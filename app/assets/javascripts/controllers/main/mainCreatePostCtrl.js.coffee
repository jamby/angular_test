@CreatePostCtrl = ($scope, $location, postData) ->

  $scope.data = postData
  postData.loadPosts(null)

  $scope.formData = 
    newPostTitle: ''
    newPostContents: ''

  $scope.newNavPost = ->
    $location.url('/post/new')

  $scope.navHome = ->
    $location.url('/')

  $scope.createPost = ->
    postData.createPost($scope.formData)
    $scope.navHome()

  $scope.clearPost = ->
    $scope.formData.newPostTitle = ''
    $scope.formData.newPostContents = ''

@CreatePostCtrl.$inject = ['$scope', '$location', 'postData']
