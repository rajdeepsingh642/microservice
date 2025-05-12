package com.staxrt.tutorial.repository;

import com.staxrt.tutorial.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * The interface User repository.
 *
 * @author Saurabh Sharma
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {}
