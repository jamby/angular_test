angular.module('Blog').factory('postData', ['$http', ($http) ->

  postData =
    data:
      posts: [{title: "Loading", contents: ""}]
    isLoaded: false

  postData.loadPosts = (deferred) ->
    if !postData.isLoaded
      $http.get('./posts.json').success( (data) ->
        postData.data.posts = data
        console.log postData.data
        postData.isLoaded = true
        console.log('Successfully loaded posts.')
        if deferred
          deferred.resolve()
      ).error( ->
        console.log('Failed to load posts')
        if deferred
          deferred.resolve()
      )
    else
      if deferred
        deferred.resolve()

  postData.createPost = (newPost) ->
    # Client-side data validation
    if newPost.newPostTitle == '' || newPost.newPostContents == ''
      alert("Neither the Title or the Body are allowed to be left blank.")
      return false

    # Create data object to POST
    data = 
      post:
        title: newPost.newPostTitle
        contents: newPost.newPostContents

    # Do POST request to /posts.json
    $http.post('./posts.json', data).success( (data) ->

      # Add new post to array of posts
      postData.data.posts.push(data)
      console.log("Successfully created post.")
    ).error( ->
      console.error("Failed to create new post.")
    )

    return true

  postData.editPost = (editPost, secondDeferred) ->
    # Client-side data validation
    if editPost.editPostTitle == '' || editPost.editPostContents == ''
      alert("Neither the Title nor the Body are allowed to be left blank.")
      return false

    # Create data object to PUT
    data =
      post:
        title: editPost.editPostTitle
        contents: editPost.editPostContents
        id: editPost.editPostId

    # Do PUT request to /posts.json
    $http.put('./posts/'+ editPost.editPostId + '.json', data).success( (data) ->

      # Update post
      post = _.findWhere(postData.data.posts, { id: parseInt(editPost.editPostId) })
      post.title = data.title
      post.contents = data.contents
      console.log("Successfully edited post.")
      if secondDeferred
        secondDeferred.resolve()
    ).error( ->
      console.error("Failed to edit post.")
      if secondDeferred
        secondDeferred.resolve()      
    )

  return postData

])
