<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RejectedApplications.aspx.cs" Inherits="StudentManagementASPX.RejectedApplications" %>

<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="card">
            <div class="card-header text-center" data-background-color="darkgreen">
                <h3 class="title"><strong>Student Portal</strong></h3>
            </div>
        </div>
    </div>
    <center class="center-item">
            <p style="color:black"><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
    <div class="panel panel-default">
        <div class="panel-heading">
            Rejected Applications<div class="pull-right"></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">

            <div runat="server" id="Div1"></div>

            <div class="table-responsive">
                <table class="table table-bordered table-striped dataTable" id="example4">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Application No</th>
                            <th>Student Name</th>
                            <th>Id Number</th>
                            <th>Examination Description</th>
                            <th style="color: red">Rejection Comment</th>
                            <th></th>


                        </tr>
                    </thead>
                    <tbody>
                        <% 

                            var nav = Config.ReturnNav();
                            string studentNo = Convert.ToString(Session["idNumber"]);
                            var details = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == studentNo && r.Document_Type == "Registration" && r.Approval_Status == "Rejected");
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
                            <td><%=detail.Examination_Description %></td>
                            <td><%=detail.Reason_for_Rejection %></td>
                            <%if (detail.Posted == false)
                                {
                            %>
                            <td><a href="StudentRegistration.aspx?step=1&&courseId=<%=detail.Examination_ID %>&&applicationNo=<%=detail.No%>" class="btn btn-success">Edit</a></td>
                            <%} %>
                        </tr>
                        <%  
                            } %>
                    </tbody>
                </table>
            </div>






        </div>
    </div>

</asp:Content>
