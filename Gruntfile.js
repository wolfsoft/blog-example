module.exports = function(grunt) {

	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

		sass: {
			dist: {
				files: {
					'./bower_components/bootstrap-tags/dist/css/bootstrap-tags.css': './bower_components/bootstrap-tags/sass/bootstrap-tags.scss'
				}
			}
		},

		less: {
			development: {
				options: {
					compress: true
				},
				files: {
					"./public/assets/stylesheets/frontend.css": "./resources/assets/less/frontend.less",
					"./public/assets/stylesheets/backend.css": "./resources/assets/less/backend.less"
				}
			}
		},

		concat: {
			options: {
				separator: ';'
			},
			js_frontend: {
				src: [
					'./bower_components/jquery/dist/jquery.js',
					'./bower_components/bootstrap/dist/js/bootstrap.js',
					'./resources/assets/javascript/frontend.js'
				],
				dest: './public/assets/javascript/frontend.js'
			},
			js_backend: {
				src: [
					'./bower_components/jquery/dist/jquery.js',
					'./bower_components/bootstrap/dist/js/bootstrap.js',
					'./bower_components/bootstrap-tags/dist/js/bootstrap-tags.js',
					'./bower_components/summernote/dist/summernote.js',
					'./resources/assets/javascript/backend.js'
				],
				dest: './public/assets/javascript/backend.js'
			}
		},

		copy: {
			main: {
				files: [{
					expand: true,
					flatten: true,
					src: [
						'./bower_components/fontawesome/fonts/*',
						'./bower_components/bootstrap/fonts/*'
					],
					dest: './public/assets/fonts/'
				}]
			}
		},

		uglify: {
			options: {
				mangle: false
			},
			frontend: {
				files: {
					'./public/assets/javascript/frontend.min.js': './public/assets/javascript/frontend.js'
				}
			},
			backend: {
				files: {
					'./public/assets/javascript/backend.min.js': './public/assets/javascript/backend.js'
				}
			}
		},

		devUpdate: {
		    main: {
		        options: {
					semver: false,
					packages: {
						devDependencies: true,
						dependencies: true
					}
		        }
		    }
		}

	});

	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-sass');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-dev-update');

	grunt.registerTask('default', ['sass', 'less', 'copy', 'concat', 'uglify']);

};
