<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReceiptsData.aspx.cs" Inherits="StudentManagementASPX.ReceiptsData" %>
<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <div class="content container-fluid">
        <div class="row">
            <div class="card">
                  <div class="card-header text-center" data-background-color="darkgreen">
                    <h3 class="title"><strong>Welcome to Student Portal</strong></h3>
                </div>
            </div>
        </div>
       <center class="center-item">
            <p style="color:black"><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
           

       
        <h5><u>Receipts</u></h5>
   
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Process Type</th>
                        <th>Examination ID</th>
                        <th>Examination</th>
                        <th>Application Amount</th>
                        <th>Booking Amount</th>
                        <th>Exemption Amount</th>          
                        <th></th>

                    </tr>
                </thead>
                     <tbody>
                         <% 


                             var nav = Config.ReturnNav();
                             string studentNo = Convert.ToString(Session["studentNo"]);
                                if (studentNo != "") { 

                                var details = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Posted == true).ToList();
                           
                                 int programesCounter = 0;
                                 foreach (var detail in details)
                                 {
                                     programesCounter++;
                         %>
                         <tr>
                             <td><%=programesCounter %></td>
                             <td><%=detail.Document_Type %></td>
                             <td><%=detail.Examination_ID %></td>
                             <td><%=detail.Examination_Description %></td>
                             <td><%=detail.Application_Amount %></td>
                             <td><%=detail.Booking_Amount %></td>
                             <td><%=detail.Exemption_Amount %></td>
                             <td><a href="Receipt.aspx?applicationNo=<%=detail.No%>&&documentType=<%=detail.Document_Type %>" class="btn btn-success">View Receipt</a></td>

                         </tr>
                         <%  
                             }
                         }
                         else
                         {%><tr>
                             <td></td
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                            </tr>
                         <%} %>
                     </tbody>
                 </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
