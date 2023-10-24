#include <emacs-module.h>
#include <X11/Xlib.h>

int plugin_is_GPL_compatible;

static emacs_value
Frep_parent_window(emacs_env *env, ptrdiff_t nargs, emacs_value args[], void *data) {
    Window parent_window = (Window)env->extract_integer(env, args[0]);
    Window child_window = (Window)env->extract_integer(env, args[1]);

    Display *display = XOpenDisplay(NULL);
    if (!display) return env->make_integer(env, 1);

    XReparentWindow(display, child_window, parent_window, 0, 0);
    XCloseDisplay(display);

    return env->make_integer(env, 0);
}

int
emacs_module_init(struct emacs_runtime *ert) {
    emacs_env *env = ert->get_environment(ert);

    emacs_value Qfset = env->intern(env, "fset");
    emacs_value Qprovide = env->intern(env, "provide");
    emacs_value Qrep_parent_symbol = env->intern(env, "rep-parent-window");

    emacs_value Qrep_parent_func = env->make_function(env, 2, 2, Frep_parent_window,
        "Reparent CHILD_WINDOW into PARENT_WINDOW.", NULL);

    env->funcall(env, Qfset, 2, Qrep_parent_symbol, Qrep_parent_func);
    env->funcall(env, Qprovide, 1, Qrep_parent_symbol);

    return 0;
}
