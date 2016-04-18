;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    my_config.el                                       :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/02/12 07:33:57 by ngoguey           #+#    #+#              ;
;    Updated: 2016/04/04 06:53:07 by ngoguey          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;


;;42 site-lisp
(defvar siteLispDir42 "/usr/share/emacs/site-lisp/")
(add-to-list 'load-path siteLispDir42)
(when (file-exists-p (concat siteLispDir42 "header.el"))
  (load "header.el"))
;;/42 site-lisp


(load "my_bindings.el")
;; (load "header.el")
(load "my_cpptemplates.el")
;; (load "comments.el")
(add-to-list 'auto-mode-alist '("\\.cu$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.tpp$" . c++-mode))

;;nasm-mode
(defvar nasmmode_path (concat confPath "/Matthieu-Hauglustaine-nasm-mode.el"))
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
   (setq indent-tabs-mode nil)
   (setq tab-width 2)
   ))

;;/emacs-lisp-mode-hook


;;tuareg
(defvar tuareg_path (concat confPath "/tuareg/"))
(add-to-list 'load-path tuareg_path)

(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
;; (autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
;;   "Configuration of imenu for tuareg" t)

;; (add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(add-hook
 'tuareg-mode-hook
 (lambda ()
   (setq-default indent-tabs-mode nil)
   (setq-default tab-width 2)
   ;; (add-to-list 'write-file-functions 'delete-trailing-whitespace)
   ))

(setq
 auto-mode-alist
 (append
  '(("\\.ml[ily]?$" . tuareg-mode)
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

(add-hook
 'python-mode-hook
 (lambda ()
   (setq indent-tabs-mode t)
   (setq tab-width 4)
   (setq python-indent 4)))

(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")

(setq line-number-mode t)
(setq column-number-mode t)

(c-set-offset 'innamespace 0)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq
 completion-ignored-extensions
 (append
  completion-ignored-extensions
  (quote
   (".cmx"  ".cmi"  ".cmo" ))))
(c-set-offset 'inextern-lang 0)



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
