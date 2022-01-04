namespace Eksanos.Model {
	internal class Player : GLib.Object {
		private string player_name;
		private string marker;
		private int score;

		public Player (string player_name, string marker) {
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

		public int get_score () {
			return score;
		}

		public void change_score_by (int delta) {
			score = score + delta;
		}
	}
}
