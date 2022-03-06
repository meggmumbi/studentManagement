$(document).ready(function () {

    //    var selected_arr = [];

    //    $(".btn_apply_SubmitTargets").on("click",
    //        function (e) {
    //            e.preventDefault();
    //            // Read all checked checkboxes
    //            $.each($(".selectedprequalificationsWorks tr.active"), function () {
    //                //procurement category
    //                var checkbox_value = $('#worksselected').val();
    //                selected_arr.push($(this).find('td').eq(1).text());
                
    //                $(this).find('td').eq(1).text()
    //            });
    //            var postData = {

    //                level: $("#ExamPapers").val(),
    //                applicationNo: $("#ApplicationNo").val,
    //                papercode: selected_arr

    //            };
    //            console.log(selected_arr)
    //            Swal.fire({
    //                title: "Confirm Selected Examinations?",
    //                text: "Are you sure you would like to proceed with submission?",
    //                type: "warning",
    //                showCancelButton: true,
    //                closeOnConfirm: true,
    //                confirmButtonText: "Yes, Proceed!",
    //                confirmButtonClass: "btn-success",
    //                confirmButtonColor: "#008000",
    //                position: "center"

    //            }).then((result) => {
    //                if (result.value) {
    //                    $.ajax({
    //                        url: "ExamBooking.aspx/selectedPapers",
    //                        type: "POST",
    //                        data: '{postData: ' + JSON.stringify(postData) + '}',
                       
    //                        contentType: "application/json",
    //                        cache: false,
    //                        processData: false
    //                    }).done(function (status) {
    //                        var registerstatus = status.split('*');
    //                        status = registerstatus[0];
    //                        switch (status) {
    //                            case "success":
    //                                Swal.fire
    //                                ({
    //                                    title: "Examinations Submitted!",
    //                                    text: status,
    //                                    type: "success"
    //                                }).then(() => {
    //                                    $("#worksfeedback").css("display", "block");
    //                                    $("#worksfeedback").css("color", "green");
    //                                    $('#worksfeedback').attr("class", "alert alert-success");
    //                                    $("#worksfeedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
    //                                    $("#worksfeedback").css("display", "block");
    //                                    $("#worksfeedback").css("color", "green");
    //                                    $("#worksfeedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
    //                                    $("#worksfeedback").reset();
    //                                });
    //                                selected_arr = [];
    //                                break;
    //                            default:
    //                                Swal.fire
    //                                ({
    //                                    title: "Submission Error!!!",
    //                                    text: registerstatus[1],
    //                                    type: "error"
    //                                }).then(() => {
    //                                    $("#worksfeedback").css("display", "block");
    //                                    $("#worksfeedback").css("color", "red");
    //                                    $('#worksfeedback').addClass('alert alert-danger');
    //                                    $("#worksfeedback").html("Your Examination papers could not be submitted.Kindly select again and try to submit!" + registerstatus[1]);
    //                                });
    //                                selected_arr = [];
    //                                break;
    //                        }
    //                    }
    //                    );
    //                } else if (result.dismiss === Swal.DismissReason.cancel) {
    //                    Swal.fire(
    //                        'Submission Cancelled',
    //                        'You cancelled your Examination submission details!',
    //                        'error'
    //                    );
    //                }
    //            });

    //        });




    //})

    //'use-strict';
    //$('#checkBoxAllGoods').click(function () {
    //    var checked = this.checked;
    //})
    $("#checkBoxAllGoods").change(function () {
        if (this.checked) {
            $(".worksselected").each(function () {
                this.checked = true;
            });
        } else {
            $(".worksselected").each(function () {
                this.checked = false;
            });
        }
    });
    var td2 = $(".selectedprequalificationsWorks")
    td2.on("change",
        "tbody tr .checkboxes",
        function () {
            var t = jQuery(this).is(":checked"), selected_arr = [];
            t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
                : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
            // Read all checked checkboxes
            $("input:checkbox[class=checkboxes]:checked").each(function () {
                selected_arr.push($(this).val());
            });

            if (selected_arr.length > 0) {
                $("#rfiresponsefeedback").css("display", "block");

            } else {
                $("#rfiresponsefeedback").css("display", "none");
                selected_arr = [];
            }

        });
    //var selected_arr = [];
    var PrimaryInitiative = new Array();
    $(".btn_apply_SubmitTargets").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".selectedprequalificationsWorks tr.active"), function () {
                //procurement category
                var checkbox_value = $('#worksselected').val();
                var Targets = {};
                Targets.targetNumber = ($(this).find('td').eq(1).text());
                //Targets.Level = $("#txtLevel").val();
                Targets.Level = $("#txtLevel").val();
                Targets.ApplicationNo = $("#txtAppNo").val();
                Targets.courseId = $("#txtcourse").val();
                PrimaryInitiative.push(Targets);
            });
            var postData = {
                catgeories: PrimaryInitiative
            };
            console.log(JSON.stringify(PrimaryInitiative))
            Swal.fire({
                title: "Confirm Selected Examinations?",
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
                        contentType: "application/json; charset=utf-8",
                        data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                        url: "ExamBooking.aspx/selectedPapers",
                        dataType: "json",
                        processData: false
                    }).done(function (status) {
                        var registerstatus = status.d;
                        console.log(JSON.stringify(registerstatus))
                        if (registerstatus == 'success') {
                            Swal.fire
                               ({
                                   title: "Examinations Submitted!",
                                   text: "Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step!",
                                   type: "success"
                               }).then(() => {
                                   $("#feedback").css("display", "block");
                                   $("#feedback").css("color", "green");
                                   $('#feedback').attr("class", "alert alert-success");
                                   $("#feedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
                                   $("#feedback").css("display", "block");
                                   $("#feedback").css("color", "green");
                                   $("#feedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
                                   location.reload(true);
                               });
                        }

                        else {
                            Swal.fire
                                    ({
                                        title: "Examination submission Error!!!",
                                        text: registerstatus,
                                        type: "error"
                                    }).then(() => {
                                        $("#feedback").css("display", "block");
                                        $("#feedback").css("color", "red");
                                        $('#feedback').addClass('alert alert-danger');
                                        $("#feedback").html("Your Examination papers could not be submitted.Kindly select again and try to submit!" + registerstatus);
                                        location.reload(true);                                });

                        }
                        //switch (registerstatus) {
                        //    case "success":
                        //        Swal.fire
                        //        ({
                        //            title: "Examinations Submitted!",
                        //            text: "Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!",
                        //            type: "success"
                        //        }).then(() => {
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "green");
                        //            $('#feedback').attr("class", "alert alert-success");
                        //            $("#feedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "green");
                        //            $("#feedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
                        //            $("#feedback").reset();
                        //            location.reload(true);
                        //        });
                        //        PrimaryInitiative = [];
                        //        $('#plogsActivities').modal('hide');
                        //        $.modal.close();
                        //        document.location.reload();
                        //       // window.location("ExamBooking.aspx");
                        //        break;
                        //    default:
                        //        Swal.fire
                        //        ({
                        //            title: "feedback Error!!!",
                        //            text: registerstatus,
                        //            type: "error"
                        //        }).then(() => {
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "red");
                        //            $('#feedback').addClass('alert alert-danger');
                        //            $("#feedback").html("Your Examination papers could not be submitted.Kindly select again and try to submit!" + registerstatus);
                        //        });
                        //        PrimaryInitiative = [];
                        //        break;
                        //}
                    }
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire(
                       'Submission Cancelled',
                            'You cancelled your Examination submission details!',
                           'error'
                    );
                }
            });

        });

})
