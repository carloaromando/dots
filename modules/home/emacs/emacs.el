;; Emacs config

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; add package servers
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

;; Dired
(use-package dired
  :ensure nil
  :init
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq insert-directory-program "/etc/profiles/per-user/carlo/bin/gls")
  (setq dired-listing-switches
	"-al --group-directories-first --time-style=long-iso")
  (setq dired-make-directory-clickable t)
  (setq dired-free-space nil)
  (setq dired-mouse-drag-files t)

  (add-hook 'dired-mode-hook #'dired-hide-details-mode)
  (add-hook 'dired-mode-hook #'hl-line-mode))

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

;; Auto completion with Company
(use-package company
  :init
  (global-company-mode t)
  :config
  (setq company-idle-delay 0.2))

;; Flycheck
(use-package flycheck
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (flycheck-add-mode 'bazel-build-buildifier 'bazel-build-mode))

;; Advanced minibuffer completion
(use-package counsel
  :config
  ;; Simple minibuffer completion M-x
  (use-package smex
    :init (smex-initialize))
  (use-package flx)
  (ivy-mode 1)
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

;; Projectile
(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-x C-p") 'projectile-command-map)
  (projectile-mode 1)
  (setq projectile-completion-system 'ivy))

;; Dashboard
(use-package dashboard
  :init
  (progn
    (setq dashboard-items
      '((projects . 5)
        (recents . 5))))
  (dashboard-setup-startup-hook))

;; Rg
(use-package rg
  :init
  (rg-enable-default-bindings)
  (rg-enable-menu))

(use-package wgrep)

;; LSP
(use-package lsp-mode
  :commands lsp)

;; Nix
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package nixpkgs-fmt
  :init
  (add-hook 'nix-mode-hook 'nixpkgs-fmt-on-save-mode))

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
		:after #'direnv-update-directory-environment--eshell))

  ;; Enable direnv on tramp
;;   (defcustom my-direnv-enabled-hosts nil
;;     "List of remote hosts to use Direnv on.

;; Each host must have `direnv' executable accessible in the default
;; environment."
;;     :type '(repeat string)
;;     :group 'my)

;;   (defun tramp-sh-handle-start-file-process@my-direnv (args)
;;     "Enable Direnv for hosts in `my-direnv-enabled-hosts'."
;;     (with-parsed-tramp-file-name (expand-file-name default-directory) nil
;;       (if (member host my-direnv-enabled-hosts)
;;           (pcase-let ((`(,name ,buffer ,program . ,args) args))
;;             `(,name
;;               ,buffer
;;               "direnv"
;;               "exec"
;;               ,localname
;;               ,program
;;               ,@args))
;; 	args)))

;;   (with-eval-after-load "tramp-sh"
;;     (advice-add 'tramp-sh-handle-start-file-process
;; 		:filter-args #'tramp-sh-handle-start-file-process@my-direnv))
  )

;; Bazel
(use-package bazel
  :commands bazel-build bazel-run bazel-test
  :mode (("/WORKSPACE\\'" . bazel-workspace-mode)
	 ("\\.bzl\\'" . bazel-starlark-mode)
	 ("BUILD\\'" . bazel-build-mode))
  :custom
  (bazel-buildifier-before-save t))

;; Clang-Format
(use-package clang-format
  :config
  (defun clang-format-save-hook()
    "Create a buffer local save hook to apply `clang-format-buffer'"
    ;; Only format if .clang-format is found
    ;;(when (locate-dominating-file "." ".clang-format")
    (clang-format-buffer);)
    ;; Continue to save
    nil)

  (define-minor-mode clang-format-on-save-mode
    "Buffer-local mode to enable/disable automated clang format on save"
    :lighter " ClangFormat"
    (if clang-format-on-save-mode
	(add-hook 'before-save-hook 'clang-format-save-hook nil t)
      (remove-hook 'before-save-hook 'clang-format-save-hook t)))

  ;; Create a globalized minor mode to
  ;;   - Auto enable the above mode only for C/C++
  ;;   - Be able to turn it off globally if needed
  (define-globalized-minor-mode clang-format-auto-enable-mode clang-format-on-save-mode
    (lambda()(clang-format-on-save-mode t))
    :predicate '(c-mode c++-mode c-or-c++-mode))
  (clang-format-auto-enable-mode t))

;; Markdown
(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
	 ("\\.mdx\\'" . markdown-mode)))

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
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<C-S-tab>") 'previous-buffer)
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

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-o") 'counsel-find-file)
(global-set-key (kbd "M-s") 'magit-status)
(global-set-key (kbd "C-x C-n") 'dired-sidebar-toggle-sidebar)
(global-set-key (kbd "C-x C-m") 'sidebar-toggle)
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
(global-unset-key (kbd "C-x C-p"))

;; Set Font
(set-face-attribute 'default nil
                    :family "JetBrains Mono"
                    :height 120
                    :weight 'medium)

