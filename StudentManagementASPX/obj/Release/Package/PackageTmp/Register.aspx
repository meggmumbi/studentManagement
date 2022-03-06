<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="StudentManagementASPX.Register" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>Register</title>
    <link href="assests/css/register.css" rel="stylesheet" /> 
    <link rel="stylesheet" href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css'>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css'>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
     <script type="text/javascript">
        function ShowPopup() {
            $("#btnShowPopup").click();
        }
    </script>
</head>
<body>
    <!-- MultiStep Form -->
    <!-- MultiStep Form -->
   
    <div class="container-fluid" id="grad1">
        <div class="row justify-content-center mt-0">
            <div class="col-11 col-sm-9 col-md-7 col-lg-6 text-center p-0 mt-3 mb-2">
                <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
                    <h2><strong>Sign Up your User Account</strong></h2>
                    <p>Fill all form fields to go to next step</p>
                    <div class="row">
                        <div class="col-md-12 mx-0">
                            <form id="msform">
                                <!-- progressbar -->
                                <ul id="progressbar">
                                    <li class="active" id="account"><strong>Account</strong></li>
                                    <li id="personal"><strong>Address</strong></li>
                                    <li id="payment"><strong>Identity</strong></li>                                    
                                    <li id="confirm"><strong>Finish</strong></li>
                                </ul> <!-- fieldsets -->
                                <fieldset>
                                    <div class="form-card">
                                        <h2 class="fs-title">Personal Information</h2> <p style="color:skyblue">(Fill your name as it appears on your National ID/ Birth certificate/ Passport)</p>                          
                                        <input type="text" name="firstName" id="firstName" placeholder="Full Name" style="text-transform: uppercase" />
                                  <%--      <input type="text" name="MiddleName" id="middlname" placeholder="Middle Name " />
                                        <input type="text" name="LastName" id="lastname" placeholder="Last Name" />   --%>                                                              
                                    </div><a href="Login.aspx">Back to Login</a> <input type="button" name="next" class="next action-button" value="Next Step" />
                                </fieldset>
                                <fieldset>
                                    <div class="form-card">
                                    <h2 class="fs-title">Communication Information</h2> 
                                    <input type="text" name="phonenumber" placeholder="Phone Number" id="phonenumber" />
                                   <%--  <input type="text" name="country" placeholder="country" id="country" /> --%>
                                     <input type="text" name="email" placeholder="Email" id="email" style="text-transform:lowercase" />
                                    
                                    </div> <input type="button" name="previous" class="previous action-button-previous" value="Previous" />
                                     <input type="button" name="next" class="next action-button" value="Next Step" />
                                </fieldset>
                                <fieldset>
                                    <div class="form-card">
                                        <%--  <h3 class="fs-title">Id Number</h3>     --%>
                                        <input type="text" name="idNumber" placeholder="ID/Passport/Birth certificate No" id="idNumber" />
                                       
                                       
                                    </div>
                                    <input type="button" name="previous" class="previous action-button-previous" value="Previous" />
                                        <input type="button"  class="next action-button btn_accountcreation" value="Register"/>
                                   
                               </fieldset>
                                <fieldset>
                                    <div class="form-card">
                                        <h2 class="fs-title text-center"></h2><br />
                                        <div class="row justify-content-center">
                                           
                                           <%-- <div class="col-3"><img src="assests/images/images.png" class="fit-image" style="width:40px; height:35px"> </div>--%>
                                        </div>
                                        <div class="row justify-content-center">
                                            <div class="col-6 text-center">
                                                <h5>Try signing Up again</h5>
                                                <a href="Login.aspx">Back to Login</a>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="assests/javascript/sweetalert.min.js"></script>  
    <script src="assests/CustomJs/RegisterStudent.js"></script>
    <script src="assests/javascript/register.js"></script>

</body>
    <script>
        function yesnoCheck(that) {
            if (that.value == "yes") {
                alert("check");
                document.getElementById("ifYes").style.display = "block";
            } else {
                document.getElementById("ifYes").style.display = "none";
            }
        }
    </script>
</html>

