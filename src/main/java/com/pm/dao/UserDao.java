package com.pm.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.pm.model.User;

/**
 * @author Ergun
 *
 */

@Repository
@Transactional
public class UserDao extends HibernateDaoSupport {
	
	@Autowired
	public void setSessionfactory(SessionFactory sessionFactory) {
		setSessionFactory(sessionFactory);
	}

	@Transactional(readOnly = false)
	public void insert(User user) {	
		getHibernateTemplate().getSessionFactory().getCurrentSession().saveOrUpdate(user);
	}

	@Transactional(readOnly = false)
	public void update(User user) {
		getHibernateTemplate().update(user);
	}

	@Transactional(readOnly = false)
	public void delete(User user) {
		getHibernateTemplate().delete(user);
	}

	@Transactional(readOnly = false)
	public User getUserByTc(String tc) {
		return getHibernateTemplate().get(User.class, tc);
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = false)
	public List<User> getUserByEmail(String email) {
		//return getHibernateTemplate().get(User.class, email);
		return (List<User>) getHibernateTemplate().getSessionFactory().getCurrentSession().createQuery("from User where email = '" + email + "'").list();
	}

	@Transactional(readOnly = false)
	@SuppressWarnings({ "unchecked" })	
	public List<User> getAllUsersByAdminEmail(String adminEmail) {
		return (List<User>) getHibernateTemplate().getSessionFactory().getCurrentSession().createQuery("from User where adminEmail = '" + adminEmail + "'").list();
	}		
}
