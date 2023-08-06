
# Table of Contents

1.  [Tutorial](#org2bc694d)
2.  [look and feel](#orgdcdc346)
    1.  [No modeline](#orgd42934e)
        1.  [dired](#org076f81d)
        2.  [Vterm](#orgc72ac9e)
    2.  [toolbar](#org76cf878)
    3.  [smooth-scrolling](#orge93e249)
    4.  [scrollbar](#orgd75886d)
    5.  [raibow-delimiters](#orgdaa16d0)
    6.  [trasparency / opacity](#org6eb713b)
3.  [FONT](#org996d172)
    1.  [Doom](#orgae7d7d2)
    2.  [Dired](#org114bbe1)
    3.  [Minibuffer](#orgf6f8e84)
        1.  [Default](#orgf205604)
        2.  [Prompt](#org1788dd3)
    4.  [Org](#org5557fd2)
    5.  [Markdown](#orgcfbfeac)
    6.  [Python](#orgdfb6891)
4.  [Dashboard](#org5afddf1)
    1.  [scroll](#orgb49057b)
    2.  [Modeline](#orgab7d298)
    3.  [Highlight](#org1afe1f5)
    4.  [Conf](#org7418a61)
    5.  [Keybinds](#org5d68e64)
    6.  [Initial-buffer](#orgfc19d64)
5.  [Keybinds](#orgf03a5da)
    1.  [Diff](#org66437f3)
    2.  [Regex](#org80b0fff)
    3.  [Org](#org442d2c1)
    4.  [Toggle](#orgce59eae)
    5.  [Btop](#org0de2bf0)
    6.  [Org](#org52f1921)
        1.  [block-jump](#org5df0406)
        2.  [Shifttab](#org6f82976)
        3.  [Evil](#orgd08862d)
        4.  [Mouse](#orgb5546a2)
        5.  [Insert-header-tags](#orgcb966f9)
        6.  [Jump](#org8eeb761)
        7.  [Split-jump](#org353e67d)
    7.  [Shells](#org05c4969)
    8.  [Doom overwrite](#org5273538)
    9.  [General-key](#org815b92d)
        1.  [Dir-split-jump](#org50db28c)
    10. [Dmenu](#org88a7b5a)
    11. [HELP](#orga5fae37)
        1.  [Hooks](#org24e2b55)
6.  [FUNCTIONS](#org1975fdb)
    1.  [XOS](#orgd6781d9)
    2.  [update-dotfiles](#org02a4030)
        1.  [run-update-dotfiles](#org01daa87)
    3.  [Diff](#org455b8c7)
    4.  [emacs-Window-manager](#org9a526f6)
        1.  [Edwina](#org96a9524)
        2.  [Enlarge OR neotree OR re-builder](#org8916bad)
        3.  [Highlight](#org97aad3d)
        4.  [Keybinds](#org1dbd2a2)
        5.  [Modeline](#org8607852)
        6.  [Tall](#orgc89e24c)
        7.  [Monocole](#orgbe94f81)
        8.  [Splits](#orgef00803)
    5.  [Kill-buffer](#orgb9b27d0)
    6.  [emacs-speak-to-python](#orgabe203d)
    7.  [Wal-watcher](#orgfb31ed1)
    8.  [Load-Org-Colors](#org24271ff)
    9.  [Wal-Set](#orgd1bd582)
        1.  [Default](#org251a7b1)
        2.  [Favourite](#org39d131d)
        3.  [solid](#org60d7167)
        4.  [Set-wallpaper](#orgf42e10b)
    10. [Doom-wal](#org205d3ec)
    11. [Doom-wal-light](#org359d5a3)
    12. [set-wallpaper-to-match-doom-theme](#org3dcc5f5)
    13. [Org](#org3d91085)
    14. [List-hooks](#org785a65a)
        1.  [Open-dir](#org0dfb6cb)
7.  [Open-dir-keybind](#org6ca43bb)
8.  [IVY](#org68bf34a)
    1.  [IVY-POSFRAME](#orgf911fd5)
    2.  [IVY KEYBINDINGS](#orga73087c)
9.  [EVIL MODE](#orgedebe54)
    1.  [INSERT](#org7097b23)
10. [DIRED](#org51e0f53)
    1.  [Keybinds](#orgd243841)
    2.  [Condifuration](#org0bfe25e)
    3.  [Custom faces](#org91f0172)
    4.  [Run](#org44fc065)
    5.  [Keybindings Within Dired With Peep-Dired-Mode Enabled](#orgc7e3663)
11. [SPACELINE](#orgd2643b2)
    1.  [Conf](#org574020c)
    2.  [toggle-modeline](#orgcb0b56c)
12. [RAINBOW MODE](#orgf322728)
13. [Emacs-run](#orgc1a991e)
    1.  [Run-launcher](#org2472ae6)
    2.  [wal-set](#orga0d4a1d)
        1.  [Default](#orga1fcb73)
        2.  [Solid](#orga12c97d)
        3.  [favourite](#org4d893b8)
        4.  [Set-wallpaper](#org891cf96)
    3.  [M-X](#orgb67ae1a)
    4.  [Info](#org351d5bd)
    5.  [Which-key](#orgd187c0f)
    6.  [Dired](#orga3c2f3c)
    7.  [Clone-client-frame](#org64529fb)
        1.  [Dmenu](#orga6b7169)
14. [Config](#org0194b7d)
    1.  [Evil](#org28d936c)
    2.  [org-auto-tangle](#org41d0ab8)
    3.  [Centaur-tabs](#org57f3c9e)
    4.  [Vterm](#orgea9faf7)
    5.  [Magit](#org1d04337)
    6.  [Neotree](#org28ba692)
    7.  [Ewal](#org8c260d8)
        1.  [Default](#orgf846d86)
        2.  [Ewal-Doom-Theme](#org6dc7bda)
15. [Enable](#org2e38699)
16. [Images](#org6e71fc5)


<a id="org2bc694d"></a>

# Tutorial

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


<a id="orgdcdc346"></a>

# look and feel


<a id="orgd42934e"></a>

## No modeline


<a id="org076f81d"></a>

### dired

    (defun hide-modeline-in-dired-mode ()
      "Hide the modeline in `dired-mode'."
      (setq mode-line-format nil))
    
    (add-hook 'dired-mode-hook 'hide-modeline-in-dired-mode)


<a id="orgc72ac9e"></a>

### Vterm

    (defun hide-modeline-in-dired-mode ()
      "Hide the modeline in `dired-mode'."
      (setq mode-line-format nil))
    
    (add-hook 'dired-mode-hook 'hide-modeline-in-dired-mode)
    
    (defun hide-modeline-in-vterm-mode ()
      "Hide the modeline in `vterm-mode'."
      (setq mode-line-format nil))
    
    (add-hook 'vterm-mode-hook 'hide-modeline-in-vterm-mode)


<a id="org76cf878"></a>

## toolbar

    (tool-bar-mode  -1)
    (scroll-bar-mode  -1)
    (menu-bar-mode  -1)


<a id="orge93e249"></a>

## smooth-scrolling

    (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
    (setq mouse-wheel-progressive-speed nil) ;; don"t accelerate scrolling
    (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
    (setq scroll-step 1) ;; keyboard scroll one line at a time
    (setq scroll-conservatively 10000)
    (setq auto-window-vscroll nil)


<a id="orgd75886d"></a>

## scrollbar

    (toggle-scroll-bar -1)


<a id="orgdaa16d0"></a>

## raibow-delimiters

    (use-package rainbow-delimiters
      :hook (prog-mode . rainbow-delimiters-mode))


<a id="org6eb713b"></a>

## trasparency / opacity

set trasparency of emacs
when focused and not focused

    (set-frame-parameter (selected-frame) 'alpha '(95 100))
    (add-to-list 'default-frame-alist '(alpha 95 100))
    
    
    ;; (add-to-list 'default-frame-alist '(alpha-background . 90))


<a id="org996d172"></a>

# FONT

TODO

-   variables [] (OCR B)


<a id="orgae7d7d2"></a>

## Doom

Settings related to fonts within Doom Emacs:

-   &rsquo;doom-font&rsquo; &#x2013; standard monospace font that is used for most things in Emacs.
-   &rsquo;doom-variable-pitch-font&rsquo; &#x2013; variable font which is useful in some Emacs plugins.
-   &rsquo;doom-big-font&rsquo; &#x2013; used in doom-big-font-mode; useful for presentations.
-   &rsquo;font-lock-comment-face&rsquo; &#x2013; for comments.
-   &rsquo;font-lock-keyword-face&rsquo; &#x2013; for keywords with special significance like &rsquo;setq&rsquo; in elisp.

    (setq doom-font (font-spec :family "JetBrains Mono NF ExtraBold" :size 15) ;; :height 1.1)
          doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
          doom-big-font (font-spec :family "JetBrains Mono" :size 24))
    (after! doom-themes
      (setq doom-themes-enable-bold t
            doom-themes-enable-italic t))
    (custom-set-faces!
      '(font-lock-comment-face :slant italic)
      '(font-lock-keyword-face :slant italic))


<a id="org114bbe1"></a>

## Dired

    ;; (defun use-ocr-b-bold ()
    ;;   "Switch the current buffer to the OCR B-Bold font."
    ;;   (face-remap-add-relative 'default '(:family "JetBrains Mono NF ExtraBold" :height 130)))
    
    ;; (add-hook 'dired-mode-hook 'use-ocr-b-bold)
    
    
    ;; (defun use-jetbrains-mono-extrabold ()
    ;;   "Switch the current buffer to JetBrains Mono ExtraBold font."
    ;;   (interactive)
    ;;   (message "Running use-jetbrains-mono-extrabold...")
    ;;   (face-remap-add-relative 'default '(:family "JetBrains Mono ExtraBold" :height 130)))
    
    ;; (with-eval-after-load 'dired
    ;;   (add-hook 'dired-mode-hook 'use-jetbrains-mono-extrabold))


<a id="orgf6f8e84"></a>

## Minibuffer


<a id="orgf205604"></a>

### Default

adding a function to minibuffer-setup-hook, which Emacs runs every time the minibuffer is entered

    (defun set-minibuffer-font ()
      "Set the font for the minibuffer."
      (face-remap-add-relative 'default '(:family "JetBrains Mono NF ExtraBold" :height 100)))
    
    (add-hook 'minibuffer-setup-hook 'set-minibuffer-font)


<a id="org1788dd3"></a>

### Prompt

    (custom-set-faces
      '(minibuffer-prompt ((t (:family "JetBrains Mono NF ExtraBold" :height 120)))))


<a id="org5557fd2"></a>

## Org

    ;; (defun my-set-org-mode-font ()
    ;;   "Set the font to JetBrains Mono NF ExtraBold when in org mode."
    ;;   (interactive)
    ;;   (when (derived-mode-p 'org-mode)
    ;;     (setq buffer-face-mode-face '(:family "JetBrains Mono NF ExtraBold" :height 1.1)) ;;  NF ExtraBold
    ;;     (buffer-face-mode)))
    
    ;; (add-hook 'org-mode-hook 'my-set-org-mode-font)


<a id="orgcfbfeac"></a>

## Markdown

    (defun my-set-markdown-mode-font ()
      "Set the font to JetBrains Mono NF ExtraBold when in markdown mode."
      (interactive)
      (when (derived-mode-p 'markdown-mode)
        (setq buffer-face-mode-face '(:family "JetBrains Mono NF ExtraBold" :height 1.1))
        (buffer-face-mode)))
    
    (add-hook 'markdown-mode-hook 'my-set-markdown-mode-font)


<a id="orgdfb6891"></a>

## Python

set everything

    (defun my-set-python-mode-font ()
      "Set the font to Space Mono when in python mode."
      (interactive)
      (when (derived-mode-p 'python-mode)
        (setq buffer-face-mode-face '(:family "jetbrains mono nl extrabold" :height 1.3)) ;; Ubuntu Mono
        (buffer-face-mode)))
    
    (add-hook 'python-mode-hook 'my-set-python-mode-font)


<a id="org5afddf1"></a>

# Dashboard


<a id="orgb49057b"></a>

## scroll

fix the scroll

    
    (defun my/dashboard-setup ()
      "Setup for dashboard."
      (my/dashboard-bindings)
      ;; Make the cursor invisible in dashboard
      (setq-local cursor-type nil)
      ;; Disable mouse scrolling
      (setq-local mouse-wheel-scroll-amount '(nil))
      (setq-local mouse-wheel-progressive-speed nil)
      ;; Turn off evil-mode in this buffer
      (evil-local-mode -1))
    
    (add-hook 'dashboard-mode-hook 'my/dashboard-setup)


<a id="orgab7d298"></a>

## Modeline

Modeline only for the dashboard


<a id="org1afe1f5"></a>

## Highlight

    (defvar my/current-highlight-overlay nil
      "Overlay variable for current highlighted line.")
    
    (defun my/dashboard-widget-forward (&optional arg)
      "Move point to the next field or button in the current buffer.
    ARG is passed as an argument to 'widget-forward'.
    Then apply highlighting to the current widget."
      (interactive "p")
      (widget-forward arg)
      (my/dashboard-highlight-widget))
    
    (defun my/dashboard-widget-backward (&optional arg)
      "Move point to the previous field or button in the current buffer.
    ARG is passed as an argument to 'widget-backward'.
    Then apply highlighting to the current widget."
      (interactive "p")
      (widget-backward arg)
      (my/dashboard-highlight-widget))
    
    (defun my/dashboard-highlight-widget ()
      "Highlight the current widget with overlay."
      (when-let ((widget (widget-at)))
        ;; Clear previous highlight
        (when my/current-highlight-overlay
          (delete-overlay my/current-highlight-overlay))
        ;; Create new highlight overlay only if the line is not empty
        (unless (looking-at-p "[[:space:]]*$")
          (let* ((start (progn (skip-chars-forward " \t") (point)))
                 (end (point-at-eol))
                 (overlay (make-overlay start end)))
            (overlay-put overlay 'face 'highlight)
            ;; Store new overlay
            (setq my/current-highlight-overlay overlay)))))
    
    (defun my/dashboard-bindings ()
      "Add my keybindings for dashboard."
      (map! :map dashboard-mode-map
            :n "j" #'my/dashboard-widget-forward
            :n "k" #'my/dashboard-widget-backward
            :n "l" #'widget-button-press
            :n "h" #'ignore))
    
    (defun my/dashboard-setup ()
      "Setup for dashboard."
      (my/dashboard-bindings)
      ;; Make the cursor invisible in dashboard
      (setq-local cursor-type nil))
    
    (add-hook 'dashboard-mode-hook 'my/dashboard-setup)


<a id="org7418a61"></a>

## Conf

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


<a id="org5d68e64"></a>

## Keybinds

keybind within the dashboard

    ;; (defun my/dashboard-bindings ()
    ;;   "Add my keybindings for dashboard."
    ;;   (map! :map dashboard-mode-map
    ;;         :n "l" #'widget-button-press
    ;;         :n "h" #'ignore))
    ;;         :n "j" #'widget-forward
    ;;         :n "k" #'widget-backward
    
    ;; (add-hook 'dashboard-mode-hook 'my/dashboard-bindings)
    
    
    ;; (map! :map dashboard-mode-map
    ;;         "<mouse-4>" #'my/dashboard-widget-forward
    ;;         "<mouse-5>" #'my/dashboard-widget-backward
    ;;         :n "l" #'widget-button-press
    ;;         :n "h" #'ignore)


<a id="orgfc19d64"></a>

## Initial-buffer

Set dashboard as the initial buffer

    (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))


<a id="orgf03a5da"></a>

# Keybinds


<a id="org66437f3"></a>

## Diff

    (map! :leader
          (:prefix ("d" . "diff")
            :desc "diff buffer with file" "i" #'laluxx/diff-buffer-with-file))


<a id="org80b0fff"></a>

## Regex

    (map! :leader
          (:prefix ("r" . "regexp")
            :desc "Regex builder" "b" #'re-builder))


<a id="org442d2c1"></a>

## Org

    (after! org
      (map! :map org-mode-map
            :nvi "<C-return>" #'laluxx/create-window-based-on-layout
            :nvi "<C-M-return>" #'vterm
            :nvi "C-j" #'my-switch-buffer-forward-or-other-window
            :nvi "C-k" #'my-switch-buffer-backward-or-other-window))


<a id="orgce59eae"></a>

## Toggle

    (map! :leader
          (:prefix ("t" . "Toggle")
           :desc "Toggle truncated lines" "t" #'visual-line-mode))


<a id="org0de2bf0"></a>

## Btop

open a new window containing btop


<a id="org52f1921"></a>

## Org


<a id="org5df0406"></a>

### block-jump

if inside a src code block
shift + j -> cursor at the end of the code block
shift + k -> cursor at the start of the code block

    (defun my/org-beginning-of-src-block ()
      "Move point to the beginning of the current source block."
      (interactive)
      (when (org-in-src-block-p)
        (search-backward "#+begin_src")
        (forward-line)
        (beginning-of-line)))
    
    (defun my/org-end-of-src-block ()
      "Move point to the end of the current source block."
      (interactive)
      (when (org-in-src-block-p)
        (search-forward "#+end_src")
        (backward-char 11)))
    
    (defun my/org-src-keybindings ()
      "Setup keybindings for org-src-mode."
      (when (org-in-src-block-p)
        (let ((map (make-sparse-keymap)))
          (define-key map (kbd "M-k") 'my/org-beginning-of-src-block)
          (define-key map (kbd "M-j") 'my/org-end-of-src-block)
          (set-transient-map map t))))
    
    (add-hook 'org-mode-hook 'my/org-src-keybindings)
    
    (with-eval-after-load 'evil-maps
      (define-key evil-visual-state-map (kbd "M-k") 'my/org-beginning-of-src-block)
      (define-key evil-visual-state-map (kbd "M-j") 'my/org-end-of-src-block))


<a id="org6f82976"></a>

### Shifttab

    ;; MAIN
    (defun my/org-shifttab-advice (orig-fun &rest args)
      "Always use global cycling with `org-shifttab'."
      (let ((context (org-element-lineage
                      (org-element-context)
                      '(headline inlinetask) t)))
        (if (or (not context)
                (eq 'headline (org-element-type context)))
            (apply 'org-global-cycle args)
          (apply orig-fun args))))
    
    (advice-add 'org-shifttab :around 'my/org-shifttab-advice)
    
    
    (defun my/org-shifttab-or-beginning-of-line ()
      "Call org-shifttab, then move to the beginning of the line."
      (interactive)
      (org-shifttab)
      (run-at-time "0.3 sec" nil #'beginning-of-line))
    
    (with-eval-after-load 'org
      (define-key org-mode-map (kbd "<backtab>") #'my/org-shifttab-or-beginning-of-line))


<a id="orgd08862d"></a>

### Evil

open org bullets with `l` and close them with `h`

    (defun my-org-cycle-or-move-right ()
      (interactive)
      (if (and (bolp) (org-at-heading-p))
          (org-cycle)
        (evil-forward-char 1)))
    
    (defun my-org-close-or-move-left ()
      (interactive)
      (if (and (bolp) (org-at-heading-p))
          (outline-hide-subtree)
        (evil-backward-char 1)))
    
    (add-hook 'org-mode-hook
              (lambda ()
                (evil-define-key 'normal org-mode-map
                  (kbd "l") 'my-org-cycle-or-move-right)
                (evil-define-key 'normal org-mode-map
                  (kbd "h") 'my-org-close-or-move-left)))


<a id="orgb5546a2"></a>

### Mouse

    ;; OVERLAY DONE
    (defvar org-headline-overlay nil)
    (defvar org-last-highlighted-line nil)
    
    (defun org-highlight-headline ()
      (when (org-at-heading-p)
        (if org-headline-overlay
            (move-overlay org-headline-overlay (line-beginning-position) (line-end-position))
          (setq org-headline-overlay (make-overlay (line-beginning-position) (line-end-position))))
        (overlay-put org-headline-overlay 'face 'highlight)
        (setq org-last-highlighted-line (line-number-at-pos))))
    
    (defun org-unhighlight-headline ()
      (when org-headline-overlay
        (delete-overlay org-headline-overlay)))
    
    (defun org-next-headline-or-wrap ()
      (interactive)
      (org-unhighlight-headline)
      (let ((initial-position (point)))
        (org-next-visible-heading 1)
        (when (= (point) initial-position)
          (goto-char (point-min))))
      (org-highlight-headline))
    
    (defun org-previous-headline-or-wrap ()
      (interactive)
      (org-unhighlight-headline)
      (let ((initial-position (point)))
        (unless (and (eobp) (looking-at-p "^$"))
          (org-previous-visible-heading 1))
        (when (= (point) initial-position)
          (goto-char (point-max))
          (org-previous-visible-heading 1)))
      (org-highlight-headline))
    
    (defun org-go-to-last-highlighted-line ()
      (interactive)
      (when org-last-highlighted-line
        (goto-line org-last-highlighted-line)
        (org-highlight-headline)))
    
    (add-hook 'org-mode-hook
              (lambda ()
                (define-key org-mode-map (kbd "<S-mouse-4>") 'org-previous-headline-or-wrap)
                (define-key org-mode-map (kbd "<S-mouse-5>") 'org-next-headline-or-wrap)
                (define-key org-mode-map (kbd "<S-mouse-2>") 'org-go-to-last-highlighted-line)
                (define-key org-mode-map (kbd "<S-mouse-8>") 'org-cycle)
                (define-key org-mode-map (kbd "<M-mouse-4>") 'previous-line)
                (define-key org-mode-map (kbd "<M-mouse-5>") 'next-line)
                (define-key org-mode-map (kbd "M-C-j") 'org-next-headline-or-wrap)
                (define-key org-mode-map (kbd "M-C-k") 'org-previous-headline-or-wrap)
                (define-key org-mode-map (kbd "<S-mouse-9>") (lambda () (interactive) (org-cycle t)))))


<a id="orgcb966f9"></a>

### Insert-header-tags

    (map! :leader
          :desc "Insert header tags"
          "i o" #'org-insert-header-tags)


<a id="org8eeb761"></a>

### Jump

    (map! :leader
          :desc "Jump to tangled file"
          "o j" #'org-jump-to-tangled)


<a id="org353e67d"></a>

### Split-jump

Jump, vsplit and set zoom if tangled file exist

    (map! :leader
          :desc "Split and jump to tangled file with zoom"
          "o J" #'org-jump-to-tangled-split-and-zoom)


<a id="org05c4969"></a>

## Shells

    (map! :leader
          :desc "Eshell"                 "e s" #'eshell
          :desc "Eshell popup toggle"    "t e" #'+eshell/toggle
          :desc "Counsel eshell history" "e h" #'counsel-esh-history
          :desc "Vterm popup toggle"     "v t" #'+vterm/toggle)


<a id="org5273538"></a>

## Doom overwrite

    (map! :leader
          :desc "Kill buffer and open dashboard if last buffer"
          "b k" 'kill-buffer-and-maybe-open-dashboard)


<a id="org815b92d"></a>

## General-key

Keybinds that execute other keybinds.


<a id="org50db28c"></a>

### Dir-split-jump

    (map! :leader
          :desc "Custom Keybind"
          "d J" (lambda ()
                  (interactive)
    
                  (text-scale-set -1)  ;; Set the desired zoom level here
                  (execute-kbd-macro (kbd "SPC w v"))
                  (execute-kbd-macro (kbd "SPC d j"))))


<a id="org88a7b5a"></a>

## Dmenu

    (global-set-key (kbd "M-p") 'dmenu)


<a id="orga5fae37"></a>

## HELP


<a id="org24e2b55"></a>

### Hooks

    (map! :leader
          :desc "Show all hooks"
          "hh" #'laluxx/list-hooks)


<a id="org1975fdb"></a>

# FUNCTIONS


<a id="orgd6781d9"></a>

## XOS


<a id="org02a4030"></a>

## update-dotfiles

whenever you save a file inside &ldquo;~/Desktop/pulls/dotfiles&rdquo;
or one of its subdirectories && if that file is a org file

    (defun laluxx/update-dotfiles ()
      "Update dotfiles."
      (interactive)
      (let* ((dotfiles-path (expand-file-name "~/Desktop/pulls/dotfiles"))
             (command (concat "rsync -a " dotfiles-path "/. $HOME/")))
        (shell-command command)
        (message "Updated dotfiles")))


<a id="org01daa87"></a>

### run-update-dotfiles

    ;; ONLY org
    ;; (defun laluxx/run-update-dotfiles ()
    ;;   "Run `laluxx/update-dotfiles` if the current file is inside ~/Desktop/pulls/dotfiles or its subdirectories."
    ;;   (when (and buffer-file-name
    ;;              (string-prefix-p (expand-file-name "~/Desktop/pulls/dotfiles") buffer-file-name)
    ;;              (string= (file-name-extension buffer-file-name) "org"))
    ;;     (laluxx/update-dotfiles)))
    
    ;; (add-hook 'after-save-hook 'laluxx/run-update-dotfiles)
    
    ;; ALL file extentions
    (defun laluxx/run-update-dotfiles ()
      "Run `laluxx/update-dotfiles` if the current file is inside ~/Desktop/pulls/dotfiles or its subdirectories."
      (when (and buffer-file-name
                 (string-prefix-p (expand-file-name "~/Desktop/pulls/dotfiles") buffer-file-name))
        (laluxx/update-dotfiles)))
    
    (add-hook 'after-save-hook 'laluxx/run-update-dotfiles)


<a id="org455b8c7"></a>

## Diff

    ;;   (defun laluxx/diff-buffer-with-file (&optional arg)
    ;;     "Compare buffer to its file, else run `vc-diff'.
    ;; With \\[universal-argument] also enable highlighting of word-wise
    ;; changes, local to the current buffer."
    ;;     (interactive "P")
    ;;     (let ((buf nil))     ; this method will "fail" if multi diff buffers
    ;;       (if (buffer-modified-p)
    ;;           (progn
    ;;             (diff-buffer-with-file (current-buffer))
    ;;             (setq buf "*Diff*"))
    ;;         (vc-diff)
    ;;         (setq buf "*vc-diff*"))
    ;;       (when arg
    ;;         (with-current-buffer (get-buffer buf)
    ;;           (setq-local diff-refine 'font-lock)))))
    
    
    (defvar laluxx/diff-buffer nil
      "Stores the current diff buffer if one exists.")
    
    (defun laluxx/diff-buffer-with-file (&optional arg)
      "Compare buffer to its file, else run `vc-diff'.
    With \\[universal-argument] also enable highlighting of word-wise
    changes, local to the current buffer."
      (interactive "P")
      (if (and laluxx/diff-buffer
               (buffer-live-p laluxx/diff-buffer)
               (get-buffer-window laluxx/diff-buffer t))
          (progn
            (kill-buffer laluxx/diff-buffer)
            (setq laluxx/diff-buffer nil))
        (if (and (not laluxx/diff-buffer)
                 (or (not (buffer-live-p laluxx/diff-buffer))
                     (not (get-buffer-window laluxx/diff-buffer t))))
            (let ((buf nil))
              (if (buffer-modified-p)
                  (progn
                    (diff-buffer-with-file (current-buffer))
                    (setq buf "*Diff*"))
                (vc-diff)
                (setq buf "*vc-diff*"))
              (setq laluxx/diff-buffer (get-buffer buf))
              (display-buffer laluxx/diff-buffer)
              (when arg
                (with-current-buffer laluxx/diff-buffer
                  (setq-local diff-refine 'font-lock)))))))


<a id="org9a526f6"></a>

## emacs-Window-manager


<a id="org96a9524"></a>

### Edwina

    (use-package! edwina
      :config
      ;; Your config here...
      (setq display-buffer-base-action '(display-buffer-below-selected))
      (edwina-setup-dwm-keys)
      (edwina-mode 1))


<a id="org8916bad"></a>

### Enlarge OR neotree OR re-builder

1.  Default

    If there is only one window, \`ctrl h\` and \`ctrl l\` will cycle buffers. If there are multiple windows, \`ctrl h\` and \`ctrl l\` will resize the windows.
    
        (defun enlarge-window-horizontally-left ()
          "Enlarges the window horizontally by 10 units."
          (interactive)
          (enlarge-window-horizontally 10))
        
        (defun shrink-window-horizontally-left ()
          "Shrinks the window horizontally by 10 units."
          (interactive)
          (shrink-window-horizontally 10))
        
        (defun enlarge-window-horizontally-right ()
          "Enlarges the window horizontally by 10 units."
          (interactive)
          (shrink-window-horizontally 10))
        
        (defun shrink-window-horizontally-right ()
          "Shrinks the window horizontally by 10 units."
          (interactive)
          (enlarge-window-horizontally 10))
        
        (defun resize-window-horizontally (increase)
          "Resize the current window horizontally.
        If INCREASE is non-nil, enlarge the window, otherwise shrink it."
          (interactive "P")
          (if (window-in-direction 'right)
              (if increase
                  (shrink-window-horizontally-right)
                (enlarge-window-horizontally-right))
            (if increase
                (enlarge-window-horizontally-left)
              (shrink-window-horizontally-left))))
        
        (defun neotree-or-enlarge-window-left ()
          "Open Neotree if there's only one window. Otherwise, enlarge the window to the left."
          (interactive)
          (if (one-window-p)
              (neotree-show)
            (resize-window-horizontally t)))
        
        (defun re-builder-or-enlarge-window-right ()
          "Open Re-Builder if there's only one window. Otherwise, enlarge the window to the right."
          (interactive)
          (if (one-window-p)
              (re-builder)
            (resize-window-horizontally nil)))
        
        (global-set-key (kbd "C-h") 'neotree-or-enlarge-window-left)
        (global-set-key (kbd "C-l") 're-builder-or-enlarge-window-right)


<a id="org97aad3d"></a>

### Highlight

    ;; (defun highlight-selected-window ()
    ;;   "Highlight selected window with a different background color."
    ;;   (walk-windows (lambda (w)
    ;;                   (unless (or (eq w (selected-window)) (minibufferp (window-buffer w)))
    ;;                     (with-current-buffer (window-buffer w)
    ;;                       (buffer-face-set '(:background "#f6f6f6"))))))
    ;;   (unless (minibufferp (window-buffer (selected-window)))
    ;;     (buffer-face-set 'default)))
    
    ;; (add-hook 'buffer-list-update-hook 'highlight-selected-window)
    
    ;; Main
    ;; (require 'color)
    
    ;; (defun highlight-selected-window ()
    ;;   "Highlight selected window with a different background color."
    ;;   (let ((bg (face-attribute 'default :background)))
    ;;     (walk-windows (lambda (w)
    ;;                     (unless (or (eq w (selected-window)) (minibufferp (window-buffer w)))
    ;;                       (with-current-buffer (window-buffer w)
    ;;                         (buffer-face-set `(:background ,(color-darken-name bg 35))))))))
    ;;   (unless (minibufferp (window-buffer (selected-window)))
    ;;     (buffer-face-set 'default)))
    
    ;; (add-hook 'buffer-list-update-hook 'highlight-selected-window)
    
    
    
    ;; FRINGE FIX
    (defun highlight-selected-window ()
      "Highlight selected window with a different background color."
      (let ((bg (face-attribute 'default :background)))
        (walk-windows (lambda (w)
                        (if (eq w (selected-window))
                            (progn
                              (with-current-buffer (window-buffer w)
                                (buffer-face-set 'default))
                              (with-selected-window w
                                (set-face-attribute 'fringe nil :background bg)))
                          (with-current-buffer (window-buffer w)
                            (buffer-face-set `(:background ,(color-darken-name bg 35))))
                          (with-selected-window w
                            (set-face-attribute 'fringe nil :background (color-darken-name bg 35))))))))
    (add-hook 'buffer-list-update-hook 'highlight-selected-window)


<a id="org1dbd2a2"></a>

### Keybinds

    (defun my-switch-buffer-forward-or-other-window ()
      (interactive)
      (if (one-window-p)
          (next-buffer)
        (other-window 1)))
    
    (defun my-switch-buffer-backward-or-other-window ()
      (interactive)
      (if (one-window-p)
          (previous-buffer)
        (other-window -1)))
    
    (after! evil
      (map! :n "C-j" #'my-switch-buffer-forward-or-other-window
            :n "C-k" #'my-switch-buffer-backward-or-other-window))
    
    
    
    
    
    (map! :leader
          (:prefix ("w" . "window")
           "M" #'laluxx/window-single-toggle))
    (map! "C-SPC" #'laluxx/window-single-toggle)
    
    (map! "<C-backspace>" #'delete-window)
    (map! :map evil-normal-state-map
          "C-w" #'delete-window)
    
    (map! :leader
          "SPC" #'rotate-layout)
    
    (global-set-key (kbd "C-M-j") 'rotate-window)
    (global-set-key (kbd "C-M-k") (lambda () (interactive) (dotimes (_ (- (length (window-list)) 1)) (rotate-window))))
    
    (global-set-key (kbd "C-M-<return>") #'vterm) ;; dont work in orgmode or inside vtmerm
    
    
    
    (map! "C-f" #'isearch-forward
          "C-s" #'edwina-inc-nmaster
          "C-d" #'edwina-dec-nmaster)


<a id="org8607852"></a>

### Modeline

TODO

-   no modeline from the 3 buffer

    ;; (defun laluxx/setup-mode-line ()
    ;;   "Set up the mode line."
    ;;   (dolist (window (window-list))
    ;;     (with-selected-window window
    ;;       (if (or (not (window-in-direction 'left))
    ;;               (and (window-in-direction 'down)
    ;;                    (not (window-in-direction 'right))))
    ;;           (hide-mode-line-mode -1)
    ;;         (hide-mode-line-mode 1)))))
    
    ;; (add-hook 'buffer-list-update-hook 'laluxx/setup-mode-line)
    
    
    
    ;; (defun laluxx/setup-mode-line ()
    ;;   "Set up the mode line."
    ;   (let ((windows (window-list))
    ;;         (counter 1))
    ;;     (dolist (window windows)
    ;;       (with-selected-window window
    ;;         (if (<= counter 2)
    ;;             (setq mode-line-format (default-value 'mode-line-format))  ; show modeline
    ;;           (setq mode-line-format nil))  ; hide modeline
    ;;         (setq counter (1+ counter))))))
    
    ;; (add-hook 'buffer-list-update-hook 'laluxx/setup-mode-line)


<a id="orgc89e24c"></a>

### Tall

    (defun laluxx/create-tall-window ()
      "Create a new window for the tall layout."
      (interactive)
      (if (= (length (window-list)) 1)
          (laluxx/vertical-split-and-hide-modeline)
        (select-window (window-at (frame-width) 0))  ; Select the rightmost window
        (laluxx/horizontal-split-and-hide-modeline)))
    
    (defvar laluxx/layouts
      '((:name tall
               :description "Master and stack layout"
               :new-window-function laluxx/create-tall-window)))
    
    (defvar laluxx/current-layout (car laluxx/layouts)
      "Current layout for new windows.")
    
    (defun laluxx/create-window-based-on-layout ()
      "Create a new window based on the current layout."
      (interactive)
      (let ((new-window-function (plist-get laluxx/current-layout :new-window-function)))
        (funcall new-window-function)))
    
    
    (evil-global-set-key 'normal (kbd "<C-return>") #'laluxx/create-window-based-on-layout)


<a id="orgbe94f81"></a>

### Monocole

    (defvar laluxx/window-configuration nil
      "Current window configuration.
    Intended for use by `laluxx/window-single-toggle'.")
    
    (define-minor-mode laluxx/window-single-toggle
      "Toggle between multiple windows and single window.
    This is the equivalent of maximising a window.  Tiling window
    managers such as DWM, BSPWM refer to this state as 'monocle'."
      :lighter " Monocle"
      :global nil
      (if (one-window-p)
          (when laluxx/window-configuration
            (set-window-configuration laluxx/window-configuration)
            (setq laluxx/window-configuration nil))
        (setq laluxx/window-configuration (current-window-configuration))
        (delete-other-windows)))


<a id="orgef00803"></a>

### Splits

1.  Horizzontal

        ;; Proportion fix
        ;;  (defun laluxx/horizontal-split-and-hide-modeline ()
        ;;   "Horizontally split the window, create a new buffer and hide the modeline."
        ;;   (interactive)
        ;;   (split-window-below)
        ;;   (balance-windows)
        ;;   (other-window 1)
        ;;   (switch-to-buffer (generate-new-buffer "new"))
        ;;   (hide-mode-line-mode))
        
        
        ;; (map! :leader
        ;;       (:prefix ("w" . "window")
        ;;        "s" #'laluxx/horizontal-split-and-hide-modeline))

2.  Vertical

        ;; (defun laluxx/vertical-split-and-hide-modeline ()
        ;;   "Vertically split the window, create a new buffer and hide the modeline."
        ;;   (interactive)
        ;;   (split-window-right)
        ;;   (other-window 1)
        ;;   (switch-to-buffer (generate-new-buffer "new"))
        ;;   (hide-mode-line-mode))
        
        ;; (map! :leader
        ;;       (:prefix ("w" . "window")
        ;;        "v" #'laluxx/vertical-split-and-hide-modeline))

3.  Mode

        (define-minor-mode laluxx/split-mode
          "A mode for custom splits."
          :lighter ""
          :init-value nil
          (if laluxx/split-mode
              (progn
                (setq buffer-read-only t
                      cursor-type nil)
                (hide-mode-line-mode 1)
                (evil-define-key* 'normal 'local (kbd "v") 'vterm)
                (evil-define-key* 'insert 'local (kbd "v") 'vterm)
                (evil-define-key* 'visual 'local (kbd "v") 'vterm)
                (evil-define-key* 'normal 'local (kbd "q") 'delete-window)
                (evil-define-key* 'insert 'local (kbd "q") 'delete-window)
                (evil-define-key* 'visual 'local (kbd "q") 'delete-window))
            (progn
              (setq buffer-read-only nil
                    cursor-type t)
              (hide-mode-line-mode -1))))
        
        (defun laluxx/horizontal-split-and-hide-modeline ()
          "Horizontally split the window, create a new buffer, and turn on `laluxx/split-mode'."
          (interactive)
          (split-window-below)
          (balance-windows)
          (other-window 1)
          (switch-to-buffer (generate-new-buffer "new"))
          (laluxx/split-mode 1))
        
        (defun laluxx/vertical-split-and-hide-modeline ()
          "Vertically split the window, create a new buffer, and turn on `laluxx/split-mode'."
          (interactive)
          (split-window-right)
          (other-window 1)
          (switch-to-buffer (generate-new-buffer "new"))
          (laluxx/split-mode 1))
        
        (map! :leader
              (:prefix ("w" . "window")
               "s" #'laluxx/horizontal-split-and-hide-modeline
               "v" #'laluxx/vertical-split-and-hide-modeline))


<a id="orgb9b27d0"></a>

## Kill-buffer

Kill every buffer that is not the dashboard

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


<a id="orgabe203d"></a>

## emacs-speak-to-python

    (defun write-buffer-list-to-file ()
      "Write the current list of buffer names to a file."
      (with-temp-file "/tmp/emacs-buffer-list"
        (insert (mapconcat 'identity (mapcar 'buffer-name (buffer-list)) "\n"))
        (insert "\n----\n")
        (insert (buffer-name (current-buffer)))))
    
    (add-hook 'buffer-list-update-hook 'write-buffer-list-to-file)


<a id="orgfb31ed1"></a>

## Wal-watcher

Setup file watcher for ~/.cache/wal/colors

    (run-with-idle-timer
     1 nil
     (lambda ()
       (file-notify-add-watch
        "~/.cache/wal/colors"
        '(change)
        (lambda (event)
          (load-theme 'ewal-doom-one t)
          (enable-theme 'ewal-doom-one)))))


<a id="org24271ff"></a>

## Load-Org-Colors

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


<a id="orgd1bd582"></a>

## Wal-Set


<a id="org251a7b1"></a>

### Default

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
                                ;; (shell-command-to-string "oomox-gtk-gen")
                                ;; (laluxx/load-org-wal-colors)
                                (run-at-time "1 sec" nil 'spaceline-compile)))))))  ; Delay spaceline-compile


<a id="org39d131d"></a>

### Favourite

Set a wal paper from `~/xos/wallpapers/favourites`

    (defun laluxx/wal-set-favourite ()
      (interactive)
      (let* ((default-directory "~/xos/wallpapers/favourites")
             (theme-directory "~/xos/theme")
             (pywal-scripts-directory "~/xos/pywal-scripts")
             (image-files (directory-files-recursively default-directory "\\.\\(png\\|jpg\\|jpeg\\|webp\\)$")))
        (ivy-read "Favourite wallpapers: "
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
                                ;; (shell-command-to-string "oomox-gtk-gen")
                                ;; (laluxx/load-org-wal-colors)
                                (run-at-time "1 sec" nil 'spaceline-compile)))))))  ; Delay spaceline-compile


<a id="org60d7167"></a>

### solid

Choose a wal paper from `~/xos/wallpapers`
and turn it solid

    (defun laluxx/wal-set-solid ()
      (interactive)
      (let* ((default-directory "~/xos/wallpapers/static")
             (theme-directory "~/xos/theme")
             (pywal-scripts-directory "~/xos/pywal-scripts")
             (solid-wallpapers-directory "~/xos/wallpapers/solid")
             (image-files (directory-files-recursively default-directory "\\.\\(png\\|jpg\\|jpeg\\|webp\\)$")))
        (ivy-read "Wallpapers to turn solid: "
                  image-files
                  :action (lambda (wallpaper)
                            (when (and (not (string-empty-p wallpaper))
                                       (file-exists-p wallpaper))
                              (let* ((abs-wallpaper (expand-file-name wallpaper))
                                     (base-wallpaper-name (file-name-base wallpaper))  ;; Get the filename without extension
                                     (solid-wallpaper (concat solid-wallpapers-directory "/" base-wallpaper-name "-SOLID.png")))
                                (if (file-exists-p solid-wallpaper)
                                    (shell-command-to-string (concat "wal -i " solid-wallpaper))
                                  (progn
                                    (shell-command-to-string (concat "wal -n -i " abs-wallpaper)) ;; Use wal -n to generate colors without setting wallpaper
                                    (shell-command-to-string (concat "wal-set-solid " base-wallpaper-name))))
                                (with-temp-file (concat theme-directory "/.wallpaper")
                                  (insert abs-wallpaper))
                                (shell-command-to-string "theme pywal --no-random")
                                (dolist (script '("xmonad-dark-wal.py" "nvim-wal.py" "nvim-wal-dark.py"))
                                  (shell-command-to-string (concat "python3 " pywal-scripts-directory "/" script)))
                                (shell-command-to-string "xmonad --restart")
                                (run-at-time "1 sec" nil 'spaceline-compile)))))))  ; Delay spaceline-compile


<a id="orgf42e10b"></a>

### Set-wallpaper

set system wallpaper

    (defun laluxx/set-wallpaper ()
      (interactive)
      (let* ((default-directory "~/xos/wallpapers/static")
             (image-files (directory-files-recursively default-directory "\\.\\(png\\|jpg\\|jpeg\\|webp\\)$")))
        (ivy-read "Choose wallpaper: "
                  image-files
                  :action (lambda (wallpaper)
                            (when (and (not (string-empty-p wallpaper))
                                       (file-exists-p wallpaper))
                              (let ((abs-wallpaper (expand-file-name wallpaper)))
                                (shell-command-to-string (concat "feh --bg-scale " abs-wallpaper))))))))


<a id="org205d3ec"></a>

## Doom-wal

doom the wallpaper

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


<a id="org359d5a3"></a>

## Doom-wal-light

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


<a id="org3dcc5f5"></a>

## set-wallpaper-to-match-doom-theme

will look into `~/xos/wallpaper/doom` for wallpapers called like doom-one.png or ef-summer.jpg

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


<a id="org3d91085"></a>

## Org

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


<a id="org785a65a"></a>

## List-hooks

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


<a id="org0dfb6cb"></a>

### Open-dir

    (defun open-dir (key desc dir)
      (map! :leader
            :desc desc
            key (lambda () (interactive) (dired dir))))


<a id="org6ca43bb"></a>

# Open-dir-keybind

open-dir defined in `FUNCTIONS`

    (open-dir "f P" "Open dotfiles directory" "~/Desktop/pulls/dotfiles/.config/doom")
    (open-dir "f t" "Open test directory" "~/Desktop/test")
    (open-dir "f x" "Open xos directory" "~/xos")
    (open-dir "f z" "Open dotfiles zsh directory" "~/Desktop/pulls/dotfiles/.config/zsh")
    (open-dir "f c" "Open ~/.config" "~/.config")


<a id="org68bf34a"></a>

# IVY


<a id="orgf911fd5"></a>

## IVY-POSFRAME

Available functions (positions) for &rsquo;ivy-posframe-display-functions-alist&rsquo;

-   ivy-posframe-display-at-frame-center
-   ivy-posframe-display-at-window-center
-   ivy-posframe-display-at-frame-bottom-left
-   ivy-posframe-display-at-window-bottom-left
-   ivy-posframe-display-at-frame-bottom-window-center
-   ivy-posframe-display-at-point
-   ivy-posframe-display-at-frame-top-center

`NOTE:` If the setting for &rsquo;ivy-posframe-display&rsquo; is set to &rsquo;nil&rsquo; (false), anything that is set to &rsquo;ivy-display-function-fallback&rsquo; will just default to their normal position in Doom Emacs (usually a bottom split).  However, if this is set to &rsquo;t&rsquo; (true), then the fallback position will be centered in the window.

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


<a id="orga73087c"></a>

## IVY KEYBINDINGS

By default, Doom Emacs does not use &rsquo;SPC v&rsquo;, so the format I use for these bindings is &rsquo;SPC v&rsquo; plus &rsquo;key&rsquo;.

    (map! :leader
          (:prefix ("v" . "Ivy")
           :desc "Ivy push view" "v p" #'ivy-push-view
           :desc "Ivy switch view" "v s" #'ivy-switch-view))


<a id="orgedebe54"></a>

# EVIL MODE


<a id="org7097b23"></a>

## INSERT

noob mode

    (after! evil
      (define-key evil-insert-state-map (kbd "C-v") 'yank)
      (define-key evil-insert-state-map (kbd "C-s") 'save-buffer)
      (define-key evil-insert-state-map (kbd "C-c") 'kill-ring-save)
      (define-key evil-insert-state-map (kbd "C-x") 'kill-region)
      (define-key evil-insert-state-map (kbd "C-z") 'undo)
      (define-key evil-insert-state-map (kbd "C-y") 'redo))


<a id="org51e0f53"></a>

# DIRED


<a id="orgd243841"></a>

## Keybinds

    (map! :leader
          (:prefix ("d" . "dired")
           :desc "Open dired" "d" #'dired
           :desc "Dired jump to current" "j" #'dired-jump)
           ;; :desc "Dired split jump" "J" #'dired-jump)
          (:after dired
           (:map dired-mode-map
            :desc "Peep-dired image previews" "d p" #'peep-dired ;; HALF WORKING
            :desc "Dired view file"           "d v" #'dired-view-file)))


<a id="org0bfe25e"></a>

## Condifuration

    (evil-define-key 'normal dired-mode-map
      (kbd "<escape>") 'delete-frame
      (kbd "M-RET") 'dired-display-file
      (kbd "h") 'dired-up-directory
      (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
      (kbd "m") 'dired-mark
      (kbd "t") 'dired-toggle-marks
      (kbd "u") 'dired-unmark
      (kbd "C") 'dired-do-copy
      (kbd "J") 'dired-goto-file
      (kbd "M") 'dired-do-chmod
      (kbd "O") 'dired-do-chown
      (kbd "P") 'dired-do-print
      (kbd "R") 'dired-do-rename
      (kbd "r") 'laluxx/dired-run-or-find
      (kbd "T") 'dired-do-touch
      (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
      (kbd "Z") 'dired-do-compress
      ;; (kbd "D") 'dired-do-delete
      (kbd "D") 'dired-create-directory
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


<a id="org91f0172"></a>

## Custom faces

    ;; (custom-set-faces
    ;;   '(dired-header ((t (:family "JetBrains Mono NF ExtraBold" :height 120))))
    ;;   '(dired-directory ((t (:family "JetBrains Mono NF ExtraBold" :height 120)))))


<a id="org44fc065"></a>

## Run

    (setq async-shell-command-buffer 'rename-buffer)
    
    (defun laluxx/dired-run-or-find ()
      "In Dired, run a script if it's a script, enter directory if it's a directory, or open the file otherwise."
      (interactive)
      (let ((file (dired-get-file-for-visit)))
        (cond
         ((file-directory-p file) (dired-find-file)) ; If it's a directory, recurse into it
         ((and (file-exists-p file) (file-executable-p file)) ; If it's an executable file, run it and also open it
          (find-file file)
          (async-shell-command (concat "./" file " > /dev/null 2>&1 &")))
         ((and (file-exists-p file) (string-match-p "\\.py\\'" file)) ; If it's a Python script, run it and also open it
          (find-file file)
          (async-shell-command (concat "python " file " > /dev/null 2>&1 &")))
         ((file-exists-p file) (find-file file)) ; If it's another type of file, just open it
         (t (message "No file on this line")))))


<a id="orgc7e3663"></a>

## Keybindings Within Dired With Peep-Dired-Mode Enabled

If peep-dired is enabled, you will get image previews as you go up/down with &rsquo;j&rsquo; and &rsquo;k&rsquo;

    (evil-define-key 'normal peep-dired-mode-map
      (kbd "j") 'peep-dired-next-file
      (kbd "k") 'peep-dired-prev-file)
    (add-hook 'peep-dired-hook 'evil-normalize-keymaps)


<a id="orgd2643b2"></a>

# SPACELINE


<a id="org574020c"></a>

## Conf

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


<a id="orgcb0b56c"></a>

## toggle-modeline

    (defvar my-modeline-state 'spaceline)
    
    (defun laluxx/toggle-modeline-local ()
      "Toggle between spaceline and no modeline for the current buffer."
      (interactive)
      (if (eq my-modeline-state 'spaceline)
          (progn
            (setq my-modeline-state 'none)
            (hide-mode-line-mode 1))
        (progn
          (hide-mode-line-mode -1)
          (setq my-modeline-state 'spaceline)
          (spaceline-spacemacs-theme))))
    
    (defun laluxx/toggle-modeline-global ()
      "Toggle between spaceline and no modeline globally."
      (interactive)
      (if (eq my-modeline-state 'spaceline)
          (progn
            (setq my-modeline-state 'none)
            (global-hide-mode-line-mode 1))
        (progn
          (global-hide-mode-line-mode -1)
          (setq my-modeline-state 'spaceline)
          (spaceline-spacemacs-theme))))
    
    (map! :leader
          (:prefix ("t" . "toggle")
           "m" #'laluxx/toggle-modeline-local
           "M" #'laluxx/toggle-modeline-global))


<a id="orgf322728"></a>

# RAINBOW MODE

turned on all the time, regardless of the mode.
The following creates a global minor mode for rainbow-mode and enables it (exception: org-agenda-mode since rainbow-mode destroys all highlighting in org-agenda).

    (define-globalized-minor-mode global-rainbow-mode rainbow-mode
      (lambda ()
        (when (not (memq major-mode
                    (list 'org-agenda-mode)))
         (rainbow-mode 1))))
    (global-rainbow-mode 1 )


<a id="orgc1a991e"></a>

# Emacs-run


<a id="org2472ae6"></a>

## Run-launcher

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


<a id="orga0d4a1d"></a>

## wal-set


<a id="orga1fcb73"></a>

### Default

    (defun emacs-run-wal-set ()
      "Create and select a frame called emacs-run-launcher which consists only of a minibuffer and has specific dimensions. Runs app-launcher-run-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
      (interactive)
      (with-selected-frame
        (make-frame '((name . "emacs-run-wal-set")
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
                        (laluxx/wal-set)
                        (delete-frame))))


<a id="orga12c97d"></a>

### Solid

    (defun emacs-run-wal-set-solid ()
      "Create and select a frame called emacs-run-launcher which consists only of a minibuffer and has specific dimensions. Runs app-launcher-run-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
      (interactive)
      (with-selected-frame
        (make-frame '((name . "emacs-run-wal-set-solid")
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
                        (laluxx/wal-set-solid)
                        (delete-frame))))


<a id="org4d893b8"></a>

### favourite

    (defun emacs-run-wal-set-favourite ()
      "Create and select a frame called emacs-run-launcher which consists only of a minibuffer and has specific dimensions. Runs app-launcher-run-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
      (interactive)
      (with-selected-frame
        (make-frame '((name . "emacs-run-wal-set-favourite")
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
                        (laluxx/wal-set-favourite)
                        (delete-frame))))


<a id="org891cf96"></a>

### Set-wallpaper

    (defun emacs-run-set-wallpaper ()
      "Create and select a frame called emacs-run-launcher which consists only of a minibuffer and has specific dimensions. Runs app-launcher-run-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
      (interactive)
      (with-selected-frame
        (make-frame '((name . "emacs-run-set-wallpaper")
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
                        (laluxx/set-wallpaper)
                        (delete-frame))))


<a id="orgb67ae1a"></a>

## M-X

    (defun emacs-run-M-x ()
      "Create a new frame and prompt for an M-x command in it."
      (interactive)
      (with-selected-frame
          (make-frame '((name . "emacs-run-M-x")
                        (minibuffer . only)
                        (fullscreen . 0)
                        (undecorated . t)
                        (internal-border-width . 10)
                        (width . 80)
                        (height . 11)))
        (unwind-protect
            (call-interactively 'execute-extended-command)
          (delete-frame))))


<a id="org351d5bd"></a>

## Info

Open info inside xmonad  DONE:

-   remember last manual manual [x]
-   Toggle [x]

    (defvar emacs-run-info-frame nil)
    
    (defun emacs-run-info ()
      "Create a new frame and run 'info' in it."
      (interactive)
      (if (and emacs-run-info-frame (frame-live-p emacs-run-info-frame))
          ;; If the frame exists, delete it.
          (progn
            (delete-frame emacs-run-info-frame)
            (setq emacs-run-info-frame nil))
        ;; Else, create a new frame.
        (let* ((new-frame (make-frame '((name . "emacs-run-info")
                                        (minibuffer . t)
                                        (fullscreen . 0)
                                        (undecorated . t)
                                        (internal-border-width . 10)
                                        (width . 80)
                                        (height . 11)))))
          (setq emacs-run-info-frame new-frame)
          (select-frame-set-input-focus new-frame)
          (with-selected-window (frame-selected-window new-frame)
            (switch-to-buffer (save-window-excursion
                                (info)
                                (current-buffer)))
            (delete-other-windows)
            (define-key Info-mode-map (kbd "<escape>") 'delete-frame)))))


<a id="orgd187c0f"></a>

## Which-key

    ;; (defun emacs-run-which-key ()
    ;;   "Create a new frame and prompt for a which-key command in it."
    ;;   (interactive)
    ;;   (let ((new-frame (make-frame '((name . "emacs-run-which-key")
    ;;                                  (minibuffer . only)
    ;;                                  (fullscreen . 0)
    ;;                                  (undecorated . t)
    ;;                                  (internal-border-width . 10)
    ;;                                  (width . 80)
    ;;                                  (height . 11)))))
    ;;     (with-selected-frame new-frame
    ;;       (which-key-mode 1)
    ;;       (call-interactively 'which-key-show-top-level))))


<a id="orga3c2f3c"></a>

## Dired

TODO

-   esc don&rsquo;t close the frame [x]
-   hide modeline [x]

    (defun hide-mode-line-in-dired-frame (frame)
      "Hide the mode line in the 'emacs-run-dired' frame."
      (when (string-equal (frame-parameter frame 'name) "emacs-run-dired")
        (with-selected-frame frame
          (setq-default mode-line-format nil))))
    
    (add-hook 'after-make-frame-functions 'hide-mode-line-in-dired-frame)
    
    (defun emacs-run-dired ()
      "Create a new frame and open dired in it."
      (interactive)
      (let* ((original-frame (selected-frame))
             (new-frame (make-frame '((name . "emacs-run-dired")
                                      (width . 80)
                                      (height . 24)
                                      (minibuffer . t)
                                      (undecorated . t)
                                      (internal-border-width . 10)
                                      (fullscreen . 0)))))
        (select-frame-set-input-focus new-frame)
        (with-selected-window (frame-selected-window new-frame)
          (dired "~"))  ;; opens dired in your home directory, change "~" to any directory you prefer
        (define-key dired-mode-map (kbd "<escape>") 'delete-frame)
        (select-frame-set-input-focus original-frame)))


<a id="org64529fb"></a>

## Clone-client-frame

    (defun hide-mode-line-in-frame (frame)
      "Hide the mode line in the specified frames."
      (when (string-match-p "^emacs-run-clone-client-frame" (frame-parameter frame 'name))
        (with-selected-frame frame
          (setq mode-line-format nil))))
    
    (add-hook 'after-make-frame-functions 'hide-mode-line-in-frame)
    
    (defun emacs-run-clone-client-frame ()
      "Create a new frame and activate which-key-mode in it."
      (interactive)
      (let ((new-frame (make-frame '((name . "emacs-run-clone-client-frame")
                                     (minibuffer . nil)
                                     (fullscreen . 0)
                                     (undecorated . t)
                                     (internal-border-width . 10)
                                     (width . 80)
                                     (height . 11)))))
        (with-selected-frame new-frame
          (which-key-mode 1)
          (minibuffer-keyboard-quit))))
    
    (defun emacs-run-clone-client-frame-bottom ()
      "Create a new frame and activate which-key-mode in it."
      (interactive)
      (let ((new-frame (make-frame '((name . "emacs-run-clone-client-frame-bottom")
                                     (minibuffer . nil)
                                     (fullscreen . 0)
                                     (undecorated . t)
                                     (internal-border-width . 10)
                                     (width . 80)
                                     (height . 11)))))
        (with-selected-frame new-frame
          (which-key-mode 1)
          (minibuffer-keyboard-quit))))


<a id="orga6b7169"></a>

### Dmenu

    (defun emacs-run-dmenu ()
      "Create a new frame and run dmenu in it."
      (interactive)
      (with-selected-frame
          (make-frame '((name . "emacs-run-dmenu")
                        (minibuffer . only)
                        (fullscreen . 0)
                        (undecorated . t)
                        (internal-border-width . 10)
                        (width . 80)
                        (height . 11)))
        (unwind-protect
            (call-interactively 'dmenu)
          (delete-frame))))


<a id="org0194b7d"></a>

# Config


<a id="org28d936c"></a>

## Evil

    (after! evil
      (map! :after evil
            :map evil-insert-state-map
            "C-h" #'evil-backward-char
            "C-j" #'evil-next-line
            "C-k" #'evil-previous-line
            "C-l" #'evil-forward-char))


<a id="org41d0ab8"></a>

## org-auto-tangle

`org-auto-tangle` allows you to add the option `#+auto_tangle: t` in your Org file so that it automatically tangles when you save the document.

    (use-package! org-auto-tangle
      :defer t
      :hook (org-mode . org-auto-tangle-mode)
      :config
      (setq org-auto-tangle-default t))
    
    (defun laluxx/insert-auto-tangle-tag ()
      "Insert auto-tangle tag in a literate config."
      (interactive)
      (evil-org-open-below 1)
      (insert "#+auto_tangle: t ")
      (evil-force-normal-state))
    
    (map! :leader
          :desc "Insert auto_tangle tag" "i a" #'laluxx/insert-auto-tangle-tag)


<a id="org57f3c9e"></a>

## Centaur-tabs

    (after! centaur-tabs
      (setq centaur-tabs-style "rounded"
            centaur-tabs-height 32
            centaur-tabs-set-icons t
            centaur-tabs-set-bar 'under
            x-underline-at-descent-line t
            centaur-tabs-set-modified-marker t
            centaur-tabs-show-navigation-buttons t
            centaur-tabs-show-new-tab-button t
            centaur-tabs-left-edge-margin nil
            centaur-tabs-cycle-scope 'tabs)
      (centaur-tabs-mode t)
      (centaur-tabs-headline-match)
      (setq centaur-tabs-adjust-buffer-order t))
    
    
    
    (defun my/centaur-tabs-mode-condition ()
      (if (or (> (count-windows) 1)
              (derived-mode-p 'dashboard-mode 'vterm-mode 'dired-mode))
          (centaur-tabs-local-mode)  ;; disable if more than one window or in one of the listed modes
        (centaur-tabs-local-mode -1)))  ;; enable otherwise
    
    
    ;; Run the function after every buffer list update
    (add-hook 'buffer-list-update-hook 'my/centaur-tabs-mode-condition)


<a id="orgea9faf7"></a>

## Vterm

    ;; (add-hook 'vterm-mode-hook
    ;;           (lambda ()
    ;;             (define-key vterm-mode-map (kbd "C-j") 'other-window)
    ;;             (define-key vterm-mode-map (kbd "C-k")
    ;;               (lambda ()
    ;;                 (interactive)
    ;;                 (other-window -1)))
    ;;             (define-key vterm-mode-map (kbd "C-h") 'neotree-or-enlarge-window-left)
    ;;             (define-key vterm-mode-map (kbd "C-l") 're-builder-or-enlarge-window-right)
    ;;             (define-key vterm-mode-map (kbd "C-M-j") 'rotate-window)
    ;;             (define-key vterm-mode-map (kbd "C-M-k")
    ;;               (lambda ()
    ;;                 (interactive)
    ;;                 (dotimes (_ (- (length (window-list)) 1))
    ;;                   (rotate-window))))
    ;;             (evil-define-key 'normal vterm-mode-map (kbd "q") 'delete-window)))
    
    (add-hook 'vterm-mode-hook
              (lambda ()
                (evil-define-key 'insert vterm-mode-map (kbd "C-j") 'other-window)
                (evil-define-key 'insert vterm-mode-map (kbd "C-k")
                  (lambda ()
                    (interactive)
                    (other-window -1)))
                (evil-define-key 'insert vterm-mode-map (kbd "C-h") 'neotree-or-enlarge-window-left)
                (evil-define-key 'insert vterm-mode-map (kbd "C-l") 're-builder-or-enlarge-window-right)
                (evil-define-key 'insert vterm-mode-map (kbd "C-M-j") 'rotate-window)
                (evil-define-key 'insert vterm-mode-map (kbd "C-M-k")
                  (lambda ()
                    (interactive)
                    (dotimes (_ (- (length (window-list)) 1))
                      (rotate-window))))
                (evil-define-key 'normal vterm-mode-map (kbd "q") 'delete-window)))


<a id="org1d04337"></a>

## Magit

    ;; (with-eval-after-load 'magit
    ;;   (define-key magit-mode-map (kbd "C-j") #'other-window)
    ;;   (define-key magit-mode-map (kbd "C-k") (lambda () (interactive) (other-window -1)))
    ;;   (define-key magit-mode-map (kbd "M-j") #'magit-section-forward)
    ;;   (define-key magit-mode-map (kbd "M-k") #'magit-section-backward))
    
    (after! magit
      (define-key magit-mode-map (kbd "C-j") #'other-window)
      (define-key magit-mode-map (kbd "C-k") (lambda () (interactive) (other-window -1)))
      (define-key magit-mode-map (kbd "M-j") #'magit-section-forward)
      (define-key magit-mode-map (kbd "M-k") #'magit-section-backward))


<a id="org28ba692"></a>

## Neotree

    (after! neotree
      (map! :map neotree-mode-map
            :n "C-j" #'my-switch-buffer-forward-or-other-window
            :n "C-k" #'my-switch-buffer-backward-or-other-window
            :n "C-h" #'neotree-hide))


<a id="org8c260d8"></a>

## Ewal


<a id="orgf846d86"></a>

### Default

    (use-package! ewal
      :init
      (setq ewal-use-built-in-always-p nil
            ewal-use-built-in-on-failure-p t
            ewal-built-in-palette "sexy-material"))


<a id="org6dc7bda"></a>

### Ewal-Doom-Theme

this will set the theme

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


<a id="org2e38699"></a>

# Enable

    ;; (desktop-save-mode 1)


<a id="org6e71fc5"></a>

# Images

    ;; (global-set-key [double-mouse-1] 'my-open-image-at-point-in-new-buffer)
    
    ;; (defun my-open-image-at-point-in-new-buffer (event)
    ;;   "Open the image at point in a new buffer."
    ;;   (interactive "e")
    ;;   (let* ((window (posn-window (event-end event)))
    ;;          (buffer (window-buffer window))
    ;;          (pos (posn-point (event-end event)))
    ;;          (file (with-current-buffer buffer
    ;;                  (get-text-property pos 'display))))
    ;;     (when file
    ;;       (let ((buffer (generate-new-buffer "image-buffer")))
    ;;         (switch-to-buffer buffer)
    ;;         (insert-file-contents (car file))
    ;;         (image-mode)))))
    
    ;; (global-set-key [double-mouse-1] 'my-open-image-at-point-in-new-buffer)
    
    
    (require 'ffap)
    
    (defun doom/open-file-at-point-in-new-buffer (event)
      "Open the file under the mouse cursor in a new buffer."
      (interactive "e")
      (let* ((window (posn-window (event-end event)))
             (buffer (window-buffer window))
             (pos (posn-point (event-end event)))
             (file (with-current-buffer buffer
                     (ffap-file-at-point))))
        (when file
          (let ((buf (find-file-noselect file)))
            (with-current-buffer buf
              (when (member (file-name-extension file)
                            '("jpg" "jpeg" "png" "gif" "bmp"))
                (image-mode)))
            (switch-to-buffer-other-window buf)))))
    
    (global-set-key [double-mouse-1] #'doom/open-file-at-point-in-new-buffer)

