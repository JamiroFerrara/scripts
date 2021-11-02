using System;
using System.Threading;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace SeleniumTest
{
    public class Program
    {
        static void Main(string[] args)
        {
            OpenQA.Selenium.Chrome.ChromeDriver cDriver = new OpenQA.Selenium.Chrome.ChromeDriver(@"C:\Scripts\Selenium");
            cDriver.Navigate().GoToUrl("http://report.mitt.it/MITTDotNetReport/Report_Scarichi.aspx");
            GetAnnullati(cDriver);
            return;
        }

        private static void GetAnnullati(ChromeDriver cDriver)
        {
            cDriver.FindElement(By.Id("Dropdownlist2")).SendKeys("a");
            cDriver.FindElement(By.Id("Button2")).Click();
            cDriver.FindElement(By.Id("Button1")).Click();
            Thread.Sleep(1000);
            cDriver.Quit();
        }
    }
}
