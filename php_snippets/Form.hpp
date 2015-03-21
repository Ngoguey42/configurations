// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   Form.hpp                                           :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/03/13 16:06:23 by ngoguey           #+#    #+#             //
//   Updated: 2015/03/13 16:26:28 by ngoguey          ###   ########.fr       //
//                                                                            //
// ************************************************************************** //



/*
test

// */

// lol test

#ifndef FORM_HPP
# define FORM_HPP

# include <iostream> //lol
# include <stdexcept>

class Form : virtual public TrucMachin , public lol
{
	int salutlol;
public:
	Form();
	virtual ~Form();

	Form(std::string const &name, int sGrade, int eGrade);

	static const int			highestGrade;
	static const int			lowestGrade;
	
	std::string const			&getName(void) const;
	int const					getSGrade(void) const;
	int const					getEGrade(void) const;
	bool						getIsSigned(void) const;

	class GradeTooHighException : public std::exception
	{
	public:
		GradeTooHighException() throw(); //
		virtual ~GradeTooHighException() throw(); /* bjr*/
		GradeTooHighException(GradeTooHighException const &src) throw();

		virtual const char *what() const throw();
	private:
		GradeTooHighException& operator=(GradeTooHighException const &rhs) throw();
	};
	class GradeTooLowException : public std::exception
	{
	public:
		GradeTooLowException() throw();
		virtual ~GradeTooLowException()/* bjr*/  throw();
		GradeTooLowException(GradeTooLowException const &src) throw();

		virtual const char *what() const throw();
	private:
		GradeTooLowException& operator=(GradeTooLowException const &rhs) throw();
	};

protected:
private:
	Form						&operator=(Form const &rhs);
	Form(Form const &src);

	std::string const			_name;
	int const					_sGrade;
	int const					_eGrade;
	bool						_isSigned;
};
std::ostream					&operator<<(std::ostream &o, Form const &rhs);

#endif // ********************************************************** FORM_HPP //
