using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class Intitutional : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsPostBack)
            {
                var nav = Config.ReturnNav();

                var customers = nav.Instcustomers;
                institution.DataSource = customers;
                institution.DataTextField = "Name";
                institution.DataValueField = "No";
                institution.DataBind();

                //var worrktypes = nav.worktype;
                //worktype.DataSource = worrktypes;
                //worktype.DataTextField = "Work_Type_Code";
                //worktype.DataValueField = "Code";
                //worktype.DataBind();

                var examAccounts = nav.ExaminationAccounts;
                regNo.DataSource = examAccounts;
                regNo.DataTextField = "Student_Name";
                regNo.DataValueField = "Registration_No";
                regNo.DataBind();

                var examJobs = nav.examJob;
                examProject.DataSource = examJobs;
                examProject.DataTextField = "Description";
                examProject.DataValueField = "Code";
                examProject.DataBind();
            }

        }

        protected void regNo_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            var registrationNo = regNo.SelectedValue.Trim();
            var bulkprocessing = nav.BulkProcessLines.Where(r => r.Registration_No == registrationNo);
            foreach (var exams in bulkprocessing)
            {
                examId.Text = exams.Course_ID;
                examination.Text = exams.Course_Description;
            }

        }

        protected void bulkBooking_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadType();
        }

        public void loadType()
        {
            try
            {
                var nav = Config.ReturnNav();
                string courseId = examId.Text.Trim();
                var itemtype = "";
                var typ = Convert.ToInt32(bulkBooking.SelectedValue);

                switch (typ)
                {

                    case 1:
                        itemtype = "Section";
                        var GL = nav.parts.Where(r => r.Course == courseId).ToList();
                        part.DataSource = GL;
                        part.DataTextField = "Code";
                        part.DataValueField = "Code";
                        part.DataBind();
                        return;

                    case 2:
                        itemtype = "Paper";

                        var paper = nav.parts.Where(r => r.Course == courseId).ToList();
                        part.DataSource = paper;
                        part.DataTextField = "Code";
                        part.DataValueField = "Code";
                        part.DataBind();
                        return;

                    case 3:
                        itemtype = "Part";
                        var parts = nav.parts.Where(r => r.Course == courseId).ToList();
                        part.DataSource = parts;
                        part.DataTextField = "Code";
                        part.DataValueField = "Code";
                        part.DataBind();
                        return;

                    default:
                        break;
                }


            }
            catch (Exception)
            {

            }
        }

        protected void section_SelectedIndexChanged(object sender, EventArgs e)
        {
            //string parts = part.SelectedValue.Trim();
            //string examIds = examId.Text.Trim();
            //var nav = Config.ReturnNav();

            //var sections = nav.sections.Where(r => r.Course == examIds && r.Part == parts);
            //foreach (var sectionz in sections)
            //{
            //    section.Text = sectionz.Code;
            //}
        }

        protected void paper_SelectedIndexChanged(object sender, EventArgs e)
        {
            string parts = part.SelectedValue.Trim();
            string examIds = examId.Text.Trim();
            string sectionId = section.SelectedValue.Trim();
            var nav = Config.ReturnNav();

            var papers = nav.Papers.Where(r => r.Course == examIds && r.Level == parts && r.Section == sectionId);
            foreach (var paperz in papers)
            {
                paper.Text = paperz.Code;
            }
        }

        protected void addItem_Click(object sender, EventArgs e)
        {

            try
            {
                // int tItemType = Convert.ToInt32(itemType.SelectedValue.Trim());
                int tbookingType = Convert.ToInt32(bulkBooking.SelectedValue.Trim());
                String tpart = String.IsNullOrEmpty(part.SelectedValue.Trim()) ? "" : part.SelectedValue.Trim();
                String tsection = String.IsNullOrEmpty(section.SelectedValue.Trim()) ? "" : section.SelectedValue.Trim();
                String tpaper = String.IsNullOrEmpty(paper.SelectedValue.Trim()) ? "" : paper.SelectedValue.Trim();
                String projectCode = examProject.SelectedValue.Trim();
                String registrationNo = regNo.SelectedValue.Trim();


                Boolean error = false;



                String applicationNo = Request.QueryString["applicationNo"];
                // Convert.ToString(Session["employeeNo"]),
                //Nav Funtion

                String status = new Config().ObjNav().InstitutionBookingLine(tbookingType, tpart, tsection, tpaper, projectCode, applicationNo, registrationNo);
                String[] info = status.Split('*');
                //try adding the line
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                //String Worktype = worktype.Text.Trim();
                String InstitutionNo = institution.SelectedValue.Trim();
                DateTime applicationDate = Convert.ToDateTime(bulkDate.Text);
                //DateTime myOrderDate = new DateTime();
                Boolean error = false;
                String message = "";


                /*
                Session["employeeNo"] = user.employeeNo;
                */
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
                String status = new Config().ObjNav().InstitutionExamBooking(applicationNo, InstitutionNo, applicationDate);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newApplicationNo)
                    {
                        applicationNo = info[2];

                    }
                    Response.Redirect("Intitutional.aspx?step=2&&applicationNo=" + applicationNo);
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }

            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}