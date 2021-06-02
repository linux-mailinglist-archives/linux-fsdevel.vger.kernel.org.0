Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855D53980BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 07:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFBFnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 01:43:42 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:55983 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230055AbhFBFnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 01:43:41 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EDC0158095D;
        Wed,  2 Jun 2021 01:41:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 02 Jun 2021 01:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        QB/0xZpsDFsfe7kzn9RW18VuOpTUDa+ex8OTHsbhbEk=; b=vwog3kS7l73qGDW/
        K43KByzvpATQAElJsTcfdHaPhzbgGsKwvVDbKBioK6OCYVfNba1QfaKkc51iBC60
        1CJJAITKHSWTeibTBXJB93VWlXdAEmeWSufQNYgeO6guJeRJUfJvks4lnxGDjHaj
        BkWpaNkiFlUPXFIszHN81/vv/UNzdcuCa8J4IPGfs7Wl8ryDYRck7ohgrDtPNe7a
        Vlbn9f0xOIniP/AVhmaUSU5pey9QzzIwJUdgJp8ONN23BgTwP/I3HjZ4DO6EsmA/
        wb+HYAvUCFw4HqlWyTPGL6oiTOTNwGwaduKnZMYRH74sgJchqMG7L8bxNJVmVU9r
        O32S/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=QB/0xZpsDFsfe7kzn9RW18VuOpTUDa+ex8OTHsbhb
        Ek=; b=QdQTkTSATCay/eoWzoctc94OjUF/QI/8LXeeJRVIsNPixE3tzNs9c166F
        7gPjWRe4e5i45hJVq4WL3/KmV9chDGSWFR1rz4Z2qUaWZpg3V868HleY9CO/+6g/
        2pmuSPjtgq5N6Glbk3HWzhfKj98Hpk+Dvpa/4mQdMthydCHaD4CIf9JaGwHW/8t4
        i5eV9UUglRXYEp8ek0RLkx4nEZ6g8sAMsCifQXR9NR2ksuGFGmFErVL2v8GjFVTs
        ekai6hGC2tCXedJ/79crO/YyXL9qrfUjgzY8NLDQSyq2/JbXkPAkk+rszciEygeP
        5iTMuWYlTSqYJdNJhKNd6DqF/odKA==
X-ME-Sender: <xms:JRq3YOp_DcVCtmdIehCGUi-SGqn6C5jN5WVO4m2sXUCv_4zD3FI5nQ>
    <xme:JRq3YMrOWSdTV7nxMb5EKC9yvbNJpqAPMJ-RaNqhL1KIJEH2fUOTdcO2Zhz4CAgel
    _PZRuvYwP9O>
X-ME-Received: <xmr:JRq3YDPgnjaiwCCYsnfpv7kRwarAILWbCb-eqyrsYeWu9ncvT5eWB_-gyxkGrhba2VkXsZo6DKwYw0NSIQLisqslpEnCTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeliedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:JRq3YN6z-izXAu3Qts8xjw_dMHR2xy3nm2yAO0m8GLREAtp3VrCA4w>
    <xmx:JRq3YN7NQ_Xju-knnmMTxKXG4_iQIZ_bVc0KMJhUk7HC3jTIgBrC5g>
    <xmx:JRq3YNi3YibGJCR0MEIQtA_B7k_0o5m5g1YT0vq04saBmHAYXGCPjA>
    <xmx:JRq3YCGIvD4F5wttcceUczQQRjJEuqNDpa4_DrEw3ljHwQvJNV93SQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jun 2021 01:41:52 -0400 (EDT)
Message-ID: <b92354fb396cd9a93fce1b3d2bb2744f0535d22f.camel@themaw.net>
Subject: Re: [REPOST PATCH v4 4/5] kernfs: use i_lock to protect concurrent
 inode updates
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Jun 2021 13:41:38 +0800
In-Reply-To: <CAJfpegshedor_ZiQ_8EdLGRG0AEWb5Sy5Pa4SwPg9+f196_mGg@mail.gmail.com>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
         <162218366632.34379.11311748209082333016.stgit@web.messagingengine.com>
         <CAJfpegshedor_ZiQ_8EdLGRG0AEWb5Sy5Pa4SwPg9+f196_mGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-06-01 at 15:18 +0200, Miklos Szeredi wrote:
