package com.crowtor.backend.data.repository;

import com.crowtor.backend.data.models.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long> {
    Role findByName(String name);
}
