Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF60E2DCBC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 05:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLQErK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 23:47:10 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:35897 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726500AbgLQErJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 23:47:09 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id CB56D5801AC;
        Wed, 16 Dec 2020 23:46:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 16 Dec 2020 23:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        Z5FYIaOY1V4vtzgdaYyrEq3twWiZ7KO+O8GPUlhDfBY=; b=CiRiGE5sttxcdi1o
        EwT/ccUEkOFScS+KVOzNxAZkpYSoe+51AT8M0Zm6nRLXlVUzdus+PNIg2kmrGFZl
        llsQe1hyJPL0/FwZEAsaKSwHi1aU9mUtJA9OceZYsEQzzP5MXw4xxZ43uy9IygvU
        Xp4fRFme/f/qxuYh4wYPj0RudaJoKnGHQMBwWaTjCx/p1eH5MJe1BYqsmhCN5aXI
        xVaJuU2+n4qUqWZLnFU6X8HExyNrmH4fbYEFQamJltUEp21AuaqYXkaBdI2U40J/
        7qK8ixx1XbZCJ8zL+zHokJXTptqAQknzVG8uitrmtGMwpSXx2ccchEfqFtpLI2B0
        R3lAOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Z5FYIaOY1V4vtzgdaYyrEq3twWiZ7KO+O8GPUlhDf
        BY=; b=AkibfdAW8EeqKH3fqx5NWADZLDAr+QnAMqS4Tt+0dCcaexWXEwRKfCPUf
        U4bMPi7d5kAHlq8BJX98sBXJIk79Rjj1iw9HdqKtRlLMAlgFm4TEAhUHWItss5mo
        hRhaMNPrIsD8SYhiwVGc9AwJRc/TRl2pcduFnHiCHWA3Urz/P4/HKyqCGhoeO+EH
        A/rfLLe13yntBgNuYqEykjO3XsVoS+SH7TEtNutZRCjT45gllnQHruYa/bXdFfty
        VdpgRq8GaGJJDNycxmjJcKvXAl5vKI6woPmXic0Q/ajkQhDgP3daMnauHeWx2RfL
        Vu2aAPIcyihbp9S4pXdfbvPwVqnyA==
X-ME-Sender: <xms:nOLaX5ze-KykKFlrSvTyOHwaByRlvXOIucJw5asOALwvHu4qFHnCHg>
    <xme:nOLaX5QMvQUV6nXz6oonPheGesM6zexU5Xc5BsOkaZlNHOc9Th7WM_kYLUJUYCzGe
    ndJtmosNNKm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelfedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eikeeggeeuvdevgfefiefhudekkeegheeileejveethedutedvveehudffjeevudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddurdeggedrudefhedrudefle
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghv
    vghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:nOLaXzWrmzJiTeHf4Cb7mtx23f9Ciqn6UrCtgzuGNOw4lEo7muHUtQ>
    <xmx:nOLaX7jv2Hdt2hh6jMlVMSW6UF6MMmU1PRShpnHwlWT5Lrmkh0W_lw>
    <xmx:nOLaX7Alobg8qgd9ib5vvO0dz3Ovc5PyiXyFiBvgFovPM3Z0jyr13A>
    <xmx:nuLaX9DjkhQMo5a3veu1HJKkH9wCnvPUki75izt69DzMSVU-oz6Y2g>
Received: from mickey.themaw.net (unknown [121.44.135.139])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4B7A924005A;
        Wed, 16 Dec 2020 23:46:17 -0500 (EST)
Message-ID: <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
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
Date:   Thu, 17 Dec 2020 12:46:13 +0800
In-Reply-To: <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20201210164423.9084-1-foxhlchen@gmail.com>
         <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
         <13e21e4c9a5841243c8d130cf9324f6cfc4dc2e1.camel@themaw.net>
         <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
         <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
         <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
         <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
         <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-12-15 at 20:59 +0800, Ian Kent wrote:
