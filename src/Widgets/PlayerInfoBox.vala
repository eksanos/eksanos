namespace Eksanos.Widgets {
	internal class PlayerInfoBox : Gtk.Box {
		private Gtk.Label player_name_label;
		private Gtk.Label player_score_label;

		public PlayerInfoBox (string player_name, int spacing) {
			orientation = Gtk.Orientation.VERTICAL;

			player_name_label = new Gtk.Label (player_name);
			player_score_label = new Gtk.Label ("Matches Won: 0");

			pack_start (player_name_label, false, false, 12);
			pack_start (player_score_label, false, false, 2);

			set_spacing(spacing);
		}

		public void update_score_label (int score) {
			player_score_label.set_label ("Matches Won: " + score.to_string());
		}
	}
}
