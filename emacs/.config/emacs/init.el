
;; Basic settings
; font
(set-face-attribute 'default nil :height 140)
(defvar monitor-info "eDP-1" "name of currently focused monitor")
(defun update-monitor-info () 
(setq monitor-info
  (string-trim
   (shell-command-to-string
    "hyprctl monitors | awk '/focused: yes/ {print monitor} {if ($1 == \"Monitor\") monitor = $2}'"))))
(defun adjust-font-size ()
  (update-monitor-info)
(cond ((string= monitor-info "HDMI-A-1")(set-face-attribute 'default nil :height 210))
      ((string= monitor-info "eDP-1")(set-face-attribute 'default nil :height 140))))
(add-hook 'focus-in-hook 'adjust-font-size)
; backups
(setq make-backup-files nil)
(setq backup-inhibited nil) ; Not sure if needed, given `make-backup-files'
(setq create-lockfiles nil)
; remove emacs custom file
(setq custom-file (make-temp-file "emacs-custom-"))

;; Set up use-package
(require 'use-package)
(setq use-package-always-ensure t)
; add repositories
(setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("GNU ELPA"     . 10)
        ("MELPA"        . 5)
        ("MELPA Stable" . 0)))


;; small packages
(use-package monkeytype)

; rainbow mode
(use-package rainbow-mode
  :hook org-mode prog-mode)
;; open with
(use-package openwith)
(setq openwith-associations '(("\\.pdf\\'" "mupdf" (file))))
(openwith-mode)
; set theme
(use-package ef-themes)
(setq custom-safe-themes t)
; dark themes
(defun change-theme ()
  (if theme-type
      (progn (load-theme 'ef-deuteranopia-light))
    (progn (load-theme 'ef-dark))))
;;Change opacity

(defun change-opacity (opacity)
  (dolist (frame (frame-list))
    (set-frame-parameter frame 'alpha (list opacity 100)))
  (setq default-frame-alist '(alpha-background . opacity)))
;;(change-opacity 60)

;;
(add-to-list 'default-frame-alist '(alpha-background . 75))
(load-theme 'ef-dark)
; light themes
;;(add-to-list 'default-frame-alist '(alpha-background . 65))
;;(load-theme 'ef-deuteranopia-light)

; highlight todo
(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
	 (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
	hl-todo-keyword-faces
	`(("TODO"       warning bold)
	  ("FIXME"      error bold)
	  ("HACK"       font-lock-constant-face bold)
	  ("REVIEW"     font-lock-keyword-face bold)
	  ("NOTE"       success bold)
	  ("DEPRECATED" font-lock-doc-face bold))))
;; terminal and multiterminal
;vterm
(use-package vterm
  :ensure t)
; multi-term
(use-package multi-vterm
  :ensure t)
;; More information on inputted commands
(use-package which-key
  :ensure t
  :hook (after-init . which-key-mode)
  :config (setq which-key-separator "  "
		which-key-prefix-prefix "... "
		which-key-max-display-columns 3
		which-key-idle-delay 1.5
		which-key-idle-secondary-delay 0.25
		which-key-add-column-padding 1
		which-key-max-description-length 40))

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode)
  :config (setq vertico-scroll-margin 0
		vertico-count 5
		vertico-resize t
		vertico-cycle t
		vertico-mode 1))

(use-package marginalia
  :ensure t
  :defer 1
  :config (setq marginalia-max-relative-age 0
		marginalia-mode 1))

(use-package consult
  :ensure t)

;; specific filetype support
; pdf
(use-package pdf-tools
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  )
; tex
(use-package outshine
  :config
  (setq LaTeX-section-list
	'(("part" 0)
	  ("chapter" 1)
	  ("section" 2)
	  ("subsection" 3)
	  ("subsubsection" 4)
	  ("paragraph" 5)
	  ("subparagraph" 6)
	  ("begin" 7)))
  (add-hook 'LaTeX-mode-hook
	    #'(lambda ()
		(outshine-mode 1)
		(setq outline-level #'LaTeX-outline-level)
		(setq outline-regexp (LaTeX-outline-regexp t))
		(setq outline-heading-alist
		      (mapcar (lambda (x)
				(cons (concat "\\" (nth 0 x)) (nth 1 x)))
			      LaTeX-section-list)))))
(use-package auctex
  :ensure t
  :defer t
  :hook
  (LaTeX-mode . turn-on-prettify-symbols-mode)
  )

;; keybindings
;; C-w to delete previous word 
(keymap-global-set "C-D" 'backward-kill-word)

;; zathura
;;(add-to-list 'load-path "~/.config/emacs/packages/")
;;(require 'zathura-sync-theme)
;;(zathura-sync-theme-mode 1)


