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

// Event Listeners


// On Load
