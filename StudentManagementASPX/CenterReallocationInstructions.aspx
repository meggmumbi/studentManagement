<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CenterReallocationInstructions.aspx.cs" Inherits="StudentManagementASPX.CenterReallocationInstructions" %>

<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    
     <% 
        var x = "Test";

    %>
    
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

      <p>
          <strong>Kindly take note of the following:</strong><br />  </p> 
          <ol>
              <li> A candidate wishing to change the allocated examination centre apply for center reallocation at least four weeks to the examination date indicating the reasons for the requested change.</li>
              <li> On receipt of the application, the Officer incharge shall assess the application and if satisfied with the reasons given, proceed to reallocate the candidate subject to centre capacity and communicate to the candidate via the email as appropriate at least three weeks before the start of the examinations.</li>
              <li>Where the Officer incharge is not satisfied with the reasons provided, he\she will communicate the decision to the candidate at least three weeks before the start of the examinations.</li>
          </ol>
        
   
              <h5><u>Booked Examinations</u></h5>
      <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Application No</th>
                            <th>Student Name</th>
                            <th>Id Number</th>
                            <th>Examination</th>
                           
                           

                        </tr>
                    </thead>
                    <tbody>
                        <% 
                           
                            var nav = Config.ReturnNav();
                            string studentNo = Convert.ToString(Session["studentNo"]);
                            var details = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Booking");                            
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
                     
                        <td><a href="centerReallocation.aspx?&&applicationNo=<%=detail.No%>&&courseid=<%=detail.Examination_ID %>" class="btn btn-success"><i class="fa fa-plus"></i>Apply For centre Reallocation</a></td>

                        <%} %>
                    </tr>
                   
                </tbody>
                 </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
