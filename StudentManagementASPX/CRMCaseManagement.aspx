<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CRMCaseManagement.aspx.cs" Inherits="StudentManagementASPX.CRMCaseManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="panel panel-default" style="width: 80%; margin: 0 auto">
        <asp:ScriptManager ID="ScriptManger1" runat="Server" />
        <asp:UpdatePanel ID="updPanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="panel-heading">
                    <strong>Case Management</strong>
                </div>


                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="Dashboard.aspx">DashBoard </a></li>
                                <li class="breadcrumb-item active">Case Management </li>
                            </ol>
                        </div>
                    </div>
                    <div id="generalFeedback" runat="server"></div>
                    <div class="row" style="justify-content: center">
                        <div class="col-md-6 offset-3" style="float: none; margin: auto;">
                            <div class="form-group">
                                <label>Case Type <span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" class="form-control select2" Style="width: 100%;" ID="txtgender" name="txtgender" OnSelectedIndexChanged="txtgender_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem>--Select Case Type--</asp:ListItem>
                                    <asp:ListItem Value="0">Enquiry</asp:ListItem>
                                    <asp:ListItem Value="1">Complaint</asp:ListItem>
                                    <asp:ListItem Value="2">Request</asp:ListItem>
                                    <asp:ListItem Value="3">Complement</asp:ListItem>

                                </asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label for="county">Subject<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="subject"></asp:DropDownList>
                            </div>


                            <div class="form-group">
                                <label for="lastname">Description</label>
                                <asp:TextBox runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" ID="description"></asp:TextBox>
                            </div>
                        </div>
                    </div>


                    <center> <asp:Button runat="server" class="btn btn-primary"  Text="Save Details" ID="saveDetails" OnClick="saveDetails_Click"></asp:Button></center>

                </div>
                 <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Exit" ID="Previousclick" OnClick="Previousclick_Click" />                 

                    <div class="clearfix"></div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>


</asp:Content>
