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
			menu_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);
			menu_box.set_vexpand (true);

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

			player_one_name_box.pack_start (player_one_name_entry_label, false, false, 0);
			player_two_name_box.pack_start (player_two_name_entry_label, false, false, 0);
			player_one_name_box.pack_start (player_one_name_entry, false, false, 0);
			player_two_name_box.pack_start (player_two_name_entry, false, false, 0);

			start_game_button = new Gtk.Button.with_label ("Start Game");

			Gtk.Box single_player_option = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
			single_player_mode_switch = new Gtk.Switch ();
			single_player_mode_switch.set_active (true);
			Gtk.Label single_player_label = new Gtk.Label ("Single Player Mode");
			single_player_label.set_justify (Gtk.Justification.LEFT);
			single_player_option.pack_start (single_player_label, false, false, 0);
			single_player_option.pack_start (single_player_mode_switch, false, false, 0);
			single_player_option.set_halign (Gtk.Align.START);

			color_drop_down = new Widgets.ColorDropDown ();
			color_drop_down.set_halign (Gtk.Align.START);

			menu_box.pack_start (new Gtk.Label ("A TicTacToe Game\nby keilith-l"), true, true, 0);

			menu_box.pack_start (player_one_name_box, false, true, 0);
			menu_box.pack_start (player_two_name_box, false, false, 0);
			menu_box.pack_start (single_player_option, false, false, 0);
			menu_box.pack_start (color_drop_down, false, false, 0);

			menu_box.pack_start (start_game_button, true, false, 0);

			main_menu_screen.pack_start (menu_box, true, false, 12);

			start_game_button.grab_focus ();
			start_game_button.clicked.connect (on_start_game_clicked);
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

			start_game_requested (player_one_name, player_two_name, single_player_mode_switch.get_active () ,color_drop_down.get_color_selected ());
		}
	}
}
