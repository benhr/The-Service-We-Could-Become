// Episode 1 (Week 1): Four partners, one inherited program
// Prototype draft, November 2026. Unreviewed text. Scenes involving the
// Aboriginal Medical Service are placeholders pending review by Aboriginal colleagues.

INCLUDE ../shared/ledger.ink

// Episode-local state (not carried in the save code)
VAR read_eval = false
VAR asked_rules = false
VAR met_rafferty = false
VAR met_raman = false
VAR met_nguyen = false
VAR met_mcallister = false
VAR met_karimi = false
VAR meetings = 0
VAR second_look_shown = false
VAR kept_after_warning = false

-> monday

=== monday ===
Monday # h
You have run services before, but not this one.
The Tallowfield Integrated Care Authority is eleven days old. Your office smells of new carpet, and the phone on your desk has no extension list yet.
Ruth Okonkwo, the Director of Strategy and Planning, arrives with two coffees and one folder. She was seconded from the state health department and has been here longer than anyone.
"One thing needs a decision this week," she says. "The Care Navigator Program."
Fourteen navigators, mostly nurses and community workers, support about 620 people who live with several chronic conditions. They book appointments, arrange transport, chase forms and medicines, and make the phone calls nobody else has time for.
The program came to the Authority from the partnership that existed before it, between the Local Health District (LHD), which runs the region's public hospitals and community health, and the Primary Health Network (PHN), which commissions primary care with Commonwealth money.
It costs about $2.3 million a year. The PHN pays $1.6 million. The LHD hosts the team at Eastlake Community Health Centre and carries $0.7 million in staff costs for 11 of the 14 navigators. The funding agreement ends in four months.
"Dr Aldous wants a recommendation in Friday's board paper," Ruth says. "You can retain it as it is. Reform how it works for the same people. Reposition it to serve a different part of the system. Or repurpose it, which means closing the program and using its people and money for something else."
She closes the folder. "Each of them has a price."
-> monday_choices

= monday_choices
* [Open the evaluation summary]
    ~ read_eval = true
    -> evaluation
* {not asked_rules} [Ask Ruth why the money is so complicated]
    ~ asked_rules = true
    "The PHN's share is Commonwealth commissioning money, and it comes with conditions," Ruth says. "It has to be spent on primary care. The LHD's share is state money, and it follows the staff."
    "The Authority holds a pooled budget. But the Act left walls inside the pool."
    -> monday_choices
* [Put the folder aside and look at your diary]
    -> week

= evaluation
Evaluation of the Care Navigator Program: summary # doc-head
Prepared by a university team for the former partnership. # doc
Hospital admissions among enrolled clients fell by 11% in the 12 months after enrolment. # doc
Most clients were enrolled soon after a hospital stay. Admissions often fall after a stay without any program. # doc
There was no comparison group. # doc
Clients and general practitioners rated the program highly. Few hospital clinicians knew it existed. # doc
[Placeholder, pending review by Aboriginal colleagues: one line on how many clients identify as Aboriginal or Torres Strait Islander, and what is not known about that number.] # placeholder
You close the summary. It is more honest than most.
-> monday_choices

=== week ===
{ meetings == 0:
    Tuesday and Wednesday # h
    Five people have asked for time with you this week. Your diary has room for two.
}
{ meetings == 1:
    You have room for one more.
}
{ meetings >= 2:
    -> wednesday_evening
}
* [Simon Rafferty, Chief Executive of the Local Health District]
    -> rafferty
* [Priya Raman, Chief Executive of the Primary Health Network]
    -> raman
* [Dr Tom Nguyen, general practitioner and board member]
    -> nguyen
* [Dr Fiona McAllister, Director of Emergency Medicine]
    -> mcallister
* [Leila Karimi, the program manager, at Eastlake]
    -> karimi

