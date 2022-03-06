$("body").on("click", "#btnSave", function () {
    //Loop through the Table rows and build a JSON array.
    var financials = new Array();
    $("#tblIncome TBODY TR").each(function () {
        var row = $(this);
        var finance = {};
        finance.source = row.find("TD input").eq(0).val();
        finance.expected = row.find("TD input").eq(1).val();
        finance.actual = row.find("TD input").eq(2).val();
        finance.financialstartdate = $("#fnstartdate option:selected").text();
        financials.push(finance);
    });

    $.ajax({
        type: "POST",
        url: "FinanceEntries.aspx/InsertIncome",
        // data: JSON.stringify(finance),
        data: '{finance: ' + JSON.stringify(financials) + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (status) {
            switch (status.d) {
                case "success":
                    swal({
                        title: "Sources of income Submitted!",
                        text: "Your Sources of income details was Successfully Submmitted.",
                        icon: "success",
                    }).then(() => {
                        $("#feedback1").css("display", "block");
                        $("#feedback1").css("color", "green");
                        $('#feedback1').attr("class", "alert alert-success");
                        $("#feedback1").html("Your Sources of income details was Successfully Submmitted");
                        location.reload(true);
                    });
                    break;
                default:
                    swal({
                        title: "Sources of income Error!!!",
                        text: "Error Occured when submmitting your source of income.Kindly Try Again",
                        type: "error"
                    }).then(() => {
                        $("#feedback1").css("display", "block");
                        $("#feedback1").css("color", "red");
                        $('#feedback1').addClass('alert alert-danger');
                        $("#feedback1").html(status.d);
                    });
                    break;
            }

        }
    });
});
$("body").on("click", "#btnDatasetCodes", function () {
    //Loop through the Table rows and build a JSON array.
    var datasetcodes = new Array();
    $("#tblbtnDatasetCodes TBODY TR").each(function () {
        var row = $(this);
        var datasetcode = {};
        datasetcode.datacode = row.find("TD input").eq(0).val();
        datasetcode.datadescription = row.find("TD input").eq(1).val();
        datasetcode.selectedcode = row.find("TD input").eq(2).val();
        datasetcodes.push(datasetcode);
    });

    $.ajax({
        type: "POST",
        url: "AmendmentsApprovalRequest.aspx/SubmitDatasetCodes",
        // data: JSON.stringify(finance),
        data: '{datasetcode: ' + JSON.stringify(datasetcodes) + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (status) {
            switch (status.d) {
                case "success":
                    swal({
                        title: "Data Ammendments Dataset Codes!",
                        text: "Dataset Codes details was Successfully Submmitted.",
                        icon: "success",
                    }).then(() => {
                        $("#feedback1").css("display", "block");
                        $("#feedback1").css("color", "green");
                        $('#feedback1').attr("class", "alert alert-success");
                        $("#feedback1").html("Dataset Codes details was Successfully Submmitted.");
                        location.reload(true);
                    });
                    break;
                default:
                    swal({
                        title: "Error Ammendments Dataset Codes!!!",
                        text: "Error Occured when submmitting your Dataset Codes.Kindly Try Again",
                        type: "error"
                    }).then(() => {
                        $("#feedback1").css("display", "block");
                        $("#feedback1").css("color", "red");
                        $('#feedback1').addClass('alert alert-danger');
                        $("#feedback1").html(status.d);
                    });
                    break;
            }

        }
    });
});
$("body").on("click", "#btnSave1", function () {
    //Loop through the Table rows and build a JSON array.
    var financials = new Array();
    $("#tblCreditor TBODY TR").each(function () {
        var row = $(this);
        var finance = {};
        finance.credits = row.find("TD input").eq(0).val();
        finance.amounts = row.find("TD input").eq(1).val();
        financials.push(finance);
    });

    $.ajax({
        type: "POST",
        url: "FinanceEntries.aspx/InsertCreditor",
        // data: JSON.stringify(finance),
        data: '{finance: ' + JSON.stringify(financials) + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (status) {
            switch (status.d) {
                case "success":
                    swal({
                        title: "University Creditors Submitted!",
                        text: "Your University Creditors details was Successfully Submmitted.",
                        icon: "success",
                    }).then(() => {
                        $("#feedback2").css("display", "block");
                        $("#feedback2").css("color", "green");
                        $('#feedback2').attr("class", "alert alert-success");
                        $("#feedback2").html("Your University Creditors details was Successfully Submmitted");
                        location.reload();
                        return false;
                    });
                    break;
                default:
                    swal({
                        title: "University Creditors Submitted!",
                        text: "Error Occured when submmitting your University Creditors Details.Kindly Try Again",
                        type: "error"
                    }).then(() => {
                        $("#feedback2").css("display", "block");
                        $("#feedback2").css("color", "red");
                        $('#feedback2').addClass('alert alert-danger');
                        $("#feedback2").html(status.d);
                    });
                    break;
            }

        }
    });
});
$("body").on("click", "#btnSave2", function () {
    //Loop through the Table rows and build a JSON array.
    var financials = new Array();
    $("#tblDebtor TBODY TR").each(function () {
        var row = $(this);
        var finance = {};
        finance.debtor = row.find("TD input").eq(0).val();
        finance.debtoramounts = row.find("TD input").eq(1).val();
        financials.push(finance);
    });

    $.ajax({
        type: "POST",
        url: "FinanceEntries.aspx/InsertDebtor",
        // data: JSON.stringify(finance),
        data: '{finance: ' + JSON.stringify(financials) + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (status) {
            switch (status.d) {
                case "success":
                    swal({
                        title: "University Debtors Submitted!",
                        text: "Your University debtors details was Successfully Submitted.",
                        icon: "success",
                    }).then(() => {
                        $("#feedback3").css("display", "block");
                        $("#feedback3").css("color", "green");
                        $('#feedback3').attr("class", "alert alert-success");
                        $("#feedback3").html("Your University debtors details was Successfully Submitted");
                    });
                    break;
                default:
                    swal({
                        title: "University Debtors Error!!!",
                        text: "Error Occured when submmitting your University debtors .Kindly Try Again",
                        type: "error"
                    }).then(() => {
                        $("#feedback3").css("display", "block");
                        $("#feedback3").css("color", "red");
                        $('#feedback3').addClass('alert alert-danger');
                        $("#feedback3").html(status.d);
                    });
                    break;
            }

        }
    });
});
$("body").on("click", "#btnAddrationale", function () {
    //Loop through the Table rows and build a JSON array.
    var general = new Array();
    $("#tblrationale TBODY TR").each(function () {
        var row = $(this);
        var rationale = {};
        rationale.rational = row.find("TD input").eq(0).val();
        rationale.descriptions = row.find("TD input").eq(1).val();
        general.push(rationale);
    });

    $.ajax({
        type: "POST",
        url: "ProgramAccreditation.aspx/InsertRationale",
        // data: JSON.stringify(finance),
        data: '{rationale: ' + JSON.stringify(general) + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (status) {
            switch (status.d) {
                case "success":
                    alert("Program Rationale Submitted!");
                    window.location.href = "ProgramAccreditation.aspx?accreditationNo=accreditationNo&step=2";
                    console.log(status.d);
                    break;
                default:
                    alert("error: " + status);
                    console.log(status.d);
                    break;
            }

        }
    });
});
$("body").delegate("#dataTables-example28 .btnInsertQAStaff", "click", function (event) {
    //To prevent form submit after ajax call
    event.preventDefault();
    //Loop through the Table rows and build a JSON array.
    var general = new Array();
    $("#dataTables-example28 TBODY TR").each(function () {
        var row = $(this);
        var onerfqitem = {};
        //onerfqitem.jobCode = $("#txtjobCode").val();
        // onerfqitem.component = $("#txtcomponentCode").val();
        onerfqitem.category = row.find("TD input").eq(0).val();
        onerfqitem.agebracket1 = row.find("TD input").eq(1).val();
        onerfqitem.agebracket2 = row.find("TD input").eq(2).val();
        onerfqitem.agebracket3 = row.find("TD input").eq(3).val();
        onerfqitem.agebracket4 = row.find("TD input").eq(4).val();
        onerfqitem.agebracket5 = row.find("TD input").eq(4).val();
        allrfqitems.push(onerfqitem);
    });

    $.ajax({
        type: "POST",
        url: "InstitutionalQA.aspx/InsertQualityofAcademicStaff",
        data: '{cmpitems: ' + JSON.stringify(allrfqitems) + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (status) {
            switch (status.d) {
                case "success":
                    Swal.fire
                    ({
                        title: "Quality of (Academic) Staff Added!",
                        text: "Quality of (Academic) Staff saved successfully!",
                        type: "success"
                    }).then(() => {
                        $("#feedback").css("display", "block");
                        $("#feedback").css("color", "green");
                        $('#feedback').attr("class", "alert alert-success");
                        $("#feedback").html("Quality of (Academic) Staff saved successfully!");
                    });
                    break;
                default:
                    Swal.fire
                    ({
                        title: "Error!!!",
                        text: "Error Occured",
                        type: "error"
                    }).then(() => {
                        $("#feedback").css("display", "block");
                        $("#feedback").css("color", "red");
                        $('#feedback').addClass('alert alert-danger');
                        $("#feedback").html(status.d);
                    });
                    break;
            }
        }
    });
    console.log(allrfqitems);
});
$("body").on("click", "#btnSaveStudents", function () {
    //Loop through the Table rows and build a JSON array.
    var studentprofile = new Array();
    $("#studentsprofiles TBODY TR").each(function () {
        var row = $(this);
        var profile = {};
        profile.academicyear = row.find("TD input").eq(0).val();
        profile.governmentmale = row.find("TD input").eq(1).val();
        profile.governmentfemale = row.find("TD input").eq(2).val();
        profile.selfmale = row.find("TD input").eq(3).val();
        profile.selffemale = row.find("TD input").eq(4).val();
        profile.kenyanstudents = row.find("TD input").eq(5).val();
        profile.internationalstudents = row.find("TD input").eq(6).val();
        studentprofile.push(profile);
    });

    $.ajax({
        type: "POST",
        url: "ProgramQA.aspx/InsertStudentsProfile",
        // data: JSON.stringify(finance),
        data: '{profile: ' + JSON.stringify(studentprofile) + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (status) {
            switch (status.d) {
                case "success":
                    alert("Student Profile Details has been submitted!");
                    location.reload(true);
                    //  window.location.href = "ProgramAccreditation.aspx?accreditationNo=accreditationNo&step=2";
                    console.log(status.d);
                    break;
                default:
                    alert("error: " + status);
                    console.log(status.d);
                    break;
            }

        }
    });
});
$("body").on("click", "#btnSaveFulltimeStaff", function () {
    //Loop through the Table rows and build a JSON array.
    var fulltimestaffs = new Array();
    $("#fulltimestaffsize TBODY TR").each(function () {
        var row = $(this);
        var fulltime = {};
        fulltime.designation = row.find("TD input").eq(0).val();
        fulltime.designationmalebelow30 = row.find("TD input").eq(1).val();
        fulltime.designationfemalebelow30 = row.find("TD input").eq(2).val();
        fulltime.designationintersexbelow30 = row.find("TD input").eq(3).val();
        fulltime.designationmalebetween3139 = row.find("TD input").eq(4).val();
        fulltime.designationfemalebetween3139 = row.find("TD input").eq(5).val();
        fulltime.designationintersexbetween3139 = row.find("TD input").eq(6).val();
        fulltime.designationmalebetween4049 = row.find("TD input").eq(7).val();
        fulltime.designationfemalebetween4049 = row.find("TD input").eq(8).val();
        fulltime.designationintersexbetween4049 = row.find("TD input").eq(9).val();
        fulltime.designationmalebetween5059 = row.find("TD input").eq(10).val();
        fulltime.designationfemalebetween5059 = row.find("TD input").eq(11).val();
        fulltime.designationintersexbetween5059 = row.find("TD input").eq(12).val();
        fulltime.designationmaleabove60 = row.find("TD input").eq(13).val();
        fulltime.designationfemaleabove60 = row.find("TD input").eq(14).val();
        fulltime.designationintersexabove60 = row.find("TD input").eq(15).val();
        fulltimestaffs.push(fulltime);
    });
    $.ajax({
        type: "POST",
        url: "ProgramQA.aspx/InsertFulltimeAcademicStaffSize",
        // data: JSON.stringify(finance),
        data: '{fulltime: ' + JSON.stringify(fulltimestaffs) + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (status) {
            switch (status.d) {
                case "success":
                    alert("Full Time Academic Staff Details has been submitted!");
                    //  window.location.href = "ProgramAccreditation.aspx?accreditationNo=accreditationNo&step=2";
                    console.log(status.d);
                    break;
                default:
                    alert("error: " + status);
                    console.log(status.d);
                    break;
            }

        }
    });
});
$("body").on("click", "#btnSaveDidactic", function () {
    //Loop through the Table rows and build a JSON array.
    var didacticaids = new Array();
    $("#didactictools TBODY TR").each(function () {
        var row = $(this);
        var didactic = {};
        didactic.didactictools = row.find("TD input").eq(0).val();
        didactic.totalnumber = row.find("TD input").eq(1).val();
        didactic.specifictoDepartment = row.find("TD input").eq(2).val();
        didactic.usageshared = row.find("TD input").eq(3).val();
        didacticaids.push(didactic);
        console.log(didactic);
        console.log(JSON.stringify(didactic));
    });
    $.ajax({
        type: "POST",
        url: "ProgramQA.aspx/InsertDidacticAidsTools",
        // data: JSON.stringify(finance),
        data: '{didactic: ' + JSON.stringify(didacticaids) + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (status) {
            switch (status.d) {
                case "success":
                    alert("Didactic aids and tools of the Academic Programme!");
                    location.reload(true);
                    //  window.location.href = "ProgramAccreditation.aspx?accreditationNo=accreditationNo&step=2";
                    console.log(status.d);
                    break;
                default:
                    alert("error: " + status);
                    console.log(status.d);
                    break;
            }

        }
    });
});
$(".btn_js_passcChangePassword").click(function () {
    var temailaddress = $("#emailid").val();
    var toriginalpassword = $("#orginalpassid").val();
    var tnewpassword = $("#newpassid").val();
    var tconfirmpassword = $("#confirmpass").val();
    if (temailaddress != '' && toriginalpassword != '' && tnewpassword != '' && tconfirmpassword != '') {
        //Swal Message
        Swal.fire({
            title: "Confirm  Password Reset?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    url: "ChangePassword.aspx/ChangeUserpassword",
                    data: "{'temailaddress':'" + temailaddress + "','toriginalpassword':'" + toriginalpassword + "','tnewpassword':'" + tnewpassword + "','tconfirmpassword':'" + tconfirmpassword + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (status) {
                        switch (status.d) {
                            case "success":
                                swal({
                                    title: "Password Changed!",
                                    text: "Your Account Password was Changed Successfully.Kindly use your new Password to Login.",
                                    icon: "success",
                                    type: "success"
                                }).then(() => {
                                    $("#feedback").css("display", "block");
                                    $("#feedback").css("color", "green");
                                    $('#feedback').attr("class", "alert alert-success");
                                    $("#feedback").html("Your Account Password was Changed Successfully.Kindly use your new Password to Login!");
                                    window.location = "Login.aspx";
                                });
                                break;
                            default:
                                swal({
                                    title: "Password Change Error!!!",
                                    text: "Error Occured when Changing your Password.Kindly Try Again",
                                    type: "error"
                                }).then(() => {
                                    $("#feedback").css("display", "block");
                                    $("#feedback").css("color", "red");
                                    $('#feedback').addClass('alert alert-danger');
                                    $("#feedback").html(status.d);
                                });
                                break;
                        }
                    }
                })
            }
            else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Password Reset Cancelled',
                    'You cancelled your Password Reset submission details!',
                    'error'
                );
            }

        });
    }
    else {
        Swal.fire({
            icon: 'error',
            type: 'error',
            title: 'Oops...',
            text: 'Fill in all the Details before you submit your Request!',
            footer: '<a href>Contact CUE for Any Clarifications!!</a>'
        })
    }
});

