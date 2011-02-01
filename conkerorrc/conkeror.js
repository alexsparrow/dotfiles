/*let (sheet = get_home_directory()) {
    sheet.append(".conkerorrc");
    sheet.append("stylesheets");
    sheet.append("theme.css");
    register_user_stylesheet(make_uri(sheet));
}*/
require("new-tabs.js");


function define_switch_buffer_key (key, buf_num) {
    define_key(default_global_keymap, key,
               function (I) {
                   switch_to_buffer(I.window,
                                    I.window.buffers.get_buffer(buf_num));
               });
}
for (let i = 0; i < 10; ++i) {
    define_switch_buffer_key(String((i+1)%10), i);
}


define_webjump("reddit","http://www.reddit.com/r/%s");

define_key(content_buffer_normal_keymap, "C-c n", "follow-new-buffer");

// copy url with C-c u
interactive("copy-url",
        "Copy the current buffer's URL to the clipboard",
        function(I) {
            var text = I.window.buffers.current.document.location.href;
            writeToClipboard(text);
            I.window.minibuffer.message("copied: " + text);
        }
);
define_key(default_global_keymap, "C-c u", "copy-url");


// reload conkerorrc with C-c r
interactive("reload-config", "reload conkerorrc",
       function(I) {
          load_rc();
          I.window.minibuffer.message("config reloaded");
       }
);
define_key(default_global_keymap, "C-c r", "reload-config");

