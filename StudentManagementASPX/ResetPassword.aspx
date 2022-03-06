<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="StudentManagementASPX.ResetPassword" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" type="image/x-icon" href="assests/images/logo.png">
    <title>Student Management</title>
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
    <link rel="stylesheet" href="assests/css/customFooter.css">
    <link rel="stylesheet" type="text/css" href="assests/css/CustomCss.css">
</head>
<body>
    <div class="respo">
    <div class="main-wrapper">
        <div class="account-page">
            <div class="container">
                <div class="card">
                    <div class="card-header text-center" data-background-color="#0071ad">
                        <h4 class="title"><i>Reset Portal Password</i></h4>
                    </div>
                    <div class="card-content">
                        <div class="account-box" style="width:620px">
                            <div class="account-wrapper">
                                <div class="account-logo">
                                    <a href="Login.aspx"><img src="assests/images/logo.png" width="60" height="60"></a>
                                </div>
                                <div id="resetpassfeedback" style="display: none" data-dismiss="alert"></div>
                                <p><strong> Enter a Valid Email Address:</strong></p>
                                <div class="form-group form-focus">
                                    <input class="form-control floating" type="text" id="txtemailresetaddress">
                                </div>
                                <div class="form-group">
                                    <div class="row">

                                        <div class="col-md-4 col-lg-4">
                                            <a href="Login.aspx" class="btn btn-danger">
                                                Cancel
                                            </a>
                                        </div>
                                        <div class="col-md-8 col-lg-8">
                                            <button class="btn btn-primary ladda-button btn_reset_passord" type="button" data-style="slide-right" data-background-color="darkgreen">
                                                <span class="ladda-label">
                                                    Reset Password
                                                </span>
                                            </button>
                                        </div>
                                    </div>
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
    <script src="assests/js/jquery-3.2.1.min.js"></script>    
    <script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="assets/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="assets/js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="assets/js/jquery.slimscroll.js"></script>
    <script type="text/javascript" src="assets/js/select2.min.js"></script>
    <script type="text/javascript" src="assets/js/moment.min.js"></script>
    <script type="text/javascript" src="assets/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="assets/js/app.js"></script>
    <script type="text/javascript" src="assets/customJs/supplierRegistration.js"></script>
    <script type="text/javascript" src="assets/customJs/sweetalert.min.js"></script>
    <script type="text/javascript" src="assets/CutsomJs/RegisterNewCandidate.js"></script>
  
    <script src="assests/CustomJs/ResetPassword.js"></script>
    <!-- Sweet Alert Js -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
</body></html>

