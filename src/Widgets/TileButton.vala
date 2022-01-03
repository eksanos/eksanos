namespace Eksanos.Widgets {
	internal class TileButton : Gtk.Button {
		private string default_marker;

		public TileButton (string default_marker) {
			this.default_marker = default_marker;
			expand = true;
			margin = 8;
			set_label (default_marker);
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
	}
}
