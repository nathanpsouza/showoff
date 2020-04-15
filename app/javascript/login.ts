import $ from 'jquery'

$(document).ready(() => {  
  $("#login-form").on("ajax:success", (event) => {
    const [data, status, xhr] = event.detail
    window.location.href = '/'
  }).on("ajax:error", (event) => {
    const [data, status, xhr] = event.detail
    $('#login-result-message').text(data.data)
    $('#login-result-message').show()
  })
})