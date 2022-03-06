using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class ExemptionInstructionTest : System.Web.UI.Page
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
                    var registrationNo = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Status== "Active").ToList();
                    foreach(var regNumbers in registrationNo)
                    {
                        regNos.Text = regNumbers.Registration_No;
                        courseId.Text = regNumbers.Course_ID;
                    }
                   
                    
                 


                }
            }
        }
        protected void Next_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((string)Session["studentNo"]))
            {
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "register(); window.location='" + Request.ApplicationPath + "registrationInstructions.aspx';", true);
                linesFeedback.InnerHtml = "<div class='alert alert-danger'> Please Register for a kasneb Course.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {
                try
                {

                    string regNUmber = regNos.Text.Trim();
                    string studentNo = Convert.ToString(Session["studentNo"]);

                    //DateTime myOrderDate = new DateTime();
                    Boolean error = false;
                    String message = "";

                    String applicationNo = "";
                    Boolean newApplicationNo = false;
                    try
                    {

                        applicationNo = Request.QueryString["applicationNo"];
                        if (String.IsNullOrEmpty(applicationNo))
                        {
                            applicationNo = "";
                            newApplicationNo = true;
                        }
                    }
                    catch (Exception)
                    {

                        applicationNo = "";
                        newApplicationNo = true;
                    }
                    String status = new Config().ObjNav().CreateExemption(applicationNo, studentNo, regNUmber);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newApplicationNo)
                        {
                            applicationNo = info[2];

                        }

                        string exam = courseId.Text;

                        Response.Redirect("StudentExemptions.aspx?step=1&&applicationNo=" + applicationNo + "&&courseid=" + exam);


                    }
                    else
                    {
                        exemptionFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }

                catch (Exception m)
                {
                    exemptionFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
        }
        protected void regNo_SelectedIndexChanged(object sender, EventArgs e)
        {

            var nav = Config.ReturnNav();
            string studentNo = Convert.ToString(Session["studentNo"]);
            var registrationNo = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Status == "Active");
            foreach (var regNumbers in registrationNo)
            {
                courseId.Text = regNumbers.Course_ID;
            }
            
        }

        protected void nextAppliation_Click(object sender, EventArgs e)
        {

        }
    }


 }