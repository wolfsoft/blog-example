module.exports = function(grunt) {

	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

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
					'./resources/assets/javascript/backend.js'
				],
				dest: './public/assets/javascript/backend.js'
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
		}

	});

	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-uglify');

	grunt.registerTask('default', ['less', 'concat', 'uglify']);

};
