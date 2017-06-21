package com.pm.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.pm.model.Role;

/**
 * @author Ergun
 *
 */

@Repository
@Transactional
public class RoleDao extends HibernateDaoSupport {

	@Autowired
	public void setSessionfactory(SessionFactory sessionFactory) {
		setSessionFactory(sessionFactory);
	}

	@Transactional(readOnly = false)
	public void insert(Role role) {
		getHibernateTemplate().getSessionFactory().getCurrentSession().saveOrUpdate(role);
	}

	@Transactional(readOnly = false)
	public void update(Role role) {
		getHibernateTemplate().update(role);
	}

	@Transactional(readOnly = false)
	public void delete(Role role) {
		getHibernateTemplate().delete(role);
	}

	@Transactional(readOnly = false)
	@SuppressWarnings({ "unchecked" })
	public List<Role> getAllRolesOfUserByTc(String tc) {
		return (List<Role>) getHibernateTemplate().getSessionFactory().getCurrentSession()
				.createQuery("from Role where tc = '" + tc + "'").list();
	}

}
