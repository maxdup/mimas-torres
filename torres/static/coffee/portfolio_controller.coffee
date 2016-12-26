angular.module('folio.Controllers', ['ui.bootstrap', 'angularModalService'])

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

  $scope.$on('changebg', (event, bgid) ->
    if (currbgid != bgid)
      newmap = THREE.ImageUtils.loadTexture(scenes[bgid]);
      $scope.show = false
      $timeout( ->
        material.map = newmap
        $scope.show = true
        currbgid = bgid
      , 300);
      $scope.v360()
  )

  $scope.v360 = ->
    $scope.v360focus = !$scope.v360focus

  routes = ["/home","/commercial","/hobby/:map?","/code","/contact"]

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
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
($scope, $location, $http, $route, $routeParams, $rootScope, $window, ModalService) ->

  $scope.viewimagemodal = (image='') ->
    ModalService.showModal({
      templateUrl: "static/partials/modal_image.html",
      controller: "ModalController"
    }).then((modal) ->
      console.log(modal)
      modal.scope.image = image)

  $scope.viewcarouselmodal = (id='')->
    ModalService.showModal({
      templateUrl: "static/partials/modal_carousel.html",
      controller: "ModalController"
    }).then((modal) ->
      boxcarousel = $(".box-carousel"+id)[0]
      carousel = $(id + " > .slides_control")[0]
      overlay = document.getElementById("overlay")
      overlay.appendChild(carousel)
      modal.close.then((result) ->
        boxcarousel.appendChild(carousel)
      ))

  $scope.change360 = (bgid) ->
    $rootScope.$broadcast('changebg', bgid);

  mapnames = [
    "occult"
    "hadal"
    "effigy"]
  $scope.maps = [
    "static/partials/occult.html"
    "static/partials/hadal.html"
    "static/partials/effigy.html"]

  mapid = mapnames.indexOf($routeParams.map)
  if (mapid != -1)
    map = $scope.maps.splice(mapid,1)[0]
    $scope.maps.unshift(map)

  $scope.vanguard_imgs = [
    { image: 'static/images/vanguard/cp_vanguard_rc60.jpg'},
    { image: 'static/images/vanguard/cp_vanguard_rc61.jpg'},
    { image: 'static/images/vanguard/cp_vanguard_rc62.jpg'},
    { image: 'static/images/vanguard/cp_vanguard_rc63.jpg'},
    { image: 'static/images/vanguard/cp_vanguard_rc64.jpg'},
    ]
  $scope.hadal_imgs = [
    { image: 'static/images/hadal/cp_hadal_b130.jpg'},
    { image: 'static/images/hadal/cp_hadal_b131.jpg'},
    { image: 'static/images/hadal/cp_hadal_b132.jpg'},
    { image: 'static/images/hadal/cp_hadal_b133.jpg'},
    { image: 'static/images/hadal/cp_hadal_b134.jpg'},
    ]
  $scope.occult_imgs = [
    { image: 'static/images/occult/koth_occult_rc40.jpg'},
    { image: 'static/images/occult/koth_occult_rc41.jpg'},
    { image: 'static/images/occult/koth_occult_rc42.jpg'},
    { image: 'static/images/occult/koth_occult_rc43.jpg'},
    { image: 'static/images/occult/koth_occult_rc44.jpg'},
    ]
  $scope.effigy_imgs = [
    { image: 'static/images/effigy/pl_effigy_rc20.jpg'},
    { image: 'static/images/effigy/pl_effigy_rc21.jpg'},
    { image: 'static/images/effigy/pl_effigy_rc22.jpg'},
    { image: 'static/images/effigy/pl_effigy_rc23.jpg'},
    { image: 'static/images/effigy/pl_effigy_rc24.jpg'},
    ]

  $scope.layout = ->
    $('.boxes').isotope
      layoutMode: 'masonryHorizontal',
      itemSelector: '.box',
      masonryHorizontal: rowHeight: 200
    return
  $scope.layout()

  $(".content").mousewheel((event, delta) ->
    this.scrollLeft -= (delta * 30)
    event.preventDefault())

.controller('ModalController', ['$scope', 'close', ($scope, close) ->
    $scope.close = close
  ])
