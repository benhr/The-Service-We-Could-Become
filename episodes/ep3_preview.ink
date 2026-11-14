// Episode 3 (Week 3): opening only, to show how a save code from Episode 1
// changes what a returning player reads. The rest of Episode 3 is not written.

INCLUDE ../shared/ledger.ink

October # h
{ code_loaded && done_ep1:
    You are three months into the job.
- else:
    You are three months into the job as the first chief executive of the Tallowfield Integrated Care Authority, which started on 1 July.
}
Since July, most of the Authority's work has been on older people who keep coming back to the emergency department. A lot of the problem turned out to be in aged care, which the Authority doesn't fund and can't direct.
{ nav_fate:
- 0: The Care Navigator Program, which the Authority inherited, was extended for twelve months while it is reviewed.
- 1: The Care Navigator Program was extended for twelve months with an evaluation. The evaluators start next week, and Leila Karimi has already sent them a list of what the last evaluation didn't measure.
- 2: The Care Navigator Program is halfway through its redesign. Tom Nguyen's practice is trialling the phone referral, and so far someone answers it.
- 3: The navigators now work from Tallowfield Hospital. Referrals from the emergency department have doubled, and referrals from general practice have nearly stopped.
- 4: The Care Navigator Program has closed and the discharge team is busy. The PHN's $1.6 million is still unallocated, and Priya Raman's letter is still on file.
}
{ ep1_reason == 3:
    Dr Aldous has mentioned twice that the Minister's office wants to see results before the end of the year.
}
{ ep1_reason == 1 && code_loaded:
    Board members now ask for the evidence behind each recommendation, as you gave it in your first board paper.
}
{ partner_phn <= 2:
    Priya Raman now sends one of her managers to most meetings with the Authority.
}
{ partner_lhd >= 6:
    Simon Rafferty has started ringing you before the LHD makes announcements.
}
{ ep1_ams_contacted == 1:
    You met Dianne Cooper, CEO of the Aboriginal Medical Service, in August, after the note you sent in your first week. She has asked to see the Authority's draft priorities before the next meeting, not after it.
}
Dr Judith Aldous needs a one-page analysis of the region for the Authority's first quarterly report to the Minister's office. It's due on Friday.
Ruth Okonkwo gives you the SWOT analysis that came over from the old partnership. The first strength listed is "strong stakeholder relationships". The first weakness is "limited resources".
"Most of it could have been written about any region," she says. "The board will notice."
The rest of Episode 3 is not written yet. Try this opening with and without a code from Episode 1 to see what changes. # quiet
-> END
