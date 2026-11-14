// Module 1 (course Weeks 1 and 2): Four partners, one inherited program
// Prototype draft, version 0.3, November 2026. About 15 minutes.
// Scenes involving the Aboriginal Medical Service are a first draft for review
// by an Aboriginal colleague.
//
// Stakes in this module:
//   - the people you don't meet act on their own (Wednesday evening emails)
//   - waiting costs staff (Clinical Navigators leave during the week)
//   - the board can approve, attach conditions or defer (m1_board)
//   - the outcome changes what is available in Module 2
//
// Tags used by the web page:
//   # h            a day heading
//   # doc-head     who a document is from (set in the margin)
//   # doc          a line of a document (set in the grotesque)
//   # prompt       a tutorial question
//   # quiet        a small note

INCLUDE ../shared/ledger.ink

// Module-local state (not carried in the save code)
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
VAR navs_left = 0
VAR navs = 14

-> monday

=== monday ===
Monday # h
It's your first week as chief executive of the Tallowfield Integrated Care Authority, one of the new authorities set up across the country under the new National Health Reform Agreement. Most of the staff came across from the Local Health District (LHD) and the Primary Health Network (PHN). They are still on different industrial agreements, and for now, two email systems.
Until last month, community health, primary care commissioning and the programs meant to keep people out of hospital were run by two organisations answering to two governments. Now they belong to the Authority: about $475 million a year, roughly 140 staff, and every contract and program the two organisations handed over.
The handover register lists 312 contracts and 41 programs. Each has an end date, a provider, staff, and people who rely on it. The Act that created the Authority will be reviewed in three years, and the Minister's office has already asked what it will have to show by its first quarterly report.
Ruth Okonkwo, the Director of Strategy and Planning, is on secondment from the state health department. She comes in with one folder.
"This one needs a decision this week," she says. "The Clinical Navigator Program. It's the first program decision the Authority makes, so everyone else on that register will be reading it for what it says about the rest."
The program has 14 Clinical Navigators, mostly registered nurses, with two allied health staff. They support about 620 people with several chronic conditions: booking appointments, arranging transport, sorting out medicines, following up test results and chasing services that haven't called back.
The LHD and the PHN set it up three years ago, in the voluntary partnership that came before the Authority. The LHD runs the region's public hospitals and community health services. The PHN commissions primary care with Commonwealth funding.
The program costs about $2.3 million a year. The PHN pays $1.6 million. The LHD hosts the team at Eastlake Community Health Centre and covers $0.7 million in salaries for 11 of the 14 navigators. The funding agreement ends in four months.
"Dr Aldous wants a recommendation in Friday's board paper," Ruth says. "As I see it there are four options. Retain it as it is. Reform how it works, for the same clients. Reposition it, so it serves a different part of the system. Or repurpose it, which means closing the program and using the staff and the money for something else."
"Simon Rafferty and Priya Raman will both have views," she adds. "Probably not the same ones. And the navigators know their funding ends in four months, so they'll be watching too."
-> monday_choices

= monday_choices
* [Read the evaluation summary]
    ~ read_eval = true
    -> evaluation
* {not asked_rules} [Ask Ruth why the funding is so complicated]
    ~ asked_rules = true
    "The PHN's money is Commonwealth money with conditions attached," Ruth says. "It has to go to primary care. The LHD's money is state money, and it's tied up in salaries."
    "The new reform agreement put both into one pool for the Authority. It didn't change the conditions either of them came with."
    -> monday_choices
* [Look at who wants to see you this week]
    -> week

= evaluation
Evaluation of the Clinical Navigator Program, summary # doc-head
Prepared by an independent evaluator for the former partnership. # doc
Hospital admissions among enrolled clients fell by 11% in the 12 months after enrolment. # doc
Most clients were enrolled soon after a hospital admission. Admissions often fall after an admission without any program. # doc
There was no comparison group. # doc
Clients and GPs rated the program highly. Few hospital clinicians knew it existed. # doc
Nine of the 620 clients identify as Aboriginal or Torres Strait Islander. The evaluation did not look at whether that is more or fewer than would be expected for the region. # doc
-> monday_choices

