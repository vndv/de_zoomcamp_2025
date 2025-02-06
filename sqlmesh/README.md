## Example project with SQLMesh and Clickhouse

1. Clone repo 

```
git clone git@github.com:vndv/de_zoomcamp_2025.git
cd sqlmesh
```

2. Create virtual environment and install packages


```
python3.13 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

3. Open SQLMesh UI in terminal 

```
sqlmesh ui

```

4. In separate terminal window run

```
sqlmesh plan
```

todo: fix ci/cd