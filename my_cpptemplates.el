;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    my_cpptemplates.el                                 :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/03/05 07:55:56 by ngoguey           #+#    #+#              ;
;    Updated: 2015/03/05 08:09:11 by ngoguey          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

(defun canonical-hpp (classname)
  "canonical-hpp"
  (interactive "sEnter class' name: ")

  (insert "
#ifndef " (upcase classname) "_CLASS_HPP
# define " (upcase classname) "_CLASS_HPP

class " classname "
{
public:
	" classname "(void);
	~" classname "(void);
	" classname "(" classname " const & src);
	" classname " &			operator=(" classname " const & rhs);

private:
	" "
};

#endif
"
)
  (sit-for 0.1)
  (header-insert)
  (goto-line 19)
  (move-end-of-line 1)
  (backward-char)
  (backward-char)
  )

(global-set-key (kbd "<f2>") 'canonical-hpp)

(defun stdcout-hpp()
  "stdcout-hpp"
  (interactive)
  (previous-line)
  (move-end-of-line 1)
  (newline)
  (insert
   "std::cout <<  << std::endl;")
  (indent-according-to-mode)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  )

(global-set-key (kbd "<f1>") 'stdcout-hpp)
