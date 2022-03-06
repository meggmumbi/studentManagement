<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ExistingStudentsnInvoice.aspx.cs" Inherits="StudentManagementASPX.ExistingStudentsnInvoice" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <%
        const int maxStep = 2;
        var nav = Config.ReturnNav();
        String appplication = "";


        int myStep = 1;
        try
        {
            myStep = Convert.ToInt32(Request.QueryString["step"]);
            if (myStep > maxStep || myStep < 1)
            {
                myStep = 1;
            }
        }
        catch (Exception)
        {
            myStep = 1;
        }
    %>
    <%
        if (myStep == 1)

        {
    %>
      <div class="panel panel-default">
        <div class="panel-heading">
           Registration Invoice<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
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
                       <th>Examination Description</th>
                       <th>Student No</th>
                       <th>Proceed</th>
                   </tr>
               </thead>
               <tbody>
                   <% 
                       String applicationNo = Request.QueryString["applicationNo"];
                        string studentNo = Convert.ToString(Session["studentNo"]);
                       var details = nav.StudentProcessing.Where(r => r.No == applicationNo && r.Approval_Status == "Released" && r.Student_No == studentNo && r.Application_Invoice !=null);
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
                       <td><%=detail.Course_Description %></td>
                       <td><%=detail.Student_No %></td>


                       <td><a href="ExistingStudentsnInvoice.aspx?step=2&&studentNo=<%=detail.Student_No%>&&applicationNo=<%=detail.Application_Invoice %>" class="btn btn-success"><i class="fa fa-eye"></i>View Invoice</a></td>
                   </tr>
                   <%  
                       } %>
               </tbody>
        </table>






            </div>
          </div>
      <%
        }
        else if (myStep == 2)
        {
    %>
        <div class="panel panel-default">
        <div class="panel-heading">
            Invoice
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
       
     <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">

            <div class="panel-heading">
                <i class="icon-file"></i>
            View  Invoice
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="com-md-4 col-lg-4">
                    <label>Student Name</label>
                    <asp:TextBox CssClass="form-control select2" ID="custName" runat="server" Enabled="false" />
                </div>
                <div class="com-md-4 col-lg-4">
                    <label>Student Number</label>

                    <asp:TextBox ID="invoiceNumber" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                </div>
                <div class="com-md-3 col-lg-3">
                    <br />
                    <asp:Button CssClass="btn btn-success" ID="generate" runat="server" Text="view" OnClick="generate_Click" />
                </div>
                <br />
                <div class="form-group">
                    <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" id="p9form" style="margin-top: 10px;"></iframe>
                </div>
            </div>

            <div class="panel-footer">

                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Make Payment" OnClick="Unnamed_Click" />

                <div class="clearfix"></div>
            </div>

        </div>
    </div>
  <%} %>

</div>


    <script>


        $(document).ready(function () {


        });
    </script>

</asp:Content>
