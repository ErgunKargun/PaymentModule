package com.pm.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.pm.model.File;

/**
 * @author Ergun
 *
 */

@Repository
@Transactional
public class FileDao extends HibernateDaoSupport {

	@Autowired
	public void setSessionfactory(SessionFactory sessionFactory) {
		setSessionFactory(sessionFactory);
	}

	@Transactional(readOnly = false)
	public void insert(File file) {
		getHibernateTemplate().getSessionFactory().getCurrentSession().saveOrUpdate(file);
	}

	@Transactional(readOnly = false)
	public void update(File file) {
		getHibernateTemplate().update(file);
	}

	@Transactional(readOnly = false)
	public void delete(File file) {
		getHibernateTemplate().delete(file);
	}
	
	@Transactional(readOnly = false)
	public File getFileBySerialId(String serialId) {
		return getHibernateTemplate().get(File.class, serialId);
	}

	@Transactional(readOnly = false)
	@SuppressWarnings({ "unchecked" })
	public List<File> getAllFilesOfUserByAdminEmail(String adminEmail) {
		return (List<File>) getHibernateTemplate().getSessionFactory().getCurrentSession()
				.createQuery("from File where adminEmail = '" + adminEmail + "'").list();
	}
}