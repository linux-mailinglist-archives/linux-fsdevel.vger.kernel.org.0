Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F897570DA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 00:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiGKWyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 18:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiGKWxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:53:55 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590AF1FCE5;
        Mon, 11 Jul 2022 15:53:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 552285C0109;
        Mon, 11 Jul 2022 18:53:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 11 Jul 2022 18:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1657580019; x=1657666419; bh=OWMNCiMshG
        CbUz9lAfEF/JWSjFpLXHlsLN4f/iMH2mE=; b=IqOri0z6hq5cF5iK4coRF5GDpy
        61Gd760sxVQcXiyPaadgz+8r0ips4sZEL48rI7gC29P5LWs7+BVMYrYfURAI46y4
        0A6CoB5Ab/cTVm8/7gX+jtexEco0SSSBmdKq1QItDyaT5GCu+Aplk3MYd4XM497e
        0HLcSdLh6EbgJPvRjTZWMTDCLut8/QfnQU4HO4vnBPk/y1pNhwq8MeP0NeoKGMhe
        udwidarD19/rpQ4rHL7qGAAmH54ykiK+E0a9GZCxUVYXw0EB9JGoSctxHqCu61r1
        1OTjFS40AWrIhV6TU6WOTixcU2+jwHFsRbkUNf16XmHt0XGedIJBD2EEo2Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657580019; x=1657666419; bh=OWMNCiMshGCbUz9lAfEF/JWSjFpL
        XHlsLN4f/iMH2mE=; b=p+KcdVphQTxK1IG1K3akETmCc98R44Tnsp++gka1bWVm
        HPlDx4An6mgCM2ZXgNsas1vz7sEtGThKVzyZ0tk/9oNoPI3EJr5G7UbTjCJwKixd
        UHR3FaguzcZwlDGA0Ivru5lbV4ICWT7USrfIvxCvMp80qzOFmHp+LSN7KoUv3lkT
        mOsm+ad7xrhY6Saxw3FZCxnbGFnKVFnI6r5x8iuvdD/iOWsIM6OIa6s+zc/aQ6dQ
        fDH/f9CKw4XXBRZfkYersVI3ASOWsFIpjxa5/7gSbsfpUIR9UVr1J/eoHT7qDd3m
        qy6CPVQNli+J3Jdn0GetL9Pbzc6IBPmuJdqsKn6Usw==
X-ME-Sender: <xms:86nMYu6WaQeikMEwPUiQD6bUbCAi0B_W1G_r5rcZ2lNBxOrCN0xCTg>
    <xme:86nMYn4z7dSbj8mSKOH0KTx3Z8slbOgtrqojFfAQvcPucHUWWMeMko7XQ4C_-XsDW
    vkzMg6gxy2oURTSX4c>
X-ME-Received: <xmr:86nMYtd4yniFoTJSx2sQfgcBocYVowjJX-spRebK8p3ikv2ijHO8C99f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejgedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:86nMYrIJ3nNZPnBIUFF8dGs1-fwCHl4SjdilUpzOFwaPe1VQydybFA>
    <xmx:86nMYiLRm1rNVli-n2boei50J-ZvlysV3JazX4G0JmyD5VvjOwxPTg>
    <xmx:86nMYswze1pfxu47-w-Kltw-SequuCTPERBxeFABArpCpovEROdFDQ>
    <xmx:86nMYnFA-u9A1eWOE9-jfFK3EodMLCYg1poGt599iSWkWP82DfZGQw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Jul 2022 18:53:37 -0400 (EDT)
Date:   Mon, 11 Jul 2022 16:53:36 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: strange interaction between fuse + pidns
Message-ID: <Ysyp8Kbl8FzhApUb@netflix>
References: <YrShFXRLtRt6T/j+@risky>
 <CAJfpegvH1EMS_469yOyUP9f=eCAEqzhyngm7h=YLRExeRdPEaw@mail.gmail.com>
 <CAJfpegurW7==LEp2yXWMYdBYXTZN4HCMMVJPu-f8yvHVbu79xQ@mail.gmail.com>
 <YsyHMVLuT5U6mm+I@netflix>
 <877d4jbabb.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d4jbabb.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 11, 2022 at 04:37:12PM -0500, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
