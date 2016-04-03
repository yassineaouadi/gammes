
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

#echo "creation statique  table profile"

#su - postgres -c "psql -c \"create table profile (first varchar(20), last varchar(20), phone varchar(20), email  varchar(20), pdf varchar(20),src varchar(20), url varchar(20), github varchar(20) , twitter varchar(20), linkedin varchar(20) );\""


echo "creation dynamique de la table profile"

echo "extraction des donées du fichier yaml"
tab=( $( awk -F ":" '{print $1}' exemple.yml) )

chaine="create table profile ("

i=0
n=${#tab[@]}
while [ "$i" -lt "$(($n -1))" ]
do
chaine="$chaine ${tab[$i]} varchar(50),"
((i++))
done
chaine="$chaine ${tab[$i]} varchar(50));"

#echo "$chaine"

#su - postgres -c "psql -c \"create table profile (first varchar(20), last varchar(20), phone varchar(20), email  varchar(20), pdf varchar(20),src varchar(20), url varchar(20), github varchar(20) , twitter varchar(20), linkedin varchar(20) );\""
su - postgres -c "psql -c \" $chaine\""
su - postgres -c "psql -c \" select * from profile\""

echo "insertion dans la table profile "

tab2=( $( awk -F ":" '{print $2}' exemple.yml) )

chaine2="insert into profile values( '"
j=0
m=${#tab2[@]}

while [ "$j" -lt "$(($m-1))" ]
do
chaine2="$chaine2 ${tab2[$j]}' ,'"
((j++))
done
chaine2="$chaine2 ${tab2[$j]} ')"
#echo "$chaine2"
su - postgres -c "psql -c \" $chaine2\""
su - postgres -c "psql -c \" select * from profile\""
