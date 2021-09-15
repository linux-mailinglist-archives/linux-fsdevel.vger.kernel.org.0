Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28040BD87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 04:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhIOCLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 22:11:19 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:59081 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233061AbhIOCLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:11:19 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id BB7253200988;
        Tue, 14 Sep 2021 22:10:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 14 Sep 2021 22:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        iq6O0DScY5bQYeTCn+EPvYLzgkuGu4CZU2kYR/zNNf4=; b=mz8e00HQq/5hd5xg
        81o+mN4AIJ6WCgkiBPtVnVGHXEgV4xGrQudWmOmyaXdgJ5nF8tiHWeQvVuB4tOSr
        tBGZvs9tK6R/gsZpG4scUydYl6z4nf9s/EkKG1SqGPmixpXgrURYCZ1ZCm6Y2EYg
        ovx4fCJKblC+W2eZHFk6aNPtRluFoBMkriLJk9wxZa47OI9SKjhVUbS23kcYuJJ4
        LJdd++Itr7dBmbKmBbRjv/jBOI29H6rUG5yGIV0TOANssq5WkiHXtC2849dyQULV
        za1w7SXSNuWl3kmVTdArrYEmia05yacZpHN6ABF22d76WdNKpCEILOYSK00PTi98
        TcNBEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=iq6O0DScY5bQYeTCn+EPvYLzgkuGu4CZU2kYR/zNN
        f4=; b=hi1AnOmX9wzt11c15aUxsvOgp08BDW9xlYUZZrhkwhBRhv8nLw8fGsRoG
        fX5hFd2rtHaXl7pobtQDHovLUMCoAHLllhzJBvtjEix196qMBh9zQ6ajnhbhjPhJ
        m2GauTJA+OPpN9bCiF967yvwmIqhspFld+5MmCI3FGtkYFKbjnbqxxW2Yu+vGx5s
        detljnjQXfQi1PUUUZ362zEOB15seGhDoY1xC66HURkwyA3p7rX6K4uXry5h7mEk
        4BFb0BwuLhXkfqp3lfGPKwP2Qz81xAFoao+I+Ga01Z5oSW5TYhjRDyXvGPbSvcRg
        jwy8ft9Lj1JzMUCVwQobSyNpM5mXA==
X-ME-Sender: <xms:91VBYavLv3s_cWdv891mxOjZpmHLGiiiv70Pl1TtIk2-9O4k1Vbaqw>
    <xme:91VBYfd1P1X5Dq5ZkASTJnpIwgWVV93Z3oe3TlVjBMHCiiXgOir7OOCZ34yMiWcxs
    S9HpOJBfYjf>
X-ME-Received: <xmr:91VBYVx8FTnfzbDfuGwOCyvwlwqMqWkMmPCz5hnx-otziVYRM-W4HKf_re1Aizu1j6fRs5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehtddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:91VBYVMHlE3q87LPbV3Kq6wv5eWdN64k5_Yti_UW7bvE62hDfbgF7g>
    <xmx:91VBYa90Y_11DYy4ATJ3C7GPFYJ33YRVQSJ9MZKgl_yu5y2IicSY7w>
    <xmx:91VBYdWEaBICE_8agbuRK0ilZzk975xwz0fkD9Uw7aYtqyrdY9dq6w>
    <xmx:-FVBYeb8SY7EhpJdm9qTH3ck-JsNqI7-bxEFWQatnIZA86_z--bmLw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 22:09:56 -0400 (EDT)
Message-ID: <747aee3255e7a07168557f29ad962e34e9cb964b.camel@themaw.net>
Subject: Re: [PATCH] kernfs: fix the race in the creation of negative dentry
From:   Ian Kent <raven@themaw.net>
To:     Hou Tao <houtao1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Cc:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Sep 2021 10:09:54 +0800
In-Reply-To: <6c8088411523e52fc89b8dd07710c3825366ce64.camel@themaw.net>
References: <20210911021342.3280687-1-houtao1@huawei.com>
         <7b92b158200567f0bba26a038191156890921f13.camel@themaw.net>
         <6c8088411523e52fc89b8dd07710c3825366ce64.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-09-15 at 09:35 +0800, Ian Kent wrote:
