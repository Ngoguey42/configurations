;;****************************************************************************;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   my_config.el                                       :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2016/04/19 09:50:58 by ngoguey           #+#    #+#             ;;
;;                                                                            ;;
;;****************************************************************************;;

;; ************************************************************************** ;;
;; modes ******************************************************************** ;;
;; ************************************************************************** ;;

;; ;;proof general(major);;
;; (load (concat confPath "/vendored/PG/generic/proof-site"))
;; ;;/proof general;;

;; ;;r-mode(major)
;; (defvar rmode_path (concat confPath "/vendored/ESS/lisp/"))
;; (if (file-exists-p rmode_path)
;;     (progn
;;       (add-to-list 'load-path rmode_path)
;;       (require 'ess-site)
;;       (add-hook
;;        'ess-mode-hook
;;        (lambda ()
;; 	 (setq comment-start "##")
;; 	 ))
;;       )
;;   )
;; ;;/r-mode

(require 'my-ecaml)
(add-hook 'merlin-mode-hook (lambda () (my-late-set-keys)))

(setq indent-tabs-mode nil)

;;yaml-mode(major)
(defvar yamlmode_path (concat confPath "/vendored/yaml-mode/"))
(add-to-list 'load-path yamlmode_path)
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
;;/yaml-mode

;;dart-mode(major)
(defvar dashdotel_path (concat confPath "/vendored/dash.el/"))
(add-to-list 'load-path dashdotel_path)

(defvar flycheck_path (concat confPath "/vendored/flycheck/"))
(add-to-list 'load-path flycheck_path)

(defvar seqdotel_path (concat confPath "/vendored/seq.el/"))
(add-to-list 'load-path seqdotel_path)

(defvar let-alist_path (concat confPath "/vendored/let-alist-1.0.4/"))
(add-to-list 'load-path let-alist_path)

(defvar dartmode_path (concat confPath "/vendored/dart-mode/"))
(add-to-list 'load-path dartmode_path)
(require 'dart-mode)
(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))
;;/dart-mode

;;scala-mode2(major)
(defvar scalamode2_path (concat confPath "/vendored/scala-mode2/"))
(add-to-list 'load-path scalamode2_path)
(require 'scala-mode2)
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.sc\\'" . scala-mode))
;;/scala-mode2

;;erlang-mode(major)
(defvar erlemacs_path_brew "~/.brew/opt/erlang/lib/erlang/lib/tools-2.8.3/emacs/")
(if (file-exists-p erlemacs_path_brew)
    (progn
      (add-to-list 'load-path erlemacs_path_brew)
      ;; (setq erlang-root-dir "/usr/local/otp")
      ;; (setq exec-path (cons "/usr/local/otp/bin" exec-path))
      (require 'erlang-start)
      )
  )
;;/erlang-mode

;;dockerfile-mode(major)
(defvar dockerfilemode_path (concat confPath "/vendored/dockerfile-mode/"))
(add-to-list 'load-path dockerfilemode_path)
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
;;/dockerfile-mode

;;markdown-mode(major)
(defvar markdownmode_path (concat confPath "/vendored/markdown-mode/"))
(add-to-list 'load-path markdownmode_path)
;;Can you please stop with your tabs you mode?!?
(setq markdown-indent-on-enter nil)
(defun insert-lol () "lol" (interactive) (insert "   "))
(setq markdown-indent-function (quote insert-lol))
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;;/markdown-mode

;;nasm-mode
(defvar nasmmode_path (concat confPath "/vendored/nasm-mode/Matthieu-Hauglustaine-nasm-mode.el"))
(autoload 'nasm-mode nasmmode_path "" t)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))
(add-hook
 'nasm-mode-hook
 (lambda () (setq-default nasm-basic-offset 4)))
;;/nasm-mode

;;web-mode
(defvar webmode_path (concat confPath "/vendored/web-mode/"))
(add-to-list 'load-path webmode_path)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

(set-face-attribute 'web-mode-html-tag-face nil :foreground "MediumSlateBlue")
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "SteelBlue")

(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(add-hook
 'web-mode-hook
 (lambda ()
   (setq-default indent-tabs-mode nil)
   ))
;;/web-mode

;;emacs-lisp-mode-hook
(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
   (setq comment-start ";;")
   (setq indent-tabs-mode nil)
   (setq tab-width 2)
   ))
;;/emacs-lisp-mode-hook

;;tuareg
(defvar tuareg_path (concat confPath "/vendored/tuareg/"))
(add-to-list 'load-path tuareg_path)

(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)

(setq tuareg-match-patterns-aligned t)
(setq tuareg-indent-align-with-first-arg nil)

(add-hook
 'tuareg-mode-hook
 (lambda ()
   (setq show-trailing-whitespace t)
   (setq indicate-empty-lines t)
   (setq mode-name "🐫")
   (elide-head)
   ;; (when (functionp 'flyspell-prog-mode) (flyspell-prog-mode))

   ))

;; Quick and dirty setup of HIDESHOW minor mode for ocaml. Seems to work perfectly
(add-to-list 'hs-special-modes-alist
             '(tuareg-mode
               "\\b\\(sig\\|struct\\|object\\|begin\\)\\b" "\\bend\\b"
               nil nil nil))
(add-hook 'tuareg-mode-hook (lambda () (hs-minor-mode 1)))

(setq
 auto-mode-alist
 (append
  '(("\\.ml[ily]?$" . tuareg-mode))
  auto-mode-alist))
;;/tuarzgeg

;;opam
(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    ))
;;/opam

;;merlin
(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    (setq merlin-error-after-save nil)
    (setq merlin-command 'opam)))
;;/merlin

;;ocamlformat
(add-hook 'tuareg-mode-hook (lambda ()
  (define-key tuareg-mode-map (kbd "C-x f") #'ocamlformat)
  (let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
    (when (and opam-share (file-directory-p opam-share))
      (setq ocamlformat-command (concat (getenv "HOME") "/.opam/of18/bin/ocamlformat"))
      (require 'ocamlformat)
      ))
  ))

(defun ft-ocamlformat016 ()
  "swap lines down"
  (interactive)
  (if (> (count-lines (point) (point-max)) 0)
      (let ((colnb (current-column)))
        (end-of-line)
        (delete-forward-char 1)
        (kill-line)
        (beginning-of-line)
        (yank)
        (newline)
        (move-to-column colnb)
        )
    )
  )

;;/ocamlformat

;;glsl-mode
(defvar glslmode_path (concat confPath "/vendored/glsl-mode/"))
(add-to-list 'load-path glslmode_path)

(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.tesc\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.tese\\'" . glsl-mode))

;;/glsl-mode

;;lua-mode
(defvar luamode_path (concat confPath "/vendored/lua-mode/"))
(add-to-list 'load-path luamode_path)

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
(setq lua-indent-level 2)
;;/lua-mode

;;python
(add-hook
 'python-mode-hook
 (lambda ()
   (setq indent-tabs-mode nil)
   (setq tab-width 4)
   (setq python-indent 4)
   ))
;;/python

;;cuda
(add-to-list 'auto-mode-alist '("\\.cu$" . c-mode))
;;/cuda

;;c
(add-to-list 'auto-mode-alist '("\\.inl$" . c-mode))
(add-hook
 'c-mode-hook
 (lambda ()
   (setq-default tab-width 4)
   (setq-default indent-tabs-mode t)
   (setq-default c-basic-offset 4)
   (setq-default c-default-style "linux")
   ))
;;/c

;;c++
(add-to-list 'auto-mode-alist '("\\.tpp$" . c++-mode))
(c-set-offset 'innamespace 0)
(add-hook
 'c++-mode-hook
 (lambda ()
   (c-set-offset 'arglist-intro 0)
   (setq indent-tabs-mode nil)
   (setq tab-width 2)
   ))
;;/c++

(require 'elide-head)
(add-to-list 'elide-head-headers-to-hide
             '("Copyright (c)" . "PERFORMANCE OF THIS SOFTWARE."))
(add-to-list 'elide-head-headers-to-hide
             '("The MIT License" . "all copies or substantial portions of the Software."))
(add-to-list 'elide-head-headers-to-hide
             '("Permission to use, copy, modify, and/or" . "PERFORMANCE OF THIS SOFTWARE."))
(add-to-list 'elide-head-headers-to-hide
             '("Open Source License" . "DEALINGS IN THE SOFTWARE."))

;; minor perspective(minor)
(defvar perspdotel_path (concat confPath "/vendored/persp-mode.el/"))
(add-to-list 'load-path perspdotel_path)

;; (setq persp-add-buffer-on-after-change-major-mode t)
;; (setq persp-add-buffer-on-find-file t)
(setq persp-nil-name "default")

(with-eval-after-load "persp-mode"
  (setq wg-morph-on nil)
  (setq persp-autokill-buffer-on-remove 'kill-weak)
  (setq persp-auto-resume-time -1
        persp-auto-save-opt 0)
  (setq persp-save-dir "./")
  (persp-mode 1)
  )

(defun ft-persp-activate (name)
  "Switch to frame."
  (interactive "sft-Perspective name to switch: ")
  (if (member name (persp-names *persp-hash* nil))
      (persp-activate (persp-add-new name) (selected-frame))
    )
  )

(defun ft-persp-activate-f1 (name)
  "Switch to frame."
  (interactive "sft-Perspective name to switch: f1/")
  (if (member (concat "f1/" name) (persp-names *persp-hash* nil))
      (persp-activate (persp-add-new (concat "f1/" name)) (selected-frame))
    )
  )

(defun ft-persp-activate-f2 (name)
  "Switch to frame."
  (interactive "sft-Perspective name to switch: f2/")
  (if (member (concat "f2/" name) (persp-names *persp-hash* nil))
      (persp-activate (persp-add-new (concat "f2/" name)) (selected-frame))
    )
  )

(defun ft-persp-activate-new (name)
  "Switch to frame."
  (interactive "sft-Perspective name to create: ")
  (unless (member name (persp-names *persp-hash* nil))
    (persp-frame-switch name)
    (switch-to-buffer (find-file "./"))
    )
  )

(require 'persp-mode)
;; /perspective(minor)


;;fci-mode (minor)
;; (defvar fci_path (concat confPath "/vendored/Fill-Column-Indicator/"))
;; (add-to-list 'load-path fci_path)
;; (require 'fill-column-indicator)
;; (define-globalized-minor-mode
;;   global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; (setq fci-rule-column 80)
;; (setq fci-rule-color "#181818")
;; (global-fci-mode t)
;;/fci-mode (minor)

;; ************************************************************************** ;;
;; /modes ******************************************************************* ;;
;; ************************************************************************** ;;

;; ************************************************************************** ;;
;; MISC ********************************************************************* ;;
;; ************************************************************************** ;;

;;42 site-lisp
;; (defvar siteLispDir42 (concat confPath "/vendored/davidGironLisp"))
;; (add-to-list 'load-path siteLispDir42)
;; (load "header.el")
;;/42 site-lisp

;; shell-command configuration
(setq shell-file-name "zsh")
(setq shell-command-switch "-ic")
;; /shell-command configuration

;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Choosing-Window-Options.html
(setq split-height-threshold nil)
(setq split-width-threshold 80)

(load "my_bindings.el")

(setq auto-save-default nil)
(setq make-backup-files nil)
(setq line-number-mode t)
(setq column-number-mode t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq
 completion-ignored-extensions
 (append
  completion-ignored-extensions
  (quote
   (".cmx"  ".cmi"  ".cmo" ))))
(c-set-offset 'inextern-lang 0)

;; (global-hl-line-mode 1)
;; (set-face-background 'hl-line "purple")
;; (set-face-foreground 'highlight nil)

(menu-bar-mode -1)

;; Reverse colors for the border to have nicer line
;; (set-face-inverse-video-p 'vertical-border nil)
;; (set-face-background 'vertical-border (face-background 'default))

;; Set symbol for the border
;; (set-display-table-slot standard-display-table
                        ;; 'vertical-border
                        ;; 0
                        ;; (make-glyph-code ? )
                        ;; )


(set-face-attribute  'mode-line
                     nil
                     :foreground "forest green"
                     :background "snow2"
                     :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line-inactive
                     nil
                     :foreground "orange"
                     :background "deep pink"
                     :box '(:line-width 1 :style released-button))
(set-face-attribute  'font-lock-function-name-face
                     nil
                     :foreground "orange"
                     :box '(:line-width 1 :style released-button))
(set-face-attribute  'font-lock-keyword-face
                     nil
                     :foreground "DeepSkyBlue1"
                     :box '(:line-width 1 :style released-button))
(set-face-attribute  'font-lock-builtin-face
                     nil
                     :foreground "LightBlue4"
                     :box '(:line-width 1 :style released-button))

(set-face-attribute  'font-lock-doc-face
                     nil
                     :foreground "orange red"
                     :box '(:line-width 1 :style released-button))
(set-face-attribute  'font-lock-comment-face
                     nil
                     :foreground "firebrick2"
                     :box '(:line-width 1 :style released-button))
(set-face-attribute  'font-lock-string-face
                     nil
                     :foreground "salmon2"
                     :box '(:line-width 1 :style released-button))
(set-face-attribute  'minibuffer-prompt
                     nil
                     :foreground "orange"
                     :box '(:line-width 1 :style released-button))

;; (transient-mark-mode 1)

;; (ido-mode 1)
;; (setq ido-separator "\n")

;; ************************************************************************** ;;
;; /MISC ******************************************************************** ;;
;; ************************************************************************** ;;

;; auto-balance on startup
(add-hook 'emacs-startup-hook 'balance-windows)

;; handle tmux's xterm-keys
;; put the following line in your ~/.tmux.conf:
;;   setw -g xterm-keys on
(if (getenv "TMUX")
    (progn
      (let ((x 2) (tkey ""))
        (while (<= x 8)
          ;; shift
          (if (= x 2)
              (setq tkey "S-"))
          ;; alt
          (if (= x 3)
              (setq tkey "M-"))
          ;; alt + shift
          (if (= x 4)
              (setq tkey "M-S-"))
          ;; ctrl
          (if (= x 5)
              (setq tkey "C-"))
          ;; ctrl + shift
          (if (= x 6)
              (setq tkey "C-S-"))
          ;; ctrl + alt
          (if (= x 7)
              (setq tkey "C-M-"))
          ;; ctrl + alt + shift
          (if (= x 8)
              (setq tkey "C-M-S-"))

          ;; arrows
          (define-key key-translation-map (kbd (format "M-[ 1 ; %d A" x)) (kbd (format "%s<up>" tkey)))
          (define-key key-translation-map (kbd (format "M-[ 1 ; %d B" x)) (kbd (format "%s<down>" tkey)))
          (define-key key-translation-map (kbd (format "M-[ 1 ; %d C" x)) (kbd (format "%s<right>" tkey)))
          (define-key key-translation-map (kbd (format "M-[ 1 ; %d D" x)) (kbd (format "%s<left>" tkey)))
          ;; home
          (define-key key-translation-map (kbd (format "M-[ 1 ; %d H" x)) (kbd (format "%s<home>" tkey)))
          ;; end
          (define-key key-translation-map (kbd (format "M-[ 1 ; %d F" x)) (kbd (format "%s<end>" tkey)))
          ;; page up
          (define-key key-translation-map (kbd (format "M-[ 5 ; %d ~" x)) (kbd (format "%s<prior>" tkey)))
          ;; page down
          (define-key key-translation-map (kbd (format "M-[ 6 ; %d ~" x)) (kbd (format "%s<next>" tkey)))
          ;; insert
          (define-key key-translation-map (kbd (format "M-[ 2 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
          ;; delete
          (define-key key-translation-map (kbd (format "M-[ 3 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
          ;; f1
          (define-key key-translation-map (kbd (format "M-[ 1 ; %d P" x)) (kbd (format "%s<f1>" tkey)))
          ;; f2
          (define-key key-translation-map (kbd (format "M-[ 1 ; %d Q" x)) (kbd (format "%s<f2>" tkey)))
          ;; f3
          (define-key key-translation-map (kbd (format "M-[ 1 ; %d R" x)) (kbd (format "%s<f3>" tkey)))
          ;; f4
          (define-key key-translation-map (kbd (format "M-[ 1 ; %d S" x)) (kbd (format "%s<f4>" tkey)))
          ;; f5
          (define-key key-translation-map (kbd (format "M-[ 15 ; %d ~" x)) (kbd (format "%s<f5>" tkey)))
          ;; f6
          (define-key key-translation-map (kbd (format "M-[ 17 ; %d ~" x)) (kbd (format "%s<f6>" tkey)))
          ;; f7
          (define-key key-translation-map (kbd (format "M-[ 18 ; %d ~" x)) (kbd (format "%s<f7>" tkey)))
          ;; f8
          (define-key key-translation-map (kbd (format "M-[ 19 ; %d ~" x)) (kbd (format "%s<f8>" tkey)))
          ;; f9
          (define-key key-translation-map (kbd (format "M-[ 20 ; %d ~" x)) (kbd (format "%s<f9>" tkey)))
          ;; f10
          (define-key key-translation-map (kbd (format "M-[ 21 ; %d ~" x)) (kbd (format "%s<f10>" tkey)))
          ;; f11
          (define-key key-translation-map (kbd (format "M-[ 23 ; %d ~" x)) (kbd (format "%s<f11>" tkey)))
          ;; f12
          (define-key key-translation-map (kbd (format "M-[ 24 ; %d ~" x)) (kbd (format "%s<f12>" tkey)))
          ;; f13
          (define-key key-translation-map (kbd (format "M-[ 25 ; %d ~" x)) (kbd (format "%s<f13>" tkey)))
          ;; f14
          (define-key key-translation-map (kbd (format "M-[ 26 ; %d ~" x)) (kbd (format "%s<f14>" tkey)))
          ;; f15
          (define-key key-translation-map (kbd (format "M-[ 28 ; %d ~" x)) (kbd (format "%s<f15>" tkey)))
          ;; f16
          (define-key key-translation-map (kbd (format "M-[ 29 ; %d ~" x)) (kbd (format "%s<f16>" tkey)))
          ;; f17
          (define-key key-translation-map (kbd (format "M-[ 31 ; %d ~" x)) (kbd (format "%s<f17>" tkey)))
          ;; f18
          (define-key key-translation-map (kbd (format "M-[ 32 ; %d ~" x)) (kbd (format "%s<f18>" tkey)))
          ;; f19
          (define-key key-translation-map (kbd (format "M-[ 33 ; %d ~" x)) (kbd (format "%s<f19>" tkey)))
          ;; f20
          (define-key key-translation-map (kbd (format "M-[ 34 ; %d ~" x)) (kbd (format "%s<f20>" tkey)))

          (setq x (+ x 1))
          ))
      )
  )
