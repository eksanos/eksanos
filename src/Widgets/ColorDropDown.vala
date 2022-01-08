namespace Eksanos.Widgets {
	internal class ColorDropDown : Gtk.ComboBoxText {
		private string[] color_options;

		public ColorDropDown () {
			color_options = new string[10];
			color_options = {
				"banana",
				"blueberry",
				"bubblegum",
				"cocoa",
				"grape",
				"lime",
				"mint",
				"orange",
				"slate",
				"strawberry"
			};

			for (int i = 0; i < color_options.length; ++i) {
				append_text (color_options[i]);
			}
			
			set_active (0);
		}

		public string get_color_selected () {
			return get_active_text ();
		}
	}
}