> On Tue, 2020-12-15 at 16:33 +0800, Fox Chen wrote:
> > On Mon, Dec 14, 2020 at 9:30 PM Ian Kent <raven@themaw.net> wrote:
> > > On Mon, 2020-12-14 at 14:14 +0800, Fox Chen wrote:
> > > > On Sun, Dec 13, 2020 at 11:46 AM Ian Kent <raven@themaw.net>
> > > > wrote:
> > > > > On Fri, 2020-12-11 at 10:17 +0800, Ian Kent wrote:
> > > > > > On Fri, 2020-12-11 at 10:01 +0800, Ian Kent wrote:
> > > > > > > > For the patches, there is a mutex_lock in kn-
> > > > > > > > >attr_mutex, 
> > > > > > > > as
> > > > > > > > Tejun
> > > > > > > > mentioned here
> > > > > > > > (
> > > > > > > > https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/
> > > > > > > > ),
> > > > > > > > maybe a global
> > > > > > > > rwsem for kn->iattr will be better??
> > > > > > > 
> > > > > > > I wasn't sure about that, IIRC a spin lock could be used
> > > > > > > around
> > > > > > > the
> > > > > > > initial check and checked again at the end which would
> > > > > > > probably
> > > > > > > have
> > > > > > > been much faster but much less conservative and a bit
> > > > > > > more
> > > > > > > ugly
> > > > > > > so
> > > > > > > I just went the conservative path since there was so much
> > > > > > > change
> > > > > > > already.
> > > > > > 
> > > > > > Sorry, I hadn't looked at Tejun's reply yet and TBH didn't
> > > > > > remember
> > > > > > it.
> > > > > > 
> > > > > > Based on what Tejun said it sounds like that needs work.
> > > > > 
> > > > > Those attribute handling patches were meant to allow taking
> > > > > the
> > > > > rw
> > > > > sem read lock instead of the write lock for
> > > > > kernfs_refresh_inode()
> > > > > updates, with the added locking to protect the inode
> > > > > attributes
> > > > > update since it's called from the VFS both with and without
> > > > > the
> > > > > inode lock.
> > > > 
> > > > Oh, understood. I was asking also because lock on kn-
> > > > >attr_mutex
> > > > drags
> > > > concurrent performance.
> > > > 
> > > > > Looking around it looks like kernfs_iattrs() is called from
> > > > > multiple
> > > > > places without a node database lock at all.
> > > > > 
> > > > > I'm thinking that, to keep my proposed change straight
> > > > > forward
> > > > > and on topic, I should just leave kernfs_refresh_inode()
> > > > > taking
> > > > > the node db write lock for now and consider the attributes
> > > > > handling
> > > > > as a separate change. Once that's done we could reconsider
> > > > > what's
> > > > > needed to use the node db read lock in
> > > > > kernfs_refresh_inode().
> > > > 
> > > > You meant taking write lock of kernfs_rwsem for
> > > > kernfs_refresh_inode()??
> > > > It may be a lot slower in my benchmark, let me test it.
> > > 
> > > Yes, but make sure the write lock of kernfs_rwsem is being taken
> > > not the read lock.
> > > 
> > > That's a mistake I had initially?
> > > 
> > > Still, that attributes handling is, I think, sufficient to
> > > warrant
> > > a separate change since it looks like it might need work, the
> > > kernfs
> > > node db probably should be kept stable for those attribute
> > > updates
> > > but equally the existence of an instantiated dentry might
> > > mitigate
> > > the it.
> > > 
> > > Some people might just know whether it's ok or not but I would
> > > like
> > > to check the callers to work out what's going on.
> > > 
> > > In any case it's academic if GCH isn't willing to consider the
> > > series
> > > for review and possible merge.
> > > 
> > Hi Ian
> > 
> > I removed kn->attr_mutex and changed read lock to write lock for
> > kernfs_refresh_inode
> > 
> > down_write(&kernfs_rwsem);
> > kernfs_refresh_inode(kn, inode);
> > up_write(&kernfs_rwsem);
> > 
> > 
> > Unfortunate, changes in this way make things worse,  my benchmark
> > runs
> > 100% slower than upstream sysfs.  :(
> > open+read+close a sysfs file concurrently took 1000us. (Currently,
> > sysfs with a big mutex kernfs_mutex only takes ~500us
> > for one open+read+close operation concurrently)
> 
> Right, so it does need attention nowish.
> 
> I'll have a look at it in a while, I really need to get a new autofs
> release out, and there are quite a few changes, and testing is seeing
> a number of errors, some old, some newly introduced. It's proving
> difficult.

I've taken a breather for the autofs testing and had a look at this.

I think my original analysis of this was wrong.

Could you try this patch please.
I'm not sure how much difference it will make but, in principle,
it's much the same as the previous approach except it doesn't
increase the kernfs node struct size or mess with the other
attribute handling code.

Note, this is not even compile tested.

kernfs: use kernfs read lock in .getattr() and .permission()

From: Ian Kent <raven@themaw.net>

From Documenation/filesystems.rst and (slightly outdated) comments
in fs/attr.c the inode i_rwsem is used for attribute handling.

This lock satisfies the requirememnts needed to reduce lock contention,
namely a per-object lock needs to be used rather than a file system
global lock with the kernfs node db held stable for read operations.

In particular it should reduce lock contention seen when calling the
kernfs .permission() method.

The inode methods .getattr() and .permission() do not hold the inode
i_rwsem lock when called as they are usually read operations. Also
the .permission() method checks for rcu-walk mode and returns -ECHILD
to the VFS if it is set. So the i_rwsem lock can be used in
kernfs_iop_getattr() and kernfs_iop_permission() to protect the inode
update done by kernfs_refresh_inode(). Using this lock allows the
kernfs node db write lock in these functions to be changed to a read
lock.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/inode.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index ddaf18198935..568037e9efe9 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -189,9 +189,11 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	inode_lock(inode);
+	down_read(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
+	up_read(&kernfs_rwsem);
+	inode_unlock(inode);
 
 	generic_fillattr(inode, stat);
 	return 0;
@@ -281,9 +283,11 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 
 	kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	inode_lock(inode);
+	down_read(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
+	up_read(&kernfs_rwsem);
+	inode_unlock(inode);
 
 	return generic_permission(inode, mask);
 }

