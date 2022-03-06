<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StudentSurveys.aspx.cs" Inherits="StudentManagementASPX.StudentSurveys" %>
<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <div class="panel panel-default">
        <div class="panel-heading">Open Survey Responses
            <span class="pull-right"><i class="fa fa-chevron-left"></i> Page 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example4" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document No.</th>
                        <th>Description</th>
                        <th>Document Date</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                     <%
                         string studentNo = Convert.ToString(Session["studentNo"]);
                         var nav = Config.ReturnNav();
                         var query = nav.BusinessResearchResponse.Where(r => r.Participant_ID == studentNo && r.Target_Respondent_Type == "Customers" && r.Status == "Open");
                         foreach (var survey in query)
                         {
                    %>
                    <tr>
                        <td><% =survey.Document_No %></td>
                        <td><% =survey.Description%></td>
                        <td><% =Convert.ToDateTime(survey.Document_Date).ToString("MM/dd/yyyy")%></td>
                        <td><a href="BRResponseSection.aspx?surveyNo=<%=survey.Document_No %>"><label class="btn btn-success">Respond To Survey</label></a></td>
                        <%
                            } %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
