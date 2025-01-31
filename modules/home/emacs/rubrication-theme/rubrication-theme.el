(deftheme rubrication
  "Rubrication design inspired theme.")

(let ((fg "#000000")
      (fg-table "#222291")
      ;;(bg "#ffffff")
      (bg "#f5f4ed")
      (bg-light "#ddddd8")
      (fg-modeline "#eeeeee")
      (bg-modeline "#2c2c2c")
      (fg-light "DimGray")
      (bg-highlight "#add6ff")
      (bg-highlight-2 "#deeeff")
      (bg-highlight-3 "LightGreen"))

  (custom-theme-set-faces
   'rubrication

   ;; generic stuff
   `(default ((t (:background ,bg :foreground ,fg))))
   `(button ((t (:foreground ,fg :underline t))))
   `(cursor ((t (:background ,fg :foreground "white smoke"))))
   `(custom-variable-tag ((t (:foreground ,fg :weight bold))))
   `(default-italic ((t (:italic t))))

   `(font-lock-builtin-face ((t (:background ,bg :foreground ,fg))))
   `(font-lock-comment-face ((t (:foreground "#cc0000"))))
   `(font-lock-doc-face ((t (:foreground ,fg :weight bold :slant italic))))
   `(font-lock-constant-face ((t (:foreground ,fg))))
   `(font-lock-doc-face ((t (:foreground ,fg :weight semi-bold))))
   `(font-lock-function-name-face ((t (:foreground ,fg))))
   `(font-lock-keyword-face ((t (:foreground ,fg :slant italic))))
   `(font-lock-preprocessor-face ((t (:foreground ,fg))))
   `(font-lock-reference-face ((t (:foreground ,fg))))
   `(font-lock-string-face ((t (:foreground ,fg :slant italic))))
   `(font-lock-type-face ((t (:foreground ,fg))))
   `(font-lock-variable-name-face ((t (:foreground ,fg :underline nil))))
   `(font-lock-warning-face ((t (:foreground ,fg :weight bold))))
   `(fringe ((t (:background ,bg :foreground ,bg))))
   
   `(gnus-header-content ((t (:foreground ,fg))))
   `(gnus-header-from ((t (:foreground ,fg))))
   `(gnus-header-name ((t (:foreground ,fg))))
   `(gnus-header-subject ((t (:foreground ,fg))))
   
   `(highlight ((t :background ,bg-highlight :foreground ,fg)))
   
   `(ido-first-match ((t (:foreground ,fg))))
   `(ido-only-match ((t (:foreground ,fg))))
   `(ido-subdir ((t (:foreground ,fg))))
   
   `(isearch ((t (:background ,bg-highlight :foreground ,fg))))
   
   `(link ((t (:foreground ,fg))))
   
   `(minibuffer-prompt ((t (:foreground ,fg :weight bold))))

   ;; mode line
   `(mode-line ((t (:background ,bg-modeline :foreground ,fg-modeline :height 0.9))))
   `(mode-line-buffer ((t (:foreground ,fg-modeline :weight bold))))
   `(mode-line-inactive ((t (:background ,bg-modeline :foreground ,bg-modeline :height 0.9))))
   `(mode-line-minor-mode ((t (:weight ultra-light))))
   `(modeline ((t (:background ,bg-modeline :foreground ,fg-modeline :height 0.9))))
   `(region ((t (:background ,bg-highlight :foreground ,fg))))
   `(eglot-mode-line ((t (:foreground ,fg-modeline))))
   
   `(slime-repl-inputed-output-face ((t (:foreground ,fg))))
   
   `(whitespace-line ((t (:background ,bg-highlight-2 :foreground ,fg))))
   `(lazy-highlight ((t (:background ,bg-highlight-2 :foreground ,fg))))

   ;; org
   `(org-agenda-date ((t (:foreground ,fg :height 1.2))))
   `(org-agenda-date-today ((t (:foreground ,fg :weight bold :height 1.4))))
   `(org-agenda-date-weekend ((t (:foreground ,fg :weight normal))))
   `(org-agenda-structure ((t (:foreground ,fg :weight bold))))
   `(org-block ((t (:foreground ,fg))))
   `(org-block-begin-line ((t (:foreground ,fg-light :height 0.8))))
   `(org-block-end-line ((t (:foreground ,fg-light :height 0.8))))
   `(org-meta-line ((t (:inherit default :foreground ,fg-light :height 0.8))))
   `(org-verbatim ((t (:foreground ,fg :weight semi-bold))))
   `(org-date ((t (:foreground ,fg) :underline)))
   `(org-done ((t (:foreground ,fg-light))))
   `(org-hide ((t (:foreground ,bg))))
   `(org-level-1 ((t (:foreground ,fg :weight semi-bold :height 1.3))))
   `(org-level-2 ((t (:foreground ,fg :weight semi-bold :height 1.1 :overline ,bg))))
   `(org-level-3 ((t (:foreground ,fg :weight semi-bold :height 1.1 :overline ,bg))))
   `(org-level-4 ((t (:foreground ,fg :weight semi-bold :height 1.1 :overline ,bg))))
   `(org-level-5 ((t (:foreground ,fg :weight semi-bold :height 1.1 :overline ,bg))))
   `(org-level-6 ((t (:foreground ,fg :weight semi-bold :height 1.1 :overline ,bg))))
   `(org-link ((t (:foreground ,fg :underline t))))
   `(org-quote ((t (:foreground ,fg :slant italic :inherit org-block))))
   `(org-scheduled ((t (:foreground ,fg))))
   `(org-sexp-date ((t (:foreground ,fg))))
   `(org-special-keyword ((t (:foreground ,fg))))
   `(org-todo ((t (:foreground ,fg))))
   `(org-verse ((t (:inherit org-block :slant italic))))
   `(org-table ((t (:inherit default :foreground ,fg))))
   `(ivy-org ((t (:inherit default))))

   ;; magit
   `(magit-section-highlight ((t (:background "#eaeaea"))))

   ;; diff
   `(diff-added ((t (:background "#e9ffe9"))))
   `(diff-removed ((t (:background "#ffecec"))))
   `(diff-refine-added ((t (:background "#a4f4a3"))))
   `(diff-refine-removed ((t (:background "#f9cbca"))))
   `(magit-diff-added-highlight ((t (:weight demibold :background "#e9ffe9"))))
   `(magit-diff-added ((t (:background "#e9ffe9"))))
   `(magit-diff-removed-highlight ((t (:weight demibold :background "#ffecec"))))
   `(magit-diff-removed ((t (:background "#ffecec"))))

   ;; git-timemachine
   `(git-timemachine-minibuffer-author-face ((t (:inherit default))))
   `(git-timemachine-minibuffer-detail-face ((t (:weight bold))))

   ;; compile
   `(compilation-error ((t (:inherit error))))

   ;; flycheck
   `(flycheck-error ((t (:foreground ,fg :underline (:color "red2" :style wave :position nil) :weight normal))))
   `(flycheck-warning ((t (:foreground ,fg :underline (:color "orange" :style wave :position nil) :weight normal))))
   
   ;; dired
   `(dired-directory ((t (:weight bold))))
   `(dired-subtree-depth-1-face ((t (:inherit default))))
   `(dired-subtree-depth-2-face ((t (:inherit default))))
   `(dired-subtree-depth-3-face ((t (:inherit default))))
   `(dired-subtree-depth-4-face ((t (:inherit default))))

   ;; helm
   `(helm-source-header ((t (:foreground ,fg :background "grey90" :weight bold))))
   `(helm-header ((t (:foreground ,fg))))
   `(helm-selection-line ((t (:inherit region :weight bold))))
   `(helm-selection ((t (:background ,bg-highlight))))
   `(helm-ff-directory ((t (:foreground ,fg :weight bold))))
   `(helm-ff-dotted-directory ((t (:foreground ,fg :weight bold))))
   `(helm-ff-symlink ((t (:foreground ,fg :slant italic))))
   `(helm-ff-executable ((t (:foreground ,fg))))

   ;; iedit
   `(iedit-occurrence ((t (:background ,bg-highlight-3 :foreground ,fg))))

   ;; company
   `(company-echo-common ((t (:foreground ,fg))))
   `(company-tooltip ((t (:background "#eaeaea" :foreground "black"))))
   `(company-scrollbar-bg ((t :background "#eaeaea")))
   `(company-tooltip-search-selection ((t (:inherit highlight))))
   `(company-tooltip-scrollbar-track ((t :background "#eaeaea")))
   `(company-tooltip-scrollbar-thumb ((t :background "black")))
   `(company-tooltip-selection ((t (:background "#dadada"))))
   
   ;; parens - parenface
   '(parenface-paren-face ((t (:foreground "blue"))))
   '(parenface-curly-face ((t (:foreground "blue"))))
   '(parenface-bracket-face ((t (:foreground "blue"))))

   ;; parens - parenface
   '(parenthesis ((t (:foreground "blue"))))

   ;; parens - other
   `(sp-show-pair-match-face ((t (:foreground "black" :weight bold))))
   `(sp-show-pair-mismatch-face ((t (:background "red" :foreground "black" :weight bold))))
   `(show-paren-match ((t (:foreground "black" :weight bold))))
   `(show-paren-mismatch ((t (:background "red" :foreground "black" :weight bold))))

   ;; rpm-spec
   `(rpm-spec-tag-face ((t (:inherit default))))
   `(rpm-spec-package-face ((t (:inherit default))))
   `(rpm-spec-macro-face ((t (:inherit default))))
   `(rpm-spec-doc-face ((t (:inherit default))))
   `(rpm-spec-var-face ((t (:inherit default))))
   `(rpm-spec-ghost-face ((t (:inherit default))))
   `(rpm-spec-section-face ((t (:inherit default :weight bold))))

   ;; linum
   `(linum ((t (:foreground ,fg :weight bold))))

   ;; web
   `(web-mode-current-element-highlight-face ((t (:inherit normal :weight bold :foreground ,fg))))

   ;; lsp
   `(lsp-ui-doc-background ((t (:background "#eaeaea"))))
   `(lsp-headerline-breadcrumb-path-error-face ((t (:style nil))))
   `(lsp-headerline-breadcrumb-path-hint-face ((t (:style nil))))
   `(lsp-headerline-breadcrumb-path-info-face ((t (:style nil))))
   `(lsp-headerline-breadcrumb-path-warning-face ((t (:style nil))))
   `(lsp-headerline-breadcrumb-symbols-error-face ((t (:style nil))))
   `(lsp-headerline-breadcrumb-symbols-hint-face ((t (:style nil))))
   `(lsp-headerline-breadcrumb-symbols-info-face ((t (:style nil))))
   `(lsp-headerline-breadcrumb-symbols-warning-face ((t (:style nil))))
   
   ;; misc
   `(yas-field-highlight-face ((t (:underline t :background ,bg-highlight :foreground ,fg))))
   `(eshell-prompt ((t (:foreground ,fg :weight bold))))
   `(cider-result-overlay-face ((t (:weight bold))))
   `(hl-line ((t (:background ,bg))))
   `(Shadow ((t (:foreground "grey75"))))
   `(idle-highlight ((t (:background ,bg-highlight))))))

;;;###autoload
(when load-file-name
  (add-to-list
   'custom-theme-load-path
   (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'rubrication)
