Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C0940A420
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 05:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbhINDHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 23:07:08 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36891 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237777AbhINDHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:07:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id AF09A320090A;
        Mon, 13 Sep 2021 23:05:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 13 Sep 2021 23:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        pWT6enqorNf1H50/A0smvSLe6BXWJ4knlGyohQ5mQfI=; b=ntRo4d4R+7XwsQjt
        bHcvl7zV0hvDUfcVLHFhDwXcYWB0sTIhI1a2OG8sMI/zsrxpE+JqXS6KC6oeJ4KQ
        yZMyPKbKI8vdx11Ix1jKk6Y5tBoZNjryIRm+eWVlYStzJn4P+S5nSCHLhtyjVX/B
        va56uXVuPE1sFEQzZnWDZxNjqHRCfu1jPIdS1t504HSVsY2TodJrasUVIRwf5u4c
        HQNP2f91PUo5QIZCfqQj/psxKBlLvSuuqmHv3f09WouQwHoG3dycWIWIx5HegJKd
        +an5Gdvm00brWf/JP3mqf3cmgVcvRYeBZQEn7XVHMDl7/AU+aP0W8F4zfZ3xNeZo
        iBWLBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=pWT6enqorNf1H50/A0smvSLe6BXWJ4knlGyohQ5mQ
        fI=; b=ld6vAERnN0FgJ1ruzEPibDm1vJtsvTWPY3IH14DRZ1bRQ/1VZ6PjJIr1I
        UIsLp4/ImAm5KcjOzXyStgEHEWptWIjoD0QiNJwcEIMA4RJP5oTNTZBrdgc62V1b
        Z46R21qdaGDhwFKbGNES+aZkPs/glXBjJkdhAk6mULe5urymxasnnWXRAnmG0M4b
        mIq2ZGBID3/PMZtaNjTcxynKOt1oyaNJJx1Hbh1bevQCRPEVqhMCbY5hqf//pue5
        WyEl1U/u0KZIaVvdYUVodap8bl6SBCv4RpBtveacR7WVnxrAhQ+bRsnP54teD2tZ
        YLNeftqd3uQXnn/bFTCHkGVBu2grw==
X-ME-Sender: <xms:iBFAYYUSC5Ux8tck-yzC0vK7_a9SW21bwBE-QL7MPb8Qj6ZAuXeyvw>
    <xme:iBFAYcl87BhnxHaeyFU170dxW7RVdn5gvo8M-jBxch0ehm8Z-DkTvlh5ff57CNtBf
    AZc0q_2s8kJ>
X-ME-Received: <xmr:iBFAYcYPemMN8UXsfzpkR7AA7aMBfr22yw5t6bvfJAX48z-CE5CyxPVHA7_pwYeyqf6YjDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegkedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:iRFAYXUHkIhXeLbTXbaavrLif9z_Z3gfhDFhoarA-w7r_mob_XPmLQ>
    <xmx:iRFAYSkPJh6kHdnN9Iif1bJ5-joA4NYp9_iP2UAeOp8IcGB883aE2g>
    <xmx:iRFAYcfmhRC4NlhE7ypWdOIbmfqkwLMS06xBzcgXnxu1_ty978w0eQ>
    <xmx:ihFAYTBUgNJEGa-CHY2u55dXD4OUhFnrSoN3UNRhxkThEeyj8TbmMg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Sep 2021 23:05:42 -0400 (EDT)
Message-ID: <7b92b158200567f0bba26a038191156890921f13.camel@themaw.net>
Subject: Re: [PATCH] kernfs: fix the race in the creation of negative dentry
From:   Ian Kent <raven@themaw.net>
To:     Hou Tao <houtao1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Cc:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Sep 2021 11:05:37 +0800
In-Reply-To: <20210911021342.3280687-1-houtao1@huawei.com>
References: <20210911021342.3280687-1-houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-09-11 at 10:13 +0800, Hou Tao wrote:
> When doing stress test for module insertion and removal,
> the following phenomenon was found:

Apologies for the late reply.

