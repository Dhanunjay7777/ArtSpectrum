document.addEventListener("DOMContentLoaded", function() {
           document.getElementById('email').addEventListener('input', function() {
               var email = this.value;
               var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
               if (!emailPattern.test(email)) {
                   document.getElementById('emailError').innerHTML = "Invalid email format. Example: user@gmail.com";
               } else {
                   document.getElementById('emailError').innerHTML = '';
               }
           });

           document.getElementById('contactno').addEventListener('input', function() {
               var contactno = this.value;
               var contactnoPattern = /^[0-9]{10}$/;
               if (!contactnoPattern.test(contactno)) {
                   document.getElementById('contactnoError').innerHTML = "Please enter a valid 10-digit contactno number.";
               } else {
                   document.getElementById('contactnoError').innerHTML = '';
               }
           });

           document.getElementById('password').addEventListener('input', function() {
               var password = this.value;
               if (password.length < 8) {
                   document.getElementById('passwordError').innerHTML = "Password must be at least 8 characters long.";
               } else {
                   document.getElementById('passwordError').innerHTML = '';
               }
               validatePasswordMatch();

           });
           document.getElementById('confirmPassword').addEventListener('input', function() {
               validatePasswordMatch();
           });
       });
       
       function validatePasswordMatch() {
           var password = document.getElementById('password').value;
           var confirmPassword = document.getElementById('confirmPassword').value;
           if (password !== confirmPassword) {
               document.getElementById('confirmPasswordError').innerHTML = "Passwords do not match.";
           } else {
               document.getElementById('confirmPasswordError').innerHTML = '';
           }
       }
       
       function validateForm() {
           var emailError = document.getElementById('emailError').innerHTML;
           var contactnoError = document.getElementById('contactnoError').innerHTML;
           var passwordError = document.getElementById('passwordError').innerHTML;

           return !emailError && !contactnoError && !passwordError; // Only submit if no errors
       }