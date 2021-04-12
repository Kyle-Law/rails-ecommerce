console.log('devise_edit.js is run')
function showPasswordForm(){
  const container = document.getElementById('changePasswordContainer')
  container.hidden == true ? container.hidden = false : container.hidden = true
}

document.getElementById('changePasswordBtn').addEventListener('click',showPasswordForm)
