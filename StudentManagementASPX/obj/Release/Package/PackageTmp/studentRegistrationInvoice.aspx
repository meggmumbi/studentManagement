<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="studentRegistrationInvoice.aspx.cs" Inherits="StudentManagementASPX.studentRegistrationInvoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

      <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">

            <div class="panel-heading">
                <i class="icon-file"></i>
                Generate  Invoice
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="com-md-4 col-lg-4">
                    <label>Institution Name</label>
                    <asp:TextBox CssClass="form-control select2" ID="custName" runat="server" Enabled="false" />
                </div>
                <div class="com-md-4 col-lg-4">
                    <label>Invoice Number</label>

                    <asp:TextBox ID="invoiceNumber" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                </div>
                <div class="com-md-3 col-lg-3">
                    <br />
                    <asp:Button CssClass="btn btn-success" ID="generate" runat="server" Text="Generate" OnClick="generate_Click" />
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


    <script>


        $(document).ready(function () {


        });
    </script>


</asp:Content>
