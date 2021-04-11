console.log('cart_show.js is run')
var orderItemInputs = document.querySelectorAll('#order_item_quantity')

function highlightUpdateBtn(e){
  e.target.nextElementSibling.classList.add('border-red')
}
orderItemInputs.forEach(input => {
  input.addEventListener('change',highlightUpdateBtn)
})
