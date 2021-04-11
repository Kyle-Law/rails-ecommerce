console.log('shipping.js is run')
// Variables
let checkoutBtn = document.getElementById('checkout')
let deliveryMode = document.getElementById('order_delivery_mode_id')
let shippingContainer = document.getElementById('shippingContainer')
let shippingAddress = document.getElementById('order_shipping_address')
let phoneNumber = document.getElementById('order_notification_phone_number')
let message = document.getElementById('checkoutPrompt')
let customerInfoCard = document.getElementById('customerInfoCard')
let infoAddress = document.getElementById('infoAddress')
let infoStreet = document.getElementById('infoStreet')
let infoPostCode = document.getElementById('infoPostCode')
let infoState = document.getElementById('infoState')
let infoCity = document.getElementById('infoCity')
let infoCompanyName = document.getElementById('infoCompanyName')
let phoneErrorMessage = document.getElementById('phoneErrorMessage')
let infoPhoneNumber = document.getElementById('infoPhoneNumber')
let commentText = document.getElementById('commentText')
let commentInput = document.getElementById('order_remarks')
let addressesData = JSON.parse(shippingContainer.getAttribute('data'))

// Helper functions
// *** isSelfCollect and isStandard logics are tied to deliveryMode ID. careful.
function isSelfCollect(){
    return deliveryMode.value == 3
}

function isStandard(){
    return deliveryMode.value == 1
}

function validSelfCollect(){
    return isSelfCollect() && isValidPhone()
}

function validatePhoneNumber(){
    if (phoneNumber.value){}
}

function isValidPhone(){
    const num = phoneNumber.value
    return num.length > 10 && !isNaN(+ num) && num.length <=13 && ['601','+60'].includes(num.slice(0,3)) && [1,2,3,4,6,7,8,9,0].includes(parseInt(num[2]))
}

function generatePhoneErrors(){
    const phoneNumErrors = []
    const num = phoneNumber.value
    if (num.length <= 10 || num.length > 13) {
        phoneNumErrors.push('Phone Number must be around 10-12 numeric values, starting with +60 or 60')
    }

    if (isNaN(+ num)){
        phoneNumErrors.push('Phone Number must be numeric')
    }

    if (!['601','+60'].includes(num.slice(0,3)) || ![1,2,3,4,6,7,8,9,0].includes(parseInt(num[2]))){
        phoneNumErrors.push('Invalid Phone Number. Please enter with the format starting with +60 or 60.')
    }

    return phoneNumErrors
}

// For Singapore Phone Numbers
function isValidPhoneSG(){
    const num = phoneNumber.value
    return num.length > 9 && !isNaN(+ num) && num.length <=11 && ['65','+6'].includes(num.slice(0,2))
}

function generatePhoneErrorsSG(){
    const phoneNumErrors = []
    const num = phoneNumber.value
    if (num.length <= 9 || num.length > 11) {
        phoneNumErrors.push('Phone Number must be around 10-11 numeric values, starting with +65 or 65')
    }

    if (isNaN(+ num)){
        phoneNumErrors.push('Phone Number must be numeric')
    }

    if (!['65','+6'].includes(num.slice(0,2))){
        phoneNumErrors.push('Invalid Phone Number. Please enter with the format starting with +65 or 65.')
    }

    return phoneNumErrors
}

function showPhoneErrors(){
    const errors = generatePhoneErrors()
    if (errors.length> 0){
        phoneErrorMessage.textContent = errors[0]
    } else {
        phoneErrorMessage.textContent = ''
    }
}

function isAllValid(){
    return shippingAddress.value && deliveryMode.value && isValidPhone()
}

function redifyBorder(input){
    if (input == phoneNumber) {
        isValidPhone() ? input.classList.remove('border-red') : input.classList.add('border-red')
    } else {
        input.value ? input.classList.remove('border-red') : input.classList.add('border-red')
    }
}

function validateCheckout(){
    if (isSelfCollect()){
        shippingContainer.firstElementChild.firstElementChild.textContent = 'Billing address'
        document.getElementById('standard-note').hidden = true
        document.getElementById('self-collect-note').hidden = false
    } else if (isStandard()){
        document.getElementById('self-collect-note').hidden = true
        document.getElementById('standard-note').hidden = false
    }
    else {
        document.getElementById('standard-note').hidden = true
        document.getElementById('self-collect-note').hidden = true
        shippingContainer.firstElementChild.firstElementChild.textContent = 'Where should we send your order to?'
    }

    [shippingAddress,deliveryMode,phoneNumber].forEach(input => redifyBorder(input))

    shippingAddress.value ? customerInfoCard.hidden = false : customerInfoCard.hidden = true

    if (isAllValid()) {
        checkoutBtn.disabled = false
        message.textContent = ''
        message.hidden = true
    } else {
        checkoutBtn.disabled = true
        message.textContent = formMessage()
        message.hidden = false
    }

    setComment()
    setPhoneNumber()

    showPhoneErrors()
}

function formMessage(){
    return `(Please input ${shippingAddress.value ? "" : " Address,"} ${deliveryMode.value ? "" : "Delivery mode,"} ${isValidPhone() ? "" : "valid Phone Number"} before proceeding)`
}

function setAddressInfo(data) {
    infoCompanyName.textContent = data.company_name
}

function setComment(){
    comment = document.getElementById('order_remarks').value
    if (comment) {
        commentText.parentElement.hidden = false
        commentText.textContent = comment
    } else {
        commentText.parentElement.hidden = true
    }
}

function setPhoneNumber(){
    phoneNum = document.getElementById('order_notification_phone_number').value
    infoPhoneNumber.textContent = phoneNum
}

// Test: fix for iOS truncating text on <select> elements
function addOptGroup(){
    const optGroup = document.createElement('optgroup')
    optGroup.setAttribute('label',' ')
    shippingAddress.appendChild(optGroup)
}


// Event Listeners
deliveryMode.addEventListener('change',(e)=>{
    validateCheckout()
})

document.getElementById('order_remarks').addEventListener('change',() => {
    comment = document.getElementById('order_remarks').value
    if (comment) {
        commentText.parentElement.hidden = false
        commentText.textContent = comment
    } else {
        commentText.parentElement.hidden = true
    }
})


shippingAddress.addEventListener('change',(e) => {
    // document.querySelector("#customer_info_card").innerHTML = "<%= escape_javascript(render('orders/address_info'))%>"
    infoAddress.textContent = shippingAddress.value
    setAddressInfo(addressesData.find((info) => info.address === shippingAddress.value))
    validateCheckout()
})

phoneNumber.addEventListener('change',(e) => {
    validateCheckout()
})

// On Load
validateCheckout()
setComment()
setPhoneNumber()
if (shippingAddress.value) {
    infoAddress.textContent = shippingAddress.value
    setAddressInfo(addressesData.find((info) => info.address.replaceAll(/ /g,'') === shippingAddress.value.replaceAll(/ /g,'')))
}
addOptGroup()
