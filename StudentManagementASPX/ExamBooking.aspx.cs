using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using StudentManagementASPX.Models;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Net;
using Newtonsoft.Json;
using System.Text.RegularExpressions;

namespace StudentManagementASPX.Service_References
{
    public partial class ExamBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
                    {
                        decimal balance=0;
                        decimal BookingAmount=0;
                        decimal totalAmount=0;
                        var nav = Config.ReturnNav();
                        string studentNos = Convert.ToString(Session["studentNo"]);
                        string student = Convert.ToString(Session["studentNo"]);
                        studentNo.Text = student;

                        string IdNumber = Convert.ToString(Session["idNumber"]);

                      

                         ExamPapers.Text = Request.QueryString["Level"];
                         ApplicationNo.Text= Request.QueryString["applicationNo"];
                         InvoiceNo.Text = Request.QueryString["applicationNo"];





                       var registrationNo = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNos && r.Status=="Active").ToList();
                       foreach(var regNumbers in registrationNo) {

                       regNos.Text = regNumbers.Registration_No;

                        }

                        var today = DateTime.Today;
                        var exmcycle = nav.ExamCycle.Where(r => r.Exam_End_Date >= today && r.Sitting_Status=="Active" && r.Closed==false);
                        examCycle.DataSource = exmcycle;
                        examCycle.DataTextField = "examCycle";
                        examCycle.DataValueField = "examCycle";
                        examCycle.DataBind();
                       // examCycle.Items.Insert(0, new ListItem("--select--", ""));

                  


                        var ExamCenters = nav.ExamCenters;
                        examCenter.DataSource = ExamCenters;
                        examCenter.DataTextField = "Name";
                        examCenter.DataValueField = "Code";
                        examCenter.DataBind();
                        examCenter.Items.Insert(0, new ListItem("--select--", ""));

                        //var currenctH = nav.currency;
                        //currencyHead.DataSource = currenctH;
                        //currencyHead.DataTextField = "Code";
                        //currencyHead.DataValueField = "Code";
                        //currencyHead.DataBind();

                        string examId = Request.QueryString["courseid"];
               

                        var papers = nav.parts.Where(r => r.Course == examId).ToList().OrderBy(r => r.level_asc);
                        //paper.DataSource = papers;
                        //paper.DataTextField = "Code";
                        //paper.DataValueField = "Code";
                        //paper.DataBind();
                        //paper.Items.Insert(0, new ListItem("--select--", ""));


                        var payment = nav.paymentMode;
                        paymentsM.DataSource = payment;
                        paymentsM.DataTextField = "Code";
                        paymentsM.DataValueField = "Code";
                        paymentsM.DataBind();
                        paymentsM.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                        var regions = nav.ExamRegions.ToList();
                        region.DataSource = regions;
                        region.DataTextField = "Description";
                        region.DataValueField = "Code";
                        region.DataBind();
                        region.Items.Insert(0, new ListItem("--select--", ""));

                        string regnumber = regNos.Text;
                        var examinationAccounts = nav.ExaminationAccounts.Where(x=>x.Registration_No== regnumber && x.Status=="Active");
                        foreach(var Ren in examinationAccounts)
                        {
                         renewalAmount.Text = Convert.ToString(Ren.Renewal_Amount);
                         reACtivation.Text = Convert.ToString(Ren.Re_Activation_Amount);

                        }
                       
                        string applicationNo = Request.QueryString["applicationNo"];

                            var studentProcessings = nav.StudentProcessing.Where(r => r.No == applicationNo && r.Student_No == studentNos && r.Examination_ID == examId && r.Examination_Center_Code !="" && r.Examination_Center != "").ToList();
                            if (studentProcessings.Count > 0)
                            {
                                nextclick.Visible = true;

                            }


