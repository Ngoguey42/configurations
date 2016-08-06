;;****************************************************************************;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   my_config.el                                       :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2016/04/19 09:50:58 by ngoguey           #+#    #+#             ;;
;;   Updated: 2016/08/06 09:29:49 by ngoguey          ###   ########.fr       ;;
;;                                                                            ;;
;;****************************************************************************;;

;; ************************************************************************** ;;
;; modes ******************************************************************** ;;
;; ************************************************************************** ;;

;;yaml-mode(major)
(defvar yamlmode_path (concat confPath "/yaml-mode/"))
(add-to-list 'load-path yamlmode_path)
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
;;/yaml-mode

;;dart-mode(major)
(defvar dashdotel_path (concat confPath "/dash.el/"))
(add-to-list 'load-path dashdotel_path)

(defvar flycheck_path (concat confPath "/flycheck/"))
(add-to-list 'load-path flycheck_path)

(defvar seqdotel_path (concat confPath "/seq.el/"))
(add-to-list 'load-path seqdotel_path)


(defvar let-alist_path (concat confPath "/let-alist-1.0.4/"))
(add-to-list 'load-path let-alist_path)


(defvar dartmode_path (concat confPath "/dart-mode/"))
(add-to-list 'load-path dartmode_path)
(require 'dart-mode)
(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))
;;/dart-mode

;;scala-mode2(major)
(defvar scalamode2_path (concat confPath "/scala-mode2/"))
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
(defvar dockerfilemode_path (concat confPath "/dockerfile-mode/"))
(add-to-list 'load-path dockerfilemode_path)
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
;;/dockerfile-mode

;;markdown-mode(major)
(defvar markdownmode_path (concat confPath "/markdown-mode/"))
(add-to-list 'load-path markdownmode_path)
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;;/markdown-mode

;;nasm-mode
(defvar nasmmode_path (concat confPath "/nasm-mode/Matthieu-Hauglustaine-nasm-mode.el"))
(autoload 'nasm-mode nasmmode_path "" t)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))
(add-hook
 'nasm-mode-hook
 (lambda () (setq-default nasm-basic-offset 4)))
;;/nasm-mode

;;web-mode
(defvar webmode_path (concat confPath "/web-mode/"))
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
(defvar tuareg_path (concat confPath "/tuareg/"))
(add-to-list 'load-path tuareg_path)

(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
;; (autoload 'camldebug "camldebug" "Run the Caml debugger" t)
;; (autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
;;   "Configuration of imenu for tuareg" t)

;; (add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(add-hook
 'tuareg-mode-hook
 (lambda ()
   (setq-default indent-tabs-mode nil)
   (setq-default tab-width 2)
   ))

(setq
 auto-mode-alist
 (append
  '(("\\.ml[ily]?$" . tuareg-mode)
    ("\\.eliom$" . tuareg-mode)
    ("\\.topml$" . tuareg-mode))
  auto-mode-alist))
;;/tuareg

;;glsl-mode
(defvar glslmode_path (concat confPath "/glsl-mode/"))
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
(defvar luamode_path (concat confPath "/lua-mode/"))
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
   (setq indent-tabs-mode t)
   (setq tab-width 4)
   (setq python-indent 4)))
;;/python

;;cuda
(add-to-list 'auto-mode-alist '("\\.cu$" . c-mode))
;;/cuda

;;c
(add-to-list 'auto-mode-alist '("\\.inl$" . c-mode))
;;/c

;;c++
(add-to-list 'auto-mode-alist '("\\.tpp$" . c++-mode))
(c-set-offset 'innamespace 0)
(load "my_cpptemplates.el")
;;/c++

;;fci-mode (minor)
;; (defvar fci_path (concat confPath "/Fill-Column-Indicator/"))
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
(defvar siteLispDir42 (concat confPath "/davidGironLisp"))
(add-to-list 'load-path siteLispDir42)
(load "header.el")
;;/42 site-lisp

;; shell-command configuration
(setq shell-file-name "zsh")
(setq shell-command-switch "-ic")
;; /shell-command configuration

;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Choosing-Window-Options.html
(setq split-height-threshold nil)
(setq split-width-threshold 80)

(load "my_bindings.el")

;;TODO: set those 4 lines as c-mode only
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")

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


(set-face-attribute  'mode-line
                     nil
                     :foreground "blue"
                     :background "snow2"
                     :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line-inactive
                     nil
                     :foreground "black"
                     :background "purple"
                     :box '(:line-width 1 :style released-button))

;; (transient-mark-mode 1)

;; (ido-mode 1)
;; (setq ido-separator "\n")

;; ************************************************************************** ;;
;; /MISC ******************************************************************** ;;
;; ************************************************************************** ;;