$('#btn_accountcreation').click(function (event) {
    //To prevent form submit after ajax call
    event.preventDefault();
    var tinsttype = document.getElementById("insttype").selectedIndex;
    var taddnumber = $('#idnumber').val();
    var tfirstname = $('#firstname').val();
    var tmiddlname = $('#middlname').val();
    var tlastname = $('#lastname').val();
    var tphonenumber = $('#phonenumber').val();
    var temailaddress = $('#emailaddress').val();
    var taddress = $('#address').val();
    var tpostcode = $('#postcode').val();
    var tcity = $('#city').val();
    var tcountry = $('#country').val();
    var tuserrole = document.getElementById("userrole").selectedIndex;
    var tuniversityname = $('#universityname').val();
    if (taddnumber != '' && tfirstname != '' && tlastname != '' && tphonenumber != '' && tcity != '' && taddress != '' && tpostcode != '' && tcountry != '' ) {
        //Swal Message
        Swal.fire({
            title: "Confirm Account Registration?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"
        }).then((result) => {
            if (result.value) {
                $.ajax
                   ({
                       type: 'POST',
                       url: 'RequestAccountCreation.aspx/RequesttoCreateAccount',
                       async: false,
                       data: "{'tinsttype':'" + tinsttype + "','taddnumber':'" + taddnumber + "','tfirstname':'" + tfirstname + "','tmiddlname':'" + tmiddlname
                           + "','tlastname':'" + tlastname + "','tphonenumber':'" + tphonenumber + "','temailaddress':'" + temailaddress
                           + "','taddress':'" + taddress + "','tpostcode':'" + tpostcode + "','tcity':'" + tcity + "','tcountry':'" + tcountry
                           + "','tuserrole':'" + tuserrole + "','tuniversityname':'" + tuniversityname + "'}",
                       contentType: 'application/json; charset =utf-8',
                       success: function (status) {
                           var obj = status.d;
                           if (obj == 'success') {
                               $('#taddnumber').val('');
                               $('#tfirstname').val('');
                               $('#tmiddlname').val('');
                               $('#tlastname').val('');
                               swal
                                  ({
                                      title: "Account Created!",
                                      text: "Your Account Details has been successfully submitted.Kindly Wait for CUE Notification.",
                                      icon: "success",
                                      type: "success"
                                  }).then(() => {
                                      $("#acccountfeedback").css("display", "block");
                                      $("#acccountfeedback").css("color", "green");
                                      $('#acccountfeedback').attr("class", "alert alert-success");
                                      $("#acccountfeedback").html("Your Account Details was Successfully Submitted.Kindly use wait for Notification from CUE!!");
                                      $("#acccountfeedback").css("display", "block");
                                      $("#acccountfeedback").css("color", "green");
                                      $("#acccountfeedback").html("Your Account Details was Successfully Submitted.Kindly use wait for Notification from CUE!");
                                      window.location = "Login.aspx";
                                  });

                           }
                           else {
                               Swal.fire
                                   ({
                                       title: "Account Creation Error!!!",
                                       text: "Error Occured when Submitting your Details.Kindly Contact CUE for more information",
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
                                title: "Account Creation Error!!!",
                                text: "Error Occured when Submitting your Details" + status.d,
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
                    'Account Registration Cancelled',
                    'You cancelled your registration submission details!',
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
            footer: '<a href>Contact CUE for Any Clarifications?</a>'
        })
    }
})
$('#btn_budgetactualexpenditure').click(function (event) {
    //To prevent form submit after ajax call
    event.preventDefault();
    var toperationBudget = $('#txtoperationBudget').val();
    var tactualExpenditure = $('#txtactualExpenditure').val();
    if (toperationBudget != '' && tactualExpenditure != '') {
        $.ajax({
            type: "POST",
            url: 'FinanceEntries.aspx/ActualBudgetSubmit',
            async: false,
            data: "{'toperationBudget':'" + toperationBudget + "','tactualExpenditure':'" + tactualExpenditure + "'}",
            contentType: 'application/json; charset =utf-8',
            success: function (status) {
                var obj = status.d;
                if (obj == 'success') {
                    $('#toperationBudget').val('');
                    $('#tactualExpenditure').val('');
                    swal({
                        title: "Budget and Actual Expenditure Submited!",
                        text: "Your University operation budget and actual expenditure has been successfully submitted.",
                        icon: "success",
                        confirmButtonText: "Okey",
                    }).then(() => {
                        $("#feedback").css("display", "block");
                        $("#feedback").css("color", "green");
                        $('#feedback').attr("class", "alert alert-success");
                        $("#feedback").html("Your University operation budget and actual expenditure has been successfully submitted.!");
                        location.reload(true);
                    });

                } else {
                    swal({
                        title: "Budget and Actual Expenditure Error!!!",
                        text: "Error Occured when Submitting your University operation budget and actual expenditure.Kindly Try Again",
                        type: "error"
                    }).then(() => {
                        $("#feedback").css("display", "block");
                        $("#feedback").css("color", "red");
                        $('#feedback').addClass('alert alert-danger');
                        $("#feedback").html(status.d);
                    });
                }
            },

            error: function (result) {
                swal({
                    title: "Budget and Actual Expenditure Error!!!",
                    text: "Error Occured when Submitting your University operation budget and actual expenditure.Kindly Try Again",
                    type: "error"
                }).then(() => {
                    $("#feedback").css("display", "block");
                    $("#feedback").css("color", "red");
                    $('#feedback').addClass('alert alert-danger');
                    $("#feedback").html(result);
                });
            }
        });
    }
    else {
        alert("Please fill in all the form details before you submit your details.");
        return false;
    }
})
function addOverlay() {
    var overlay = document.getElementById("overlay");
    overlay.style.display = "block";
}
$('#btn_password_resetrequest').click(function (event) {
    //To prevent form submit after ajax call
    event.preventDefault();
    var temailaddress = $('#emailid').val();
    if (temailaddress != '') {
        $.ajax({
            type: "POST",
            url: 'ForgotPass.aspx/Resetpassword',
            async: false,
            data: "{'temailaddress':'" + temailaddress + "'}",
            contentType: 'application/json; charset =utf-8',
            success: function (status) {
                var obj = status.d;
                if (obj == 'success') {
                    $('#temaiaddress').val('');
                    swal({
                        title: "Password Reset Request!",
                        text: "Your Password Reset Request has been successfully submitted.Kindly Check Your Email for the New Password",
                        icon: "success",
                        confirmButtonText: "Okey",
                    }).then(() => {
                        $("#feedback").css("display", "block");
                        $("#feedback").css("color", "green");
                        $('#feedback').attr("class", "alert alert-success");
                        $("#feedback").html("Your Password Reset Request has been successfully submitted.Kindly Check Your Email for the New Password!");
                        window.location = "Login.aspx";

                    });

                } else {
                    swal({
                        title: "Password Reset Error!!!",
                        text: "Error Your Password Reset Request was not Succesffully Submitted.Kindly Try Again.",
                        type: "error"
                    }).then(() => {
                        $("#feedback").css("display", "block");
                        $("#feedback").css("color", "red");
                        $('#feedback').addClass('alert alert-danger');
                        $("#feedback").html(status.d);
                    });
                }
            },

            error: function (result) {
                swal({
                    title: "Password Reset Error!!!",
                    text: "Error Your Password Reset Request was not Succesffully Submitted.Email Address is Missing",
                    type: "error"
                }).then(() => {
                    $("#feedback").css("display", "block");
                    $("#feedback").css("color", "red");
                    $('#feedback').addClass('alert alert-danger');
                    $("#feedback").html(result);
                });
            }
        });
    }
    else {
        alert("Please fill in your Email Address Before Submittting your Request.");
        return false;
    }
})
$(".btn_request_assistance").click(function () {
    var tuseremailaddress = $("#useremailaddress").val();
    var tcueemailaddress = $("#cueemailaddress").val();
    var temailsubject = $("#emailsubject").val();
    var temailassistance = $("#emailassitancerequest").val();
    if (tuseremailaddress != '' && tcueemailaddress != '' && temailsubject != '' && temailassistance != '') {
        console.log(JSON.stringify(temailassistance))
        //Swal Message
        Swal.fire({
            title: "Confirm  Assitance Request?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    url: "ComposeEmail.aspx/AssitanceRequest",
                    data: "{'tuseremailaddress':'" + tuseremailaddress + "','tcueemailaddress':'" + tcueemailaddress + "','temailsubject':'" + temailsubject + "','temailassistance':'" + temailassistance + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (status) {
                        switch (status.d) {
                            case "success":
                                swal({
                                    title: "Assistance Request Submitted!",
                                    text: "Your Assistance Reqeuest was Successfully Sent.Kindly Check your Email Account for More Information.",
                                    icon: "success",
                                    type: "success"
                                }).then(() => {
                                    $("#feedback").css("display", "block");
                                    $("#feedback").css("color", "green");
                                    $('#feedback').attr("class", "alert alert-success");
                                    $("#feedback").html("Your Assistance Reqeuest was Successfully Sent.Kindly Check your Email Account for More Information!");
                                });
                                break;
                            default:
                                swal({
                                    title: "Assitance Request Error!!!",
                                    text: "Error Occured whenSubmitting your Assitance Request.Kindly Try Again or Contact CUE for More Information",
                                    type: "error"
                                }).then(() => {
                                    $("#feedback").css("display", "block");
                                    $("#feedback").css("color", "red");
                                    $('#feedback').addClass('alert alert-danger');
                                    $("#feedback").html(status.d);
                                });
                                break;
                        }
                    }
                })
            }
            else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Assistance Request Cancelled',
                    'You cancelled your Assistance Request submission details!',
                    'error'
                );
            }

        });
    }
    else {
        Swal.fire({
            icon: 'error',
            type: 'error',
            title: 'Oops...',
            text: 'Fill in all the Details before you submit your Request!',
            footer: '<a href>Contact CUE for Any Clarifications!!</a>'
        })
    }
});

var table = $('#datacollectiondatasetcodes').DataTable({})
$('#btnGet').on('click', function () {
    var nodes = [];
    table.rows().every(function (rowIdx, tableLoop, rowLoop) {
        if (this.data()[2] == true) nodes.push(this.node())

    })
    nodes.forEach(function (node) {
        table.row(node).remove().draw()
    })
});