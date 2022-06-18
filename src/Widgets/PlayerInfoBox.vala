/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Justin Lahman <justinlahmanCS@gmail.com>
 */
namespace Eksanos.Widgets {
	internal class PlayerInfoBox : Gtk.Box {
		private Gtk.Label player_name_label;
		private Gtk.Label player_score_label;

		public PlayerInfoBox (string player_name, int spacing) {
			orientation = Gtk.Orientation.VERTICAL;
			add_css_class (Granite.STYLE_CLASS_CARD);
			add_css_class (Granite.STYLE_CLASS_ROUNDED);
			set_hexpand (true);

			player_name_label = new Gtk.Label (player_name);
			player_name_label.set_margin_top (4);

			player_score_label = new Gtk.Label ("Matches Won: 0");
			player_score_label.set_margin_bottom (4);

			append (player_name_label);
			append (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));
			append (player_score_label);

			set_spacing(spacing);
		}

		public void update_score_label (int score) {
			player_score_label.set_label ("Matches Won: " + score.to_string());
		}

		public string get_player_name () {
			return player_name_label.get_label ();
		}

		public void update_player_name (string player_name) {
			player_name_label.set_label (player_name);
		}

		public void disable () {
			set_sensitive (false);
		}

		public void enable () {
			set_sensitive (true);
		}
	}
}
