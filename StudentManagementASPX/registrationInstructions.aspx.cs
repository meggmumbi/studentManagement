using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class registrationInstructions : System.Web.UI.Page
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
                    var courses = nav.ExamSittingCycle.Where(r => r.Sitting_Status == "Active" && r.Closed==false);
                    int counter = 0;
                    foreach (var Coursez in courses)
                    {
                        Cycle.Text = Coursez.Sitting_Cycle;
                        projectCodes.Text = Coursez.Examination_Project_ID;
                        projectCode2.Text = Coursez.Examination_Project_ID;

                    }
                    ClientScript.RegisterStartupScript(GetType(), "ModalScript", "$(function(){ $('#removeLineModal').modal('show'); });", true);
                    string parameter = Request["__EVENTARGUMENT"];

                    string type ="";
                    //type = DIPt.Value;
                    //if (type == "")
                    //{
                    //     type = "Post-Graduate";
                    //}



                    //var examCourse = nav.ExamCourses.Where(r => r.Job_No == projectCodes.Text);
                    //ApplicationNo.DataSource = examCourse;
                    //ApplicationNo.DataTextField = "Description";
                    //ApplicationNo.DataValueField = "Job_Task_No";
                    //ApplicationNo.DataBind();
                    //ApplicationNo.Items.Insert(0, new ListItem("--select--", ""));

                    //updPanel1.Update();


                }
               

            }
                    





        }

        protected void Next_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((string)Session["studentNo"]))
            {
                Boolean error = false;
                String message = "";
                string courseId = fileName1.Text.Trim();
                string studentNo = Convert.ToString(Session["studentNo"]);
                string IdNumber = Convert.ToString(Session["idNumber"]);



                if (string.IsNullOrEmpty(courseId))
                {
                    error = true;
                    message = "Please Select Kasneb Examination you are registering for";
                }

                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

                else
                {
                    var nav = Config.ReturnNav();
                    var examAccounts = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber && r.Approval_Status == "Open").ToList();
                    if (examAccounts.Count > 0)
                    {
                        message = "You have an existing active account";
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else if (examAccounts.Count == 0)
                    {
                        string cycle = Cycle.Text;
                        string projectCode = projectCodes.Text;
                        Response.Redirect("StudentRegistration.aspx?courseId=" + courseId + "&&cycle=" + cycle + "&&projectcode=" + projectCode);
                    }
                }

    }

            else if (Session["studentNo"] != null)
            {
                 Boolean error = false;
                    String message = "";
                    string courseId = fileName1.Text.Trim();
                    var nav = Config.ReturnNav();
                   string studentNo = Convert.ToString(Session["studentNo"]);
                var examinationAccounts = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Course_ID == courseId).ToList();
                if (examinationAccounts.Count > 0)
                {
                    error = true;
                    message = "You have an existing examination account for the selecetd examination. "+courseId;
                }
                if (examinationAccounts.Count > 0)
                {

                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else if (examinationAccounts.Count == 0)
                {

                    if (string.IsNullOrEmpty(courseId))
                    {
                        error = true;
                        message = "Please Select Kasneb Examination you are registering for";
                    }

                    if (error)
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    { 
                        var examAccounts = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Status == "Active").ToList();
                        if (examAccounts.Count > 0)
                        {
                            message = "You have an existing active account";
                            generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else if (examAccounts.Count == 0)
                        {

                            string cycle = Cycle.Text;
                            string projectCode = projectCodes.Text;
                            Response.Redirect("ExistingStudents.aspx?courseId=" + courseId + "&&cycle=" + cycle + "&&projectcode=" + projectCode);
                        }
                    }
                }
                
           
            }
            

        }

        protected void ApplicationNo_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void examinationType_SelectedIndexChanged(object sender, EventArgs e)
        {
            

            //string type =examinationType.SelectedValue;


            //var nav = Config.ReturnNav();
            //var examCourse = nav.ExamCourses.Where(r => r.Job_No == projectCodes.Text && r.Examination_Type == type);
            //ApplicationNo.DataSource = examCourse;
            //ApplicationNo.DataTextField = "Description";
            //ApplicationNo.DataValueField = "Job_Task_No";
            //ApplicationNo.DataBind();
            //ApplicationNo.Items.Insert(0, new ListItem("--select--", ""));

            //updPanel1.Update();

        }

        protected void DIPt_TextChanged(object sender, EventArgs e)
        {

        }

        protected void nextButton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((string)Session["studentNo"]))
            {
                Boolean error = false;
                String message = "";
                string courseId = fileName1.Text.Trim();
                string studentNo = Convert.ToString(Session["studentNo"]);
                string IdNumber = Convert.ToString(Session["idNumber"]);




                if (string.IsNullOrEmpty(courseId))
                {
                    error = true;
                    message = "Please Select Kasneb Examination you are registering for";
                }

                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

                else
                {
                    var nav = Config.ReturnNav();
                    var studentProcessing = nav.StudentProcessing.Where(X => X.ID_Number_Passport_No == IdNumber && X.Examination_ID != "" && X.Approval_Status=="Open").ToList();
                    var examAccounts = nav.ExaminationAccounts.Where(r => r.ID_No == IdNumber && r.Status == "Active").ToList();
                    if (studentProcessing.Count > 0)
                    {
                        message = "You have an existing active account";
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else if (studentProcessing.Count == 0)
                    {
                        string cycle = Cycle.Text;
                        string projectCode = projectCodes.Text;
                        Response.Redirect("StudentRegistration.aspx?courseId=" + courseId + "&&cycle=" + cycle + "&&projectcode=" + projectCode);
                    }
                }

            }

            else if (Session["studentNo"] != null)
            {
                Boolean error = false;
                String message = "";
                string courseId = fileName1.Text.Trim();
                var nav = Config.ReturnNav();
                string studentNo = Convert.ToString(Session["studentNo"]);
                var examinationAccounts = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Course_ID == courseId).ToList();
                if (examinationAccounts.Count > 0)
                {
                    error = true;
                    message = "You have an existing examination account for the selecetd examination. " + courseId;
                }
                if (examinationAccounts.Count > 0)
                {

                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else if (examinationAccounts.Count == 0)
                {

                    if (string.IsNullOrEmpty(courseId))
                    {
                        error = true;
                        message = "Please Select Kasneb Examination you are registering for";
                    }

                    if (error)
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        var examAccounts = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Status == "Active").ToList();
                        if (examAccounts.Count > 0)
                        {
                            message = "You have an existing active account";
                            generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else if (examAccounts.Count == 0)
                        {

                            string cycle = Cycle.Text;
                            string projectCode = projectCodes.Text;
                            Response.Redirect("ExistingStudents.aspx?courseId=" + courseId + "&&cycle=" + cycle + "&&projectcode=" + projectCode);
                        }
                    }
                }


            }


        }
    }
}