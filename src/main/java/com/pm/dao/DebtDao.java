package com.pm.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.pm.model.Debt;

/**
 * @author Ergun
 *
 */

@Repository
@Transactional
public class DebtDao extends HibernateDaoSupport {
	
	@Autowired
	public void setSessionfactory(SessionFactory sessionFactory) {
		setSessionFactory(sessionFactory);
	}

	@Transactional(readOnly = false)
	public void insert(Debt debt) {		
		getHibernateTemplate().saveOrUpdate(debt);
	}

	@Transactional(readOnly = false)
	public void update(Debt debt) {
		getHibernateTemplate().update(debt);
	}

	@Transactional(readOnly = false)
	public void delete(Debt debt) {
		getHibernateTemplate().delete(debt);
	}

	@Transactional(readOnly = false)
	public Debt getDebtBySerialno(String debt_serialno) {
		return getHibernateTemplate().get(Debt.class, debt_serialno);
	}

	@Transactional(readOnly = false)
	@SuppressWarnings({ "unchecked" })
	public List<Debt> getAllDebtsByTc(String userTc) {
		String query = "from Debt where tc = :tc";		
		return (List<Debt>) getHibernateTemplate().getSessionFactory().getCurrentSession().createQuery(query).setParameter("tc", userTc).list();
		//return (List<Debt>) getHibernateTemplate().getSessionFactory().getCurrentSession().createQuery("from Debt where tc = '" + userTc + "'").list();
	}
}
