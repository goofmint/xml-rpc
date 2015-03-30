document.addEventListener("deviceready", onDeviceReady, false)
onDeviceReady = ->
  connection = 
    url:      'http://153.120.17.226/xmlrpc.php'
    username: 'moongift'
    password: 'Lq2l2Eic14De'
  wp = new WordPress(connection.url, connection.username, connection.password)
  $("#file").on "change", (e) ->
    file = e.target.files[0]
    fr = new FileReader()
    fr.onload = (e) ->
      $("#photo").val(e.target.result)
    fr.readAsDataURL(file)
  
  $("form").on "submit", (e) ->
    e.preventDefault()
    form = $(e.target)
    console.log(form.find("#photo").val())
    console.log(atob(form.find("#photo").val().split(',')[1]))
    console.log(new Base64(atob(form.find("#photo").val().split(',')[1])))
    base64 = new Base64(atob(form.find("#photo").val().split(',')[1]));
    file_name = $("#file")[0].value.replace(/.*\\/, "")
    file_hash =
      name: file_name
      bits: base64
      type: 'image/png'
    file = wp.uploadFile(1, file_hash)
    url = file.url.concat()
    content = "<img src='#{url}' /><br />#{form.find('textarea').val()}"
    post = wp.newPost 1, 
      post_title: form.find("input[name='title']").val()
      post_content: content.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
      post_status: 'publish'
    alert("投稿完了しました")
onDeviceReady()