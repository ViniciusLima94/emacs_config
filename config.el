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

(use-package! python-black
  :demand t
  :after python
  :config
  (add-hook! 'python-mode-hook #'python-black-on-save-mode)
  ;; Feel free to throw your own personal keybindings here
  (map! :leader :desc "Blacken Buffer" "m b b" #'python-black-buffer)
  (map! :leader :desc "Blacken Region" "m b r" #'python-black-region)
  (map! :leader :desc "Blacken Statement" "m b s" #'python-black-statement)
  )

;;/opt/anaconda3/bin/anaconda
;;(setq ein:jupyter-default-server-command "/anaconda3/envs/test_env/bin/jupyter")

(setq fancy-splash-image (concat doom-private-dir "splash.png"))

;; Unbind workspace switching that hijacks Option+Shift+5
(map! "M-5" nil)
(map! "s-5" nil)
(map! "S-M-5" nil)

;; macOS: stop using Option as a modifier so symbols work normally
(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta) ;; optional



;; Activate conda env
;; Path to your conda installation
(setq conda-anaconda-home "/opt/anaconda3/bin/anaconda")  ;; adjust path

;; Set the default env
(setq conda-env-home-directory "/opt/anaconda3/envs/test_env")  ;; adjust path
(conda-env-initialize-interactive-shells)
(conda-env-initialize-eshell)
(conda-env-autoactivate-mode t)

;; Activate a specific env by default
;;(conda-env-activate "basic")

;; Add known Projectile projects
(after! projectile
  (projectile-add-known-project "~/projects/phase_coupling_analysis/")
  (projectile-add-known-project "~/projects/plot_phase_coupling_analysis/")
  (projectile-add-known-project "~/projects/phase_amplitude_encoding/")
  (projectile-add-known-project "~/projects/Hopf-Model-for-Syn-Red/")
  (projectile-add-known-project "~/projects/Project-Euler/"))

(global-set-key (kbd "M-s-<left>")  'windmove-left)
(global-set-key (kbd "M-s-<right>") 'windmove-right)
(global-set-key (kbd "M-s-<up>")    'windmove-up)
(global-set-key (kbd "M-s-<down>")  'windmove-down)



(defun my/square-brackets ()
  "Append a semicolon to the end of the current line and return to normal mode."
  (interactive)
  (insert "[]")
  (evil-normal-state))  ;; ensure we drop back into normal mode

(map! :leader
      "sq" #'my/square-brackets)

(defun my/curly-brackets ()
  "Append a semicolon to the end of the current line and return to normal mode."
  (interactive)
  (insert "{}")
  (evil-normal-state))  ;; ensure we drop back into normal mode

(map! :leader
      "cb" #'my/curly-brackets)

(defun my/append-semicolon ()
  "Append a semicolon to the end of the current line and return to normal mode."
  (interactive)
  (end-of-line)
  (insert ";")
  (evil-normal-state))  ;; ensure we drop back into normal mode

(map! :leader
      ";" #'my/append-semicolon)

(defun my/insert-header-io ()
  "Insert include stdio on C code."
  (interactive)
  (insert "#include <stdio.h>")
  (evil-normal-state))  ;; ensure we drop back into normal mode

(map! :leader
      "io" #'my/insert-header-io)

(setq leetcode-save-solutions t)
(setq leetcode-directory "~/leetcode")


(org-babel-do-load-languages
 'org-babel-load-languages
 '((lua . t)
   (typescript . t) ;; since you’re also running TS
   ))


(use-package! buffer-move
  :commands (buf-move-up buf-move-down buf-move-left buf-move-right))

(map! :leader
      :desc "Move buffer left"  "w <left>"  #'buf-move-left
      :desc "Move buffer right" "w <right>" #'buf-move-right
      :desc "Move buffer up"    "w <up>"    #'buf-move-up
      :desc "Move buffer down"  "w <down>"  #'buf-move-down)

;; LSP Mode
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((python-mode . lsp-deferred)
         (js-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (rust-mode . lsp-deferred))
  :config
  (setq lsp-enable-snippet t)
  (setq lsp-prefer-capf t)) ;; prefer completion-at-point-functions for corfu

;; LSP UI (for docs, hover, etc.)
(use-package lsp-ui
  :commands lsp-ui-mode
  :after lsp-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-sideline-enable t))

;; CORFU for autocompletion UI
(use-package corfu
  :init
  (global-corfu-mode))

;; Yasnippet for snippets
(use-package yasnippet
  :init
  (yas-global-mode 1))
