/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Justin Lahman <justinlahmanCS@gmail.com>
 */
namespace Eksanos.Model {
	internal class Tile : GLib.Object {
		private string marker;
		private int tile_id;

		public Tile (string default_marker, int id) {
			marker = default_marker;
			tile_id = id;
		}

		public string get_marker () {
			return marker;
		}

		public void clear_tile () {
			marker = " ";
		}

		public void place_marker (string marker_id) {
			marker = marker_id;
		}
	}
}
