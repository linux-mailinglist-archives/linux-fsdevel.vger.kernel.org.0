Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549513641B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 14:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbhDSMbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 08:31:35 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:59597 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229790AbhDSMbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:31:35 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 08:31:35 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E36171217;
        Mon, 19 Apr 2021 08:25:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 19 Apr 2021 08:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        9D4Gtb3vH0W2i2JTXhBukgx70QFcLkleNcILHqPTyU0=; b=f0Sp5vL7g/aEH8B8
        WmtCd36Q9ygpOgpHJFwQ3Uvq2k7ndzmQ4Mx/i8dima44vNaeiBEJGdoSoaRHctuB
        bpYVI9XWmEFh+sM6SwiMxrrMB9dzVFpSNAWmosSLa20rphf+msDoTrIhuLCHL/Lc
        jZFBZhiYkbVsJmcYc4ZfcXArDidaWeIulvU5FYrcComYSF/wJN4p0AV/GBgXv69J
        Rr27N8zd9RFR2lDPPPPL4mfmEIRuZsjtcOWnEbqqQC/pJgD+2jU9fdoPRqPRpMK2
        /gZh4F5x0V8V5hOwIt1M7pGTEREMEw/QGa1MqnOwvqLrwGDvzc1gLeZtAARpNnTd
        TTxInw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=9D4Gtb3vH0W2i2JTXhBukgx70QFcLkleNcILHqPTy
        U0=; b=FBR6bcj70XStCWxFB6ml5tBYpF0b8vlSwe/EhW6EbUEpewq+mo8SKyDPK
        f2ruC62592M6EhTFRNow9Gnpqv4CC62/qo1zngiWYQgfDwikZL0U1pRyhdVlKBrG
        vjtEzP1ZMbgspJP7j2wfwOMcrp4hNPXMTYDfe+NJcM9y9yJ0I3iOimq7Mq/z8LXx
        RyHM4YjSXdWeVrx3Xc2UmL0LrOAJMGI8uVIZEhq2uBcunoVaO/5BZX7729On2Ohm
        pHphvRbmuDb9s01HXId5Twfgp9A0I8cLiQO3/R3dCrbEsWRn50hUXB8q53S8OI49
        X+uCno2Sx7SK8MQMg0NBx5rnPADTA==
X-ME-Sender: <xms:uXZ9YKEUw4TiNXWfyyFAYxAenk5r56jizoetMpNH-pbnj8B9AfNWlQ>
    <xme:uXZ9YLWK-rXXHNx98SgY53Phgk0Po2mL95r4ejoDnRN2mg8o5XSyhh4s9cvRkyuoJ
    s-kbcInwt2R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ekkeejieeiieegvedvvdejjeegfeffleekudekgedvudeggeevgfekvdfhvdelfeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedutdeirdeiledrvdehfedrvdefle
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghv
    vghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:uXZ9YEIFiGD3jPq371dc1ebDjznVTn3WGs1wlTzn9H2ojKIXRnYFPg>
    <xmx:uXZ9YEH1XqgyS5gDYoSL5WKftv2tQZv5VosrDgDnLtKw0NHha52vEw>
    <xmx:uXZ9YAWX9rKYvUBFU_xyQL2vWL0ZLK817d_-iC0Ub1V76NvuMvECzg>
    <xmx:unZ9YDEsINb4HUNmjjbQQCe8f_3N-ltxWKhEm6NuKUfSSYT9S3reyPBd2eY>
Received: from mickey.themaw.net (106-69-253-239.dyn.iinet.net.au [106.69.253.239])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2BB131080066;
        Mon, 19 Apr 2021 08:25:24 -0400 (EDT)
Message-ID: <29a018c9d7dce71be8321c4f8a129a2880cf3348.camel@themaw.net>
Subject: Re: [PATCH v3 0/4] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 19 Apr 2021 20:25:20 +0800
In-Reply-To: <CAC2o3DKNc=sL2n8291Dpiyb0bRHaX=nd33ogvO_LkJqpBj-YmA@mail.gmail.com>
References: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
         <CAC2o3DKNc=sL2n8291Dpiyb0bRHaX=nd33ogvO_LkJqpBj-YmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-04-19 at 15:56 +0800, Fox Chen wrote:
