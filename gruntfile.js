module.exports = function(grunt){
  pkg: grunt.file.readJSON('package.json'),

  grunt.initConfig({
    coffee: {
      app: {
        files: [{
          expand: true,
          cwd: 'torres/static/coffee/',
          src: ['*.coffee','!.*.coffee'],
          dest: 'torres/static/js/',
          ext: '.js'
        }],
        options:{
          header:true
        }
      }
    },
    less: {
      app: {
        files: [{
          expand: true,
          cwd: 'torres/static/less/',
          src: ['*.less', '!.*.less'],
          dest: 'torres/static/css/',
          ext: '.css'
        }]
      }
    },
    concat: {
      main: {
        src: [
          'torres/static/js/folioapp.js',
          'torres/static/js/root_controller.js',
          'torres/static/js/portfolio_controller.js',
          'torres/static/js/portfolio_locale.js',
        ],
        dest: 'torres/static/js/main.js',
      },
      angular: {
        src: [
          'torres/static/bower_components/angular/angular.js',
          'torres/static/bower_components/angular-animate/angular-animate.js',
          'torres/static/bower_components/angular-route/angular-route.js',
          'torres/static/bower_components/angular-cookies/angular-cookies.js',
          'torres/static/bower_components/angular-resource/angular-resource.min.js',
          'torres/static/bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js',
          'torres/static/bower_components/angular-modal-service/dst/angular-modal-service.min.js',
          'torres/static/bower_components/angular-translate/angular-translate.min.js',
        ],
        dest: 'torres/static/js/angular.js',
      },
      three: {
        src: [
          'torres/static/bower_components/three.js/build/three.min.js',
          'torres/static/bower_components/three.js/examples/js/loaders/OBJLoader.js',
          'torres/static/bower_components/three.js/examples/js/loaders/MTLLoader.js',
          'torres/static/bower_components/three.js/examples/js/controls/OrbitControls.js',
          'torres/static/bower_components/three.js/examples/js/renderers/CanvasRenderer.js',
          'torres/static/bower_components/three.js/examples/js/renderers/Projector.js',
        ],
        dest: 'torres/static/js/three.js',
      },
      meta: {
        src: [
          'torres/static/bower_components/isotope/dist/isotope.pkgd.min.js',
          'torres/static/bower_components/masonry/dist/masonry.pkgd.js',
          'torres/static/bower_components/isotope-masonry-horizontal/masonry-horizontal.js',
        ],
        dest: 'torres/static/js/meta.js',
      },
      extras: {
        src: [
          'torres/static/bower_components/jquery-mousewheel/jquery.mousewheel.min.js',
          'torres/static/bower_components/imagesloaded/imagesloaded.pkgd.js',
          'torres/static/bower_components/imagefill/js/jquery-imagefill.js',
        ],
        dest: 'torres/static/js/jqextras.js',
      }
    },
    uglify: {
      options: {
        mangle: false
      },
      js : {
        files: {
          'torres/static/js/main.min.js': ['torres/static/js/main.js']
        }
      }
    },
    cssmin: {
      options: {
        mergeIntoShorthands: false,
        roundingPrecision: -1
      },
      target: {
        files: {
          'torres/static/css/main.min.css': [
            'torres/static/bower_components/reset-css/reset.css',
            'torres/static/bower_components/bootstrap/dist/css/bootstrap.min.css',
            'torres/static/css/main.css'
          ]
        }
      }
    },
    copy: {
      main: {
        files: [
          {expand: true,
           cwd: 'torres/static/bower_components/bootstrap/fonts/',
           src: ['*'],
           dest: 'torres/static/fonts/',
           filter: 'isFile'}
        ]
      }
    },
    watch :{
      coffee: {
        files: ['**/*.coffee'],
        tasks: ['coffee', 'concat:main', 'uglify'],
      },
      less: {
        files: ['**/*.less'],
        tasks: ['less', 'cssmin'],
      }
    }
  });
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.registerTask('build', ['copy', 'less', 'cssmin', 'coffee', 'concat', 'uglify']);
  grunt.registerTask('default', ['watch']);
};
