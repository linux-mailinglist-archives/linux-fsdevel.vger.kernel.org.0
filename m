Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE9541C24E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245334AbhI2KLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 06:11:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52223 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245312AbhI2KLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:11:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B04725C00E4;
        Wed, 29 Sep 2021 06:09:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 Sep 2021 06:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        XyWpzuNutYoJcPGBx2ak1LF9tlTpcwxalOm9ZHW/Tro=; b=P1BVPtuWkTvgYHX5
        z8ZOGpy8oamtBLBhjac4yRmvRJHzOBLKEXYuwx7onZJfjVkCsJz5vr9agaL6iWht
        9JFwgKyjyfCfxYSZtynLd05ZHdIDCAM31SKu2gmvKpbeYIsmx7xlgA881DqR+Gm2
        +u15+5QKgkb8IDPzCtSQzsfav9HfRWaf3WZqWXMZN9ykGRKjRYfzGDEEwIZIa/VQ
        WZqutrECuAjK7/6m5yQN287tiyDcUdv3q44sozgQFfx74mFCM7w668FWzLNrDyG1
        F4R8+4SG4zrkibxUAEU/Bt8+D9pbIDI1kP9gVN+IrlETVqDjvZ7M3jiT4xWQObeY
        Vj7XSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=XyWpzuNutYoJcPGBx2ak1LF9tlTpcwxalOm9ZHW/T
        ro=; b=a+yo04FW0iDGO9ftwP/acjTujpAEyNCH8zwCC/jsHDg0lWXE9cFHLa3Lv
        6a2HRsEqaAWChQme1xTNmq1T9dxlzzFm+/BpnSk1qDSqpH+x3M4XCmOKXw80vpEl
        0UdA5DV2/ZUg1Mpqnu/blQIWHuxJ2DR1UNqEaBdylMO7/9B0zufYcEOkIoBAG9Ik
        fKtlyfVp/2c8MbpQJz2Vj1RkZFxmVr1ynZUboFbz28tP+VtCndT37QMVfwlMPZyA
        KBEYRmbd++hdzTd5JKNdhnSQUEcxhcpo0YngyYmrrFlqyokeDFfAM67f/GpfYhxR
        W6ICrJcFVnmm7nyI4ZAvXNOA/bwng==
X-ME-Sender: <xms:bjtUYYeaVv2EIUEYVjRqgOz0mcGVlM4eTvXD8Q-88VtBREhK23uitQ>
    <xme:bjtUYaMxH3vSO3n6n5S6y0EWnhuLqBUQEMQeLn5l88JP5035Qk4UGiRYE97tXcaUD
    exlOdGP-tIh>
X-ME-Received: <xmr:bjtUYZjshIZIQKsAJI0MGc4YgfvOJL_A_LXlAkaSaRNyOuvrZmIyuE2MFtgPl4dkHhx2Fco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekvddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    etjeefgeefiefffeetudeludegieeiueeggfetheekgedtffdtjeeitedufeevgfenucff
    ohhmrghinhepmhgrrhgtrdhinhhfohenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:bjtUYd-4LOQpP45MLbnST2BVtnE0FYg4XfzwhWO5a2RcLIUvBAL9sw>
    <xmx:bjtUYUvV-mDW2yc6kETg9LYcdMj8dZQOocy-vDxVZxNKo4R9PAh3dw>
    <xmx:bjtUYUHPeNKWvzVle9B8SxinufphIMhI62ZulnoV0nRWEP3XBuOeXg>
    <xmx:bjtUYQJ8WWNztT7Hzhc0tKvrz0sDk1jJlivTlRFvOSOedaMY-ffnfg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 06:09:47 -0400 (EDT)
Message-ID: <266004dfa3a023b593b17841ab8fed6311040a0d.camel@themaw.net>
Subject: Re: [PATCH] kernfs: also call kernfs_set_rev() for positive dentry
From:   Ian Kent <raven@themaw.net>
To:     Hou Tao <houtao1@huawei.com>, Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, glider@google.com
Date:   Wed, 29 Sep 2021 18:09:43 +0800
In-Reply-To: <20210928140750.1274441-1-houtao1@huawei.com>
References: <20210928140750.1274441-1-houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-09-28 at 22:07 +0800, Hou Tao wrote:
> A KMSAN warning is reported by Alexander Potapenko:

I haven't looked at this thoroughly yet I admit but ...

I'm very sorry but again I don't quite agree with what's done
in the patch.

