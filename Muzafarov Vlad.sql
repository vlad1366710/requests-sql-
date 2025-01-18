create table type_obect(
id integer  not null constraint material_p primary key,
name text not null

);
create table obect_foto(
    id_foto integer not null constraint obect_foto_p references foto  on update cascade on delete cascade ,
    id_type_obect integer not null constraint obect_foto_pp references type_obect on update cascade  on delete cascade ,
    col integer not null
);
create table  foto(
    id integer not null constraint foto_p primary key,
    id_user integer  not null constraint foto_pp references user on update cascade on delete cascade ,
    name text not null ,
    col_odobr integer not null
);create table user(
    id integer not null constraint user_p primary key,
    login text  not null,
    age integer not null
);
create unique index login_index on user (login);
/* insert, update,delete */
/* 1 */

INSERT INTO user VALUES
    (1,'lord',6),
    (2,'albert',25),
    (3,'lika',15),
    (4,'loke',13),
   (6,'anna',32),
    (7,'djec',49);
INSERT INTO type_obect VALUES
    (1,'кот'),
    (2,'крот'),
    (3,'человек'),
    (4,'собака'),
    (5,'стол'),
    (7,'котел'),
    (8,'кот дивуар');

INSERT INTO obect_foto VALUES
    (1,1,5),
    (2,1,10),
    (3,3,3),
    (4,5,1),
    (4,2,2),
    (4,1,1),
(5,3,2),
(6,3,1),
(7,3,1),
(8,3,1);
INSERT INTO foto VALUES
    (1,1,'коты',38),
    (2,1,'котята',200),
    (3,2,'семья',150),
    (4,4,'домашние животные',25),
    (5,3,'мама и 100% неожиданность и я',301),
    (6,3,'моя 100% неожиданность',500),
    (7,1,'я и милота дома',120),
    (8,7,'я',25);

/* 1 */

select *from user where  age > 14;
/* 2 */
select name, col_odobr from foto where  col_odobr >100  order by name desc;
/* 3 */
select name from  type_obect where name  like 'кот%';
/* 4 */
select name, col_odobr from foto where name like '%100% неожиданность%';
/* 5 */
select foto.name, t.name from foto inner join obect_foto o on foto.id = o.id_foto inner join type_obect t on t.id = o.id_type_obect;
/* 6 */
select distinct type_obect.name from type_obect inner join obect_foto o on type_obect.id = o.id_type_obect ;
/* 7 */
select name, max(col_odobr) from foto;
/* 8 */
select user.login,user.age, f.name,f.col_odobr,t.name,o.col from user inner join foto f on user.id = f.id_user inner join obect_foto o on f.id = o.id_foto inner join type_obect t on t.id = o.id_type_obect;
/* 9 */
select sum(col) from  obect_foto inner join type_obect t on t.id = obect_foto.id_type_obect where t.name = 'кот';
/* 10 */

select user.login,f.name from user left join foto f on user.id = f.id_user;

/* insert, update,delete */
/* 2 */
delete from user  where age<14;
/* 3 */
delete from  user where age in(select min(age)from user);
/* 4 */
update foto set col_odobr = col_odobr*3 where name in (select name from foto where name like '%милота%');
/* 5 */
update foto set col_odobr = col_odobr*2 where id_user in(select id_user from foto inner join user u on u.id = foto.id_user where u.age>40 ) or(select id_user from foto inner join obect_foto o on foto.id = o.id_foto inner join type_obect t on t.id = o.id_type_obect where t.name = 'кот' and  o.col > 3)