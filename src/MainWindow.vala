/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Justin Lahman <justinlahmanCS@gmail.com>
 */
namespace Eksanos {
	public class MainWindow : Gtk.ApplicationWindow {
		private Controllers.Game game_controller;
		private MainMenu main_menu;
		private Gtk.HeaderBar header_bar;
		private Adw.Leaflet leaflet;
		private Gtk.Button nav_button;

		public MainWindow (Eksanos.Application eksanos_app) {
			Object (
				application: eksanos_app,
				title: "Eksanos",
				default_height: 640,
				default_width: 360,
				resizable: false
			);
		}

		construct {
			var global_grid = new Gtk.Grid ();
			global_grid.orientation = Gtk.Orientation.VERTICAL;

			nav_button = new Gtk.Button.with_label ("Menu");
			nav_button.add_css_class (Granite.STYLE_CLASS_BACK_BUTTON);
			nav_button.set_valign (Gtk.Align.CENTER);
			nav_button.set_visible (true);
			nav_button.set_can_focus (false);

			game_controller = new Controllers.Game (this);
			main_menu = new MainMenu ();

			game_controller.get_game_screen ().quit_game_requested.connect (on_quit_game_requested);
			game_controller.get_game_screen ().back_to_main_menu_requested.connect (() => {
				leaflet.set_visible_child (main_menu.get_menu_screen ());
				nav_button.set_visible (false);
			});

			setup_header_bar ();
			setup_leaflet ();
			setup_connections ();

			set_titlebar (header_bar);
			global_grid.attach (leaflet, 0, 0);
			set_child (global_grid);
		}

		private void setup_header_bar () {
			header_bar = new Gtk.HeaderBar (){
				hexpand = true,
				show_title_buttons = true
			};
			header_bar.add_css_class (Granite.STYLE_CLASS_DEFAULT_DECORATION);
			
			var title = new Gtk.Label ("Eksanos");
			title.add_css_class(Granite.STYLE_CLASS_ACCENT);
			title.add_css_class(Granite.STYLE_CLASS_H3_LABEL);

			header_bar.set_title_widget (title);
			header_bar.pack_start (nav_button);
		}

		private void setup_leaflet () {
			leaflet = new Adw.Leaflet ();
			leaflet.set_transition_type (Adw.LeafletTransitionType.UNDER);
			leaflet.append (main_menu.get_menu_screen ());
			leaflet.append (game_controller.get_game_screen ());
			leaflet.set_visible_child (main_menu.get_menu_screen ());
		}

		private void setup_connections () {
			main_menu.start_game_requested.connect ((player_one_name, player_two_name, single_player_mode, color_name) => {
				game_controller.generate_new_game (player_one_name, player_two_name, single_player_mode, color_name);
				leaflet.set_visible_child (game_controller.get_game_screen ());
				nav_button.set_visible (true);
			});

			nav_button.clicked.connect (() => {
				leaflet.set_visible_child (main_menu.get_menu_screen ());
				nav_button.set_visible (false);
			});
		}

		private void on_quit_game_requested () {
			application.quit ();
		}
	}
}
