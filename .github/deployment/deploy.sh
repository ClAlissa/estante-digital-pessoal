set -e

echo "Deploying application..."

git pull origin master

composer update

echo "Application deployed."