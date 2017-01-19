angular.module('folio.Controllers', ['ui.bootstrap', 'angularModalService'])

.controller 'FolioController',
($scope, $location, $http, $route, $routeParams, $rootScope, $window, $timeout, $document, ModalService) ->

  $scope.queue()
  $scope.layout = ->
    $('.boxes').isotope
      layoutMode: 'masonryHorizontal',
      itemSelector: '.box',
      masonryHorizontal: rowHeight: 200
    return
  $scope.layout()

  $scope.reload = ->
    $('.boxes').isotope('reloadItems')
    $scope.layout()

  $scope.$on 'isotopeReload', (event, next, current) ->
    $scope.reload()
  $scope.$on 'isotopeLayout', (event, next, current) ->
    $scope.layout()

  $('.box-photo').imagefill({runOnce:true});

  $(".content").mousewheel((event, delta) ->
    this.scrollLeft -= (delta * 10)
    event.preventDefault())

  $scope.viewimagemodal = (image='') ->
    ModalService.showModal({
      templateUrl: "static/partials/modal_image.html",
      controller: "ModalController"
    }).then((modal) ->
      $scope.modal = modal
      $scope.modalactive = true
      modal.scope.image = image
      modal.close.then((result) ->
        $scope.modalactive = false))

  $scope.viewcarouselmodal = (id='')->
    ModalService.showModal({
      templateUrl: "static/partials/modal_carousel.html",
      controller: "ModalController"
    }).then((modal) ->
      $scope.modal = modal
      $scope.modalactive = true
      boxcarousel = $(".box-carousel"+id)[0]
      carousel = $(id + " > .slides_control")[0]
      overlay = document.getElementById("overlay")
      overlay.appendChild(carousel)
      modal.close.then((result) ->
        $scope.modalactive = false
        boxcarousel.appendChild(carousel)
      ))

  $scope.$on '$locationChangeStart', (event, next, current) ->
    if ($scope.modalactive == true)
      $scope.modalactive = false
      $scope.modal.scope.close()
      event.preventDefault()

  camera = null
  controls = null
  scene = null
  renderer = null
  material = null
  light = null

  SCREEN_WIDTH = ''
  SCREEN_HEIGHT = ''
  SHADOW_MAP_WIDTH = 1024
  SHADOW_MAP_HEIGHT = 1024
  lightShadowMapViewer = null
  showHUD = false

  $scope.$on 'init3d', (event, id) ->
    container = document.getElementById($scope.maps[id]['targetid'])

    SCREEN_WIDTH = container.offsetWidth
    SCREEN_HEIGHT = container.offsetHeight

    scene = new THREE.Scene()
    scene.fog = new THREE.FogExp2( 0x444444, 2 )

    ambient = new THREE.AmbientLight( 0x555555 )
    scene.add( ambient )

    light = new THREE.PointLight( 0xffffff, 5, 1000, 2)
    light.position.set( 200, 300, 0 )
    scene.add(light)

    light = new THREE.SpotLight( 0xffffff, 1, 0, Math.PI / 2 )
    light.position.set( 200, 900, 900 )
    light.target.position.set( 0, 0, 0 )
    light.castShadow = true
    light.shadow = new THREE.LightShadow( new THREE.PerspectiveCamera( 50, 1, 1200, 2500 ) )
    light.shadow.bias = 0.0001
    light.shadow.mapSize.width = SHADOW_MAP_WIDTH
    light.shadow.mapSize.height = SHADOW_MAP_HEIGHT
    scene.add( light )

    #createHUD()

    material = new THREE.MeshPhongMaterial( { color:0xffffff } )

    manager = new THREE.LoadingManager()
    loader = new THREE.OBJLoader( manager )
    loader.load($scope.maps[id]['mdlurl'], ( object ) ->
      object.traverse( ( child ) ->
        if ( child instanceof THREE.Mesh )
          child.material = material
          child.castShadow = true
          child.receiveShadow = true

      )
      object.scale.set(0.1, 0.1, 0.1)
      object.position.y = - 95

      scene.add( object )
      $scope.$broadcast('mdlloaded')
    , null, null)


    renderer = new THREE.WebGLRenderer( { antialias: true } )
    renderer.setClearColor( scene.fog.color )
    renderer.setPixelRatio( window.devicePixelRatio )
    renderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT )
    renderer.autoClear = false

    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFShadowMap;

    camera = new THREE.OrthographicCamera(SCREEN_WIDTH / - 2, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, SCREEN_HEIGHT / - 2, - 500, 1000)
    camera.target = new THREE.Vector3( 0, 0, 0 )
    camera.position.x = -300
    camera.position.y = 300
    camera.position.z = 300
    camera.lookAt( camera.target )

    controls = new THREE.OrbitControls( camera, renderer.domElement )
    controls.enableDamping = true
    controls.dampingFactor = 0.1
    controls.enableZoom = false

    canvas = angular.element(renderer.domElement)
    wrapcontainer = angular.element(container)
    wrapcontainer.append(renderer.domElement)

    animate()

  animate = ->
    requestAnimationFrame(animate)
    render()

  render = ->
    controls.update()
    renderer.clear()
    renderer.render( scene, camera )

    if ( showHUD )
      lightShadowMapViewer.render( renderer )

  #shadow maps debug
  createHUD = ->
    lightShadowMapViewer = new THREE.ShadowMapViewer(light)
    lightShadowMapViewer.position.x = 10
    lightShadowMapViewer.position.y = SCREEN_HEIGHT - ( SHADOW_MAP_HEIGHT / 4 ) - 10
    lightShadowMapViewer.size.width = SHADOW_MAP_WIDTH / 4
    lightShadowMapViewer.size.height = SHADOW_MAP_HEIGHT / 4
    lightShadowMapViewer.update()
