;;****************************************************************************;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   my_config.el                                       :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2016/04/19 09:50:58 by ngoguey           #+#    #+#             ;;
;;   Updated: 2016/05/20 09:57:17 by ngoguey          ###   ########.fr       ;;
;;                                                                            ;;
;;****************************************************************************;;

;; ************************************************************************** ;;
;; modes ******************************************************************** ;;
;; ************************************************************************** ;;

;;markdown-mode(major)
(defvar markdownmode_path (concat confPath "/markdown-mode/"))
(add-to-list 'load-path markdownmode_path)
(require 'markdown-mode)
;; (defvar markdownmode_path (concat confPath "/markdown-mode/"))
;; (autoload 'markdown-mode markdownmode_path "" t)
;; (autoload 'markdown-mode "markdown-mode"
;;   "Major mode for editing Markdown files" t)
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

(set-face-attribute 'web-mode-html-tag-face nil :foreground "MediumSlateBlue")
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "SteelBlue")
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
(defvar fci_path (concat confPath "/Fill-Column-Indicator/"))
(add-to-list 'load-path fci_path)
(require 'fill-column-indicator)
(define-globalized-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
(setq fci-rule-column 80)
(setq fci-rule-color "#181818")
(global-fci-mode t)
;;/fci-mode (minor)

;; ************************************************************************** ;;
;; /modes ******************************************************************* ;;
;; ************************************************************************** ;;

;;TODO: move to my_bindings.el
;; ************************************************************************** ;;
;; ARROWS CONFIGURATION ***************************************************** ;;
;; ************************************************************************** ;;

;; (control x) (up)                  ??
;; (control x) (down)                ??
;; (control x) (right)               next-buffer(default)
;; (control x) (left)                prev-buffer(default)

;; (control c) (up)                  windmove-up
;; (control c) (down)                windmove-down
;; (control c) (right)               windmove-right
;; (control c) (left)                windmove-left

;; (control h) (up)                  ??
;; (control h) (down)                ??
;; (control h) (right)               ??
;; (control h) (left)                ??

;; (control c) (control x) (up)      buf-move-up
;; (control c) (control x) (down)    buf-move-down
;; (control c) (control x) (right)   buf-move-right
;; (control c) (control x) (left)    buf-move-left

;; (meta x) (up)                     ??
;; (meta x) (down)                   ??
;; (meta x) (right)                  right word(default)
;; (meta x) (left)                   left word(default)

;; (shift up)                        selection(default)
;; (shift down)                      selection(default)
;; (shift right)                     selection(default)
;; (shift left)                      selection(default)

;; (control up)                      none(macos hook)
;; (control down)                    none(macos hook)
;; (control right)                   none(macos hook)
;; (control left)                    none(macos hook)


;;buffer-move
(load "buffer-move/buffer-move.el")
(global-set-key [(control c) (control x) (up)]   'buf-move-up)
(global-set-key [(control c) (control x) (down)]   'buf-move-down)
(global-set-key [(control c) (control x) (right)]   'buf-move-right)
(global-set-key [(control c) (control x) (left)]   'buf-move-left)
;;/buffer-move

;;windmove
(global-set-key [(control c) (up)]   'windmove-up)
(global-set-key [(control c) (down)]   'windmove-down)
(global-set-key [(control c) (right)]   'windmove-right)
(global-set-key [(control c) (left)]   'windmove-left)
;;/windmove

;; ************************************************************************** ;;
;; /ARROWS CONFIGURATION **************************************************** ;;
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

;;TODO: move to my_bindings.el
(global-set-key
 (kbd "C-c C-t")
 (lambda()
   "replace spaces"
   (interactive)
   (revert-buffer t t)
   (read-only-mode 1)
   (custom-set-faces
    '(default ((t (:inherit nil :stipple nil :background "color-234" :foreground "unspecified-fg" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default")))))
   ))


;; (ido-mode 1)
;; (setq ido-separator "\n")
