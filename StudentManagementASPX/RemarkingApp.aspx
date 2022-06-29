<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RemarkingApp.aspx.cs" Inherits="StudentManagementASPX.RemarkingApp" %>

<%@ Import Namespace="StudentManagementASPX" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    
    <%
        const int maxStep = 3;
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


    <div class="panel panel-primary">
        <div class="panel-heading">
            Student Remarking Application<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="Div4" runat="server"></div>
            <div id="Div5" runat="server"></div>
            <div runat="server" id="Div6"></div>
            <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">Remarking Application</h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="generalFeedback" runat="server"></div>
                        <div id="feedback" runat="server"></div>

                        <br />
                        <br />
                        <div class="row">
                            <div class="col-md-6"> 
                                <div class="form-group" style="display: none">
                                    <label>Student No:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="studentNo" />                                 
                                </div>
                                <div class="form-group">
                                    <label>Examination :</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="regNo" Placeholder="Name" OnSelectedIndexChanged="regNo_SelectedIndexChanged" />
                                 
                                    <asp:TextBox CssClass="form-control" runat="server" ID="courseId" Visible="false" />
                                </div>
                                   <div class="form-group">
                                    <label>Withdrawal Reason:</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="withdrawal" />                                  
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Exam sitting:</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="examCycle" />
                                    <%-- <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="examCycle" ErrorMessage="Please select worktype!" ForeColor="Red" />--%>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </section>
 
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


    <%
        }
        else if (myStep == 2)
        {
    %>
  <div class="panel panel-primary">
        <div class="panel-heading">
            Student Withdrawal
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="Div1"></div>
            <div class="row">
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <p>Active Booking Papers.</p>

                </div>
                <div class="col-md-12">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Booking Header</th>
                                <th>Examination </th>
                                <th>Part </th>
                                <th>Paper</th>
                                <th>Description </th>
                                <th>Amount </th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String applicationNo = Request.QueryString["applicationNo"];
                                string studentNo = Convert.ToString(Session["studentNo"]);
                                    var studentProcessingLine = nav.studentProcessingLines.Where(r => r.Document_Type == "Withdrawal" && r.Booking_Header_No == applicationNo);
                                    foreach (var line in studentProcessingLine)
                                    {
                            %>
                            <tr>

                                <td><% =line.Booking_Header_No %></td>
                                <td><% =line.Course_Id %></td>
                                <td><% =line.Part %></td>
                                <td><% =line.Paper %></td>
                                <td><% =line.Description %></td>
                                <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>
                                <td>                                   
                                         <Label class="btn btn-danger" id="button" onclick="removeLine('<%=line.Description %>','<%=line.Paper %>');"><i class="fa fa-trash"></i>Delete</Label></td>
                             
                            </tr>
                            <% 
                                    }
                                
                            %>
                        </tbody>
                    </table>
                </div>
                <div />
            </div>
        </div>


        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="step3" OnClick="step3_Click"/>
              <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="View Withdrawal Summery" ID="submitApp" OnClick="attachdoc_Click" Visible="false" />
            <div class="clearfix"></div>
        </div>
    </div>
       <%}%>

</asp:Content>
