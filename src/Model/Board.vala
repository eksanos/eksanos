namespace Eksanos.Model {
	internal class Board : GLib.Object {
		private Model.Tile[,] board_tiles;
		private const string empty_space_marker = " ";

		public Board () {
			board_tiles = new Model.Tile [3,3];
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					board_tiles[c,r] = new Tile (empty_space_marker, ((3*r + c)));
				}
			}
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

		public string[,] get_state () {
			string[,] state = new string [3,3];

			for (int r = 0; r < 3; ++r) {
				for (int c = 0; c < 3; ++c) {
					state[c,r] = board_tiles[c,r].get_marker();
				}
			}

			return state;
		}

		public bool is_position_empty (int[] position) {
			return (" " == board_tiles[position[0], position[1]].get_marker ());
		}

		public void clear_board () {
			for (int r = 0; r < 3; ++r) {
				for (int c = 0; c < 3; ++c) {
					board_tiles[c,r].clear_tile();
				}
			}
		}

		public void place_marker (int col, int row, string marker) {
			board_tiles[col,row].place_marker (marker);
		}
	}
}
