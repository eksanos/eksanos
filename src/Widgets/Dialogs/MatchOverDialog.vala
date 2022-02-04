namespace Eksanos.Widgets {
	internal class MatchOverDialog : Granite.MessageDialog {
		public MatchOverDialog (int match_result, string player_one_name, string player_two_name) {
			string primary_message = "";
			string secondary_message = "";
			string icon_name = "";

			switch(match_result) {
				case MatchResults.MATCH_DRAW:
					icon_name = "dialog-information";
					primary_message = "DRAW!";
					secondary_message = "Neither player could get three in a row. Perhaps a rematch is in order?";
					break;
				case MatchResults.MATCH_PLAYER_ONE_WON:
					icon_name = "dialog-information";
					primary_message = player_one_name + " WON!";
					secondary_message = "Congratulations " + player_one_name + "!";
					break;
				case MatchResults.MATCH_PLAYER_TWO_WON:
					icon_name = "dialog-information";
					primary_message = player_two_name + " WON!";
					secondary_message = "Congratulations " + player_two_name + "!";
					break;
			}
			base.with_image_from_icon_name (primary_message, secondary_message, icon_name, Gtk.ButtonsType.NONE);
			add_button ("Quit Eksanos", Gtk.ResponseType.CLOSE).get_style_context ().add_class(Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
			add_button ("Main Menu", Gtk.ResponseType.CANCEL);
			add_button ("New Match", Gtk.ResponseType.ACCEPT).get_style_context ().add_class(Gtk.STYLE_CLASS_SUGGESTED_ACTION);

			set_default_response(Gtk.ResponseType.ACCEPT);
		}

	}
}
