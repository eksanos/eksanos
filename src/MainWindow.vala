namespace Eksanos {
	public class MainWindow : Gtk.ApplicationWindow {
		public MainWindow (Eksanos.Application eksanos_app) {
			Object (
				application: eksanos_app,
				title: "Eksanos",
				default_height: 360,
				default_width: 640
			);
		}
	}
}
