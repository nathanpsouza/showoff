import $ from 'jquery'

$(document).ready(() => {
  
  $("#login-form").on("ajax:success", (event) => {
    const [data, status, xhr] = event.detail
    console.log(data)
  }).on("ajax:error", (event) => {
    const [data, status, xhr] = event.detail
    console.log(data)
  })
})