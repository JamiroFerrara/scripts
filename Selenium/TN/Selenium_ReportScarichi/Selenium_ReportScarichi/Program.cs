using System;
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
            OpenQA.Selenium.Chrome.ChromeDriver cDriver = new OpenQA.Selenium.Chrome.ChromeDriver(@"C:\Scripts\Selenium");
            cDriver.Navigate().GoToUrl("http://report.mitt.it/MITTDotNetReport/Report_Scarichi.aspx");
            GetAnnullati(cDriver);
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
            cDriver.FindElement(By.Id("Button2")).Click();

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
            var startYear= nowDate.AddDays(-nowDate.Day).AddMonths(-nowDate.Month);
            dateBox.SendKeys("01/01/");
            dateBox.SendKeys(startYear.Year.ToString());

            DeleteExistingReportScarichi();

            cDriver.FindElement(By.Id("Button1")).Click();
            Thread.Sleep(1000);
            cDriver.Quit();
        }

        private static void DeleteExistingReportScarichi()
        {
            var files = Directory.GetFiles(DOWNLOADS);
            foreach(var file in files)
            {
                if (file.Contains("Scarichi"))
                {
                    File.Delete(file);
                }
            }
        }
    }
}
