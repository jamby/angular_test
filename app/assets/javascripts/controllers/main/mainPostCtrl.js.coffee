@PostCtrl = ($scope, $routeParams, $location, $q, postData) ->

  $scope.data = 
    postData: postData.data
    currentPost:
      title: "Loading..."
      contents: ""
      
  $scope.formData = 
    editPostTitle: ''
    editPostContents: ''
    editPostId: $routeParams.postId

  $scope.data.postId = $routeParams.postId
  $scope.formShown = false

  $scope.navNewPost = ->
    $location.url('/post/new')

  $scope.navHome = ->
    $location.url('/')
  
  $scope.editPost = ->
    secondDeferred = $q.defer()
    secondDeferred.promise.then($scope.formShown = false).then($scope.prepPostData)
    postData.editPost($scope.formData, secondDeferred)

  $scope.deletePost = ->
    deleteDeferred = $q.defer()
    deleteDeferred.promise.then($scope.navHome)
    postData.deletePost($scope.data.postId, deleteDeferred)

  # This will be run once the loadPosts successfully completes (or immediately if data is already loaded)
  $scope.prepPostData = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
    $scope.data.currentPost.title = post.title
    $scope.data.currentPost.contents = post.contents
    $scope.formData.editPostTitle = post.title
    $scope.formData.editPostContents = post.contents
    
  $scope.toggleForm = ->
    $scope.formShown = !$scope.formShown
    
  $scope.returnData = ->
    $scope.formData.editPostTitle = $scope.data.currentPost.title
    $scope.formData.editPostContents = $scope.data.currentPost.contents

  # Create promise to be resolved after posts load
  @deferred = $q.defer()
  @deferred.promise.then($scope.prepPostData)

  postData.loadPosts(@deferred)

@PostCtrl.$inject = ['$scope', '$routeParams', '$location', '$q', 'postData']
