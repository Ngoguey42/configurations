;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    .emacs                                             :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/02/09 15:34:40 by ngoguey           #+#    #+#              ;
;    Updated: 2015/11/15 08:42:09 by ngoguey          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

(setq config_files "~/configurations/")
(defvar confPath "~/configurations")
(setq load-path (append (list nil config_files) load-path))
(load "my_config.el")
