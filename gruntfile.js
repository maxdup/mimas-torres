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
    watch :{
      coffee: {
        files: ['**/*.coffee'],
        tasks: ['coffee'],
      },
      less: {
        files: ['**/*.less'],
        tasks: ['less'],
      }
    }
  });
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.registerTask('default', ['watch'])
};