> 
>   $ lsmod
>   Module                  Size  Used by
>   libkmod: kmod_module_get_holders: could not open \
>            '/sys/module/nbd/holders': No such file or directory
>   nbd                       -2  -2
>   $ cat /proc/modules
>   nbd 110592 0 - Live 0xffffffffc0298000
>   $ ls -1 /sys/module |grep nbd
>   ls: cannot access 'nbd': No such file or directory
>   nbd
> 
> It seems the kernfs node of module has been activated and is returned
> to
> ls command through kernfs_fop_readdir(), but the sysfs dentry is
> negative.
> Further investigation found that there is race between kernfs dir
> creation
> and dentry lookup as shown below:
> 
> CPU 0                          CPU 1
> 
>                         kernfs_add_one
> 
>                         down_write(&kernfs_rwsem)
>                         // insert nbd into rbtree
>                         // update the parent's revision
>                         kernfs_link_sibling()
>                         up_write(&kernfs_rwsem)
> 
> kernfs_iop_lookup
> 
> down_read(&kernfs_rwsem)
> // find nbd in rbtree, but it is deactivated
> kn = kernfs_find_ns()
>   // return false
>   kernfs_active()
>   // a negative is created
>   d_splice_alias(NULL, dentry)
> up_read(&kernfs_rwsem)
> 
>                         // activate after negative dentry is created
>                         kernfs_activate()
> 
> // return 0 because parent's
> // revision is stable now
> kernfs_dop_revalidate()
> 
> The race will create a negative dentry for a kernfs node which
> is newly-added and activated. To fix it, there are two cases
> to be handled:

Yes, I see.

This is a great analysis, thanks for the effort providing it.

> 
> (1) kernfs root without KERNFS_ROOT_CREATE_DEACTIVATED
> kernfs_rwsem can be always hold during kernfs_link_sibling()
> and kernfs_activate() in kernfs_add_one(), so kernfs_iop_lookup()
> will find an active kernfs node.
> 
> (2) kernfs root with KERNFS_ROOT_CREATE_DEACTIVATED
> kernfs_activate() is called separatedly, and we can invalidate
> the dentry subtree with kn as root by increasing the revision of
> its parent. But we can invalidate in a finer granularity by
> only invalidating the negative dentry of the newly-activated
> kn node.

I'm pretty sure your patch will fix the problem which is great.

But I'm not sure this is the best way or more importantly the
right way to do it.

The real problem here lies in the definition of a kernfs negative
dentry. At one time the series to change to an rwsem used the
kernfs node to determine negativeness in revalidate which is
a stronger check than the dentry inode alone.

The point here is that using an incorrect definition, as I have
done, could leave other unseen problems or cause the introduction
of new problems in new code.

There's also the question of how a kernfs root node gets used in
path walking (rather if it's negativity or activation state play
any part in it at all). Worth understanding but not a problem as
such.

I'm still looking at this (as time permits) and thinking about it.
Please give me more time to report back.

