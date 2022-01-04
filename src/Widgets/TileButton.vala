namespace Eksanos.Widgets {
	internal class TileButton : Gtk.Button {
		private string default_marker;
		private int id;

		public signal void tile_selected(int id);

		public TileButton (string default_marker, int id) {
			this.default_marker = default_marker;
			this.id = id;
			expand = true;
			margin = 8;
			set_label (default_marker);
			clicked.connect(on_tile_clicked);
		}

		public void update_tile_marker (string marker) {
			set_label (marker);
		}

		public void clear_tile () {
			set_label (default_marker);
		}

		public void enable () {
			set_sensitive (true);
		}

		public void disable () {
			set_sensitive (false);
		}

		public void on_tile_clicked () {
			tile_selected(id);
		}
	}
}
