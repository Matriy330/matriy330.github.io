var posts=["2025/01/01/hello-world/","2025/01/02/逆向工程入门/"];function toRandomPost(){
    pjax.loadUrl('/'+posts[Math.floor(Math.random() * posts.length)]);
  };