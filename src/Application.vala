namespace Eksanos{
	public class Application : Gtk.Application {
		public MainWindow app_window;

		public Application () {
			Object (
				application_id: "com.github.keilith-l.eksanos",
				flags: ApplicationFlags.FLAGS_NONE
			);
		}

		protected override void activate () {
			var gtk_settings = Gtk.Settings.get_default ();
			gtk_settings.gtk_application_prefer_dark_theme = true;
			
			if (get_windows().length() > 0) {
				app_window.present();
				return;
			}

			app_window = new MainWindow (this);

			app_window.show_all ();
		}

		public static int main (string[] args) {
			return new Application ().run (args);
		}


	}
}
