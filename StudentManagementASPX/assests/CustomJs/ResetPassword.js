$('.btn_reset_passord').click(function (event) {
    //To prevent form submit after ajax call
    event.preventDefault();

    var temail = $('#txtemailresetaddress').val();




    if (temail != '') {
        //Swal Message
        Swal.fire({
            title: "Reset password?",
            text: "are you sure you would like to reset your password",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"
        }).then((result) => {
            if (result.value) {
             return  $.ajax
                   ({
                       type: 'POST',
                       url: 'Login.aspx/login',
                       async: false,
                       data: "{'temail':'" + temail + "'}",
                       contentType: 'application/json; charset =utf-8',
                       success: function (status) {
                           var obj = status.d;
                           if (obj == 'success') {

                               $('#temail').val('');
                               Swal.fire
                                  ({
                                      title: "Password Reset!",
                                      text: "Your password was reset.Kindly check your Email for the newly set password.",
                                      icon: "success",
                                      type: "success"
                                  }).then(() => {
                                      $("#acccountfeedback").css("display", "block");
                                      $("#acccountfeedback").css("color", "green");
                                      $('#acccountfeedback').attr("class", "alert alert-success");
                                      $("#acccountfeedback").html("your password was reset.proceed to login!");
                                      $("#acccountfeedback").css("display", "block");
                                      $("#acccountfeedback").css("color", "green");
                                      $("#acccountfeedback").html("Your password was reset.Kindly check your Email for the newly set password");
                                      window.location = "Login.aspx";
                                  });

                           }
                           else {
                               Swal.fire
                                   ({
                                       title: "Password Reset Error!!!",
                                       text: obj,
                                       type: "error"
                                   }).then(() => {
                                       $("#acccountfeedback").css("display", "block");
                                       $("#acccountfeedback").css("color", "red");
                                       $('#acccountfeedback').addClass('alert alert-danger');
                                       $("#acccountfeedback").html(status.d);
                                   });
                           }
                       },
                       error: function (result) {
                           Swal.fire
                            ({
                                title: "Password Reset Error!!!",
                                text: "Error Occured when Resetting your Password" + status.d,
                                type: "error"
                            }).then(() => {
                                $("#acccountfeedback").css("display", "block");
                                $("#acccountfeedback").css("color", "red");
                                $('#acccountfeedback').addClass('alert alert-danger');
                                $("#acccountfeedback").html(status.d);
                            });
                       }
                   });
            }
            else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Reset Password cancelled',
                    'You cancelled password reset!',
                    'error'
                );
            }
        });
    }
    else {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Fill in all the Details before you register!',
            footer: '<a href>Contact kasneb for Any Clarifications?</a>'
        });
    }
});

$('.btn_passwordreset_Details').click(function (event) {
    //To prevent form submit after ajax call
    event.preventDefault();

    var temailAddres = $('#txtemailaddress').val();
    var tOldPassword = $('#txtoldpassword').val();
    var tNewPassword = $('#txtnewpassword').val();
    var tconfirmNewPassword = $('#txtconfirmnewpassword').val();



    if (temailAddres != '' && tOldPassword != '' && tNewPassword != '' && tconfirmNewPassword != '') {
        //Swal Message
        Swal.fire({
            title: "Confirm Change Password?",
            text: "Are you sure you would like to change your Password?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"
        }).then((result) => {
            if (result.value) {
                return $.ajax
                   ({
                       type: 'POST',
                       url: 'Login.aspx/ChangePassword',
                       async: false,
                       data: "{'temailAddres':'" + temailAddres + "','tOldPassword':'" + tOldPassword + "','tNewPassword':'" + tNewPassword + "','tconfirmNewPassword':'" + tconfirmNewPassword + "'}",
                       contentType: 'application/json; charset =utf-8',
                       success: function (status) {
                           var obj = status.d;
                           if (obj == 'success') {

                               Swal.fire
                                  ({
                                      title: "Password Changed!",
                                      text: "Your Password Has been changed. Proceed to Login.",
                                      icon: "success",
                                      type: "success"
                                  }).then(() => {
                                      $("#acccountfeedback").css("display", "block");
                                      $("#acccountfeedback").css("color", "green");
                                      $('#acccountfeedback').attr("class", "alert alert-success");
                                      $("#acccountfeedback").html("Your Password Has been changed! proceed to login");
                                      $("#acccountfeedback").css("display", "block");
                                      $("#acccountfeedback").css("color", "green");
                                      $("#acccountfeedback").html("Your Password Has been changed!.proceed to login");
                                      window.location = "Login.aspx";
                                  });

                           }
                           else {
                               Swal.fire
                                   ({
                                       title: "Password Change Error!!!",
                                       text: obj,
                                       type: "error"
                                   }).then(() => {
                                       $("#acccountfeedback").css("display", "block");
                                       $("#acccountfeedback").css("color", "red");
                                       $('#acccountfeedback').addClass('alert alert-danger');
                                       $("#acccountfeedback").html(status.d);
                                   });
                           }
                       },
                       error: function (result) {
                           Swal.fire
                            ({
                                title: "Password Change Error!!!",
                                text: "Error Occured when Changing your password" + status.d,
                                type: "error"
                            }).then(() => {
                                $("#acccountfeedback").css("display", "block");
                                $("#acccountfeedback").css("color", "red");
                                $('#acccountfeedback').addClass('alert alert-danger');
                                $("#acccountfeedback").html(status.d);
                            });
                       }
                   });
            }
            else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Password change Cancelled',
                    'cancelled!',
                    'error'
                );
            }
        });
    }
    else {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Fill in all the Details before you Change Your Password your password!',
            footer: '<a href>Contact kasneb for Any Clarifications?</a>'
        })
    }
})