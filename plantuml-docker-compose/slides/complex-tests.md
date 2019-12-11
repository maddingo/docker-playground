# Complex test scenarios
---
## Requirements
- Executable with Maven
- Runs on developer machine
- Runs on both Windows and Linux
- Uses Junit 4 (test reports, well understood by developers)
- Need test classification
    - `lengthy` for weekly tests
    - `single`, those that affect all of EC, like Object Partitioning
    - `ui`, for selenium tests

---
## Analysis of Manual test
- Benefit = Complexity × Execution_Time
---
## Missing Pieces
- Multi-host cluster with SSL
- Kerberos/SSO Environment
- Network traffic shaping
- OPC server that can be automated
- Environments of old versions
- Download of files from browser (log files, reports etc.)
- Integration tests for non-selenium tests
    - conventions for parameters
    - infrastructure (where in the Jenkins pipeline, how to provision)

---
## ECPT-1234

[![UML](http://localhost:8080/svg/LOmn3iCW34Ltdy8ZkK8wTEmbAY4BdCGIDHIxaUZfmzYE__sdPqxT0MJ3yEZKZbE-A6fEfN2-B-W7AuR1jW3YsdfDR8RpVMeMsZkzx0PSZ35e_NEgbZ5tZCRl3slY694qJq39vHGV4_mqPcy3CA_j0W00)](http://localhost:8080/uml/LOmn3iCW34Ltdy8ZkK8wTEmbAY4BdCGIDHIxaUZfmzYE__sdPqxT0MJ3yEZKZbE-A6fEfN2-B-W7AuR1jW3YsdfDR8RpVMeMsZkzx0PSZ35e_NEgbZ5tZCRl3slY694qJq39vHGV4_mqPcy3CAyDBW00)
