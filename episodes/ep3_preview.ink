// Episode 3 (Week 3): opening only, to show how a save code from Episode 1
// changes what a returning player reads. The rest of Episode 3 is not written.

INCLUDE ../shared/ledger.ink

Month three # h
{ code_loaded && done_ep1:
    Three months into the job, the Authority has a logo, an extension list and a reputation that is still forming.
- else:
    You are three months into the job as the first chief executive of the Tallowfield Integrated Care Authority. You have run services before, but not this one.
}
Since spring, most of the Authority's attention has gone to older people who move between the emergency department and home. The work showed how much of that problem sits in aged care, which the Authority does not fund and cannot direct.
{ nav_fate:
- 0: The Care Navigator Program, inherited from the old partnership, was extended for twelve months while a further review is done.
- 1: The Care Navigator Program was extended for twelve months with a proper evaluation. The evaluators start next week, and Leila Karimi has already sent them a list of what the last evaluation missed.
- 2: The Care Navigator Program is halfway through its redesign. Tom Nguyen's practice has been testing the phone referral, and so far someone answers it.
- 3: The navigators now work from Tallowfield Hospital. Referrals from the emergency department have doubled. Referrals from general practice have nearly stopped.
- 4: The Care Navigator Program has closed. The discharge team is busy. The Primary Health Network's $1.6 million is still unspent, and Priya Raman's letter is still on file.
}
{ ep1_reason == 3:
    Dr Aldous has not forgotten that you promised the board something it could see.
}
{ ep1_reason == 1 && code_loaded:
    Your habit of saying what the evidence does not show has been noticed. Not everyone likes it.
}
{ partner_phn <= 2:
    Priya Raman now sends a colleague to most meetings with the Authority.
}
{ partner_lhd >= 6:
    Simon Rafferty has started calling you before announcements, not after.
}
{ ep1_ams_contacted == 1:
    [Placeholder, pending review by Aboriginal colleagues: a callback to the note the player sent the Aboriginal Medical Service in week one.] # placeholder
}
Dr Judith Aldous needs a one-page analysis of the region for the Authority's first quarterly report to the Minister's office. It is due on Friday.
Ruth Okonkwo puts the inherited SWOT on your desk. Its first strength is "strong stakeholder relationships". Its first weakness is "limited resources".
"It could describe anywhere in the country," she says. "That might be the problem."
The rest of Episode 3 is not written yet. This preview shows how a save code from Episode 1 changes the opening for a returning player. Try it with and without a code. # quiet
-> END
