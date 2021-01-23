;;****************************************************************************;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   .emacs                                             :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2015/02/09 15:34:40 by ngoguey           #+#    #+#             ;;
;;                                                                            ;;
;;****************************************************************************;;

;; (setq config_files "~/configurations/")
;; (defvar confPath "~/configurations")
(defvar confPath (getenv "NGOCONF_PATH"))
;; (defvar confPath "/Volumes/Storage/goinfre/ngoguey/configurations")
;; (setq load-path (append (list nil config_files) load-path))
(setq load-path (append (list nil confPath) load-path))
(load "my_config.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(smerge-base ((t (:background "color-58"))))
 '(smerge-lower ((t (:background "color-22"))))
 '(smerge-markers ((t (:background "color-17"))))
 '(smerge-refined-added ((t (:inherit smerge-refined-change :background "color-28"))))
 '(smerge-refined-removed ((t (:inherit smerge-refined-change :background "color-88"))))
 '(smerge-upper ((t (:background "color-52")))))
