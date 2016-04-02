#!/usr/bin/env  bash

echo " installation de nginx"
add-apt-repository ppa:nginx/stable > /dev/null 2>&1
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx

echo "Installation de Postgresql"
apt-get update > /dev/null 2>&1
apt-get install -y postgresql postgresql-contrib > /dev/null 2>&1

echo "fin de l'installation"

echo "Creation de la base de donnée"
su - postgres -c "psql -c \"create database challenge ;\""
echo "connexion base de donnée"
su - postgres -c "psql -c \"\\connect challenge\""
echo "creation table profile"
su - postgres -c "psql -c \"create table profile (first varchar(20), last varchar(20), phone varchar(20), email  varchar(20), pdf varchar(20),src varchar(20), url varchar(20), github varchar(20) , twitter varchar(20), linkedin varchar(20) );\""


