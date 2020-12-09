Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085F22D4CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 22:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbgLIVeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 16:34:12 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:46476 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732223AbgLIVeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:34:01 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn75K-005T3u-9k; Wed, 09 Dec 2020 14:33:18 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn75J-0006rx-EK; Wed, 09 Dec 2020 14:33:18 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
        <20201120231441.29911-15-ebiederm@xmission.com>
        <20201207232900.GD4115853@ZenIV.linux.org.uk>
        <877dprvs8e.fsf@x220.int.ebiederm.org>
        <20201209040731.GK3579531@ZenIV.linux.org.uk>
        <877dprtxly.fsf@x220.int.ebiederm.org>
        <20201209142359.GN3579531@ZenIV.linux.org.uk>
        <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
        <20201209195033.GP3579531@ZenIV.linux.org.uk>
Date:   Wed, 09 Dec 2020 15:32:38 -0600
In-Reply-To: <20201209195033.GP3579531@ZenIV.linux.org.uk> (Al Viro's message
        of "Wed, 9 Dec 2020 19:50:33 +0000")
Message-ID: <87sg8er7gp.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kn75J-0006rx-EK;;;mid=<87sg8er7gp.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UzOWmGe9SV576lXWAKwEdqLp/GDuaw78=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 496 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 10 (2.0%), parse: 1.17
        (0.2%), extract_message_metadata: 17 (3.4%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-1000: 16 (3.2%), tests_pri_-950: 1.37 (0.3%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 202 (40.8%), check_bayes:
        200 (40.3%), b_tokenize: 8 (1.6%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 178 (35.9%), b_finish: 0.69
        (0.1%), tests_pri_0: 230 (46.5%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 22 (4.5%), poll_dns_idle: 21 (4.2%), tests_pri_10:
        1.70 (0.3%), tests_pri_500: 10 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] files: rcu free files_struct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Dec 09, 2020 at 11:13:38AM -0800, Linus Torvalds wrote:
>> On Wed, Dec 9, 2020 at 10:05 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >
>> > -                               struct file * file = xchg(&fdt->fd[i], NULL);
>> > +                               struct file * file = fdt->fd[i];
>> >                                 if (file) {
>> > +                                       rcu_assign_pointer(fdt->fd[i], NULL);
>> 
>> This makes me nervous. Why did we use to do that xchg() there? That
>> has atomicity guarantees that now are gone.
>> 
>> Now, this whole thing should be called for just the last ref of the fd
>> table, so presumably that atomicity was never needed in the first
>> place. But the fact that we did that very expensive xchg() then makes
>> me go "there's some reason for it".
>> 
>> Is this xchg() just bogus historical leftover? It kind of looks that
>> way. But maybe that change should be done separately?
>
> I'm still not convinced that exposing close_files() to parallel
> 3rd-party accesses is safe in all cases, so this patch still needs
> more analysis.

That is fine.  I just wanted to post the latest version so we could
continue the discussion.  Especially with comments etc.

> And I'm none too happy about "we'll fix the things
> up at the tail of the series" - the changes are subtle enough and
> the area affected is rather fundamental.  So if we end up returning
> to that several years from now while debugging something, I would
> very much prefer to have the transformation series as clean and
> understandable as possible.  It's not just about bisect hazard -
> asking yourself "WTF had it been done that way, is there anything
> subtle I'm missing here?" can cost many hours of head-scratching,
> IME.

Fair enough.  I don't expect anyone is basing anything on that branch,
so a rebase is possible.

Now removing the pounding on task_lock isn't about correctness, and it
is not fixing a performance problem anyone has measured at this point.
So I do think it should be a follow on.  If for no other reason than to
keep the problem small enough it can fit in heads.

Similarly the dnotify stuff.  Your description certain makes it look
fishy but that the questionable parts are orthogonal to my patches.

> Eric, I understand that you want to avoid reordering/folding, but
> in this case it _is_ needed.  It's not as if there had been any
> serious objections to the overall direction of changes; it's
> just that we need to get that as understandable as possible.

I will post the patch that will become -1/24 in a moment.

Eric



