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

  $(".content").mousewheel((event, delta) ->
    this.scrollLeft -= (delta * 60)
    event.preventDefault())

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
      mdlurl: 'static/models/vanguard.obj',
      mtlurl: 'static/models/vanguard.mtl',
      mdlents: [
        ['cn', 0, 0, 103],
        ['cr', 1936, -400, 324],
        ['cr', 4096, -1216, 319],
        ['cb', -1936, 400, 324],
        ['cb', -4096, 1216, 319],
        ['rr', 5300, -950, 310],
        ['rb', -5300, 950, 310],
        ['ph', 1265, -548, 109],
        ['pa', 1265, -484, 109],
        ['ph', 528, 224, 26],
        ['pa', 528, 120, 26],
        ['ph', 92, 528, 202],
        ['pa', 196, 528, 202],
        ['ph', 1810, 720, 138],
        ['pa', 1700, 720, 138],
        ['ph', 2150, -820, 60],
        ['pa', 2150, -716, 60],
        ['pa', 1948, -1760, 250],
        ['ph', 1844, -1760, 250],
        ['ph', 3008, -1248, 246],
        ['pa', 3154, -480, 246],
        ['ph', 3488, 64, 187],
        ['pa', 3392, -416, 179],
        ['pa', 3568, -580, 394],
        ['ph', 3568, -684, 394],
        ['ph', -1265, 548, 109],
        ['pa', -1265, 484, 109],
        ['ph', -528, -224, 26],
        ['pa', -528, -120, 26],
        ['ph', -92, -528, 202],
        ['pa', -196, -528, 202],
        ['ph', -1810, -720, 138],
        ['pa', -1700, -720, 138],
        ['ph', -2150, 820, 60],
        ['pa', -2150, 716, 60],
        ['pa', -1948, 1760, 250],
        ['ph', -1844, 1760, 250],
        ['ph', -3008, 1248, 246],
        ['pa', -3154, 480, 246],
        ['ph', -3488, -64, 187],
        ['pa', -3392, 416, 179],
        ['pa', -3568, 580, 394],
        ['ph', -3568, 684, 394],

      ]
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
      mtlurl: 'static/models/hadal.mtl',
      mdlents: [
        ['c1', -1664, -622, 396],
        ['c2', 1828, 292, 512],
        ['c3', -912, 1680, 544],
        ['c4', 352, 512, 614],
        ['rb', 128, -2647, 14],
        ['rr', -576, -104, 112],
        ['pa', -946, 448, 567],
        ['ph', -1054, 448, 567],
        ['ph', 976, -1012, 493],
        ['pa', 976, -898, 493],
        ['pa', 290, 1036, 398],
        ['ph', 414, 1036, 398],
        ['ph', 1146, 1256, 589],
        ['pa', 1234, 1149, 589],
        ['ph', -1792, 1584, 565],
        ['ph', -1104, 1824, 465],
        ['ph', -25, 185, 277],
        ['pa', 60, 100, 277],
        ['pa', 2064, -16, 397],
        ['ph', 2080, -902, 397],
        ['ph', -1536, -2016, 174],
        ['pa', -1280, -1312, 13],
        ['pa', -2000, -272, 267],
        ['pa', -1080, 1848, 616],
        ['ph', 1008, 400, 397],
        ['pa', 1240, -472, 468],
        ['ph', 1280, -744, 205],
        ['pa', 960, -1404, 212],
        ['ph', 1216, 128, 465],

      ]
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
      mtlurl: 'static/models/occult.mtl',
      mdlents: [
        ["cn", 0,0,70],
        ["pa", 544, 624, -41],
        ["ph", -328, 96, -126],
        ["pa", 1216, -130, -160],
        ["ph", 1216, -254, -160],
        ["pa", -30, 1152, -33],
        ["ph", 94, 1152, -27],
        ["pa", -544, -624, -41],
        ["ph", 328, -96, -126],
        ["pa", -1216, 130, -160],
        ["ph", -1216, 254, -160],
        ["pa", 30, -1152, -33],
        ["ph", -94, -1152, -27],
        ["rr", -1368, -3568, 122],
        ["rb", 1368, 3568, 122],
      ],
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
      panorama: 'static/images/occult/koth_occult360.jpg',
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
      panorama: 'static/images/effigy/pl_effigy360.jpg',
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
    if !current || !current['$$route']
      return
    for k, v of $scope.maps
      v['mdlshow'] = false

    $scope.reverse = (routes.indexOf(current['$$route']['originalPath']) > routes.indexOf(next['$$route']['originalPath']))

  $scope.$on '$locationChangeStart', (event, next, current) ->
    if ($scope.v360focus)
      $scope.v360()
      event.preventDefault()

  $scope.isActive = (viewLocation) ->
    $location.path().indexOf(viewLocation) == 0

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
        scope.loaded = false
        for k, v of scope.maps
          v['mdlshow'] = false
        return

      hidecontrols = ->
        scope.controlsGlimpse3d = false

      scope.openmodel = ->
        scope.closemodels()
        scope.maps[scope.map]['mdlshow'] = true
        return

      scope.$on('mdlloaded', (event) ->
        scope.controlsGlimpse3d = true
        scope.loaded = true
        scope.$apply()
        $timeout( hidecontrols , 2000)
        return
      )

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
