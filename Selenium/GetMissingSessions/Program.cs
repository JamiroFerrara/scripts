using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;

namespace GetMissingSessions
{
    public class CF
    {
        public int number { get; set; }
        public List<List<string>> sessionimancanti { get; set; } = new List<List<string>>();
    }
    class Program
    {
        #region Hide Console
        [DllImport("kernel32.dll")]
        static extern IntPtr GetConsoleWindow();

        [DllImport("user32.dll")]
        static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        private static void HideConsoleWindow()
        {
            var handle = GetConsoleWindow();
            ShowWindow(handle, SW_HIDE);
        }

        const int SW_HIDE = 0;
        const int SW_SHOW = 5;
        #endregion

        public static string dtFormat = "dd/MM/yyyy";
        public static string TransactionModel = "TRANSYYMMddhhmm00NNNN.dat";
        public static string DOWNLOADS = @"C:\Users\Jamiro Ferrara\Downloads";
        public static string CFDIR = @"C:\Recupero CF";

        static void Main(string[] args)
        {
            HideConsoleWindow();   
            var cf = GetFiles();
            GenerateTxtFromCf(cf);
            BatchElaborateCFFiles(DateTime.Now.Date, cf);
        }

        private static void BatchElaborateCFFiles(DateTime folderDate, List<CF> cfs)
        {
            string dateFormat = folderDate.ToString("ddMMyyyy");
            foreach(var dir in Directory.GetDirectories(CFDIR))
            {
                if (dir.Contains(dateFormat.Substring(2)))
                {
                    string innerDir = CFDIR + @"\" + dateFormat.Substring(2) + @"\" + dateFormat;
                    var cfFolders = Directory.GetDirectories(innerDir);
                    foreach (var cfFolder in cfFolders)
                    {
                        var transactions = Directory.GetFiles(cfFolder + @"\datitx");
                        foreach (var cf in cfs)
                        {
                            if (cfFolder.Contains(cf.number.ToString()))
                            {

                            }
                        }
                    }
                }
            }
        }

        private static void GenerateTxtFromCf(List<CF> cf)
        {
            using (StreamWriter sw = new StreamWriter(DOWNLOADS + @"\Sessioni\SessioniMancanti.txt"))
            {
                foreach(var item in cf)
                {
                    string output1 = $"Bus: {item.number}";
                    sw.WriteLine(output1);
                    sw.WriteLine();
                    foreach(var session in item.sessionimancanti)
                    {
                        string output2 = $"Sessione Numero: {session[3]} Data: {session[4].Substring(0, session[4].Length - 9)}";
                        sw.WriteLine(output2);
                    }
                    sw.WriteLine("-------------------------");
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
                        if (file.Contains(".csv"))
                        {
                            var data = FilterFileForMissingSessions(file);

                            if (data.Count() != 0)
                                cf.Add(new CF() { number = Convert.ToInt32(data[0][2]), sessionimancanti = data });
                        }
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
