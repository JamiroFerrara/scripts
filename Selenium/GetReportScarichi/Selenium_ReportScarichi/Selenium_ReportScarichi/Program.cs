using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Runtime.InteropServices;
using System.Threading;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace SeleniumTest
{
    public class Program
    {
        [DllImport("kernel32.dll")]
        static extern IntPtr GetConsoleWindow();

        [DllImport("user32.dll")]
        static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

        const int SW_HIDE = 0;
        const int SW_SHOW = 5;

        public static string DOWNLOADS = @"C:\Users\Jamiro Ferrara\Downloads";

        static void Main(string[] args)
        {
            HideConsoleWindow();
            var chromeOptions = new ChromeOptions();
            OpenQA.Selenium.Chrome.ChromeDriver cDriver = new OpenQA.Selenium.Chrome.ChromeDriver(@"C:\Scripts\Selenium", chromeOptions);
            cDriver.Navigate().GoToUrl("http://report.mitt.it/MITTDotNetReport/Report_Scarichi.aspx");
            GetAnnullati(cDriver);
            FormatReportScarichi();
            return;
        }

        private static void HideConsoleWindow()
        {
            var handle = GetConsoleWindow();
            ShowWindow(handle, SW_HIDE);
        }
        private static void GetAnnullati(ChromeDriver cDriver)
        {
            cDriver.FindElement(By.Id("Dropdownlist2")).SendKeys("a");

            var nowDate = DateTime.Now;
            var dateBox = cDriver.FindElement(By.Id("da"));
            dateBox.SendKeys(Keys.Backspace);
            dateBox.SendKeys(Keys.Backspace);
            dateBox.SendKeys(Keys.Backspace);
            dateBox.SendKeys(Keys.Backspace);
            dateBox.SendKeys(Keys.Backspace);
            dateBox.SendKeys(Keys.Backspace);
            dateBox.SendKeys(Keys.Backspace);
            dateBox.SendKeys(Keys.Backspace);
            dateBox.SendKeys(Keys.Backspace);
            dateBox.SendKeys(Keys.Backspace);
            var startYear = nowDate.AddDays(-nowDate.Day).AddMonths(-nowDate.Month);
            dateBox.SendKeys("01/11/");
            dateBox.SendKeys("2022");
            cDriver.FindElement(By.Id("Button2")).Click();
            Thread.Sleep(1000);

            DeleteExistingReportScarichi();

            cDriver.FindElement(By.Id("Button1")).Click();
            Thread.Sleep(1000);
            cDriver.Quit();
        }
        private static void DeleteExistingReportScarichi()
        {
            var files = Directory.GetFiles(DOWNLOADS);
            foreach (var file in files)
            {
                if (file.Contains("Scarichi"))
                {
                    File.Delete(file);
                }
            }
        }
        private static void FormatReportScarichi()
        {
            var files = Directory.GetFiles(DOWNLOADS);
            foreach (var file in files)
            {
                if (file.Contains("Scarichi"))
                {
                    string line = "";
                    var fileStream = File.OpenText(file);
                    List<string> directories = new List<string>();
                    while ((line = fileStream.ReadLine()) != null)
                    {
                        if (line.Contains("td"))
                        {
                            var larr = line.Split('\\');
                            if (larr.Length == 9)
                            {
                                string dir = @"\" + larr[2] + @"\" + larr[3] + @"\" + larr[4] + @"\" + larr[5] + @"\" + larr[6] + @"\" + larr[7] + @"\" + larr[8].Substring(0, larr[8].Length - 5) + @"\TRANSACTIONS.xml";
                                directories.Add(dir);
                            }
                        }
                    }

                    using (StreamWriter sw = new StreamWriter(DOWNLOADS + @"\DirAnnullati.txt"))
                    {
                        foreach (var d in directories)
                        {
                            sw.WriteLine(@"\" + d);
                        }
                        sw.Close();
                    }
                }
            }
        }
    }
}
