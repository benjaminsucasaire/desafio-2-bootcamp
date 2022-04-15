#!/bin/bash
# shellcheck disable=SC1066
nombre_carpeta=tempdir
sub_carpeta1=static
sub_carpeta2=templates
aplication=desafio2_app.py
echo "Creando carpeta $nombre_carpeta...."
mkdir $nombre_carpeta

echo "Copiando carpetas $sub_carpeta1 y $sub_carpeta2 a $nombre_carpeta...."
cp $sub_carpeta1 $nombre_carpeta -r
cp $sub_carpeta2 $nombre_carpeta -r

echo "Copiando aplicación $aplication a $nombre_carpeta...."
cp $aplication $nombre_carpeta

echo "Creando Dockerfile en $nombre_carpeta...."
touch $nombre_carpeta/Dockerfile

echo "Ingresando información al Dockerfile ....."
echo "FROM python" >> $nombre_carpeta/Dockerfile
echo "RUN pip install flask" >> $nombre_carpeta/Dockerfile
echo "COPY ./static /home/myapp/static/" >> $nombre_carpeta/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> $nombre_carpeta/Dockerfile
echo "COPY desafio2_app.py /home/myapp/" >> $nombre_carpeta/Dockerfile
echo "EXPOSE 5050" >> $nombre_carpeta/Dockerfile
echo "CMD python3 /home/myapp/desafio2_app.py" >> $nombre_carpeta/Dockerfile

echo "Construcción de imagen  a partir del Dockerfile....."
cd tempdir
docker build -t desafio02app:v1 .

echo "Iniciar contenedor en el puerto 5050....."
docker run -t -d -p 5050:5050 --name desafio02app desafio02app:v1
