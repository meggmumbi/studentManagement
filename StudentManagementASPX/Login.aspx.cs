using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_Click(object sender, EventArgs e)
        {
            try
            {
                string tUsername = email.Text.Trim();
                string mUsername = tUsername.ToLower();
                string mPassword = password.Text.Trim();
                string tpassword = "";
                string temail = "";
                var changePass = "";

                bool error = false;
                if (mUsername.Length < 1)
                {
                    error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'>Please Email address cannot be Empty</div>";
                }
                if (mPassword.Length < 4)
                {
                    error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'>Please input a Correct Password to Access the System</div>";
                }
                if (!error)
                {
                    bool exists = false;
                    bool accountactivated = false;
                    var nav = Config.ReturnNav();

                    string allData = new Config().ObjNav().FnGetStudentUser(mUsername, mPassword);
                    String[] allInfo = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (allInfo != null)
                    {
                        foreach (var item in allInfo)
                        {
                            String[] oneItem = item.Split('*');

                            if (oneItem[0] == "danger")
                            {
                                error = true;
                                feedback.InnerHtml = "<div class='alert alert-" + oneItem[0] + "'>" + oneItem[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                            else
                            {


                                Session["Name"] = oneItem[0];
                                Session["EmailAddress"] = oneItem[1];
                                Session["Code"] = oneItem[2];
                                Session["Password"] = oneItem[3];
                                Session["PhoneNumber"] = oneItem[4];
                                Session["type"] = "old";
                                Session["studentNo"] = oneItem[5];
                                Session["StudentName"] = oneItem[6];
                                Session["idNumber"] = oneItem[7];
                                Session["firstName"] = oneItem[8];
                                Session["MiddleName"] = oneItem[9];
                                Session["LastName"] = oneItem[10];
                                changePass = oneItem[12];

                                if (changePass == "Yes")
                                {
                                    if (Session["studentNo"] != null)
                                    {
                                        string response = new Config().ObjNav().GetStudentsImages(Convert.ToString(Session["idNumber"]));
                                    }
                                    Response.Redirect("Dashboard.aspx");
                                }
                                else if (changePass == "No")
                                {
                                    Response.Redirect("ChangePassword.aspx");
                                }
                            }
                     
                        }
                    }



                    //var users = nav.studentsPortalUsers.Where(r => r.Authentication_Email == mUsername && r.Password_Value == mPassword && r.State == "Enabled").ToList();
                    //if (users.Count == 0)
                    //{
                    //    var usersEmail = nav.studentsPortalUsers.Where(r => r.Authentication_Email == mUsername).ToList();
                    //    if (usersEmail.Count == 0)
                    //    {
                    //        error = true;
                    //        feedback.InnerHtml = "<div class='alert alert-danger'>Please input correct Email address </div>";
                    //    }
                    //    var usersPassword = nav.studentsPortalUsers.Where(r => r.Password_Value == mPassword).ToList();
                    //    if (usersPassword.Count == 0)
                    //    {

                    //        error = true;
                    //        feedback.InnerHtml = "<div class='alert alert-danger'>Wrong Password </div>";

                    //    }
                    //    if (usersPassword.Count == 0 && usersEmail.Count == 0)
                    //    {

                    //        error = true;
                    //        feedback.InnerHtml = "<div class='alert alert-danger'>The student Account with the given Credentials does not exist.Kindly Signup to create your account</div>";

                    //    }
                    //}
                    //var users = nav.portalusers.Where(r => r.Email == mUsername && r.Password == mPassword);
                    //else
                    //{
                    //    foreach (var user in users)
                    //    {
                    //        if (user.Change_Password == true)
                    //        {
                    //            exists = true;
                    //            accountactivated = true;
                    //            Session["Name"] = user.User_Name;
                    //            Session["EmailAddress"] = user.Authentication_Email;
                    //            Session["Code"] = user.Entry_No;
                    //            Session["Password"] = user.Password_Value;
                    //            Session["PhoneNumber"] = user.Mobile_Phone_No;
                    //            Session["type"] = "old";
                    //            Session["studentNo"] = user.No;
                    //            Session["StudentName"] = user.Full_Name;
                    //            Session["idNumber"] = user.Id_Number;
                    //            Session["firstName"] = user.FirstName;
                    //            Session["MiddleName"] = user.MiddleName;
                    //            Session["LastName"] = user.LastName;

                    //            if (Session["studentNo"] != null)
                    //            {
                    //                string response = new Config().ObjNav().GetStudentsImages(Convert.ToString(Session["idNumber"]));
                    //            }
                    //            Response.Redirect("Dashboard.aspx");

                    //        }
                    //        else
                    //        {

                    //            exists = true;
                    //            accountactivated = true;
                    //            Session["Name"] = user.User_Name;
                    //            Session["EmailAddress"] = user.Authentication_Email;
                    //            Session["Code"] = user.Entry_No;
                    //            Session["Password"] = user.Password_Value;
                    //            Session["type"] = "old";
                    //            Session["studentNo"] = user.Record_ID;
                    //            Session["StudentName"] = user.Full_Name;


                    //            Response.Redirect("ChangePassword.aspx");
                    //        }
                    //    }


                    //    if (!exists)
                    //    {
                    //        // var users3 = nav.portalusers.Where(r => r.Email == mUsername && r.Password == mPassword);
                    //        var users3 = nav.studentsPortalUsers.Where(r => r.Authentication_Email == mUsername && r.Password_Value == mPassword && r.State == "Disabled");
                    //        foreach (var user in users3)
                    //        {
                    //            feedback.InnerHtml = "<div class='alert alert-danger'>The student User Account with the given Credentials was Deactivated.</div>";

                    //        }
                    //    }
                    //    if (!exists && !accountactivated)
                    //    {
                    //        feedback.InnerHtml = "<div class='alert alert-danger'>The student Account with the given Credentials does not exist.Kindly Signup to create your account</div>";
                    //    }
                    //}

                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>We experienced an error while Login you in. Kindly try again Later.</div>";

            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string login(string temail)
        {
            var results = (dynamic)null;

            try
            {
                var nav = new Config().ObjNav();
                var status = nav.FnResetPassword(temail.ToLower());
                var info = status.Split('*');
                if (info[0] == "success")
                {
                    results = info[0];
                }
                else
                {
                    results = info[1];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string ChangePassword(string temailAddres, string tOldPassword, string tNewPassword, string tconfirmNewPassword)
        {
            var results = (dynamic)null;
            try
            {
                var nav = new Config().ObjNav();
                var status = nav.FnChangeStudentPassword(temailAddres, tOldPassword, tNewPassword, tconfirmNewPassword);
                var info = status.Split('*');
                if (info[0] == "success")
                {
                    results = info[0];
                }
                else
                {
                    results = info[1];
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