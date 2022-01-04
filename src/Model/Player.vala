namespace Eksanos {
	internal class Player : GLib.Object {
		private Widgets.PlayerInfoBox player_info_box;
		private string player_name;
		private string marker;
		private int score;

		public Player (string player_name, string marker) {
			player_info_box = new Widgets.PlayerInfoBox (player_name, 8);
			this.player_name = player_name;
			this.marker = marker;
			score = 0;
		}

		public string get_name () {
			return player_name;
		}

		public string get_marker () {
			return marker;
		}

		public void change_score_by (int delta) {
			score = score + delta;
			player_info_box.update_score_label (score);
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
