(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(defun package--save-selected-packages (&rest opt) nil)

(define-minor-mode ksantana-modus-theme
  "Kevin S. style theme"
  :init-value nil
  :global t
  (if ksantana-modus-theme
      (setq modus-vivendi-tinted-palette-overrides
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
      (setq modus-vivendi-tinted-palette-overrides nil)))

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;General Configuration
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(global-display-line-numbers-mode t)
(column-number-mode)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(setq frame-inhibit-implied-resize t)

;; Installed Packages/configure Them
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

(use-package modus-themes
  :config
  (ksantana-modus-theme)
  (load-theme 'modus-vivendi-tinted t t)
  (enable-theme 'modus-vivendi-tinted))


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

(use-package magit)

(use-package consult)

(use-package vterm)

(use-package restart-emacs)

(use-package helpful
    :config
    (global-set-key (kbd "C-h f") #'helpful-callable)
    (global-set-key (kbd "C-h v") #'helpful-variable)
    (global-set-key (kbd "C-h k") #'helpful-key)
    (global-set-key (kbd "C-h x") #'helpful-command))


(use-package lsp-mode
  :config
  (setq lsp-keymap-prefix "C-C l")
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

(dolist
  (mode '(org-mode-hook vterm-mode-hook))
  (add-hook
     mode
     (lambda () (display-line-numbers-mode 0))))
