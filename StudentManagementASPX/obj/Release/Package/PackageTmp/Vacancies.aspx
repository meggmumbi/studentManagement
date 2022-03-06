<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Vacancies.aspx.cs" Inherits="StudentManagementASPX.Vacancies" %>
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
        <p>This Student Portal enables you to register for a kasneb Examination, book examination, apply for exemptions, withdrawal and differment.</p>
        <h5><u>Open Vacancies</u></h5>
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
                    <table class="table table-striped table-bordered" style="width: 100%" id="example5">
                        <thead>
                            <tr>
                                <th>Vacancy No</th>
                                <th>Description</th>
                                <th>No of open Vacancies</th>
                                <th>Organization</th>
                                <th>Application End Date</th>
                                <th>Comments</th>
                                <th>View Vacancy Description</th>


                            </tr>
                        </thead>
                        <tbody>
                            <%
                                string IdNumber = Convert.ToString(Session["idNumber"]);
                                 var nav = Config.ReturnNav();
                                var today = DateTime.Today;
                                var innovations = nav.CrmVacancies.Where(r => r.Application_End_Date >= today && r.Published==true);
                                //var requests = "";
                                foreach (var innovation in innovations)
                                {
                            %>
                            <tr>
                                <td><%=innovation.Vacancy_No %></td>

                                <td><%=innovation.Position %></td>
                                <td><%=innovation.No_of_Openings %></td>
                                <td><%=innovation.Employer %></td>
                                <td><%=Convert.ToDateTime(innovation.Application_End_Date).ToString("dd/MM/yyyy") %></td>
                                <td><%=innovation.Comments %></td>
                                <td><a href="VacancyDescription.aspx?innovationNumber=<%=innovation.Vacancy_No %>" class="btn btn-success"><i class="fa fa-share m-r-10"></i>View</a></td>



                            </tr>
                            <%

}
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
