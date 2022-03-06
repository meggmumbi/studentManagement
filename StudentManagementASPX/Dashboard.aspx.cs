using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((string)Session["idNumber"]))
            {

                Response.Redirect("Login.aspx");


            }
            else if (Session["idNumber"] != null)
            {


                if (!IsPostBack)
                {
                    var nav = Config.ReturnNav();
                    string studentNo = Convert.ToString(Session["studentNo"]);
                    var students = nav.StudentProcessing.Where(r => r.Student_No == studentNo);
                    //foreach (var student in students)
                    //{
                    //    firstName.Text = student.First_Name;
                    //    middlename.Text = student.Middle_Name;
                    //    lastName.Text = student.Surname;
                    //    idnumber.Text = student.ID_Number_Passport_No;
                    //    email.Text = student.Email;
                    //    phoneNumber.Text = student.Phone_No;
                    //    address.Text = student.Address;
                    //    countyt.Text = student.County;
                    //    postalt.Text = student.Post_Code;
                    //    city.Text = student.City;
                    //    gender.Text = student.Gender;
                    //    dob.Text = Convert.ToDateTime(student.Date_of_Birth).ToString("MM/dd/yyyy");
                    //    rkin.Text = student.Contact_Relationship;
                    //    kinName.Text = student.Contact_Full_Name;
                    //    kinPhone.Text = student.Contact_Phone_No;
                    //    educationallevel.Text = student.Highest_Academic_Qualification;
                    //    informationt.Text = student.Information_Source_Name;

                    //}
                    if (Session["studentNo"] != null)
                    {
                        
                        string studentNos = Convert.ToString(Session["studentNo"]);
                        var registrationNo = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNos && r.Status == "Active").ToList();
                        foreach (var regNumbers in registrationNo)
                        {

                            regNo.Text = regNumbers.Registration_No;
                        }
                    }


                    var today = DateTime.Today;
                    var exmcycle = nav.ExamCycle;
                    examCycle.DataSource = exmcycle;
                    examCycle.DataTextField = "examCycle";
                    examCycle.DataValueField = "examCycle";
                    examCycle.DataBind();



                    var courses = nav.ExamSittingCycle.Where(r => r.Sitting_Status == "Active");
                    int counter = 0;
                    foreach (var Coursez in courses)
                    {
                        //Cycle.Text = Coursez.Sitting_Cycle;
                        //projectCode.Text = Coursez.Examination_Project_ID;

                    }

                    var Examcourses = nav.Courses;
                    examinationIDs.DataSource = Examcourses;
                    examinationIDs.DataTextField = "Code";
                    examinationIDs.DataValueField = "No_Series";
                    examinationIDs.DataBind();
                    examinationIDs.Items.Insert(0, new ListItem("--select--", ""));



                }
            }
        

        }

        protected void studentAccounts_Click(object sender, EventArgs e)
        {
            try
            {
                string CAMS = "";
                var nav = Config.ReturnNav();
                string courseId = examinationIDs.SelectedValue.Trim();
                string NUmericRegNo = RegistrationNo.Text.Trim();
                string RegNo = courseId + "/" + NUmericRegNo;
                
                ExamRegNo.Text = NUmericRegNo;
                if (courseId == "CAM")
                {
                    courseId = "CAMS";
                }

                var examinationAccounts = nav.ExaminationAccounts.Where(r => r.Registration_No == RegNo).ToList();
                foreach(var examAccount in examinationAccounts)
                {
                    ExamId.Text = examAccount.Course_ID;
                    ExamRegNo.Text = examAccount.Registration_No;
                }

                if (examinationAccounts.Count > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ExaminationAccounts();", true);
                }
                else
                {
                    account.InnerHtml = "<div class='alert alert-danger'>Sorry, The Examination Account with the given number does not exist in the system. Kindly Contact Examination department  for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('registrationInstructions.aspx') }, 3000);", true);                   
                }
            }
            catch (Exception ex)
            {
                account.InnerHtml = "<div class='alert alert-danger'>Sorry, The Examination Account with the given number does not exist in the system. Kindly Contact Examination department  for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void confirm_Click(object sender, EventArgs e)
        {

            string temail = Convert.ToString(Session["EmailAddress"]);

            string phone = Convert.ToString(Session["PhoneNumber"]);

            string tIdNumber = Convert.ToString(Session["idNumber"]);
            string tcourseId = ExamId.Text.Trim();
            string tregNo = ExamRegNo.Text.Trim();
            // string NUmericRegNo = RegistrationNo.Text.Trim();
            string RegNo = ExamRegNo.Text.Trim();

            try
            {

                var nav = new Config().ObjNav();
                String status = nav.FnEditstudent(tIdNumber, phone, temail, RegNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Login.aspx') }, 3000);", true);
                   
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
}

        protected void reject_Click(object sender, EventArgs e)
        {
            feedback.InnerHtml = "<div class='alert alert-danger>You have confirmed that the given examination account does not belong to you. Please proceed to registration. Contact kasneb for any query.  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('registrationInstructions.aspx') }, 3000);", true);
            
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("registrationInstructions.aspx");
        }

        protected void resultsSlip_Click(object sender, EventArgs e)
        {
            // <td><a href="ResultSlip.aspx?No=<%=detail.Student_Reg_No%>&&sitting=<%=detail.Examination_Sitting_ID %>" class="btn btn-success"><i class="fa fa-eye"></i>Result Slip</a></td>
            var nav = Config.ReturnNav();
            string sitting = examCycle.SelectedValue.Trim();
            string No = regNo.Text.Trim();
            string IdNumbers = Convert.ToString(Session["idNumber"]);
            string message = "";


            var details = nav.ExaminationResults.Where(r => r.National_ID_No == IdNumbers && r.Examination_Sitting_ID==sitting).ToList();

            if (details.Count > 0)
            {
                Response.Redirect("ResultSlip.aspx?No=" + No + "&&sitting=" + sitting);
            }
            else
            {
                message = "You did not sit for the " + sitting + " Examination.";
                examResults.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }

        protected void examCycle_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            string sitting = examCycle.SelectedValue.Trim();
            string No = regNo.Text.Trim();
            examSitting.Text = sitting;
            string IdNumbers = Convert.ToString(Session["idNumber"]);
            string message = "";


            var details = nav.ExaminationResults.Where(r => r.National_ID_No == IdNumbers && r.Examination_Sitting_ID == sitting).ToList();

            if (details.Count > 0)
            {
                studentAcc.Visible = false;
                SpecificSitting.Visible = true;
            }
            else
            {
                message = "You did not sit for the " + sitting + " Examination.";
                examResults.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                studentAcc.Visible = true;
                SpecificSitting.Visible = false;
            }

        }
    }
}