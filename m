Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD262CFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 02:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfGIAOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 20:14:00 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57422 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfGIAOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:14:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hkdle-0003Yp-4l; Mon, 08 Jul 2019 18:13:58 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hkdld-0000Hx-6V; Mon, 08 Jul 2019 18:13:57 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
        <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
        <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
        <20190708131831.GT17978@ZenIV.linux.org.uk>
        <874l3wo3gq.fsf@xmission.com>
        <20190708180132.GU17978@ZenIV.linux.org.uk>
        <20190708202124.GX17978@ZenIV.linux.org.uk>
Date:   Mon, 08 Jul 2019 19:13:33 -0500
In-Reply-To: <20190708202124.GX17978@ZenIV.linux.org.uk> (Al Viro's message of
        "Mon, 8 Jul 2019 21:21:24 +0100")
Message-ID: <87pnmkhxoy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hkdld-0000Hx-6V;;;mid=<87pnmkhxoy.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19lXMlz1gf1ewdMm7N8JUU30PMjddK1ff4=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 526 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.1 (0.6%), b_tie_ro: 2.1 (0.4%), parse: 1.08
        (0.2%), extract_message_metadata: 13 (2.5%), get_uri_detail_list: 2.3
        (0.4%), tests_pri_-1000: 8 (1.6%), tests_pri_-950: 1.44 (0.3%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 28 (5.3%), check_bayes: 26
        (5.0%), b_tokenize: 9 (1.7%), b_tok_get_all: 9 (1.7%), b_comp_prob:
        3.2 (0.6%), b_tok_touch_all: 3.2 (0.6%), b_finish: 0.62 (0.1%),
        tests_pri_0: 452 (85.8%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.54 (0.1%), tests_pri_10:
        3.3 (0.6%), tests_pri_500: 11 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts around
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Jul 08, 2019 at 07:01:32PM +0100, Al Viro wrote:
>> On Mon, Jul 08, 2019 at 12:12:21PM -0500, Eric W. Biederman wrote:
>> 
>> > Al you do realize that the TOCTOU you are talking about comes the system
>> > call API.  TOMOYO can only be faulted for not playing in their own
>> > sandbox and not reaching out and fixing the vfs implementation details.
>
> PS: the fact that mount(2) has been overloaded to hell and back (including
> MS_MOVE, which goes back to v2.5.0.5) predates the introduction of ->sb_mount()
> and LSM in general (2.5.27).  MS_BIND is 2.4.0-test9pre2.
>
> In all the years since the introduction of ->sb_mount() I've seen zero
> questions from LSM folks regarding a sane place for those checks.  What I have
> seen was "we want it immediately upon the syscall entry, let the module
> figure out what to do" in reply to several times I tried to tell them "folks,
> it's called in a bad place; you want the checks applied to objects, not to
> raw string arguments".
>
> As it is, we have easily bypassable checks on mount(2) (by way of ->sb_mount();
> there are other hooks also in the game for remounts and new mounts).
>
> I see no point whatsoever trying to duplicate ->sb_mount() on the top level
> of move_mount(2).  When and if sane checks are agreed upon for that thing,
> they certainly should be used both for MS_MOVE case of mount(2) and for
> move_mount(2).  And that'll come for free from calling those in do_move_mount().
> They won't be the first thing called in mount(2) - we demultiplex first,
> decide that we have a move and do pathname resolution on source.  And that's
> precisely what we need to avoid the TOCTOU there.
>
> I'm sorry, but this "run the hook at the very beginning, the modules know
> better what they want, just give them as close to syscall arguments as
> possible before even looking at the flags" model is wrong, plain and simple.
>
> As for the MS_MOVE checks, the arguments are clear enough (two struct path *,
> same as what we pass to do_move_mount()).  AFAICS, only tomoyo and
> apparmor are trying to do anything for MS_MOVE in ->sb_mount(), and both
> look like it should be easy enough to implement what said checks intend
> to do (probably - assuming that aa_move_mount() doesn't depend upon
> having its kern_path() inside the __begin_current_label_crit_section()/
> __end_current_label_crit_section() pair; looks like it shouldn't be,
> but that's for apparmor folks to decide).
>
> That's really for LSM folks, though - I've given up on convincing
> (or even getting a rationale out of) them on anything related to hook
> semantics years ago.

I have found the LSM folks in recent years to be rather reasonable,
especially when something concrete has been proposed.

A quick look suggests that the new security_mount_move is a reasonable
hook for the mount_move check.

Tetsuo, do you think you can implement the checks you need for Tomoyo
for mount_move on top of the new security_mount_move?

Al is proposing that similar hooks be added for the other subcases of
mount so that less racy hooks can be implemented.  Tetsuo do you have
any problem with that?

Tetsuo whatever the virtues of this patchset getting merged into Linus's
tree it is merged now, so the only thing we can do now is roll up our
sleeves go through everything and fix the regressions/bugs/issues that
have emerged with the new mount api.

Eric



