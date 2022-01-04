namespace Eksanos {
	internal class MainMenu : GLib.Object {
		private Gtk.Box main_menu_screen;
		private Gtk.Box menu_box;

		private Gtk.Label player_one_name_entry_label;
		private Gtk.Entry player_one_name_entry;

		private Gtk.Label player_two_name_entry_label;
		private Gtk.Entry player_two_name_entry;

		private Gtk.Button start_game_button;

		public signal void start_game_requested (string player_one_name, string player_two_name);

		public MainMenu () {
			main_menu_screen = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 8);
			main_menu_screen.set_hexpand (true);
			menu_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 8);
			menu_box.set_vexpand (true);


			player_one_name_entry_label = new Gtk.Label ("Player 1 name:");
			player_two_name_entry_label = new Gtk.Label ("Player 2 name:");

			player_one_name_entry = new Gtk.Entry ();
			player_two_name_entry = new Gtk.Entry ();

			player_one_name_entry.set_placeholder_text ("Player 1");
			player_two_name_entry.set_placeholder_text ("Player 2");

			start_game_button = new Gtk.Button.with_label ("Start Game");


			menu_box.pack_start (new Gtk.Label ("A TicTacToe Game"), true, true, 0);
			menu_box.pack_start (player_one_name_entry_label, false, false, 0);
			menu_box.pack_start (player_one_name_entry, false, false, 0);
			menu_box.pack_start (player_two_name_entry_label, false, false, 0);
			menu_box.pack_start (player_two_name_entry, false, false, 0);
			menu_box.pack_start (start_game_button, true, false, 0);

			main_menu_screen.pack_start (menu_box, true, false, 0);

			start_game_button.clicked.connect (on_start_game_clicked);
		}

		public Gtk.Box get_menu_screen () {
			return main_menu_screen;
		}

		private void on_start_game_clicked () {
			if (check_names_different ()) {
				start_game_requested (player_one_name_entry.get_text (), player_two_name_entry.get_text ());
			}
		}

		private bool check_names_different () {
			return player_one_name_entry.get_text () != player_two_name_entry.get_text ();
		}
	}
}
