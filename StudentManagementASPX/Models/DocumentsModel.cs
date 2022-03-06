using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StudentManagementASPX.Models
{
    public class DocumentsModel
    {
        public string browsedDoc { get; set; }
        public string applicationNo { get; set; }
        public HttpPostedFileBase files { get; set; }

    }
}