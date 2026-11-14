// Module 2 (course Weeks 3 and 4): opening only, to show how a save code from Module 1
// changes what a returning player reads and what they have to work with.
// The rest of Module 2 is not written.

INCLUDE ../shared/ledger.ink

Month three # h
{ code_loaded && done_m1:
    You are three months into the job.
- else:
    You are three months into the job as the first chief executive of the Tallowfield Integrated Care Authority.
}
Since you started, most of the Authority's work has been on older people who keep coming back to the emergency department. A lot of the problem turned out to be in aged care, which the Authority doesn't fund and can't direct.
{ nav_fate:
- 0: The Clinical Navigator Program, which the Authority inherited, was extended for twelve months while it is reviewed.
- 1:
    { m1_board == 2:
        The Clinical Navigator Program has three months of its six-month extension left, and the board is still waiting for the evaluation plan.
    - else:
        The Clinical Navigator Program was extended for twelve months with an evaluation. The evaluators start next week, and Leila Karimi has already sent them a list of what the last evaluation didn't measure.
    }
- 2:
    { m1_board == 2:
        The Clinical Navigator Program's redesign is finished, but its funding runs out next month. The GP clinical council has the design on its agenda for next week.
    - else:
        The Clinical Navigator Program is halfway through its redesign. Tom Nguyen's practice is trialling the phone referral, and so far someone answers it.
    }
- 3:
    { m1_board == 2:
        The move of the Clinical Navigator Program to the hospital is still waiting on the LHD's budget. Most of the navigators have gone.
    - else:
        The Clinical Navigators now work from Tallowfield Hospital. Referrals from the emergency department have doubled, and referrals from general practice have nearly stopped.
    }
- 4:
    { m1_board == 3:
        The board deferred the navigator decision twice more before closing the program last month. The PHN's $1.6 million is still on hold, and Priya Raman's letter is still on file.
    - else:
        The Clinical Navigator Program has closed and the discharge team is busy. The PHN has recommissioned its $1.6 million, and nobody at the Authority was asked how.
    }
}
{ m1_ams_contacted == 1:
    You met Dianne Cooper, CEO of the Aboriginal Medical Service, a month after the note you sent in your first week. She has asked to see the Authority's draft priorities before the next meeting, not after it.
}
Dr Judith Aldous needs a one-page analysis of the region for the Authority's first quarterly report to the Minister's office. It's due on Friday.
Ruth Okonkwo gives you the SWOT analysis that came over from the old partnership. The first strength listed is "strong stakeholder relationships". The first weakness is "limited resources".
"Most of it could have been written about any region," she says. "The board will notice. What can we actually get our hands on by Friday?"
What you have to work with # h
{
- partner_phn >= 5: Priya Raman has offered the PHN's general practice data for the brief, with a note on what it can and can't show.
- partner_phn <= 2: Priya Raman says the PHN can't share its general practice data until the funding question is settled.
- else: The PHN will share its general practice data, but not before the end of the month.
}
{
- partner_lhd >= 5 || trust_hospital >= 6: Fiona McAllister's team will pull the emergency department data you need by Wednesday.
- else: The LHD's data request form says to allow ten working days.
}
{
- (nav_fate == 1 || nav_fate == 2) && m1_board == 1: Leila Karimi can give you three years of client data from the navigator program.
- nav_fate == 4: The navigator program's client records went to the LHD when it closed, and nobody has had time to look at them.
- else: The navigator program's client data is there, but Leila Karimi is short-staffed and can't pull it this week.
}
{ m1_ams_contacted == 1:
    Dianne Cooper has said the Service will talk about what it knows, but its data stays with the Service.
- else:
    You don't yet have a way to ask the Aboriginal Medical Service what it knows.
}
The rest of Module 2 is not written yet. Try this opening with and without a code from Module 1 to see what changes. # quiet
-> END
