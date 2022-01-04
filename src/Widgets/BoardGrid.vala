namespace Eksanos.Widgets {
	internal class BoardGrid : Gtk.Grid {
		private string empty_tile_marker;
		private TileButton[,] tile_buttons;

		public void cell_selected (int col, int row);

		public BoardGrid (string empty_tile_marker) {
			this.empty_tile_marker = empty_tile_marker;
			tile_buttons = new TileButton[3,3];
			set_size_request (360,360);
			init_board (empty_tile_marker);
		}

		public void disable () {
			set_sensitive (false);
		}

		public void enable () {
			set_sensitive (true);
		}

		private void init_board (string empty_tile_marker) {
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					tile_buttons[c,r] = new TileButton (empty_tile_marker, ((3*r + c)));
					attach (tile_buttons[c,r], c, r);

					tile_buttons[c,r].tile_selected.connect (on_tile_selected);
				}
			}
		}

		private void on_tile_selected (int id) {
			var index_r = id/3;
			var index_c = id%3;

			cell_selected (index_c, index_r);
		}

	}
}
