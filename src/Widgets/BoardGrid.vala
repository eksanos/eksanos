/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Justin Lahman <justinlahmanCS@gmail.com>
 */
namespace Eksanos.Widgets {
	internal class BoardGrid : Gtk.Grid {
		private string empty_tile_marker;
		private TileButton[,] tile_buttons;

		public signal void cell_selected (int[] position);

		public BoardGrid (string empty_tile_marker) {
			this.empty_tile_marker = empty_tile_marker;
			tile_buttons = new TileButton[3,3];
			set_size_request (330,330);
			get_style_context ().add_class (Granite.STYLE_CLASS_CARD);
			get_style_context ().add_class (Granite.STYLE_CLASS_ROUNDED);

			init_board (empty_tile_marker);
		}

		public void disable () {
			set_sensitive (false);
		}

		public void enable () {
			set_sensitive (true);
		}

		public void update_tile_marker (int[] position, string marker) {
			tile_buttons[position[0], position[1]].update_tile_marker (marker);
		}

		public void update_marker_color (string color_name) {
			string path = "/com/github/eksanos/eksanos/";
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					tile_buttons[c,r].update_color_path (path, color_name);
				}
			}
		}

		public void clear_board () {
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					tile_buttons[c,r].clear_tile ();
				}
			}
		}

		private void init_board (string empty_tile_marker) {
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					tile_buttons[c,r] = new TileButton (empty_tile_marker, ((3*r + c)));
					Gtk.Frame cell_frame = new Gtk.Frame (null);
					cell_frame.add(tile_buttons[c,r]);
					attach (cell_frame, c, r);

					tile_buttons[c,r].tile_selected.connect (on_tile_selected);
				}
			}
		}

		private void on_tile_selected (int id) {
			var index_r = id/3;
			var index_c = id%3;

			int[] position = new int[2];
			position[0] = index_c;
			position[1] = index_r;

			cell_selected (position);
		}

	}
}
