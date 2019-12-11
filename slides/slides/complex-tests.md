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
- Mail server
- Error injection
---
### Missing Pieces (contd.)
- cluster env for each team for sprint demo
- PI server  that can be automated
- performance testing
- several browsers for ui testing
---
### Integration tests for non-selenium tests
- conventions for parameters
- infrastructure

---
## ECPT-4091

[![UML](http://localhost:8080/svg/dP2nQiD038PtFuN6n10JoEOCfKrJQCbGwj1GyABuTFQLisJkv9YyVUsGKDgjdJH8-lJzYef1aoGlIA7l066xWShtKIcKF3Xj01KyOLJGGO35K5mdYRCmAyxZL0klGJeAUeQIAsapgZ8Rsc6iBcQFgBWFoD5IsBuyP5TouRZsfC8bHzAxEMX333EMUG9mKVd5_WTwdH0RPyTe1tGALW9ugS4xff8FJxkFpQvuNowNgnpIT8h5s5AQvbGj8eKJXKM3G9ug9GCO9qM8DpXqGKxEK02nbuw4EXkSDzQVC_eyhcuwPBBlfOdhAXhVbx_r38hr4UD8TsqdGQ_ltcDzRx0RTv_tqsJHz0f61hxScKH_-Fu95bMwBm00)](http://localhost:8080/uml/dP2nQiD038PtFuN6n10JoEOCfKrJQCbGwj1GyABuTFQLisJkv9YyVUsGKDgjdJH8-lJzYef1aoGlIA7l066xWShtKIcKF3Xj01KyOLJGGO35K5mdYRCmAyxZL0klGJeAUeQIAsapgZ8Rsc6iBcQFgBWFoD5IsBuyP5TouRZsfC8bHzAxEMX333EMUG9mKVd5_WTwdH0RPyTe1tGALW9ugS4xff8FJxkFpQvuNowNgnpIT8h5s5AQvbGj8eKJXKM3G9ug9GCO9qM8DpXqGKxEK02nbuw4EXkSDzQVC_eyhcuwPBBlfOdhAXhVbx_r38hr4UD8TsqdGQ_ltcDzRx0RTv_tqsJHz0f61hxScKH_-Fu95bMwBm00)
