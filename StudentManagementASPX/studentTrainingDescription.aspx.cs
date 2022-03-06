using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class studentTrainingDescription : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var vacancyNo = Request.QueryString["innovationNumber"];
                var today = DateTime.Today;
                var innovations = nav.Crmtraining.Where(r => r.Document_No == vacancyNo && r.End_Date >= today && r.Published == true);
                foreach (var innovation in innovations)
                {
                    noticeNo.Text = innovation.Document_No;
                    innovationDescription.Text = innovation.Description;
                    category.Text = Convert.ToDateTime(innovation.Start_Date).ToString("dd/MM/yyyyy");
                    department.Text = Convert.ToDateTime(innovation.End_Date).ToString("dd/MM/yyyyy");
                    submissionstartDate.Text = Convert.ToString(innovation.Duration);
                    submissionEndDate.Text = innovation.Duration_Units;
                    executiveSummery.Text = innovation.Provider_Name;
                    region.Text = innovation.Location;
                    attendees.Text = innovation.Attendees;
                    cost.Text = Convert.ToString(innovation.Cost_Of_Training);
                    starttime.Text = innovation.Start_Time;
                    endtime.Text = innovation.End_Time;

                }
            }
        }


        protected void confirm_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((string)Session["studentNo"]))
            {
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "register(); window.location='" + Request.ApplicationPath + "registrationInstructions.aspx';", true);
                submit.InnerHtml = "<div class='alert alert-danger'> You must be a student registered with kasneb.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else if (Session["studentNo"] != null)
            {


                try
                {
                    String DocumentId = removeFuelWorkType.Text;
                    var studentNo = Session["studentNo"].ToString();
                    String applicationNo = "";
                    Boolean newapplicationNo = false;
                    Boolean error = false;
                    String message = "";

                    try
                    {

                        applicationNo = Request.QueryString["applicationNo"];
                        if (String.IsNullOrEmpty(applicationNo))
                        {
                            applicationNo = "";
                            newapplicationNo = true;

                        }
                    }
                    catch (Exception)
                    {

                        applicationNo = "";
                        newapplicationNo = true;
                    }

                    if (string.IsNullOrEmpty(DocumentId))
                    {
                        error = true;
                        message = "An application with the given applcationNo does not exist";
                    }

                    String status = new Config().ObjNav().FnConfirmAttendance(applicationNo, studentNo,DocumentId);                    

                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newapplicationNo)
                        {
                            applicationNo = info[2];                           
                            

                        }

                        submit.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        submit.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                    submit.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }


    }
}