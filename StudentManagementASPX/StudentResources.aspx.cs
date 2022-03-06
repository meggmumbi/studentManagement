using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class StudentResources : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void downloadFile_Click(object sender, EventArgs e)
        {
            try
            {
               
                //SharePoint Credentials  
                var sharepointUrl = ConfigurationManager.AppSettings["sServer_URL"];
                var fileName = fileName1.Text;               

                String leaveNo = Request.QueryString["applicationNo"];
                string password = ConfigurationManager.AppSettings["S_PWD"];
                string account = ConfigurationManager.AppSettings["S_USERNAME"];
                string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                var filePath = sharepointUrl + "Shared%20Documents/Examination/Kasneb Syllabuses 2021/" + "/" + fileName;

                var secret = new SecureString();
                foreach (char c in password)
                {
                    secret.AppendChar(c);
                }
              
                var onlineCredentials = new NetworkCredential(account, password, domainname);
                ClientContext clientContext = new ClientContext(filePath);
                var url = string.Format("{0}", filePath);
                WebRequest request = WebRequest.Create(new Uri(url, UriKind.Absolute));
                request.Credentials = onlineCredentials;
                WebResponse response = request.GetResponse();
                Stream fs = response.GetResponseStream() as Stream;
                using (FileStream localfs = System.IO.File.OpenWrite(Server.MapPath("~/Downloads/") + "/" + Path.GetFileName(filePath)))
                {
                    CopyStream(fs, localfs);

                }
                string filename = Path.GetFileName(filePath);
                Response.ContentType = "application/octet-stream";
                Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename);
                string aaa = Server.MapPath("~/Downloads/" + filename);
                Response.TransmitFile(Server.MapPath("~/Downloads/" + filename));
                Response.End();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "HidePopup", "$('#downloadFileModal').modal('hide')", true);
                
            }
            catch (Exception ex)
            {
                documents.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
       
        public static void CopyStream(Stream inputStream, Stream outputStream)
        {
            inputStream.CopyTo(outputStream, 4096);
        }
     
    }
    
}