> On Tue, 2021-09-14 at 11:05 +0800, Ian Kent wrote:
> > On Sat, 2021-09-11 at 10:13 +0800, Hou Tao wrote:
> > > When doing stress test for module insertion and removal,
> > > the following phenomenon was found:
> > 
> > Apologies for the late reply.
> > 
> > > 
> > >   $ lsmod
> > >   Module                  Size  Used by
> > >   libkmod: kmod_module_get_holders: could not open \
> > >            '/sys/module/nbd/holders': No such file or directory
> > >   nbd                       -2  -2
> > >   $ cat /proc/modules
> > >   nbd 110592 0 - Live 0xffffffffc0298000
> > >   $ ls -1 /sys/module |grep nbd
> > >   ls: cannot access 'nbd': No such file or directory
> > >   nbd
> > > 
> > > It seems the kernfs node of module has been activated and is
> > > returned
> > > to
> > > ls command through kernfs_fop_readdir(), but the sysfs dentry is
> > > negative.
> > > Further investigation found that there is race between kernfs dir
> > > creation
> > > and dentry lookup as shown below:
> > > 
> > > CPU 0                          CPU 1
> > > 
> > >                         kernfs_add_one
> > > 
> > >                         down_write(&kernfs_rwsem)
> > >                         // insert nbd into rbtree
> > >                         // update the parent's revision
> > >                         kernfs_link_sibling()
> > >                         up_write(&kernfs_rwsem)
> > > 
> > > kernfs_iop_lookup
> > > 
> > > down_read(&kernfs_rwsem)
> > > // find nbd in rbtree, but it is deactivated
> > > kn = kernfs_find_ns()
> > >   // return false
> > >   kernfs_active()
> > >   // a negative is created
> > >   d_splice_alias(NULL, dentry)
> > > up_read(&kernfs_rwsem)
> > > 
> > >                         // activate after negative dentry is
> > > created
> > >                         kernfs_activate()
> > > 
> > > // return 0 because parent's
> > > // revision is stable now
> > > kernfs_dop_revalidate()
> > > 
> > > The race will create a negative dentry for a kernfs node which
> > > is newly-added and activated. To fix it, there are two cases
> > > to be handled:
> > 
> > Yes, I see.
> > 
> > This is a great analysis, thanks for the effort providing it.
> > 
> > > 
> > > (1) kernfs root without KERNFS_ROOT_CREATE_DEACTIVATED
> > > kernfs_rwsem can be always hold during kernfs_link_sibling()
> > > and kernfs_activate() in kernfs_add_one(), so kernfs_iop_lookup()
> > > will find an active kernfs node.
> > > 
> > > (2) kernfs root with KERNFS_ROOT_CREATE_DEACTIVATED
> > > kernfs_activate() is called separatedly, and we can invalidate
> > > the dentry subtree with kn as root by increasing the revision of
> > > its parent. But we can invalidate in a finer granularity by
> > > only invalidating the negative dentry of the newly-activated
> > > kn node.
> > 
> > I'm pretty sure your patch will fix the problem which is great.
> > 
> > But I'm not sure this is the best way or more importantly the
> > right way to do it.
> > 
> > The real problem here lies in the definition of a kernfs negative
> > dentry. At one time the series to change to an rwsem used the
> > kernfs node to determine negativeness in revalidate which is
> > a stronger check than the dentry inode alone.
> > 
> > The point here is that using an incorrect definition, as I have
> > done, could leave other unseen problems or cause the introduction
> > of new problems in new code.
> > 
> > There's also the question of how a kernfs root node gets used in
> > path walking (rather if it's negativity or activation state play
> > any part in it at all). Worth understanding but not a problem as
> > such.
> > 
> > I'm still looking at this (as time permits) and thinking about it.
> > Please give me more time to report back.
> 
> Sorry to hold things up on this.
> 
> I'm still looking at it but thought I'd report my thoughts so
> far so you know I haven't forgotten about it.
> 
> Now, based on the original code, before the change to the rwsem,
> no dentry would be created for an inactive but existing node,
> they are meant to be invisible to the VFS.
> 
> That's a bug that I have introduced in kernfs_iop_lookup().
> I will need to fix that.

