namespace Eksanos {
	internal class Player : GLib.Object {
		private Gtk.Box player_info_box;
		private Gtk.Label player_score_label;
		private string player_name;
		private string marker;
		private int score;

		public Player (string player_name, string marker) {
			player_info_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 8);
			player_score_label = new Gtk.Label ("Matches Won: 0");
			this.player_name = player_name;
			this.marker = marker;
			score = 0;

			player_info_box.pack_start (new Gtk.Label (player_name), false, false, 2);
			player_info_box.pack_start (player_score_label, false, false, 2);

		}

		public string get_name () {
			return player_name;
		}

		public string get_marker () {
			return marker;
		}

		public void change_score_by (int delta) {
			score = score + delta;
			player_score_label.set_label ("Matches Won: " + score.to_string());
		}

		public Gtk.Box get_info_box () {
			return player_info_box;
		}

		public void disable () {
			player_info_box.set_sensitive (false);
		}

		public void enable () {
			player_info_box.set_sensitive (true);
		}

	}
}
