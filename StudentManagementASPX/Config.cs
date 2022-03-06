using System;
using StudentManagementASPX.Nav;
using System.Configuration;
using System.Net;
using Microsoft.SharePoint.Client;


namespace StudentManagementASPX
{
    public class Config
    {
        public static ClientContext SPClientContext { get; set; }
        public static Web SPWeb { get; set; }
        public static string SPErrorMsg { get; set; }


        public static NAV ReturnNav()
        {
            NAV nav = new NAV(new Uri(ConfigurationManager.AppSettings["ODATA_URI"]))
            {
                Credentials = new NetworkCredential(ConfigurationManager.AppSettings["W_USER"],
                         ConfigurationManager.AppSettings["W_PWD"], ConfigurationManager.AppSettings["DOMAIN"])
            };
            return nav;
        }
        public StudentManagement.StudentManagement ObjNav()
        {
            var ws = new StudentManagement.StudentManagement();
            try
            {
                var credentials = new NetworkCredential(ConfigurationManager.AppSettings["W_USER"],
                    ConfigurationManager.AppSettings["W_PWD"], ConfigurationManager.AppSettings["DOMAIN"]);
                ws.Credentials = credentials;
                ws.PreAuthenticate = true;


            }
            catch (Exception ex)
            {
                ex.Data.Clear();
            }
            return ws;
        }
        public static string FilesLocation()
        {
            return ConfigurationManager.AppSettings["FilesLocation"];
        }
        public bool IsAllowedExtension(string extension)
        {
            bool check = Convert.ToBoolean(ConfigurationManager.AppSettings["CheckFileExtensions"]);
            if (check)
            {
                string allowedFileTypes = ConfigurationManager.AppSettings["AllowedFileExtensions"];
                string[] info = allowedFileTypes.Split(',');
                extension = extension.Replace('.', ' ');
                extension = extension.Trim();
                extension = extension.ToLower();
                foreach (string fileExtension in info)
                {
                    string myExtension = fileExtension;
                    myExtension = myExtension.Replace('.', ' ');
                    myExtension = myExtension.Trim();
                    myExtension = myExtension.ToLower();
                    if (myExtension == extension)
                    {
                        return true;
                    }
                }

            }
            else
            {
                return true;
            }
            return false;
        }

        public static bool Connect(string SPURL, string SPUserName, string SPPassWord, string SPDomainName)
        {

            bool bConnected = false;

            try
            {
                ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;



                SPClientContext = new ClientContext(SPURL);

                SPClientContext.Credentials = new NetworkCredential(SPUserName, SPPassWord, SPDomainName);

                SPClientContext.RequestTimeout = 1800000;

                SPWeb = SPClientContext.Web;

                SPClientContext.Load(SPWeb);

                SPClientContext.ExecuteQuery();

                bConnected = true;




                bConnected = true;

            }

            catch (Exception ex)
            {

                bConnected = false;

                SPErrorMsg = ex.Message;

            }

            return bConnected;

        }
    }
}