=== week ===
{ meetings == 0:
    Tuesday and Wednesday # h
    Five people have asked to meet you this week. Your diary has room for two. The other three won't wait for you.
}
{ meetings == 1:
    You have time for one more meeting.
}
{ meetings >= 2:
    -> wednesday_evening
}
* [Simon Rafferty, Chief Executive of the Local Health District]
    -> rafferty
* [Priya Raman, CEO of the Primary Health Network]
    -> raman
* [Dr Tom Nguyen, GP and board member]
    -> nguyen
* [Dr Fiona McAllister, Director of Emergency Medicine]
    -> mcallister
* [Leila Karimi, the program manager, at Eastlake]
    -> karimi

=== rafferty ===
~ met_rafferty = true
~ meetings = meetings + 1
You meet Simon Rafferty at Tallowfield Hospital. He has twenty minutes between the morning bed meeting and the executive meeting.
"Eleven of those fourteen navigators are on my payroll," he says. "If the funding stops, so do their positions. They're good staff and I'd rather not lose them. I've asked People and Culture to hold off on redeployment until you've decided."
He shows you this morning's patient flow report. Thirty-one patients are in the emergency department (ED) waiting for a bed. Nine people on the wards are ready for discharge and waiting on a residential aged care place or an NDIS package.
"Community health is your budget now," he says. "If it isn't done well, those patients come back through my ED. What I need is people who follow patients home. Someone who makes sure the GP gets the discharge summary, the medicines are right and the transport turns up. Your navigators already do a fair bit of that."
"Most of their clients were referred after an admission anyway. What I'd want to know is how many readmissions they'd prevent."
-> week

=== raman ===
~ met_raman = true
~ meetings = meetings + 1
You meet Priya Raman at the PHN's office. She has the funding schedule printed out.
"Our share is $1.6 million of Commonwealth commissioning funds," she says. "Under our funding agreement it has to be spent on primary care. We can't use it for hospital discharge work, even good discharge work."
"We'll keep funding the program if it stays a primary care program and we keep managing the contract. The practices know us. They don't know the Authority yet."
"To be honest, some of my board think the PHN will be absorbed into the Authority within a couple of years. They meet tonight. I'll tell them we've talked, and that you understand where our money can go."
-> week

=== nguyen ===
~ met_nguyen = true
~ meetings = meetings + 1
Dr Tom Nguyen sees you at 7.30 am, before his first patient. He's a partner in a group practice in Eastlake and chairs the GP clinical council.
"GPs like the navigators," he says. "They deal with the things we can't sort out in a standard consult. Transport, forms, the pharmacy and the hospital having different medication lists."
"What they don't like is the referral form. It's four pages. And sometimes a navigator contacts one of our patients and we only find out when the patient asks us what's going on."
"We'd rather pick up the phone than fill in a form. One number, and someone who answers it."
"And be careful how it looks. Most practices already assume the Authority means more paperwork. Anything with a new form attached won't get used."
-> week

=== mcallister ===
~ met_mcallister = true
~ meetings = meetings + 1
Dr Fiona McAllister meets you in the ED office. She has printed a list from the department's data.
"Fifty people made 410 presentations to this ED last year," she says. "A few of them were here most weeks."
"Eleven of them are enrolled in the navigator program. The other 39 aren't, because the program only takes GP referrals. About half of our frequent presenters don't have a regular GP, which is part of why they keep coming here."
"Let us refer from ED. Put a navigator here three days a week and we'd know within a few months whether it made a difference."
-> week

=== karimi ===
~ met_karimi = true
~ meetings = meetings + 1
Leila Karimi, the program manager, shows you around Eastlake Community Health Centre. Fatima Haddad, who manages Eastlake Multicultural Services, has come along too.
You sit in while a navigator goes through a client's letters with her: hospital, Centrelink, pharmacy, and two she can't place. The navigator books an Arabic interpreter for Thursday's appointment and arranges community transport.
"The evaluation is weaker than people think," Karimi says. "Most clients were enrolled straight after a hospital admission, and admissions tend to drop after that anyway. There was no comparison group, because nobody funded one. I want the program kept, and I want it evaluated properly."
Haddad tells you about a family who missed a specialist appointment because the letter was in English and nobody at home could read it. A navigator found it on the fridge five weeks later.
"Nine of our clients are Aboriginal," Karimi says. "I'd have expected more for this region, but I don't really know. I was told the Aboriginal Medical Service runs its own care coordination. Nobody asked them whether they wanted this program, or whether it would work for their clients."
"The program was set up to reduce admissions, because that was what the partnership could get funded," she says as you leave. "Most of what the navigators do each day is something else, and the evaluation didn't measure any of it. Two of them have job interviews this week. I've told them to go."
-> week

