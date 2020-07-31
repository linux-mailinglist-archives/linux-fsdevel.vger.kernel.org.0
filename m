Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440DD234A2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgGaRTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 13:19:43 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59002 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732817AbgGaRTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:19:42 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1Yh1-005yTT-FM; Fri, 31 Jul 2020 11:19:39 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1Yh0-0005CV-Mh; Fri, 31 Jul 2020 11:19:39 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
        <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
        <87d04fhkyz.fsf@x220.int.ebiederm.org>
        <87h7trg4ie.fsf@x220.int.ebiederm.org>
        <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
        <878sf16t34.fsf@x220.int.ebiederm.org>
        <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wjMcHGDh8Wx+dwaYHOGVNN+zzCPEKZEc5qb3spsEydNKg@mail.gmail.com>
Date:   Fri, 31 Jul 2020 12:16:29 -0500
In-Reply-To: <CAHk-=wjMcHGDh8Wx+dwaYHOGVNN+zzCPEKZEc5qb3spsEydNKg@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 30 Jul 2020 16:17:50 -0700")
Message-ID: <87pn8by58y.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k1Yh0-0005CV-Mh;;;mid=<87pn8by58y.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/myGxaPwVa4s7NNKG9jDuSCrMBG7MsRNg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMBody_17,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XMBody_17 BODY: Spammy words in all caps
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 426 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.9%), b_tie_ro: 11 (2.5%), parse: 1.22
        (0.3%), extract_message_metadata: 16 (3.9%), get_uri_detail_list: 2.5
        (0.6%), tests_pri_-1000: 14 (3.2%), tests_pri_-950: 1.34 (0.3%),
        tests_pri_-900: 1.14 (0.3%), tests_pri_-90: 154 (36.1%), check_bayes:
        139 (32.7%), b_tokenize: 6 (1.5%), b_tok_get_all: 10 (2.3%),
        b_comp_prob: 3.4 (0.8%), b_tok_touch_all: 114 (26.7%), b_finish: 1.49
        (0.4%), tests_pri_0: 213 (50.1%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 3.1 (0.7%), poll_dns_idle: 1.22 (0.3%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] exec: Conceal the other threads from wakeups during exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Jul 30, 2020 at 4:00 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The key is the function make_task_wakekill which could probably
>> benefit from a little more review and refinement but appears to
>> be basically correct.
>
> You really need to explain a lot more why you think this is all a good idea.
>
> For example, what if one of those other threads is waiting in line for
> a critical lock, and the wait-queue you basically disabled was the
> exclusive wait after lock handoff?
>
> That means that the lock will now effectively be held by that thread.
> No, it wasn't woken up, but it had the lock handed to it, and it's now
> entirely unresponsive until it is killed.
>
> How is that different from the deadlocks you're actually trying to fix?
>
> These are the kinds of problems that the freezer() code had too, with
> freezing things that held locks etc.
>
> This approach does seem better than the freezer thing, and if I read
> it right it will gather things in the signal handler code, but it's
> not obvious that gathering them in random places where they sleep for
> random reasons is safe or a good idea.
>
> I can imagine _so_ many dead systems if you just basically froze
> something that holds the mmap lock and is sleeping on a page fault,
> for example.
>
> Maybe I'm missing something, but I really think your "let's freeze
> things" is seriously misguided. You're concentrating on some small
> problem and trying to solve that, and not seeign the HUGE HONKING
> problems that your approach is fundamentally introducing.

Very good point.  That would be a priority inversion on mmap_lock.
Without great care that could indeed result in lockups.

That definitely requires the points where things are already sleeping
that can be converted to be opt-in.  Which potentially makes things much
more work.

Thanks, that helps kill my bright idea as I expressed it.

Part of what I was trying to solve (because I ran into the problem while
I was reading the code) was that the freezer, the cgroup v2 freezer, and
other waits do not compose nicely.

Even limited to opt-in locations I think the trick of being able to
transform the wait-state may solve that composition problem.


That said I was really just posting this so if the ideas were good they
could inspire future code, and if the ideas were bad they could be sunk.
When it comes to sorting out future especially in exec I will know which
ideas don't fly, so it will be easier to make the case for ideas that
will work.

Eric

