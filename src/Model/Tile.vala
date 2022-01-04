namespace Eksanos {
	internal class Tile : GLib.Object {
		private Widgets.TileButton button;
		private string marker;
		private int tile_id;

		public signal void tile_selected(int id);

		public Tile (string default_marker, int id) {
			button = new Widgets.TileButton (default_marker);

			button.clicked.connect(on_tile_clicked);
			marker = default_marker;
			tile_id = id;
		}

		public Widgets.TileButton get_button () {
			return button;
		}

		public string get_marker () {
			return marker;
		}

		public void clear_tile () {
			marker = " ";
			button.clear_tile ();
			button.enable ();
		}

		public void place_marker (string marker_id) {
			marker = marker_id;
			button.update_tile_marker (marker);
			button.disable ();
		}

		public void on_tile_clicked () {
			tile_selected(tile_id);
		}
	}
}
