using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace GetMissingSessions
{
    public class CF
    {
        public int number { get; set; }
        public List<List<string>> sessionimancanti { get; set; } = new List<List<string>>();
    }
    class Program
    {
        public static string DOWNLOADS = @"C:\Users\Jamiro Ferrara\Downloads";
        static void Main(string[] args)
        {
            var cf = GetFiles();
            GenerateTxtFromCf(cf);
        }

        private static void GenerateTxtFromCf(List<CF> cf)
        {
            using (StreamWriter sw = new StreamWriter(DOWNLOADS + "SessioniMancanti.txt"))
            {
                foreach(var item in cf)
                {
                    string output1 = $"Bus: {item.number}";
                    sw.WriteLine(output1);
                    sw.WriteLine();
                    foreach(var session in item.sessionimancanti)
                    {
                        string output2 = $"Sessione Numero: {session[3]} Data: {session[4]}";
                        sw.WriteLine();
                    }
                }
            }
        }

        private static List<CF> GetFiles()
        {
            var dirs = Directory.GetDirectories(DOWNLOADS);
            List<CF> cf = new List<CF>();
            foreach(var dir in dirs)
            {
                if (dir.Contains("Sessioni") || dir.Contains("cf"))
                {
                    var files = Directory.GetFiles(dir);
                    foreach(var file in files)
                    {
                        var data = FilterFileForMissingSessions(file);
                        cf.Add(new CF() { number = Convert.ToInt32(data[0][2]), sessionimancanti = data });
                    }
                }
            }

            return cf;
        }

        private static List<List<string>> FilterFileForMissingSessions(string file)
        {
            string line = "";
            bool first = true;

            var fileStream = File.OpenText(file);
            List<List<string>> lines = new List<List<string>>();
            List<int> sessions = new List<int>();
            
            while ((line = fileStream.ReadLine()) != null)
            {
                if (first)
                {
                    first = false;
                }
                else
                {
                    var split = new List<string>(line.Split(';'));
                    if (split[3] != " ")
                    {
                        lines.Add(split);
                        sessions.Add(Convert.ToInt32(split[3]));
                    }
                }
            }

            sessions.Sort();
            var filter1 = new List<int>(sessions);
            var filteredItems = new List<int>(filter1.Where(x =>
            {
                try
                {
                    return Convert.ToInt32(x) != Convert.ToInt32(filter1[filter1.IndexOf(x) + 1]) - 1;
                }
                catch
                {
                    return false;
                }
            }));

            var filteredNoDuplicates = filteredItems.Where(x =>
            {
                try
                {
                    return x != filteredItems[filteredItems.IndexOf(x) + 1];
                }
                catch
                {
                    return true;
                }
            });

            List<List<string>> missingSessionLines = new List<List<string>>();
            foreach(var item in filteredNoDuplicates)
            {
                missingSessionLines.Add(lines.First(x => Convert.ToInt32(x[3]) == item));
            }

            fileStream.Close();

            return missingSessionLines;
        }
    }
}
