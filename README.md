# summary-transactions-front
    Summary Transactions its an SPA to api summary-transactions, it allow upload file csv and enter email into form

## Technical specifications of the environment

* **vue** - `@vue/cli 5.0.4`
* **docker** - `v20.10.16`
* **node** - `v12.18.4`


## Installation
 clone the repository

### summary-transactions-front
    git clone https://github.com/josepootargaez/summary-transactions-front.git
    cd summary-transactions-front
 ### run the next comands to active the docker container and deploy aplication
    docker build -t  vue-app .
    docker run -p 8080:8080 vue-app
### show aplication
http://localhost:8080


## optional
 ### run without docker and run in local 
    npm install
    npm run serve