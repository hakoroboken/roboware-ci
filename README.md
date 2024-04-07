# roboware-ci

## How to use

simple build test

```yaml
name: build test
on:
 pull_request:
    branches: [ main ]
 push:
    branches: [ main ]
jobs:
 build_and_test:
    runs-on: ubuntu-latest
    steps:
    - name: Checking out
      uses: actions/checkout@v3
    - name: Building
      uses: hakoroboken/roboware-ci@v2
```

with deb pkg

```yaml
name: Build test
on:
 pull_request:
    branches: [ main ]
 push:
    branches: [ main ]
jobs:
 build-test:
    runs-on: ubuntu-latest
    steps:
    - name: Checking out
      uses: actions/checkout@v3
    - name: Building
      uses: hakoroboken/roboware-ci@v2
      with:
       apt-url-packages: https://github.com/hakoroboken/roboware/raw/pkg/ros-humble-scgw-msgs_1.0.0-0jammy_amd64.deb 
```

