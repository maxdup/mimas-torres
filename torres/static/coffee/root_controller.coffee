angular.module('folio.rootController', ['ui.bootstrap'])

.controller 'RootController',
($scope, $location, $http, $route, $routeParams, $rootScope, $window, $timeout) ->

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

  currmap = 'vanguard'

  $scope.show = true

  $scope.maps = {
    vanguard: {
      order: 0,
      partial: "static/partials/vanguard.html",
      mdlurl: 'static/models/hadal.obj',
      targetid: 'vanguard3d',
      mdlshow: false,
      startup: 'cp_vanguard',
      level: 1,
      images: [
        { image: 'static/images/vanguard/cp_vanguard_rc60.jpg'},
        { image: 'static/images/vanguard/cp_vanguard_rc61.jpg'},
        { image: 'static/images/vanguard/cp_vanguard_rc62.jpg'},
        { image: 'static/images/vanguard/cp_vanguard_rc63.jpg'},
        { image: 'static/images/vanguard/cp_vanguard_rc64.jpg'},
        ],
      panorama: 'static/images/vanguard/cp_vanguard360.jpg',
    },
    hadal: {
      order: 2,
      partial: "static/partials/hadal.html",
      mdlurl: 'static/models/hadal.obj',
      targetid: 'hadal3d',
      mdlshow: false,
      startup: "workshop%2f804251853",
      level: 0,
      images: [
        { image: 'static/images/hadal/cp_hadal_b130.jpg'},
        { image: 'static/images/hadal/cp_hadal_b131.jpg'},
        { image: 'static/images/hadal/cp_hadal_b132.jpg'},
        { image: 'static/images/hadal/cp_hadal_b133.jpg'},
        { image: 'static/images/hadal/cp_hadal_b134.jpg'},
        ]
      panorama: 'static/images/vanguard/cp_vanguard360.jpg',
    },
    occult: {
      order: 1,
      partial: "static/partials/occult.html",
      mdlurl: 'static/models/occult.obj',
      targetid: 'occult3d',
      mdlshow: false,
      startup: "workshop%2f468770640",
      level: 0,
      images: [
        { image: 'static/images/occult/koth_occult_rc40.jpg'},
        { image: 'static/images/occult/koth_occult_rc41.jpg'},
        { image: 'static/images/occult/koth_occult_rc42.jpg'},
        { image: 'static/images/occult/koth_occult_rc43.jpg'},
        { image: 'static/images/occult/koth_occult_rc44.jpg'},
      ]
      panorama: 'static/images/vanguard/cp_vanguard360.jpg',
    },
    effigy: {
      order: 3,
      partial: "static/partials/effigy.html",
      startup: "workshop%2f543841027",
      level: 0,
      images: [
        { image: 'static/images/effigy/pl_effigy_rc20.jpg'},
        { image: 'static/images/effigy/pl_effigy_rc21.jpg'},
        { image: 'static/images/effigy/pl_effigy_rc22.jpg'},
        { image: 'static/images/effigy/pl_effigy_rc23.jpg'},
        { image: 'static/images/effigy/pl_effigy_rc24.jpg'},
      ],
      panorama: 'static/images/vanguard/cp_vanguard360.jpg',
    }
  }

  $scope.change360 = (map) ->
    $rootScope.$broadcast('changebg', map)

  $scope.$on('changebg', (event, map) ->
    if (currmap != map)
      newmap = THREE.ImageUtils.loadTexture($scope.maps[map]['panorama'])
      $scope.show = false
      $timeout( ->
        material.map = newmap
        $scope.show = true
        currmap = map
      , 300)
    $scope.v360())

  if $location['$$path'].startsWith('/hobby')
    front = {}
    $scope.mapsQueue = []
    for k, v of $scope.maps
      if(v['level'] == 0)
        if k == $routeParams.map
            front = v
        else
          $scope.mapsQueue.push(v)
    $scope.mapsQueue.sort((a, b) -> return a['order']-b['order'])
    if front
      $scope.mapsQueue.unshift(front)

  $scope.v360 = ->
    $scope.v360focus = !$scope.v360focus

  routes = ["/home","/commercial","/hobby/:map?","/code","/contact"]

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
    if !current
      return
    for k, v of $scope.maps
      v['mdlshow'] = false

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
      map: new THREE.TextureLoader().load($scope.maps[currmap]['panorama'])})
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
    renderer.setSize( window.innerWidth, window.innerHeight)
  )

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
