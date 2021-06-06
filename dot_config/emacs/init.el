;; Bootstrap straight.el package manager.
;; https://github.com/raxod502/straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;;;
;;; Some sane defaults.
;;; Taken from https://git.sr.ht/~technomancy/better-defaults
;;;

;; Disable menu bar, tool bar and scroll bars.
(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

;; Unique buffer names.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Show matching parentheses.
(show-paren-mode 1)
(setq show-paren-delay 0)

(setq save-interprogram-paste-before-kill t ; Under X, killing and yanking uses the X clipboard rather than just the primary selection.
      apropos-do-all t ; Apropos commands perform more extensive searches than default.
      mouse-yank-at-point t ; Mouse yanking inserts at the point instead of the location of the click.
      require-final-newline t ; require-final-newline is set to avoid problems with crontabs, etc.
      visible-bell t ; Do not get annoying sounds - Get a visual bell instead.
      load-prefer-newer t ; Setting load-prefer-newer prevents stale elisp bytecode from shadowing more up-to-date source files.
      ediff-window-setup-function 'ediff-setup-windows-plain ; Ediff is set up to use the existing frame instead of creating a new one.
      custom-file (concat user-emacs-directory "custom.el")) ; Write customizations to custom.el instead of this init file.

;; Store backups in user-emacs-directory.
(unless backup-directory-alist
  (setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                 "backups")))))


;;;
;;; My Emacs configuration
;;;

;; Use command as meta on macOS
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;; Performance tuning
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1 MB

;; Indentation.
(setq-default tab-width 4)
(setq backward-delete-char-untabify-method 'hungry)
(setq-default electric-indent-inhibit t)

(defun disable-tabs ()
  (setq indent-tabs-mode nil))

(defun enable-tabs ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t))

;; Show column number next to the line number in the mode line.
(setq column-number-mode t)

