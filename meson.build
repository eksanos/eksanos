project('com.github.keilith-l.hello-packaging', 'vala', 'c')

executable(
	meson.project_name(),
	'src'/'Application.vala',
	dependencies: [
		dependency('gtk+-3.0')
	],
	install: true
)

install_data(
	'data'/'hello-packaging.desktop',
	install_dir: get_option('datadir') / 'applications',
	rename: meson.project_name() + '.desktop'
)

install_data(
	'data' / 'hello-packaging.appdata.xml',
	install_dir: get_option('datadir') / 'metainfo',
	rename: meson.project_name() + '.appdata.xml'
)

icon_sizes = ['16', '24', '32', '48', '64', '128']

foreach i : icon_sizes
	install_data(
		'data' / i + '.svg',
		install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i / 'apps',
		rename: meson.project_name() + '.svg'
	)
	install_data(
		'data' / i + '.svg',
		install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i + '@2' / 'apps',
		rename: meson.project_name() + '.svg'
	)
endforeach
