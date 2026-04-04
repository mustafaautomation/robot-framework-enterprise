# Robot Framework Enterprise

[![Tests](https://github.com/mustafaautomation/robot-framework-enterprise/actions/workflows/tests.yml/badge.svg)](https://github.com/mustafaautomation/robot-framework-enterprise/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Robot Framework](https://img.shields.io/badge/Robot_Framework-7.1-00B0D8.svg)](https://robotframework.org)
[![Python](https://img.shields.io/badge/Python-3.12-3776AB.svg?logo=python&logoColor=white)](https://python.org)

Enterprise-grade Robot Framework test automation covering E2E browser testing (SeleniumLibrary) and API testing (RequestsLibrary). Page Object Model architecture, data-driven tests, and CI/CD integration.

---

## Test Coverage

| Suite | Tests | Target | Tags |
|-------|-------|--------|------|
| Login | 5 | SauceDemo | smoke |
| Inventory | 6 | SauceDemo | regression |
| Checkout | 3 | SauceDemo | regression |
| Users API | 6 | reqres.in | api |
| **Total** | **20** | | |

---

## Quick Start

```bash
# Clone
git clone https://github.com/mustafaautomation/robot-framework-enterprise.git
cd robot-framework-enterprise

# Install
pip install -r requirements.txt

# Run API tests (no browser needed)
robot --outputdir results --include api tests/api/

# Run all tests (requires Chrome/Chromium)
robot --outputdir results tests/

# Run by tag
robot --outputdir results --include smoke tests/
```

---

## Architecture

```
┌─────────────────────────────────────────────────┐
│              Test Suites                         │
│   Login │ Inventory │ Checkout │ Users API       │
├─────────────────────────────────────────────────┤
│              Keywords Layer                      │
│   Common │ API │ Page-specific keywords          │
├─────────────────────────────────────────────────┤
│              Page Objects                        │
│   LoginPage │ InventoryPage │ CartPage │ ...     │
├─────────────────────────────────────────────────┤
│              Resources                           │
│   Variables │ Test Data │ Browser Config         │
├─────────────────────────────────────────────────┤
│              Libraries                           │
│   SeleniumLibrary │ RequestsLibrary │ pabot      │
└─────────────────────────────────────────────────┘
```

---

## Page Object Model

Each page has its own resource file with:
- **Variables** — CSS/XPath selectors
- **Keywords** — Page-specific actions and assertions

```robot
*** Settings ***
Resource    resources/pages/login_page.robot

*** Test Cases ***
Valid Login
    Open Login Page
    Login With Credentials    standard_user    secret_sauce
    Login Should Succeed
```

---

## Commands

| Command | Description |
|---|---|
| `robot --outputdir results tests/` | Run all tests |
| `robot --include smoke tests/` | Run smoke tests only |
| `robot --include api tests/api/` | Run API tests only |
| `robot --include regression tests/e2e/` | Run regression suite |
| `pabot --processes 4 tests/` | Parallel execution (4 workers) |
| `robot --dryrun tests/` | Validate syntax without running |

---

## Docker

```bash
docker build -t rf-enterprise .
docker run --rm -v $(pwd)/results:/app/results rf-enterprise
docker run --rm -v $(pwd)/results:/app/results rf-enterprise --include api tests/api/
```

---

## Project Structure

```
robot-framework-enterprise/
├── resources/
│   ├── variables.robot              # Global variables (URLs, credentials, timeouts)
│   ├── pages/
│   │   ├── login_page.robot         # Login page object
│   │   ├── inventory_page.robot     # Inventory page object
│   │   ├── cart_page.robot          # Cart page object
│   │   └── checkout_page.robot      # Checkout page object
│   ├── keywords/
│   │   ├── common.robot             # Browser setup/teardown
│   │   └── api.robot                # API session and request helpers
│   └── data/
│       └── users.robot              # Test data constants
├── tests/
│   ├── e2e/
│   │   ├── login.robot              # 5 login scenarios
│   │   ├── inventory.robot          # 6 inventory scenarios
│   │   └── checkout.robot           # 3 checkout scenarios
│   └── api/
│       └── users_api.robot          # 6 API test cases
├── results/                         # Test output (gitignored)
├── requirements.txt                 # Python dependencies
├── Dockerfile
└── .github/workflows/tests.yml
```

---

## License

MIT

---

Built by [Quvantic](https://quvantic.com)
