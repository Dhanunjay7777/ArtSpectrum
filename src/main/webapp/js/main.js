document.addEventListener("DOMContentLoaded", function() {
       const aboutBtn = document.getElementById('aboutBtn');
       const modal = document.getElementById('aboutModal');
       const closeModal = document.getElementById('closeModal');
       const aboutContent = document.getElementById('aboutContent');

       // Show modal when About is clicked
       aboutBtn.addEventListener('click', function(e) {
           e.preventDefault(); // Prevent default link behavior
           modal.style.display = 'block';

           // Load about.jsp content
           fetch('about.jsp')
               .then(response => response.text())
               .then(data => {
                   aboutContent.innerHTML = data;
               })
               .catch(err => {
                   aboutContent.innerHTML = '<p>Error loading About content</p>';
               });
       });

       // Close modal when X is clicked
       closeModal.addEventListener('click', function() {
           modal.style.display = 'none';
       });

       // Close modal when clicking outside the modal content
       window.addEventListener('click', function(event) {
           if (event.target === modal) {
               modal.style.display = 'none';
           }
       });
   });
   
   
   
   function getUrlParameter(name) {
       name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
       var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
       var results = regex.exec(location.search);
       return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
   }

   document.addEventListener("DOMContentLoaded", function() {
       var errorMessage = getUrlParameter('error');
       var message = getUrlParameter('msg');

       const alertBox = document.getElementById('alertBox');
       const alertMessage = document.getElementById('alertMessage');
       const progressBar = alertBox ? alertBox.querySelector('.progress') : null;

       // Check if alertBox and alertMessage exist
       if (!alertBox || !alertMessage) return;

       if (errorMessage === 'invalid') {
           alertMessage.textContent = 'Invalid credentials'; // Message for invalid login
       } else if (errorMessage === 'exist') {
           alertMessage.textContent = 'Email Already Exists'; // Message for email already exists
       } else if (message === 'success') {
           alertMessage.textContent = 'Registration Successful'; 
       } else {
           return;
       }

       // Show the alert box
       alertBox.style.display = 'block'; // Show the alert box
       alertBox.classList.add('show'); // Apply any styles for showing

       if (progressBar) {
           progressBar.style.transform = 'scaleX(1)'; // Start the progress animation
       }

       // Automatically hide the alert after a few seconds
       setTimeout(() => {
           alertBox.classList.remove('show');
           alertBox.style.display = 'none'; // Hide the alert box after showing

           if (progressBar) {
               progressBar.style.transform = 'scaleX(0)'; // Reset progress bar
           }
       }, 3000);
   });
