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
			circle_res_path = "/com/github/eksanos/eksanos/circle_banana.png";
			cross_res_path = "/com/github/eksanos/eksanos/cross_banana.png";
			set_relief (Gtk.ReliefStyle.NONE);
			expand = true;
			margin = 8;
			set_size_request (112, 112);
			set_can_focus (false);
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

		public void update_color_path (string path, string color_name) {
			circle_res_path = path + "circle_" + color_name + ".png";
			cross_res_path = path + "cross_" + color_name + ".png";
		}

		public void clear_tile () {
			set_image (null);
		}

		public void on_tile_clicked () {
			tile_selected(id);
		}
	}
}
