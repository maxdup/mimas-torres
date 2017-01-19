angular.module('folio.rootController', ['ui.bootstrap', 'ngCookies'])

.controller 'RootController',
($scope, $location, $http, $route, $routeParams, $rootScope, $window, $cookies, $timeout, $translate) ->

  $scope.translate = (lang) ->
    $scope.active_lang = lang
    $translate.use(lang)
    $cookies.put('lang', lang)
  if $cookies.get('lang')
    $scope.translate($cookies.get('lang'))
  else
    $scope.active_lang = $translate.use()

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
      workid: 'cp_vanguard',
      level: 1,
      title: 'static/images/vanguard/vanguard.png',
      images: [
        { image: 'static/images/vanguard/cp_vanguard_rc60.jpg', id: 0},
        { image: 'static/images/vanguard/cp_vanguard_rc61.jpg', id: 1},
        { image: 'static/images/vanguard/cp_vanguard_rc62.jpg', id: 2},
        { image: 'static/images/vanguard/cp_vanguard_rc63.jpg', id: 3},
        { image: 'static/images/vanguard/cp_vanguard_rc64.jpg', id: 4},
        ],
      panorama: 'static/images/vanguard/cp_vanguard360.jpg',
    },
    hadal: {
      order: 2,
      partial: "static/partials/hadal.html",
      mdlurl: 'static/models/hadal.obj',
      targetid: 'hadal3d',
      mdlshow: false,
      workid: "804251853",
      level: 0,
      title: 'static/images/hadal/hadal.png',
      images: [
        { image: 'static/images/hadal/cp_hadal_b130.jpg', id: 0},
        { image: 'static/images/hadal/cp_hadal_b131.jpg', id: 1},
        { image: 'static/images/hadal/cp_hadal_b132.jpg', id: 2},
        { image: 'static/images/hadal/cp_hadal_b133.jpg', id: 3},
        { image: 'static/images/hadal/cp_hadal_b134.jpg', id: 4},
        ],
      panorama: 'static/images/hadal/cp_hadal360.jpg',
    },
    occult: {
      order: 1,
      partial: "static/partials/occult.html",
      mdlurl: 'static/models/occult.obj',
      targetid: 'occult3d',
      mdlshow: false,
      workid: "468770640",
      level: 0,
      title: 'static/images/occult/occult.png',
      images: [
        { image: 'static/images/occult/koth_occult_rc40.jpg', id: 0},
        { image: 'static/images/occult/koth_occult_rc41.jpg', id: 1},
        { image: 'static/images/occult/koth_occult_rc42.jpg', id: 2},
        { image: 'static/images/occult/koth_occult_rc43.jpg', id: 3},
        { image: 'static/images/occult/koth_occult_rc44.jpg', id: 4},
      ],
      panorama: 'static/images/vanguard/cp_vanguard360.jpg',
    },
    effigy: {
      order: 3,
      partial: "static/partials/effigy.html",
      workid: "543841027",
      level: 0,
      title: 'static/images/effigy/effigy.png',
      images: [
        { image: 'static/images/effigy/pl_effigy_rc20.jpg', id: 0},
        { image: 'static/images/effigy/pl_effigy_rc21.jpg', id: 1},
        { image: 'static/images/effigy/pl_effigy_rc22.jpg', id: 2},
        { image: 'static/images/effigy/pl_effigy_rc23.jpg', id: 3},
        { image: 'static/images/effigy/pl_effigy_rc24.jpg', id: 4},
      ],
      panorama: 'static/images/vanguard/cp_vanguard360.jpg',
    }
  }

  $scope.change360 = (map) ->
    $scope.controlsGlimpse = true
    $rootScope.$broadcast('changebg', map)
    $timeout( hidecontrols , 2000)

  hidecontrols = ->
    $scope.controlsGlimpse = false

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

  $scope.queue = ->
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

  $scope.v360inControl = false
  $scope.v360 = ->
    $scope.v360focus = !$scope.v360focus
    if !$scope.v360focus
      $scope.v360inControl = false

  routes = ["/home","/commercial","/hobby/:map?","/code","/contact"]

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
    $scope.isNavCollapsed = true
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
      $scope.v360inControl = true
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
    if !$scope.v360inControl
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

.directive("box3d", ($animate, $timeout) ->
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
      scope.closemodels = ->
        for k, v of scope.maps
          v['mdlshow'] = false
        return

      hidecontrols = ->
        scope.controlsGlimpse3d = false

      scope.openmodel = ->
        scope.closemodels()
        scope.maps[scope.map]['mdlshow'] = true
        scope.controlsGlimpse3d = true
        $timeout( hidecontrols , 2000)
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

.directive("boxMain", ->
  {
    restrict: 'E',
    templateUrl: 'static/partials/boxmain.html',
    scope: {
      map: '@',
      maps: '='
      }
  })
