using System;
using System.Collections.Generic;
using System.EnterpriseServices.CompensatingResourceManager;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register_Click(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string register(string ttype, string tfirstname, string tmiddlname, string tlastname, string tphonenumber, string temailaddress, string taddress, string tpostcode, string tcity, string tcountry, string tIdNumber)
        {
            var results = (dynamic)null;
            try
            {
                string sIdNumber = "";
                string FullNames = tfirstname;

                string fullName = FullNames.ToUpper();
                var names= fullName.Split(new string[] { " " }, StringSplitOptions.RemoveEmptyEntries);
                // var names = fullName.Split(' ');
                Boolean error = false;
                String message = "";
                string firstName = "";
                string middliN = "";
                string lastName = "";

                if (names.Length == 4)
                {
                    firstName = names[0];
                   middliN = names[1];
                     lastName = names[2] + names[3];

                }

                if (names.Length == 3)
                {
                    firstName = names[0];
                     middliN = names[1];
                     lastName = names[2];

                }
                if (names.Length == 2)
                {
                    firstName = names[0];
                    //string middliN = names[1];
                    lastName = names[1];

                }
                if (names.Length == 1)
                {
                    firstName = names[0];
                   // string middliN = names[1];
                    //string lastName = names[2];

                }

                
                
                var nav = Config.ReturnNav();
                tphonenumber = Regex.Replace(tphonenumber, @"/^[^ 1 - 9A - Z] +|\s / gm", "");

                if (string.IsNullOrWhiteSpace(temailaddress))
                {
                    results = "Please Fill in Your Email Address";
                    return results;
                }

                string AuthenticationEmail = temailaddress.Trim().ToLower();

                if (string.IsNullOrWhiteSpace(tIdNumber))
                {
                    results = "Please Fill in Your Id Number / Passport Number / Birth certificate Number";
                    return results;
                }

                var regexItem = new Regex("^[a-zA-Z0-9 ]*$");

                if (regexItem.IsMatch(tIdNumber)) {

                    sIdNumber = tIdNumber;

                }
                else
                {
                    results = "Please Fill in correct Id Number / Passport Number / Birth certificate Number. " + tIdNumber+" is not a valid Identity Number.";
                    return results;
                }
                Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
                Match match = regex.Match(AuthenticationEmail);

                if (match.Success)
                {


                    string status = new Config().ObjNav().FnRegistrationStudent(firstName, middliN, lastName, tphonenumber, AuthenticationEmail, sIdNumber);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        results = info[0];
                    }
                    else
                    {
                        results = info[1];
                    }
                }
                else
                {
                    results = "Invalid Email Address" + AuthenticationEmail;
                }
            


            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

    }
}
