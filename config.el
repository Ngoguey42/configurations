
(add-to-list 'load-path "~/.scripts/web-mode/")

(load "header.el")
;; (load "comments.el")

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

(setq line-number-mode t)
(setq column-number-mode t)
