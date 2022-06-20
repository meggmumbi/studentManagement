<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Defferment.aspx.cs" Inherits="StudentManagementASPX.Defferment" %>
<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="StudentManagementASPX.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <%
        const int maxStep = 4;
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
            Student Deferment Application<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="Div4" runat="server"></div>
            <div id="Div5" runat="server"></div>
            <div runat="server" id="Div6"></div>




            <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">Student Deferment</h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="generalFeedback" runat="server"></div>
                        <div id="feedback" runat="server"></div>

                        <br />
                        <br />
                        <div class="row">

                            <div class="col-md-6">
                               <%-- <div class="form-group">
                                    <label>Date:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="Date" TextMode="Date" />
                                    <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="Date" ErrorMessage="Please enter the Phone Number!" ForeColor="Red" />
                                </div>--%>

                                <div class="form-group" style="display: none">
                                    <label>Student No:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="studentNo" />
                                    <%--  <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="studentNo" ErrorMessage="Please enter the Phone Number!" ForeColor="Red" />--%>
                                </div>


                                <div class="form-group">
                                    <label>Examination :</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="regNo" Placeholder="Name" OnSelectedIndexChanged="regNo_SelectedIndexChanged" />
                                    <%-- <asp:RequiredFieldValidator runat="server" ID="phone" ControlToValidate="regNo" ErrorMessage="Please enter the Phone Number!" ForeColor="Red" />--%>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="courseId" Visible="false" />
                                </div>
                                   <div class="form-group">
                                    <label>Deferment Reason:</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="withdrawal" />
                                    <%--  <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="withdrawal" ErrorMessage="Please select worktype!" ForeColor="Red" />--%>
                                </div>



                            </div>


                            <div class="col-md-6">


                             

                                <div class="form-group">
                                    <label>Exam sitting:</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="examCycle" />
                                    <%-- <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="examCycle" ErrorMessage="Please select worktype!" ForeColor="Red" />--%>
                                </div>

                                <div class="form-group">
                                    <label>Preferred Examination Sitting:</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="examCenter" Placeholder="Name" />
                                    <%--  <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="examCenter" ErrorMessage="Please enter the Proposed Name!" ForeColor="Red" />--%>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </section>
 <%--           <center>
               
                
               <asp:Button runat="server" CssClass="btn btn-primary" Text="Save Details" OnClick="next_Click"/>
            </center>--%>
           <%-- <table id="example2" class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>
                        <th>Student Name</th>
                        <th>Deferment Reason</th>
                        <th>Examination</th>
                        <th>Edit</th>
                        <th>Proceed</th>

                    </tr>
                </thead>
                <tbody>
                    <% 

                        string IdNumber = Convert.ToString(Session["idNumber"]);


                        var details = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber && r.Document_Type == "Defferment" && r.Approval_Status == "Open");
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
                        <td><%=detail.Withdrawal_Reason %></td>
                        <td><%=detail.Examination_Description %></td>
                        <td class="btn btn-success"><i class="fa fa-eye">Edit</i></td>
                        <td><a href="Defferment.aspx?step=2&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Examination_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>proceed</a></td>
                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>--%>
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
            Student Deferment
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

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String applicationNo = Request.QueryString["applicationNo"];
                               
                                    var studentProcessingLine = nav.studentProcessingLines.Where(r => r.Document_Type == "Defferment" && r.Booking_Header_No == applicationNo);
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
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="step3" OnClick="step3_Click" />
           

            <div class="clearfix"></div>
        </div>
    </div>
  


    <%
        }
        else if (myStep == 3)
        {
    %>
     <div class="panel-default setup-content" id="step-10">
        <div class="panel-heading">
            Mandatory Documents
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>

        </div>
           <div runat="server" id="attach"></div>
        <div id="completefeedback" runat="server"></div>
        <div class="panel-body">
            <ul class="nav nav-tabs">
                <li class="active" style="background-color: gray">
                    <a href="#tab_1_documents" data-toggle="tab">
                        <p style="color: black">Defferment Document Attachments</p>
                    </a>
                </li>
            <%--    <li style="background-color: gray">
                    <a href="#tab_1_attach" data-toggle="tab">
                        <p style="color: black">Attach Document </p>
                    </a>
                </li>--%>
                <%--         <li style="background-color:gray">
                    <a href="#tab_1_attached" data-toggle="tab"><p style="color:black">Attached Document </p></a>
                </li>--%>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="tab_1_documents">
                    <div class="row">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>You are to submit scanned copies of the following sets of documents, as part of your Withdrawal process. Click on the submit Documents button, when ready to attach the supporting documents.</p>

                        </div>
                        <div class="progress progress-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                            <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                        </div>
                         <div class="col-md-12">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" id="txtapplicationNo" class="txtapplicationNo" />
                            <asp:TextBox runat="server" ID="template" CssClass="form-control" Visible="false"></asp:TextBox>
                            <div class="table-responsive">
                                              <table class="table table-striped custom-table datatable" id="example2">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Document Type</th>
                                            <th>Description</th>
                                            <th>Requirement Type</th>
                                            <th>Attach Document</th>
                                        </tr>

                                    </thead>
                                    <tbody>
                                        <% 
                                            string courseId = Request.QueryString["courseId"];
                                            var details = nav.AttachDocuments.Where(r => r.Template_No == template.Text  && r.Examination_Process == "Defferment" && r.Examiantion_ID == courseId).ToList();
                                            int programesCounter = 0;
                                            int counter = 0;
                                            foreach (var detail in details)
                                            {

                                                counter++;
                                                programesCounter++;
                                        %>
                                        <tr>
                                            <td><%=programesCounter %></td>
                                            <td><%=detail.Examination_Document_Type %></td>
                                            <td><%=detail.Description %></td>
                                            <td><%=detail.Requirement_Type %></td>
                                            <td>
                                               <label class="btn btn-success" onclick="studentattachdocuments('<%=detail.Entry_No %>');">Attach Document</label>
                                            </td>
                                        </tr>
                                        <%  
                                            } %>
                                    </tbody>
                                </table>
                                </div>
                                
                                <br />
                                <br />
                                  <div class="box-header">
                                        <h3 class="box-title">Attached Documents</h3>
                                    </div>
                             <div class="table-responsive">
                                  <table class="table table-bordered table-striped" id="example7">
                                <thead>
                                    <tr>
                                        <th>Document Title</th>
                                        <%--<th>Download</th>--%>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                                        try
                                        {%>
                                    <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
                                        {
                                            // var vendorNo = Convert.ToString(Session["vendorNo"]);
                                            String leaveNo = Request.QueryString["applicationNo"];
                                            string password = ConfigurationManager.AppSettings["S_PWD"];
                                            string account = ConfigurationManager.AppSettings["S_USERNAME"];
                                            string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                                            var secret = new SecureString();



                                            foreach (char c in password)
                                            {
                                                secret.AppendChar(c);
                                            }

                                            ctx.Credentials = new NetworkCredential(account, secret, domainname);
                                            ctx.Load(ctx.Web);
                                            ctx.ExecuteQuery();
                                            List list = ctx.Web.Lists.GetByTitle("Student Portal");

                                            //Get Unique rfiNumber
                                            string uniqueLeaveNumber = leaveNo;

                                            ctx.Load(list);
                                            ctx.Load(list.RootFolder);
                                            ctx.Load(list.RootFolder.Folders);
                                            ctx.Load(list.RootFolder.Files);
                                            ctx.ExecuteQuery();

                                            FolderCollection allFolders = list.RootFolder.Folders;
                                            foreach (Folder folder in allFolders)
                                            {
                                                if (folder.Name == "KASNEB")
                                                {
                                                    ctx.Load(folder.Folders);
                                                    ctx.ExecuteQuery();
                                                    var uniquerfiNumberFolders = folder.Folders;

                                                    foreach (Folder folders in uniquerfiNumberFolders)
                                                    {
                                                        if (folders.Name == "Deferment")
                                                        {
                                                            ctx.Load(folders.Folders);
                                                            ctx.ExecuteQuery();
                                                            var uniquevendorNumberSubFolders = folders.Folders;

                                                            foreach (Folder vendornumber in uniquevendorNumberSubFolders)
                                                            {
                                                                if (vendornumber.Name == uniqueLeaveNumber)
                                                                {
                                                                    ctx.Load(vendornumber.Files);
                                                                    ctx.ExecuteQuery();

                                                                    FileCollection vendornumberFiles = vendornumber.Files;
                                                                    foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                                    {%>
                                    <% ctx.ExecuteQuery();
                                        alldocuments.Add(new SharePointTModel { FileName = file.Name });
                                        alldocuments.ToList();
                                    %>


                                    <% }%>

                                    <%
                                        foreach (var item in alldocuments)
                                        {%>
                                    <tr>
                                        <td><% =item.FileName %></td>
                                        <td>
                                            <label class="btn btn-danger" onclick="deleteFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                    </tr>
                                    <% }
                                    %>

                                    <%  }

                                                                }


                                                            }
                                                        }

                                                    }
                                                }

                                            }

                                        }
                                        catch (Exception t)
                                        {

                                            completefeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                              "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        }

                                    %>
                                </tbody>

                                  </table>
                             </div>
                         </div>
                    </div>

                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="prevstep1" OnClick="prevstep1_Click" />
                    <%
                        if (alldocuments.Count >= details.Count)
                        {
                            attachdoc.Visible = true;
                        }

                    %>
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit Application" ID="attachdoc" OnClick="attachdoc_Click" Visible="false" />

                </div>

                <div class="tab-pane fade" id="tab_1_attach">
                    <div id="keydocumentsuploadfeedback" style="display: none" data-dismiss="alert"></div>
                    <!-- The global progress bar -->
                    <div class="progress progress-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                        <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>This Section enables you to upload scanned copies of the supporting documents as part of this Booking process.</p>
                        </div>
                        <div class="panel-body col-lg-12">
                            <div id="Div14" runat="server"></div>
                            <div class="row">
                                   <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Document Type:</strong>
                                       <asp:DropDownList runat="server" CssClass="form-control" ID="DocType"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control" ID="uploadsDoc"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="fileuploads"/>
                                    </div>
                                </div>
                            </div>
                          <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Document Title</th>
                                        <th>Download</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        try
                                        {
                                            String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Student Processing Header/";
                                            String applicationNo = Request.QueryString["applicationNo"].Trim();
                                            applicationNo = applicationNo.Replace('/', '_');
                                            applicationNo = applicationNo.Replace(':', '_');
                                            String documentDirectory = filesFolder + applicationNo + "/";
                                            if (Directory.Exists(documentDirectory))
                                            {
                                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                                {
                                                    String url = documentDirectory;
                                    %>
                                    <tr>
                                        <td><% =file.Replace(documentDirectory, "") %></td>

                                        <td><a href="<%=fileFolderApplication %>\Non-Project Purchase Order\<% =applicationNo + "\\" + file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                                        <td>
                                            <label class="btn btn-danger" onclick="deleteOrganizationFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                    </tr>
                                    <%
                                                }
                                            }
                                        }
                                        catch (Exception)
                                        {

                                        }%>
                                </tbody>
                            </table>
                              </div>

                        </div>


                    </div>
                   
                </div>

            </div>

        </div>

         <div class="panel-footer">
            
             <%-- <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Button1" />
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Request" ID="sendApproval" /><div class="clearfix"></div>--%>
         </div>
     </div>

    <%}
        else if (myStep == 4)
        {
    %>
    <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">

            <div class="panel-heading">
                <i class="icon-file"></i>
                Payment
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">DashBoard </a></li>
                            <li class="breadcrumb-item active">Payment </li>
                        </ol>
                    </div>
                </div>
                <div id="PaymentsMpesa" runat="server"></div>

                <br />
                <div class="row">

                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="tab_1_1" style="width: 100%">
                            <div class="row">
                                <div id="openTenderfeedback" runat="server"></div>
                                <div class="col-md-12">

                                    <section class="accordion-section clearfix mt-3" aria-label="Question Accordions">
                                        <div class="container">

                                            <h3>Payment </h3>
                                            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading p-3 mb-3" role="tab" id="heading0">
                                                        <h3 class="panel-title">
                                                            <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse0" aria-expanded="true" aria-controls="collapse0">Mpesa
                                                            </a>
                                                        </h3>
                                                    </div>
                                                    <div role="tabpanel" aria-labelledby="heading0">
                                                        <div class="panel-body px-3 mb4">
                                                        <div class="container">
                                                            <div class="row">
                                                                <div class="col-xs-12">                                                                    
                                                                   <h3><strong>Payment Instructions</strong></h3>                                                                        
                                                                                
                                                                  
                                                                        <div>
                                                                            <div class="panel-body">
                                                                                <div class="panel-body px-3 mb-4">
                                                                                   
                                                                                   <center><img class="imgMpesa" src="assets/img/stkMpesa.png" />
                                                                                     <p></p><h4><strong>Please ensure you have the following ready to make payment</strong></h4></center> 
                                                                                    <ol type="1">
                                                                                       <li>Enough funds in your Mpesa account.</li>
                                                                                        <li>The Correct Mpesa pin code.</li>
                                                                                        <li>Use a Safaricom sim not older than 3 years</li>
                                                                                        <li>Account No. <strong><%=Request.QueryString["applicationNo"] %> </strong></li>
                                                                                        <li>Amount <strong>
                                                                                            <p runat="server" style="display: inline" id="AmountInstructions"></p>
                                                                                        </strong></li>
                                                                                        <li>Make sure you have the phone you are making payment with.</li>
                                                                                        <li>You will be prompted to enter your Mpesa Pin to complete the payment</li>
                                                                                    </ol>
                                                                                    <p style="text-align:center">NB: You have to wait for the Mpesa Pop Up message to confirm your payment. Should you wish to retry your transaction please wait for a period of 3 minutes.
                                                                                    </p>
                                                                                    <div class="panel-footer">
                                                                                        <label class="btn btn-success" onclick="makePayments('<%=Request.QueryString["applicationNo"]%>')"><i class="fa fa-money"></i>Pay Now</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                                    <div class="panel panel-default">
                                                                        <div class="panel-heading p-3 mb-3" role="tab" id="heading2">
                                                                            <h3 class="panel-title">
                                                                                <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="true" aria-controls="collapse2">Manual Payment Instructions (Pay Later)
                                                                                </a>
                                                                            </h3>
                                                                        </div>
                                                                        <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
                                                                            <div class="panel-body px-3 mb-4">
                                                                                <div>
                                                                                    <div class="panel-body">
                                                                                 <div class="panel-body px-3 mb-4">
                                                                                    
                                                                                     <img src="assets/img/paybill-number.jpg" style="width: 150px; height: 90px" />
                                                                                     <div class="col-lg-12">
                                                                                         <div class="form-group">                                                                                                                                                                                       <br />
                                                                                             <asp:CheckBox runat="server" ID="CheckBox1" />
                                                                                             <label class="font-noraml" for="acceptTerms">Pay Later.</label>
                                                                                         </div>
                                                                                     </div>
                                                                                     <ol type="1">
                                                                                         <li>Go to MPESA</li>
                                                                                         <li>Lipa na Mpesa</li>
                                                                                         <li>Paybill Option</li>
                                                                                         <li>Paybill No: <strong>204777</strong></li>
                                                                                         <li>Account No. <strong><%=Request.QueryString["applicationNo"] %> </strong></li>
                                                                                         <li>Amount <strong>
                                                                                             <p runat="server" style="display: inline" id="AmountInstructionsManual"></p>
                                                                                         </strong></li>
                                                                                         <li>Make sure you have the phone you are making payment with.</li>
                                                                                         <li>You will be prompted to enter your Mpesa Pin to complete the payment</li>
                                                                                     </ol>

                                                                                 </div>
                                                                             </div>
                                                                         </div>


                                                                </div>
                                                            </div>
                                                        </div>
                                                                   
                                                           
                                                <div class="panel panel-default" style="display: none">
                                                    <div class="panel-heading p-3 mb-3" role="tab" id="heading2">
                                                        <h3 class="panel-title">
                                                            <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="true" aria-controls="collapse2">Other Modes of Payment

                                                            </a>
                                                        </h3>
                                                    </div>
                                                    <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
                                                        <div class="panel-body px-3 mb-4">
                                                            <div id="modalPay" role="dialog">

                                                                <div class="row">
                                                                    <div class="panel-heading">
                                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                        <h4 class="modal-title">Confirm Examination registration Payment</h4>
                                                                    </div>
                                                                    <div class="panel-body">

                                                                        <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                                                                        <div class="form-group">
                                                                            <strong>Application Number:</strong>
                                                                            <asp:TextBox runat="server" CssClass="form-control" ID="accreditationnumber" />

                                                                        </div>

                                                                        <div class="form-group">
                                                                            <strong>Payment Mode:</strong>
                                                                            <asp:DropDownList runat="server" CssClass="form-control" ID="paymentsM" />
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <strong>Payment Document:</strong>
                                                                            <asp:FileUpload runat="server" ID="paymentdocument" CssClass="form-control" Style="padding-top: 0px;" />
                                                                            <%-- <asp:RequiredFieldValidator runat="server" ID="payments" ControlToValidate="paymentdocument" ErrorMessage="Please attach the Payment Document!" ForeColor="Red" />--%>
                                                                            <div class="form-group">
                                                                                <strong>Payment Reference Number:</strong>
                                                                                <asp:TextBox runat="server" CssClass="form-control" ID="paymentsref" placeholder="Payment Reference Number" />
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                    <div class="panel-footer">
                                                                        <%-- <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>--%>
                                                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payments" ID="makePayments" OnClick="makePayments_Click" EnableViewState="true" />
                                                                    </div>
                                                                </div>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                </div>
                                            </div>
                 
                                    </section>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>



        </div>
    </div>
    <div class="clearfix"></div>



    <%} %>
      <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainContent_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
           <script type="text/javascript">
           function studentattachdocuments(entryNo) {
            $("#DocumentsAttach").modal();
        }
    </script>
            <script>


        $(document).ready(function () {


        });
    </script>
    <script>
        function makePayments(no) {
            document.getElementById("MainContent_ApplicationNo").value = no;

            $("#MakepaymentsModal").modal();
        }
    </script>
         <div id="DocumentsAttach" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Attach the Document</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                      <strong>Upload Document</strong><span class="text-danger" style="font-size:25px">*</span>
                          <asp:FileUpload runat="server" CssClass="form-control" ID="uploadfile" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button1" OnClick="UploadDocuments_Click" />
                </div>
            </div>

        </div>
    </div>
        <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>


    <div id="MakepaymentsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Registration Payments</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="TextBox3" type="hidden" />
                    <div class="form-group">
                        <strong>Application Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="ApplicationNo" placeholder="Institution Accreditation Number" ReadOnly="true" />

                    </div>
                    <div class="form-group">
                        <strong>Amount:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="Amount" ReadOnly="true" />
                    </div>
                    <div class="form-group">
                        <strong>Phone Number:</strong>
                        <asp:TextBox runat="server" TextMode="Number" CssClass="form-control" ID="PhoneNumberPay" />
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payment" ID="SubmitPayment" OnClick="SubmitPayment_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
