// The ledger: variables that carry between modules through the save code.
// Declared once here. Modules read and change them; none defines its own copy.
// The web page sets these from a save code before the story starts.

VAR code_loaded = false

// Modules completed (done_m1 to done_m5). done_r2, r4, r6, r8 and r10 are
// reserved bits kept so the save code layout does not change.
VAR done_m1 = false
VAR done_r2 = false
VAR done_m2 = false
VAR done_r4 = false
VAR done_m3 = false
VAR done_r6 = false
VAR done_m4 = false
VAR done_r8 = false
VAR done_m5 = false
VAR done_r10 = false

// Tracks, 0 to 7. Bands: low 0-2, middle 3-5, high 6-7.
VAR trust_hospital = 4
VAR trust_primary = 4
VAR partner_lhd = 4
VAR partner_phn = 4
VAR partner_ams = 3
VAR community = 4
VAR confidence = 4

// Module 1 flags
VAR nav_fate = 0            // 0 unset, 1 retained, 2 reformed, 3 repositioned, 4 repurposed
VAR m1_ams_contacted = 0   // 0 no, 1 yes
VAR m1_reason = 0          // 0 unset, 1 evidence, 2 relationships, 3 visibility
VAR m1_board = 0           // 0 unset, 1 approved, 2 approved with conditions, 3 deferred

// Module 2 flags (provisional)
VAR brief_basis = 0
VAR ams_terms = 0
VAR brief_names_unknowns = 0
VAR m2_consumers_consulted = 0

// Module 3 flags (provisional)
VAR intake_path = 0
VAR gp_council_involved = 0
VAR allied_health_included = 0
VAR named_the_losses = 0
VAR intake_launched_early = 0

// Module 4 flags (provisional)
VAR plan_author = 0
VAR plan_stops_something = 0
VAR plan_ams_consulted = 0
VAR plan_shared_before_board = 0

// Module 5 flags (provisional)
VAR response_stance = 0
VAR outside_mandate_voices = 0
VAR coalition_built = 0
VAR staff_told_first = 0

// Reserved
VAR reserved_a = 0
VAR reserved_b = 0
VAR reserved_c = 0
VAR reserved_d = 0

// Clamp a track to 0..7 after a change.
=== function move(ref track, delta)
~ track = track + delta
{ track > 7:
    ~ track = 7
}
{ track < 0:
    ~ track = 0
}