=== wednesday_evening ===
Wednesday evening # h
You have 212 unread emails. Three are about the program, from people you didn't make time for.
{ not met_rafferty:
    Email from LHD People and Culture, copied to Simon Rafferty # doc-head
    Given the uncertainty about the Clinical Navigator Program's funding, we have started redeployment conversations with the 11 LHD-employed navigators, as our policy requires. We will keep you informed. # doc
}
{ not met_raman:
    Email from Priya Raman, CEO, PHN # doc-head
    Our board met last night and resolved that the PHN's commissioning funds stay in primary care. I wanted you to hear it from me before Friday's board papers. Happy to talk. # doc
}
{ not met_nguyen:
    GP clinical council minutes, item 6 # doc-head
    Members noted that the Clinical Navigator Program's funding ends in four months. Members asked that any change to referral arrangements come to the council before it is decided. Nobody from the Authority attended. # doc
}
{ not met_mcallister:
    Email from Dr Fiona McAllister to Simon Rafferty, copied to you # doc-head
    Eleven of our 50 most frequent presenters are already on the navigator list. If the program is being reviewed, ED would like a say. Can we discuss at Thursday's executive? # doc
}
{ not met_karimi:
    Email from Leila Karimi, program manager # doc-head
    The team has heard the funding ends in four months. Two of the navigators have job interviews this week. What can I tell them? # doc
}
The Tallowfield Aboriginal Medical Service nominates one of the Authority's board members, but you haven't met anyone from the Service yet. Its CEO is Dianne Cooper. The Service has its own board and runs its own clinics in Eastlake and Cobb's Crossing.
* [Write a short note to the Service's CEO]
    ~ m1_ams_contacted = 1
    You write to Dianne Cooper, introduce yourself and ask whether the Service would be willing to meet.
* [Ask Ruth to arrange a meeting]
    "I'll ask," Ruth says. "Their diary is fuller than ours."
* [Leave it until the Authority has a plan]
    You add it to your list for next month.
- -> thursday

=== thursday ===
~ navs_left = 2
{ not met_rafferty:
    ~ navs_left = 3
}
~ navs = 14 - navs_left
Thursday # h
Ruth has news before the board paper goes out. This week {navs_left} Clinical Navigators accepted jobs elsewhere.{ not met_rafferty: One of them took a redeployment offer from the LHD.} Leila Karimi says the others are waiting to see what the board decides.
Ruth has drafted the paper and left a gap for the recommendation.
-> options

= options
* [Retain: extend it for 12 months, with a proper evaluation]
    ~ nav_fate = 1
* [Reform: a simpler referral pathway and interpreter-supported intake, designed with GPs and clients]
    ~ nav_fate = 2
* [Reposition: take referrals from ED and base the team at the hospital]
    ~ nav_fate = 3
* [Repurpose: close the program and move the LHD staff into a hospital discharge team]
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
"One thing before this goes out," Ruth says. "The PHN's $1.6 million is Commonwealth money for primary care, and their board has just said so in writing. It can't pay for a hospital discharge team. The board will ask where the money is coming from."
"You can leave it as it is. But if the board can't see how it's funded, I think they'll defer it, and the navigators will be left waiting another month."
-> second_look_choice

= second_look_reposition
~ second_look_shown = true
"One thing before this goes out," Ruth says. "If the program moves to the hospital, how will the practices find out? About 150 GPs have referred patients to it, and the GP clinical council has asked to see any change first."
"You can leave it as it is. But we'll need to tell the GPs something, and soon."
-> second_look_choice

= second_look_choice
* [Leave the recommendation as it is]
    ~ kept_after_warning = true
    -> reason
* [Change the recommendation]
    -> options_again

= options_again
* [Retain: extend it for 12 months, with a proper evaluation]
    ~ nav_fate = 1
* [Reform: a simpler referral pathway and interpreter-supported intake, designed with GPs and clients]
    ~ nav_fate = 2
* {nav_fate != 3} [Reposition: take referrals from ED and base the team at the hospital]
    ~ nav_fate = 3
* {nav_fate != 4} [Repurpose: close the program and move the LHD staff into a hospital discharge team]
    ~ nav_fate = 4
- -> reason

= reason
Ruth asks for your main reason, to open the covering note. "Dr Aldous reads that first."
* [The evidence]
    ~ m1_reason = 1
* [The relationships the Authority needs]
    ~ m1_reason = 2
* [What the board needs to see]
    ~ m1_reason = 3
- The paper goes to the board secretary that afternoon.
-> apply_effects

=== apply_effects ===
// What the board decides: 1 approved, 2 approved with conditions, 3 deferred
{ nav_fate:
- 1:
    { met_karimi || read_eval:
        ~ m1_board = 1
    - else:
        ~ m1_board = 2
    }
- 2:
    { met_nguyen || met_karimi:
        ~ m1_board = 1
    - else:
        ~ m1_board = 2
    }
- 3:
    { met_rafferty:
        ~ m1_board = 1
    - else:
        ~ m1_board = 2
    }
- 4:
    { kept_after_warning:
        ~ m1_board = 3
    - else:
        ~ m1_board = 1
    }
}
// What happens to the team
{ m1_board == 3:
    ~ navs = navs - 3
}
{ m1_board == 2:
    ~ navs = navs - 1
}
{ nav_fate == 3 && navs > 8:
    ~ navs = 8
}
{ nav_fate == 4 && m1_board == 1:
    ~ navs = 0
}

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
    { m1_board == 2:
        ~ d_conf -= 1
    }
- 2:
    { m1_board == 1:
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
    ~ d_prim -= 1
    ~ d_comm -= 1
    { m1_board == 3:
        ~ d_phn -= 3
        ~ d_conf -= 1
    - else:
        ~ d_phn -= 2
        ~ d_conf += 1
    }
}
// The people you didn't meet
{ not met_raman && (nav_fate == 3 || nav_fate == 4):
    ~ d_phn -= 1
}
{ not met_mcallister && nav_fate != 3:
    ~ d_hosp -= 1
}
{ not met_nguyen && nav_fate == 2:
    ~ d_prim -= 1
}
// The reason given
{ m1_reason:
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
// No track moves by more than 3 in one module.
{ d > 3:
    ~ return 3
}
{ d < -3:
    ~ return -3
}
~ return d

=== friday ===
Friday # h
The board meets in the morning. These arrive over the afternoon.
{ nav_fate:
- 1: -> friday_retain
- 2: -> friday_reform
- 3: -> friday_reposition
- 4: -> friday_repurpose
}

= friday_retain
Email from Dr Judith Aldous, Chair # doc-head
{ m1_board == 1:
    The board approved the 12-month extension and the evaluation. There was some discussion about what we should expect to see at the end of the year, and I said you would bring a proposal to the March meeting. # doc
- else:
    The board agreed to extend the program for six months, not twelve. Members weren't convinced the evaluation showed what the paper said it did, and want an evaluation plan before committing further. Could you bring one to the March meeting? # doc
}
~ aldous_reason_line()
Email from Priya Raman, CEO, PHN # doc-head
{ m1_board == 1:
    Thanks for keeping the program in primary care. We're happy to continue our share for another 12 months under the current contract, and I'll let our board know. # doc
- else:
    We'll continue our share for six months. After that I'll need to take it back to my board, and they'll want to see the evaluation plan too. # doc
}
~ ams_reply()
Board paper, budget line 4.12 # doc-head
{ m1_board == 1:
    Clinical Navigator Program: extended 12 months, evaluation component added. $2.45m. # doc
- else:
    Clinical Navigator Program: extended six months, subject to an evaluation plan. $1.15m. # doc
}
~ navs_line()
Bev, 71, Cobb's Crossing # doc-head
{ m1_board == 1:
    "My navigator rings on Tuesdays. She knows my five tablets better than the chemist does, and she sorted out the community transport to my heart clinic. I don't know who pays for her, but I hope they keep it going." # doc
- else:
    "My navigator rang to say she's leaving. They've given me someone new, and she's very nice, but she doesn't know my tablets yet. I hope this one stays." # doc
}
-> debrief

= friday_reform
Email from Dr Judith Aldous, Chair # doc-head
{ m1_board == 1:
    The board approved an eight-week design period, with funding to continue while it runs. Members supported a simpler referral pathway but want to see it described before they fund it beyond that. Could you bring the new pathway, the interpreting costs and a timeline to the next meeting? # doc
- else:
    The board approved the eight-week design period but not funding beyond the current agreement. A member asked who had been involved in the redesign, and the board wants the GP clinical council consulted before anything more is funded. # doc
}
~ aldous_reason_line()
{ met_nguyen:
    Email from Dr Tom Nguyen # doc-head
    Happy to trial the phone referral at our practice and a couple of others. If it's one number and someone answers it, I think most GPs will use it. # doc
- else:
    Email from Priya Raman, CEO, PHN # doc-head
    I understand the program is being redesigned. It would have been good to hear about it before the board paper went out. We'll need to see the design before we commit our share. # doc
}
~ ams_reply()
Board paper, budget line 4.12 # doc-head
{ m1_board == 1:
    Clinical Navigator Program: redesign, interpreting costs added. $2.38m. # doc
- else:
    Clinical Navigator Program: redesign; funded to the end of the current agreement only. $0.77m. # doc
}
~ navs_line()
Mr Lau, 78, Eastlake # doc-head
{ m1_board == 1:
    "Before, letters came that I could not read. Now I ring the navigator and she books the Cantonese interpreter. Last week I went to the heart clinic by myself for the first time." # doc
- else:
    "The navigator says things might change after Christmas. She books my interpreter. I hope I can still ring her." # doc
}
-> debrief

= friday_reposition
Email from Dr Judith Aldous, Chair # doc-head
{ m1_board == 1:
    The board approved moving the program to the hospital. The PHN has told us its share can't go to a hospital-based program, so the LHD will fund the team from its own budget. Dr McAllister has already emailed to thank us. # doc
- else:
    The board approved the move to the hospital in principle, subject to the LHD agreeing to fund it. The PHN has told us its share can't go to a hospital-based program. Mr Rafferty said he would need to look at his budget. # doc
}
~ aldous_reason_line()
Email from Simon Rafferty, Chief Executive, LHD # doc-head
{ m1_board == 1:
    Thanks, this will help. We'll fund eight positions from the LHD budget, which is as far as I can stretch. Could we also talk about weekend cover in ED? Fiona has some numbers. # doc
- else:
    I'm happy to look at it, but I can't promise anything before the new financial year. It would have helped to talk before the paper went to the board. # doc
}
~ ams_reply()
Board paper, budget line 4.12 # doc-head
{ m1_board == 1:
    Clinical Navigator Program: transferred to Tallowfield Hospital, LHD-funded. $1.3m. The PHN's $1.6m returns to primary care commissioning. # doc
- else:
    Clinical Navigator Program: transfer to Tallowfield Hospital approved in principle. Funding not confirmed. # doc
}
~ navs_line()
Bev, 71, Cobb's Crossing # doc-head
{ met_nguyen:
    "A navigator rang after I got home from Fenwick. She wasn't my usual one, but she was nice. My GP already knew about it. He said the hospital had rung him." # doc
- else:
    "A navigator rang after I got home from Fenwick. She wasn't my usual one. My GP only found out from the discharge letter, and he wasn't happy about it." # doc
}
-> debrief

= friday_repurpose
Email from Dr Judith Aldous, Chair # doc-head
{ m1_board == 1:
    The board approved the new discharge team, funded from the LHD's share. Ms Raman abstained, and told the board the PHN will recommission its $1.6 million elsewhere in primary care. Could you let me know how we'll support the 620 clients through the change? # doc
- else:
    The board deferred the recommendation. Ms Raman told the meeting that the PHN's funds can't be used for a hospital team, and members weren't willing to approve a team without knowing how it would be paid for. The program continues for now, but nothing has been decided. Could we talk on Monday? # doc
}
~ aldous_reason_line()
Letter from Priya Raman, CEO, PHN # doc-head
{ m1_board == 1:
    Dear Chief Executive, as I said when we met, the PHN's share of the Clinical Navigator Program cannot fund hospital services. The PHN will recommission the $1.6 million in primary care, and will write to the GPs of the program's clients to explain what happens next. # doc
- else:
    Dear Chief Executive, I am writing about the $1.6 million in Commonwealth funding that the PHN has allocated to the Clinical Navigator Program. Under our funding agreement these funds cannot be used for hospital services, and the PHN reserves its position on how they are used. I have copied this letter to the Department. # doc
    I understand your staff raised this with you before the board met. # doc
}
~ ams_reply()
Board paper, budget lines 4.12 and 4.13 # doc-head
{ m1_board == 1:
    Clinical Navigator Program: closes in four months. Hospital discharge team: established, $0.7m (LHD). The PHN's $1.6m to be recommissioned in primary care. # doc
- else:
    Clinical Navigator Program: decision deferred. The PHN's $1.6m share on hold. # doc
}
~ navs_line()
Bev, 71, Cobb's Crossing # doc-head
{ m1_board == 1:
    "I got a letter saying the program was finishing and I should talk to my GP. So I rang him, and he rang someone at your office, and nobody seemed to know who I should talk to now." # doc
- else:
    "My navigator has left, and so has the one before her. Someone rang to say the program is still going, but nobody can tell me for how long." # doc
}
-> debrief

=== function navs_line()
{ navs == 0:
    Clinical Navigators in post when the program closes: none. The 11 LHD staff move to the discharge team; the other three positions end. # doc
- else:
    Clinical Navigators in post: {navs} of 14. # doc
}

=== function ams_reply()
{ m1_ams_contacted == 1:
    Email from Dianne Cooper, CEO, Tallowfield Aboriginal Medical Service # doc-head
    Thanks for your note. We'd be glad to meet once the Authority has worked out what it wants to talk with us about. Where decisions affect our community, we'd ask that you bring them to us before they're made, not after. # doc
}

=== function aldous_reason_line()
{ m1_reason:
- 1:
    { met_karimi || read_eval:
        Thank you for being upfront about the limits of the evaluation. Members appreciated it. # doc
    - else:
        One member asked whether the evaluation had a comparison group. Could you send me a short note on that before the next meeting? # doc
    }
- 2:
    { not (met_rafferty || met_raman):
        Your paper said the recommendation was mainly about relationships. A member asked which partners you had spoken to, and I couldn't say. Could you let me know? # doc
    }
- 3:
    Thank you for thinking about what the board needs to see. The Minister's office will be asking us the same question. # doc
}

=== debrief ===
~ done_m1 = true
A week later # h
{
- navs == 0: The navigators who stayed have started in the discharge team. Leila Karimi has taken a job with another LHD.
- navs >= 12: Leila Karimi's team is close to full strength, and she has started taking new referrals again.
- navs >= 8: Leila Karimi has {navs} Clinical Navigators and a waiting list.
- else: Leila Karimi has {navs} Clinical Navigators left, and has stopped taking new referrals.
}
{
- partner_lhd >= 6: Simon Rafferty has asked you to join the LHD's patient flow committee.
- partner_lhd <= 2: Simon Rafferty's office now copies the state health department into its emails to you.
- else: Simon Rafferty is waiting to see what the Authority means for his hospitals.
}
{
- partner_phn >= 6: Priya Raman has offered to introduce you at the next GP education evening.
- partner_phn <= 2: Priya Raman has asked that any further discussion of the PHN's funding be in writing.
- else: Priya Raman is cordial, and is keeping her board informed.
}
{
- trust_primary >= 5 && trust_primary > trust_hospital: Tom Nguyen has raised the navigator program at the GP clinical council, favourably.
- trust_hospital >= 6: Fiona McAllister has asked when the first navigator can start in ED.
- trust_primary <= 3: Several GPs have told Tom Nguyen they'll wait and see before referring to anything the Authority runs.
- else: Most general practices haven't heard of the Authority yet.
}
{
- confidence >= 5: Dr Aldous has asked you to brief the Minister's office next month.
- confidence <= 3: Dr Aldous has asked Ruth for a briefing on your first month.
- else: Dr Aldous has asked for an update at the next board meeting.
}
For your tutorial # h
Each person you met described a different problem that the navigator program was meant to solve. Whose problem did you decide it was, and who wasn't in a position to say? # prompt
Three people acted this week without hearing from you. What did that cost, and could you have known it would? # prompt
You gave one main reason for your recommendation. Which of the other two would you have been comfortable explaining to the program's clients? # prompt
-> END