> 
> So factor out a helper kernfs_activate_locked() to activate
> kernfs subtree lockless and invalidate the negative dentries
> if requested. Creation under kernfs root with CREATED_DEACTIVATED
> doesn't need invalidation because kernfs_rwsem is always hold,
> and kernfs root w/o CREATED_DEACTIVATED needs to invalidate
> the maybe-created negative dentries.
> 
> kernfs_inc_rev() in kernfs_link_sibling() is kept because
> kernfs_rename_ns() needs it to invalidate the negative dentry
> of the target kernfs which is newly created by rename.
> 
> Fixes: c7e7c04274b1 ("kernfs: use VFS negative dentry caching")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/kernfs/dir.c | 52 +++++++++++++++++++++++++++++++++++++++--------
> --
>  1 file changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index ba581429bf7b..2f1ab8bad575 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -17,6 +17,8 @@
>  
>  #include "kernfs-internal.h"
>  
> +static void kernfs_activate_locked(struct kernfs_node *kn, bool
> invalidate);
> +
>  DECLARE_RWSEM(kernfs_rwsem);
>  static DEFINE_SPINLOCK(kernfs_rename_lock);    /* kn->parent and -
> >name */
>  static char kernfs_pr_cont_buf[PATH_MAX];      /* protected by
> rename_lock */
> @@ -753,8 +755,6 @@ int kernfs_add_one(struct kernfs_node *kn)
>                 ps_iattr->ia_mtime = ps_iattr->ia_ctime;
>         }
>  
> -       up_write(&kernfs_rwsem);
> -
>         /*
>          * Activate the new node unless CREATE_DEACTIVATED is
> requested.
>          * If not activated here, the kernfs user is responsible for
> @@ -763,8 +763,7 @@ int kernfs_add_one(struct kernfs_node *kn)
>          * trigger deactivation.
>          */
>         if (!(kernfs_root(kn)->flags &
> KERNFS_ROOT_CREATE_DEACTIVATED))
> -               kernfs_activate(kn);
> -       return 0;
> +               kernfs_activate_locked(kn, false);
>  
>  out_unlock:
>         up_write(&kernfs_rwsem);
> @@ -942,8 +941,11 @@ struct kernfs_root *kernfs_create_root(struct
> kernfs_syscall_ops *scops,
>         root->kn = kn;
>         init_waitqueue_head(&root->deactivate_waitq);
>  
> -       if (!(root->flags & KERNFS_ROOT_CREATE_DEACTIVATED))
> -               kernfs_activate(kn);
> +       if (!(root->flags & KERNFS_ROOT_CREATE_DEACTIVATED)) {
> +               down_write(&kernfs_rwsem);
> +               kernfs_activate_locked(kn, false);
> +               up_write(&kernfs_rwsem);
> +       }
>  
>         return root;
>  }
> @@ -1262,8 +1264,11 @@ static struct kernfs_node
> *kernfs_next_descendant_post(struct kernfs_node *pos,
>  }
>  
>  /**
> - * kernfs_activate - activate a node which started deactivated
> + * kernfs_activate_locked - activate a node which started
> deactivated
>   * @kn: kernfs_node whose subtree is to be activated
> + * @invalidate: whether or not to increase the revision of parent
> node
> + *              for each newly-activated child node. The increase
> will
> + *              invalidate negative dentries created under the
> parent node.
>   *
>   * If the root has KERNFS_ROOT_CREATE_DEACTIVATED set, a newly
> created node
>   * needs to be explicitly activated.  A node which hasn't been
> activated
> @@ -1271,15 +1276,15 @@ static struct kernfs_node
> *kernfs_next_descendant_post(struct kernfs_node *pos,
>   * removal.  This is useful to construct atomic init sequences where
>   * creation of multiple nodes should either succeed or fail
> atomically.
>   *
> + * The caller must have acquired kernfs_rwsem.
> + *
>   * The caller is responsible for ensuring that this function is not
> called
>   * after kernfs_remove*() is invoked on @kn.
>   */
> -void kernfs_activate(struct kernfs_node *kn)
> +static void kernfs_activate_locked(struct kernfs_node *kn, bool
> invalidate)
>  {
>         struct kernfs_node *pos;
>  
> -       down_write(&kernfs_rwsem);
> -
>         pos = NULL;
>         while ((pos = kernfs_next_descendant_post(pos, kn))) {
>                 if (pos->flags & KERNFS_ACTIVATED)
> @@ -1290,8 +1295,35 @@ void kernfs_activate(struct kernfs_node *kn)
>  
>                 atomic_sub(KN_DEACTIVATED_BIAS, &pos->active);
>                 pos->flags |= KERNFS_ACTIVATED;
> +
> +               /*
> +                * Invalidate the negative dentry created after pos
> is
> +                * inserted into sibling rbtree but before it is
> +                * activated.
> +                */
> +               if (invalidate && pos->parent)
> +                       kernfs_inc_rev(pos->parent);
>         }
> +}
>  
> +/**
> + * kernfs_activate - activate a node which started deactivated
> + * @kn: kernfs_node whose subtree is to be activated
> + *
> + * Currently it is only used by kernfs root which has
> + * FS_ROOT_CREATE_DEACTIVATED set. Because the addition and the
> activation
> + * of children nodes are not atomic (not always hold kernfs_rwsem),
> + * negative dentry may be created for one child node after its
> addition
> + * but before its activation, so passing invalidate as true to
> + * @kernfs_activate_locked() to invalidate these negative dentries.
> + *
> + * The caller is responsible for ensuring that this function is not
> called
> + * after kernfs_remove*() is invoked on @kn.
> + */
> +void kernfs_activate(struct kernfs_node *kn)
> +{
> +       down_write(&kernfs_rwsem);
> +       kernfs_activate_locked(kn, true);
>         up_write(&kernfs_rwsem);
>  }
>  


