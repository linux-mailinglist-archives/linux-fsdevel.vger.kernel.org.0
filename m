Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61ACC1E0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 11:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfI3JeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 05:34:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53182 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfI3JeR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HJX9OsF7nCzAZY7WIWxxCUDlfYelrriJNJXBjDq+X1M=; b=vvfopPJjdaD8Bmrwikclthc06
        4UBM7BsH8BFKrpARFNc4w8yKOIiW8zmh2YC2Atp7ZS/nZZkdV/sxbIWFNnn/X0bFqLz2BQbP+NTyL
        El+ZC0stZ7pdBB0KSi9EYrQJe9TerTDiOfmUBsHY9KOo2QHEWIccOsHS3+NM7O6Qn3n542UVxAIP0
        UtuZudVVT3fIVVxuJL8b1Nd2nc9eKuftSq6+KzlNov1CuNzZSIVcsvQEVZ/xqvEJY4QLFexPxuHhs
        UpgkdvqFGyY4WKg6a2id/kb/KxAd/ydZbDxRhG1m6EzFOWusy8T8gVmQDNpwJGvLZwF5F5Bwmm9yl
        t+q+ri8NA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEs42-0006sd-Da; Mon, 30 Sep 2019 09:33:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81E37305BD3;
        Mon, 30 Sep 2019 11:33:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5097E2652FF85; Mon, 30 Sep 2019 11:33:52 +0200 (CEST)
Date:   Mon, 30 Sep 2019 11:33:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        jose.marchesi@oracle.com
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
Message-ID: <20190930093352.GM4553@hirez.programming.kicks-ass.net>
References: <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck>
 <25289.1568379639@warthog.procyon.org.uk>
 <28447.1568728295@warthog.procyon.org.uk>
 <20190917170716.ud457wladfhhjd6h@willie-the-truck>
 <15228.1568821380@warthog.procyon.org.uk>
 <5385.1568901546@warthog.procyon.org.uk>
 <20190923144931.GC2369@hirez.programming.kicks-ass.net>
 <20190927095107.GA13098@andrea>
 <20190927124929.GB4643@worktop.programming.kicks-ass.net>
 <CAKwvOd=pZYiozmGv+DVpzJ1u9_0k4CXb3M1EAcu22DQF+bW0fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=pZYiozmGv+DVpzJ1u9_0k4CXb3M1EAcu22DQF+bW0fA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 27, 2019 at 01:43:18PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 27, 2019 at 5:49 AM Peter Zijlstra <peterz@infradead.org> wrote:

> Oh, in that case I'm less sure (I still don't think so, but I would
> love to be proven wrong, preferably with a godbolt link).  I think the
> best would be to share a godbolt.org link to a case that's clearly
> broken, or cite the relevant part of the ISO C standard (which itself
> leaves room for interpretation), otherwise the discussion is too
> hypothetical.  Those two things are single-handedly the best way to
> communicate with compiler folks.

Ah, I'm not sure current compilers will get it wrong -- and I'm trying
to be preemptive here. I'm looking for a guarantee that compilers will
recognise and respect control depenencies.

The C language spec does not recognise the construct at _all_ and I'd be
fine with it being behind some optional compiler knob.

So far we're mostly very careful when using it, recognising that
compilers can screw us over because they have no clue.

> > Using WRITE_ONCE() defeats this because volatile indicates external
> > visibility.
> 
> Could data be declared as a pointer to volatile qualified int?

It's not actually 'int' data, mostly its a void* and we use memcpy().

> > Barring LTO the above works for perf because of inter-translation-unit
> > function calls, which imply a compiler barrier.

Having looked at it again, I think we're good and have sufficient
barrier() in there to not rely on function calls being a sync point.

> > Now, when the compiler inlines, it looses that sync point (and thereby
> > subtlely changes semantics from the non-inline variant). I suspect LTO
> > does the same and can cause subtle breakage through this transformation.
> 
> Do you have a bug report or godbolt link for the above?  I trust that
> you're familiar enough with the issue to be able to quickly reproduce
> it?  These descriptions of problems are difficult for me to picture in
> code or generated code, and when I try to read through
> memory-barriers.txt my eyes start to glaze over (then something else
> catches fire and I have to go put that out).  Having a concise test
> case I think would better illustrate potential issues with LTO that
> we'd then be able to focus on trying to fix/support.
> 
> We definitely have heavy hitting language lawyers and our LTO folks
> are super sharp; I just don't have the necessary compiler experience
> just yet to be as helpful in these discussions as we need but I'm
> happy to bring them cases that don't work for the kernel and drive
> their resolution.

Like said; I've not seen it go wrong -- but it is one of the things I'm
always paranoid about with LTO.

Furthermore, if it were to go wrong, it'd be a very subtle data race and
finding it would be super hard and painful. Which is again why I would
love to get compiler folks on board to actually support control
dependencies in some way.

Like I said before, something like: "disallowing store hoists over control
flow depending on a volatile load" would be sufficient I think.

Yes this is outside of ISO/C, but it is something that is really
important to us because, as said above, getting it wrong would be
*SUPER* painful.

So basically I'm asking for a language extension I suppose; a new
guarantee from the compiler's memory model that does not exist _at_all_
in the spec, one that we're actively using.

And I'm hoping that getting the compilers to (optionally) support this
is easier than waiting another few decades until Paul McKenney has
wrestled the C committee into sanity and only then (maybe) getting it.
Look at the horrible mess vs data dependencies and consume ordering
(another fun thing we're actively using lots that the compilers are
still struggling with).