=== rafferty ===
~ met_rafferty = true
~ meetings = meetings + 1
Simon Rafferty meets you at Tallowfield Hospital, between one bed meeting and the next. He is warm, tired, and apologises for the coffee.
"Eleven of those fourteen navigators are my staff," he says. "If the funding stops, their positions stop. I'd rather not lose good people."
He turns his screen towards you. Thirty-one people are waiting in the emergency department for a bed. Nine beds upstairs hold people who are well enough to go home and are waiting on something outside the hospital.
"What I need is people who follow patients out the door. Someone who makes sure the GP knows, the medicines are right and the transport turns up. Call it a discharge team. Your navigators already do half of it."
You ask about the people the program helps now.
"Most of them came to it after a hospital stay anyway," he says. "So how many beds would we get back?"
-> week

=== raman ===
~ met_raman = true
~ meetings = meetings + 1
Priya Raman meets you at the Primary Health Network's office, above a pharmacy on the main road. The funding agreement is open on the table before you sit down.
"Let me be clear about our share," she says. "$1.6 million of Commonwealth commissioning money. Under our funding rules it has to be spent on primary care. It can't pay for hospital discharge work, however worthwhile."
She is polite about it, and precise.
"We'll keep funding the program if it stays a primary care program and we keep managing the contract. Our general practices trust us. They don't know you yet."
She pauses. "Some of my board think the Authority is a takeover with better branding. I'd like to be able to tell them they're wrong."
-> week

=== nguyen ===
~ met_nguyen = true
~ meetings = meetings + 1
Dr Tom Nguyen fits you in at 7.30 am, before his first patient. His practice is a mid-sized group in Eastlake.
"GPs like the navigators," he says. "They sort out what we can't fix in fifteen minutes. Transport. Forms. Why the pharmacy and the hospital disagree about someone's medicines."
"What they don't like is the referral form. Four pages. And sometimes a navigator rings one of my patients and I find out later. That's awkward when the patient asks me what's going on."
He pours you a coffee from the waiting room machine. "We want a phone call, not a form. One person we can ring."
"And one more thing. To most practices, the Authority's name already means more paperwork. Whatever you do, don't prove them right."
-> week

=== mcallister ===
~ met_mcallister = true
~ meetings = meetings + 1
Dr Fiona McAllister meets you in the emergency department, standing up. She has a printout from last night.
"Fifty people," she says. "Fifty people made 410 presentations to this department last year. Some of them came every week."
She runs a finger down the list. "Eleven are on your navigator program. The other 39 aren't, because the program only takes referrals from GPs. Half of my frequent attenders don't have a regular GP. That's partly why they're here."
A nurse asks her about a bed. She answers in four words and turns back.
"Let us refer from the department. Put a navigator here three days a week. You'd know within a month whether it makes a difference."
-> week

