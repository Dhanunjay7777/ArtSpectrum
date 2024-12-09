<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Home</title>
    <link rel="stylesheet" href="css/mainhome.css"/>
    <style>
   .lottie-container {
    display: flex;
    justify-content: space-between;
    align-items: flex-start; /* Aligns items at the top */
    width: 100%;
    padding: 0 20px; /* Adds padding on left and right */
}

.lottie-player {
    width: 300px;
    height: 300px;
}

.left {
    text-align: left;
    margin-top: -200px;
}

.center {
    text-align: center;
    
}

.right {
    text-align: right;
    margin-top: -90px; 
}
   
    </style>
</head>
<body>

    <!-- Embedding the video -->
      <div class="video-container">
        <video autoplay muted loop>
            <source src="https://media.istockphoto.com/id/1483895619/video/creative-artist-wearing-a-white-t-shirt-black-apron-with-headphones-on-is-creating-an.mp4?s=mp4-640x640-is&k=20&c=pxc5Y4__eCQcZcBB2uwhrEOrnFm43QNEc8X677R1VkM=" type="video/mp4">
        </video>
    </div>  
  

     <div class="content-overlay">
        <h2>Welcome to the Art Spectrum</h2>
        <div class="link-container">
            <a href="">Home</a>
            <a href="login">Login</a>
        </div>
    </div> 
    
 <!-- <div class="lottie-container">
        <div class="left">
        <script src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs" type="module"></script>
<dotlottie-player src="https://lottie.host/bafb986e-d881-46d5-bd80-958d396b7d86/xhy9pnOZIl.lottie" background="transparent" speed="1" style="width: 300px; height: 300px" loop autoplay></dotlottie-player>
        </div>

        <div class="center">
        <script src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs" type="module"></script>
<dotlottie-player src="https://lottie.host/c906819a-754a-404c-8ed2-e5d09bcf949b/s44r1NFwHx.lottie" background="transparent" speed="1" style="width: 300px; height: 300px" loop autoplay></dotlottie-player>
</div>

        <div class="right">
            <script src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs" type="module"></script>
            <dotlottie-player src="https://lottie.host/e91d6850-74f5-4950-a33d-f7510c6179ab/vkmSnYmrou.lottie" background="transparent" speed="1" class="lottie-player" loop autoplay></dotlottie-player>
        </div>
    </div>   -->
</body>
</html>
