select
    s.date,
    round(
        count(a.user_id_sender)::decimal / count(*),
        2
    ) as acceptance_rate
from fb_friend_requests s
left join fb_friend_requests a
    on s.user_id_sender = a.user_id_sender
   and s.user_id_receiver = a.user_id_receiver
   and a.action = 'accepted'
where s.action = 'sent'
group by s.date
having count(a.user_id_sender) > 0
order by s.date;