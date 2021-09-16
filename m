Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD7340E5E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 19:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhIPRQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 13:16:18 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:49824 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240202AbhIPRMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1631812284;
        bh=zSJJ5cHL7s/jqv54yo5u9Z6aM7IPcjeI1xRJI/qC0qs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=J6IaOhlHK6p8FT4mJi+ehzSKUrUNJpY8cq33Bt+IiqJDXvPtq7Ck5pi7ami/qcXOe
         ukWU3G0vi7cbKg7G+aLJQdwnDBQBlYBmR/U2b1RepsQBoeu9ljOwZCK4+UoW8GftAO
         Cm94sfXufzNZywPK/xxZL2kfIHv/BI9Dx13vrpss=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 396821280A67;
        Thu, 16 Sep 2021 10:11:24 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KzyaYtQ7urIC; Thu, 16 Sep 2021 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1631812283;
        bh=zSJJ5cHL7s/jqv54yo5u9Z6aM7IPcjeI1xRJI/qC0qs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=VcANc/7xNJhj2d/Ggwf2cLukOsMfhszxep9WaxCGQ0SBOBNaxM3vQ8+fi6IGtrbYh
         r1FJxUc4x6GfzQtEwL9grwcsiddOM2W6nZIooiZ356BAukfGE1HOEgZcvbZERyjZ0L
         eBUdh2BG7i7LJOU8U8daR33ZtX9wynBo9/sONSaE=
Received: from jarvis.lan (c-67-166-170-96.hsd1.va.comcast.net [67.166.170.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CBD891280916;
        Thu, 16 Sep 2021 10:11:22 -0700 (PDT)
Message-ID: <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Chris Mason <clm@fb.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Date:   Thu, 16 Sep 2021 13:11:21 -0400
In-Reply-To: <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
         <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
         <YUI5bk/94yHPZIqJ@mit.edu> <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
         <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
         <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-09-16 at 16:46 +0000, Chris Mason wrote:
> > On Sep 15, 2021, at 3:15 PM, James Bottomley <
> > James.Bottomley@HansenPartnership.com> wrote:
> > 
> > My reading of the email threads is that they're iterating to an
> > actual conclusion (I admit, I'm surprised) ... or at least the
> > disagreements are getting less.  Since the merge window closed this
> > is now a 5.16 thing, so there's no huge urgency to getting it
> > resolved next week.
> > 
> 
> I think the urgency is mostly around clarity for others with out of
> tree work, or who are depending on folios in some other way.  Setting
> up a clear set of conditions for the path forward should also be part
> of saying not-yet to merging them.
> 
> > > * What process should we use to make the overall development of
> > > folio sized changes more predictable and rewarding for everyone
> > > involved?
> > 
> > Well, the current one seems to be working (admittedly eventually,
> > so achieving faster resolution next time might be good) ... but I'm
> > sure you could propose alternatives ... especially in the time to
> > resolution department.
> 
> It feels like these patches are moving forward, but with a pretty
> heavy emotional cost for the people involved.  I'll definitely agree
> this has been our process for a long time, but I'm struggling to
> understand why we'd call it working.

Well ... moving forwards then.

> In general, we've all come to terms with huge changes being a slog
> through  consensus building, design compromise, the actual technical
> work, and the rebase/test/fix iteration cycle.  It's stressful, both
> because of technical difficulty and because the whole process is
> filled with uncertainty.
> 
> With folios, we don't have general consensus on:
> 
> * Which problems are being solved?  Kent's writeup makes it pretty
> clear filesystems and memory management developers have diverging
> opinions on this.  Our process in general is to put this into patch
> 0.  It mostly works, but there's an intermediate step between patch 0
> and the full lwn article that would be really nice to have.

I agree here ... but problem definition is supposed to be the job of
the submitter and fully laid out in the cover letter.

> * Who is responsible for accepting the design, and which acks must be
> obtained before it goes upstream?  Our process here is pretty similar
> to waiting for answers to messages in bottles.  We consistently leave
> it implicit and poorly defined.

My answer to this would be the same list of people who'd be responsible
for ack'ing the patches.  However, we're always very reluctant to ack
designs in case people don't like the look of the code when it appears
and don't want to be bound by the ack on the design.  I think we can
get around this by making it clear that design acks are equivalent to
"This sounds OK but I won't know for definite until I see the code"

> * What work is left before it can go upstream?  Our process could be
> effectively modeled by postit notes on one person's monitor, which
> they may or may not share with the group.  Also, since we don't have
> agreement on which acks are required, there's no way to have any
> certainty about what work is left.  It leaves authors feeling
> derailed when discussion shifts and reviewers feeling frustrated and
> ignored.

Actually, I don't see who should ack being an unknown.  The MAINTAINERS
file covers most of the kernel and a set of scripts will tell you based
on your code who the maintainers are ... that would seem to be the
definitive ack list.

I think the problem is the ack list for features covering large areas
is large and the problems come when the acker's don't agree ... some
like it, some don't.  The only deadlock breaking mechanism we have for
this is either Linus yelling at everyone or something happening to get
everyone into alignment (like an MM summit meeting).  Our current model
seems to be every acker has a foot on the brake, which means a single
nack can derail the process.  It gets even worse if you get a couple of
nacks each requesting mutually conflicting things.

We also have this other problem of subsystems not being entirely
collaborative.  If one subsystem really likes it and another doesn't,
there's a fear in the maintainers of simply being overridden by the
pull request going through the liking subsystem's tree.  This could be
seen as a deadlock breaking mechanism, but fear of this happening
drives overreactions.

We could definitely do a clear definition of who is allowed to nack and
when can that be overridden.

> * How do we divide up the long term future direction into individual
> steps that we can merge?  This also goes back to consensus on the
> design.  We can't decide which parts are going to get layered in
> future merge windows until we know if we're building a car or a
> banana stand.

This is usual for all large patches, though, and the author gets to
design this.

> * What tests will we use to validate it all?  Work this spread out is
> too big for one developer to test alone.  We need ways for people
> sign up and agree on which tests/benchmarks provide meaningful
> results.

In most large patches I've worked on, the maintainers raise worry about
various areas (usually performance) and the author gets to design tests
to validate or invalidate the concern ... which can become very open
ended if the concern is vague.

> The end result of all of this is that missing a merge window isn't
> just about a time delay.  You add N months of total uncertainty,
> where every new email could result in having to start over from
> scratch.  Willy's do-whatever-the-fuck-you-want-I'm-going-on-vacation 
> email is probably the least surprising part of the whole thread.
> 
> Internally, we tend to use a simple shared document to nail all of
> this down.  A two page google doc for folios could probably have
> avoided a lot of pain here, especially if we’re able to agree on
> stakeholders.

You mean like a cover letter?  Or do you mean a living document that
the acker's could comment on and amend?

James


