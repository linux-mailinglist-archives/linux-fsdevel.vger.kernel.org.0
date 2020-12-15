Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF242DAD9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 14:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgLONAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 08:00:13 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33305 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728632AbgLONAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:00:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 35AF7580396;
        Tue, 15 Dec 2020 07:59:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 15 Dec 2020 07:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        qHNuiRPUfmhVpEZXQy+wUvMfpqmiGB2JR0+F6M2f928=; b=fwbKxu8ZHkGxH205
        /T02XtvEqPcMvG411U6TosC2y9trk9lFZEXtlvVAyGffVaFxwdADm/wADzdP5ke1
        LmrAikzJ6iveCdNBw+1r7af7SzixNko3ASOuIx75e5RbHDpWV2MddaZIZ4BO77hJ
        bz5Wduv+ko8WzKYgRyr1s/UP++r2YV6h6LggmRos1Nez04JpVy/PU4Zvt8UQyWRk
        nVwG018dtsVVvrVxyyoI1gqTV24rpBkXaixSRuB2VlMlR+u2pPur7I1qlI40jVKF
        7wL5A4W+/DbOtArrL3aoclMoaZ0su/xMaeE25QraMzeZZe//enfBwjuEDKL8Q2DJ
        s2kDDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=qHNuiRPUfmhVpEZXQy+wUvMfpqmiGB2JR0+F6M2f9
        28=; b=FPC7PX3gbLRHVu6UJrxs9PN9QtuaUYE9dEi2pjbDmAloC6PEfchafX/Mb
        EiIoZcmEW7iHfVoH4Vn8b8KHsBbfN3+oXqPG+LpojjDZrxJMJG+pIji+34YsHQP0
        qulen4o2yU2T8zoWvFHHqh53qrkgopw3mVmDGo9lAVPcF4/vbxT05hEI2yjZQAgi
        a8Ub5aXIWyQxIuCHdQ3BTEFSSBT6gBkzYnM7ETFOkT0z6O3STKE8JcPHfVPyk2RB
        Ep66F3gx1oRpEwlGhZDi5SrE4XuzwqTU3db1o3IHN8q2AwiyCxo5BFspv2AqN0hn
        MJphSERkaqG0A6dcdBIQbgse+BLRw==
X-ME-Sender: <xms:LLPYXyjPVo6YdTdpi4FfT5bFigqtV7Ykhpq9wQlvM4c-suJMKu4-Vg>
    <xme:LLPYX234qImRz7A8vkMEWr8B7GNSMCubiwNxw5MvsLFpa1iYjhCs8dDzK6BSk6HDY
    WQ3Y7Uw3_pF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeltddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eikeeggeeuvdevgfefiefhudekkeegheeileejveethedutedvveehudffjeevudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddurdeggedrudefhedrudefle
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghv
    vghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:LLPYXzIU7Uh9nR8xRe8zOWTVA4P8RI1Hjjr7nIz7f5GteU0uduPuBA>
    <xmx:LLPYX-zgCHt1MpN1IHCmnWUOYKCeJsDLK2TkkWyMkuJsOMta7sDM4g>
    <xmx:LLPYX5XH1Oy1hGKGUBbeiH2j2N3RwA0_6OVmZsk1jTu5ouKGcllawg>
    <xmx:L7PYX4sE4fXbgaDv_hniudsXrHh6qd5UiadNjDkbxJMFHiqk8rPKXA>
Received: from mickey.themaw.net (unknown [121.44.135.139])
        by mail.messagingengine.com (Postfix) with ESMTPA id 405DB240066;
        Tue, 15 Dec 2020 07:59:20 -0500 (EST)
Message-ID: <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, Tejun Heo <tj@kernel.org>,
        viro@zeniv.linux.org.uk
Date:   Tue, 15 Dec 2020 20:59:17 +0800
In-Reply-To: <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20201210164423.9084-1-foxhlchen@gmail.com>
         <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
         <13e21e4c9a5841243c8d130cf9324f6cfc4dc2e1.camel@themaw.net>
         <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
         <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
         <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
         <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-12-15 at 16:33 +0800, Fox Chen wrote:
