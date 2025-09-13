package com.hevlar.api.repository;

import com.hevlar.api.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.UUID;

@RepositoryRestResource
public interface EmployeeRepository extends JpaRepository<Employee, UUID> {
}
