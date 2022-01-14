/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Justin Lahman <justinlahmanCS@gmail.com>
 */
namespace Eksanos{
	public class Application : Gtk.Application {
		public MainWindow app_window;

		public Application () {
			Object (
				application_id: "com.github.eksanos.eksanos",
				flags: ApplicationFlags.FLAGS_NONE
			);
		}

		protected override void activate () {
			setup_color_preference ();
			setup_custom_resources ();

			if (get_windows().length() > 0) {
				app_window.present();
				return;
			}

			app_window = new MainWindow (this);

			app_window.show_all ();
		}

		private void setup_color_preference () {
			var granite_settings = Granite.Settings.get_default ();
			var gtk_settings = Gtk.Settings.get_default ();
			gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

			granite_settings.notify["prefers_color_scheme"].connect (() => {
				gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
			});
		}

		private void setup_custom_resources () {
			Gtk.IconTheme.get_default ().add_resource_path("/com/github/keilith-l/eksanos");
		}

		public static int main (string[] args) {
			return new Application ().run (args);
		}
	}
}
