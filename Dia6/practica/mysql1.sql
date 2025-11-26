¨
1️⃣1️⃣ Crea una función:

fn_EdadPersona(id_persona)
que retorne la edad actual de una persona basada en su fecha_nacimiento.


delimiter //
create function fn_EdadPersona(id_persona int )
returns varchar(50)
READS SQL DATA
begin 
declare v_id int;
declare v_fecha_nacimiento date;
DECLARE v_edad INT;
DECLARE v_nombre VARCHAR(50);
DECLARE v_apellido VARCHAR(50);
select id,nombre,apellido,fecha_nacimiento into v_id,v_nombre,v_apellido,v_fecha_nacimiento from persona where id=id_persona;
SET v_edad = TIMESTAMPDIFF(YEAR, v_fecha_nacimiento, CURDATE());

return concat(v_id,v_nombre,v_apellido,'la edad de la persona es ', v_edad,' años');
end //
delimiter ;

SELECT fn_EdadPersona(1);

Crea un procedimiento que muestre el historial de citas de un cliente, con:

cliente, animal, veterinario, especialidad, fechas y total.

delimiter //
create procedure historial_cliente(in v_id_cliente int)
begin 
    select 
    pc.nombre as nombre_cliente,
    a.nombre as nombre_animal,
    pv.nombre as nombre_veterinario,
    e.nombre as especialidad_veterinario,
    c.fecha_inicio,
    c.fecha_fin,
    c.total 
    from citas c 
    
    left join animal a on c.animal_id=a.id
    left join cliente cl on a.cliente_id=cl.id
    left join persona pc on pc.id=cl.id
    left join veterinario v on c.veterinario_id=v.id
    left join persona pv on pv.id=v.id
    left join especialidad e on v.especialidad=e.id
    where cl.id=v_id_cliente;
    
end //
delimiter ;
call historial_cliente(1);
