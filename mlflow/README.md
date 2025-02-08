# docker_template/mlflow

## How to Run
1. Copy .env.example as .env
1. Edit .env as you wish
1. Execute the following commands

```
$ docker compose build --no-cache
$ docker compose up -d
```

## How to Change MLflow Password
Execute the following command
```
$ docker compose exec tracking python3 /change_admin_password.py --password your_password
```
