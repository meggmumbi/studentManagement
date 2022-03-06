<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="OpenCourseRegistrations.aspx.cs" Inherits="StudentManagementASPX.OpenCourseRegistrations" %>

<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <div class="row">
            <div class="card">
                  <div class="card-header text-center" data-background-color="darkgreen">
                    <h3 class="title"><strong> Student Portal</strong></h3>
                </div>
            </div>
        </div>
       <center class="center-item">
            <p style="color:black"><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
           
    <div class="content container-fluid">
     
        <h5><u>My Applications</u></h5>

            <%
            if (string.IsNullOrEmpty((string)Session["studentNo"]))
            {
        %>
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>
                        <th>Student Name</th>
                        <th>Passport No</th>
                        <th>Address</th>
                        <th>Examination Id</th>
                        <th>Edit</th>
                        <th></th>

                    </tr>
                </thead>
                <tbody>
                    <% 

                        string IdNumber = Convert.ToString(Session["idNumber"]);
                        var nav = Config.ReturnNav();
                        string application = "";
                        //string courseId = Request.QueryString["courseId"];
                        var details = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber && r.Document_Type == "Registration");
                        //string university = Convert.ToString(Session["UniversityCode"]);
                        int programesCounter = 0;
                        foreach (var detail in details)
                        {
                            programesCounter++;
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.No %></td>
                        <td><%=detail.Student_Name %></td>
                        <td><%=detail.ID_Number_Passport_No %></td>
                        <td><%=detail.Address %></td>
                        <td><%=detail.Examination_ID %></td>
                        <%
                            var drafts = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber && r.Document_Type == "Registration" && r.Submitted==false).ToList();
                            if (drafts.Count > 0)
                            {

                            %>
                        <td><a href="StudentRegistration.aspx?step=1&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Examination_ID%>&&projectCode=<%=detail.Examination_Project_Code %>" class="btn btn-success"><i class="fa fa-eye"></i>Edit</a></td>
                        <%}
                            else
                            {%>
                        <td></td>

                           <% }%>
                        <%
                            var detailz = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber && r.Document_Type == "Registration" && r.Submitted == true).ToList();
                            if (detailz.Count > 0)
                            {
                                foreach (var detailsz in detailz)
                                {
                                    application = detailsz.No;
                                }

                                var mpesa = nav.MpesaTransaction.Where(r => r.ACCOUNT_NUMBER == application).ToList();
                                if (mpesa.Count == 0)
                                {
                        %>
                        <td><a href="PaymentInvoice.aspx?&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Examination_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Proceed To Payment</a></td>
                        <%}
                            }
                            else
                            { %>
                        <td></td>
                        <%} %>
                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>
                </div>
            </div>
        </div>
                <%}


            else if (Session["studentNo"] != null)
            {
        %>
         <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example3">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>
                        <th>Student Name</th>
                        <th>Passport No</th>
                        <th>Address</th>
                        <th>Examination Id</th>
                        <th>Edit</th>
                        <th></th>

                    </tr>
                </thead>
                     <tbody>
                         <% 

                             string studentNo = Convert.ToString(Session["studentNo"]);
                             var nav = Config.ReturnNav();
                             string application = "";
                             //string courseId = Request.QueryString["courseId"];
                             var details = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Registration");
                             //string university = Convert.ToString(Session["UniversityCode"]);
                             int programesCounter = 0;
                             foreach (var detail in details)
                             {
                                 programesCounter++;
                         %>
                         <tr>
                             <td><%=programesCounter %></td>
                             <td><%=detail.No %></td>
                             <td><%=detail.Student_Name %></td>
                             <td><%=detail.ID_Number_Passport_No %></td>
                             <td><%=detail.Address %></td>
                             <td><%=detail.Examination_ID %></td>
                             <%
                                 var drafts = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Registration" && r.Submitted == false).ToList();
                                 if (drafts.Count > 0)
                                 {

                             %>
                             <td><a href="ExistingStudents.aspx?step=1&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Examination_ID%>&&projectCode=<%=detail.Examination_Project_Code %>" class="btn btn-success"><i class="fa fa-eye"></i>Edit</a></td>
                             <%}
                                 else
                                 {%>
                             <td></td>
                             <%} %>

                             <%
                                 var detailz = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Registration" && r.Submitted == true).ToList();
                                 if (detailz.Count > 0)
                                 {
                                     foreach (var detailsz in detailz)
                                     {
                                         application = detailsz.No;
                                     }

                                     var mpesa = nav.MpesaTransaction.Where(r => r.ACCOUNT_NUMBER == application).ToList();
                                     if (mpesa.Count == 0)
                                     {%>
                             <td><a href="PaymentInvoice.aspx?&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Examination_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Proceed To Payment</a></td>
                             <%}
                             }
                             else
                             { %>
                             <td></td>
                             <%} %>
                             <%--  <td><a href="ExistingStudents.aspx?step=3&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Examination_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Complete Application</a></td>--%>
                         </tr>
                         <%  
                             } %>
                     </tbody>
            </table>
                </div>
            </div>
        </div>

           <%} %>
    </div>


</asp:Content>
