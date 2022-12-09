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
}
window.addEventListener('load', count);