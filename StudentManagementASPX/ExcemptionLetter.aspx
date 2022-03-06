<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ExcemptionLetter.aspx.cs" Inherits="StudentManagementASPX.ExcemptionLetter" %>
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
           Exemption Letter
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div class="row">
                <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">DashBoard </a></li>
                            <li class="breadcrumb-item active">  Exemption Letter </li>
                        </ol>
                    </div>
            </div>               
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
