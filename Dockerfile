# Этап 1: Сборка кода и страницы
FROM python:3.10 as builder

# Копируем все файлы и папки из текущей директории в контейнер
# Устанавливаем зависимости из файла requirements.txt
COPY . /app
RUN pip install --no-cache-dir -r /app/requirements.txt

WORKDIR /app

# Этап 2: Создание образа Nginx
FROM nginx:latest

# Устанавливаем Nginx в контейнере
RUN apt-get update && apt-get install -y nginx

# Копируем собранный код и страницу из первого этапа
COPY --from=builder /app /usr/share/nginx/html

# Копируем конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Экспонируем порт 80
EXPOSE 80

# Запускаем Nginx при старте контейнера
CMD ["nginx", "-g", "daemon off;"]
