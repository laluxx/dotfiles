;;; doom-pywal-palenight-theme.el --- A Pywal integrated Material-Palenight theme for Doom Emacs

(require 'doom-themes)

;; Load pywal colors
(defvar pywal-theme-colors-alist
  (when (file-exists-p "~/.cache/wal/colors.el")
    (with-temp-buffer
      (insert-file-contents "~/.cache/wal/colors.el")
      (car (read-from-string (buffer-string))))))

(defun pywal-color (color-name)
  "Get the color value for COLOR-NAME from pywal-theme-colors-alist."
  (alist-get color-name pywal-theme-colors-alist))

;;
;;; Variables

(defgroup doom-pywal-palenight-theme nil
  "Options for the `doom-pywal-palenight' theme."
  :group 'doom-themes)

(defcustom doom-pywal-palenight-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-pywal-palenight-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-pywal-palenight
  "A dark theme inspired by Material-Palenight and integrated with Pywal colors."

  ;; Define colors using pywal
  (let ((bg (pywal-color 'background-color))
        (fg (pywal-color 'foreground-color))
        (base0 bg)
        (base1 fg)
        ;; ... define other colors here ...
        )

    ;; Set the faces
    `((default :background ,bg :foreground ,fg)
      ;; ... other faces

      ;; Example for setting syntax elements using pywal colors
      (font-lock-comment-face :foreground ,base1)
      
      ;; ... rest of the face specifications from doom-palenight
      )))

(provide 'doom-pywal-palenight-theme)
;;; doom-pywal-palenight-theme.el ends here
