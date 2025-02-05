;; Emacs config
 
;; Remove GUI widgets
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Add package servers
(add-to-list 'package-archives '("gnu"  . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Prevent creation of backup files. I'd rather manually handle that.
(setq make-backup-files nil)

;; Freaking don't ask me to type out "yes" and "no"
(defalias 'yes-or-no-p 'y-or-n-p)
(setq use-file-dialog nil)
(delete-selection-mode 1)
                       
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; Disable color crap that pukes up everywhere
(setq-default global-font-lock-mode nil)

;; Disable backup
(setq backup-inhibited t)

;; Disable auto save
(setq auto-save-default nil)

;; Disable ring bell
(setq ring-bell-function 'ignore)

;; Disable dialog box
(setq use-dialog-box nil)

;; Set show paren mode on
(show-paren-mode 1)

;; Prettify
(global-prettify-symbols-mode 1)

;; Set tab size to 4
(setq default-tab-width 4)
(setq-default c-basic-offset 4)

(add-to-list 'default-frame-alist '(width  . 140))
(add-to-list 'default-frame-alist '(height . 80))

(setq vc-follow-symlinks t)

;; Preserve cursor position when scrolling
(setq scroll-preserve-screen-position 'always) ;; Don't work. Fix

;; Ediff use single frame
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(defvar display-buffer-same-window-commands
  '(occur-mode-goto-occurrence compile-goto-error))

(add-to-list 'display-buffer-alist
             '((lambda (&rest _)
                 (memq this-command display-buffer-same-window-commands))
               (display-buffer-reuse-window
                display-buffer-same-window)
               (inhibit-same-window . nil)))

;; ---------- ;;
;;  PACKAGES  ;;
;; ---------- ;;

;; Theme
(use-package rubrication-theme
  :load-path "@rubricationThemePath@" ;; injected by nix home-manager
  :config
  (load-theme 'rubrication t))

;; Compilation Mode
(use-package compile
  :ensure nil
  :custom
  (compilation-scroll-output t)
  (compilation-auto-jump-to-first-error t)
  (compilation-max-output-line-length nil))

;; Dired
(use-package dired
  :ensure nil
  :init
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq insert-directory-program "/etc/profiles/per-user/carlo/bin/gls") ;; gnu ls need to be installed with home-manager
  (setq dired-listing-switches
        "-al --group-directories-first --time-style=long-iso")
  (setq dired-make-directory-clickable t)
  (setq dired-free-space nil)
  (setq dired-mouse-drag-files t)
  :hook ((dired-mode . dired-hide-details-mode)
	 (dired-mode . hl-line-mode)))

;; Dired subtree
(use-package dired-subtree
  :after dired
  :init
  (setq dired-subtree-use-backgrounds nil)
  :config
  (define-key dired-mode-map (kbd "<tab>") 'dired-subtree-toggle)
  (define-key dired-mode-map (kbd "<backtab>") 'dired-subtree-remove))

;; Nlinum
(use-package nlinum
  :config
  (add-hook 'prog-mode-hook 'nlinum-mode)
  (setq nlinum-format "%4d "))

;; Multiple cursors
(use-package multiple-cursors)

;; Expand region
(use-package expand-region)

;; Proced
(use-package proced
  :config
  (setq proced-tree-flag t)
  (setq proced-format-alist
   '((compat user pid tree pcpu pmem start time comm)
     (normal user pid tree pcpu pmem state start time (args comm))))
  (setq proced-format :compat))
 
;; Auto completion with Company
(use-package company
  :init
  (global-company-mode t)
  :hook
  ((slime-repl-mode . company-mode)
   (common-lisp-mode . company-mode)
   (emacs-lisp-mode . company-mode))
  :config
  (define-key company-active-map (kbd "<SPC>")
              (lambda ()
               (interactive)
               (company-abort)
               (insert " ")))
  (define-key company-active-map (kbd "<tab>") 'company-complete)
  (setq company-minimum-prefix-length 2
        company-idle-delay 0.1
        company-flx-limit 10
	company-format-margin-function nil))

;; Flycheck
(use-package flycheck
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode)
  :config
  (flycheck-add-mode 'bazel-build-buildifier 'bazel-build-mode))

;; Ivy: Advanced minibuffer completion
(use-package ivy
  :demand
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-use-selectable-prompt t)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy)))
  (define-key ivy-minibuffer-map (kbd "TAB") #'ivy-partial)
  (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done))

(use-package counsel
  :after ivy)

(use-package flx
  :after counsel)

(use-package smex
  :after counsel
  :init (smex-initialize))

;; Magit
(use-package magit
  :custom
  (magit-git-executable "/etc/profiles/per-user/carlo/bin/git"))

;; Diff Highlight
(use-package diff-hl
  :hook
  (magit-post-refresh-hook . diff-hl-magit-post-refresh))

;; God mode
(use-package god-mode
  :config
  (require 'god-mode-isearch)
  (define-key isearch-mode-map (kbd "<escape>") 'god-mode-isearch-activate)
  (define-key god-mode-isearch-map (kbd "<escape>") 'god-mode-isearch-disable)
  (define-key god-local-mode-map (kbd ".") 'repeat)
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  (defun god-mode-cursor-on ()
    (progn
      (message "Entering GOD mode...")
      (blink-cursor-mode 0)
      (set-cursor-color "darkred")))
  (defun god-mode-cursor-off ()
    (progn
      (message "Exiting GOD mode...")
      (blink-cursor-mode 1)
      (set-cursor-color "#000000")))
  (add-hook 'god-mode-enabled-hook 'god-mode-cursor-on)
  (add-hook 'god-mode-disabled-hook 'god-mode-cursor-off))

;; Dired Sidebar
(use-package dired-sidebar
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'ascii))

;; Ibuffer Sidebar
(use-package ibuffer-sidebar
  :commands (ibuffer-sidebar-toggle-sidebar))

;; Projectile
(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-x C-p") 'projectile-command-map)
  (projectile-mode 1)
  (setq projectile-completion-system 'ivy)
  (setq projectile-indexing-method 'alien))

;; Dashboard
(use-package dashboard
  :init
  (progn
    (setq dashboard-items
      '((projects . 5)
        (recents . 5))))
  (dashboard-setup-startup-hook))

;; Rg ----> use projectile-ripgrep
(use-package rg
  :init
  (rg-enable-default-bindings)
  (rg-enable-menu))

(use-package wgrep)

;; LSP
(use-package lsp-mode
  :hook
  ((c-mode c++-mode) . lsp)
  ;; ((c-mode c++-mode) . (lambda () (add-hook 'before-save-hook (lambda () (lsp-format-buffer)))))
  (lsp-mode . lsp-enable-which-key-integration)
  :config
  (setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1)
  :custom
  (lsp-clients-clangd-args '("-j=8"
                             "--background-index"
			     "--header-insertion=never"
			     "--compile-commands-dir=/Users/carlo/src/work/cubbit/" ;; find a way to use projectile root folder
			     "--query-driver=/**/*"
			     "--clang-tidy=true"))
  (lsp-enable-on-type-formatting nil)
  (lsp-idle-delay 0.1)
  :commands lsp)

(use-package lsp-ui
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-flycheck-enable t)
  (lsp-ui-peek-enable t)
  :commands lsp-ui-mode
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; Clang-Format
(use-package clang-format
  :config
  (defun clang-format-save-hook ()
    (clang-format-buffer)
    nil)

  (define-minor-mode clang-format-on-save-mode
    "Buffer-local mode to enable/disable automated clang format on save"
    :lighter " ClangFormat"
    (if clang-format-on-save-mode
	(add-hook 'before-save-hook 'clang-format-save-hook nil t)
      (remove-hook 'before-save-hook 'clang-format-save-hook t)))

  (define-globalized-minor-mode clang-format-auto-enable-mode clang-format-on-save-mode
    (lambda () (clang-format-on-save-mode t))
    :predicate '(c-mode c++-mode c-or-c++-mode))
  
  (clang-format-auto-enable-mode t))

;; Which Key
(use-package which-key
  :init
  (which-key-mode))

;; Nix
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package nixpkgs-fmt
  :hook
  (nix-mode . nixpkgs-fmt-on-save-mode))

;; Direnv
(use-package direnv
  :init
  (direnv-mode)
  :config
  (custom-set-variables
   '(direnv-non-file-modes '(compilation-mode
                             dired-mode
                             eshell-mode
                             magit-status-mode)))

  ;; Enable direnv on eshell
  (with-eval-after-load "eshell"
    (defun eshell--direnv-path-env (&rest args)
      "Update `eshell-path-env'."
      (unless (file-remote-p default-directory)
        (setq eshell-path-env (getenv "PATH"))))
    
    (advice-add 'eshell
                :after #'eshell--direnv-path-env)

    (defun direnv-update-directory-environment--eshell (&rest args)
      "Update `eshell-path-env'."
      (setq eshell-path-env (getenv "PATH")))
    (advice-add 'direnv-update-directory-environment
                :after #'direnv-update-directory-environment--eshell)))

;; Bazel
(use-package bazel
  :commands bazel-build bazel-run bazel-test
  :mode (("/WORKSPACE\\'" . bazel-workspace-mode)
         ("\\.bzl\\'" . bazel-starlark-mode)
         ("BUILD\\'" . bazel-build-mode))
  :custom
  (bazel-buildifier-before-save t))

;; Markdown
(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.mdx\\'" . markdown-mode)))

;; Org
(use-package org
  :ensure nil)

(use-package ob
  :ensure nil
  :after org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (clojure . t)
     (lisp . t)))
  :custom
  (org-export-use-babel nil)
  (org-confirm-babel-evaluate nil))

;; Slime
(use-package slime
  :config
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "sbcl")
  (add-to-list 'slime-contribs 'slime-banner)
  (add-to-list 'slime-contribs 'slime-company)
  (add-to-list 'slime-contribs 'inferior-slime)
  (setq lisp-indent-function 'common-lisp-indent-function)
  (slime-setup '(slime-fancy slime-company))
  :hook
  ((lisp-mode . slime-mode)
   (inferior-lisp-mode . (lambda () (inferior-slime-mode 1)))))

(use-package slime-company
  :after (slime company)
  :config
  (setq slime-company-completion 'fuzzy
        slime-company-after-completion 'slime-company-just-one-space))

;; Paredit
(use-package paredit
  :config
  (define-key paredit-mode-map (kbd "M-<up>") nil)
  (define-key paredit-mode-map (kbd "M-<down>") nil)
  :hook
  ((paredit-mode . (lambda () (electric-indent-mode +1)))
   (paredit-mode . (lambda () (electric-pair-mode -1)))
   (emacs-lisp-mode . paredit-mode)
   (common-lisp-mode . paredit-mode)
   (slime-repl-mode . paredit-mode)
   (slime-mode . paredit-mode)
   (lisp-interaction-mode . paredit-mode)
   (lisp-mode . paredit-mode)))

;; Typescript
(use-package typescript-mode
  :mode
  (("\\.ts\\'" . typescript-mode)))

;; Pass
(use-package password-store)

;; Chat-GPT
(use-package chatgpt-shell
  :custom
  ((chatgpt-shell-openai-key (lambda ()
			       "")))) ; TODO use pass

;; Generic hooks
(add-hook 'c-or-c++-mode (lambda () (electric-pair-mode +1)))

;; ------------------------- ;;
;;    CUSTOM KEYBINDINGS     ;;
;; ------------------------- ;;
;;
;; TODO: move specific mode keybindings in use-package declarations

(defun goto-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-at-point "~/src/systems/modules/home/emacs/emacs.el"))

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
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<C-S-tab>") 'previous-buffer)
(global-set-key (kbd "C-q") 'keyboard-quit)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-,") 'duplicate-line)
(global-set-key (kbd "C->") 'end-of-buffer)
(global-set-key (kbd "C-<") 'beginning-of-buffer)
(global-set-key (kbd "C-c C-d") 'dired)
(global-set-key (kbd "C-c C-i") 'goto-init-file)
(global-set-key (kbd "C-x C-M-k") 'kill-buffer-and-window)
(global-set-key (kbd "A-<up>") 'backward-paragraph)
(global-set-key (kbd "A-<down>") 'forward-paragraph)
(global-set-key (kbd "A-<right>") 'forward-word)
(global-set-key (kbd "A-<left>") 'backward-word)
(global-set-key (kbd "A-M-<up>") (lambda () (interactive) (scroll-down 5)))
(global-set-key (kbd "A-M-<down>") (lambda () (interactive) (scroll-up 5)))
(global-set-key (kbd "M-µ") 'toggle-frame-maximized)
(global-set-key (kbd "M-ƒ") 'toggle-frame-fullscreen)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-o") 'counsel-find-file)
(global-set-key (kbd "C-M-o") 'projectile-find-file)
(global-set-key (kbd "M-s") 'magit-status)
(global-set-key (kbd "C-x C-n") 'dired-sidebar-toggle-sidebar)
(global-set-key (kbd "C-x C-m") 'ibuffer-sidebar-toggle-sidebar)
(global-set-key (kbd "C-x C-M-n") 'dired-sidebar-jump-to-sidebar)
(global-set-key (kbd "<escape>") 'god-mode-all)

;; Do What I Mean
(global-set-key (kbd "C-M-j") 'mc/mark-all-dwim) ; both marked and unmarked region. multiple presses.

;; For continuous lines: Mark lines, then create cursors. Can be mid-line.
(global-set-key (kbd "C-M-c") 'mc/edit-lines)

;; Expand region. (Also from Magnar Sveen)
(global-set-key (kbd "C-M-l") 'er/expand-region) ; only type once, then l, -, 0

;; Select region first, then create cursors.
(global-set-key (kbd "C-M-/") 'mc/mark-all-like-this) ; select text first. finds all occurrences.
(global-set-key (kbd "C-M-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-.") 'mc/mark-next-like-this)

;; Skip this match and move to next one. (Note YouTube won't allow angle brackets here.)
(global-set-key (kbd "C-M-<") 'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-M->") 'mc/skip-to-next-like-this)

(global-unset-key (kbd "C-h C-h"))
(global-unset-key (kbd "C-h C-h"))

;; Set Font
(set-face-attribute 'default nil
                    :family "JetBrains Mono NL"
		    ;; :family "Pragmata Pro Mono"
		    :height 120
                    :weight 'medium)

(setq-default line-spacing 0)
