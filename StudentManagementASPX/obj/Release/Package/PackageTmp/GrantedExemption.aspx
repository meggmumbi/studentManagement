<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="GrantedExemption.aspx.cs" Inherits="StudentManagementASPX.GrantedExemption" %>
<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="content container-fluid">
        <div class="row">
            <div class="card">
                <div class="card-header text-center" data-background-color="darkgreen">
                    <h5 class="title"><i>Welcome to Student portal</i></h5>
                </div>
            </div>
        </div>
        <p>         The Student Portal enables a student to register for a kasneb examination, book examination and apply for exemptions  withdrawal and deferment of an examination.</p>
        <div id="generalFeedback" runat="server"></div>
        <h5><u>Granted Exemption</u></h5>
            <%
            if (string.IsNullOrEmpty((string)Session["studentNo"]))
            {
        %>
        <%
            string Message = "Please Register for a kasneb Examination";
            generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
             %>

      
              <%-- <div class="row">
                  <div id="feedback" runat="server" /> 
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
                      <%--  <th>Edit</th>--%>
          <%--              <th>Payment</th>

                    </tr>
                </thead>
                <tbody>
                    <% 

                        string IdNumber = Convert.ToString(Session["idNumber"]);
                        var nav = Config.ReturnNav();
                        //var application = appNo.Text;
                        //string courseId = Request.QueryString["courseId"];
                        var details = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber && r.studentType == "New" && r.Document_Type == "Registration" && r.submitted==true && r.Payment_Evidence == false);
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
                        <td><%=detail.Course_ID %></td>
                      <%--  <td><a href="StudentRegistration.aspx?step=1&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Edit</a></td>
                        <td><a href="PaymentInvoice.aspx?&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Complete Application</a></td>
                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>
                </div>
            </div>
        </div>--%>--%>

            <%}


            else if (Session["studentNo"] != null)
            {
        %>
       <div class="row">
                  <div id="Div1" runat="server" /> 
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>
                        <th>Student Name</th>
                        <th>Examination</th>
                        <th>Registration Number</th>
                        <th>Exemption Amount</th>
                      <%--  <th>Edit</th>--%>
                        <th>View Exemption Letter</th>

                    </tr>
                </thead>
                <tbody>
                    <% 

                        string studentNo = Convert.ToString(Session["studentNo"]);
                        var nav = Config.ReturnNav();
                        //var application = appNo.Text;
                        //string courseId = Request.QueryString["courseId"];
                        var details = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Exemption" && r.Posted==true);
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
                        <td><%=detail.Examination_Description%></td>
                        <td><%=detail.Student_Reg_No %></td>
                        <td><%=detail.Exemption_Amount %></td>
                      <%--  <td><a href="StudentRegistration.aspx?step=1&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Edit</a></td>--%>
                        <td><a href="ExcemptionLetter.aspx?&&applicationNo=<%=detail.No%>" class="btn btn-success"><i class="fa fa-eye"></i>Exemption Letter</a></td>
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
