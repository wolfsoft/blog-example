module.exports = function(grunt) {

	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

		less: {
			development: {
				options: {
					compress: true,
					paths: "./bower_components"
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
					'./bower_components/typeahead.js/dist/typeahead.bundle.js',
					'./bower_components/bootstrap-tokenfield/dist/bootstrap-tokenfield.js',
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

		critical: {
			test: {
				options: {
					base: './public/',
					minify: true,
					css: [
						'./public/assets/stylesheets/frontend.css'
					],
					width: 1300,
					height: 500
				},
				src: './resources/example.html',
				dest: './public/assets/stylesheets/critical.css'
			}
		},

		exec: {
			gzip: "find ./public -type f ! -name '*.gz' -exec gzip -f -k -9 -N '{}' ';'",
			autowire: "./autowire.sh"
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
	grunt.loadNpmTasks('grunt-critical');
	grunt.loadNpmTasks('grunt-exec');
	grunt.loadNpmTasks('grunt-dev-update');

	grunt.registerTask('default', ['less', 'copy', 'concat', 'uglify', 'critical', 'exec']);

};
