;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    my_config.el                                       :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/02/12 07:33:57 by ngoguey           #+#    #+#              ;
;    Updated: 2015/08/10 14:38:31 by ngoguey          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

(add-to-list 'load-path "/usr/share/emacs/site-lisp/")


(load "my_bindings.el")
(load "header.el")
(load "my_cpptemplates.el")
;; (load "comments.el")
(add-to-list 'auto-mode-alist '("\\.cu$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.tpp$" . c++-mode))

;;nasm-mode, not mine
(autoload 'nasm-mode "~/configurations/Matthieu-Hauglustaine-nasm-mode.el" "" t)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))
(add-hook 'nasm-mode-hook
		  (lambda () (setq-default nasm-basic-offset 4)))
;;/nasm-mode


;;web-mode, not mine
(add-to-list 'load-path "~/configurations/web-mode/")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . web-mode))

(set-face-attribute 'web-mode-html-tag-face nil :foreground "MediumSlateBlue")
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "SteelBlue")
;;/web-mode


;;tuareg
(add-to-list 'load-path "~/configurations/tuareg/")

(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
  "Configuration of imenu for tuareg" t)

(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)

(setq auto-mode-alist
	  (append '(("\\.ml[ily]?$" . tuareg-mode)
				("\\.topml$" . tuareg-mode))
			  auto-mode-alist))
;;/tuareg


;;glsl-mode
(add-to-list 'load-path "~/configurations/glsl-mode/")

(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))

;;/glsl-mode

(add-hook 'python-mode-hook
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
