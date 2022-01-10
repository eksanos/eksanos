namespace Eksanos {
	internal class MainMenu : GLib.Object {
		private Gtk.Box main_menu_screen;
		private Gtk.Box menu_box;

		private Gtk.Label player_one_name_entry_label;
		private Gtk.Entry player_one_name_entry;

		private Gtk.Label player_two_name_entry_label;
		private Gtk.Entry player_two_name_entry;

		private Gtk.Button start_game_button;

		private Gtk.CheckButton single_player_mode_checkbutton;
		private Widgets.ColorDropDown color_drop_down;

		private string player_one_name;
		private string player_two_name;

		public signal void start_game_requested (string player_one_name, string player_two_name, bool single_player_mode, string color_name);

		public MainMenu () {
			main_menu_screen = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 8);
			main_menu_screen.set_hexpand (true);
			menu_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 8);
			menu_box.set_vexpand (true);

			player_one_name_entry_label = new Gtk.Label ("Player 1's name:");
			player_two_name_entry_label = new Gtk.Label ("Player 2's name:");

			player_one_name_entry = new Gtk.Entry ();
			player_two_name_entry = new Gtk.Entry ();

			player_one_name_entry.set_placeholder_text ("Player 1");
			player_two_name_entry.set_placeholder_text ("Player 2");

			start_game_button = new Gtk.Button.with_label ("Start Game");
			single_player_mode_checkbutton = new Gtk.CheckButton.with_label ("Single Player Mode");
			single_player_mode_checkbutton.set_active (true);
			color_drop_down = new Widgets.ColorDropDown ();

			menu_box.pack_start (new Gtk.Label ("A TicTacToe Game\nby keilith-l"), true, true, 0);

			menu_box.pack_start (player_one_name_entry_label, false, false, 0);
			menu_box.pack_start (player_one_name_entry, false, false, 0);
			menu_box.pack_start (player_two_name_entry_label, false, false, 0);
			menu_box.pack_start (player_two_name_entry, false, false, 0);
			menu_box.pack_start (start_game_button, true, false, 0);
			menu_box.pack_start (color_drop_down, true, false, 0);
			menu_box.pack_start (single_player_mode_checkbutton, true, false, 0);

			main_menu_screen.pack_start (menu_box, true, false, 0);

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

			start_game_requested (player_one_name, player_two_name, single_player_mode_checkbutton.get_active () ,color_drop_down.get_color_selected ());
		}
	}
}
