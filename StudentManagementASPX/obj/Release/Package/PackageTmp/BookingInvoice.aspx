<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BookingInvoice.aspx.cs" Inherits="StudentManagementASPX.BookingInvoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    
    <div class="row" style="width: 100%; margin: auto;">
              <div class="panel-footer">
            <%--<asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="" />--%>
           
            <div class="clearfix"></div>
        </div>
    <div class="panel panel-primary">
         
            <div class="panel-heading"> <i class="icon-file"></i>
           Invoice
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div class="row">
                <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">DashBoard </a></li>
                            <li class="breadcrumb-item active">  Invoice </li>
                        </ol>
                    </div>
            </div>
                 <asp:Button runat="server" CssClass="btn btn-success pull-right"  Text="Proceed to Payment" ID="PaymentMode"  OnClick="PaymentMode_Click"></asp:Button>
                <div id="feedback" runat="server"></div>

                <br/>
                <div class="form-group">
                 <iframe runat="server" class="col-sm-12 col-xs-12 col-md-12 col-lg-12" height="500px" ID="p9form" style="margin-top: 10px;" ></iframe>
                    </div>
                </div>
               
            
         
          </div>
         
        </div>
    <div class="clearfix"></div>
     <script>
            
       
            $(document).ready(function () {
               

            });
        </script>



</asp:Content>
