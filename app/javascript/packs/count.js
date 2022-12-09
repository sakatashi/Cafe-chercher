function count (){
  const postText = document.getElementById('post_text');

  postText.addEventListener("keyup", () => {
   let titleLength = postText.value.length
   let countTitle = document.getElementById('count_title')
   if (titleLength > 50){
     titleLength = 50
   }
   countTitle.innerHTML = `${titleLength}/50`
  });
  
  const postContent = document.getElementById('post_content');

  postContent.addEventListener("keyup", () => {
   let contentLength = postContent.value.length
   let countContent = document.getElementById('count_content')
   if (contentLength >125){
     contentLength = 125
   }
   countContent.innerHTML = `${contentLength}/125`
  });
}
window.addEventListener('load', count);