> On Fri, 28 May 2021 at 08:34, Ian Kent <raven@themaw.net> wrote:
> > 
> > The inode operations .permission() and .getattr() use the kernfs
> > node
> > write lock but all that's needed is to keep the rb tree stable
> > while
> > updating the inode attributes as well as protecting the update
> > itself
> > against concurrent changes.
> > 
> > And .permission() is called frequently during path walks and can
> > cause
> > quite a bit of contention between kernfs node operations and path
> > walks when the number of concurrent walks is high.
> > 
> > To change kernfs_iop_getattr() and kernfs_iop_permission() to take
> > the rw sem read lock instead of the write lock an additional lock
> > is
> > needed to protect against multiple processes concurrently updating
> > the inode attributes and link count in kernfs_refresh_inode().
> > 
> > The inode i_lock seems like the sensible thing to use to protect
> > these
> > inode attribute updates so use it in kernfs_refresh_inode().
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/inode.c |   10 ++++++----
> >  fs/kernfs/mount.c |    4 ++--
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > index 3b01e9e61f14e..6728ecd81eb37 100644
> > --- a/fs/kernfs/inode.c
> > +++ b/fs/kernfs/inode.c
> > @@ -172,6 +172,7 @@ static void kernfs_refresh_inode(struct
> > kernfs_node *kn, struct inode *inode)
> >  {
> >         struct kernfs_iattrs *attrs = kn->iattr;
> > 
> > +       spin_lock(&inode->i_lock);
> >         inode->i_mode = kn->mode;
> >         if (attrs)
> >                 /*
> > @@ -182,6 +183,7 @@ static void kernfs_refresh_inode(struct
> > kernfs_node *kn, struct inode *inode)
> > 
> >         if (kernfs_type(kn) == KERNFS_DIR)
> >                 set_nlink(inode, kn->dir.subdirs + 2);
> > +       spin_unlock(&inode->i_lock);
> >  }
> > 
> >  int kernfs_iop_getattr(struct user_namespace *mnt_userns,
> > @@ -191,9 +193,9 @@ int kernfs_iop_getattr(struct user_namespace
> > *mnt_userns,
> >         struct inode *inode = d_inode(path->dentry);
> >         struct kernfs_node *kn = inode->i_private;
> > 
> > -       down_write(&kernfs_rwsem);
> > +       down_read(&kernfs_rwsem);
> >         kernfs_refresh_inode(kn, inode);
> > -       up_write(&kernfs_rwsem);
> > +       up_read(&kernfs_rwsem);
> > 
> >         generic_fillattr(&init_user_ns, inode, stat);
> >         return 0;
> > @@ -284,9 +286,9 @@ int kernfs_iop_permission(struct user_namespace
> > *mnt_userns,
> > 
> >         kn = inode->i_private;
> > 
> > -       down_write(&kernfs_rwsem);
> > +       down_read(&kernfs_rwsem);
> >         kernfs_refresh_inode(kn, inode);
> > -       up_write(&kernfs_rwsem);
> > +       up_read(&kernfs_rwsem);
> > 
> >         return generic_permission(&init_user_ns, inode, mask);
> >  }
> > diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> > index baa4155ba2edf..f2f909d09f522 100644
> > --- a/fs/kernfs/mount.c
> > +++ b/fs/kernfs/mount.c
> > @@ -255,9 +255,9 @@ static int kernfs_fill_super(struct super_block
> > *sb, struct kernfs_fs_context *k
> >         sb->s_shrink.seeks = 0;
> > 
> >         /* get root inode, initialize and unlock it */
> > -       down_write(&kernfs_rwsem);
> > +       down_read(&kernfs_rwsem);
> >         inode = kernfs_get_inode(sb, info->root->kn);
> > -       up_write(&kernfs_rwsem);
> > +       up_read(&kernfs_rwsem);
> >         if (!inode) {
> >                 pr_debug("kernfs: could not get root inode\n");
> >                 return -ENOMEM;
> > 
> 
> This last hunk is not mentioned in the patch header.  Why is this
> needed?

Yes, that's right.

The lock is needed to keep the node rb tree stable.

kernfs_get_inode() calls kernfs_refresh_inode() indirectly so
since the i_lock is probably not needed here this hunk could
just as well have gone into the rwsem change but because of
that kernfs_refresh_inode() call it also makes sense to put
it here.

I'd prefer to keep it here and clearly what's going on isn't
as obvious as I thought so I can add this reasoning to the
description if you still think it's worth while?

> 
> Otherwise looks good.
> 
> Thanks,
> Miklos


