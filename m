Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6E7225579
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 03:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGTBd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 21:33:29 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:34269 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbgGTBd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:33:28 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 311EE1070E9;
        Mon, 20 Jul 2020 11:33:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jxKgC-0001wQ-Lq; Mon, 20 Jul 2020 11:33:20 +1000
Date:   Mon, 20 Jul 2020 11:33:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200720013320.GP5369@dread.disaster.area>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
 <20200718140811.GA1179836@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718140811.GA1179836@rowland.harvard.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=7-415B0cAAAA:8
        a=feIL57iW5i9pFtJXli8A:9 a=nK-mLslAj2odQg0r:21 a=efrNrOHdcqjrA1Sw:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 18, 2020 at 10:08:11AM -0400, Alan Stern wrote:
> > This is one of the reasons that the LKMM documetnation is so damn
> > difficult to read and understand: just understanding the vocabulary
> > it uses requires a huge learning curve, and it's not defined
> > anywhere. Understanding the syntax of examples requires a huge
> > learning curve, because it's not defined anywhere. 
> 
> Have you seen tools/memory-model/Documentation/explanation.txt?

<raises eyebrow>

Well, yes. Several times. I look at it almost daily, but that
doesn't mean it's approachable, easy to read or even -that I
understand what large parts of it say-. IOWs, that's one of the 
problematic documents that I've been saying have a huge learning
curve.

So, if I say "the LKMM documentation", I mean -all- of the
documentation, not just some tiny subset of it. I've read it all,
I've even installed herd7 so I can run the litmus tests to see if
that helps me understand the documentation better.

That only increased the WTF factor because the documentation of that
stuff is far, far more impenetrable than the LKMM documentation.  If
the LKMM learnign curve is near vertical, then the stuff in the
herd7 tools is an -overhang-. And I most certainly can't climb
that....

/me idly wonders if you recognise that your comment is, yet again, a
classic demonstration of the behaviour the "curse of knowledge"
cognitive bias describes.

> That
> file was specifically written for non-experts to help them overcome the
> learning curve.  It tries to define the vocabulary as terms are
> introduced and to avoid using obscure syntax.

It tries to teach people about what a memory model is at the same
time it tries to define the LKMM. What it doesn't do at all is
teach people how to write safe code. People want to write safe code,
not become "memory model experts".

Memory models are -your expertise- but they aren't mine. My
expertise is filesystems: I don't care about the nitty gritty
details of memory models, I just want to be able to write lockless
algorithms correctly. Which, I might point out, I've been doing for
well over a decade...

> If you think it needs improvement and can give some specific
> details about where it falls short, I would like to hear them.

Haven't you understood anything I've been saying? That developers
don't care about how the theory behind the memory model  or how it
works - we just want to be able to write safe code. And to do that
quickly and efficiently. The "make the documentation more complex"
response is the wrong direction. Please *dumb it down* to the most
basic, simplest, common concurrency patterns that programmers use
and then write APIs to do those things that *hide the memory model
for the programmer*.

Adding documentation about all the possible things you could do,
all the optimisations you could make, all the intricate, subtle
variations you can use, etc is not helpful. It might be interesting
to you, but I just want -somethign that works- and not have to
understand the LKMM to get stuff done.

Example: I know how smp_load_acquire() works. I know that I can
expect the same behavioural semantics from smp_cond_load_acquire().
But I don't care how the implementation of smp_cond_load_acquire()
is optimised to minimise ordering barriers as it spins. That sort of
optimisation is your job, not mine - I just want a function that
will spin safely until a specific value is seen and then return with
acquire semantics on the successful load.....

Can you see the difference between "understanding the LKMM
documenation" vs "using a well defined API that provides commonly
used functionality" to write correct, optimal code that needs to
spin waiting for some other context to update a variable?

That's the problem the LKMM documentation fails to address. It is
written to explain the theory behind the LKMM rather than provide
developers with pointers to the templates and APIs that implement
the lockless co-ordination functionality they want to use....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
