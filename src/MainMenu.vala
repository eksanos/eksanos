/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Justin Lahman <justinlahmanCS@gmail.com>
 */
namespace Eksanos {
	internal class MainMenu : GLib.Object {
		private Gtk.Box main_menu_screen;
		private Gtk.Box menu_box;

		private Gtk.Label player_one_name_entry_label;
		private Gtk.Entry player_one_name_entry;

		private Gtk.Label player_two_name_entry_label;
		private Gtk.Entry player_two_name_entry;

		private Gtk.Button start_game_button;

		private Gtk.Switch single_player_mode_switch;
		private Widgets.ColorDropDown color_drop_down;

		private string player_one_name;
		private string player_two_name;

		public signal void start_game_requested (string player_one_name, string player_two_name, bool single_player_mode, string color_name);

		public MainMenu () {
			main_menu_screen = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
			main_menu_screen.set_hexpand (true);
			main_menu_screen.set_margin_start (24);
			main_menu_screen.set_margin_end (24);
			main_menu_screen.set_margin_top (24);
			main_menu_screen.set_margin_bottom (24);

			menu_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);
			menu_box.set_vexpand (true);
			menu_box.set_margin_start (12);
			menu_box.set_margin_end (12);
			menu_box.set_valign (Gtk.Align.FILL);

			Gtk.Box title_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);
			title_box.set_valign (Gtk.Align.CENTER);
			title_box.set_vexpand (true);
			Gtk.Box options_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);
			options_box.set_valign (Gtk.Align.CENTER);
			options_box.set_vexpand (true);
			options_box.set_margin_start (12);
			options_box.set_margin_end (12);
			Gtk.Box play_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);
			play_box.set_valign (Gtk.Align.CENTER);
			play_box.set_vexpand (true);

			Gtk.Box player_one_name_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
			Gtk.Box player_two_name_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);

			player_one_name_entry_label = new Gtk.Label ("Player 1's name:");
			player_two_name_entry_label = new Gtk.Label ("Player 2's name:");
			player_one_name_entry_label.set_justify (Gtk.Justification.RIGHT);
			player_two_name_entry_label.set_justify (Gtk.Justification.RIGHT);

			player_one_name_entry = new Gtk.Entry ();
			player_two_name_entry = new Gtk.Entry ();

			player_one_name_entry.set_placeholder_text ("Player 1");
			player_two_name_entry.set_placeholder_text ("Player 2");
			player_one_name_entry.set_hexpand (true);
			player_two_name_entry.set_hexpand (true);

			player_one_name_box.append (player_one_name_entry_label);
			player_two_name_box.append (player_two_name_entry_label);
			player_one_name_box.append (player_one_name_entry);
			player_two_name_box.append (player_two_name_entry);

			start_game_button = new Gtk.Button.with_label ("Start Game");

			Gtk.Box single_player_option = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
			single_player_mode_switch = new Gtk.Switch ();
			single_player_mode_switch.set_active (true);
			Gtk.Label single_player_label = new Gtk.Label ("Single Player Mode");
			single_player_label.set_justify (Gtk.Justification.LEFT);
			single_player_option.append (single_player_label);
			single_player_option.append (single_player_mode_switch);
			single_player_option.set_halign (Gtk.Align.START);

			color_drop_down = new Widgets.ColorDropDown ();
			color_drop_down.set_halign (Gtk.Align.START);

			Gtk.Label menu_title = new Gtk.Label ("A TicTacToe Game");
			menu_title.get_style_context ().add_class(Granite.STYLE_CLASS_H2_LABEL);
			menu_title.set_valign (Gtk.Align.CENTER);

			title_box.append (menu_title);
			options_box.append (player_one_name_box);
			options_box.append (player_two_name_box);
			options_box.append (single_player_option);
			options_box.append (color_drop_down);

			play_box.append (start_game_button);

			menu_box.append (title_box);
			menu_box.append (options_box);
			menu_box.append (play_box);

			main_menu_screen.append (menu_box); 
			start_game_button.clicked.connect (on_start_game_clicked);
		}

		public Gtk.Widget get_default_widget () {
			return start_game_button;
		}

		public Gtk.Box get_menu_screen () {
			return main_menu_screen;
		}

		private void on_start_game_clicked () {
			player_one_name = player_one_name_entry.get_text ();
			player_two_name = player_two_name_entry.get_text ();

			if (player_one_name == "") {
				player_one_name = player_one_name_entry.get_placeholder_text ();
			}
			if (player_two_name == "") {
				player_two_name = player_two_name_entry.get_placeholder_text ();
			}

			if (player_one_name == player_two_name) {
				player_one_name += "_X";
				player_two_name += "_O";
			}

			start_game_requested (player_one_name, player_two_name, single_player_mode_switch.get_active (), color_drop_down.get_color_selected ());
		}
	}
}
