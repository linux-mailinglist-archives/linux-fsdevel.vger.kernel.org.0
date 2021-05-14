Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EC0380185
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 03:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhENBfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 21:35:53 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:50859 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232048AbhENBfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 21:35:52 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 4E85B1A46;
        Thu, 13 May 2021 21:34:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 13 May 2021 21:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        iJ6t80zLP0jWqMOoc66bwpFFYMy/M+FeT/hsKOcsIP0=; b=UlhAn9ULIpiewiOn
        sw3r6mCXvWpepQq8FJGftxzra62MxZHTI9MqOwKL6lMVd6CErYsERaxC5NgsiEjS
        wfeGf04MZyFN2lt/8OXwMTkbVo8F4/RpiKkVcKFq2wvbI1XzYb2c0v1Rgd46YxHr
        d0PRCBrLnHk2s76pTKqVmp2n40vhghfICXhtr1mmRVjTge48LjUtLM8fM6TPW9OX
        kUIzt4PDeHUUCclJbmiJ0kplStE6fltv2pbjtg4UaXaLRLggfmtvxFyNGbUuyQ0X
        Q9CDogd79/e62kL5qWF2QRrgZkERE+85l7IVO/17D9qMew+gFMY8s8qefUkX+tGv
        0cCiNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=iJ6t80zLP0jWqMOoc66bwpFFYMy/M+FeT/hsKOcsI
        P0=; b=lEd8jsbu0hoqgJ0evGdolBB3dcF8AuJUU+t3HTAoetF5BOKOi1p+drA2d
        f6Kcas2nalOW0xmTe8qeozZTQoy9H8NWiVZr+P4fLgpkt8UTLW8Y1lYEv7Zztrdz
        cFq9kOBDbvVOzMxohynr3AEzgxS89kBsvVWdXhVw/0/bT9DV5vTT+hRydWjDFSCk
        y5CvrLHlgNbRwAiVmQoUEC8zWMe3wA/PxGuo/80/KfN9Zcm1dGwbmdjmrvnyI7Mi
        6J+OfZkS28Nov6Ows2AZIxXZ7wdkZNmycKEN5f2HyzMloLFti4tiB5nG+j5M6X6c
        nF5MBvAueWDFm7gXwwDb8ZOEJAxAw==
X-ME-Sender: <xms:r9OdYPUvnNh-0_azgDvOodinXYLI-PZvWjFGPxy3Z9NxsSJTQoZlRA>
    <xme:r9OdYHmlaIGt0SlQr74Tx9hnoDWw0E5PztKeE6a61KdWD-5sBL6B5tMjJXBJgO7L7
    Q2_5fufMbE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehhedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    elgedtleeltdffteejudetfefgieehheekffehuefhkeegkeeuleehffehieegjeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepuddtie
    drieelrddvfedurdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:r9OdYLaCJY9bryAsSZZ6m1JdsKXyHluPQDpzRnsV11j8H-pUQUGaiw>
    <xmx:r9OdYKWXEz-uYl0LoAKASuCMfUjMHmq7mcolf4UwfcYAVXccpLsoSg>
    <xmx:r9OdYJmT9ZPhmc2qjn1QsZoPZOg2hqdcCQk0CD7b_t0HCCQsPwjCnA>
    <xmx:r9OdYL6EslUBsfRWJ2vzHjJukID7DFwDVnuaoQMqC3oUxb6cQbDla7dTeWI>
Received: from mickey.long.domain.name.themaw.net (106-69-231-44.dyn.iinet.net.au [106.69.231.44])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 21:34:34 -0400 (EDT)
Message-ID: <bc9650145291b6e568a8f75d02663b9e4f2bcfd7.camel@themaw.net>
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
Date:   Fri, 14 May 2021 09:34:31 +0800
In-Reply-To: <CAC2o3DKvq12CrsgWTNmQmu3iDJ+9tytMdCJepdBjUKN1iUJ0RQ@mail.gmail.com>
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
         <YJtz6mmgPIwEQNgD@kroah.com>
         <CAC2o3D+28g67vbNOaVxuF0OfE0RjFGHVwAcA_3t1AAS_b_EnPg@mail.gmail.com>
         <CAC2o3DJm0ugq60c8mBafjd81nPmhpBKBT5cCKWvc4rYT0dDgGg@mail.gmail.com>
         <CAC2o3DJdwr0aqT6LwhuRj8kyXt6NAPex2nG5ToadUTJ3Jqr_4w@mail.gmail.com>
         <4eae44395ad321d05f47571b58fe3fe2413b6b36.camel@themaw.net>
         <CAC2o3DKvq12CrsgWTNmQmu3iDJ+9tytMdCJepdBjUKN1iUJ0RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-05-13 at 23:37 +0800, Fox Chen wrote:
> Hi Ian
> 
> On Thu, May 13, 2021 at 10:10 PM Ian Kent <raven@themaw.net> wrote:
> > 
> > On Wed, 2021-05-12 at 16:54 +0800, Fox Chen wrote:
> > > On Wed, May 12, 2021 at 4:47 PM Fox Chen <foxhlchen@gmail.com>
> > > wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > I ran it on my benchmark (
> > > > https://github.com/foxhlchen/sysfs_benchmark).
> > > > 
> > > > machine: aws c5 (Intel Xeon with 96 logical cores)
> > > > kernel: v5.12
> > > > benchmark: create 96 threads and bind them to each core then
> > > > run
> > > > open+read+close on a sysfs file simultaneously for 1000 times.
> > > > result:
> > > > Without the patchset, an open+read+close operation takes 550-
> > > > 570
> > > > us,
> > > > perf shows significant time(>40%) spending on mutex_lock.
> > > > After applying it, it takes 410-440 us for that operation and
> > > > perf
> > > > shows only ~4% time on mutex_lock.
> > > > 
> > > > It's weird, I don't see a huge performance boost compared to
> > > > v2,
> > > > even
> > > 
> > > I meant I don't see a huge performance boost here and it's way
> > > worse
> > > than v2.
> > > IIRC, for v2 fastest one only takes 40us
> > 
> > Thanks Fox,
> > 
> > I'll have a look at those reports but this is puzzling.
> > 
> > Perhaps the added overhead of the check if an update is
> > needed is taking more than expected and more than just
> > taking the lock and being done with it. Then there's
> > the v2 series ... I'll see if I can dig out your reports
> > on those too.
> 
> Apologies, I was mistaken, it's compared to V3, not V2.  The previous
> benchmark report is here.
> https://lore.kernel.org/linux-fsdevel/CAC2o3DKNc=sL2n8291Dpiyb0bRHaX=nd33ogvO_LkJqpBj-YmA@mail.gmail.com/

Are all these tests using a single file name in the open/read/close
loop?

That being the case the per-object inode lock will behave like a
mutex and once contention occurs any speed benefits of a spinlock
over a mutex (or rwsem) will disappear.

In this case changing from a write lock to a read lock in those
functions and adding the inode mutex will do nothing but add the
overhead of taking the read lock. And similarly adding the update
check function also just adds overhead and, as we see, once
contention starts it has a cumulative effect that's often not
linear.

The whole idea of a read lock/per-object spin lock was to reduce
the possibility of contention for paths other than the same path
while not impacting same path accesses too much for an overall
gain. Based on this I'm thinking the update check function is
probably not worth keeping, it just adds unnecessary churn and
has a negative impact for same file contention access patterns.

I think that using multiple paths, at least one per test process
(so if you are running 16 processes use at least 16 different
files, the same in each process), and selecting one at random
for each loop of the open would better simulate real world
access patterns.


Ian

