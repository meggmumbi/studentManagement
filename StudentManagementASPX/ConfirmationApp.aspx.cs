using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class ConfirmationApp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void apply_Click(object sender, EventArgs e)
        {
   
            try
            {
               
                Boolean hasError = false;
                string regNo = lineNo.Text.Trim();
                if (string.IsNullOrEmpty(regNo))
                {
                    hasError = true;

                }


                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>Student Examination Registration Number is Missing <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String applicationNo = "";
                    String StudentNo = Convert.ToString(Session["studentNo"]);                    
                    String status = new Config().ObjNav().FnConfirmation(StudentNo, regNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        
    }
    }
}