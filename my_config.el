;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    my_config.el                                       :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/02/12 07:33:57 by ngoguey           #+#    #+#              ;
;    Updated: 2015/03/23 14:34:10 by ngoguey          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(add-to-list 'load-path "~/configurations/web-mode/")

(load "my_bindings.el")
(load "header.el")
(load "my_cpptemplates.el")
;; (load "comments.el")


;;nasm-mode, not mine
(autoload 'nasm-mode "~/configurations/Matthieu-Hauglustaine-nasm-mode.el" "" t)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))
(add-hook 'nasm-mode-hook
		  (lambda () (setq-default nasm-basic-offset 4)))
;;/nasm-mode


;;web-mode, not mine
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.cu$" . c-mode))

(set-face-attribute 'web-mode-html-tag-face nil :foreground "MediumSlateBlue")
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "SteelBlue")
(setq web-mode-markup-indent-offset 2)
;;/web-mode


(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")

(setq line-number-mode t)
(setq column-number-mode t)
