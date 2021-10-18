Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098EE432897
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 22:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhJRUsU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 16:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJRUsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:48:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645DC061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 13:46:03 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id b12so16474859qtq.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aN+GBnxvSYxI1CBykhy1W3cisyjCt5R6Tkf+A9sowYI=;
        b=7HblSRuZT2o71Rzj9KO+L+0WlowU1JnFRhSL6OY6SDP6BXZPP3+f2WK9cDXISXymD7
         DiFKD/2V+V6ud355yDsI2WDB8+Zl9Qg1aWTI2h9r0iQrcteNGwSew4TDYCNK7o5bJ5UE
         B00B2MANKfv4s0jrdv0XHCTHS/l8s7d8AxHaV4QLN6jQMDwRs/hly+qikjzcQWadup8S
         UhSt3ez4l9Bfuo5+C0Rsp3gH42aCY3hGG8MyZZmT0lsmylwQsXjVLhPVnFOGVprqr9mV
         km9KInz16To2OqJwRmFsmTP72MMbdD64BGYEq+1zsD4hklaiIw8Wxls0D3ejQScWLyPO
         ZntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aN+GBnxvSYxI1CBykhy1W3cisyjCt5R6Tkf+A9sowYI=;
        b=Udq+LJbXc+ijiXw/o68ZOLkx0sgdsBEDZw86qphjN27IYeLsRHZAiJUfg81+QxnBtU
         7cmQ1ATVxSNla+DQJ14frQCc++h8B5OPodtYLXi4pz6bxQ9w4rCbmtlkPEAdfFDzPUf9
         B5iPGKoy9tPpm137qn4U84HWk0yMijbV7tyIU/kr79B99dM3gRV/DG5u7hzvOqWTKgKx
         AF5iu43KVxkn7gmMpFZR6qNLP5zH6zXbgW0g5XTuvDPgE74f7dP0fRsktj6eBNaHB2Y1
         H9WLKMc+OiJUz2pqyv6e6R0FMQ+gw80JxPbqfmMxXhbvH1xhbEeFeRhycvPJgia//L/K
         lyJA==
X-Gm-Message-State: AOAM531wV3M9XPg9p+FqOYS5HdEXN72FqfI8rQ6ZdUnKdBPFblBFQ/24
        yO0BqccaKhSbDVeNOMuZfAXYPR7oepw=
X-Google-Smtp-Source: ABdhPJy8s5gOURjQ9GR8NNLQkQkca1bFVXt6uE9jEnLSM5STxfK9c5OLjEVUT49waHtu8LKhKwCqBQ==
X-Received: by 2002:ac8:4b57:: with SMTP id e23mr31353689qts.328.1634589961607;
        Mon, 18 Oct 2021 13:46:01 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id d9sm6859236qtd.76.2021.10.18.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 13:46:00 -0700 (PDT)
Date:   Mon, 18 Oct 2021 16:45:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YW3dByBWM0dSRw/X@cmpxchg.org>
References: <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW25EDqynlKU14hx@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW25EDqynlKU14hx@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 02:12:32PM -0400, Kent Overstreet wrote:
> On Mon, Oct 18, 2021 at 12:47:37PM -0400, Johannes Weiner wrote:
> > I find this line of argument highly disingenuous.
> > 
> > No new type is necessary to remove these calls inside MM code. Migrate
> > them into the callsites and remove the 99.9% very obviously bogus
> > ones. The process is the same whether you switch to a new type or not.
> 
> Conversely, I don't see "leave all LRU code as struct page, and ignore anonymous
> pages" to be a serious counterargument. I got that you really don't want
> anonymous pages to be folios from the call Friday, but I haven't been getting
> anything that looks like a serious counterproposal from you.
> 
> Think about what our goal is: we want to get to a world where our types describe
> unambigiuously how our data is used. That means working towards
>  - getting rid of type punning
>  - struct fields that are only used for a single purpose

How is a common type inheritance model with a generic page type and
subclasses not a counter proposal?

And one which actually accomplishes those two things you're saying, as
opposed to a shared folio where even 'struct address_space *mapping'
is a total lie type-wise?

Plus, really, what's the *alternative* to doing that anyway? How are
we going to implement code that operates on folios and other subtypes
of the page alike? And deal with attributes and properties that are
shared among them all? Willy's original answer to that was that folio
is just *going* to be all these things - file, anon, slab, network,
rando driver stuff. But since that wasn't very popular, would not get
rid of type punning and overloaded members, would get rid of
efficiently allocating descriptor memory etc.- what *is* the
alternative now to common properties between split out subtypes?