> On Mon, Dec 14, 2020 at 9:30 PM Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2020-12-14 at 14:14 +0800, Fox Chen wrote:
> > > On Sun, Dec 13, 2020 at 11:46 AM Ian Kent <raven@themaw.net>
> > > wrote:
> > > > On Fri, 2020-12-11 at 10:17 +0800, Ian Kent wrote:
> > > > > On Fri, 2020-12-11 at 10:01 +0800, Ian Kent wrote:
> > > > > > > For the patches, there is a mutex_lock in kn->attr_mutex, 
> > > > > > > as
> > > > > > > Tejun
> > > > > > > mentioned here
> > > > > > > (
> > > > > > > https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/
> > > > > > > ),
> > > > > > > maybe a global
> > > > > > > rwsem for kn->iattr will be better??
> > > > > > 
> > > > > > I wasn't sure about that, IIRC a spin lock could be used
> > > > > > around
> > > > > > the
> > > > > > initial check and checked again at the end which would
> > > > > > probably
> > > > > > have
> > > > > > been much faster but much less conservative and a bit more
> > > > > > ugly
> > > > > > so
> > > > > > I just went the conservative path since there was so much
> > > > > > change
> > > > > > already.
> > > > > 
> > > > > Sorry, I hadn't looked at Tejun's reply yet and TBH didn't
> > > > > remember
> > > > > it.
> > > > > 
> > > > > Based on what Tejun said it sounds like that needs work.
> > > > 
> > > > Those attribute handling patches were meant to allow taking the
> > > > rw
> > > > sem read lock instead of the write lock for
> > > > kernfs_refresh_inode()
> > > > updates, with the added locking to protect the inode attributes
> > > > update since it's called from the VFS both with and without the
> > > > inode lock.
> > > 
> > > Oh, understood. I was asking also because lock on kn->attr_mutex
> > > drags
> > > concurrent performance.
> > > 
> > > > Looking around it looks like kernfs_iattrs() is called from
> > > > multiple
> > > > places without a node database lock at all.
> > > > 
> > > > I'm thinking that, to keep my proposed change straight forward
> > > > and on topic, I should just leave kernfs_refresh_inode() taking
> > > > the node db write lock for now and consider the attributes
> > > > handling
> > > > as a separate change. Once that's done we could reconsider
> > > > what's
> > > > needed to use the node db read lock in kernfs_refresh_inode().
> > > 
> > > You meant taking write lock of kernfs_rwsem for
> > > kernfs_refresh_inode()??
> > > It may be a lot slower in my benchmark, let me test it.
> > 
> > Yes, but make sure the write lock of kernfs_rwsem is being taken
> > not the read lock.
> > 
> > That's a mistake I had initially?
> > 
> > Still, that attributes handling is, I think, sufficient to warrant
> > a separate change since it looks like it might need work, the
> > kernfs
> > node db probably should be kept stable for those attribute updates
> > but equally the existence of an instantiated dentry might mitigate
> > the it.
> > 
> > Some people might just know whether it's ok or not but I would like
> > to check the callers to work out what's going on.
> > 
> > In any case it's academic if GCH isn't willing to consider the
> > series
> > for review and possible merge.
> > 
> Hi Ian
> 
> I removed kn->attr_mutex and changed read lock to write lock for
> kernfs_refresh_inode
> 
> down_write(&kernfs_rwsem);
> kernfs_refresh_inode(kn, inode);
> up_write(&kernfs_rwsem);
> 
> 
> Unfortunate, changes in this way make things worse,  my benchmark
> runs
> 100% slower than upstream sysfs.  :(
> open+read+close a sysfs file concurrently took 1000us. (Currently,
> sysfs with a big mutex kernfs_mutex only takes ~500us
> for one open+read+close operation concurrently)

Right, so it does need attention nowish.

I'll have a look at it in a while, I really need to get a new autofs
release out, and there are quite a few changes, and testing is seeing
a number of errors, some old, some newly introduced. It's proving
difficult.

> 
> > --45.93%--kernfs_iop_permission
>                                   |                                |
>                   |          |          |          |
>                                   |                                |
>                   |          |          |
> > --22.55%--down_write
>                                   |                                |
>                   |          |          |          |          |
>                                   |                                |
>                   |          |          |          |
> --20.69%--rwsem_down_write_slowpath
>                                   |                                |
>                   |          |          |          |
>   |
>                                   |                                |
>                   |          |          |          |
>   |--8.89%--schedule
> 
> perf showed most of the time had been spent on kernfs_iop_permission
> 
> 
> thanks,
> fox

