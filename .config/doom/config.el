;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented. #+end_src

(tool-bar-mode  -1)
(scroll-bar-mode  -1)
(menu-bar-mode  -1)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don"t accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

(toggle-scroll-bar -1)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(set-frame-parameter (selected-frame) 'alpha '(95 100))
(add-to-list 'default-frame-alist '(alpha 95 100))

;; (setq doom-font (font-spec :family "JetBrains Mono" :size 15)
;;       doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
;;       doom-big-font (font-spec :family "JetBrains Mono" :size 24))
;; (after! doom-themes
;;   (setq doom-themes-enable-bold t
;;         doom-themes-enable-italic t))
;; (custom-set-faces!
;;   '(font-lock-comment-face :slant italic)
;;   '(font-lock-keyword-face :slant italic))

(defun my-set-org-mode-font ()
  "Set the font to JetBrains Mono NF ExtraBold when in org mode."
  (interactive)
  (when (derived-mode-p 'org-mode)
    (setq buffer-face-mode-face '(:family "JetBrains Mono NF ExtraBold" :height 1.1))
    (buffer-face-mode)))

(add-hook 'org-mode-hook 'my-set-org-mode-font)

(require 'dashboard)
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-show-shortcuts nil)

;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")

;; Set the footer
(setq dashboard-footer-icon (all-the-icons-octicon "dash" :height 1.1 :v-adjust -0.05 :face 'font-lock-keyword-face))
(setq dashboard-footer-messages '("Dashboard is a minimal and nice looking startup screen."))

;; Set the content
(setq dashboard-items '((recents  . 5)
                        (projects . 5)))

;; Enable the dashboard at startup
(dashboard-setup-startup-hook)

;; Config for recent files
(require 'recentf)
(setq recentf-exclude '("/tmp/" "/ssh:"))
(setq recentf-max-saved-items 50)
(recentf-mode 1)

;; Config for projectile
(require 'projectile)
(setq projectile-completion-system 'ivy)
(projectile-mode 1)

;; Define the function to open the dashboard manually
(defun open-dashboard ()
  (interactive)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))
(global-set-key (kbd "C-x d") 'dashboard-open)

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

(use-package! ewal
  :init
  (setq ewal-use-built-in-always-p nil
        ewal-use-built-in-on-failure-p t
        ewal-built-in-palette "sexy-material"))

(use-package! ewal-doom-themes
  :init
  ;; If you've set ewal-use-built-in-always-p to nil in ewal configuration
  ;; This might be unnecessary, but doesn't hurt to ensure.
  (setq ewal-use-built-in-always-p nil
        ewal-use-built-in-on-failure-p t
        ewal-built-in-palette "sexy-material")
  :config
  (load-theme 'ewal-doom-one t)
  (enable-theme 'ewal-doom-one))

(map! :leader
      :desc "Eshell"                 "e s" #'eshell
      :desc "Eshell popup toggle"    "t e" #'+eshell/toggle
      :desc "Counsel eshell history" "e h" #'counsel-esh-history
      :desc "Vterm popup toggle"     "v t" #'+vterm/toggle)

(map! :leader
      :desc "Kill buffer and open dashboard if last buffer"
      "b k" 'kill-buffer-and-maybe-open-dashboard)

(map! :leader
      :desc "Custom Keybind"
      "d J" (lambda ()
              (interactive)
              (text-scale-set -1)  ;; Set the desired zoom level here
              (execute-kbd-macro (kbd "SPC w v"))
              (execute-kbd-macro (kbd "SPC d j"))))

(map! :leader
      :desc "Insert header tags"
      "i o" #'org-insert-header-tags)

(map! :leader
      :desc "Jump to tangled file"
      "o j" #'org-jump-to-tangled)

(map! :leader
      :desc "Split and jump to tangled file with zoom"
      "o J" #'org-jump-to-tangled-split-and-zoom)

(global-set-key (kbd "M-p") 'dmenu)

(map! :leader
      :desc "Show all hooks"
      "hh" #'laluxx/list-hooks)

(defun kill-buffer-and-maybe-open-dashboard ()
  "Kill current buffer if it's not dashboard, and open dashboard if it was the last user buffer."
  (interactive)
  (let ((buffer (current-buffer)))
    (when (string-equal (buffer-name buffer) "*dashboard*")
      (error "Cannot kill *dashboard* buffer"))
    (when (and (not (string-equal (buffer-name buffer) "*dashboard*"))
               (= 1 (length (delq nil (mapcar (lambda (buf)
                                                (and (buffer-live-p buf)
                                                     (not (string-prefix-p " " (buffer-name buf)))))
                                              (buffer-list))))))
      (dashboard-refresh-buffer))
    (kill-buffer (current-buffer))))

(run-with-idle-timer
 1 nil
 (lambda ()
   (file-notify-add-watch
    "~/.cache/wal/colors"
    '(change)
    (lambda (event)
      (load-theme 'ewal-doom-one t)
      (enable-theme 'ewal-doom-one)))))

(defun laluxx/load-org-wal-colors ()
  "Load colors from the wal cache and apply them to org levels."
  (interactive)
  (let* ((wal-colors (with-temp-buffer
                       (insert-file-contents "~/.cache/wal/colors")
                       (split-string (buffer-string) "\n" t)))
         (wal-colors (cdr wal-colors))) ;; remove the black color (first one)
    (dotimes (level (min 8 (length wal-colors)))
      (let ((color (nth level wal-colors)))
        (set-face-attribute (intern (format "org-level-%d" (1+ level))) nil :foreground color)))))

(defun laluxx/wal-set ()
  (interactive)
  (let* ((default-directory "~/xos/wallpapers/static")
         (theme-directory "~/xos/theme")
         (pywal-scripts-directory "~/xos/pywal-scripts")
         (image-files (directory-files-recursively default-directory "\\.\\(png\\|jpg\\|jpeg\\|webp\\)$")))
    (ivy-read "Choose wallpaper: "
              image-files
              :action (lambda (wallpaper)
                        (when (and (not (string-empty-p wallpaper))
                                   (file-exists-p wallpaper))
                          (let ((abs-wallpaper (expand-file-name wallpaper)))
                            (shell-command-to-string (concat "wal -i " abs-wallpaper))
                            (with-temp-file (concat theme-directory "/.wallpaper")
                              (insert abs-wallpaper))
                            (shell-command-to-string "theme pywal --no-random")
                            (dolist (script '("xmonad-dark-wal.py" "nvim-wal.py" "nvim-wal-dark.py"))
                              (shell-command-to-string (concat "python3 " pywal-scripts-directory "/" script)))
                            (shell-command-to-string "xmonad --restart")
                            ;; (shell-command "papirus-wal")
                            (shell-command-to-string "oomox-gtk-gen")
                            (laluxx/load-org-wal-colors)
                            (run-at-time "1 sec" nil 'spaceline-compile)))))))  ; Delay spaceline-compile

(defun set-wallpaper ()
  (interactive)
  (let* ((default-directory "~/xos/wallpapers/static/")
         (image-files (directory-files-recursively default-directory "\\.\\(png\\|jpg\\|jpeg\\|webp\\)$")))
    (ivy-read "Choose wallpaper: "
              image-files
              :action (lambda (wallpaper)
                        (when (file-exists-p wallpaper)
                          (start-process-shell-command "feh" nil (format "feh --bg-scale '%s'" (shell-quote-argument wallpaper))))))))

;; TODO: set a specific wallpaper based on the theme,                                            [x]  set-wallpaper-to-match-doom-theme
;; TODO: org bullets should use those colors too,                                                []
;; TODO: make a version of this function that let you consuel a theme and do everything,         []
;; TODO: make this function send a signal to xmonad to set all workspaces to "threecol"          []

(defun laluxx/doom-wal ()
  "Run theme-magic-from-emacs, PyWal scripts and execute PyWal scripts."
  (interactive)
  (theme-magic-from-emacs)
  (shell-command "pkill picom")
  (shell-command "python3 /home/l/xos/pywal-scripts/xmonad-dark-wal.py")    ;; Xmonad dark  theme
  ;; (shell-command "python3 /home/l/xos/pywal-scripts/xmonad-light-wal.py") ;; light theme
  (laluxx/set-wallpaper-to-match-doom-theme)
  (shell-command "xmonad --restart"))
  (shell-command "python3 /home/l/xos/pywal-scripts/nvim-wal.py")

;; TODO: set a specific wallpaper based on the theme,                                            [x]  set-wallpaper-to-match-doom-theme
;; TODO: org bullets should use those colors too,                                                []
;; TODO: make a version of this function that let you consuel a theme and do everything,         []
;; TODO: make this function send a signal to xmonad to set all workspaces to "threecol"          []

(defun laluxx/doom-wal-light ()
  "Run theme-magic-from-emacs, PyWal scripts and execute PyWal scripts."
  (interactive)
  (theme-magic-from-emacs)
  (shell-command "pkill picom")
  (shell-command "python3 /home/l/xos/pywal-scripts/xmonad-light-wal.py") ;; xmonad light theme
  (laluxx/set-wallpaper-to-match-doom-theme)
  (shell-command "xmonad --restart"))
  (shell-command "python3 /home/l/xos/pywal-scripts/nvim-wal.py")

(defun laluxx/set-wallpaper-to-match-doom-theme ()
  "Set the desktop wallpaper based on the current Doom Emacs theme."

  (interactive)

  (let* ((theme-name (symbol-name doom-theme))
         (wallpaper-base-path "~/xos/wallpapers/doom/")
         (png-wallpaper (concat wallpaper-base-path theme-name ".png"))
         (jpg-wallpaper (concat wallpaper-base-path theme-name ".jpg"))
         (wallpaper nil))

    ;; Check for PNG and then JPG wallpaper
    (if (file-exists-p png-wallpaper)
        (setq wallpaper png-wallpaper)
      (if (file-exists-p jpg-wallpaper)
          (setq wallpaper jpg-wallpaper)))

    ;; If a matching wallpaper was found, set it using feh
    (if wallpaper
        (shell-command (concat "feh --bg-scale " wallpaper))
      (message "No matching wallpaper found for theme '%s'" theme-name))))

(defun org-insert-header-tags ()
  "Insert personalized header tags at the beginning of the current Org file."
  (interactive)
  (goto-char (point-min)) ; Move to the beginning of the buffer
  (insert "#+TITLE: \n") ; Insert TITLE tag
  (insert "#+AUTHOR: laluxx\n") ; Insert AUTHOR tag with your desired value
  (insert "#+DESCRIPTION: \n") ; Insert DESCRIPTION tag
  (insert "#+STARTUP: showeverything\n") ; Insert STARTUP tag
  (insert "#+PROPERTY: header-args :tangle\n") ; Insert TANGLE tag
  (insert "\n") ; Insert a newline for separation
  (message "Header tags inserted.")
  (evil-goto-first-line) ; Move cursor to the top of the buffer
  (evil-append-line 0)) ; Move cursor to the end of the line (after TITLE) and enter insert mode (Evil)

(defun org-jump-to-tangled ()
  "Jump to the tangled file corresponding to the current Org mode file."
  (interactive)
  (let ((tangled-file (org-jump-to-tangled-file-name)))
    (if tangled-file
        (find-file (expand-file-name tangled-file (file-name-directory buffer-file-name)))
      (message "Tangled file not specified in the document."))))

(defun org-jump-to-tangled-file-name ()
  "Extract the tangled file name from the Org mode file properties.
If not specified, return nil."
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^#\\+PROPERTY: header-args :tangle \\(.+\\)$" nil t)
      (match-string 1))))

(defun org-jump-to-tangled-split-and-zoom ()
  "Split the window vertically, jump to the tangled file corresponding to the current Org mode file in the new window, and adjust the zoom level."
  (interactive)
  (let ((tangled-file (org-jump-to-tangled-file-name)))
    (if tangled-file
        (progn
          (text-scale-set -1)  ;; Set the desired zoom level here
          (execute-kbd-macro (kbd "SPC w v"))  ;; Split window vertically
          (execute-kbd-macro (kbd "SPC o j"))) ;; Jump to tangled
      (message "Tangled file not specified in the document."))))

(defun laluxx/list-hooks ()
  "List all hooks in a completing-read interface."
  (interactive)
  (let* ((hook-symbols (sort
                        (seq-filter (lambda (sym)
                                      (and (symbolp sym)
                                           (string-suffix-p "-hook" (symbol-name sym))))
                                    (append obarray nil))
                        #'string-lessp))
         (hooks (mapcar #'symbol-name hook-symbols))
         (selected-hook (completing-read "Hooks: " hooks)))
    (when selected-hook
      (describe-variable (intern selected-hook)))))

(defun open-dir (key desc dir)
  (map! :leader
        :desc desc
        key (lambda () (interactive) (dired dir))))

(open-dir "f P" "Open dotfiles directory" "~/Desktop/pulls/dotfiles/.config/doom")
(open-dir "f t" "Open test directory" "~/Desktop/test")
(open-dir "f x" "Open xos directory" "~/xos")
(open-dir "f z" "Open dotfiles zsh directory" "~/Desktop/pulls/dotfiles/.config/zsh")

(setq ivy-posframe-display-functions-alist
      '((swiper                     . ivy-posframe-display-at-point)
        (complete-symbol            . ivy-posframe-display-at-point)
        ;; (counsel-M-x                . ivy-display-function-fallback)
        (counsel-esh-history        . ivy-posframe-display-at-window-center)
        (counsel-describe-function  . ivy-display-function-fallback)
        (counsel-describe-variable  . ivy-display-function-fallback)
        (counsel-find-file          . ivy-display-function-fallback)
        (counsel-recentf            . ivy-display-function-fallback)
        (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
        (dmenu                      . ivy-posframe-display-at-frame-top-center)
        (nil                        . ivy-posframe-display))
      ivy-posframe-height-alist
      '((swiper . 20)
        (dmenu . 20)
        (t . 10)))
(ivy-posframe-mode 1) ; 1 enables posframe-mode, 0 disables it.

(map! :leader
      (:prefix ("v" . "Ivy")
       :desc "Ivy push view" "v p" #'ivy-push-view
       :desc "Ivy switch view" "v s" #'ivy-switch-view))

(after! evil
  (define-key evil-insert-state-map (kbd "C-v") 'yank)
  (define-key evil-insert-state-map (kbd "C-s") 'save-buffer)
  (define-key evil-insert-state-map (kbd "C-c") 'kill-ring-save)
  (define-key evil-insert-state-map (kbd "C-x") 'kill-region)
  (define-key evil-insert-state-map (kbd "C-z") 'undo)
  (define-key evil-insert-state-map (kbd "C-y") 'redo))

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
       ;; :desc "Dired split jump" "J" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired ;; HALF WORKING
        :desc "Dired view file"           "d v" #'dired-view-file)))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(use-package spaceline-config
  :ensure spaceline
  :config
  (setq spaceline-buffer-encoding-abbrev-p nil
        spaceline-line-column-p nil
        spaceline-line-p nil
        spaceline-highlight-face-func 'spaceline-highlight-face-evil-state
        powerline-default-separator 'wave)

  (spaceline-define-segment evil-state
    "The current evil state.  Requires `evil-mode' to be enabled."
    (when (bound-and-true-p evil-local-mode)
      (s-trim (evil-state-property evil-state :tag t))))

  (spaceline-define-segment buffer-modified
    "Replace the `buffer-modified' segment with an exclamation point for
    modified buffers and an asterisk for read-only buffers."
    (cond (buffer-read-only "*")
          ((buffer-modified-p) "!")))

  (setq spaceline-left
        '((evil-state :face highlight-face)
          (buffer-modified :face error-face)
          anzu
          auto-compile
          ((buffer-id buffer-size) :separator " | ")
          major-mode
          ((flycheck-error flycheck-warning flycheck-info)
           :when active)
          (version-control :when active)
          (org-pomodoro :when active)
          (org-clock :when active)))

  (setq spaceline-right
        '((global :when active)
          buffer-position
          hud))

  (spaceline-spacemacs-theme))

;; FIXME
;; (defvar my-modeline-state 'doom)

;; (defun laluxx/toggle-modeline ()
;;   "Toggle between doom-modeline, spaceline, and no modeline."
;;   (interactive)
;;   (cond
;;    ((eq my-modeline-state 'doom)
;;     (doom-modeline-mode -1)
;;     (spaceline-spacemacs-theme)
;;     (setq my-modeline-state 'spaceline))
;;    ((eq my-modeline-state 'spaceline)
;;     (hide-mode-line-mode 1)
;;     (setq my-modeline-state 'none))
;;    ((eq my-modeline-state 'none)
;;     (hide-mode-line-mode -1)
;;     (doom-modeline-mode 1)
;;     (setq my-modeline-state 'doom))))

1(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     t
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

;; BREAK dirvish icons
;; (use-package treemacs-icons-dired
;;   :hook (dired-mode . treemacs-icons-dired-enable-once)
;;   :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                (list 'org-agenda-mode)))
     (rainbow-mode 1))))
(global-rainbow-mode 1 )

(defun emacs-run-launcher ()
  "Create and select a frame called emacs-run-launcher which consists only of a minibuffer and has specific dimensions. Runs app-launcher-run-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
  (interactive)
  (with-selected-frame
    (make-frame '((name . "emacs-run-launcher")
                  (minibuffer . only)
                  (fullscreen . 0) ; no fullscreen
                  (undecorated . t) ; remove title bar
                  ;;(auto-raise . t) ; focus on this frame
                  ;;(tool-bar-lines . 0)
                  ;;(menu-bar-lines . 0)
                  (internal-border-width . 10)
                  (width . 80)
                  (height . 11)))
                  (unwind-protect
                    (app-launcher-run-app)
                    (delete-frame))))

(defun laluxx/update-dotfiles ()
  "Update dotfiles."
  (interactive)
  (let* ((dotfiles-path (expand-file-name "~/Desktop/pulls/dotfiles"))
         (command (concat "rsync -a " dotfiles-path "/. $HOME/")))
    (shell-command command)
    (message "Updated dotfiles")))

(defun laluxx/run-update-dotfiles ()
  "Run `laluxx/update-dotfiles` if the current file is inside ~/Desktop/pulls/dotfiles or its subdirectories."
  (when (and buffer-file-name
             (string-prefix-p (expand-file-name "~/Desktop/pulls/dotfiles") buffer-file-name)
             (string= (file-name-extension buffer-file-name) "org"))
    (laluxx/update-dotfiles)))

(add-hook 'after-save-hook 'laluxx/run-update-dotfiles)
