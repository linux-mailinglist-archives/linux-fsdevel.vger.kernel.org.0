Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364E9234BFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 22:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgGaUKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 16:10:22 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38444 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaUKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:10:21 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1bMB-004Bqh-An; Fri, 31 Jul 2020 14:10:19 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1bM9-0003KN-MC; Fri, 31 Jul 2020 14:10:18 -0600
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
        <87pn8by58y.fsf@x220.int.ebiederm.org>
        <CAHk-=wh_5Lu_3OACT4pSqrf1eJ3=PR_fUjL1vLSbBZM2_OAC5w@mail.gmail.com>
Date:   Fri, 31 Jul 2020 15:07:07 -0500
In-Reply-To: <CAHk-=wh_5Lu_3OACT4pSqrf1eJ3=PR_fUjL1vLSbBZM2_OAC5w@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 31 Jul 2020 10:41:48 -0700")
Message-ID: <87tuxnwis4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k1bM9-0003KN-MC;;;mid=<87tuxnwis4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX198s0rrR4a+N9N2dvHxXsg20KO1oB//4cY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 476 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (2.0%), parse: 1.26 (0.3%),
         extract_message_metadata: 17 (3.5%), get_uri_detail_list: 3.5 (0.7%),
        tests_pri_-1000: 14 (2.9%), tests_pri_-950: 1.21 (0.3%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 113 (23.7%), check_bayes:
        111 (23.3%), b_tokenize: 10 (2.1%), b_tok_get_all: 11 (2.3%),
        b_comp_prob: 3.3 (0.7%), b_tok_touch_all: 83 (17.4%), b_finish: 0.91
        (0.2%), tests_pri_0: 304 (63.9%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 9 (1.9%), poll_dns_idle: 0.33 (0.1%), tests_pri_10:
        2.9 (0.6%), tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] exec: Conceal the other threads from wakeups during exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jul 31, 2020 at 10:19 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Even limited to opt-in locations I think the trick of being able to
>> transform the wait-state may solve that composition problem.
>
> So the part I found intriguing was the "catch things in the signal
> handling path".
>
> Catching things there - and *only* there - would avoid a lot of the
> problems we had with the freezer. When you're about to return to user
> mode, there are no lock inversions etc.
>
> And it kind of makes conceptual sense to do, since what you're trying
> to capture is the signal group - so using the signal state to do so
> seems like a natural thing to do. No touching of any runqueues or
> scheduler data structures, do everything _purely_ with the signal
> handling pathways.
>
> So that "feels" ok to me.
>
> That said, I do wonder if there are nasty nasty latency issues with
> odd users. Normally, you'd expect that execve() with other threads in
> the group shouldn't be a performance issue, because people simply
> shouldn't do that. So it might be ok.
>
> And if you capture them all in the signal handling pathway, that ends
> up being a very convenient place to zap them all too, so maybe my
> latency worry is misguided.
>
> IOW, I think that you could try to do your "freese other threads" not
> at all like the freezer, but more like a "collect all threads in their
> signal handler parts as the first phase of zapping them".
>
> So maybe this approach is salvageable. I see where something like the
> above could work well. But I say that with a lot of handwaving, and
> maybe if I see the patch I'd go "Christ, I was a complete idiot for
> ever even suggesting that".

Yes.

The tricky bit is that there are a handful of stops that must
be handled, or it is impossible to stop everything without causing
disruption if the exec fails.  The big ones are TASK_STOPPED and
TASK_TRACED.  There is another in wait_for_vfork_done.

At which point I am looking at writting a wrapper around schedule that
changes task state to something like TASK_WAKEKILL when asked, and then
restores the state when released.  Something that is independent of
which freezer the code is using.

It could be the scheduler to with a special bit in state that says
opt-in.  But if we have to opt in it is probably much less error
prone to write the code as an wrapper around schedule, and only
modify the core scheduling code if necessary.

If I can make TASK_STOPPED and TASK_TRACED handle spurious wake-ups
I think I can build something that is independent of the rest of the
freezers so the code doesn't have to go 3 deep on wrappers of different
freezer at those locations.  It is already 2 layers deep.

But I really don't intend to work on that again for a while.


Right now I am in the final stages of ressurecting:
https://lore.kernel.org/linux-fsdevel/87a7ohs5ow.fsf@xmission.com/

The hard part looks like cleaning up and resurrecting Oleg's patch
to prevent the abuse of files_struct->count.
https://lore.kernel.org/linux-fsdevel/20180915160423.GA31461@redhat.com/

I am close but dotting all of the i's and crossing all of the t's is
taking ab bit.

Eric
