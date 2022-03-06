<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TimetableList.aspx.cs" Inherits="StudentManagementASPX.TimetableList" %>
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
        <p>The Student Portal enables the students to register for a kasneb Examination, book examination, apply for exemptions, withdrawal and differment.</p>
        <h5><u>Timetable</u></h5>
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
                        <th>Code</th>
                        <th>Examination Sitting</th>
                        <th>Description</th>                    
                        <th>View</th>

                    </tr>
                </thead>
                <tbody>
                    <% 

                        string IdNumber = Convert.ToString(Session["idNumber"]);
                        var nav = Config.ReturnNav();
                        string studentNo = Convert.ToString(Session["studentNo"]);
                        //string courseId = Request.QueryString["courseId"];
                        var details = nav.TimetablePlanners.Where(r => r.Approval_Status == "Released" && r.Posted==true && r.Published==true);
                        //string university = Convert.ToString(Session["UniversityCode"]);
                        int programesCounter = 0;
                        foreach (var detail in details)
                        {
                            programesCounter++;
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                         <td><%=detail.Code %></td>
                        <td><%=detail.Exam_Sitting_ID %></td>
                        <td><%=detail.Description %></td>
                        <td><a href="Timetable.aspx?&&code=<%=detail.Code%>" class="btn btn-success"><i class="fa fa-èye"></i>View Timetable</a></td>
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
