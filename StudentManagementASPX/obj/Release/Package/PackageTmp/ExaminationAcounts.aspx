<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ExaminationAcounts.aspx.cs" Inherits="StudentManagementASPX.ExaminationAcounts" %>

<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
        <div class="row">
            <div class="card">
                <div class="card-header text-center" data-background-color="darkgreen">
                    <h3 class="title"><strong>Welcome to Student Portal</strong></h3>
                </div>
            </div>
        </div>
    <center class="center-item">
            <p style="color:black"><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
        <h5><u>Examination Accounts</u></h5>
        <%--    <div class="row filter-row">
        <div class="col-sm-4 col-xs-6">
            <div class="form-group form-focus">
                <label class="control-label">Seacrh by  Procurement Method</label>
                <input type="text" class="form-control floating" />
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="form-group form-focus">
                <label class="control-label">Search by Regions</label>
                <input type="text" class="form-control floating" />
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <a href="#" class="btn btn-success btn-block"> Search </a>
        </div>
    </div>--%>
        <div class="row">
            <div runat="server" id="PaymentsMpesa"/>
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Registration No</th>
                        <th>Registration Date</th>
                        <th>First Name</th>
                        <th>Last Name </th>
                        <th>Other Name</th>
                        <th>Examination Id</th>                       
                        <th>Examination</th>
                        <th></th>                        
                      

                    </tr>
                </thead>
                <tbody>
                    <% 
                        var nav = Config.ReturnNav();
                        var today = DateTime.Today;
                        var examSittings = nav.ExamSittingCycle.Where(r => r.Sitting_Status == "Active" && r.Exam_End_Date >= today).ToList();
                         var NextexamSittings = nav.ExamSittingCycle.Where(r =>r.Exam_End_Date >= today && r.Sitting_Status=="Upcoming").ToList();


                        string IdNumber = Convert.ToString(Session["idNumber"]);

                        string studentNo = Convert.ToString(Session["studentNo"]);
                        //string courseId = Request.QueryString["courseId"];
                        var details = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Status == "Active");
                        //string university = Convert.ToString(Session["UniversityCode"]);
                        int programesCounter = 0;
                        foreach (var detail in details)
                        {
                            programesCounter++;
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.Registration_No %></td>
                        <td><%=Convert.ToDateTime(detail.Registration_Date).ToString("dd/MM/yyyy") %></td>
                        <td><%=detail.First_Name %></td>
                        <td><%=detail.Surname %></td>
                        <td><%=detail.Middle_Name %></td>
                        <td><%=detail.Course_ID %></td>
                      
                        <td><%=detail.Course_Description %></td>
                        <%--<%if (examSittings.Count == 0)
                            {
                        %>
                        <td style="color:red"><strong><%=" The Current Examination sitting is Closed. Please wait for the next sitting to be activated!" %></strong></td>
                        <%}
                            else--%> 
                        <% if(NextexamSittings.Count > 0)
                            {
                                %>
                        <td><a href="ExamBooking.aspx?&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-plus"></i>Book Examination</a></td>
                        
                            <%}

                         else{ %>
                        <td><a href="ExamBooking.aspx?&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-plus"></i>Book Examination</a></td>
                        <%} %>

                        

                    </tr>
                    <%  
                        } %>
                </tbody>
                 </table>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
