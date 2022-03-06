Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78A4CE889
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 04:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiCFDbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 22:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCFDbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 22:31:47 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE3344F3;
        Sat,  5 Mar 2022 19:30:51 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2263Umjm001464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 5 Mar 2022 22:30:49 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9FD6D15C0038; Sat,  5 Mar 2022 22:30:48 -0500 (EST)
Date:   Sat, 5 Mar 2022 22:30:48 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@redhat.com,
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
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report 2 in ext4 and journal based on v5.17-rc1
Message-ID: <YiQq6Ou39uzHC0mu@mit.edu>
References: <YiAow5gi21zwUT54@mit.edu>
 <1646285013-3934-1-git-send-email-byungchul.park@lge.com>
 <YiDSabde88HJ/aTt@mit.edu>
 <20220304032002.GD6112@X58A-UD3R>
 <YiLbs9rszWXpHm/P@mit.edu>
 <20220305145534.GB31268@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305145534.GB31268@X58A-UD3R>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 05, 2022 at 11:55:34PM +0900, Byungchul Park wrote:
> > that is why some of the DEPT reports were completely incomprehensible
> 
> It's because you are blinded to blame at it without understanding how
> Dept works at all. I will fix those that must be fixed. Don't worry.

Users of DEPT must not have to understand how DEPT works in order to
understand and use DEPT reports.  If you think I don't understand how
DEPT work, I'm going to gently suggest that this means DEPT reports
are clear enough, and/or DEPT documentation needs to be
*substantially* improved, or both --- and these needs to happen before
DEPT is ready to be merged.

> > So if DEPT is issuing lots of reports about apparently circular
> > dependencies, please try to be open to the thought that the fault is
> 
> No one was convinced that Dept doesn't have a fault. I think your
> worries are too much.

In that case, may I ask that you add back a RFC to the subject prefix
(e.g., [PATCH RFC -v5]?)  Or maybe even add the subject prefix NOT YET
READY?  I have seen cases when after a patch series get to PATCH -v22,
and then people assume that it *must* be ready, as opposed what it
really means, which is "the author is just persistently reposting and
rebasing the patch series over and over again".  It would be helpful
if you directly acknowledge, in each patch submission, that it is not
yet ready for prime time.

After all, right now, DEPT has generated two reports in ext4, both of
which were false positives, and both of which have required a lot of
maintainer times to prove to you that they were in fact false
positives.  So are we all agreed that DEPT is not ready for prime
time?

> No one argued that their code must be buggy, either. So I don't think
> you have to worry about what's never happened.

Well, you kept on insisting that ext4 must have a circular dependency,
and that depending on a "rescue wakeup" is bad programming practice,
but you'll reluctantly agree to make DEPT accept "rescue wakeups" if
that is the will of the developers.  My concern here is the
fundmaental concept of "rescue wakeups" is wrong; I don't see how you
can distinguish between a valid wakeup and one that you and DEPT is
going to somehow characterize as dodgy.

Consider: a process can first subscribe to multiple wait queues, and
arrange to be woken up by a timeout, and then call schedule() to go to
sleep.  So it is not waiting on a single wait channel, but potentially
*multiple* wakeup sources.  If you are going to prove that kernel is
not going to make forward progress, you need to prove that *all* ways
that process might not wake up aren't going to happen for some reason.

Just because one wakeup source seems to form a circular dependency
proves nothing, since another wakeup source might be the designed and
architected way that code makes forward progress.

You seem to be assuminng that one wakeup source is somehow the
"correct" one, and the other ways that process could be woken up is a
"rescue wakeup source" and you seem to believe that relying on a
"rescue wakeup source" is bad.  But in the case of a process which has
called prepare-to-wait on more than one wait queue, how is DEPT going
to distinguish between your "morally correct" wkaeup source, and the
"rescue wakeup source"?

> No doubt. I already think so. But it doesn't mean that I have to keep
> quiet without discussing to imporve Dept. I will keep improving Dept in
> a reasonable way.

Well, I don't want to be in a position of having to prove that every
single DEPT report in my code that doesn't make sense to me is
nonsense, or else DEPT will get merged.

So maybe we need to reverse the burden of proof.

Instead of just sending a DEPT report, and then asking the maintainers
to explain why it is a false positive, how about if *you* use the DEPT
report to examinie the subsystem code, and then explain plain English,
how you think this could trigger in real life, or cause a performance
problem in real life or perhaps provide a script or C reproducer that
triggers the supposed deadlock?

Yes, that means you will need to understand the code in question, but
hopefully the DEPT reports should be clear enough that someone who
isn't a deep expert in the code should be able to spot the bug.  If
not, and if only a few deep experts of code in question will be able
to decipher the DEPT report and figure out a fix, that's really not
ideal.

If DEPT can find a real bug and you can show that Lockdep wouldn't
have been able to find it, then that would be proof that it is making
a real contribution.  That's would be real benefit.  At the same time,
DEPT will hopefully be able to demonstrate a false positive rate which
is low enough that the benefits clearly outweight the costs.

At the moment, I believe the scoreboard for DEPT with respect to ext4
is zero real bugs found, and two false positives, both of which have
required significant rounds of e-mail before the subsystem maintainers
were able to prove to you that it was, indeed, DEPT reporting a false
positive.

Do you now understand why I am so concerned that you aren't putting an
RFC or NOT YET READY in the subject line?

						- Ted

P.S.  If DEPT had a CONFIG_EXPERIMENTAL, with a disclaimer in the
KConfig that some of its reports might be false positives, that might
be another way of easing my fears that this won't get used by
Syzkaller, and to generate a lot of burdensome triage work on the
maintainers.
