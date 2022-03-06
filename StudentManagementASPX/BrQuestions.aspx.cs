using System.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class BrQuestions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            quizId.Visible = false;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertComponentItems(List<SurveyResponse> cmpitems)
        {
            string tSurveyNo = "", tSectionCode = "", tQuestion = "", tGeneralResponse = "", tRadioButton = "", tCheckbox = "", tResponseType = "", tBranching = "";
            string results_0 = (dynamic)null;

            try
            {

                //Check for NULL.
                if (cmpitems == null)
                    cmpitems = new List<SurveyResponse>();

                //Loop and insert records.
                foreach (SurveyResponse oneitem in cmpitems)
                {
                    tSurveyNo = oneitem.SurveyNo;
                    tSectionCode = oneitem.SectionCode;
                    tQuestion = oneitem.QuestionCode;
                    tGeneralResponse = oneitem.GeneralResponse;
                    tRadioButton = oneitem.RadioButton;
                    tCheckbox = oneitem.CheckBox;
                    tResponseType = oneitem.ResponseType;
                    tBranching = oneitem.Branching;

                    if (string.IsNullOrWhiteSpace(tGeneralResponse))
                    {
                        tGeneralResponse = "";
                    }

                    if (string.IsNullOrWhiteSpace(tCheckbox))
                    {
                        tCheckbox = "";
                    }

                    if (string.IsNullOrWhiteSpace(tRadioButton))
                    {
                        tRadioButton = "";
                    }

                    if (tResponseType == "Single Response")
                    {
                        string status = new Config().ObjNav().FnCreateBRResponseQuestions(tSurveyNo, tSectionCode, tQuestion, tRadioButton, tGeneralResponse);
                        string[] info = status.Split('*');
                        results_0 = info[0];
                    }
                    else if (tResponseType == "Multiple Response")
                    {
                        string status = new Config().ObjNav().FnInsertMultipleSurveys(tSurveyNo, tSectionCode, tQuestion, tCheckbox);
                        string[] info = status.Split('*');
                        results_0 = info[0];
                    }

                }
            }
            catch (Exception ex)
            {
                results_0 = ex.Message;
            }
            return results_0;
        }
        //protected void Dropdownlist1_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    //var nav = Config.ReturnNav();
        //    //string tquizId = Convert.ToString(Session["QID"]);
        //    //var quiz = nav.BRResponseQuestion.Where(x => x.Question_ID == tquizId);
        //    //foreach (var mQuiz in quiz)
        //    //{
        //    //    if (mQuiz.Branch_Logic_Question == true)
        //    //    {
        //    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('divtest').style.visibility = 'visible';", true);
        //    //    }
        //    //    else if (mQuiz.Branch_Logic_Question == false)
        //    //    {
        //    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('divtest').style.visibility = 'visible';", false);
        //    //    }
        //    //}
        //    if (listItems.SelectedValue == "0")
        //    {
        //         Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('divtest').style.visibility = 'visible';", true);
        //        //divtest.Visible = true;
        //    }
        //}

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string Insertbrachedresponse(List<BrachedResponses> Bcmpitems)
        {
            string tSurveyNo = "", tSectionCode = "", tParentQuestionId = "", tParentresponse = "", tQuestionId = "", tQuestion = "", tResponsevalue = "";
            string results_0 = (dynamic)null;

            try
            {

                //Check for NULL.
                if (Bcmpitems == null)
                    Bcmpitems = new List<BrachedResponses>();

                //Loop and insert records.
                foreach (BrachedResponses oneitem in Bcmpitems)
                {
                    tSurveyNo = oneitem.SurveyNo;
                    tSectionCode = oneitem.SectionCode;
                    tParentQuestionId = oneitem.ParentQuestionId;
                    tParentresponse = oneitem.Parentresponse;
                    tQuestionId = oneitem.QuestionId;
                    tQuestion = oneitem.Question;
                    tResponsevalue = oneitem.Responsevalue;

                    if (string.IsNullOrWhiteSpace(tResponsevalue))
                    {
                        results_0 = "Please add your response";
                    }

                    string status = new Config().ObjNav().FnInsertBranchingResponses(tSurveyNo, tSectionCode, tParentQuestionId, tParentresponse, tQuestionId, tQuestion, tResponsevalue);
                    string[] info = status.Split('*');
                    results_0 = info[0];

                }
            }
            catch (Exception ex)
            {
                results_0 = ex.Message;
            }
            return results_0;
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            string surveyNo = Request.QueryString["surveyNo"];
            string sectionCode = Request.QueryString["sectionCode"];
            Response.Redirect("BRResponseSection.aspx?&&surveyNo=" + surveyNo + "&&sectionCode=" + sectionCode);
        }
    }
}