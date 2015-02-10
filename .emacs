;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    .emacs                                             :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/02/09 15:34:40 by ngoguey           #+#    #+#              ;
;    Updated: 2015/02/10 09:13:33 by ngoguey          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

(setq config_files "/usr/share/emacs/site-lisp/")
(setq load-path (append (list nil config_files) load-path))
(add-to-list 'load-path "~/.scripts/web-mode/")


(load "header.el")
;; (load "comments.el")


;;http://web-mode.org/
;; (set 'nxml-path (concat site-lisp-path "nxml-mode/"))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.cu$" . c-mode))
(set-face-attribute 'web-mode-html-tag-face nil :foreground "MediumSlateBlue")
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "SteelBlue")

(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)


(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))




(setq line-number-mode t)
(setq column-number-mode t)

(global-set-key (kbd "<kp-7>") "\C-a\C- \C-n\M-w\C-y\C-p")
(global-set-key (kbd "<kp-8>") 'replace-string)
(global-set-key (kbd "<kp-9>") 'goto-line)

(global-set-key (kbd "<kp-1>") "\C-a\C-k\177\C-a\C-n")
(global-set-key (kbd "<kp-4>") "\C-y")
(global-set-key (kbd "<kp-0>") "\C-a\C-m\C-b\C-y\C-a")
(global-set-key (kbd "<kp-5>") 'yank-pop)

(global-set-key (kbd "<kp-3>") 'toggle-comment-on-line)
(global-set-key (kbd "<kp-6>") 'comment-or-uncomment-region)
(global-set-key (kbd "<kp-5>") "\M-;")


(global-set-key (kbd "<kp-add>") 'forward-paragraph)
(global-set-key (kbd "<kp-subtract>") 'backward-paragraph)
(global-set-key (kbd "<kp-enter>") "\C-m")
