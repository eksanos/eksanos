namespace Eksanos {
	internal class Tile : GLib.Object {
		private Gtk.Button button;
		private string marker;
		private int tile_id;

		public signal void tile_selected(int id);

		public Tile (string default_marker, int id) {
			button = new Gtk.Button.with_label(default_marker);
			button.expand = true;
			button.margin = 8;
			button.clicked.connect(on_tile_clicked);
			marker = default_marker;
			tile_id = id;
		}

		public Gtk.Button get_button () {
			return button;
		}

		public string get_marker () {
			return marker;
		}

		public void clear_tile () {
			marker = " ";
			button.label = marker;
			button.set_sensitive(true);
		}

		public void place_marker (string marker_id) {
			marker = marker_id;
			button.label = marker;
			button.set_sensitive(false);
		}

		public void on_tile_clicked () {
			tile_selected(tile_id);
		}
	}
}