                        var studentProcessing = nav.StudentProcessing.Where(r => r.No == applicationNo && r.Student_No==studentNos && r.Examination_ID== examId).ToList();
                        if (studentProcessing.Count > 0)
                        {
                            List<ExamCentersList> examinationcenterList = new List<ExamCentersList>();
                            foreach (var descript in studentProcessing)
                            {
                                ExamCentersList list1 = new ExamCentersList();
                                list1.centerCode = descript.Examination_Center_Code;
                                BookingAmount = Convert.ToDecimal(descript.Booking_Amount);
                                //Amount.Text = Convert.ToString(descript.Booking_Amount);
                                //AmountInstructions.InnerText = Convert.ToString(descript.Booking_Amount);
                                studentNo.Text = Convert.ToString(Session["studentNo"]);                                
                                examinationCenter.SelectedValue = list1.centerCode;
                                examCenter.SelectedValue = descript.Examination_Center_Code;



                                examCycle.SelectedValue = descript.Examination_Sitting;
                                //ExaminationCenter.SelectedValue = descript.Examination_Center_Code;

                                //var examcenters = nav.ExamCenters.Where(x => x.Code == list1.centerCode).ToList();
                                //foreach (var centers in examcenters)
                                //{
                                //    zone.SelectedValue = centers.Exam_Zone;
                                //    region.SelectedValue = centers.Exam_Region;
                                //}        

                                }
                            }
                        var customer = nav.Instcustomers.Where(r => r.ID_No == IdNumber).ToList();
                        if (customer.Count > 0)
                        {
                            foreach (var custBalance in customer)
                            {
                                balance = Convert.ToDecimal(custBalance.Balance_LCY);

                            }
                            totalAmount = balance + BookingAmount;
                            Amount.Text = Convert.ToString(BookingAmount);
                            AmountInstructions.InnerText = Convert.ToString(BookingAmount);
                            AmountInstructionsManual.InnerText = Convert.ToString(BookingAmount);
                }
                  
            }
        }

        protected void regNo_SelectedIndexChanged(object sender, EventArgs e)
        {
            string examRegNo = regNos.Text.Trim();
            var nav = Config.ReturnNav();

            var examinationId = nav.ExaminationAccounts.Where(r => r.Registration_No == examRegNo);
            foreach (var myexamID in examinationId)
            {
                courseDescription.Text = myexamID.Course_Description;
                courseId.Text = myexamID.Course_ID;
            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                var nav = Config.ReturnNav();
                //String Worktype = worktype.Text.Trim();
                var today = DateTime.Today;
                String StudentNo = studentNo.Text.Trim();
                //String exapProjects = examproject.Text.Trim();
                String regNUmber = regNos.Text.Trim();
                string examCenterS = examCenter.SelectedValue.Trim();
                //string currencys = currency.SelectedValue.Trim();
                string examCycles = examCycle.SelectedValue.Trim();
                //DateTime myOrderDate = new DateTime();
                Boolean error = false;
                String message = "";
                var examSittings = nav.ExamSittingCycle.Where(r =>r.Exam_End_Date >= today).ToList();

                if (examSittings.Count == 0)
                {
                    error = true;
                    message = "The December Examination sitting is currently Closed. Please wait for the next sitting to be activated!";
                }

                if (string.IsNullOrEmpty(examCycles))
                {
                    error = true;
                    message = "An application with the given applcationNo does not exist";
                }

                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

                string IdNumber = Convert.ToString(Session["idNumber"]);
                var path = "~/images/" + IdNumber + ".jpg";
                string servpath = Server.MapPath(path);
                FileInfo file = new FileInfo(servpath);

                if (file.Exists.Equals(false))
                {
                    error = true;
                    message = "Please Upload Your Passport Photo";//faz algo
                }

                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

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
                    String status = new Config().ObjNav().CreateStudentBooking(applicationNo, StudentNo, regNUmber, examCenterS, examCycles, "");
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        if (newApplicationNo)
                        {
                            applicationNo = info[2];


                        }
                         string suggest = new Config().ObjNav().FnsuggestPapers(applicationNo);
                        linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                      
                    
                        string examId = Request.QueryString["courseid"];

                        Response.Redirect("ExamBooking.aspx?step=2&&applicationNo=" + applicationNo + "&&courseid=" + examId);

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

        protected void addItem_Click(object sender, EventArgs e)
        {
            try
            {
                // int tItemType = Convert.ToInt32(itemType.SelectedValue.Trim());
               // int tbookingType = Convert.ToInt32(deffermentType.SelectedValue.Trim());
               // String tpart = String.IsNullOrEmpty(part.SelectedValue.Trim()) ? "" : part.SelectedValue.Trim();
               // String tsection = section.SelectedValue.Trim();

                //String tpaper = String.IsNullOrEmpty(paper.SelectedValue.Trim()) ? "" : paper.SelectedValue.Trim();
                String Currency = courseId.Text.Trim();


                Boolean error = false;



                String applicationNo = Request.QueryString["applicationNo"];
                // Convert.ToString(Session["employeeNo"]),
                //Nav Funtion

                // String status = new Config().ObjNav().CreateStudentBookingLine(tbookingType, tpart, tsection, tpaper, Currency, applicationNo);
                String status = "";
                String[] info = status.Split('*');
                if (info[0] == "success")
                {

                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
               
                

            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExamBooking.aspx?step=1");
        }

        protected void deffermentType_SelectedIndexChanged(object sender, EventArgs e)
        {
            //loadType();
        }

        //public void loadType()
        //{
        //    try
        //    {
        //        var nav = Config.ReturnNav();
        //        string examId = Request.QueryString["courseid"];
        //        var itemtype = "";
        //        var typ = Convert.ToInt32(deffermentType.SelectedValue);

        //        switch (typ)
        //        {

        //            case 0:
        //                itemtype = "Section";
        //                var GL = nav.parts.Where(r => r.Course == examId).ToList();
        //                part.DataSource = GL;
        //                part.DataTextField = "Code";
        //                part.DataValueField = "Code";
        //                part.DataBind();
        //                part.Items.Insert(0, new ListItem("--select--", ""));
        //                return;

        //            case 1:
        //                itemtype = "Paper";

        //                var paper = nav.parts.Where(r => r.Course == examId).ToList();
        //                part.DataSource = paper;
        //                part.DataTextField = "Code";
        //                part.DataValueField = "Code";
        //                part.DataBind();
        //                part.Items.Insert(0, new ListItem("--select--", ""));
        //                return;

        //            case 2:
        //                itemtype = "Part";
        //                var parts = nav.parts.Where(r => r.Course == examId).ToList();
        //                part.DataSource = parts;
        //                part.DataTextField = "Code";
        //                part.DataValueField = "Code";
        //                part.DataBind();
        //                part.Items.Insert(0, new ListItem("--select--", ""));
        //                return;

        //            default:
        //                break;
        //        }


        //    }
        //    catch (Exception)
        //    {

        //    }
        //}

        //protected void section_SelectedIndexChanged(object sender, EventArgs e)
        //{
           
        //    string examId = Request.QueryString["courseid"];            
        //    var nav = Config.ReturnNav();

        //    var papers = nav.Papers.Where(r => r.Course == examId);
        //    paper.DataSource = papers;
        //    paper.DataTextField = "Code";
        //    paper.DataValueField = "Code";
        //    paper.DataBind();
        //    paper.Items.Insert(0, new ListItem("--select--", ""));
        //}

        //protected void paper_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    string parts = part.SelectedValue.Trim();
        //    string examId = Request.QueryString["courseid"];
        //    string sectionId = section.SelectedValue.Trim();
            
        //    var nav = Config.ReturnNav();

        //    var papers = nav.Papers.Where(r => r.Course == examId && r.Level == parts && r.Section == sectionId && r.Code == paper.SelectedValue);

        //    foreach (var paperz in papers)
        //    {
        //        description.Text = paperz.Description;
        //    }
        //}

        //protected void part_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    string parts = part.SelectedValue.Trim();
        //    string examId = Request.QueryString["courseid"];
        //    var nav = Config.ReturnNav();

        //    var sections = nav.Papersz.Where(r => r.Course == examId && r.Level == parts);
        //    paper.DataSource = sections;
        //    paper.DataTextField = "Description";
        //    paper.DataValueField = "Code";
        //    paper.DataBind();
        //    paper.Items.Insert(0, new ListItem("--select--", ""));
        //}

     

        //[System.Web.Services.WebMethod(EnableSession = true)]
        //public static string selectedPapers(ExaminationPapers postData) { 
      
        //    try
        //    {
               
        //        int i = 0;

        //        string results_0 = (dynamic)null;
        //        string results_1 = (dynamic)null;
            

        //        List<string> AllSelectedCategoriesLists = postData.papercode.ToList();
        //        //Loop and insert records.
        //        foreach (var iteminlist in AllSelectedCategoriesLists)
        //        {
        //            var selectedcategory = iteminlist;
        //            var nav = new Config().ObjNav();
        //            var status = nav.FnInsertBookingLines(postData.level, selectedcategory,postData.applicationNo);
        //            var res = status.Split('*');
        //            results_0 = res[0];
        //            results_1 = res[1];
        //        }
        //        switch (results_0)
        //        {
        //            case "success":
        //                return results_0 = "<div class='alert alert-success'>'" + results_1 + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //            default:
        //                return results_0 = "<div class='alert alert-danger'>'" + results_1 + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return  "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //}

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string selectedPapers(List<Targets> targetNumber)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            string part = "";
            
            try
            {
                if (targetNumber == null)
                {
                    targetNumber = new List<Targets>();
                }
                NewControl.ID = "feedback";
                //int alltargets = targetNumber.ToList().Count();
                //if (targetNumber.Count > 3)
                //{
                //    string alertMessage = "danger";
                //    string message = "You can can only select three papers.Please try again.";
                //    NewControl.InnerHtml = "<div class='alert alert-" + alertMessage + "'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //    results = message;
                //}
                //else if (targetNumber.Count <= 3) { 
                    foreach (Targets target in targetNumber)
                    {

                        string InitiativeNumber = target.TargetNumber;
                    var nav1 = Config.ReturnNav();
                    var levels = nav1.Papersz.Where(r => r.Coursez == target.courseId && r.Levelz == Convert.ToInt32(target.Level)).ToList();
                    foreach (var parts in levels)
                    {
                         part = parts.Levels;
                    }
                        var nav = new Config().ObjNav();
                        var status = nav.FnInsertBookingLines(part, target.TargetNumber, target.ApplicationNo);
                        string[] info = status.Split('*');
                        if (info[0] == "success")
                        {
                            NewControl.ID = "feedback";
                            NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            results = info[0];
                        }
                      else  if (info[0] == "danger")
                        {

                            NewControl.ID = "feedback";
                            NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            results = info[1];


                        }

                    
           }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        protected void prev_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            Response.Redirect("ExamBooking.aspx?step=2&&courseId=" + courseId + "&&studentNo=" + studentNo);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            Response.Redirect("ExamBooking.aspx?step=4&&courseId=" + courseId + "&&studentNo=" + studentNo);
        }

        protected void submitRegistration_Click(object sender, EventArgs e)
        {
            if (declaration.Checked == true)
            {

                try
                {
                    String tapplicationNo = Request.QueryString["applicationNo"];

                    Boolean error = false;
                    String message = "";

                    if (string.IsNullOrEmpty(tapplicationNo))
                    {
                        error = true;
                        message = "An application with the given applcationNo does not exist";
                    }

                    String status = new Config().ObjNav().FnSubmitApplication(tapplicationNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        submit.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Payment.Visible = true;
                        submitRegistration.Visible = false;
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
            else if (declaration.Checked == false)
            {

                var message = "Please accept our Terms and Conditions";
                submit.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {

            string courseId = Request.QueryString["courseId"];
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("ExamBooking.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }

        //protected void paper_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    ExamPapers.Text = paper.SelectedValue.Trim();
        //    Session["AllLevel"] = paper.SelectedValue.Trim();
        //}

        protected void delete_Click(object sender, EventArgs e)
        {
            String applicationNo = Request.QueryString["applicationNo"];
            var nav1 = Config.ReturnNav();
            string tentryNumber = removeFuelNumber.Text.Trim();
            var studentProcessingLine = nav1.studentProcessingLines.Where(r => r.Booking_Header_No == applicationNo && r.Type == "Booking").ToList();
            if (studentProcessingLine.Count > 3)
            {


                try
            {
              

                    var nav = new Config().ObjNav();
                    String status = nav.RemoveExaminationPaper(applicationNo, tentryNumber);
                    String[] info = status.Split('*');
                 examBooking.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
              }
                catch (Exception t)
                {
                    examBooking.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }



            else
            {
                var Tpapers = nav1.Papers.Where(r => r.Code == tentryNumber && r.Status == "Optional").ToList();
                if (Tpapers.Count > 0)
                {

                    try
                    {


                        var nav = new Config().ObjNav();
                        String status = nav.RemoveExaminationPaper(applicationNo, tentryNumber);
                        String[] info = status.Split('*');
                        examBooking.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    catch (Exception t)
                    {
                        examBooking.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    string message = "A minimum of three papers is required. Please proceed to the next step";
                    examBooking.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }

        }

        protected void region_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            string Region = region.SelectedValue.Trim();
            var ExaminationZones = nav.ExamZones.Where(r=>r.Region_Code==Region).ToList();
            zone.DataSource = ExaminationZones;
            zone.DataTextField = "Zone_Name";
            zone.DataValueField = "Code";
            zone.DataBind();
            zone.Items.Insert(0, new ListItem("--select--", ""));

            updPanel1.Update();
        }

        protected void Zone_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            string Examzone = zone.SelectedValue.Trim();
            string applicationNo = Request.QueryString["applicationNo"];
            string courseid = Request.QueryString["courseid"];
            int Total = 0;
            var ExaminationCenters = nav.centerCourseapacity.Where(r => r.Zone_Code == Examzone && r.Course_Id== courseid).ToList();
          
            if (ExaminationCenters.Count == 0)
            {
                string Message = "The selected Examination Zone does not have Examination centers for the registered examination. " + courseid;
                examcenterz.InnerHtml = "<div class='alert alert-danger'>" + Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {
                List<ExamCentersList> examinationcenterList = new List<ExamCentersList>();
                foreach (var examCenter in ExaminationCenters)
                {
                    ExamCentersList list1 = new ExamCentersList();
                    list1.centerCode = examCenter.Center_Code;
                    var bookingLines = nav.studentProcessingLines.Where(r => r.Booking_Header_No == applicationNo).ToList();
                    foreach(var bookingLine in bookingLines)
                    {
                        var centerBookingEntries = nav.centerBookingEntries.Where(r => r.Exam_Center_Code == list1.centerCode && r.Status == "Allocated" && r.Subject_Code == bookingLine.Paper).ToList();
                        if (centerBookingEntries.Count > 0)
                        {
                            Total++;
                        }
                    }
                    
                    var center = nav.ExamCenters.Where(r => r.Code == list1.centerCode && Total< r.Maximum_Capacity_Per_Session && r.Blocked==false).ToList();
                    if (center.Count > 0)
                    {
                        list1.centerCode = examCenter.Center_Code;
                        list1.name = examCenter.Center_Name;
                        examinationcenterList.Add(list1);
                    }
                }
                //List<StudentProcessing> studetnEntriesz = new List<StudentProcessing>();

                //foreach (var exemptionEntrys in exemptionEntries)
                //{

                //    StudentProcessing list1 = new StudentProcessing();
                //    list1.Papercode = exemptionEntrys.No;

                //    studetnEntriesz.Add(list1);

                //}
                // List<ExamCentersList> examinationcenterList = new List<ExamCentersList>();

                // foreach (var examCenter in ExaminationCenters)
                // {
                //     ExamCentersList examcenters = new ExamCentersList();
                //     examcenters.centerCode = examCenter.Center_Code;

                //     examinationcenterList.Add(examcenters);
                // }

                // List<ExamCentersList> examCenterList = new List<ExamCentersList>();
                // ExamCentersList[] examCenterArray = examCenterList.ToArray();

                // var ExaminationZenter = nav.ExamCenters.Where(m => m.Exam_Zone == Examzone).ToList();

                // foreach (var subtopic in ExaminationZenter)
                // {

                //     ExamCentersList list = new ExamCentersList();
                //     list.code = subtopic.Code;
                //     list.name = subtopic.Name;
                //     examCenterList.Add(list);
                // }
                //var Results = examCenterList.Intersect(examinationcenterList).ToList();



                examinationCenter.DataSource = examinationcenterList;
                examinationCenter.DataTextField = "name";
                examinationCenter.DataValueField = "centerCode";
                examinationCenter.DataBind();
                examinationCenter.Items.Insert(0, new ListItem("--select--", ""));

                updPanel1.Update();
            }
        }

   
        protected void nextbutton_Click(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            String applicationNo = Request.QueryString["applicationNo"];
            string studentNumb = Convert.ToString(Session["studentNo"]);
            string courseId = Request.QueryString["courseId"];
            var studentProcessingLine = nav.studentProcessingLines.Where(r => r.Booking_Header_No == applicationNo && r.Type == "Booking").ToList();
            var exemptionEntries = nav.ExemptionEntries.Where(r => r.Stud_Cust_No == studentNumb).ToList();

            string studentNo = Convert.ToString(Session["studentNo"]);          
            var program = nav.ExamBookingEntries.Where(r => r.Stud_Cust_No == studentNo && r.Blocked == false).ToList();
            if (program.Count == 0)
            {
                if (studentProcessingLine.Count < 3)
                {
                    if (exemptionEntries.Count > 0)
                    {
                        // string courseId = Request.QueryString["courseId"];
                        // string applicationNo = Request.QueryString["applicationNo"];
                       // String status = new Config().ObjNav().FnsuggestPapers(applicationNo);
                        Response.Redirect("ExamBooking.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
                       
                       
                    }
                    else
                    {
                        response.InnerHtml = "<div class='alert alert-danger'>Please select three (3) or more examination papers before you proceed <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        //Response.Redirect("ExamBooking.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
                    }
                }

                    else if (studentProcessingLine.Count >= 3)
                {
                    //string courseId = Request.QueryString["courseId"];
                    //string applicationNo = Request.QueryString["applicationNo"];
                   // String status = new Config().ObjNav().FnsuggestPapers(applicationNo);
                    Response.Redirect("ExamBooking.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
                }

        }
            else if (program.Count > 0)
            {
                //string courseId = Request.QueryString["courseId"];
                //string applicationNo = Request.QueryString["applicationNo"];
                //zString status = new Config().ObjNav().FnsuggestPapers(applicationNo);
                Response.Redirect("ExamBooking.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
            }



}

        protected void previous_Click1(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("ExamBooking.aspx?step=1&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }

        protected void examcenters_Click(object sender, EventArgs e)
        {
            try
            {
                string texamcenter = examinationCenter.SelectedValue.Trim();
                String applicationNo = Request.QueryString["applicationNo"];
                Boolean error = false;
                String message = "";
                if (string.IsNullOrEmpty(texamcenter))
                {
                    error = true;
                    message = "An application with the given applcationNo does not exist";
                }


                var nav = new Config().ObjNav();
                String status = nav.FnConfirmExamCenter(applicationNo, texamcenter);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {

                    examcenterz.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    nextclick.Visible = true;
                }
                else
                {
                    examcenterz.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
               
            }
            catch (Exception t)
            {
                examcenterz.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void Previousclick_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("ExamBooking.aspx?step=2&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }

        protected void nextclick_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("ExamBooking.aspx?step=4&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }
        protected void Payment_Click(object sender, EventArgs e)
        {
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("BookingInvoice.aspx?applicationNo=" + applicationNo);
        }
        protected void makePayments_Click(object sender, EventArgs e)
        {
            try
            {
                string applicationNumber = accreditationnumber.Text.Trim();
                applicationNumber = applicationNumber.Replace('/', '_');
                applicationNumber = applicationNumber.Replace(':', '_');
                string path1 = Config.FilesLocation() + "Registration Payments/";
                string str1 = Convert.ToString(applicationNumber);
                string folderName = path1 + str1 + "/";
                bool paymentsDocUploaded = false;
                try
                {
                    if (paymentdocument.HasFile)
                    {
                        string extension = System.IO.Path.GetExtension(paymentdocument.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            string filename = "PaymentDocument" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (System.IO.File.Exists(folderName + filename))
                            {
                                System.IO.File.Delete(folderName + filename);
                            }
                            paymentdocument.SaveAs(folderName + filename);
                            if (System.IO.File.Exists(folderName + filename))
                            {
                                paymentsDocUploaded = true;
                            }
                        }
                        else
                        {
                            PaymentsMpesa.InnerHtml = ("The file extension of the payment document is not allowed");
                        }

                    }
                }
                catch (Exception)
                {
                    PaymentsMpesa.InnerHtml = ("The Payments Details Could Not Be Captured Kindly Contact the System Administrator");
                }

                string applicationnumber = accreditationnumber.Text.Trim();
                string paymentreference = paymentsref.Text.Trim();
                string mode = paymentsM.SelectedValue.Trim();
               // string status = "";
                string status = new Config().ObjNav().ConfirmPaymentsStudentBooking(applicationnumber, paymentsDocUploaded, paymentreference, "", mode);
               string[] info = status.Split('*');
                PaymentsMpesa.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
            catch (Exception y)
            {
                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void SubmitPayment_Click(object sender, EventArgs e)
        {
            var response = "";
            try
            {
                using (var client = new WebClient())
                {



                    EnableTrustedHosts();



                    client.Headers.Add("Content-Type", "application/json");




                    string tphoneNumber = PhoneNumberPay.Text.Trim();
                    decimal tAmount = Convert.ToDecimal(Amount.Text.Trim());
                    Boolean error = false;
                    String message = "";

                    if (string.IsNullOrEmpty(tphoneNumber))
                    {
                        error = true;
                        message = "Please enter Phone Number used to pay";
                    }

                    string _mobileNumber = CleanNumber(tphoneNumber);

                    // trim any leading zeros
                    _mobileNumber = _mobileNumber.TrimStart(new char[] { '0' });


                    // add country code if they haven't entered it
                    //If we need to handle with multiple Country codes we have to place a list here,Currently added +64 as per document.
                    if (!_mobileNumber.StartsWith("254"))
                    {
                        _mobileNumber = "254" + _mobileNumber;
                    }



                    String applicationNo = Request.QueryString["applicationNo"];

                    //  string account = idno;  //id number

                    var nav = Config.ReturnNav();
                    var detailz = nav.MpesaTransaction.Where(x=>x.ACCOUNT_NUMBER== applicationNo).ToList();
                    if (detailz.Count > 0)
                    {

                        response = ("You have already paid for the Booking. You can now view your timetable");
                        PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";



                    }

                    else
                    {

                        var vm = new { accountnumber = applicationNo, transactionreference = applicationNo, amount = tAmount, transactiondescription = "Paybill Deposit", businessnumber = "204777", Telephone = _mobileNumber };



                        var dataString = JsonConvert.SerializeObject(vm);



                        try
                        {
                            string result = "";
                            result = client.UploadString("https://mobile.kasneb.or.ke:8222/api/stkpush", "POST", dataString);



                            Stkresult details = null;




                            details = JsonConvert.DeserializeObject<Stkresult>(result);



                            if (details.ResponseCode == "0")
                            {

                                response = (details.ResponseDescription + "." + " " + "You have initiated payment using MPESA. Please enter your MPESA PIN when prompted.");
                                PaymentsMpesa.InnerHtml = "<div class='alert alert-success'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                                //string responses = new Config().ObjNav().FnConfirmPayments(applicationNo);
                                ////string response = "";

                                //String[] info = responses.Split('*');
                                //if (info[0] == "success")
                                //{

                                //    PaymentsMpesa.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                                //    //Response.Redirect("Dashboard.aspx");

                                //}
                                //else
                                //{
                                //    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //}
                                //Response.Redirect("Dashboard.aspx");

                            }
                            else
                            {
                                response = (details.ResponseDescription + ". " + "" + "Please Use the Manual Mpesa Payment Process");
                                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                        }
                        catch (Exception ex)
                        {
                            response = ex.Message;
                            PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }

                }

            }
            catch (Exception ex)
            {
                response = ex.Message;
                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }



















            //try
            //{



            //    string tphoneNumber = PhoneNumberPay.Text.Trim();
            //    decimal tAmount = Convert.ToDecimal(Amount.Text.Trim());
            //    Boolean error = false;
            //    String message = "";

            //    if (string.IsNullOrEmpty(tphoneNumber))
            //    {
            //        error = true;
            //        message = "Please enter Phone Number used to pay";
            //    }



            //    String applicationNo = Request.QueryString["applicationNo"];




            //    string response = new Config().ObjNav().FnConfirmPayment(applicationNo,tphoneNumber,tAmount);
            //    //string response = "";

            //    String[] info = response.Split('*');
            //    if (info[0] == "success")
            //    {

            //        PaymentsMpesa.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            //    }
            //    else
            //    {
            //        PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    }
            //}
            //catch (Exception m)
            //{
            //    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    //MessageBox.Show(m.Message);
            //    // ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + m.Message + "');", true);
            //}
        }
        public static void EnableTrustedHosts()
        {
            System.Net.ServicePointManager.ServerCertificateValidationCallback =
                 ((sender, certificate, chain, sslPolicyErrors) => true);
        }
        public partial class Stkresult
        {
            public string MerchantRequestID { get; set; }
            public string CheckoutRequestID { get; set; }
            public string ResponseCode { get; set; }
            public string ResponseDescription { get; set; }
            public string CustomerMessage { get; set; }
        }
        public string CleanNumber(string phone)
        {
            Regex digitsOnly = new Regex(@"[^\d]");
            return digitsOnly.Replace(phone, "");
        }

        protected void renew_Click(object sender, EventArgs e)
        {
            Response.Redirect("Renewal.aspx");
        }

        protected void reload_Click(object sender, EventArgs e)
        {
            String applicationNo = Request.QueryString["applicationNo"];
            String status = new Config().ObjNav().FnsuggestPapers(applicationNo);
        }
    }
}