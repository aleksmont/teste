# README

Aplicação segundo as instruções do teste proposto em 13/10/2025

Para rodar o projeto, juntamente com o banco postgres usar o comando docker-compose: 

``docker-compose -f ./docker-compose.yml  -p webscrapper up -d``

Acessar o projeto pelo link:

``http://localhost:3005``


Gems utilizadas: 
* Bootstrap - apenas para facilitar o layout
* httparty, nokogiri - para a funcionalidade do scrapper
* kaminari - paginação dos resultados, melhoria de UX 
* rails_url_shortener - para a funcionalidade de encurtamnto de urls e geração de captura de dados (ip, geolocation ...)

``OBS: Poderiam ter sido utilizados serviços terceiros, como o bitly. porem só permite poucos links por mês e ia dificultar os testes``

* Test unitario escrito em minitest: [ip_helper_test.rb](test/helpers/ip_helper_test.rb)
* 


