Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44F38228B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 03:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhEQBd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 May 2021 21:33:28 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53663 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhEQBd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 May 2021 21:33:28 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 45F5F5805EE;
        Sun, 16 May 2021 21:32:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 16 May 2021 21:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        cxZjKmHMz/D7TD+kHqFRoA9O3quyMMGlHAotgmFEv54=; b=wMwnNrN5q9I/yaK4
        gdjJkOIdJPg6y6QKtBnyysyzDn2Qx6UAs7M3TfRQcTJdWfDv8AfEODVg136IcVLM
        nP+moKJrzwrSwiqlSOGN9yv6YbzJKl8QTZNOZgwvzM9at+wrHxGGIz3DkuTKRTdO
        608GJUooEH3hdomZHE6w/uOcqH6Kfpqs2fCUsZG/SziYjorpqFDrtwPxZ7jo+tbN
        Y8l2ZE9gscLlMdPULTYesbX/AJAqYrCgFk8yeobya4CjkHtLT7/I6aU/iTlyCn1e
        INW19teVcqxzQPmRmbJQLPYisWqwl33pPm2r+vA8LImeyPci73EPk3QRaiY7sBqf
        MXKZug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=cxZjKmHMz/D7TD+kHqFRoA9O3quyMMGlHAotgmFEv
        54=; b=YsMjOMVUhsTARBJ1CYIl/nKSxTr5SuhHh9/fgMEocndRPGWzOrNlvPYEk
        4VXJVhMLfrLOhmGjdRXlDBgtzI3G2M4Wv28nFywPrVd+MouOAwq0rDTeUrKml8Hf
        t9JwSbjL3ERww9JI//Q09426NEBCC9IK/ZQYqaHtjJFS4y2dPMLMzYrF45m/O4tr
        OsjVC2dyZL9eZcaUfhWjSq5g9rKNP02WAEemBPsJDssxbwrt2f8qB8xcuKz29J8C
        IfvKej7Qmr07UwlwLxsUfNn5Ivbr+OQSv/lzDFcHNeFcF6AqKQ6gHpsK07VVWSui
        ADk8OKpvC3UsrcGjv3Jmu4rJJfCng==
X-ME-Sender: <xms:m8ehYPmMHUABJGL2Qkb8LVrBv5tm0yVfNw5aB7Nb-QVEJs2TK7R7Jw>
    <xme:m8ehYC3YvgTRs6gqn9a5gOHMK3Mt8M1_wd9XuPDJuaKJVlOhnPD2aX0eNNuD-G6fe
    VrnttpygwhW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeigedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    elgedtleeltdffteejudetfefgieehheekffehuefhkeegkeeuleehffehieegjeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepuddtie
    drieelrddvfedurdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:m8ehYFrRVsJo-SF-z-S7QCO5jHsMI62RRzbbM1V04Kctr-142rCL1g>
    <xmx:m8ehYHlr6Q41itY2ib686tvAUoqDzP-CyEu5Q7sIbt40uyhxH9KbOg>
    <xmx:m8ehYN08wU2XSF9gvm-AbIyACt1CZJqFvzRj8VJeVwS4CneKAdRezA>
    <xmx:nMehYGLEJNoq9I2kCXFysjWc0qNk_E8YK2dnGwB0GSI-jTgDwXOWww>
Received: from mickey.long.domain.name.themaw.net (106-69-231-44.dyn.iinet.net.au [106.69.231.44])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sun, 16 May 2021 21:32:06 -0400 (EDT)
Message-ID: <da58dcefb59d2b51d95d1dfc012ba058bc77f23b.camel@themaw.net>
Subject: Re: [PATCH v4 0/5] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@sandeen.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 17 May 2021 09:32:03 +0800
In-Reply-To: <CAC2o3DL1VwbLgajSYSR_UPL-53cjHDp+X63CerQsZ8tgNgO=-A@mail.gmail.com>
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
         <YJtz6mmgPIwEQNgD@kroah.com>
         <CAC2o3D+28g67vbNOaVxuF0OfE0RjFGHVwAcA_3t1AAS_b_EnPg@mail.gmail.com>
         <CAC2o3DJm0ugq60c8mBafjd81nPmhpBKBT5cCKWvc4rYT0dDgGg@mail.gmail.com>
         <CAC2o3DJdwr0aqT6LwhuRj8kyXt6NAPex2nG5ToadUTJ3Jqr_4w@mail.gmail.com>
         <4eae44395ad321d05f47571b58fe3fe2413b6b36.camel@themaw.net>
         <CAC2o3DKvq12CrsgWTNmQmu3iDJ+9tytMdCJepdBjUKN1iUJ0RQ@mail.gmail.com>
         <bc9650145291b6e568a8f75d02663b9e4f2bcfd7.camel@themaw.net>
         <CAC2o3DL1VwbLgajSYSR_UPL-53cjHDp+X63CerQsZ8tgNgO=-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-05-14 at 10:34 +0800, Fox Chen wrote:
