*** Variables ***
# SauceDemo users
@{VALID_USERS}        standard_user    problem_user    performance_glitch_user    visual_user
@{INVALID_USERS}      locked_out_user    invalid_user

# Checkout data
${CHECKOUT_FIRST}     Test
${CHECKOUT_LAST}      User
${CHECKOUT_ZIP}       12345

# API test data
&{NEW_USER}           name=Test User    job=QA Engineer
&{UPDATE_USER}        name=Updated User    job=Senior QA
