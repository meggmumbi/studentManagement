<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BookedExams.aspx.cs" Inherits="StudentManagementASPX.BookedExams" %>
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
     <center>
            <p><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
        <h5><u>Booked Examinations</u></h5>
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
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Student Name</th>
                        <th>Examination Id</th>
                        <th>Examination </th>
                        <th>Examination Centre </th>
                        <th>Examination Cycle</th>
                        <th>Booking Amount</th>                                           
                        <th>Withdraw</th>

                    </tr>
                </thead>
                <tbody>
                    <% 

                        string IdNumber = Convert.ToString(Session["idNumber"]);
                        var nav = Config.ReturnNav();
                        string studentNo = Convert.ToString(Session["studentNo"]);
                        //string courseId = Request.QueryString["courseId"];
                        var details = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type=="Booking" && r.Posted==true && r.Cancelled==false);
                        //string university = Convert.ToString(Session["UniversityCode"]);
                        int programesCounter = 0;
                        foreach (var detail in details)
                        {
                            programesCounter++;
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.Student_Name %></td>
                        <td><%=detail.Examination_ID%></td>
                        <td><%=detail.Examination_Description %></td>
                        <td><%=detail.Examination_Center %></td>
                        <td><%=detail.Examination_Sitting %></td>
                        <td><%=detail.Booking_Amount %></td>
                                            
                        <td><a href="Withdrawal.aspx?courseid=<%=detail.Examination_ID%>&&RegNo=<%=detail.Student_Reg_No %>" class="btn btn-success"><i class="fa fa-plus"></i>Apply</a></td>
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