I'm not *against* what you and Willy are saying. I have *genuinely
zero idea what* you are saying.

> Leaving all the LRU code as struct page means leaving a shit ton of type punning
> in place, and you aren't outlining any alternate ways of dealing with that. As
> long as all the LRU code is using struct page, that halts efforts towards
> separately allocating these types and making struct page smaller (which was one
> of your stated goals as well!), and it would leave a big mess in place for god
> knows how long.

I don't follow either of these claims.

Converting to a shared anon/file folio makes almost no dent into the
existing type punning we have, because head/tail page disambiguation
is a tiny part of the type inferment we do on struct page.

And leaving the LRU linkage in the struct page doesn't get in the way
of allocating separate subtype descriptors. All these types need a
list_head anyway, from anon to file to slab to the buddy allocator.

Maybe anon, file, slab don't need it at the 4k granularity all the
time, but the buddy allocator does anyway as long as it's 4k based and
I'm sure you don't want to be allocating a new buddy descriptor every
time we're splitting a larger page block into a smaller one?

I really have no idea how that would even work.

> It's been a massive effort for Willy to get this far, who knows when
> someone else with the requisite skillset would be summoning up the
> energy to deal with that - I don't see you or I doing it.
> 
> Meanwhile: we've got people working on using folios for anonymous pages to solve
> some major problems
> 
>  - it cleans up all of the if (normalpage) else if (hugepage) mess

No it doesn't.

>  - it'll _majorly_ help with our memory fragmentation problems, as I recently
>    outlined. As long as we've got a very bimodal distribution in our allocation
>    sizes where the peaks are at order 0 and HUGEPAGE_ORDER, we're going to have
>    problems allocating hugepages. If anonymous + file memory can be arbitrary
>    sized compound pages, we'll end up with more of a poisson distribution in our
>    allocation sizes, and a _great deal_ of our difficulties with memory
>    fragmentation are going to be alleviated.
>
>  - and on architectures that support merging of TLB entries, folios for
>    anonymous memory are going to get us some major performance improvements due
>    to reduced TLB pressure, same as hugepages but without nearly as much memory
>    fragmetation pain

It doesn't do those, either.

It's a new name for headpages, that's it.

Converting to arbitrary-order huge pages needs to rework assumptions
around what THP pages mean in various places of the code. Mainly the
page table code. Presumably. We don't have anything even resembling a
proposal on how this is all going to look like implementation-wise.

How does changing the name help with this?

How does not having the new name get in the way of it?

> And on top of all that, file and anonymous pages are just more alike than they
> are different.

I don't know what you're basing this on, and you can't just keep
making this claim without showing code to actually unify them.

They have some stuff in common, and some stuff is deeply different.
All about this screams class & subclass. Meanwhile you and Willy just
keep coming up with hacks on how we can somehow work around this fact
and contort the types to work out anyway.

You yourself said that folio including slab and other random stuff is
a bonkers idea. But that means we need to deal with properties that
are going to be shared between subtypes, and I'm the only one that has
come up with a remotely coherent proposal on how to do that.

> > (I'll send more patches like the PageSlab() ones to that effect. It's
> > easy. The only reason nobody has bothered removing those until now is
> > that nobody reported regressions when they were added.)
> 
> I was also pretty frustrated by your response to Willy's struct slab patches.
> 
> You claim to be all in favour of introducing more type safety and splitting
> struct page up into multiple types, but on the basis of one objection - that his
> patches start marking tail slab pages as PageSlab (and I agree with your
> objection, FWIW) - instead of just asking for that to be changed, or posting a
> patch that made that change to his series, you said in effect that we shouldn't
> be doing any of the struct slab stuff by posting your own much more limited
> refactoring, that was only targeted at the compound_head() issue, which we all
> agree is a distraction and not the real issue. Why are you letting yourself get
> distracted by that?

Kent, you can't be serious. I actually did exactly what you suggested
I should have done.

The struct slab patches are the right thing to do.

I had one minor concern (which you seem to share) and suggested a
small cleanup. Willy worried about this cleanup adding a needless
compound_head() call, so *I sent patches to eliminate this call and
allow this cleanup and the struct slab patches to go ahead.*

My patches are to unblock Willy's. He then moved the goal posts and
started talking about prefetching, but that isn't my fault. I was
collaborating and putting my own time and effort where my mouth is.

Can you please debug your own approach to reading these conversations?
