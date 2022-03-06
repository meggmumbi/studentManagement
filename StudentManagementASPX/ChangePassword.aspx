<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="StudentManagementASPX.ChangePassword" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/logo.png">
    <title>Student Portal</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="assests/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/select2.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/style.css">
    <link rel="stylesheet" type="text/css" href="assests/css/CustomCss.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/material-dashboard-new.css">
    <link rel="stylesheet" type="text/css" href="assests/css/ladda-themeless.min.css">
   
    <link rel="stylesheet" type="text/css" href="assests/css/CustomCss.css">
</head>
<body>
    <div class="respo">
    <div class="main-wrapper">
        <div class="account-page">
            <div class="container">
                <div class="card">
                    <div class="card-header text-center backgroundcolor">
                        <h4 class="title"><i>Change Password </i></h4>
                    </div>
                    <div class="card-content">
                        <div class="account-box" style="width:1020px">
                            <div class="account-wrapper">
                                <div class="account-logo">
                                    <img src="assests/images/logo.png" width="60" height="5" alt="">
                                </div>
                                <d3iv class="row">
                                    <div id="passwordresetfeedback" style="display: none" data-dismiss="alert"></div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label">Registered Email Address: <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="txtemailaddress" value="<%=Session["EmailAddress"]%>" readonly >
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group pass_show">
                                            <label class="control-label">Old Password: <span class="text-danger">*</span></label>
                                            <input class="form-control" type="password" id="txtoldpassword" value="<%=Session["Password"]%>" readonly>
                                        </div>
                                    </div>
                                </d3iv>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group pass_show">
                                            <label class="control-label">Enter New Password: <span class="text-danger">*</span></label>
                                            <input type="password" class="form-control" id="txtnewpassword">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group pass_show">
                                            <label class="control-label">Confirm New Password: <span class="text-danger">*</span></label>
                                            <input class="form-control" type="password" id="txtconfirmnewpassword">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group text-center">
                                    <button class="btn btn-primary btn-block account-btn btn_passwordreset_Details backgroundcolor" type="button">Change Password</button>
                                </div>
                                <div class="text-center">
                                    <a href="Login.aspx">Back to Login</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        </div>
    <div class="sidebar-overlay" data-reff="#sidebar"></div>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="assests/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="assests/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="assests/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="assests/js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="assests/js/jquery.slimscroll.js"></script>
    <script type="text/javascript" src="assests/js/select2.min.js"></script>
    <script type="text/javascript" src="assests/js/moment.min.js"></script>
    <script type="text/javascript" src="assests/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="assests/js/app.js"></script>s    
    <script type="text/javascript" src="assests/customJs/sweetalert.min.js"></script>
    <script type="text/javascript" src="assests/CutsomJs/RegisterNewCandidate.js"></script>
    <script src="assests/CustomJs/ResetPassword.js"></script>
    <!-- Sweet Alert Js -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
</body>
</html>

