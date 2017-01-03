angular.module('folio.rootController', ['ui.bootstrap'])

.controller 'RootController',
($scope, $location, $http, $route, $rootScope, $window, $timeout) ->

  camera = null
  scene = null
  renderer = null
  mesh = null
  material = null
  isUserInteracting = false
  onPointerDownPointerX = 0
  onPointerDownPointerY = 0
  onPointerDownLon = 0
  onPointerDownLat = 0
  lon = 0
  onMouseDownLon = 0
  lat = 0
  onMouseDownLat = 0
  phi = 0
  theta = 0

  currbgid = 0

  $scope.show = true

  scenes = ['static/images/vanguard/cp_vanguard360.jpg',
    'static/images/vanguard/cp_vanguard360alt.jpg',
    'static/images/vanguard/cp_vanguard360alt2.jpg',
    ]

  $scope.v360 = ->
    $scope.v360focus = !$scope.v360focus

  $scope.change360 = (bgid) ->
    $rootScope.$broadcast('changebg', bgid);

  $scope.$on('changebg', (event, bgid) ->
    if (currbgid != bgid)
      newmap = THREE.ImageUtils.loadTexture(scenes[bgid]);
      $scope.show = false
      $timeout( ->
        material.map = newmap
        $scope.show = true
        currbgid = bgid
      , 300)
    $scope.v360())

  routes = ["/home","/commercial","/hobby/:map?","/code","/con7tact"]

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
    if !current
      return
    $scope.reverse = (routes.indexOf(current['$$route']['originalPath']) > routes.indexOf(next['$$route']['originalPath']))

  $scope.$on '$locationChangeStart', (event, next, current) ->
    if ($scope.v360focus)
      $scope.v360()
      event.preventDefault()

  $scope.isActive = (viewLocation) ->
    $location.path().startsWith(viewLocation)

  $scope.init = ->

    camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 )
    camera.target = new THREE.Vector3( 0, 0, 0 )
    camera.position.z = -100
    camera.lookAt( camera.target )
    scene = new THREE.Scene()

    geometry = new THREE.SphereGeometry(500,60,40)
    geometry.scale(-1, 1, 1)
    material = new THREE.MeshBasicMaterial({
    map: new THREE.TextureLoader().load(scenes[0])} )
    mesh = new THREE.Mesh(geometry, material)

    scene.add(mesh)

    renderer = new THREE.WebGLRenderer()

    renderer.setPixelRatio(window.devicePixelRatio)
    renderer.setSize( window.innerWidth, window.innerHeight )
    tdcontainer = document.getElementById("portfolio")
    tdcontainer.appendChild( renderer.domElement )

    document.addEventListener( 'mousedown', onDocumentMouseDown, false )
    document.addEventListener( 'mousemove', onDocumentMouseMove, false )
    document.addEventListener( 'mouseup', onDocumentMouseUp, false )
    document.addEventListener( 'wheel', onDocumentMouseWheel, false )

  onDocumentMouseDown = (event) ->
    if $scope.v360focus
      event.preventDefault()
      isUserInteracting = true;
      onPointerDownPointerX = event.clientX
      onPointerDownPointerY = event.clientY
      onPointerDownLon = lon
      onPointerDownLat = lat

  onDocumentMouseUp = (event) ->
    isUserInteracting = false

  onDocumentMouseMove = (event) ->
    if isUserInteracting and $scope.v360focus
      lon = (onPointerDownPointerX - event.clientX ) * 0.1 + onPointerDownLon;
      lat = (event.clientY - onPointerDownPointerY ) * 0.1 + onPointerDownLat;

  onDocumentMouseWheel = (event) ->
    if $scope.v360focus
      camera.fov = Math.max(Math.min(camera.fov + event.deltaY * 0.05, 120),60)
      camera.updateProjectionMatrix()

  $scope.animate = ->
    requestAnimationFrame($scope.animate)
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
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize( window.innerWidth, window.innerHeight))

.controller('ModalController', ['$scope', 'close', ($scope, close) ->
    $scope.close = close
  ])

.directive("box3d", ($animate) ->
  {
    restrict: 'E',
    templateUrl: 'static/partials/box3d.html',
    replace: true,
    scope: {
      map: '@',
      maps: '='
      }

    link: (scope, element) ->
      scope.$emit('isotopeReload')
      scope.openmodel = ->
        for k, v of scope.maps
          v['mdlshow'] = false
        scope.maps[scope.map]['mdlshow'] = true
        return

      scope.$watch("maps."+scope.map+".mdlshow", (show, oldShow) ->
        if (!show)
          $animate.removeClass(element, 'big').then(layout)
          $animate.removeClass(element.find('.box-3d'), 'big').then(clearCanvas)

        if (show)
          $animate.addClass(element, 'big').then(layout)
          $animate.addClass(element.find('.box-3d'), 'big').then(init3d)
      )

      layout = ->
        scope.$emit('isotopeLayout')
      init3d = ->
        scope.$emit('init3d', scope.map)
      clearCanvas = ->
        element.find('canvas').remove()
  })
