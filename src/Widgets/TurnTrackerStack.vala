namespace Eksanos.Widgets {
	internal class TurnTrackerStack : Gtk.Stack {
		private Gtk.Label turn_label;
		private Gtk.Label empty_label;
		public TurnTrackerStack (string default_label_text) {
			turn_label = new Gtk.Label (default_label_text);
			turn_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
			empty_label = new Gtk.Label ("");
			transition_type = Gtk.StackTransitionType.SLIDE_UP;
			transition_duration =150;

			set_vexpand (true);
			set_hexpand (true);

			add_named (turn_label, "turn_text");
			add_named (empty_label, "no_text");


			visible_child_name = "turn_text";
		}


		public void add_turn_text (string turn_text) {

			do_transition.begin (turn_text, (obj, res) => {
				try {
					do_transition.end(res);
				} catch (ThreadError e) {
					string msg = e.message;
					stderr.printf(@"Thread error: $msg\n");
				}
			});
		}

		private async void do_transition (string turn_text) throws ThreadError {
			SourceFunc callback = do_transition.callback;

			ThreadFunc<void> run = () => {
				transition_type = Gtk.StackTransitionType.SLIDE_DOWN;
				visible_child_name = "no_text";

				while(transition_running) {

				}

				turn_label.set_text(turn_text);

				transition_type = Gtk.StackTransitionType.SLIDE_UP;
				visible_child_name = "turn_text";
				Idle.add((owned) callback);
				return;
			};

			new Thread<void>("label_transition", run);
			yield;
			return;
		}
	}


}
