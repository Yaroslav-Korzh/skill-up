CREATE DATABASE Корж;
USE Корж;

create table if not exists users(
id int(2) auto_increment primary key,
login varchar(20) not null,
password varchar(20) not null
);

create table if not exists profiles(
id int(2) not null,
first_name varchar(20) not null,
last_name varchar(20) not null,
email varchar(20) not null,
age int(2) not null
);

create table if not exists games(
id int(2) auto_increment primary key,
first_player_id int(2) not null,
second_player_id int(2) not null
);

create table if not exists games_results(
id int(2) auto_increment primary key,
result_value varchar(10) not null
);

insert into users
values (1,11111,11111),
(2,22222,22222),
(3,33333,33333),
(4,44444,44444),
(5,55555,55555),
(6,66666,66666),
(7,77777,77777),
(8,88888,88888),
(9,99999,99999),
(10,00000,00000),
(11,111111,111111),
(12,222222,222222),
(13,333333,333333),
(14,444444,444444),
(15,555555,555555)
;

insert into profiles
values (1,"Alex","Jp","qwe@gmail.com",13),
(2,"Andrew","Qda","asd@gmail.com",14),
(3,"Mike","Aqq","zxc@gmail.com",15),
(4,"Jon","Fsdd","rty@gmail.com",16),
(5,"Miha","Bill","dfg@gmail.com",17),
(6,"Katya","cat","cvb@gmail.com",18),
(7,"Sveta","pop","yui@gmail.com",19),
(8,"Albert","mat","hjk@gmail.com",20),
(9,"Sasha","stil","anm@gmail.com",21),
(10,"Yarik","Bib","fsnm@gmail.com",22)
;

insert into games
values (1,1,2),
(2,3,4),
(3,5,6),
(4,7,8),
(5,9,10),
(6,11,12),
(7,13,14),
(8,15,1),
(9,14,2),
(10,13,3)
;

insert into games_results
values (1,'WIN'),
(2,'LOSE'),
(3,'LOSE')
;

delete from users
where id=14
;

delete from users
where id=15
;

update games_results
set result_value='draw'
where id=2
;

update games_results
set result_value='draw'
where id=3
;

update profiles
set first_name='Bob'
where id=5
;

create table if not exists achievements(
	id int(2) auto_increment primary key,
    achiev_name varchar(20) not null
);

select * from achievements;

insert into achievements values
(1,"newbie");

insert into achievements values
(2,"amateur"),
(3,"advanced"),
(4,"professional"),
(5,"master")
;

create table if not exists player_achievs(
	id int(2) auto_increment primary key,
    player_id int(2),
    achiev_id int(2)
);

drop table game_results;

select * from games;

update games
set first_player_id = case
					when id = 1 then 1
                    when id = 2 then 3
                    when id = 3 then 6
                    when id = 4 then 8
                    when id = 5 then 10
                    when id = 6 then 2
                    when id = 7 then 6
                    when id = 8 then 2
                    when id = 9 then 3
                    when id = 10 then 5
end;

update games
set second_player_id = case
					when id = 1 then 2
                    when id = 2 then 4
                    when id = 3 then 5
                    when id = 4 then 7
                    when id = 5 then 9
                    when id = 6 then 4
                    when id = 7 then 1
                    when id = 8 then 8
                    when id = 9 then 5
                    when id = 10 then 10
end;

select * from player_achievs;
select * from ;

insert into player_achievs values
(1, 1, 2),
(2, 2, 3),
(3, 2, 4),
(4, 2, 5),
(5, 3, 1),
(6, 4, 1),
(7, 4, 2),
(8, 5, 3),
(9, 5, 4)
;

create table player_result(
		id int(2) auto_increment primary key,
        player_id int(2) not null,
        result_id int(2) not null
);

update games_results
set result_value = 'lose'
where id = 3
;

insert into player_result values
(1, 3, 3),
(2, 2, 1),
(3, 3, 1),
(4, 3, 2),
(5, 1, 2),
(6, 5, 1),
(7, 4, 2)
;

alter table games
add winner_id int(2)
;

update games
set winner_id = case
			when id=1 then 1
            when id=2 then 3
            when id=3 then 5
            when id=4 then 8
            when id=5 then 9
            when id=6 then null
            when id=7 then null
            when id=8 then 8
            when id=9 then 3
            when id=10 then 5
end;

alter table users
add constraint fk_users_profiles
foreign key(id)
references profiles(id);

alter table player_achievs
add constraint fk_player_achievs_profiles
foreign key(player_id)
references profiles(id);

alter table player_achievs
add constraint FK_player_achievs_achievements
foreign key(achiev_id)
references achievements(id);

alter table player_result
add constraint FK__player_result_profiles
foreign key(player_id)
references profiles(id);


alter table player_result
add constraint FK_player_result_games_results
foreign key (result_id)
references games_results(id);

alter table games
add constraint FK_games_profiles
foreign key (winner_id)
references profiles(id);

select users.login, profiles.first_name, profiles.last_name
from profiles
join users on profiles.id = users.id;

select pr.id, first_name, email, achiev_name
from player_achievs as p
join achievements as a on p.achiev_id = a.id
join profiles as pr on pr.id = p.player_id
where pr.id <= 5;

select profiles.id, first_name, last_name, email, age, winner_id
from games
join profiles on profiles.id = winner_id;

select first_name, last_name, result_value, g.id
from games as g
join profiles as p on g.first_player_id = p.id
join player_result as pr on pr.player_id = p.id
join games_results as gr on gr.id = pr.result_id;


select first_name, count(second_player_id) as count_of_games
from games as g
join profiles as p on p.id = g.second_player_id
group by first_name
order by count_of_games desc;

select first_name, email
from profiles, games
where profiles.id = games.first_player_id;