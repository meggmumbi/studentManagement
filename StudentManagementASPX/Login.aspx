<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="StudentManagementASPX.Login" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" type="image/x-icon" href="assests/images/logo.png">   
    <title>Login - Student Management</title>
    <link href="assests/css/login.css" rel="stylesheet" />
  


    <link href='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'/>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
</head>
<body>
    <div class="formwrap">
           <div class="mid-wrap">
        <form id="form1" runat="server" class="float-left">
 
        <div id="container" >
                  <div class="panel-body">
       
                      </div>
             <div id="feedback" runat="server"></div>
            <div id="formcontainer"> 
                <div class="form-logo">
                    <img id="img1" src="images/Frame.svg" />
                </div>
                <p id="text">Login to your Account</p> 
                <asp:TextBox runat="server" id="email" Placeholder="Email Address" required  />
                <asp:TextBox runat="server" id="password" Placeholder="Account Password" type="password" required />                
                <asp:Button runat="server" CssClass="btn btn-primary btn-block btn-ladda" data-style="contract-overlay" ID="login" Text="Login" Style="border-radius: 2px; font-size: 17px; line-height: 1.471; padding: 10px 19px;z-index: 10;" OnClientClick="$('.loading').show();" OnClick="login_Click"/>
                 <div class="input-group">
                    <input id="check" type="checkbox"/> <p id="text1">Remember Me</p>
                     <a id="forget" href="ResetPassword.aspx">Forgot Password ?</a>
                </div>
                 <div class="input-group">
                <%--<hr id="hrline1">--%>
               <%-- <p id="text2">signup</p>--%>
                <%--<hr id="hrline2"> --%>
                <p id="text3">Don't have an account? <a href="Register.aspx" id="signup" style="-webkit-appearance:button; -moz-appearance:button;">Signup Now</a></p> 
                 </div>
            </div>
        </div>

        </form>
        <div class="banner-form" style="background-image:url(images/form.jpg);background-position:center;background-size:cover;">
            <h1>Boost your convenience </h1>
        </div>
        </div>
    </div>
    <div class="sidebar-overlay" data-reff="#sidebar"></div>
    <script src="assests/javascript/login.js"></script>z
</body>
</html>