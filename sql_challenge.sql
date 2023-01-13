--10) Did we ever use two classrooms at the same time in the same course location?
select o1.location
, o1.begindate, o1.course, c1.duration
, o2.begindate, o2.course, c2.duration
from offerings    o1
, offerings    o2
, courses      c1
, courses      c2
where  o1.location  = o2.location
    and (o1.begindate < o2.begindate or
    o1.course   <> o2.course      )
    and o1.course    = c1.code
    and o2.course    = c2.code
    and o2.begindate between o1.begindate
                        and o1.begindate + c1.duration;
