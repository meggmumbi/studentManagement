using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class centerReallocation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                string applicationNo = Request.QueryString["applicationNo"];
                string courseid = Request.QueryString["courseid"];
                courseIDTEXT.Text = courseid;
                string studentNo = Convert.ToString(Session["studentNo"]);
                var centerEntries = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Booking" && r.No== applicationNo).ToList();
                foreach (var entry in centerEntries)
                {
                    oldExamCenetr.Text = entry.Examination_Center;
                    oldExamCenetrs.Text = entry.Examination_Center_Code;
                    string oldExamCent = oldExamCenetrs.Text;


                    var examcenters = nav.ExamCenters.Where(x => x.Code == oldExamCent).ToList();
                    foreach (var centers in examcenters)
                    {
                        string zone = centers.Exam_Zone;                        
                        string region = centers.Exam_Region;
                        oldExamRegions.Text = region;
                        oldExamZones.Text = zone;


                        var Examzone = nav.ExamZones.Where(m => m.Code == zone).ToList();
                        var examRegion = nav.ExamRegions.Where(n => n.Code == region).ToList();

                        foreach (var examRegions in examRegion)
                        {
                            oldExamRegion.Text = examRegions.Description;
                        }
                        foreach (var examZones in Examzone)
                        {
                            oldExamZone.Text = examZones.Zone_Name;
                        }

                        var ExaminationCenters = nav.centerCourseapacity.Where(r =>r.Course_Id == courseid && r.Blocked==false).ToList();

                        NewExamCenter.DataSource = ExaminationCenters;
                        NewExamCenter.DataTextField = "Center_Name";
                        NewExamCenter.DataValueField = "Center_Code";
                        NewExamCenter.DataBind();
                        NewExamCenter.Items.Insert(0, new ListItem("--select--", ""));

                        updPanel1.Update();

                    }

                }

                }

        }

        protected void saveDetails_Click(object sender, EventArgs e)
        {
            try
            {
                var nav1 = Config.ReturnNav();
                string tRegion = oldExamRegions.Text;
                string tzone = oldExamZones.Text;
                string texamcenter = oldExamCenetrs.Text;
                string tnewexamcenter = NewExamCenter.SelectedValue.Trim();
                string studentNo = Convert.ToString(Session["studentNo"]);
                String applicationNo = Request.QueryString["applicationNo"];
                string regNo = "";
                var details = nav1.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Booking" && r.No== applicationNo).ToList();
               
                foreach (var detail in details)
                {
                    regNo = detail.Student_Reg_No;
                }
                Boolean error = false;
                String message = "";
                if (string.IsNullOrEmpty(tnewexamcenter))
                {
                    error = true;
                    message = "Please select an examination center you wish to be reallocated to.";
                }

                if (error)
                {
                    examcenterz.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {


                    var nav = new Config().ObjNav();
                    String status = nav.FnCenterRecollocate(applicationNo, regNo, tRegion, tzone, texamcenter, tnewexamcenter);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        examcenterz.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                    }
                    else
                    {
                        examcenterz.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception t)
            {
                examcenterz.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void Previousclick_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }
}