(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(setq warning-minimum-level :warning)

;; add MELPA package server
(require 'package)

(add-to-list 'package-archives '("gnu"  . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; prevent creation of backup files. I'd rather manually handle that.
(setq make-backup-files nil)

;; freaking don't ask me to type out "yes" and "no"
(defalias 'yes-or-no-p 'y-or-n-p)
(setq use-file-dialog nil)
(delete-selection-mode 1)

;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; disable color crap that pukes up everywhere
(setq-default global-font-lock-mode nil)

;; disable backup
(setq backup-inhibited t)

;; disable auto save
(setq auto-save-default nil)

;; disable ring bell
(setq ring-bell-function 'ignore)

;; disable dialog box
(setq use-dialog-box nil)

;; set show paren mode on
(show-paren-mode 1)

;; ido
(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

;; Prettify
(global-prettify-symbols-mode 1)

;; set tab size to 4
(setq default-tab-width 4)
(setq-default c-basic-offset 4)

(add-to-list 'default-frame-alist '(width  . 180))
(add-to-list 'default-frame-alist '(height . 70))

(setq vc-follow-symlinks t)

;; ---------- ;;
;;  PACKAGES  ;;
;; ---------- ;;

;; Theme
(use-package rubrication-theme
  :load-path "@rubricationThemePath@"
  :config
  (load-theme 'rubrication t))

;; Nlinum
(use-package nlinum
  :config
  (add-hook 'prog-mode-hook 'nlinum-mode)
  (setq nlinum-format "%4d "))

;; Auto completion with Company
(use-package company 
  :init
  (global-company-mode t)
  :config
  (setq company-idle-delay 0.2))

;; Flycheck
(use-package flycheck)

;; Advanced minibuffer completion
(use-package counsel
  :config
  ;; Simple minibuffer completion M-x
  (use-package smex
    :init (smex-initialize))
  (use-package flx)
  (setq ivy-use-virtual-buffers t)
  ;; intentional space before end of string
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy))))

;; Magit
(use-package magit
  :custom
  (magit-git-executable "/etc/profiles/per-user/carlo/bin/git"))

;; God mode
(use-package god-mode
  :config
  (require 'god-mode-isearch)
  (define-key isearch-mode-map (kbd "<escape>") 'god-mode-isearch-activate)
  (define-key god-mode-isearch-map (kbd "<escape>") 'god-mode-isearch-disable)
  (define-key god-local-mode-map (kbd ".") 'repeat)
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  (defun god-mode-cursor ()
    (if (or god-local-mode buffer-read-only)
        (progn
          (message "Entering GOD mode...")
          (blink-cursor-mode 0)
          (set-cursor-color "darkred"))
        (progn
          (message "Exiting GOD mode...")
          (blink-cursor-mode 1)
          (set-cursor-color "#000000"))))
  (add-hook 'god-mode-enabled-hook 'god-mode-cursor)
  (add-hook 'god-mode-disabled-hook 'god-mode-cursor))

;; Dired Sidebar
(use-package dired-sidebar
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (defun sidebar-toggle ()
    "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
    (interactive)
    (ibuffer-sidebar-toggle-sidebar)
    (dired-sidebar-toggle-sidebar))

  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'ascii))

;; Ibuffer Sidebar
(use-package ibuffer-sidebar
  :commands (ibuffer-sidebar-toggle-sidebar))

(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (ibuffer-sidebar-toggle-sidebar)
  (dired-sidebar-toggle-sidebar))

;; Projectile
(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-x C-p") 'projectile-command-map)
  (projectile-mode 1))

;; Dashboard
(use-package dashboard
  :init
  (progn
    (setq dashboard-items
      '((projects . 5)
        (recents . 5))))
  :config
  (dashboard-setup-startup-hook))

;; LSP
(use-package lsp-mode
  :commands lsp)

;; Nix
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package nixpkgs-fmt
  :init
  (add-hook 'nix-mode-hook 'nixpkgs-fmt-on-save-mode))

;; ------------------------- ;;
;;    CUSTOM KEYBINDINGS     ;;
;; ------------------------- ;;

(defun goto-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-at-point "~/dots/modules/home/emacs/emacs.el"))

(fset 'duplicate-line
    [?\C-a ?\C-  ?\C-n ?\M-w ?\C-y])

(windmove-default-keybindings 'meta)

(global-set-key (kbd "M-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-S-<down>") 'shrink-window)
(global-set-key (kbd "M-S-<up>") 'enlarge-window)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key (kbd "C-x ;") 'comment-region)
(global-set-key (kbd "C-x C-1") 'delete-other-windows)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)
(global-set-key (kbd "C-x C-0") 'delete-window)
(global-set-key (kbd "C-x C-o") 'other-window)
(global-set-key (kbd "C-q") 'keyboard-quit)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-x C-d") 'duplicate-line)
(global-set-key (kbd "C->") 'end-of-buffer)
(global-set-key (kbd "C-<") 'beginning-of-buffer)
(global-set-key (kbd "C-c C-d") 'dired)
(global-set-key (kbd "C-c C-i") 'goto-init-file)
(global-set-key [(control -)] 'undo)
(global-set-key (kbd "A-<up>") 'backward-paragraph)
(global-set-key (kbd "A-<down>") 'forward-paragraph)
(global-set-key (kbd "A-<right>") 'forward-word)
(global-set-key (kbd "A-<left>") 'backward-word)

(global-set-key (kbd "M-x") #'counsel-M-x)
(global-set-key (kbd "C-o") #'counsel-find-file)
(global-set-key (kbd "M-s") 'magit-status)
(global-set-key (kbd "C-x C-n") 'dired-sidebar-toggle-sidebar)
(global-set-key (kbd "C-x C-m") 'sidebar-toggle)
(global-set-key (kbd "<escape>") 'god-mode-all)

(global-unset-key (kbd "C-h C-h"))
(global-unset-key (kbd "C-x C-p"))

;; Set Font
(set-face-attribute 'default nil
                    :family "JetBrains Mono"
                    :height 120
                    :weight 'medium)