I think something like this is needed (not even compile tested):

kernfs: dont create a negative dentry if node exists

From: Ian Kent <raven@themaw.net>

In kernfs_iop_lookup() a negative dentry is created if associated kernfs
node is incative which makes it visible to lookups in the VFS path walk.

But inactive kernfs nodes are meant to be invisible to the VFS and
creating a negative for these can have unexpetced side effects.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ba581429bf7b..a957c944cf3a 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1111,7 +1111,14 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
 	/* attach dentry and inode */
-	if (kn && kernfs_active(kn)) {
+	if (kn) {
+		/* Inactive nodes are invisible to the VFS so don't
+		 * create a negative.
+		 */
+		if (!kernfs_active(kn)) {
+			up_read(&kernfs_rwsem);
+			return NULL;
+		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);


Essentially, the definition a kernfs negative dentry, for the
cases it is meant to cover, is one that has no kernfs node, so
one that does have a node should not be created as a negative.

Once activated a subsequent ->lookup() will then create a
positive dentry for the node so that no invalidation is
necessary.

This distinction is important because we absolutely do not want
negative dentries created that aren't necessary. We don't want to
leave any opportunities for negative dentries to accumulate if
we don't have to.
    
I am still thinking about the race you have described.

Given my above comments that race might have (maybe probably)
been present in the original code before the rwsem change but
didn't trigger because of the serial nature of the mutex.

So it may be wise (perhaps necessary) to at least move the
activation under the rwsem (as you have done) which covers most
of the change your proposing and the remaining hunk shouldn't
do any harm I think but again I need a little more time on that.

I'm now a little concerned about the invalidation that should
occur on deactivation so I want to have a look at that too but
it's separate to this proposal.

Greg, Tejun, Hou, any further thoughts on this would be most
welcome.

Ian
> 
> > 
> > So factor out a helper kernfs_activate_locked() to activate
> > kernfs subtree lockless and invalidate the negative dentries
> > if requested. Creation under kernfs root with CREATED_DEACTIVATED
> > doesn't need invalidation because kernfs_rwsem is always hold,
> > and kernfs root w/o CREATED_DEACTIVATED needs to invalidate
> > the maybe-created negative dentries.
> > 
> > kernfs_inc_rev() in kernfs_link_sibling() is kept because
> > kernfs_rename_ns() needs it to invalidate the negative dentry
> > of the target kernfs which is newly created by rename.
> > 
> > Fixes: c7e7c04274b1 ("kernfs: use VFS negative dentry caching")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  fs/kernfs/dir.c | 52 +++++++++++++++++++++++++++++++++++++++------
> > --
> > --
> >  1 file changed, 42 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index ba581429bf7b..2f1ab8bad575 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -17,6 +17,8 @@
> >  
> >  #include "kernfs-internal.h"
> >  
> > +static void kernfs_activate_locked(struct kernfs_node *kn, bool
> > invalidate);
> > +
> >  DECLARE_RWSEM(kernfs_rwsem);
> >  static DEFINE_SPINLOCK(kernfs_rename_lock);    /* kn->parent and -
> > > name */
> >  static char kernfs_pr_cont_buf[PATH_MAX];      /* protected by
> > rename_lock */
> > @@ -753,8 +755,6 @@ int kernfs_add_one(struct kernfs_node *kn)
> >                 ps_iattr->ia_mtime = ps_iattr->ia_ctime;
> >         }
> >  
> > -       up_write(&kernfs_rwsem);
> > -
> >         /*
> >          * Activate the new node unless CREATE_DEACTIVATED is
> > requested.
> >          * If not activated here, the kernfs user is responsible
> > for
> > @@ -763,8 +763,7 @@ int kernfs_add_one(struct kernfs_node *kn)
> >          * trigger deactivation.
> >          */
> >         if (!(kernfs_root(kn)->flags &
> > KERNFS_ROOT_CREATE_DEACTIVATED))
> > -               kernfs_activate(kn);
> > -       return 0;
> > +               kernfs_activate_locked(kn, false);
> >  
> >  out_unlock:
> >         up_write(&kernfs_rwsem);
> > @@ -942,8 +941,11 @@ struct kernfs_root *kernfs_create_root(struct
> > kernfs_syscall_ops *scops,
> >         root->kn = kn;
> >         init_waitqueue_head(&root->deactivate_waitq);
> >  
> > -       if (!(root->flags & KERNFS_ROOT_CREATE_DEACTIVATED))
> > -               kernfs_activate(kn);
> > +       if (!(root->flags & KERNFS_ROOT_CREATE_DEACTIVATED)) {
> > +               down_write(&kernfs_rwsem);
> > +               kernfs_activate_locked(kn, false);
> > +               up_write(&kernfs_rwsem);
> > +       }
> >  
> >         return root;
> >  }
> > @@ -1262,8 +1264,11 @@ static struct kernfs_node
> > *kernfs_next_descendant_post(struct kernfs_node *pos,
> >  }
> >  
> >  /**
> > - * kernfs_activate - activate a node which started deactivated
> > + * kernfs_activate_locked - activate a node which started
> > deactivated
> >   * @kn: kernfs_node whose subtree is to be activated
> > + * @invalidate: whether or not to increase the revision of parent
> > node
> > + *              for each newly-activated child node. The increase
> > will
> > + *              invalidate negative dentries created under the
> > parent node.
> >   *
> >   * If the root has KERNFS_ROOT_CREATE_DEACTIVATED set, a newly
> > created node
> >   * needs to be explicitly activated.  A node which hasn't been
> > activated
> > @@ -1271,15 +1276,15 @@ static struct kernfs_node
> > *kernfs_next_descendant_post(struct kernfs_node *pos,
> >   * removal.  This is useful to construct atomic init sequences
> > where
> >   * creation of multiple nodes should either succeed or fail
> > atomically.
> >   *
> > + * The caller must have acquired kernfs_rwsem.
> > + *
> >   * The caller is responsible for ensuring that this function is
> > not
> > called
> >   * after kernfs_remove*() is invoked on @kn.
> >   */
> > -void kernfs_activate(struct kernfs_node *kn)
> > +static void kernfs_activate_locked(struct kernfs_node *kn, bool
> > invalidate)
> >  {
> >         struct kernfs_node *pos;
> >  
> > -       down_write(&kernfs_rwsem);
> > -
> >         pos = NULL;
> >         while ((pos = kernfs_next_descendant_post(pos, kn))) {
> >                 if (pos->flags & KERNFS_ACTIVATED)
> > @@ -1290,8 +1295,35 @@ void kernfs_activate(struct kernfs_node *kn)
> >  
> >                 atomic_sub(KN_DEACTIVATED_BIAS, &pos->active);
> >                 pos->flags |= KERNFS_ACTIVATED;
> > +
> > +               /*
> > +                * Invalidate the negative dentry created after pos
> > is
> > +                * inserted into sibling rbtree but before it is
> > +                * activated.
> > +                */
> > +               if (invalidate && pos->parent)
> > +                       kernfs_inc_rev(pos->parent);
> >         }
> > +}
> >  
> > +/**
> > + * kernfs_activate - activate a node which started deactivated
> > + * @kn: kernfs_node whose subtree is to be activated
> > + *
> > + * Currently it is only used by kernfs root which has
> > + * FS_ROOT_CREATE_DEACTIVATED set. Because the addition and the
> > activation
> > + * of children nodes are not atomic (not always hold
> > kernfs_rwsem),
> > + * negative dentry may be created for one child node after its
> > addition
> > + * but before its activation, so passing invalidate as true to
> > + * @kernfs_activate_locked() to invalidate these negative
> > dentries.
> > + *
> > + * The caller is responsible for ensuring that this function is
> > not
> > called
> > + * after kernfs_remove*() is invoked on @kn.
> > + */
> > +void kernfs_activate(struct kernfs_node *kn)
> > +{
> > +       down_write(&kernfs_rwsem);
> > +       kernfs_activate_locked(kn, true);
> >         up_write(&kernfs_rwsem);
> >  }
> >  
> 



