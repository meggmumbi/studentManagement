using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StudentManagementASPX
{
    public class SurveyResponse
    {
        public string QuestionCode { get; set; }
        public string SectionCode { get; set; }
        public string SurveyNo { get; set; }
        public string GeneralResponse { get; set; }
        public string ResponseType { get; set; }
        public string RadioButton { get; set; }
        public string CheckBox { get; set; }
        public string Branching { get; set; }
    }
}