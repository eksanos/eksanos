namespace Eksanos {
	internal class Board : GLib.Object {
		private Gtk.Grid board_grid;
		private Tile[,] board_tiles;
		private string current_marker;

		public signal void marker_placed ();

		public Board () {
			board_grid = new Gtk.Grid ();
			board_grid.set_size_request(360,360);
			board_tiles = new Tile [3,3];
			current_marker = "M";
			init_board (" ");
		}

		public Gtk.Grid get_grid () {
			return board_grid;
		}

		public void set_current_marker(string marker) {
			this.current_marker = marker;
		}

		public string[] get_row (int r) {
			string[] row = new string[3];
			for (int i = 0; i < 3; ++i) {
				row[i] = board_tiles[i,r].get_marker();
			}
			return row;
		}

		public string[] get_col (int c) {
			string[] col = new string[3];
			for (int i = 0; i < 3; ++i) {
				col[i] = board_tiles[c,i].get_marker();
			}
			return col;
		}

		public string[] get_diag (int d) {
			string[] diag = new string[3];
			if (d == 0) {
				diag[0] = board_tiles[0,0].get_marker();
				diag[1] = board_tiles[1,1].get_marker();
				diag[2] = board_tiles[2,2].get_marker();
			} else {
				diag[0] = board_tiles[0,2].get_marker();
				diag[1] = board_tiles[1,1].get_marker();
				diag[2] = board_tiles[2,0].get_marker();
			}
			return diag;
		}

		public void clear_board () {
			for (int r = 0; r < 3; ++r) {
				for (int c = 0; c < 3; ++c) {
					board_tiles[c,r].clear_tile();
				}
			}
		}

		public void disable () {
			board_grid.set_sensitive (false);
		}

		public void enable () {
			board_grid.set_sensitive (true);
		}

		private void init_board (string empty_tile_marker) {
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					board_tiles[c,r] = new Tile (empty_tile_marker, ((3*r + c)));
					board_grid.attach (board_tiles[c,r].get_button(), c, r);

					board_tiles[c,r].tile_selected.connect (on_tile_selected);
				}
			}
		}

		private void on_tile_selected (int id) {
			var index_r = id/3;
			var index_c = id%3;

			board_tiles[index_c,index_r].place_marker(current_marker);
			marker_placed ();
		}
	}
}
