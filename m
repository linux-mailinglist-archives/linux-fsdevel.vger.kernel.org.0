Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B94D3EEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 02:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiCJBrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 20:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiCJBrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:47:23 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70F4AFDFA9
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 17:46:20 -0800 (PST)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 10 Mar 2022 10:46:18 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 10 Mar 2022 10:46:18 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 10 Mar 2022 10:45:49 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Theodore Ts'o <tytso@mit.edu>
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
Message-ID: <20220310014549.GA24568@X58A-UD3R>
References: <YiQq6Ou39uzHC0mu@mit.edu>
 <1646563902-6671-1-git-send-email-byungchul.park@lge.com>
 <YiTC3j6Igkw7xvIM@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiTC3j6Igkw7xvIM@mit.edu>
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

On Sun, Mar 06, 2022 at 09:19:10AM -0500, Theodore Ts'o wrote:
> On Sun, Mar 06, 2022 at 07:51:42PM +0900, Byungchul Park wrote:
> > > 
> > > Users of DEPT must not have to understand how DEPT works in order to
> > 
> > Users must not have to understand how Dept works for sure, and haters
> > must not blame things based on what they guess wrong.
> 
> For the record, I don't hate DEPT.  I *fear* that DEPT will result in
> my getting spammed with a huge number of false posiives once automated
> testing systems like Syzkaller, zero-day test robot, etcs., get a hold
> of it once it gets merged and start generating hundreds of automated
> reports.

Agree. Dept should not be a part of *automated testing system* until it
finally works as much as Lockdep in terms of false positives. However,
it's impossible to achieve it by doing it out of the tree.

Besides automated testing system, Dept works great in the middle of
developing something that is so complicated in terms of synchronization.
They don't have to worry about real reports anymore, that should be
reported, from getting prevented by a false positve.

I will explicitely describe EXPERIMENTAL and "Dept might false-alarm" in
Kconfig until it's considered a few-false-alarming tool.

> > Sure, it should be done manually. I should do it on my own when that
> > kind of issue arises.
> 
> The question here is how often will it need to be done, and how easy

I guess it's gonna rarely happens. I want to see too.

> will it be to "do it manually"?  Suppose we mark all of the DEPT false

Very easy. Equal to or easier than the way we do for lockdep. But the
interest would be wait/event objects rather than locks.

> positives before it gets merged?  How easy will it be able to suppress
> future false positives in the future, as the kernel evolves?

Same as - or even better than - what we do for Lockdep.

And we'd better consider those activies as a code-documentation. Not
only making things just work but organizing code and documenting
in code, are also very meaningful.

> Perhaps one method is to haved a way to take a particular wait queue,
> or call to schedule(), or at the level of an entire kernel source
> file, and opt it out from DEPT analysis?  That way, if DEPT gets
> merged, and a maintainer starts getting spammed by bogus (or

Once Dept gets stable - hoplefully now that Dept is working very
conservatively, there might not be as many false positives as you're
concerning. The situation is in control.

> That way we don't necessarily need to have a debate over how close to
> zero percent false positives is necessary before DEPT can get merged.

Non-sense. I would agree with you if it was so when Lockdep was merged.
But I'll try to achieve almost zero false positives, again, it's
impossible to do it out of tree.

> And we avoid needing to force maintainers to prove that a DEPT report

So... It'd be okay if Dept goes not as a part of automated testing
system. Right?

> is a false positive, which is from my experience hard to do, since
> they get accused of being DEPT haters and not understanding DEPT.

Honestly, it's not a problem of that they don't understand other
domians than what they are familiar with, but another issue. I won't
mention it.

And it sounds like you'd do nothing unless it turns out to be
problematic 100%. It's definitely the *easiest* way to maintain
something because it's the same as not checking its correctness at all.

Even if it's so hard to do, checking if the code is safe for real
repeatedly, is what it surely should be done. Again, I understand it
would be freaking hard. But it doesn't mean we should avoid it.

Here, there seems to be two points you'd like to say:

1. Fundamental question. Does Dept track wait and event correctly?
2. Even if so, can Dept consider all the subtle things in the kernel?

For 1, I'm willing to response to whatever it is. And not only me but we
can make it perfectly work if the concept and direction is *right*.
For 2, I need to ask things and try my best to fix those if it exists.

Again. Dept won't be a part of *automated testing system* until it
finally works as much as Lockdep in terms of false positives. Hopefully
you are okay with it.

---
Byungchul
