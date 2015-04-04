// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   Form.hpp                                           :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2015/03/13 16:06:23 by ngoguey           #+#    #+#             //
//   Updated: 2015/04/04 14:43:34 by ngoguey          ###   ########.fr       //
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

namespace bordel
{
class Form : virtual public TrucMachin , public lol
{
	int salutlol;
public:
	Form();
	int AForm (void) ;
	virtual ~Form();

	Form(std::string const &name, int sGrade, int eGrade);

	static const int			highestGrade;
	static const int			lowestGrade;
	static const int			lowestGrade2[42];
	static const int			lowestGrades(int lol);
	static void			lowestGrades(int lol3);
	static void			*lowestGrades(int lol3, int caca, char *truc);
	static void			*lowestGrades(int lol3, std::string const &salut, char *truc);
	
	const int			lowestGrades(int lol);
	void			lowestGrades(int lol3);
	void			*lowestGrades(int lol3, int caca, char *truc);
	virtual void			*lowestGrades(int lol3, std::string const &salut, char *truc);
	
	std::string const			&getName(void) const;
	virtual std::string const			&getNameTruc(void) const = 0;
	int const					getSGrade(void) const;
	int const					getEGrade(void) const;
	int const					getEGradestatic(void) const;
	bool						getIsSigned(void) const;
	void						setIsSigned(bool truc) const;
	static  const char *what2() const throw(int salut, hello lol, hello loli);
	
	virtual const char *what() const throw(int salut, hello lol);
	
	void	*test(void) {
		if () {void 1;}
		return ;
		}
	
	void	*test2(void) {}
	
	class GradeTooHighException : public std::exception
	{
	public:
		GradeTooHighException() throw(); //
		virtual ~GradeTooHighException() throw(); /* bjr*/
		GradeTooHighException(GradeTooHighException const &src) throw();
		void	*test2(void) {}
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
	std::string					_data;
	int const					_sGrade;
	int constatic				_sGrade;
	int const					_eGrade;
	bool						_isSigned;
};
std::ostream					&operator<<(std::ostream &o, Form const &rhs);
}
#endif // ********************************************************** FORM_HPP //
