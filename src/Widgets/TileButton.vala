/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Justin Lahman <justinlahmanCS@gmail.com>
 */
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
			vexpand = true;
			hexpand = true;
			set_size_request (108, 108);
			set_can_focus (false);
			clicked.connect(on_tile_clicked);
		}

		public void update_tile_marker (string marker) {
			if (marker == "X") {
				current_marker = new Gtk.Image.from_resource (cross_res_path);
				set_child (current_marker);
				print (cross_res_path);
			} else {
				current_marker = new Gtk.Image.from_resource (circle_res_path);
				set_child (current_marker);
			}
		}

		public void update_color_path (string path, string color_name) {
			circle_res_path = path + "circle_" + color_name + ".png";
			cross_res_path = path + "cross_" + color_name + ".png";
		}

		public void clear_tile () {
			set_child (null);
		}

		public void on_tile_clicked () {
			tile_selected(id);
		}
	}
}
