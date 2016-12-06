angular.module('folio.Controllers', [])

.controller 'RootController',
($scope, $location, $http, $route, $rootScope, $window) ->
  
  camera = null
  scene = null
  renderer = null
  isUserInteracting = false
  onMouseDownMouseX = 0
  onMouseDownMouseY = 0
  lon = 0
  onMouseDownLon = 0
  lat = 0
  onMouseDownLat = 0
  phi = 0
  theta = 0
  

  $scope.init = ->
    
    camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 )
    camera.target = new THREE.Vector3( 0, 0, 0 )
    camera.position.z = -100
    camera.lookAt( camera.target )
    scene = new THREE.Scene()

    geometry = new THREE.SphereGeometry(500,60,40)
    geometry.scale(-1, 1, 1)
    material = new THREE.MeshBasicMaterial({
    map: new THREE.TextureLoader().load('static/images/vanguard360.jpg')} )
    mesh = new THREE.Mesh(geometry, material)

    scene.add(mesh)

    renderer = new THREE.WebGLRenderer()

    renderer.setPixelRatio(window.devicePixelRatio)
    renderer.setSize( window.innerWidth, window.innerHeight )
    tdcontainer = document.getElementById("portfolio")
    tdcontainer.appendChild( renderer.domElement )


  $scope.animate = ->
    requestAnimationFrame( $scope.animate )
    $scope.update()


  $scope.update = ->
    lon += 0.03;

    lat = Math.max( - 85, Math.min( 85, lat ) )
    phi = THREE.Math.degToRad( 90 - lat )
    theta = THREE.Math.degToRad( lon )
    camera.target.x = 500 * Math.sin( phi ) * Math.cos( theta )
    camera.target.y = 500 * Math.cos( phi )
    camera.target.z = 500 * Math.sin( phi ) * Math.sin( theta )

    camera.lookAt( camera.target )
    renderer.render( scene, camera )

  $scope.init()
  $scope.animate()

  w = angular.element($window)
  w.bind( 'resize', ->
    console.log("resize")
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize( window.innerWidth, window.innerHeight))


.controller 'FolioController',
($scope, $location, $http, $route, $rootScope, $window) ->
  return
