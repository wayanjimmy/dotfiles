;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Wayanjimmy"
      user-mail-address "jimmyeatcrab@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "JetBrains Mono" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq
 org_notes "~/JimboyLabs/resources/roam/"
 org-directory org_notes
 org-roam-directory org_notes
 org-download-image-dir (concat org_notes "/images"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(use-package! wakatime-mode
  :hook (after-init . global-wakatime-mode))

(use-package org-journal
  :bind
  ("C-c n j" . org-journal-new-entry)
  ("C-c n t" . org-journal-today)
  :custom
  (org-journal-dir org_notes)
  (org-journal-date-prefix "#+TITLE: ")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-date-format "%A, %d %B %Y")
  :config
  (defun org-journal-today()
    (interactive)
    (org-journal-new-entry t)))

(setq org-journal-enable-agenda-integration t)

(use-package org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

(use-package org-roam-server
  :ensure t)

(setq geiser-default-implementation 'racket)

(setq org-babel-clojure-backend 'cider)

(setq exec-path (append exec-path '("/var/folders/f1/3qjvc5895319405rbmrbcrd00000gn/T/fnm-shell-6566882/bin/node")))

(setq org-roam-index-file "index.org")

(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory org_notes))

(setq org-pomodoro-length 55
      org-pomodoro-short-break-length 15
      org-pomodoro-play-sounds t
      org-pomodoro-short-break-sound-p t
      org-pomodoro-long-break-sound-p t
      org-pomodoro-short-break-sound (expand-file-name "/System/Library/Sounds/Blow.aiff")
      org-pomodoro-long-break-sound (expand-file-name "/System/Library/Sounds/Blow.aiff")
      org-pomodoro-finished-sound (expand-file-name "/System/Library/Sounds/Blow.aiff")
      org-pomodoro-start-sound (expand-file-name "/System/Library/Sounds/Blow.aiff"))
(put 'erase-buffer 'disabled nil)

(use-package! org-pomodoro
  :ensure t)
(setq org-pomodoro-finished-sound-args "-volume 1.0")
(setq org-pomodoro-long-break-sound-args "-volume 1.0")
(setq org-pomodoro-short-break-sound-args "-volume 1.0")

(custom-set-variables '(wakatime-api-key "051aaab1-d2eb-4366-b7f6-fccf41e1ef67"))

(use-package org-randomnote
  :ensure t
  :bind ("C-c r" . org-randomnote))

(load-library "find-lisp")
(setq org-randomnote-candidates
      (find-lisp-find-files org_notes "\.org$"))

(use-package! md-roam ; load immediately, before org-roam
  :config
  (setq md-roam-file-extension-single "md"))

(add-to-list 'load-path "~/Downloads/beancount-mode")
(require 'beancount)
(add-to-list 'auto-mode-alist '("\\.bean\\'" . beancount-mode))
