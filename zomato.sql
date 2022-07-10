show databases;
select database() zomato;
show tables in zomato;
select * from zomato.zomatodata;
/* not executed by sql compiler - plain english statement */
/*distinct list of country code*/ 
select distinct zomatodata.CountryCode
from zomato.zomatodata;
/*create table in zomato databse */
create table zomato.country(country varchar(20),pincode int(6));
insert into zomato.country values("india",30);
insert into zomato.country values("USA",162);
select * from zomato.country;
/*join 2 tables with foriegn key*/
select country.country,zomatodata.CountryCode 
from zomato.country 
right join zomato.zomatodata 
on country.pincode = zomatodata.CountryCode;
/*help zomato to identifying poor rating of resturant or less than 3.5*/
select zomatodata.RestaurantName,zomatodata.Rating 
from zomato.zomatodata 
where rating < 3.5;
 /*so these resturaants have poor rating */
 /*Mr. roy looking for resturants in Brasí_lia which not provide online delivery help in choose best resturant */
 select zomatodata.RestaurantName,zomatodata.Rating,zomatodata.Has_Online_delivery 
 from zomato.zomatodata 
 where zomatodata.CountryCode=30 and
zomatodata.Has_Online_delivery= "no";
/* help in findng resturant havinf pizza*/
select zomatodata.RestaurantName,zomatodata.Cuisines 
from zomato.zomatodata 
where zomatodata.Cuisines 
like "%izza";
/* finding restutants who are expensive, luxury,average*/
select zomatodata.RestaurantName 
from zomato.zomatodata 
where zomatodata.Average_Cost_for_two >1000;
select zomatodata.RestaurantName 
from zomato.zomatodata 
where zomatodata.Average_Cost_for_two >3000;
select zomatodata.RestaurantName 
from zomato.zomatodata 
where zomatodata.Average_Cost_for_two >4500;
/* most resturants in which country*/
select zomatodata.CountryCode,count(*)
from zomato.zomatodata 
where zomatodata.CountryCode = 30;
select zomatodata.CountryCode,count(*)
from zomato.zomatodata 
where zomatodata.CountryCode = 162;
select count(*),zomatodata.CountryCode 
from zomato.zomatodata 
group by zomatodata.CountryCode 
order by count(*);