=== karimi ===
~ met_karimi = true
~ meetings = meetings + 1
Leila Karimi, the program manager, meets you at Eastlake Community Health Centre. Fatima Haddad from Eastlake Multicultural Services is there too, with a folder of her own.
You watch a navigator sort a client's letters into piles: hospital, Centrelink, pharmacy, not sure. She books an Arabic interpreter for Thursday and fills in a transport form while the client waits.
"The evaluation is weaker than people think," Karimi says. "We enrolled most people straight after a hospital stay. Admissions fall after that anyway, and nobody funded a comparison group. I want the program kept. I also want it evaluated properly, so nobody has to take my word for it."
Haddad shows you a letter. A family waited five weeks for a specialist appointment because the letter was in English and nobody at home could read it. "The navigator found it on the fridge," she says.
[Placeholder, pending review by Aboriginal colleagues: Karimi mentions the program's Aboriginal clients, and that nobody asked the Aboriginal Medical Service whether it wanted this program.] # placeholder
Karimi walks you to the car park. "Everyone asks whether the program works," she says. "Hardly anyone asks whose problem it was meant to solve."
-> week

=== wednesday_evening ===
Wednesday evening # h
Your inbox holds 212 unread emails.
[Placeholder, pending review by Aboriginal colleagues: a short scene in which the player decides whether to contact the Tallowfield Aboriginal Medical Service (working name) this week.] # placeholder
* [Write a short note to the Service's chief executive]
    ~ ep1_ams_contacted = 1
    You write four sentences, read them twice, and send them.
* [Ask Ruth to arrange a meeting]
    Ruth adds it to her list. "Next month at the earliest," she says. "Their diary is fuller than ours."
* [Leave it until the Authority has a plan]
    You flag the email and move on.
- -> thursday

=== thursday ===
Thursday # h
Ruth has drafted the board paper with a gap where the recommendation goes. "Your call," she says.
-> options

= options
* [Retain: extend it for 12 months, with a proper evaluation]
    ~ nav_fate = 1
* [Reform: a simpler referral route and interpreter-supported intake, designed with GPs and clients]
    ~ nav_fate = 2
* [Reposition: take referrals from the emergency department and base the team at the hospital]
    ~ nav_fate = 3
* [Repurpose: close the program and move the staff into a hospital discharge team]
    ~ nav_fate = 4
- -> check

= check
{ not second_look_shown && nav_fate == 4 && not met_raman:
    -> second_look_repurpose
}
{ not second_look_shown && nav_fate == 3 && not met_nguyen:
    -> second_look_reposition
}
-> reason

= second_look_repurpose
~ second_look_shown = true
Ruth reads the recommendation twice.
"One problem before this goes out. The PHN's $1.6 million is Commonwealth money for commissioning primary care. As far as I know it can't pay for a hospital discharge team. The board will ask where the money comes from."
"You can keep it. I'd just rather the board heard it from us than from Priya Raman."
-> second_look_choice

= second_look_reposition
~ second_look_shown = true
Ruth reads the recommendation twice.
"If the program moves to the emergency department, how will the practices find out? About 150 GPs have referred patients to it. Some of those patients will get a call from a hospital number they don't recognise."
"You can keep it. I'd just like to know what we tell the GPs."
-> second_look_choice

= second_look_choice
* [Keep the recommendation]
    ~ kept_after_warning = true
    -> reason
* [Choose again]
    -> options_again

= options_again
* [Retain: extend it for 12 months, with a proper evaluation]
    ~ nav_fate = 1
* [Reform: a simpler referral route and interpreter-supported intake, designed with GPs and clients]
    ~ nav_fate = 2
* {nav_fate != 3} [Reposition: take referrals from the emergency department and base the team at the hospital]
    ~ nav_fate = 3
* {nav_fate != 4} [Repurpose: close the program and move the staff into a hospital discharge team]
    ~ nav_fate = 4
- -> reason

= reason
Ruth asks for the main reason, to open the covering note. "Dr Aldous reads that line first."
* [The evidence]
    ~ ep1_reason = 1
* [The relationships the Authority needs]
    ~ ep1_reason = 2
* [What the board needs to see]
    ~ ep1_reason = 3
- The paper goes out at 4.58 pm.
-> apply_effects

=== apply_effects ===
~ temp d_hosp = 0
~ temp d_prim = 0
~ temp d_lhd = 0
~ temp d_phn = 0
~ temp d_comm = 0
~ temp d_conf = 0
{ nav_fate:
- 1:
    ~ d_phn += 1
    ~ d_prim += 1
    { not (met_karimi || read_eval):
        ~ d_conf -= 1
    }
- 2:
    { met_nguyen || met_karimi:
        ~ d_prim += 1
        ~ d_comm += 1
    - else:
        ~ d_conf -= 1
    }
- 3:
    ~ d_hosp += 2
    ~ d_lhd += 1
    ~ d_phn -= 1
    { not met_nguyen:
        ~ d_prim -= 1
    }
- 4:
    ~ d_lhd += 2
    ~ d_hosp += 1
    ~ d_conf += 1
    ~ d_prim -= 1
    ~ d_comm -= 1
    { kept_after_warning:
        ~ d_phn -= 3
    - else:
        ~ d_phn -= 2
    }
}
{ ep1_reason:
- 1:
    { met_karimi || read_eval:
        ~ d_conf += 1
    - else:
        ~ d_conf -= 1
    }
- 2:
    {
    - met_rafferty && met_raman:
        ~ d_lhd += 1
        ~ d_phn += 1
    - met_rafferty:
        ~ d_lhd += 1
        ~ d_phn -= 1
    - met_raman:
        ~ d_phn += 1
        ~ d_lhd -= 1
    - else:
        ~ d_conf -= 1
    }
- 3:
    ~ d_conf += 1
}
~ move(trust_hospital, cap(d_hosp))
~ move(trust_primary, cap(d_prim))
~ move(partner_lhd, cap(d_lhd))
~ move(partner_phn, cap(d_phn))
~ move(community, cap(d_comm))
~ move(confidence, cap(d_conf))
-> friday

=== function cap(d)
// No track moves by more than 3 in one episode.
{ d > 3:
    ~ return 3
}
{ d < -3:
    ~ return -3
}
~ return d

=== friday ===
Friday # h
The board meets at 10 am. By lunchtime the consequences start arriving.
{ nav_fate:
- 1: -> friday_retain
- 2: -> friday_reform
- 3: -> friday_reposition
- 4: -> friday_repurpose
}

= friday_retain
From: Dr Judith Aldous, Chair # doc-head
The board approved a 12-month extension with an evaluation. Members were content, if not excited. One asked what will be different in a year that isn't different now. I said you would tell us. Please do, by March. # doc
~ aldous_reason_line()
From: Priya Raman, Primary Health Network # doc-head
Thanks for keeping the program in primary care. The PHN will continue its share for 12 months under the current contract. I've told my board the Authority listens. Let's see how the year goes. # doc
Board paper, budget line 4.12 # doc-head
Care Navigator Program: extended 12 months, evaluation component added. $2.45m. # doc
A client, Cobb's Crossing # doc-head
"My navigator rings on Tuesdays. She knows my five tablets better than the chemist does. Last month she got the bus company to move the stop near my place. I don't know who pays for her. I hope they keep doing it." Bev, 71. # doc
-> debrief

= friday_reform
From: Dr Judith Aldous, Chair # doc-head
The board approved an eight-week design period. Members liked the idea of a simpler referral route but want it described before they fund it. Please bring the new route, the interpreting costs and a timeline to the next meeting. # doc
{ not (met_nguyen || met_karimi):
    One member asked who the new design had been tested with. I'd like a better answer next time than the one we had today. # doc
}
~ aldous_reason_line()
{ met_nguyen:
    From: Dr Tom Nguyen # doc-head
    Happy to test the phone referral with our practice and two others. If it's one number and someone answers it, you'll have GPs on side by Easter. # doc
- else:
    From: Priya Raman, Primary Health Network # doc-head
    I gather the program is being redesigned. It would have been good to hear that from you before the board paper. The PHN will need to see the design before we commit our share. # doc
}
Board paper, budget line 4.12 # doc-head
Care Navigator Program: redesign, interpreting costs added. $2.38m. # doc
A client, Eastlake # doc-head
"Before, I got letters I could not read. Now I call the navigator and she books the Cantonese interpreter for me. Last week I went to the heart clinic on my own for the first time." Mr Lau. # doc
-> debrief

= friday_reposition
From: Dr Judith Aldous, Chair # doc-head
The board approved the move to the hospital site. Members noted the PHN's concern about its funding and asked for a written agreement with the LHD before anything changes. Dr McAllister has already emailed me to say thank you, which is fast even for her. # doc
~ aldous_reason_line()
From: Simon Rafferty, Local Health District # doc-head
Thanks. This will help. Could we talk about navigators in the emergency department on weekends too? Fiona has a list. # doc
Board paper, budget line 4.12 # doc-head
Care Navigator Program: transferred to Tallowfield Hospital site. $2.30m, PHN share under review. # doc
A client, Cobb's Crossing # doc-head
{ met_nguyen:
    "A navigator rang me after I came home from Fenwick. Not my usual one, but she was nice. My GP already knew, he said the hospital had rung him first. That made a change." Bev, 71. # doc
- else:
    "A navigator rang me after I came home from Fenwick. Not my usual one. My GP said he only found out about it from the discharge letter, and he didn't sound pleased." Bev, 71. # doc
}
-> debrief

= friday_repurpose
From: Dr Judith Aldous, Chair # doc-head
The board approved the new discharge team. Members liked a decision that will show up in the bed numbers. Ms Raman abstained. Please tell me how the PHN will respond before the Minister's office asks me. # doc
~ aldous_reason_line()
From: Priya Raman, Primary Health Network # doc-head
Dear Chief Executive, I write to reserve the Primary Health Network's rights over the $1.6 million in Commonwealth commissioning funds allocated to the Care Navigator Program. These funds may not be applied to hospital services. I have copied this letter to the Department. # doc
{ kept_after_warning:
    I understand your own staff raised this with you before the board met. # doc
}
Board paper, budget lines 4.12 and 4.13 # doc-head
Care Navigator Program: closed. Hospital discharge team: established, $0.7m (LHD). $1.6m unallocated, subject to PHN agreement. # doc
A client, Cobb's Crossing # doc-head
"I got a letter saying the program had ended and to talk to my GP. So I rang him, and he rang somebody at your place, and nobody seemed to know who I should talk to now." Bev, 71. # doc
-> debrief

=== function aldous_reason_line()
{ ep1_reason:
- 1:
    { met_karimi || read_eval:
        Your note on the limits of the evaluation was useful. It is rare to see a recommendation that admits what it doesn't know. # doc
    - else:
        One member asked whether the evaluation had a comparison group. Nobody at the table could say. # doc
    }
- 2:
    { not (met_rafferty || met_raman):
        You said the recommendation rests on relationships. A member asked which partners you had spoken to this week. It was an awkward pause. # doc
    }
- 3:
    Thank you for being clear about what the board needs to see. I will remember that. # doc
}

=== debrief ===
~ done_ep1 = true
What people are saying # h
{
- partner_lhd >= 6: Simon Rafferty has stopped asking you about beds. For now.
- partner_lhd <= 2: Simon Rafferty's office now copies the Minister's office into its emails to you.
- else: Simon Rafferty still answers your calls, mostly with questions about beds.
}
{
- partner_phn >= 6: Priya Raman told her board the Authority might be a partner after all.
- partner_phn <= 2: Priya Raman copies her lawyer on everything.
- else: Priya Raman is reserving judgement, politely and in writing.
}
{
- trust_primary >= 5 && trust_primary > trust_hospital: Tom Nguyen mentioned you kindly at the GP clinical council.
- trust_hospital >= 6: Fiona McAllister forwarded your board paper to her registrars.
- trust_primary <= 3: In some GP waiting rooms, the Authority is already shorthand for paperwork.
- else: General practices have not formed a view of the Authority yet, which is about the best you can hope for in week one.
}
{
- confidence >= 5: Dr Aldous now calls you before board meetings, not after.
- confidence <= 3: Dr Aldous has asked Ruth for a briefing on your first month.
- else: Dr Aldous is waiting to see what you do next.
}
For your tutorial # h
Each person you spoke to described a different problem that the navigator program was meant to solve. Whose problem did you decide it was, and who was not in a position to say? # prompt
You gave a main reason for your recommendation. Which of the other reasons would you have been comfortable explaining to the people the program serves? # prompt
-> END