> On Fri, May 14, 2021 at 9:34 AM Ian Kent <raven@themaw.net> wrote:
> > 
> > On Thu, 2021-05-13 at 23:37 +0800, Fox Chen wrote:
> > > Hi Ian
> > > 
> > > On Thu, May 13, 2021 at 10:10 PM Ian Kent <raven@themaw.net>
> > > wrote:
> > > > 
> > > > On Wed, 2021-05-12 at 16:54 +0800, Fox Chen wrote:
> > > > > On Wed, May 12, 2021 at 4:47 PM Fox Chen
> > > > > <foxhlchen@gmail.com>
> > > > > wrote:
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > I ran it on my benchmark (
> > > > > > https://github.com/foxhlchen/sysfs_benchmark).
> > > > > > 
> > > > > > machine: aws c5 (Intel Xeon with 96 logical cores)
> > > > > > kernel: v5.12
> > > > > > benchmark: create 96 threads and bind them to each core
> > > > > > then
> > > > > > run
> > > > > > open+read+close on a sysfs file simultaneously for 1000
> > > > > > times.
> > > > > > result:
> > > > > > Without the patchset, an open+read+close operation takes
> > > > > > 550-
> > > > > > 570
> > > > > > us,
> > > > > > perf shows significant time(>40%) spending on mutex_lock.
> > > > > > After applying it, it takes 410-440 us for that operation
> > > > > > and
> > > > > > perf
> > > > > > shows only ~4% time on mutex_lock.
> > > > > > 
> > > > > > It's weird, I don't see a huge performance boost compared
> > > > > > to
> > > > > > v2,
> > > > > > even
> > > > > 
> > > > > I meant I don't see a huge performance boost here and it's
> > > > > way
> > > > > worse
> > > > > than v2.
> > > > > IIRC, for v2 fastest one only takes 40us
> > > > 
> > > > Thanks Fox,
> > > > 
> > > > I'll have a look at those reports but this is puzzling.
> > > > 
> > > > Perhaps the added overhead of the check if an update is
> > > > needed is taking more than expected and more than just
> > > > taking the lock and being done with it. Then there's
> > > > the v2 series ... I'll see if I can dig out your reports
> > > > on those too.
> > > 
> > > Apologies, I was mistaken, it's compared to V3, not V2.  The
> > > previous
> > > benchmark report is here.
> > > https://lore.kernel.org/linux-fsdevel/CAC2o3DKNc=sL2n8291Dpiyb0bRHaX=nd33ogvO_LkJqpBj-YmA@mail.gmail.com/
> > 
> > Are all these tests using a single file name in the open/read/close
> > loop?
> 
> Yes,  because It's easy to implement yet enough to trigger the
> mutex_lock.
> 
> And you are right It's not a real-life pattern, but on the bright
> side, it proves there is no original mutex_lock problem anymore. :)

I've been looking at your reports and they are quite interesting.

> 
> > That being the case the per-object inode lock will behave like a
> > mutex and once contention occurs any speed benefits of a spinlock
> > over a mutex (or rwsem) will disappear.
> > 
> > In this case changing from a write lock to a read lock in those
> > functions and adding the inode mutex will do nothing but add the
> > overhead of taking the read lock. And similarly adding the update
> > check function also just adds overhead and, as we see, once
> > contention starts it has a cumulative effect that's often not
> > linear.
> > 
> > The whole idea of a read lock/per-object spin lock was to reduce
> > the possibility of contention for paths other than the same path
> > while not impacting same path accesses too much for an overall
> > gain. Based on this I'm thinking the update check function is
> > probably not worth keeping, it just adds unnecessary churn and
> > has a negative impact for same file contention access patterns.

The reports indicate (to me anyway) that the slowdown isn't
due to kernfs. It looks more like kernfs is now putting pressure
on the VFS, mostly on the file table lock but it looks like
there's a mild amount of contention on a few other locks as well
now.

That's a whole different problem and those file table handling
functions don't appear to have any obvious problems so they are
doing what they have to do and that can't be avoided.

That's definitely out of scope for these changes.

And, as you'd expect, once any appreciable amount of contention
happens our measurements go out the window, certainly with
respect to kernfs.

It also doesn't change my option that checking if an inode
attribute update is needed in kernfs isn't useful since, IIUC
that file table lock contention would result even if you were
using different paths.

So I'll drop that patch from the series.

Ian
> > 
> > I think that using multiple paths, at least one per test process
> > (so if you are running 16 processes use at least 16 different
> > files, the same in each process), and selecting one at random
> > for each loop of the open would better simulate real world
> > access patterns.
> > 
> > 
> > Ian
> > 
> 
> 
> thanks,
> fox