> On Fri, Apr 9, 2021 at 9:14 AM Ian Kent <raven@themaw.net> wrote:
> > There have been a few instances of contention on the kernfs_mutex
> > during
> > path walks, a case on very large IBM systems seen by myself, a
> > report by
> > Brice Goglin and followed up by Fox Chen, and I've since seen a
> > couple
> > of other reports by CoreOS users.
> > 
> > The common thread is a large number of kernfs path walks leading to
> > slowness of path walks due to kernfs_mutex contention.
> > 
> > The problem being that changes to the VFS over some time have
> > increased
> > it's concurrency capabilities to an extent that kernfs's use of a
> > mutex
> > is no longer appropriate. There's also an issue of walks for non-
> > existent
> > paths causing contention if there are quite a few of them which is
> > a less
> > common problem.
> > 
> > This patch series is relatively straight forward.
> > 
> > All it does is add the ability to take advantage of VFS negative
> > dentry
> > caching to avoid needless dentry alloc/free cycles for lookups of
> > paths
> > that don't exit and change the kernfs_mutex to a read/write
> > semaphore.
> > 
> > The patch that tried to stay in VFS rcu-walk mode during path walks
> > has
> > been dropped for two reasons. First, it doesn't actually give very
> > much
> > improvement and, second, if there's a place where mistakes could go
> > unnoticed it would be in that path. This makes the patch series
> > simpler
> > to review and reduces the likelihood of problems going unnoticed
> > and
> > popping up later.
> > 
> > The patch to use a revision to identify if a directory has changed
> > has
> > also been dropped. If the directory has changed the dentry revision
> > needs to be updated to avoid subsequent rb tree searches and after
> > changing to use a read/write semaphore the update also requires a
> > lock.
> > But the d_lock is the only lock available at this point which might
> > itself be contended.
> > 
> > Changes since v2:
> > - actually fix the inode attribute update locking.
> > - drop the patch that tried to stay in rcu-walk mode.
> > - drop the use a revision to identify if a directory has changed
> > patch.
> > 
> > Changes since v1:
> > - fix locking in .permission() and .getattr() by re-factoring the
> > attribute
> >   handling code.
> > 
> > ---
> > 
> > Ian Kent (4):
> >       kernfs: move revalidate to be near lookup
> >       kernfs: use VFS negative dentry caching
> >       kernfs: switch kernfs to use an rwsem
> >       kernfs: use i_lock to protect concurrent inode updates
> > 
> > 
> >  fs/kernfs/dir.c             |  240 +++++++++++++++++++++++------
> > --------------
> >  fs/kernfs/file.c            |    4 -
> >  fs/kernfs/inode.c           |   18 ++-
> >  fs/kernfs/kernfs-internal.h |    5 +
> >  fs/kernfs/mount.c           |   12 +-
> >  fs/kernfs/symlink.c         |    4 -
> >  include/linux/kernfs.h      |    2
> >  7 files changed, 155 insertions(+), 130 deletions(-)
> > 
> > --
> > 
> 
> Hi Ian,
> 
> I tested this patchset with my
> benchmark(https://github.com/foxhlchen/sysfs_benchmark) on a 96 CPUs
> (aws c5) machine.
> 
> The result was promising:
> Before, one open+read+close cycle took 500us without much variation.
> With this patch, the fastest one only takes 30us, though the slowest
> is still around 100us(due to the spinlock). perf report shows no more
> significant mutex contention.

Thanks for this Fox.
I'll have a look through the data a bit later.

For now, I'd like to keep the series as simple as possible.

But there shouldn't be a problem reading and comparing those
attributes between the kernfs node and the inode without taking
the additional lock. So a check could be done and the lock only
taken if an update is needed.

That may well improve that worst case quite a bit, but as I say,
it would need to be a follow up change.

Ian

