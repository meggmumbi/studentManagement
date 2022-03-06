<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Intitutional.aspx.cs" Inherits="StudentManagementASPX.Intitutional" %>
<%@ Import Namespace="StudentManagementASPX" %>
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


    <div class="panel panel-primary">
        <div class="panel-heading">
           Institution Examination Booking<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div id="feedback" runat="server"></div>
            <div runat="server" id="linesFeedback"></div>


            <div class="row">

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Date:</label>
                        <asp:TextBox CssClass="form-control" runat="server" TextMode="DateTime" ID="bulkDate" required />

                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Institution Name :</label>
                        <asp:DropDownList CssClass="form-control" runat="server" ID="institution" required />

                    </div>
                </div>

          
            </div>
            <div class="row">

            <%--    <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Work type:</label>
                        <asp:DropDownList CssClass="form-control" runat="server" ID="worktype" Placeholder="Name" required />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="worktype" ErrorMessage="Please select worktype!" ForeColor="Red" />

                    </div>
                </div>--%>


           

            </div>

           
  
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
           Exemptions
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="Div1"></div>


            <div class="row">


                 <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Registration Number:</label>
                        <asp:DropDownList CssClass="form-control" runat="server" ID="regNo" Placeholder="Name" OnSelectedIndexChanged="regNo_SelectedIndexChanged" />
                        <asp:RequiredFieldValidator runat="server" ID="phone" ControlToValidate="regNo" ErrorMessage="Please enter the Phone Number!" ForeColor="Red" />

                    </div>
                </div>

                  <div class="col-md-4 col-lg-4">
                    <div class="form-group">
                        <label>Exam Id:</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="examId" required />

                    </div>
                </div>
                </div>
            <div class="row">

                  <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Examination:</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="examination" required />

                    </div>
                </div>



                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Booking Type:</strong>
                        <asp:DropDownList runat="server" ID="bulkBooking" CssClass="form-control select2" OnSelectedIndexChanged="bulkBooking_SelectedIndexChanged"  AutoPostBack="True">
                            <asp:ListItem>Select</asp:ListItem>
                            <asp:ListItem Value="0">Section</asp:ListItem>
                            <asp:ListItem Value="1">Paper</asp:ListItem>   
                             <asp:ListItem Value="2">Part</asp:ListItem>                            
                        </asp:DropDownList>

                    </div>
                </div>
                </div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Part:</strong>
                        <asp:DropDownList runat="server" ID="part" CssClass="form-control select2" />
                    </div>
                </div>
           
                    
                 <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>section:</strong>
                        <asp:DropDownList runat="server" ID="section" CssClass="form-control select2" OnSelectedIndexChanged="section_SelectedIndexChanged"/>
                    </div>
                </div>
                </div>

            <div class="row">
                    <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Subject:</strong>
                        <asp:DropDownList runat="server" ID="paper" CssClass="form-control select2" OnSelectedIndexChanged="paper_SelectedIndexChanged" />
                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Exam Project</strong>
                        <asp:DropDownList runat="server" ID="examProject" CssClass="form-control select2" />

                    </div>
                </div>

          </div>
           <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add student" ID="addItem" OnClick="addItem_Click" />
                    </div>
                </div>
            </div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Booking Header</th>
                        <th>Examination </th>
                        <th>Section</th>
                        <th>Part </th>
                        <th>Paper</th>
                        <th>Description </th>
                        <th>Amount </th>
                        <th>Remove </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String applicationNo = Request.QueryString["applicationNo"];
                      
                        var bulkprocessingLine = nav.BulkProcessLines.Where(r => r.Bulk_Header_No == applicationNo && r.Document_Type=="Booking");
                        foreach (var line in bulkprocessingLine)
                        {
                    %>
                    <tr>

                        <td><% =line.Bulk_Header_No%></td>
                        <td><% =line.Course_ID %></td>
                        <td><% =line.Section %></td>
                        <td><% =line.Part %></td>
                        <td><% =line.Paper %></td>
                        <td><% =line.Course_Description %></td>                      
                        <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>

                        <td>
                            <label class="btn btn-danger" onclick="removeLine('<% =line.Description %>','<%=line.Line_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                    </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click"/>
          <%--  <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" />--%>

            <div class="clearfix"></div>
        </div>
    </div>
    <%} %>



</asp:Content>
