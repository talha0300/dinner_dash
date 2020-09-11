$(document).ready(function() {
    
    $('#new_user').bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            'user[email]': {
                //container: '#user[email]Message',
                validators: {
                    notEmpty: {
                        message: 'The email is required'
                    }
                }
            },
            'user[user_name]': {
                //container: '#user[email]Message',
                validators: {
                    notEmpty: {
                        message: 'The email is required'
                    }
                }
            },
            'user[display_name]': {
                //container: '#user[email]Message',
                validators: {
                    notEmpty: {
                        message: 'The email is required'
                    },
                    stringLength: {
                        min: 2,
                        max: 32,
                        message: 'The display_name must be more than 2 and less than 32 characters long'
                    }
                }
            },
            'user[password]': {
                //container: '#user[password]Message',
                validators: {
                    notEmpty: {
                        message: 'The password is required'
                    },
                    stringLength: {
                        min: 6,
                        max: 30,
                        message: 'The password must be more than 6 and less than 30 characters long'
                    }
                }
            },
            'user[password_confirmation]': {
                //container: '#user[password_confirmation]Message',
                validators: {
                    notEmpty: {
                        message: 'The password is required'
                    },
                    stringLength: {
                        min: 6,
                        max: 30,
                        message: 'The password must be more than 6 and less than 30 characters long'
                    }
                }
            }

        }
    });
});
