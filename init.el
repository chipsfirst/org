;;THEMES AND MODELINE
(doom-themes-visual-bell-config)
(use-package doom-themes
  :init (load-theme 'doom-dracula t))
(require 'doom-modeline)
(doom-modeline-mode 1)
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))
(setq inhibit-startup-message t)

;;HIDE MENUS AND TOOLBARS
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;;LOAD
(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; Set up the visible bell
(setq visible-bell t)
(column-number-mode)
(global-display-line-numbers-mode t)
;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;;AUTO UPDATE
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;SWIPER AND NAVIGATIONS
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;;RAINBOW DELIMITERS ( ) 
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7a7b1d475b42c1a0b61f3b1d1225dd249ffa1abb1b7f726aec59ac7ca3bf4dae" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" default))
 '(doom-modeline-buffer-modification-icon nil)
 '(doom-modeline-buffer-state-icon nil)
 '(doom-modeline-hud t)
 '(org-agenda-files
   '("~/.emacs.d/dev/work.org" "~/.emacs.d/dev/org/home.org" "~/.emacs.d/dev/org/test.org"))
 '(package-selected-packages
   '(all-the-icons-completion logview mu4e-views pacmacs elfeed nyan-mode eradio emmet-mode code-cells org-mime all-the-icons-dired eshell-git-prompt forge org-bullets evil-magit magit counsel-projectile term-cmd flycheck doom-modeline vscode-icon treemacs-all-the-icons smart-mode-line spaceline-all-the-icons jetbrains-darcula-theme projectile org-alert minions lsp-ivy lsp-treemacs lsp-ui lsp-mode auto-package-update cl-libify org-dashboard dashboard-ls dashboard fireplace hydra nav anaconda-mode ipython-shell-send jedi unicode-fonts elpy live-py-mode helpful cmake-project tracking telega counsel-world-clock diminish emojify alert which-key ivy-rich rainbow-delimiters use-package swiper-helm evil-collection doom-themes counsel command-log-mode))
 '(safe-local-variable-values '((projectile-project-run-cmd . "eshell start"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package swiper
  :ensure t)

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;;FRAME AND VISIBLE
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
  (add-to-list 'default-frame-alist '(alpha . (90 . 90)))
  (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
  (add-to-list 'default-frame-alist '(fullscreen . maximized))

;;EMOJI
(use-package emojify
  :hook (erc-mode . emojify-mode)
  :commands emojify-mode)

;;TIMES
(setq display-time-format "%l:%M %p %b %y"
      display-time-default-load-average nil)

(use-package diminish)

;;RED LINE
(use-package alert
  :commands alert
  :config
  (setq alert-default-style 'notifications))

;;DISPLAY TIME
(setq display-time-mode 1)


(dolist (mode '(org-mode-hook
                term-mode-hook))
                shell-mode-hook
                eshell-mode-hook
		(add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq frame-title-format "%b")

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;;HELP AND HISTORY
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;;ICONS
(use-package all-the-icons)

;;CODE AND UNICODE
(set-coding-system-priority 'utf-8 'utf-16 'windows-1251)

;;NAMES FOR BUFFERS
(setq frame-title-format "GNU Emacs: %b")

(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))
;;FONTS AND SPACEline
(add-to-list 'default-frame-alist '(font . "JetBrains Mono 11"))
(add-to-list 'default-frame-alist '(line-spacing . 0.2))

;;GLOBAL ESC
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))

(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

(setq org-hide-emphasis-markers t)
(add-hook 'org-mode-hook 'visual-line-mode)

(require 'recentf)

(recentf-mode 1)


(use-package command-log-mode
  :commands command-log-mode)

(use-package all-the-icons)

 (defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy
  :after lsp)

(use-package minions
  :hook (doom-modeline-mode . minions-mode))

(use-package alert
  :commands alert
  :config
  (setq alert-default-style 'notifications))

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

(require 'dashboard)
(dashboard-setup-startup-hook)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)
(setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
(transient-mark-mode 1)
(setq dashboard-startup-banner "~/.emacs.d/elpa/dashboard-20220208.915/banners/logo.png")
(add-hook 'after-init-hook 'global-company-mode)
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        ))
(setq dashboard-navigator-buttons
      `(;; line1
        ((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
         "Homepage"
         "Browse homepage"
         (lambda (&rest _) (browse-url "https://github.com/chipsfirst"))))))

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(when (not (file-directory-p "~/.backup"))
  (make-directory "~/.backup"))
(if (file-directory-p "~/.backup")
    (setq backup-directory-alist '(("." . "~/.backup"))))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

;;(use-package forge)
;; Org Mode Configuration ------------------------------------------------------

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
   (set-face-attribute (car face) nil :font "Jetbrains Mono" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
 ;;(set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (efs/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

;;ESHEll
(use-package eshell-git-prompt)
:config
(eshell-git-prompt-use-theme 'powerline)

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

;;ICONS FOR DIRED
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))


(setq mode-line-format
      (list
       '(:eval (list (nyan-create)))
       ))

(global-set-key (kbd "C-x w") 'elfeed)

(setq elfeed-feeds
      '(
        ;; programming
	("https://www.mirf.ru/feed/" mirf)
	("https://thecode.media/feed/" thecode.media)
	("https://interface31.ru/tech_it/atom.xml" admins_note)
	("https://proglib.io/feed" proglib)
))


(setq-default elfeed-search-title-max-width 100)
(setq-default elfeed-search-title-min-width 100)
