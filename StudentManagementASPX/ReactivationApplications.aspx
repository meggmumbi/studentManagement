<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReactivationApplications.aspx.cs" Inherits="StudentManagementASPX.ReactivationApplications" %>

<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <div class="panel panel-default">
        <div class="panel-heading">
            My Applications<div class="pull-right"></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">

            <div runat="server" id="Div1"></div>


            <table class="table table-bordered table-striped dataTable" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>
                        <th>Student Name</th>
                        <th>Id Number</th>
                        <th>Examination Description</th>
                        <th>Application Status</th>
                        <th style="color:red">Rejection Comment</th>

                    </tr>
                </thead>
                <tbody>
                    <% 
                        //String applicationNo = Request.QueryString["applicationNo"];
                        var nav = Config.ReturnNav();
                        string studentNo = Convert.ToString(Session["idNumber"]);
                        var details = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == studentNo && r.Document_Type == "Reactivation");
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
                        <td><%=detail.Course_Description %></td>
                        <%if (detail.Approval_Status == "Open")
                            {

                        %>
                        <td>Reactivation awaiting processing</td>
                        <%}
                            else if (detail.Approval_Status == "Pending Approval")
                            {
                        %>
                        <td>Application awaiting Approval</td>
                        <%}
                            else if (detail.Approval_Status == "Released")
                            {
                        %>
                        <td style="color:green">Reactivation Approved</td>
                        <%} %>

                        <td><%=detail.Reason_for_Rejection %></td>

                        <%--<td><a href="ExistingStudentsnInvoice.aspx?step=2&&studentNo=<%=detail.Student_No%>&&applicationNo=<%=detail.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Invoice</a></td>--%>
                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>






        </div>
    </div>
</asp:Content>
