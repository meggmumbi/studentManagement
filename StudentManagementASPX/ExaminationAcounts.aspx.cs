using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class ExaminationAcounts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var today = DateTime.Today;
                var examSittings = nav.ExamSittingCycle.Where(r => r.Sitting_Status == "Active" && r.Exam_End_Date >= today).ToList();
                var NextexamSittings = nav.ExamSittingCycle.Where(r => r.Exam_End_Date >= today && r.Sitting_Status == "Upcoming").ToList();

                string IdNumberS = Convert.ToString(Session["idNumber"]);
                var path1 = "~/images/" + IdNumberS + ".jpg";
                string servpath1 = Server.MapPath(path1);
                System.IO.FileInfo file1 = new System.IO.FileInfo(servpath1);

                if (file1.Exists.Equals(false))
                {
                    string response = ("Please Update Your Profile Photo");
                    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('profile.aspx') }, 1000);", true);

                }

                if (NextexamSittings.Count > 0 && examSittings.Count==0)
                {
                    string response = ("The current Examination Sitting is closed. Proceed to Book for the next sitting");
                    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }


                }

        }
    }
}