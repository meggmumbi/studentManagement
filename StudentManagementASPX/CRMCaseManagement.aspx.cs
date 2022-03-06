using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class CRMCaseManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                

            }
        }

        protected void saveDetails_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                string message = "";

                int caseType = Convert.ToInt32(txtgender.SelectedValue.Trim());
                string tsubject = subject.SelectedValue.Trim();
                string tdescription = description.Text.Trim();
                string studentNo = Convert.ToString(Session["studentNo"]);
               

            

                if (string.IsNullOrEmpty(Convert.ToString(caseType)))
                {
                    error = true;
                    message = "Select a case Type";

                }

                if (string.IsNullOrEmpty(tdescription))
                {
                    error = true;
                    message = "Please enter the description of your case";
                }

                if (string.IsNullOrEmpty(tsubject))
                {
                    error = true;
                    message = "Select a case subject";
                }
                

                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    /*
                    Session["UniversityCode"]);
                    Session["employeeNo"] = user.employeeNo;
                    */
                    String applicationNo = "";
                    Boolean newapplicationNo = false;
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


                    string response = new Config().ObjNav().FnCaseManagement(applicationNo, caseType, tsubject, tdescription, studentNo);

                    String[] info = response.Split('*');
                    if (info[0] == "success")
                    {
                        if (newapplicationNo)
                        {
                            applicationNo = info[2];

                        }
                        generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + info[2] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                       
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void txtgender_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            string caseType = txtgender.SelectedValue.Trim();
            var crmcases = nav.CRMcases.Where(r => r.Case_Type == caseType);
            subject.DataSource = crmcases;
            subject.DataTextField = "Description";
            subject.DataValueField = "Code";
            subject.DataBind();
            subject.Items.Insert(0, new ListItem("--select--", ""));
        }

        protected void Previousclick_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");

        }
    }
}