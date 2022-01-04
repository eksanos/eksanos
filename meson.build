project('com.github.keilith-l.eksanos', 'vala', 'c')

executable(
	meson.project_name(),
	'src'/'Application.vala',
	'src'/'MainWindow.vala',
	'src'/'GameController.vala',
	'src'/'Model'/'Game.vala',
	'src'/'Model'/'Player.vala',
	'src'/'Model'/'Board.vala',
	'src'/'Model'/'Tile.vala',
	'src'/'Widgets'/'GameScreen.vala',
	'src'/'Widgets'/'PlayerInfoBox.vala',
	'src'/'Widgets'/'TileButton.vala',
	'src'/'Widgets'/'BoardGrid.vala',
	dependencies: [
		dependency('libhandy-1', version: '>=0.91.0'),
		dependency('granite'),
		dependency('gtk+-3.0')
	],
	install: true
)

install_data(
	'data'/'eksanos.desktop',
	install_dir: get_option('datadir') / 'applications',
	rename: meson.project_name() + '.desktop'
)

install_data(
	'data' / 'eksanos.appdata.xml',
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