;; Font
(set-face-attribute 'default nil :font "Go Mono-13:style=Regular")

;; Theme
(load-theme 'whiteboard t)

;; Whitespace
(global-whitespace-mode)
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 '(whitespace-tab ((t (:foreground "#c1c1c1")))))

(setq whitespace-display-mappings
      '((tab-mark 9 [124 9] [92 9])))

;; Highlight current line
(global-hl-line-mode)


;;;
;;; Modes
;;;

;;
;; Selectrum and perscient.el
;;
;; Item selection
;;
(straight-use-package 'selectrum)
(selectrum-mode +1)
(straight-use-package 'prescient)
(straight-use-package 'selectrum-prescient)
(selectrum-prescient-mode +1)
(prescient-persist-mode +1)

;;
;; Evil
;;
;; Vim emulation
;;
(straight-use-package 'evil)
(defvaralias 'evil-shift-width 'tab-width)
;;(setq-default evil-shift-width my-tab-width)
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(evil-mode 1)
(straight-use-package 'evil-collection)

;;
;; Which Key
;;
;; Display key bindings
;;
(straight-use-package 'which-key)
(evil-collection-init 'which-key)
(which-key-mode)

;;
;; Winum
;;
;; Select window by number
;;
(straight-use-package 'winum)
(winum-mode)

;;
;; Projectile
;;
;; Project management
;;
(straight-use-package 'projectile)
(projectile-mode +1)

;;
;; Magit
;;
;; Git interface
;;
(straight-use-package 'magit)
(evil-collection-init 'magit)

;;
;; Smartparens
;;
;; Insert pairs of parens automatically
;;
(straight-use-package 'smartparens)
(require 'smartparens-config)

(sp-pair "{" nil :post-handlers '(("||\n[i]" "RET")
                                  ("| " "SPC")))

(smartparens-global-mode 1)

;;
;; Company
;;
;; Auto-completion
;;
(straight-use-package 'company)
(setq company-idle-delay 0)
(setq company-echo-delay 0)
(setq company-minimum-prefix-length 1)
(setq company-tooltip-limit 20)
(setq company-show-numbers t)
(setq company-selection-wrap-around t)
(setq company-dabbrev-downcase nil)
(setq company-backends '(company-capf
                         company-dabbrev-code
                         company-dabbrev))
(add-hook 'after-init-hook 'global-company-mode)

;;
;; YASnippet
;;
;; Snippet management
;;
(straight-use-package 'yasnippet)
(yas-global-mode 1)

;;
;; LSP
;;
;; Language server client
;;
(straight-use-package 'lsp-mode)
;;(setq lsp-headerline-breadcrumb-enable f)
;; (straight-use-package 'lsp-ui)

;;
;; Polymode
;;
;; A framework for multiple major modes
;;
(straight-use-package 'polymode)

;;
;; Bazel
;;
;; Mode for the Bazel build system
;;
(straight-use-package 'bazel)

;;
;; Text
;;
;; Text mode configuration
;;
(add-hook 'text-mode-hook (lambda ()
                            (setq fill-column 80)
                            (enable-tabs)
                            (display-fill-column-indicator-mode)
                            (display-line-numbers-mode)))

;;
;; Prog
;;
;; Prog mode configuration
;;
(add-hook 'prog-mode-hook (lambda ()
                            (setq fill-column 100)
                            (enable-tabs)
                            (display-fill-column-indicator-mode)
                            (display-line-numbers-mode)))

;;
;; Lisp
;;
;; Lisp mode configuration
;;
(add-hook 'lisp-mode-hook (lambda ()
                            (disable-tabs)))

;;
;; Emacs Lisp
;;
;; Emacs Lisp mode configuration
;;
(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (disable-tabs)))

;;
;; Go
;;
;; Mode for the Go language
;;
(straight-use-package 'go-mode)
(evil-collection-init 'go-mode)
(add-hook 'go-mode-hook (lambda ()
                          (lsp-deferred)))

;;
;; Just
;;
;; Mode for editing justfiles (an alternative to Make)
;;
(straight-use-package 'just-mode)

;;
;; TypeScript
;;
;; Mode for editing TypeScript
;;
(straight-use-package 'typescript-mode)
(add-hook 'typescript-mode-hook (lambda ()
                                  (lsp-deferred)))

;;
;; Terraform
;;
;; Mode for Terraform projects
;;
(straight-use-package 'terraform-mode)

;;
;; YAML
;;
;; Mode for YAML files
;;
(straight-use-package 'yaml-mode)
(add-hook 'yaml-mode-hook (lambda ()
                            (setq fill-column 100)
                            (setq tab-width 2)
                            (disable-tabs)))

;;
;; JSON
;;
;; Mode for editing JSON files
;;
(straight-use-package 'json-mode)

;;
;; Jsonnet
;;
;; Mode for jsonnet and libsonnet files
;;
(straight-use-package 'jsonnet-mode)

;;
;; Vue
;;
;; A mode for Vue based on Polymode
;; https://github.com/AdamNiederer/vue-mode/issues/109
;;
(define-innermode poly-vue-template-innermode
  :mode 'html-mode
  :head-matcher "<[[:space:]]*template[[:space:]]*[[:space:]]*>"
  :tail-matcher "</[[:space:]]*template[[:space:]]*[[:space:]]*>"
  :head-mode 'host
  :tail-mode 'host)

(define-innermode poly-vue-template-html-innermode
  :mode 'html-mode
  :head-matcher "<[[:space:]]*template[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*html[[:space:]]*[\"'][[:space:]]*>"
  :tail-matcher "</[[:space:]]*template[[:space:]]*[[:space:]]*>"
  :head-mode 'host
  :tail-mode 'host)

(define-innermode poly-vue-script-innermode
  :mode 'js-mode
  :head-matcher "<[[:space:]]*script[[:space:]]*[[:space:]]*>"
  :tail-matcher "</[[:space:]]*script[[:space:]]*[[:space:]]*>"
  :head-mode 'host
  :tail-mode 'host)

(define-innermode poly-vue-script-js-innermode
  :mode 'js-mode
  :head-matcher "<[[:space:]]*script[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*js[[:space:]]*[\"'][[:space:]]*>"
  :tail-matcher "</[[:space:]]*script[[:space:]]*[[:space:]]*>"
  :head-mode 'host
  :tail-mode 'host)

(define-innermode poly-vue-script-ts-innermode
  :mode 'typescript-mode
  :head-matcher "<[[:space:]]*script[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*ts[[:space:]]*[\"'][[:space:]]*>"
  :tail-matcher "</[[:space:]]*script[[:space:]]*[[:space:]]*>"
  :head-mode 'host
  :tail-mode 'host)

(define-innermode poly-vue-style-innermode
  :mode 'css-mode
  :head-matcher "<[[:space:]]*style[[:space:]]*[[:space:]]*>"
  :tail-matcher "</[[:space:]]*style[[:space:]]*[[:space:]]*>"
  :head-mode 'host
  :tail-mode 'host)

(define-innermode poly-vue-style-css-innermode
  :mode 'css-mode
  :head-matcher "<[[:space:]]*style[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*css[[:space:]]*[\"'][[:space:]]*>"
  :tail-matcher "</[[:space:]]*style[[:space:]]*[[:space:]]*>"
  :head-mode 'host
  :tail-mode 'host)

(define-polymode poly-vue-mode
  :hostmode 'poly-sgml-hostmode
  :innermodes '(poly-vue-template-html-innermode
                poly-vue-script-ts-innermode
                poly-vue-script-js-innermode
                poly-vue-style-css-innermode
                poly-vue-template-innermode
                poly-vue-script-innermode
                poly-vue-style-innermode))

(add-to-list 'auto-mode-alist '("\\.vue" . poly-vue-mode))

;;
;; Telephone-line
;;
;; Mode line
;;
(straight-use-package 'telephone-line)

(setq telephone-line-height 20
      telephone-line-primary-left-separator 'telephone-line-flat
      telephone-line-primary-right-separator 'telephone-line-flat
      telephone-line-secondary-left-separator 'telephone-line-flat
      telephone-line-secondary-right-separator 'telephone-line-flat)

(setq telephone-line-lhs
      '((evil   . (telephone-line-evil-tag-segment))
        (accent . (telephone-line-window-number-segment))
        (accent . (telephone-line-projectile-buffer-segment))
        (nil    . (telephone-line-vc-segment))
        (nil    . (telephone-line-flymake-segment))))

(setq telephone-line-rhs
      '((nil    . (telephone-line-misc-info-segment))
        (nil    . (telephone-line-atom-eol-segment))
        (nil    . (telephone-line-atom-encoding-segment))
        (accent . (telephone-line-major-mode-segment))
        (evil   . (telephone-line-position-segment))))

(telephone-line-mode 1)


;;;
;;; Key maps and key bindings
;;;

;; Prevent mouse click from changing the cursor position.
(global-unset-key [down-mouse-1])
(global-unset-key [mouse-1])
(define-key evil-normal-state-map [down-mouse-1] nil)
(define-key evil-normal-state-map [mouse-1] nil)
(define-key evil-normal-state-map [down-mouse-3] nil)
(define-key evil-normal-state-map [mouse-3] nil)
(define-key evil-insert-state-map [down-mouse-1] nil)
(define-key evil-insert-state-map [mouse-1] nil)
(define-key evil-insert-state-map [down-mouse-3] nil)
(define-key evil-insert-state-map [mouse-3] nil)
(define-key evil-motion-state-map [down-mouse-1] nil)
(define-key evil-motion-state-map [mouse-1] nil)
(define-key evil-motion-state-map [down-mouse-3] nil)
(define-key evil-motion-state-map [mouse-3] nil)

;; Space map - A prefix keymap using the space key.
(define-prefix-command 'space-map)
(define-key space-map "b" 'space-buffer-map)
(define-key space-map "f" 'space-file-map)
(define-key space-map "p" 'space-projectile-map)
(define-key space-map "w" 'space-window-map)
(define-key space-map (kbd "SPC") 'execute-extended-command)
(define-key evil-normal-state-map (kbd "SPC") 'space-map)

;; Space buffer map
(define-prefix-command 'space-buffer-map)
(define-key space-buffer-map "b" 'switch-to-buffer)
(define-key space-buffer-map "k" 'kill-current-buffer)

;; Space file map
(define-prefix-command 'space-file-map)
(define-key space-file-map "f" 'find-file)

;; Space projectile map
(define-prefix-command 'space-projectile-map)
(define-key space-projectile-map "a" 'projectile-add-known-project)
(define-key space-projectile-map "f" 'projectile-find-file)
(define-key space-projectile-map "i" 'projectile-invalidate-cache)
(define-key space-projectile-map "p" 'projectile-switch-project)

;; Space window map
(define-prefix-command 'space-window-map)
(define-key space-window-map "1" 'winum-select-window-1)
(define-key space-window-map "2" 'winum-select-window-2)
(define-key space-window-map "3" 'winum-select-window-3)
(define-key space-window-map "4" 'winum-select-window-4)
(define-key space-window-map "5" 'winum-select-window-5)
(define-key space-window-map "6" 'winum-select-window-6)
(define-key space-window-map "7" 'winum-select-window-7)
(define-key space-window-map "8" 'winum-select-window-8)
(define-key space-window-map "9" 'winum-select-window-9)
(define-key space-window-map "0" 'winum-select-window-0)
(define-key space-window-map "w" 'winum-select-window-by-number)
