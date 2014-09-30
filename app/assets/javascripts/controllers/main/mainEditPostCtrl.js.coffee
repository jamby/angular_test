@EditPostCtrl = ($scope, $routeParams, $location, $q, postData) ->

  $scope.data =
    postData: postData.data
    currentPost: 
      title: ""
      contents: ""

  $scope.data.postId = $routeParams.postId

  $scope.formData = 
    editPostTitle: ''
    editPostContents: ''
    editPostId: $routeParams.postId

  $scope.newNavPost = ->
    $location.url('/post/new')

  $scope.navHome = ->
    $location.url('/')

  $scope.editPost = ->
    postData.editPost($scope.formData)
    $location.url("/post/" + $routeParams.postId)

  $scope.backPost = ->
    $location.url("/post/" + $routeParams.postId)

  # This will be run once the loadPosts successfully completes (or immediately if data is already loaded)
  $scope.prepPostData = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
    $scope.data.currentPost.title = post.title
    $scope.data.currentPost.contents = post.contents
    $scope.formData.editPostTitle = post.title
    $scope.formData.editPostContents = post.contents

  # Create promise to be resolved after posts load
  @deferred = $q.defer()
  @deferred.promise.then($scope.prepPostData)

  postData.loadPosts(@deferred)

@EditPostCtrl.$inject = ['$scope', '$routeParams', '$location', '$q', 'postData']

