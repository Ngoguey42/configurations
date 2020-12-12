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
