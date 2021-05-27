Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAC7392442
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 03:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhE0BYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 21:24:48 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43441 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232187AbhE0BYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 21:24:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 97277580574;
        Wed, 26 May 2021 21:23:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 26 May 2021 21:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        oJSr+5oX37aUcbhQNV6OsG1T02M5TatlMSKHepmUSRU=; b=c2xv1b3p8LByw+Si
        mv4s+toMIqa4vlKjWAFhsFIYneMQ8KX9Q4n/qzPPVQz8Gs5B4KXyhvm2Gu4v5FC1
        5C+iYv3JMqILdnXJ8wwHvCUUDmiuLzpxCgWcyXhTMfWsW99mrvL1PanqPTHWnjgo
        4PHGapbEIaNulLAGNLmXgYKC206B+q8bYrH18KzmAyNhxD9l2rWKZ12I0kpJo8tj
        i4P/lufWgYmcXDZFQTHhCCH3czxgwfBKlA2xHAel9cdaFMwuAEJUZI0/U30lJPLy
        nDjWRdC/6daAEUs+9p6JxTgZvJJSROxtUpM92s93YH3D/iYpUooJgNTbKjOTgSDX
        vwB7vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=oJSr+5oX37aUcbhQNV6OsG1T02M5TatlMSKHepmUS
        RU=; b=TbPJYg58MOuSCVbOA91AUZEgrCyJupUVaNs9CSob+6ckc3/uyWDT9cxKN
        xKmOosfZBZBT4QLnzYXd1Fzueo+LSEk3r7dwEHTOaxmmnncz9w9nco5Eayz2iQ51
        A5Ay0eAGiRJI+Z2r2DS9Pb61i3uGQLVmnQMMmVEQ9po47C7CpJ1wKORNjpbVpn9U
        +OVXbXIglT+bEjwCnacreqRKxA07ShAR/LWINnM1LSDeCBSHoptXAEpoywVvCftD
        Drbzy9RlyOfDg30TCUcmGlN9zxBSlhHOXa91qHdhdjJMDnmSoFhM3kUsM7JXkKRy
        MiraeMaraVXKXcUu70ByuwInYKmMg==
X-ME-Sender: <xms:gvSuYELi8reNbG8xO6W42iiq8a99h117Mg3o-2EUOrpABBrNVD8W7A>
    <xme:gvSuYEK-f6KeVPRsekNOc5cPHU-1w7x8LVWePtiIHSloOrMnSEqSQ_UcKySs5vfIK
    i02oqWjLaeR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    elgedtleeltdffteejudetfefgieehheekffehuefhkeegkeeuleehffehieegjeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepuddtie
    drieelrddvheehrdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:gvSuYEumi43sxEvNMEv2a2863HnbwFwaqfUqICDemIFQvQF3fI2ghQ>
    <xmx:gvSuYBac5FfbLI2wCeJ-ywT3KMi4r5MtgsUINhOJJdaMmQhZpyt9og>
    <xmx:gvSuYLb9HQWC8nK4Cb1wbgn9orp4_qOzmM2CAnV6G-hfgKBIN-NkrA>
    <xmx:g_SuYJO3bLmTnPi9zyNMojuShhwbtFtbloISCwXxhCNHf0WtKyqvIg>
Received: from mickey.long.domain.name.themaw.net (106-69-255-44.dyn.iinet.net.au [106.69.255.44])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 26 May 2021 21:23:10 -0400 (EDT)
Message-ID: <6df8d572c6e7a20fab3df13a64f28c1a69648c9f.camel@themaw.net>
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
Date:   Thu, 27 May 2021 09:23:06 +0800
In-Reply-To: <da58dcefb59d2b51d95d1dfc012ba058bc77f23b.camel@themaw.net>
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
         <YJtz6mmgPIwEQNgD@kroah.com>
         <CAC2o3D+28g67vbNOaVxuF0OfE0RjFGHVwAcA_3t1AAS_b_EnPg@mail.gmail.com>
         <CAC2o3DJm0ugq60c8mBafjd81nPmhpBKBT5cCKWvc4rYT0dDgGg@mail.gmail.com>
         <CAC2o3DJdwr0aqT6LwhuRj8kyXt6NAPex2nG5ToadUTJ3Jqr_4w@mail.gmail.com>
         <4eae44395ad321d05f47571b58fe3fe2413b6b36.camel@themaw.net>
         <CAC2o3DKvq12CrsgWTNmQmu3iDJ+9tytMdCJepdBjUKN1iUJ0RQ@mail.gmail.com>
         <bc9650145291b6e568a8f75d02663b9e4f2bcfd7.camel@themaw.net>
         <CAC2o3DL1VwbLgajSYSR_UPL-53cjHDp+X63CerQsZ8tgNgO=-A@mail.gmail.com>
         <da58dcefb59d2b51d95d1dfc012ba058bc77f23b.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-05-17 at 09:32 +0800, Ian Kent wrote:
> On Fri, 2021-05-14 at 10:34 +0800, Fox Chen wrote:
> > On Fri, May 14, 2021 at 9:34 AM Ian Kent <raven@themaw.net> wrote:
> > > 
> > > On Thu, 2021-05-13 at 23:37 +0800, Fox Chen wrote:
> > > > Hi Ian
> > > > 
> > > > On Thu, May 13, 2021 at 10:10 PM Ian Kent <raven@themaw.net>
> > > > wrote:
> > > > > 
> > > > > On Wed, 2021-05-12 at 16:54 +0800, Fox Chen wrote:
> > > > > > On Wed, May 12, 2021 at 4:47 PM Fox Chen
> > > > > > <foxhlchen@gmail.com>
> > > > > > wrote:
> > > > > > > 
> > > > > > > Hi,
> > > > > > > 
> > > > > > > I ran it on my benchmark (
> > > > > > > https://github.com/foxhlchen/sysfs_benchmark).
> > > > > > > 
> > > > > > > machine: aws c5 (Intel Xeon with 96 logical cores)
> > > > > > > kernel: v5.12
> > > > > > > benchmark: create 96 threads and bind them to each core
> > > > > > > then
> > > > > > > run
> > > > > > > open+read+close on a sysfs file simultaneously for 1000
> > > > > > > times.
> > > > > > > result:
> > > > > > > Without the patchset, an open+read+close operation takes
> > > > > > > 550-
> > > > > > > 570
> > > > > > > us,
> > > > > > > perf shows significant time(>40%) spending on mutex_lock.
> > > > > > > After applying it, it takes 410-440 us for that operation
> > > > > > > and
> > > > > > > perf
> > > > > > > shows only ~4% time on mutex_lock.
> > > > > > > 
> > > > > > > It's weird, I don't see a huge performance boost compared
> > > > > > > to
> > > > > > > v2,
> > > > > > > even
> > > > > > 
> > > > > > I meant I don't see a huge performance boost here and it's
> > > > > > way
> > > > > > worse
> > > > > > than v2.
> > > > > > IIRC, for v2 fastest one only takes 40us
> > > > > 
> > > > > Thanks Fox,
> > > > > 
> > > > > I'll have a look at those reports but this is puzzling.
> > > > > 
> > > > > Perhaps the added overhead of the check if an update is
> > > > > needed is taking more than expected and more than just
> > > > > taking the lock and being done with it. Then there's
> > > > > the v2 series ... I'll see if I can dig out your reports
> > > > > on those too.
> > > > 
> > > > Apologies, I was mistaken, it's compared to V3, not V2.  The
> > > > previous
> > > > benchmark report is here.
> > > > https://lore.kernel.org/linux-fsdevel/CAC2o3DKNc=sL2n8291Dpiyb0bRHaX=nd33ogvO_LkJqpBj-YmA@mail.gmail.com/
> > > 
> > > Are all these tests using a single file name in the
> > > open/read/close
> > > loop?
> > 
> > Yes,  because It's easy to implement yet enough to trigger the
> > mutex_lock.
> > 
> > And you are right It's not a real-life pattern, but on the bright
> > side, it proves there is no original mutex_lock problem anymore. :)
> 
> I've been looking at your reports and they are quite interesting.
> 
> > 
> > > That being the case the per-object inode lock will behave like a
> > > mutex and once contention occurs any speed benefits of a spinlock
> > > over a mutex (or rwsem) will disappear.
> > > 
> > > In this case changing from a write lock to a read lock in those
> > > functions and adding the inode mutex will do nothing but add the
> > > overhead of taking the read lock. And similarly adding the update
> > > check function also just adds overhead and, as we see, once
> > > contention starts it has a cumulative effect that's often not
> > > linear.
> > > 
> > > The whole idea of a read lock/per-object spin lock was to reduce
> > > the possibility of contention for paths other than the same path
> > > while not impacting same path accesses too much for an overall
> > > gain. Based on this I'm thinking the update check function is
> > > probably not worth keeping, it just adds unnecessary churn and
> > > has a negative impact for same file contention access patterns.
> 
> The reports indicate (to me anyway) that the slowdown isn't
> due to kernfs. It looks more like kernfs is now putting pressure
> on the VFS, mostly on the file table lock but it looks like
> there's a mild amount of contention on a few other locks as well
> now.
> 
> That's a whole different problem and those file table handling
> functions don't appear to have any obvious problems so they are
> doing what they have to do and that can't be avoided.
> 
> That's definitely out of scope for these changes.
> 
> And, as you'd expect, once any appreciable amount of contention
> happens our measurements go out the window, certainly with
> respect to kernfs.
> 
> It also doesn't change my option that checking if an inode
> attribute update is needed in kernfs isn't useful since, IIUC
> that file table lock contention would result even if you were
> using different paths.
> 
> So I'll drop that patch from the series.

It will probably not make any difference, but for completeness
and after some thought, I felt I should post what I think is
happening with the benchmark.

The benchmark application runs a pthreads thread for each CPU
and goes into a tight open/read/close loop to demonstrate the
contention that can occur on the kernfs mutex as the number of
CPUs grows.

But that tight open/read/close loop causes contention on the VFS
file table because the pthreads threads share the process file
table.

So the poor performance is actually evidence the last patch is
doing what it's meant to do rather than evidence of a regression
with the series.

The benchmark is putting pressure on the process file table on
some hardware configurations but those critical sections are small
and there's really nothing obvious that can be done to improve the
file table locking.

It is however important to remember that the benckmark application
access pattern is not a normal access pattern by a long way.

So I don't see the need for a new revision of the series with the
last patch dropped.

If there's a change of heart and the series was to be merged I'll
leave whether to include this last patch to the discretion of the
maintainer as the bulk of the improvement comes from the earlier
patches anyway.

> 
> Ian
> > > 
> > > I think that using multiple paths, at least one per test process
> > > (so if you are running 16 processes use at least 16 different
> > > files, the same in each process), and selecting one at random
> > > for each loop of the open would better simulate real world
> > > access patterns.
> > > 
> > > 
> > > Ian
> > > 
> > 
> > 
> > thanks,
> > fox
> 


