;;****************************************************************************;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   my_bindings.el                                     :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2016/04/19 09:55:30 by ngoguey           #+#    #+#             ;;
;;                                                                            ;;
;;****************************************************************************;;
0;10;1c
(load "my_functions.el")

;; ************************************************************************** ;;
;; ARROWS CONFIGURATION ***************************************************** ;;
;; ************************************************************************** ;;

;; (up)                              charup
;; (down)                            chardown
;; (right)                           charright
;; (left)                            charleft
;; (pgup)                            scroll
;; (pgdown)                          scroll

;; (meta up)                         ??
;; (meta down)                       ??
;; (meta right)                      right word(default)
;; (meta left)                       left word(default)
;; (meta pgup)                       scroll in other buffer
;; (meta pgdown)                     scroll in other buffer

;; (shift up)                        selection(default)
;; (shift down)                      selection(default)
;; (shift right)                     selection(default)
;; (shift left)                      selection(default)
;; (shift pgup)                      ??
;; (shift pgdown)                    ??

;; (control up)                      (macos hook)(mintty quick move)(linux ?)
;; (control down)                    (macos hook)(mintty quick move)(linux ?)
;; (control right)                   (macos hook)(mintty quick move)(linux ?)
;; (control left)                    (macos hook)(mintty quick move)(linux ?)
;; (control pgup)                    ??
;; (control pgdown)                  ??

;; (control x) (up)                  ??
;; (control x) (down)                ??
;; (control x) (right)               next-buffer(default)
;; (control x) (left)                prev-buffer(default)
;; (control x) (pgup)                ??
;; (control x) (pgdown)              ??

;; (control c) (up)                  windmove-up
;; (control c) (down)                windmove-down
;; (control c) (right)               windmove-right
;; (control c) (left)                windmove-left
;; (control c) (pgup)                ??
;; (control c) (pgdown)              ??

;; (control h) (up)                  ??
;; (control h) (down)                ??
;; (control h) (right)               ??
;; (control h) (left)                ??
;; (control h) (pgup)                ??
;; (control h) (pgdown)              ??

;; (control c) (control x) (up)      buf-move-up
;; (control c) (control x) (down)    buf-move-down
;; (control c) (control x) (right)   buf-move-right
;; (control c) (control x) (left)    buf-move-left
;; (control c) (control x) (pgup)    ??
;; (control c) (control x) (pgdown)  ??

;;buffer-move
(load "vendored/buffer-move/buffer-move.el")
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
;; BLOCK 1/3 ******************************************** **

(global-set-key [(f1)] 'ft-persp-activate-f1)
(global-set-key [(f2)] 'ft-persp-activate-f2)

(global-set-key [(meta f1)] 'hs-toggle-hiding)
(global-set-key [?\e f1] 'hs-hide-all)
(global-set-key [?\e f2] 'hs-show-all)

;; (global-set-key [(f2)] '(lambda() "tab shortcut" (interactive) (insert "\t")))
;; (global-set-key [(control f2)] 'ft-indent-buffer)

(global-set-key [(f3)] 'ft-put-debug1)
;; (global-set-key [(shift f3)] 'ft-put-debug2)
;; (global-set-key [(control f3)] 'ft-put-debug3)
;; (global-set-key [?\e f3] 'ft-put-debug4)

;; BLOCK 2/3 ******************************************** **
(global-set-key [(f5)] 'ft-toggle-comment-on-line)
(global-set-key [(f6)] 'comment-or-uncomment-region)
(global-set-key [(f7)] 'replace-string)
(global-set-key [(f8)] 'goto-line)

;; BLOCK 3/3 ******************************************** **
(global-set-key [(f9)] 'ft-persp-activate-new)
(global-set-key [(control f9)] 'ft-star-to-80)
(global-set-key [f11] 'ft-swap-line-up)
(global-set-key [f12] 'ft-swap-line-down)

;; ************************************************************************** **

;; ************************************************************************** ;;
;; /F* KEYS ***************************************************************** ;;
;; ************************************************************************** ;;
(global-unset-key (kbd "ESC ESC ESC"))
(global-set-key (kbd "<kp-enter>") "\C-m")
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)