> 
> BUG: KMSAN: uninit-value in kernfs_dop_revalidate+0x61f/0x840
> fs/kernfs/dir.c:1053
>  kernfs_dop_revalidate+0x61f/0x840 fs/kernfs/dir.c:1053
>  d_revalidate fs/namei.c:854
>  lookup_dcache fs/namei.c:1522
>  __lookup_hash+0x3a6/0x590 fs/namei.c:1543
>  filename_create+0x312/0x7c0 fs/namei.c:3657
>  do_mkdirat+0x103/0x930 fs/namei.c:3900
>  __do_sys_mkdir fs/namei.c:3931
>  __se_sys_mkdir fs/namei.c:3929
>  __x64_sys_mkdir+0xda/0x120 fs/namei.c:3929
>  do_syscall_x64 arch/x86/entry/common.c:51
> 
> It seems a positive dentry in kernfs becomes a negative dentry directly
> through d_delete() in vfs_rmdir(). dentry->d_time is uninitialized
> when accessing it in kernfs_dop_revalidate(), because it is only
> initialized when created as negative dentry in kernfs_iop_lookup().

It looks more like the final dput() that's sending the dentry to
the LRU list than the call to d_delete().

But I could be mistaken and it's just a detail.

I think the real question is do we want kernfs ->rmdir() to utilize
the VFS negative dentry facility.

Clearly, based in the kernfs ->rmdir() op function definition kernfs
doesn't want file systems that use it to be able to decide that.

Unless there is a case for allowing dentries to be re-used I think
they should be dropped in kernfs_iop_rmdir().

> 
> The problem can be reproduced by the following command:
> 
>   cd /sys/fs/cgroup/pids && mkdir hi && stat hi && rmdir hi && stat hi

And immediately recreating the directory is probably not a common
use case so it doesn't provide a case for kernfs ->rmdir() not
dropping the dentry to prevent the dentry making it to the LRU
negative dentry list.

The more likely case is an unnecessary accumulation of negative
dentries from file system activity with occasional negative dentry
re-use which might be undesirable for long running systems.

> 
> A simple fixes seems to be initializing d->d_time for positive dentry
> in kernfs_iop_lookup() as well. The downside is the negative dentry
> will be revalidated again after it becomes negative in d_delete(),
> because the revison of its parent must have been increased due to
> its removal.

I did that for a long time is the series before deciding to do
it only for negatives ...

The usual case of directory removal is the dentry is dropped by
the ->rmdir() function either directly or via d_invalidate() to
prevent possible incorrect initialization on re-create.

But this is probably unlikely for kernfs attributes of the same
name so I'm not certain dropping the dentry is in fact what really
should be done here.

I admit I did miss this case.

> 
> Alternative solution is implement .d_iput for kernfs, and assign d_time
> for the newly-generated negative dentry in it. But we may need to
> take kernfs_rwsem to protect again the concurrent kernfs_link_sibling()
> on the parent directory, it is a little over-killing. Now the simple
> fix is chosen.

Please don't even consider this, it's misleading because here we
are concerned with the dentry not the inode so I don't think adding
->d_iput() is the right thing to do.

> 
> Link: https://marc.info/?l=linux-fsdevel&m=163249838610499
> Fixes: c7e7c04274b1 ("kernfs: use VFS negative dentry caching")
> Reported-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/kernfs/dir.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 0c7f1558f489..f7618ba5b3b2 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1140,8 +1140,13 @@ static struct dentry *kernfs_iop_lookup(struct
> inode *dir,
>                 if (!inode)
>                         inode = ERR_PTR(-ENOMEM);
>         }
> -       /* Needed only for negative dentry validation */
> -       if (!inode)
> +       /*
> +        * Needed for negative dentry validation.
> +        * The negative dentry can be created in kernfs_iop_lookup()
> +        * or transforms from positive dentry in dentry_unlink_inode()
> +        * called from vfs_rmdir().
> +        */
> +       if (!IS_ERR(inode))
>                 kernfs_set_rev(parent, dentry);
>         up_read(&kernfs_rwsem);
>  

This is not a bad idea to do and is what I did for quite a while too
but maybe it would be better to do this:

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index a957c944cf3a..3fd9d8fa4b92 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1165,6 +1165,8 @@ static int kernfs_iop_rmdir(struct inode *dir, struct dentry *dentry)
                return -ENODEV;
 
        ret = scops->rmdir(kn);
+       if (!ret)
+               d_invalidate(dentry);
 
        kernfs_put_active(kn);
        return ret;


