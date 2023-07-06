(def-doom-theme pywal
  "A theme that uses pywal colors."

  ;; Define the color palette.
  (let* ((colors (if (f-exists? "~/.cache/wal/colors.el")
                     (progn
                       (load-file "~/.cache/wal/colors.el")
                       pywal-theme-colors-alist)
                   '((class '((background-color . "#000000")
                              (foreground-color . "#ffffff"))))))
    (let ((bg (alist-get 'background-color colors))
          (fg (alist-get 'foreground-color colors)))
      `((default :background ,bg :foreground ,fg)))))

(setq doom-theme 'pywal)
