package com.staxrt.tutorial.utils;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class CommaSeparatedAllowedValuesValidator implements ConstraintValidator<CommaSeparatedAllowedValues, String> {

    private Set<String> allowedValues;

    @Override
    public void initialize(CommaSeparatedAllowedValues constraintAnnotation) {
        allowedValues = new HashSet<>(Arrays.asList(constraintAnnotation.allowed()));
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null || value.isEmpty()) return true; // Handle null or blank as valid. Change if needed.

        List<String> inputValues = Arrays.asList(value.split(","));
        Set<String> invalidValues = new HashSet<>();

        for (String val : inputValues) {
            if (!allowedValues.contains(val.trim())) {
                invalidValues.add(val.trim());
            }
        }

        if (!invalidValues.isEmpty()) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate(
                "Invalid values: " + String.join(", ", invalidValues)
            ).addConstraintViolation();
            return false;
        }

        return true;
    }
}
