namespace Eksanos.Widgets {
	internal class TileButton : Gtk.Button {
		private string default_marker;
		private int id;
		private string circle_res_path;
		private string cross_res_path;
		private Gtk.Image current_marker;

		public signal void tile_selected(int id);

		public TileButton (string default_marker, int id) {
			this.default_marker = default_marker;
			this.id = id;
			circle_res_path = "/com/github/keilith-l/eksanos/circle.png";
			cross_res_path = "/com/github/keilith-l/eksanos/cross.png";
			expand = true;
			margin = 8;
			set_size_request (100, 100);
			clicked.connect(on_tile_clicked);
		}

		public void update_tile_marker (string marker) {
			if (marker == "X") {
				current_marker = new Gtk.Image.from_resource (cross_res_path);
				set_image (current_marker);
			} else {
				current_marker = new Gtk.Image.from_resource (circle_res_path);
				set_image (current_marker);
			}
		}

		public void clear_tile () {
			set_image (null);
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
