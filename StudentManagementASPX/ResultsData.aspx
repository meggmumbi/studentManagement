<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ResultsData.aspx.cs" Inherits="StudentManagementASPX.ResultsData" %>
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
        <p>This Student Portal enables the students to assceess services related to kasneb examinations.</p>
        <h5><u>Examination Results</u></h5>
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Student Name</th>
                        <th>Examination</th>
                        <th>Examination Description</th>
                        <th>Grade </th>
                        <th>Examination Sitting</th>
                        <th>Issue Date</th>                                           
                       <%-- <th>Results</th>--%>

                    </tr>
                </thead>
                <tbody>
                    <% 

                        string IdNumber = Convert.ToString(Session["idNumber"]);
                        var nav = Config.ReturnNav();
                        string studentNo = Convert.ToString(Session["studentNo"]);
                        //string courseId = Request.QueryString["courseId"];
                        var details = nav.ExaminationResults.Where(r => r.National_ID_No==IdNumber);
                        //string university = Convert.ToString(Session["UniversityCode"]);
                        int programesCounter = 0;
                        foreach (var detail in details)
                        {
                            programesCounter++;
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.Student_Name %></td>
                        <td><%=detail.Paper%></td>
                        <td><%=detail.Paper_Name %></td>
                        <td><%=detail.Grade %></td>
                        <td><%=detail.Examination_Sitting_ID +" "+ detail.Financial_Year %></td>
                        <td><%=Convert.ToDateTime(detail.Issue_Date).ToString("yy/MM/dd") %></td>                                            
                       <%-- <td><a href="ResultSlip.aspx?&&application=<%=detail.Student_Reg_No%>" class="btn btn-success"><i class="fa fa-eye"></i>Result Slip</a></td>--%>
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
