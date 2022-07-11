Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43259570DE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 01:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiGKXGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 19:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiGKXGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:06:30 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D7582468;
        Mon, 11 Jul 2022 16:06:29 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:33566)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB2U0-00G8Wy-Ii; Mon, 11 Jul 2022 17:06:28 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:50226 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB2Tz-00H9Z1-HN; Mon, 11 Jul 2022 17:06:28 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YrShFXRLtRt6T/j+@risky>
        <CAJfpegvH1EMS_469yOyUP9f=eCAEqzhyngm7h=YLRExeRdPEaw@mail.gmail.com>
        <CAJfpegurW7==LEp2yXWMYdBYXTZN4HCMMVJPu-f8yvHVbu79xQ@mail.gmail.com>
        <YsyHMVLuT5U6mm+I@netflix>
        <877d4jbabb.fsf@email.froward.int.ebiederm.org>
        <Ysyp8Kbl8FzhApUb@netflix>
Date:   Mon, 11 Jul 2022 18:06:21 -0500
In-Reply-To: <Ysyp8Kbl8FzhApUb@netflix> (Tycho Andersen's message of "Mon, 11
        Jul 2022 16:53:36 -0600")
Message-ID: <87zghf6yhe.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oB2Tz-00H9Z1-HN;;;mid=<87zghf6yhe.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+OGEb0wlua6M1IrlcGe+enGRiKgOw6Ni0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 497 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (0.8%), b_tie_ro: 2.7 (0.5%), parse: 0.74
        (0.1%), extract_message_metadata: 13 (2.7%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-1000: 11 (2.2%), tests_pri_-950: 0.99 (0.2%),
        tests_pri_-900: 0.79 (0.2%), tests_pri_-90: 79 (15.8%), check_bayes:
        77 (15.6%), b_tokenize: 8 (1.6%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 55 (11.1%), b_finish: 0.66
        (0.1%), tests_pri_0: 377 (75.8%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 1.28 (0.3%), poll_dns_idle: 0.12 (0.0%),
        tests_pri_10: 1.75 (0.4%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: strange interaction between fuse + pidns
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tycho Andersen <tycho@tycho.pizza> writes:

> On Mon, Jul 11, 2022 at 04:37:12PM -0500, Eric W. Biederman wrote:
>> Tycho Andersen <tycho@tycho.pizza> writes:
>> 
>> > Hi all,
>> >
>> > On Mon, Jul 11, 2022 at 03:59:15PM +0200, Miklos Szeredi wrote:
>> >> On Mon, 11 Jul 2022 at 12:35, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> >> >
>> >> > Can you try the attached untested patch?
>> >> 
>> >> Updated patch to avoid use after free on req->args.
>> >> 
>> >> Still mostly untested.
>> >
>> > Thanks, when I applied your patch, I still ended up with tasks stuck
>> > waiting with a SIGKILL pending. So I looked into that and came up with
>> > the patch below. With both your patch and mine, my testcase exits
>> > cleanly.
>> >
>> > Eric (or Christian, or anyone), can you comment on the patch below? I
>> > have no idea what this will break. Maybe instead a better approach is
>> > some additional special case in __send_signal_locked()?
>> >
>> > Tycho
>> >
>> > From b7ea26adcf3546be5745063cc86658acb5ed37e9 Mon Sep 17 00:00:00 2001
>> > From: Tycho Andersen <tycho@tycho.pizza>
>> > Date: Mon, 11 Jul 2022 11:26:58 -0600
>> > Subject: [PATCH] sched: __fatal_signal_pending() should also check shared
>> >  signals
>> >
>> > The wait_* code uses signal_pending_state() to test whether a thread has
>> > been interrupted, which ultimately uses __fatal_signal_pending() to detect
>> > if there is a fatal signal.
>> >
>> > When a pid ns dies, in zap_pid_ns_processes() it does:
>> >
>> >     group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
>> >
>> > for all the tasks in the pid ns. That calls through:
>> >
>> >     group_send_sig_info() ->
>> >       do_send_sig_info() ->
>> >         send_signal_locked() ->
>> >           __send_signal_locked()
>> >
>> > which does:
>> >
>> >     pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
>> >
>> > which puts sigkill in the set of shared signals, but not the individual
>> > pending ones. If tasks are stuck in a killable wait (e.g. a fuse flush
>> > operation), they won't see this shared signal, and will hang forever, since
>> > TIF_SIGPENDING is set, but the fatal signal can't be detected.
>> 
>> Hmm.
>> 
>> That is perplexing.
>
> Thanks for taking a look.
>
>> __send_signal_locked calls complete_signal.  Then if any of the tasks of
>> the process can receive the signal, complete_signal will loop through
>> all of the tasks of the process and set the per thread SIGKILL.  Pretty
>> much by definition tasks can always receive SIGKILL.
>> 
>> Is complete_signal not being able to do that?
>
> In my specific case it was because my testcase was already trying to
> exit and had set PF_EXITING when the signal is delivered, so
> complete_signal() was indeed not able to do that since PF_EXITING is
> checked before SIGKILL in wants_signal().
>
> But I changed my testacase to sleep instead of exit, and I get the
> same hang behavior, even though complete_signal() does add SIGKILL to
> the set. So there's something else going on there...
>
>> The patch below really should not be necessary, and I have pending work
>> that if I can push over the finish line won't even make sense.
>> 
>> As it is currently an abuse to use the per thread SIGKILL to indicate
>> that a fatal signal has been short circuit delivered.  That abuse as
>> well as being unclean tends to confuse people reading the code.
>
> How close is your work? I'm wondering if it's worth investigating the
> non-PF_EXITING case further, or if we should just land this since it
> fixes the PF_EXITING case as well. Or maybe just do something like
> this in addition:

It is not different enough to change the semantics.  What I am aiming
for is having a dedicated flag indicating a task will exit, that
fatal_signal_pending can check.  And I intend to make that flag one way
so that once it is set it will never be cleared.

Which sort of argues against your patch below.

It most definitely does not sort out the sleep case.


The other thing I have played with that might be relevant was removing
the explicit wait in zap_pid_ns_processes and simply not allowing wait
to reap the pid namespace init until all it's children had been reaped.
Essentially how we deal with the thread group leader for ordinary
processes.  Does that sound like it might help in the fuse case?

I am not certain how far such a change would be (it has been a couple
years since I played with implementing it) but it can be made much
sooner if it demonstratively breaks some dead-locks, and generally makes
the kernel easier to maintain.

Eric
