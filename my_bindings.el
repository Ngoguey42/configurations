;;****************************************************************************;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   my_bindings.el                                     :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2016/04/19 09:55:30 by ngoguey           #+#    #+#             ;;
;;   Updated: 2016/10/27 13:01:22 by ngoguey          ###   ########.fr       ;;
;;                                                                            ;;
;;****************************************************************************;;

(load "my_functions.el")

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

;; (control up)                      (macos hook)(mintty )
;; (control down)                    (macos hook)(mintty )
;; (control right)                   (macos hook)(mintty )
;; (control left)                    (macos hook)(mintty )


;;buffer-move
(load "buffer-move/buffer-move.el")
(global-set-key [(control c) (control x) (up)] 'buf-move-up)
(global-set-key [(control c) (control x) (down)] 'buf-move-down)
(global-set-key [(control c) (control x) (right)] 'buf-move-right)
(global-set-key [(control c) (control x) (left)] 'buf-move-left)
;;/buffer-move

;;windmove
(global-set-key [(control c) (up)] 'windmove-up)
(global-set-key [(control c) (down)] 'windmove-down)
(global-set-key [(control c) (right)] 'windmove-right)
(global-set-key [(control c) (left)] 'windmove-left)
;;/windmove

;; ************************************************************************** ;;
;; /ARROWS CONFIGURATION **************************************************** ;;
;; ************************************************************************** ;;

;; ************************************************************************** ;;
;; F* KEYS ****************************************************************** ;;
;; ************************************************************************** ;;
;; depredated, TODO: update

;; (f1)                              ft-put-debug1
;; (f2)                              tab
;; (f3)                              comment line
;; (f4)                              comment region
;; (f5)                              replace-string
;; (f6)                              goto-line
;; (f7)                              ??
;; (f8)                              ??
;; (f9)                              ??
;; (f10)                             ??
;; (f11)                             ??
;; (f12)                             ??

;; (meta f1)                         show bindings(default)
;; (meta f2)                         ??
;; (meta f3)                         ft-swap-line-up
;; (meta f4)                         ft-swap-line-down
;; (meta f5)                         ??
;; (meta f6)                         ??
;; (meta f7)                         ??
;; (meta f8)                         ??
;; (meta f9)                         ??
;; (meta f10)                        ??
;; (meta f11)                        ??
;; (meta f12)                        ??

;; (control f1)                      ??
;; (control f2)                      indent buffer
;; (control f3)                      ??
;; (control f4)                      ??
;; (control f5)                      ??
;; (control f6)                      ??
;; (control f7)                      ??
;; (control f8)                      ??
;; (control f9)                      ft-star-to-80
;; (control f10)                     ??
;; (control f11)                     ??
;; (control f12)                     ??


(global-set-key [(f2)] '(lambda() "tab shortcut" (interactive) (insert "\t")))
(global-set-key [(f3)] 'ft-put-debug1)

(global-set-key [(f5)] 'ft-toggle-comment-on-line)
(global-set-key [(f6)] 'comment-or-uncomment-region)
(global-set-key [(f7)] 'replace-string)
(global-set-key [(f8)] 'goto-line)

(global-set-key [?\e f3] 'ft-swap-line-up)
(global-set-key [?\e f4] 'ft-swap-line-down)

(global-set-key [(control f2)] 'ft-indent-buffer)
(global-set-key [(control f9)] 'ft-star-to-80)


;; (global-set-key (kbd "<kp-7>") "\C-a\C- \C-n\M-w\C-y\C-p")
;; (global-set-key (kbd "<kp-1>") "\C-a\C-k\177\C-a\C-n")
;; (global-set-key (kbd "<kp-0>") "\C-a\C-m\C-a\C-b\C-y\C-a")

;; (global-set-key (kbd "<kp-5>") "\M-;")

(global-set-key [(f9)] 'forward-paragraph)
(global-set-key [(f10)] 'backward-paragraph)


;; ************************************************************************** ;;
;; /F* KEYS ***************************************************************** ;;
;; ************************************************************************** ;;

(global-set-key (kbd "<kp-enter>") "\C-m")
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)
(global-set-key (kbd "C-x C-g") 'ft-rename-file-and-buffer)
