var question_show = {
    setup: function(last_submission_language, last_submission, submit_custom_testcase_path) {
        var editorModes = {
            10: 'ace/mode/csharp',
            7: 'ace/mode/c_cpp',
            2: 'ace/mode/clojure',
            8: 'ace/mode/java',
            6: 'ace/mode/golang',
            4: 'ace/mode/javascript',
            3: 'ace/mode/php',
            0: 'ace/mode/python',
            1: 'ace/mode/ruby',
            5: 'ace/mode/scala',
            9: 'ace/mode/vbscript',
            11: 'ace/mode/batchfile',
            12: 'ace/mode/objectivec',
            13: 'ace/mode/mysql',
            14: 'ace/mode/perl'
        };
        var content = $("#question_description")[0];
        content.innerHTML = markdown.toHTML(content.innerHTML);
    
        var languageSelect = $('#submission_language');
        languageSelect.val(last_submission_language);
        languageSelect.addClass("form-control");
        
        var editor = ace.edit("editor");
        editor.setTheme("ace/theme/monokai");
        editor.getSession().setMode(editorModes[parseInt(languageSelect.val(), 10)]);
        editor.setOptions({maxLines: 40});
        editor.setValue(last_submission);
        
        if (editor.session.getLength() <= 1) {
            editor.insert(Array(40).join("\n"));
        }
        editor.setShowPrintMargin(false);
        editor.gotoLine(0);
        
        
        languageSelect.on('change', function() {
            editor.getSession().setMode(editorModes[parseInt(this.value, 10)]);
        });
        
        $('#submit').on('click', function() {
            $('#editor-form-submit').val(editor.getValue());
            console.log(editor.getValue());
        });
        
        
        question_show.setup_custom_testcases(editor, languageSelect, submit_custom_testcase_path)
        question_show.setup_loading_element()
    },
    
    setup_custom_testcases: function(editor, languageSelect, submit_custom_testcase_path) {
        var customTestcaseChkbx = $("#toggleCustomTestCases");
        var customTestcaseInput = $("#customInputArea");
        var customTestcaseRunBtn = $("#customInputBtn");
        customTestcaseInput.hide();
        customTestcaseRunBtn.hide();
        customTestcaseChkbx.attr('checked',false);
        customTestcaseChkbx.click(function() {
            var self = $(this);
            if (self.is(':checked')) {
                customTestcaseInput.show();
                customTestcaseRunBtn.show();
            } else {
                customTestcaseInput.hide();
                customTestcaseRunBtn.hide();
                $("#custom_results").hide();
            }
        });
        customTestcaseRunBtn.click(function() {
            $("#custom_results").hide();
            $.ajax({
              type: "POST",
              url: submit_custom_testcase_path,
              data: {submission: {
                         language: languageSelect.val(),
                         code: editor.getValue(),
                         stdin: customTestcaseInput.val()
                     },
              },
              success: question_show.display_custom_testcase_results
            });
        });
        $("#custom_results").hide();
    },
    
    display_custom_testcase_results: function(response) {
        $("#custom_results").show();
        $("#custom_output_pre").text(response['output']);
        $("#custom_error_pre").text(response['errors']);
        
    },
    
    setup_loading_element: function() {
        $(function() {
            $('#loading-indicator').hide();  // hide it initially.
            $(document)  
            .ajaxStart(function() {
                $('#loading-indicator').show(); // show on any Ajax event.
            })
            .ajaxStop(function() {
                $('#loading-indicator').hide(); // hide it when it is done.
            });
        });
    }
};