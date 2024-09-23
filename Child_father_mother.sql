create table people
(id int primary key not null,
 name varchar(20),
 gender char(2));

create table relations
(
    c_id int,
    p_id int,
    FOREIGN KEY (c_id) REFERENCES people(id),
    foreign key (p_id) references people(id)
);

insert into people (id, name, gender)
values
    (107,'Days','F'),
    (145,'Hawbaker','M'),
    (155,'Hansel','F'),
    (202,'Blackston','M'),
    (227,'Criss','F'),
    (278,'Keffer','M'),
    (305,'Canty','M'),
    (329,'Mozingo','M'),
    (425,'Nolf','M'),
    (534,'Waugh','M'),
    (586,'Tong','M'),
    (618,'Dimartino','M'),
    (747,'Beane','M'),
    (878,'Chatmon','F'),
    (904,'Hansard','F');
    insert into relations(c_id, p_id)
values
    (145, 202),
    (145, 107),
    (278,305),
    (278,155),
    (329, 425),
    (329,227),
    (534,586),
    (534,878),
    (618,747),
    (618,904);
    #output child/father/mother
  

    
    #inner join relation with people on parent_id
    #filter of gender
    #mothers of each child
    with m as (
    select r.c_id,p.name as mother_name
    from relations r
    inner join people p
    on r.p_id=p.id and gender='F'),
    #father name
    f as(
	select r.c_id,p.name as father_name
    from relations r
    inner join people p
    on r.p_id=p.id and gender='M')
    
    select f.c_id as chid_name,m.mother_name ,f.father_name 
    from f 
    inner join m on f.c_id=m.c_id
    #using optimal solution of case when and group by
    
    #direct inner join with people
    select r.c_id as child_id, 
    max(case when p.gender='F'then name end)as mother_name,
    max(case when p.gender='M'then name end)as father_name
    from relations r
    inner join people p on r.p_id=p.id
    group by r.c_id
   

