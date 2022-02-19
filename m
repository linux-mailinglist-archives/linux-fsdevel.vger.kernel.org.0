Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE24BC741
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 10:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiBSJyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 04:54:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbiBSJyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 04:54:37 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC1FB6EB37
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 01:54:17 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 19 Feb 2022 18:54:15 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 19 Feb 2022 18:54:15 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Sat, 19 Feb 2022 18:54:07 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [PATCH 00/16] DEPT(Dependency Tracker)
Message-ID: <20220219095407.GA10342@X58A-UD3R>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <Yg5u7dzUxL3Vkncg@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg5u7dzUxL3Vkncg@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 10:51:09AM -0500, Theodore Ts'o wrote:
> On Thu, Feb 17, 2022 at 07:57:36PM +0900, Byungchul Park wrote:
> > 
> > I've got several reports from the tool. Some of them look like false
> > alarms and some others look like real deadlock possibility. Because of
> > my unfamiliarity of the domain, it's hard to confirm if it's a real one.
> > Let me add the reports on this email thread.
> 
> The problem is we have so many potentially invalid, or
> so-rare-as-to-be-not-worth-the-time-to-investigate-in-the-
> grand-scheme-of-all-of-the-fires-burning-on-maintainers laps that it's
> really not reasonable to ask maintainers to determine whether

Even though I might have been wrong and might be gonna be wrong, you
look so arrogant. You were hasty to judge and trying to walk over me.

I reported it because I thought it was a real problem but couldn't
confirm it. For the other reports that I thought was not real, I didn't
even mention it. If you are talking about the previous report, then I
felt so sorry as I told you. I skimmed through the part of the waits...

Basically, I respect you and appreciate your feedback. Hope you not get
me wrong.

> Looking at the second ext4 report, it doesn't make any sense.  Context
> A is the kjournald thread.  We don't do a commit until (a) the timeout
> expires, or (b) someone explicitly requests that a commit happen
> waking up j_wait_commit.  I'm guessing that complaint here is that
> DEPT thinks nothing is explicitly requesting a wake up.  But note that
> after 5 seconds (or whatever journal->j_commit_interval) is configured
> to be we *will* always start a commit.  So ergo, there can't be a deadlock.

Yeah, it might not be a *deadlock deadlock* because the wait will be
anyway woken up by one of the wake up points you mentioned. However, the
dependency looks problematic because the three contexts participating in
the dependency chain would be stuck for a while until one eventually
wakes it up. I bet it would not be what you meant.

Again. It's not critical but problematic. Or am I missing something?

> At a higher level of discussion, it's an unfair tax on maintainer's
> times to ask maintainers to help you debug DEPT for you.  Tools like
> Syzkaller and DEPT are useful insofar as they save us time in making
> our subsystems better.  But until you can prove that it's not going to
> be a massive denial of service attack on maintainer's time, at the

Partially I agree. I would understand you even if you don't support Dept
until you think it's valuable enough. However, let me keep asking things
to fs folks, not you, even though I would cc you on it.

> If you know there there "appear to be false positives", you need to
> make sure you've tracked them all down before trying to ask that this
> be merged.

To track them all down, I need to ask LKML because Dept works perfectly
with my system. I don't want it to be merged with a lot of false
positive still in there, either.

> You may also want to add some documentation about why we should trust
> this; in particular for wait channels, when a process calls schedule()
> there may be multiple reasons why the thread will wake up --- in the
> worst case, such as in the select(2) or epoll(2) system call, there
> may be literally thousands of reasons (one for every file desriptor
> the select is waiting on) --- why the process will wake up and thus
> resolve the potential "deadlock" that DEPT is worrying about.  How is
> DEPT going to handle those cases?  If the answer is that things need

Thank you for the information but I don't get it which case you are
concerning. I'd like to ask you a specific senario of that so that we
can discuss it more - maybe I guess I could answer to it tho, but I
won't ask you. Just give me an instance only if you think it's worthy.

You look like a guy who unconditionally blames on new things before
understanding it rather than asking and discussing. Again. I also think
anyone doesn't have to spend his or her time for what he or she think is
not worthy enough.

> I know that you're trying to help us, but this tool needs to be far
> better than Lockdep before we should think about merging it.  Even if
> it finds 5% more potential deadlocks, if it creates 95% more false

It should not get merged for sure if so, but it sounds too sarcastic.
Let's see if it creates 95% false positives for real. If it's true and
I can't control it, I will give up. That's what I should do.

There are a lot of factors to judge how valuable Dept is. Dept would be
useful especially in the middle of development, rather than in the final
state in the tree. It'd be appreciated if you think that sides more, too.

Thanks,
Byungchul
