<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StudentTraining.aspx.cs" Inherits="StudentManagementASPX.StudentTraining" %>
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
        <h5><u>Trainings</u></h5>
      
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered" style="width: 100%" id="example5">
                        <thead>
                            <tr>
                                <th>Training Description</th>
                                <th>Location</th>
                                <th>Training Provider Name</th>
                                 <th>Cost of Training</th>
                                <th>Start Date</th>
                                <th> End Date</th>
                                <th>View Training Description</th>


                            </tr>
                        </thead>
                        <tbody>
                            <%
                                string IdNumber = Convert.ToString(Session["idNumber"]);
                                 var nav = Config.ReturnNav();
                                var today = DateTime.Today;
                                var innovations = nav.Crmtraining.Where(r => r.End_Date >= today && r.Published==true);
                                //var requests = "";
                                foreach (var innovation in innovations)
                                {
                            %>
                            <tr>
                                <td><%=innovation.Description %></td>

                                <td><%=innovation.Location %></td>
                                <td><%=innovation.Provider_Name %></td>
                                 <td><%=innovation.Cost_Of_Training %></td>
                                <td><%=Convert.ToDateTime(innovation.Start_Date).ToString("dd/MM/yyyy") %></td>
                                <td><%=Convert.ToDateTime(innovation.End_Date).ToString("dd/MM/yyyy") %></td>
                                <td><a href="studentTrainingDescription.aspx?innovationNumber=<%=innovation.Document_No %>" class="btn btn-success"><i class="fa fa-share m-r-10"></i>View</a></td>



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
