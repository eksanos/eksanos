namespace Eksanos.Widgets {
	internal class ColorDropDown : Gtk.Box {
		private string[] color_options;
		private Gtk.ComboBoxText combo_box;
		private Gtk.Label label;

		public ColorDropDown () {
			combo_box = new Gtk.ComboBoxText ();
			label = new Gtk.Label ("Piece Color:");
			label.set_justify (Gtk.Justification.LEFT);
			set_halign (Gtk.Align.START);
			set_spacing (12);

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
				combo_box.append_text (color_options[i]);
			}

			combo_box.set_active (0);

			add(label);
			add(combo_box);
		}

		public string get_color_selected () {
			return combo_box.get_active_text ();
		}
	}
}
