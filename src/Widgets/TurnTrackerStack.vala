namespace Eksanos.Widgets {
	internal class TurnTrackerStack : Gtk.Box { //Gtk.Stack {
		private Gtk.Label turn_label;
		private Gtk.Label empty_label;
		private Gtk.Stack stack;
		public TurnTrackerStack (string default_label_text) {
			orientation = Gtk.Orientation.VERTICAL;
			set_hexpand (true);
			set_vexpand (true);
			set_valign (Gtk.Align.FILL);

			stack = new Gtk.Stack ();
			stack.add_css_class (Granite.STYLE_CLASS_CARD);
			stack.add_css_class (Granite.STYLE_CLASS_ROUNDED);
			stack.set_margin_top (12);
			stack.set_margin_bottom (12);
			stack.set_vexpand (true);

			turn_label = new Gtk.Label (default_label_text);
			turn_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
			empty_label = new Gtk.Label ("");
			stack.transition_type = Gtk.StackTransitionType.SLIDE_UP;
			stack.transition_duration =150;

			set_vexpand (true);
			set_hexpand (true);

			stack.add_named (turn_label, "turn_text");
			stack.add_named (empty_label, "no_text");

			stack.visible_child_name = "turn_text";
			append (stack);
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
				stack.transition_type = Gtk.StackTransitionType.SLIDE_UP;
				stack.visible_child_name = "no_text";

				while(stack.transition_running) {

				}

				turn_label.set_text(turn_text);

				stack.transition_type = Gtk.StackTransitionType.SLIDE_UP;
				stack.visible_child_name = "turn_text";
				Idle.add((owned) callback);
				return;
			};

			new Thread<void>("label_transition",(owned) run);
			yield;
			return;
		}
	}


}