> 
> > Hi all,
> >
> > On Mon, Jul 11, 2022 at 03:59:15PM +0200, Miklos Szeredi wrote:
> >> On Mon, 11 Jul 2022 at 12:35, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >> >
> >> > Can you try the attached untested patch?
> >> 
> >> Updated patch to avoid use after free on req->args.
> >> 
> >> Still mostly untested.
> >
> > Thanks, when I applied your patch, I still ended up with tasks stuck
> > waiting with a SIGKILL pending. So I looked into that and came up with
> > the patch below. With both your patch and mine, my testcase exits
> > cleanly.
> >
> > Eric (or Christian, or anyone), can you comment on the patch below? I
> > have no idea what this will break. Maybe instead a better approach is
> > some additional special case in __send_signal_locked()?
> >
> > Tycho
> >
> > From b7ea26adcf3546be5745063cc86658acb5ed37e9 Mon Sep 17 00:00:00 2001
> > From: Tycho Andersen <tycho@tycho.pizza>
> > Date: Mon, 11 Jul 2022 11:26:58 -0600
> > Subject: [PATCH] sched: __fatal_signal_pending() should also check shared
> >  signals
> >
> > The wait_* code uses signal_pending_state() to test whether a thread has
> > been interrupted, which ultimately uses __fatal_signal_pending() to detect
> > if there is a fatal signal.
> >
> > When a pid ns dies, in zap_pid_ns_processes() it does:
> >
> >     group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
> >
> > for all the tasks in the pid ns. That calls through:
> >
> >     group_send_sig_info() ->
> >       do_send_sig_info() ->
> >         send_signal_locked() ->
> >           __send_signal_locked()
> >
> > which does:
> >
> >     pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
> >
> > which puts sigkill in the set of shared signals, but not the individual
> > pending ones. If tasks are stuck in a killable wait (e.g. a fuse flush
> > operation), they won't see this shared signal, and will hang forever, since
> > TIF_SIGPENDING is set, but the fatal signal can't be detected.
> 
> Hmm.
> 
> That is perplexing.

Thanks for taking a look.

> __send_signal_locked calls complete_signal.  Then if any of the tasks of
> the process can receive the signal, complete_signal will loop through
> all of the tasks of the process and set the per thread SIGKILL.  Pretty
> much by definition tasks can always receive SIGKILL.
> 
> Is complete_signal not being able to do that?

In my specific case it was because my testcase was already trying to
exit and had set PF_EXITING when the signal is delivered, so
complete_signal() was indeed not able to do that since PF_EXITING is
checked before SIGKILL in wants_signal().

But I changed my testacase to sleep instead of exit, and I get the
same hang behavior, even though complete_signal() does add SIGKILL to
the set. So there's something else going on there...

> The patch below really should not be necessary, and I have pending work
> that if I can push over the finish line won't even make sense.
> 
> As it is currently an abuse to use the per thread SIGKILL to indicate
> that a fatal signal has been short circuit delivered.  That abuse as
> well as being unclean tends to confuse people reading the code.

How close is your work? I'm wondering if it's worth investigating the
non-PF_EXITING case further, or if we should just land this since it
fixes the PF_EXITING case as well. Or maybe just do something like
this in addition:

diff --git a/kernel/signal.c b/kernel/signal.c
index 6f86fda5e432..0f71dfb1c3d2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -982,12 +982,12 @@ static inline bool wants_signal(int sig, struct task_struct *p)
        if (sigismember(&p->blocked, sig))
                return false;

-       if (p->flags & PF_EXITING)
-               return false;
-
        if (sig == SIGKILL)
                return true;

+       if (p->flags & PF_EXITING)
+               return false;
+
        if (task_is_stopped_or_traced(p))
                return false;

?

Tycho
