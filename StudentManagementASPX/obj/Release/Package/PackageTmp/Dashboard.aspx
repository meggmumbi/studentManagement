<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="StudentManagementASPX.Dashboard" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="Adminlte/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <link href="assets/css/css.css" rel="stylesheet" />




</asp:Content>


 

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

  
        <div class="row">
            <div class="card">
                <div class="card-header text-center" data-background-color="darkgreen">
                    <h3 class="title"><strong>Welcome to Student Portal</strong></h3>
                </div>
            </div>
        </div>
    <center class="center-item">
            <p style="color:black"><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
     <div class="content container-fluid">

        <!-- Small boxes (Stat box) -->

        <!-- /.row -->
        <!-- Main row -->
        <%
            if (string.IsNullOrEmpty((string)Session["studentNo"]))
            {
                var nav = Config.ReturnNav();
                string idNumb = Convert.ToString(Session["idNumber"]);
                var details = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == idNumb).ToList();

                if (details.Count > 0)
                {
                    Response.Redirect("registrationInstructions.aspx");
                }
                else
                {
               // Response.Redirect("registrationInstructions.aspx");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                }
             

                %>
         


        <div class="clearfix"></div>

        <%}


            else if (Session["studentNo"] != null)
            {
       
        
                 string IdNumber = Convert.ToString(Session["studentNo"]);
                 string application = "";
                 var nav7 = Config.ReturnNav();
                 var Registration = nav7.StudentProcessing.Where(r => r.Student_No == IdNumber && r.Document_Type == "Registration").ToList();
                 var booking = nav7.StudentProcessing.Where(r => r.Student_No == IdNumber && r.Document_Type == "Booking").ToList();
                 var renewal = nav7.StudentProcessing.Where(r => r.Student_No == IdNumber && r.Document_Type == "Renewal").ToList();
                 var exemp = nav7.StudentProcessing.Where(r => r.Student_No == IdNumber && r.Document_Type == "Exemption").ToList();

            %>
          <div id="submit" runat="server"></div>
        <div class="row">
           
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-aqua">
                    <div class="inner">
                        <h3><%=Registration.Count() %></h3>
                        <p >Examination Registration</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-bag"></i>
                    </div>
                    <a href="registrationInstructions.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-yellow">
                    <div class="inner">
                        <h3><%=exemp.Count() %></h3>
                       <p >Exemptions</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-person-add"></i>
                    </div>
                    <a href="ExemptionInstructionTest.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>         
            <div class="col-lg-3 col-xs-6">
              
                <div class="small-box bg-green">
                    <div class="inner">
                        <h3><%=booking.Count() %></h3>
                       <p>Examination Booking</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-stats-bars"></i>
                    </div>
                    <a href="ExaminationAcounts.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
           
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-red">
                    <div class="inner">
                        <h3><%=renewal.Count() %></h3>
                        <p>Renewal</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-pie-graph"></i>
                    </div>
                    <a href="Renewal.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
        </div>
        <section class="content">

            <div class="row">
                <div class="col-md-3">

                    <%--           <!-- Profile Image -->
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                            <img class="profile-user-img img-responsive img-circle" src="Adminlte/dist/img/user4-128x128.jpg" alt="User profile picture">

                            <h3 class="profile-username text-center">xx</h3>

                            <p class="text-muted text-center">xx</p>

                            <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <% =Session["StudentName"] %>
                                </li>
                                <li class="list-group-item">
                                    <% =Session["EmailAddress"] %>
                                </li>
                                <li class="list-group-item">
                                    <% =Session["idNumber"] %>
                                </li>
                            </ul>


                        </div>
                        <!-- /.box-body -->
                    </div>--%>
                    <!-- /.box -->

                    <!-- About Me Box -->

                    <!-- /.box -->
                </div>
                <!-- /.col -->
                <div class="col-md-12">
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#activity" data-toggle="tab">Examination Accounts</a></li>
                            <li><a href="#timeline" data-toggle="tab">Booked Examinations</a></li>
                            <li><a href="#settings" data-toggle="tab">Exempted examinations </a></li>
                            <li><a href="#deffered" data-toggle="tab">Deferred Papers</a></li>
                            <li><a href="#withdrawn" data-toggle="tab">Examinations Withdrawals</a></li>
                             <li><a href="#Results" data-toggle="tab">Examinations Results</a></li>
                        </ul>
                        <div class="tab-content">
                            <div class="active tab-pane" id="activity">
                                <div class="panel panel-primary">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Examination Accounts</h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="table-responsive">
                                            <table id="example1" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Registration No:</th>
                                                        <th>Examination Id</th>
                                                        <th>Examination</th>
                                                        <th>Student Name</th>
                                                        <th>Student IdNo</th>
                                                        <th>Status</th>
                                                        <th>Registration Date</th>

                                                        <%-- <th>Receipt</th>--%>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav = Config.ReturnNav();
                                                        string studentNumber = Convert.ToString(Session["studentNo"]);
                                                        //string applicationNumber = Request.QueryString["applicationNo"];
                                                        var programs = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNumber && r.Blocked==false);
                                                        foreach (var programe in programs)
                                                        {

                                                    %>
                                                    <tr>
                                                        <td><%=programe.Registration_No %></td>
                                                        <%--<td><%=program.Student_No %></td>--%>
                                                        <td><%=programe.Course_ID %></td>
                                                        <td><%=programe.Course_Description %></td>
                                                        <td><%=programe.First_Name %> <%=programe.Middle_Name %> <%=programe.Surname %></td>
                                                        <td><%=programe.ID_No %></td>
                                                        <td><%=programe.Status %></td>
                                                        <td><%=Convert.ToDateTime(programe.Registration_Date).ToString("MM/dd/yyyy") %></td>



                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                                </div>
                                        </div>
                                        <!-- /.box-body -->
                                    </div>
                                </div>

                            </div>
                            <!-- /.tab-pane -->
                            <div class="tab-pane" id="timeline">
                                <div class="panel panel-primary">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Booked Examinations</h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="table-responsive">
                                            <table id="example2" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Registration No:</th>
                                                        <th>Student Name</th>
                                                        <th>Examination ID</th>                                                                                                    
                                                        <th>Paper</th>
                                                        <th>Level</th>                                                    
                                                        
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav1 = Config.ReturnNav();
                                                        string studentNo = Convert.ToString(Session["studentNo"]);
                                                        string surrenderData = new Config().ObjNav().FnGetExamBookingEntries(studentNo, 5);
                                                        String[] info = surrenderData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                                        if (info != null)
                                                        {
                                                            foreach (var allInfo in info)
                                                            {
                                                                String[] arr = allInfo.Split('*');

                                                    %>
                                                    <tr>
                                                        <td><%=arr[0] %></td>
                                                        <td><%=arr[1] %></td>
                                                        <td><%=arr[2]%></td>
                                                        <td><%=arr[7] %></td>
                                                        <td><%=arr[3] %></td>

                                                    </tr>
                                                    <%
                                                        }
                                                    }
                                                    %>
                                                </tbody>
                                            </table>
                                            </div>
                                        </div>
                                        <!-- /.box-body -->
                                    </div>
                                </div>
                            </div>
                            <!-- /.tab-pane -->

                            <div class="tab-pane" id="settings">
                                <div class="panel panel-primary">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Exempted Papers</h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="table-responsive">
                                            <table id="example3" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Registration No:</th>
                                                        <th>Examination Id</th>
                                                        <th>Examination </th>
                                                        <th>Paper</th>
                                                        <th>Amount</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav2 = Config.ReturnNav();
                                                        string studentNumb = Convert.ToString(Session["studentNo"]);
                                                        //string applicationNumber = Request.QueryString["applicationNo"];
                                                        var exemptions = nav2.ExemptionEntries.Where(r => r.Stud_Cust_No == studentNo);
                                                        foreach (var exemption in exemptions)
                                                        {

                                                    %>
                                                    <tr>
                                                        <td><%=exemption.Stud_Reg_No %></td>
                                                        <td><%=exemption.Course_Id %></td>
                                                        <td><%=exemption.Name %></td>
                                                         <td><%=exemption.No %></td>
                                                        <td><%=exemption.Amount %></td>

                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                                </div>
                                        </div>
                                        <!-- /.box-body -->
                                    </div>
                                </div>


                            </div>

                            <div class="tab-pane" id="deffered">
                                <div class="panel panel-primary">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Deferred Papers</h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="table-responsive">
                                                <table id="example7" class="table table-bordered table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>Registration No:</th>
                                                            <th>Student Name</th>
                                                            <th>Examination ID</th>
                                                            <th>Part</th>
                                                            <th>Examination</th>
                                                            <th>Fee Amount</th>
                                                            <th>Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            var nav3 = Config.ReturnNav();
                                                            string student = Convert.ToString(Session["studentNo"]);
                                                           
                                                            string surrenderDatas = new Config().ObjNav().FnGetExamBookingEntries(studentNo, 2);
                                                            String[] infos = surrenderDatas.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                                            if (infos != null)
                                                            {
                                                                foreach (var allInfo in infos)
                                                                {
                                                                    String[] arr = allInfo.Split('*');


                                                        %>
                                                        <tr>
                                                            <td><%=arr[0] %></td>
                                                            <td><%=arr[1] %></td>
                                                            <td><%=arr[2]%></td>
                                                            <td><%=arr[3] %></td>
                                                            <td><%=arr[4] %></td>
                                                            <td><%=arr[5] %></td>
                                                            <td><%=arr[6] %></td>
                                                        </tr>
                                                        <%
                                                            }
                                                        }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <!-- /.box-body -->
                                    </div>
                                </div>


                            </div>

                            <div class="tab-pane" id="withdrawn">
                                <div class="panel panel-primary">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Examination withdrawals</h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="table-responsive">
                                                <table id="example5" class="table table-bordered table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>Registration No:</th>
                                                            <th>Student Name</th>
                                                            <th>Examination</th>
                                                            <th>Part</th>
                                                            <th>Examination</th>
                                                            <th>Fee Amount</th>
                                                            <th>Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            var nav4 = Config.ReturnNav();
                                                            string students = Convert.ToString(Session["studentNo"]);
                                                          
                                                            string surrenderDataz = new Config().ObjNav().FnGetExamBookingEntries(studentNo, 7);
                                                            String[] infoz = surrenderDataz.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                                            if (infoz != null)
                                                            {
                                                                foreach (var allInfo in infoz)
                                                                {
                                                                    String[] arr = allInfo.Split('*');

                                                        %>
                                                        <tr>
                                                            <td><%=arr[0] %></td>
                                                            <td><%=arr[1] %></td>
                                                            <td><%=arr[2]%></td>
                                                            <td><%=arr[3] %></td>
                                                            <td><%=arr[4] %></td>
                                                            <td><%=arr[5] %></td>
                                                            <td><%=arr[6] %></td>
                                                        </tr>
                                                        <%
                                                            }
                                                        }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <!-- /.box-body -->
                                    </div>
                                </div>


                            </div>
                            <!-- /.tab-pane -->
                         
                            <div class="tab-pane" id="Results">

                                   <div runat="server" id="examResults"></div>
                                <div class="row filter-row" id="ifYes">
                                    <div class="col-md-4" style="display:none">
                                        <div class="form-group form-focus">
                                            <label class="control-label">Examination</label>
                                           <asp:TextBox style="color: #FFFFFF; display: inline" runat="server" id="regNo"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-focus">
                                            <label class="control-label">Examination Sitting</label>
                                           <asp:DropDownList runat="server" CssClass="form-control select2" ID="examCycle" OnSelectedIndexChanged="examCycle_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-md-4" style="display: inline">
                                        <div class="form-group">
                                            <br />
                                            <asp:Button runat="server" CssClass="btn btn-success" Text="Result Slip" ID="resultsSlip" OnClick="resultsSlip_Click"/>
                                        </div>
                                    </div>
                                </div>

                                
                                <div id="studentAcc" runat="server" visible="true">
                                <div class="panel panel-primary">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Examination Results</h3>
                                        </div>
                                            
                                        

                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="table-responsive">
                                                <table id="example" class="table table-bordered table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Student Name</th>
                                                            <th>Examination</th>
                                                            <th>Examination Description</th>
                                                            <th>Grade </th>
                                                            <th>Examination Sitting</th>
                                                            <th>Issue Date</th>
                                                            <%-- <th>Results</th>--%>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% 

                                                            string IdNumbers = Convert.ToString(Session["idNumber"]);
                                                            var nav = Config.ReturnNav();
                                                            int programesCounter = 0;
                                                           
                                                            string surrenderData = new Config().ObjNav().FnGetExaminationResults(IdNumbers);
                                                            String[] info = surrenderData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                                            if (info != null)
                                                            {
                                                                foreach (var allInfo in info)
                                                                {
                                                                    String[] arr = allInfo.Split('*');
                                                                    programesCounter++;

                                                        %>


                                                        <tr>
                                                            <td><%=programesCounter %></td>
                                                            <td><%=arr[0] %></td>
                                                            <td><%=arr[1]%></td>
                                                            <td><%=arr[2] %></td>
                                                            <td><%=arr[3] %></td>
                                                            <td><%=arr[4] %></td>
                                                            <td><%=Convert.ToDateTime(arr[6]).ToString("yy/MM/dd") %></td>
                                                            <%-- <td><a href="ResultSlip.aspx?No=<%=detail.Student_Reg_No%>&&sitting=<%=detail.Examination_Sitting_ID %>" class="btn btn-success"><i class="fa fa-eye"></i>Result Slip</a></td>--%>
                                                        </tr>
                                                        <%  
                                                            }
                                                        } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <!-- /.box-body -->


                                    </div>
                                </div>
                                    </div>
                                  <div id="SpecificSitting" runat="server" visible="false">
                                <div class="panel panel-primary">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Examination Results</h3>
                                        </div>                                           
                                        
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                         <asp:TextBox runat="server" CssClass="form-control" ID="examSitting" Visible="false"></asp:TextBox>
                                            <div class="table-responsive">
                                                <table id="example" class="table table-bordered table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Student Name</th>
                                                            <th>Examination</th>
                                                            <th>Examination Description</th>
                                                            <th>Grade </th>
                                                            <th>Examination Sitting</th>
                                                            <th>Issue Date</th>
                                                            <%-- <th>Results</th>--%>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% 

                                                            string IdNumbers = Convert.ToString(Session["idNumber"]);
                                                            var nav = Config.ReturnNav();
                                                            string examsittings = examSitting.Text.Trim();
                                                            var details = nav.ExaminationResults.Where(r => r.National_ID_No == IdNumbers && r.Examination_Sitting_ID==examsittings);
                                                            //string university = Convert.ToString(Session["UniversityCode"]);
                                                            int programesCounter = 0;
                                                            foreach (var detail in details)
                                                            {
                                                                programesCounter++;
                                                        %>
                                                        <tr>
                                                            <td><%=programesCounter %></td>
                                                            <td><%=detail.Student_Name %></td>
                                                            <td><%=detail.Paper%></td>
                                                            <td><%=detail.Paper_Name %></td>
                                                            <td><%=detail.Grade %></td>
                                                            <td><%=detail.Examination_Sitting_ID +" "+ detail.Financial_Year %></td>
                                                            <td><%=Convert.ToDateTime(detail.Issue_Date).ToString("yy/MM/dd") %></td>
                                                            <%-- <td><a href="ResultSlip.aspx?No=<%=detail.Student_Reg_No%>&&sitting=<%=detail.Examination_Sitting_ID %>" class="btn btn-success"><i class="fa fa-eye"></i>Result Slip</a></td>--%>
                                                        </tr>
                                                        <%  
                                                        } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <!-- /.box-body -->


                                    </div>
                                </div>
                                    </div>

                          </div>
                            <!-- /.tab-content -->
                        </div>

                        <!-- /.nav-tabs-custom -->

                        <!-- /.col -->
                    </div>
                </div>

                <!-- /.row -->
            </div>
        </section>
        <%} %>
    </div>

     

    <script type="text/javascript">
        function viewsections(code) {
            document.getElementById("MainContent_courseCode").value = code;
            $("#view").modal();
        }
    </script>
       <script type="text/javascript">
        function yesnoCheck(that) {
            if (that.value == "yes") {               
                document.getElementById("ifYes").style.display = "block";
            } else {
                window.location.replace("registrationInstructions.aspx");
                //document.getElementById("ifYes").style.display = "none";
            }
        }
    </script>
    

        <script type="text/javascript">
   

        function ExaminationAccounts() {
            $('#plogsActivities').modal({ show: true, backdrop: 'static', keyboard: false });
        }

        function openModal() {
            $('#removeLineModal').modal({show: true, backdrop: 'static', keyboard: false  });
        }


  
        </script>
    <div id="removeLineModal" class="modal fade" role="dialog">


        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div id="generalFeedback" runat="server"></div>
                <div class="modal-header">
                   
                    <h4 class="modal-title">Please Answer the following Question</h4>
                </div>
                <div id="account" runat="server">
                <div class="modal-body">
                    <label>Do you have a kasneb examination registration Number? <span class="text-danger">*</span></label>
                    <select onchange="yesnoCheck(this);" id="cars" class="form-group" style="width:100%;min-width:15ch;max-width:30ch;border: 1px solid;border-radius: 0.25em;padding: 0.25em 0.5em;font-size: 1.25rem;cursor: pointer;line-height: 1.1;background-color: #fff;background-image: linear-gradient(to top, #f9f9f9, #fff 33%);">
                        <option>--select--</option>
                        <option value="yes">Yes</option>
                        <option value="No">No</option>

                    </select>
                    <div id="ifYes" style="display: none;">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="idnumber">Examination <span class="text-danger">*</span></label>
                                    <asp:DropdownList runat="server" CssClass="form-control select2" MaxLength="11" ID="examinationIDs"></asp:DropdownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="email address">Registration Number</label>
                                    <asp:TextBox runat="server" TextMode="Number" CssClass="form-control" ID="RegistrationNo"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <center>

                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Next" ID="studentAccounts" OnClick="studentAccounts_Click" />
                                   </center>
                        </div>
                    </div>
                </div>

                <div class="modal-footer" style="display:none">
                    <asp:Button runat="server" CssClass="btn btn-default" Text="Cancel" ID="cancel" OnClick="cancel_Click" />

                </div>
            </div>

        </div>


    </div>
        </div>



    <div id="plogsActivities" class="modal fade" role="dialog">
        <asp:ScriptManager ID="ScriptManager1" runat="Server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                          <div id="feedback" runat="server"></div>
                        <div class="modal-header">
                           
                            <h4 class="modal-title">List of All Examinations Accounts </h4>
                        </div>
                        <div class="modal-body">

                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <strong>Examination :</strong>
                                            <asp:TextBox runat="server" ID="ExamId" CssClass="form-control select2 ExamPapers" />
                                        </div>
                                        </div>
                                    </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <strong>Examination Registration No</strong>
                                                    <asp:TextBox runat="server" ID="ExamRegNo" CssClass="form-control select2 ApplicationNo" />

                                                </div>
                                            </div>
                                        </div>

                                <div class="row">
                                    <div runat="server" id="generalfeedbacks"></div>
                                    <input type="hidden" value="<% =Convert.ToString(Session["idNumber"]) %>" id="txtLevel" />

                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped selectedprequalificationsWorks" id="example3">
                                            <thead>
                                                <tr>
                                                    
                                                    <th>Student No</th>
                                                    <th>First Name</th>
                                                    <th>Middle Name</th>
                                                    <th>Sir Name</th>
                                                    <th>Examination Id</th>
                                                    <th>Examination</th>                                                   
                                                    <th>Confirm Examination Account</th>
                                                     <th>Reject</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <% 
                                                    var nav6 = Config.ReturnNav();                                                    
                                                    string tcourseId = ExamId.Text.Trim();
                                                    string RegNo = ExamRegNo.Text.Trim();
                                                    var examAccounts = nav6.ExaminationAccounts.Where(x => x.Course_ID == tcourseId && x.Registration_No == RegNo ).ToList();

                                                    foreach (var nbpaperz in examAccounts)

                                                    {
                                                %>
                                                <tr>                                                
                                                    
                                                    <td><% =nbpaperz.Student_Cust_No %></td>
                                                    <td><% =nbpaperz.First_Name %></td>
                                                    <td><% =nbpaperz.Middle_Name %></td>                                                   
                                                    <td><% =nbpaperz.Surname %></td>
                                                    <td><% =nbpaperz.Course_ID %></td>
                                                    <td><% =nbpaperz.Course_Description %></td>

                                                    <td>
                                                        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Confirm Account" ID="confirmCoount" OnClick="confirm_Click" /></td>
                                                    <td>
                                                        <asp:Button runat="server" CssClass="btn btn-danger pull-right" Text="Reject" id="reject" OnClick="reject_Click" /></td>


                                                    <%
                                                    } %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <%-- <div class="col-md-12 col-lg-12">
                                <input type="button" id="btn_apply_SubmitTargets" class="btn btn-success btn_apply_SubmitTargets" name="btn_apply_SubmitTargets" value="Submit Selected papers" />
                            </div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

