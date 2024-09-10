;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; BEGIN MY CUSTOM SETTINGS
;; Start Emacs in fullscreen mode
(add-to-list 'initial-frame-alist '(fullscreen . fullboth))
(add-to-list 'default-frame-alist '(fullscreen . fullboth))

;; Setting treemacs keybinds
;; Make C-c t a prefix key
;; (define-prefix-command 'my-treemacs-prefix)
;; (global-set-key (kbd "C-c t") 'my-treemacs-prefix)

;; Allows toggling treemacs window
(global-set-key (kbd "C-c b") #'treemacs-select-window)
;; moves cursor into treemacs window if it exists
(global-set-key (kbd "C-c B") #'treemacs)
;; (global-set-key (kbd "C-c t o") #'treemacs-select-window)

;; rebind commenting to run comment-line rather than comment-dwim
(global-set-key (kbd "M-;") #'comment-line)

;; add keybind for toggling breakpoint
(global-unset-key (kbd "<f9>"))


;; doesn't work with svelte
;; (use-package! lsp-tailwindcss
;;   :ensure t)

;; allow C-c to kill vterm processes (such as dev server)
(map! :after vterm
      :map vterm-mode-map
      "C-c" #'vterm-send-C-c)

(map! :after web-mode
      :map web-mode-map
      "C-," #'web-mode-surround)

(map! "<f9>" #'dap-breakpoint-toggle)

;; dap mode config from docs
(map! :after dap-mode
      :map dap-mode-map
      ;; :leader
      ;; :prefix ("d" , "dap")
      ;; basics
      :desc "dap next"          "<f10>" #'dap-next
      :desc "dap step in"       "<f11>" #'dap-step-in
      :desc "dap step out"      "<f12>" #'dap-step-out
      :desc "dap continue"      "C-<f5>" #'dap-continue
      :desc "dap hydra"         "C-S-h" #'dap-hydra
      :desc "dap debug restart" "M-<f5>" #'dap-debug-restart
      :desc "dap debug"         "<f5>" #'dap-debug)

      ;; debug
      ;; :prefix ("dd" , "Debug")
      ;; :desc "dap debug recent"  "r" #'dap-debug-recent
      ;; :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      ;; :prefix ("de" , "Eval")
      ;; :desc "eval"                "e" #'dap-eval
      ;; :desc "eval region"         "r" #'dap-eval-region
      ;; :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      ;; :desc "add expression"      "a" #'dap-ui-expressions-add
      ;; :desc "remove expression"   "d" #'dap-ui-expressions-remove

      ;; :prefix ("db" , "Breakpoint")
      ;; :desc "dap breakpoint toggle"      "<f9>" #'dap-breakpoint-toggle
      ;; :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      ;; :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      ;; :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

;; remove suspend from C-z
(global-unset-key (kbd "C-z"))

;; (after! web-mode
;;   (require 'lsp-mode)
;;   (add-hook 'web-mode-hook #'lsp))

;;; config.el ends here
