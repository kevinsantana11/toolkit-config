;; Package manager setup
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(defun package--save-selected-packages (&rest opt) nil) ;; Improve load time by saving selected packages
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


;; THEMING setup (to look sort of like the Github theme provided for VS Code
(define-minor-mode ksantana-modus-theme
  "Kevin S. style theme"
  :init-value nil
  :global t
  (if ksantana-modus-theme
      (setq modus-operandi-tinted-palette-overrides
	    '((yellow-intense "#eb9951")
	      (red-intense "#df6d66")
	      (builtin yellow-intense)
	      (constant blue)
	      (docstring cyan-faint)
	      (docmarkup magenta-faint)
	      (fnname magenta-cooler)
	      (keyword red-intense)
	      (preprocessor red-cooler)
	      (string cyan-faint)
	      (type yellow-intense)
	      (variable green-faint)))
      (setq modus-operandi-tinted-palette-overrides nil)))
(use-package modus-themes
  :config
  (ksantana-modus-theme)
  (load-theme 'modus-operandi-tinted t t)
  (enable-theme 'modus-operandi-tinted))

;; General EMACS Configuration
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(global-display-line-numbers-mode t)
(column-number-mode)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(setq frame-inhibit-implied-resize t)
(dolist
  (mode '(org-mode-hook vterm-mode-hook))
  (add-hook
     mode
     (lambda () (display-line-numbers-mode 0))))


;; Define dependencies and configure them
;; Evil related stuff
(use-package evil
  :init
  (setq evil-want-integration t
	evil-want-keybinding nil
	evil-want-minibuffer t)
  :config
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Treemacs related stuff
(use-package treemacs)
(use-package treemacs-evil
  :after (treemacs evil))
(use-package treemacs-projectile
  :after (treemacs projectile))
(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once))


;; LSP Configuration
(use-package lsp-mode
  :config
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (python-mode . lsp)
  (lsp-mode . lsp-enable-which-key-integration)
  :commands lsp)

(use-package lsp-pyright
  :hook
  (python-mode . (lambda ()
		   (require 'lsp-pyright)
		   (lsp))))
(use-package lsp-ui)

;; Other Dependencies
(use-package magit)
(use-package consult)
(use-package vterm)
(use-package restart-emacs)


(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package which-key
  :config
  (which-key-mode))

(use-package company
  :config
  (company-mode)
  (add-hook 'after-init-hook 'global-company-mode))

(use-package helpful
    :config
    (global-set-key (kbd "C-h f") #'helpful-callable)
    (global-set-key (kbd "C-h v") #'helpful-variable)
    (global-set-key (kbd "C-h k") #'helpful-key)
    (global-set-key (kbd "C-h x") #'helpful-command))

