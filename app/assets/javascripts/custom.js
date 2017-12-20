document.addEventListener("turbolinks:load", function(){

    $(".button-collapse").sideNav({
      menuWidth: 200, // Default is 300
      edge: 'right', // Choose the horizontal origin
      closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
      draggable: true, // Choose whether you can drag to open on touch screens,
    });
    
    
    
    $(".dropdown-button").dropdown();
    
    var dis1 = document.getElementById('upload_field');
    dis1.onchange = function () {
     if (this.value != "" || this.value.length > 0) {
        document.getElementById("link_field").disabled = true;
      }
    };
    
    
    var dis2 = document.getElementById("link_field");
    dis2.onchange = function () {
      if (this.value != "" || this.value.length > 0) {
        document.getElementById('upload_field').disabled = true;
      }
    };
    
    var reset = document.getElementById('form_reset');
    reset.onclick = function () {
        document.getElementById('upload_field').removeAttribute('disabled');
        document.getElementById('upload_field').value = '';
        document.getElementById('link_field').removeAttribute('disabled');
        document.getElementById('link_field').value = '';
    };
    
});