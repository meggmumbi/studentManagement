<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BRResponseSection.aspx.cs" Inherits="StudentManagementASPX.BRResponseSection" %>
<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-default">
    <div class="panel-heading">
        Open Surveys
        <span class="pull-right"><i class="fa fa-chevron-left"></i> Page 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
    </div>
    <div class="panel-body">
        <div runat="server" id="feedback"></div>
        <table id="example4"  class="table table-bordered table-striped">
            <thead>
            <tr>
                <%--<th>Section Code</th>--%>
                <th>Description</th>
                <th>Section Completion Instruction</th>
                <th>No Of Questions</th>
                <th></th>
                <%--<th>Weight (%)</th>--%>
            </tr>
            </thead>
            <tbody>
            <%
                string surveyNo = Request.QueryString["surveyNo"];
                var nav = Config.ReturnNav();
                var survey = nav.BrResponseSection.Where(x=> x.Survey_Response_ID == surveyNo).ToList();
                foreach (var line in survey)
                {
                    %>
                <tr>
                   <%-- <td><% =line.Section_Code %></td>--%>
                    <td><% =line.Description %></td>
                    <td><% =line.Section_Completion_Instruction %></td>
                    <td><% =line.No_of_Questions%></td>
                  <%--  <td><% =line.Total_Weight%></td>--%>
                        <td><a href="BrQuestions.aspx?surveyNo=<%=line.Survey_Response_ID %>&&sectionCode=<%=line.Section_Code %>"><label class="btn btn-success">View Questions</label></a></td>
                </tr>
                <%
                } %>
            </tbody>
        </table>
    </div>
</div>
</asp:Content>
