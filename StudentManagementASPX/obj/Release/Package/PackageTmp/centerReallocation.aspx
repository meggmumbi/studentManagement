<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="centerReallocation.aspx.cs" Inherits="StudentManagementASPX.centerReallocation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="panel panel-default" style="width: 80%; margin: 0 auto">
        <asp:ScriptManager ID="ScriptManger1" runat="Server" />
        <asp:UpdatePanel ID="updPanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="panel-heading">
                    <strong>Centre Reallocation</strong>
                </div>


                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="Dashboard.aspx">DashBoard </a></li>
                                <li class="breadcrumb-item active">Centre Reallocation Application Form </li>
                            </ol>
                        </div>
                    </div>
                    <div id="examcenterz" runat="server"></div>
                    <div class="row" style="justify-content: center">

                        <p class="col-md-offset-3"><strong>--Previous Examination Centre Information --</strong></p>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="city">Examination </label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="courseIDTEXT" Enabled="false"></asp:TextBox>
                              
                            </div>
                        </div>
                         <div class="col-md-6" style="display:none">
                            <div class="form-group">
                                <label for="city">Examination </label>
                               <asp:TextBox runat="server" CssClass="form-control" ID="oldExamRegions" />                              
                            </div>
                       
                        
                            <div class="form-group">
                                <label for="city">Examination </label>
                               <asp:TextBox runat="server" CssClass="form-control" ID="oldExamZones" />                              
                            </div>
                        
                         
                            <div class="form-group">
                                <label for="city">Examination </label>
                               <asp:TextBox runat="server" CssClass="form-control" ID="oldExamCenetrs" />                              
                            </div>
                        </div>
                          
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="city">Region </label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="oldExamRegion" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="city">Examination Zone </label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="oldExamZone" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="city">Initial Examination centre </label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="oldExamCenetr" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                        </br>
                        <p class="col-md-offset-3"><strong>--Preferred Examination centre--</strong></p>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Examination centre<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="NewExamCenter"></asp:DropDownList>
                            </div>
                        </div>

                    </div>
                    <center>
                    <a href="javascript:editTeamMember('<%=Request.QueryString["applicationNo"]%>');" class="btn btn-primary rounded">submit request</a>  
                        </center>    
                   

                </div>
                 <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Exit" ID="Previousclick" OnClick="Previousclick_Click" />                 

                    <div class="clearfix"></div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <script>
      function editTeamMember(trainingNo) {
            document.getElementById("MainContent_removeFuelWorkType").value = trainingNo;


            $("#editTeamMemberModal").modal();
        }
    </script>
    <div id="editTeamMemberModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">centre Reallocation?</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to Apply for centre reallocation?</p>
                    <asp:TextBox runat="server" ID="removeFuelWorkType" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                      <asp:Button runat="server" class="btn btn-primary"  Text="Submit" ID="saveDetails" OnClick="saveDetails_Click"></asp:Button></>
                </div>
            </div>

        </div>
    </div>


</asp:Content>
