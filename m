Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3A3F39A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Aug 2021 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhHUJAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Aug 2021 05:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUJAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:00:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1076C061575;
        Sat, 21 Aug 2021 01:59:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id n7so21418705ljq.0;
        Sat, 21 Aug 2021 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:mime-version:content-disposition;
        bh=kEULimDkzu2M4h9diM+nwbfqNFbIaITyZl/LMTcXmtk=;
        b=K0aYCO8PMpgon87D7F2CTTaqDiMRs2KGuFq2vDtMIv4Xmp8fYir7jmiAMfqNaj02MG
         cPgbs0WnCxilBORJVvbeZrTsalx3Y4bdxr7sDDNf/7IqrPHkH4Es9lyy2g3GtyzWlkCu
         +MYah9lR8XJ5qQOn///dfWXSOK+nkZMWyyV4OfZPtZoYqrHKbhlsol5iM3nvax+zP0p5
         F0mTS3ViFzObmD1tvoVyeXCKKbxcKrKkuf4zbUSVlsQlcz7RvEtZ1QzQZyMrHtzSFZmK
         swJXdXV5y9P2g9xzyidOXjejpsMjatMqbZL/pojvhJnYCxpeaR+0C/UHf9a3YAjrmmO3
         Bzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:mime-version
         :content-disposition;
        bh=kEULimDkzu2M4h9diM+nwbfqNFbIaITyZl/LMTcXmtk=;
        b=npTEsYXGBS3Kuy+ubjPbGCmfI1Qe/PDCjZQljbgpJP52mzc1mAckbD9WXODGrCTG6/
         mYyftpw9S8FoKrPo08fQ+J5KDXIR82iO/AS7zBHg8ffE6SRZkT/Ymsxcy17q8gS/idtL
         PdAXrOhOfYuYPZxQwJlJ5lLWGqnPLA5CSMymdWQzpM645NCAdTs5nU/ZVvcojNIJ5LY1
         mVSP+kpvA5vfgV4NF7K0yERCxcxuFaHKUH9naY6er7o9Iz0XkLlf5GXYfAfwxBt+Lics
         A9hC2Buk3EGrG70loeWTX2vWETU6USipL/rXnkQT8qZsU+jERjbc5IAvJhIcWk4az5/q
         +bQw==
X-Gm-Message-State: AOAM530w90tFwXnJlP1PDsiGUriDNK2qUtEjcmYTrtiWRFPcCyT9qNhF
        avceLXgLh8i1RNklqydLvMA=
X-Google-Smtp-Source: ABdhPJyqEghdCLO/2Od3zhM7ahPm6vDvyQjeQjIhPezZzQLGIo669guVhL0rGlfbAlSd/PLIPzEG0g==
X-Received: by 2002:a2e:88d0:: with SMTP id a16mr3420767ljk.81.1629536382735;
        Sat, 21 Aug 2021 01:59:42 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id y6sm858662lfg.225.2021.08.21.01.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 01:59:41 -0700 (PDT)
Date:   Sat, 21 Aug 2021 11:59:39 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     cgel.zte@gmail.com
Cc:     viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com,
        jamorris@linux.microsoft.com, gladkov.alexey@gmail.com,
        yang.yang29@zte.com.cn, tj@kernel.org,
        paul.gortmaker@windriver.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Message-ID: <20210821085939.3sj66wdkshnadnjm@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bcc:
Subject: Re: [PATCH] proc: prevent mount proc on same mountpoint in one pid
 namespace
Reply-To:
In-Reply-To: <20210821083105.30336-1-yang.yang29@zte.com.cn>

On Sat, Aug 21, 2021 at 01:31:05AM -0700, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Patch "proc: allow to mount many instances of proc in one pid namespace"
> aims to mount many instances of proc on different mountpoint, see
> tools/testing/selftests/proc/proc-multiple-procfs.c.
> 
> But there is a side-effects, user can mount many instances of proc on
> the same mountpoint in one pid namespace, which is not allowed before.
> This duplicate mount makes no sense but wastes memory and CPU, and user
> may be confused why kernel allows it.
> 
> The logic of this patch is: when try to mount proc on /mnt, check if
> there is a proc instance mount on /mnt in the same pid namespace. If
> answer is yes, return -EBUSY.
> 
> Since this check can't be done in proc_get_tree(), which call
> get_tree_nodev() and will create new super_block unconditionally.
> And other nodev fs may faces the same case, so add a new hook in
> fs_context_operations.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  fs/namespace.c             |  9 +++++++++
>  fs/proc/root.c             | 15 +++++++++++++++
>  include/linux/fs_context.h |  1 +
>  3 files changed, 25 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index f79d9471cb76..84da649a70c5 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2878,6 +2878,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
>  static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
>  			int mnt_flags, const char *name, void *data)
>  {
> +	int (*check_mntpoint)(struct fs_context *fc, struct path *path);
>  	struct file_system_type *type;
>  	struct fs_context *fc;
>  	const char *subtype = NULL;
> @@ -2906,6 +2907,13 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
>  	if (IS_ERR(fc))
>  		return PTR_ERR(fc);
>  
> +	/* check if there is a same super_block mount on path*/
> +	check_mntpoint = fc->ops->check_mntpoint;
> +	if (check_mntpoint)
> +		err = check_mntpoint(fc, path);
> +	if (err < 0)
> +		goto err_fc;
> +
>  	if (subtype)
>  		err = vfs_parse_fs_string(fc, "subtype",
>  					  subtype, strlen(subtype));
> @@ -2920,6 +2928,7 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
>  	if (!err)
>  		err = do_new_mount_fc(fc, path, mnt_flags);
>  
> +err_fc:
>  	put_fs_context(fc);
>  	return err;
>  }
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index c7e3b1350ef8..0971d6b0bec2 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -237,11 +237,26 @@ static void proc_fs_context_free(struct fs_context *fc)
>  	kfree(ctx);
>  }
>  
> +static int proc_check_mntpoint(struct fs_context *fc, struct path *path)
> +{
> +	struct super_block *mnt_sb = path->mnt->mnt_sb;
> +	struct proc_fs_info *fs_info;
> +
> +	if (strcmp(mnt_sb->s_type->name, "proc") == 0) {
> +		fs_info = mnt_sb->s_fs_info;
> +		if (fs_info->pid_ns == task_active_pid_ns(current) &&
> +		    path->mnt->mnt_root == path->dentry)
> +			return -EBUSY;
> +	}
> +	return 0;
> +}
> +
>  static const struct fs_context_operations proc_fs_context_ops = {
>  	.free		= proc_fs_context_free,
>  	.parse_param	= proc_parse_param,
>  	.get_tree	= proc_get_tree,
>  	.reconfigure	= proc_reconfigure,
> +	.check_mntpoint	= proc_check_mntpoint,
>  };
>  
>  static int proc_init_fs_context(struct fs_context *fc)
> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index 6b54982fc5f3..090a05fb2d7d 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -119,6 +119,7 @@ struct fs_context_operations {
>  	int (*parse_monolithic)(struct fs_context *fc, void *data);
>  	int (*get_tree)(struct fs_context *fc);
>  	int (*reconfigure)(struct fs_context *fc);
> +	int (*check_mntpoint)(struct fs_context *fc, struct path *path);

Don't you think this should be it's own patch. It is after all internal
api change. This also needs documentation. It would be confusing if
someone convert to new mount api and there is one line which just
address some proc stuff but even commit message does not address does
every fs needs to add this. 

Documentation is very good shape right now and we are in face that
everyone is migrating to use new mount api so everyting should be well
documented.

>  };
>  
>  /*
> -- 
> 2.25.1
> 
