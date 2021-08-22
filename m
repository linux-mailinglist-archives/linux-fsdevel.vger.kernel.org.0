Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4943F3F6E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Aug 2021 15:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhHVNOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHVNOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:14:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAD7C061575;
        Sun, 22 Aug 2021 06:13:59 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id v6so1803870qto.3;
        Sun, 22 Aug 2021 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qf4utuU+RpA+uHG06+6D2GHWVuTKcfWTDf0QzBu5Zes=;
        b=gtAGbuiWtMPrrPfi1v8x/SL0Q1TDquvr4m8w6oRihc3IEjW2xPTipX/nsd1+ZBDEev
         VDNTea6dKnwCtksVRRN3Kf+FQufzQnRdqLIMDd/xf92nB55eFqsF8Ahb2Mqhsu7MlPo9
         O8StqCcAy66y+uv9yI7r1H2LDFhZ9gEl39I5ztN24Thj7oye9XOjbNnXQ01HuGGtLkWx
         5MtBrDJdfx8947OgkHgc3yB4PKSvW4Y/CDi0teyrAfz7iL4zKqXpBTy2Hgx/tjymPfBA
         YL4jMnWnAF+1U1j+jMvLnNMYUHdbr/RZwGkJhw4j6WlNOKChjJO6xHncdB68Jtk5bEKp
         kfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qf4utuU+RpA+uHG06+6D2GHWVuTKcfWTDf0QzBu5Zes=;
        b=M4PF/3Lkv9WaM8o6dp5O8nTBgtVydSRJvWrl821fiBSs7kl9HQhFjbrA0l/SIiKMcF
         kHEDtZa2y5MDSXmRgf/Ro09ObGL5MWe3nAXeE3zzHr5B6EAKIYV2RkxJLaUdBp1+gLSa
         V639MIgGcTpD5GOupR/V840O2FANnVKfFZA7U7/tis0nBPJWxz+g+lLWLcbVrkbEGgWj
         ZmlA2MegHAnXJpbm91m90sFzwafZpiP147GCzzY1aVRhHTqTZ4XZS4IgCxC0pNyEh224
         K/KD4f8KJR/CeI7dB2la8aoJB+zqs/Ey7TU70EJPoIQYWcavmpuKp11RbBKngB3xl6G3
         Z8PA==
X-Gm-Message-State: AOAM533rKvGXEWjixRkDzNZ8snxFXZBvhyvH1TkH823PWm9v/MklcQVA
        M30fYpsD0kxj4bRgxQOqSfg=
X-Google-Smtp-Source: ABdhPJxvjM88e175RmZDPwVs8KQrQQSNR0owExOZJvx8pTjGNUMmeQq5f3E6N9iyEvU/8MEgDZWqyg==
X-Received: by 2002:ac8:6bcc:: with SMTP id b12mr2127924qtt.243.1629638038155;
        Sun, 22 Aug 2021 06:13:58 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h4sm6473250qkp.86.2021.08.22.06.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 06:13:57 -0700 (PDT)
Date:   Sun, 22 Aug 2021 06:13:54 -0700
From:   CGEL <cgel.zte@gmail.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com,
        jamorris@linux.microsoft.com, gladkov.alexey@gmail.com,
        yang.yang29@zte.com.cn, tj@kernel.org,
        paul.gortmaker@windriver.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: your mail
Message-ID: <20210822131354.GB39585@www>
References: <20210821085939.3sj66wdkshnadnjm@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821085939.3sj66wdkshnadnjm@kari-VirtualBox>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

O
Sat, Aug 21, 2021 at 11:59:39AM +0300, Kari Argillander wrote:
> Bcc:
> Subject: Re: [PATCH] proc: prevent mount proc on same mountpoint in one pid
>  namespace
> Reply-To:
> In-Reply-To: <20210821083105.30336-1-yang.yang29@zte.com.cn>
> 
> On Sat, Aug 21, 2021 at 01:31:05AM -0700, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > Patch "proc: allow to mount many instances of proc in one pid namespace"
> > aims to mount many instances of proc on different mountpoint, see
> > tools/testing/selftests/proc/proc-multiple-procfs.c.
> > 
> > But there is a side-effects, user can mount many instances of proc on
> > the same mountpoint in one pid namespace, which is not allowed before.
> > This duplicate mount makes no sense but wastes memory and CPU, and user
> > may be confused why kernel allows it.
> > 
> > The logic of this patch is: when try to mount proc on /mnt, check if
> > there is a proc instance mount on /mnt in the same pid namespace. If
> > answer is yes, return -EBUSY.
> > 
> > Since this check can't be done in proc_get_tree(), which call
> > get_tree_nodev() and will create new super_block unconditionally.
> > And other nodev fs may faces the same case, so add a new hook in
> > fs_context_operations.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > ---
> >  fs/namespace.c             |  9 +++++++++
> >  fs/proc/root.c             | 15 +++++++++++++++
> >  include/linux/fs_context.h |  1 +
> >  3 files changed, 25 insertions(+)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index f79d9471cb76..84da649a70c5 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2878,6 +2878,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
> >  static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
> >  			int mnt_flags, const char *name, void *data)
> >  {
> > +	int (*check_mntpoint)(struct fs_context *fc, struct path *path);
> >  	struct file_system_type *type;
> >  	struct fs_context *fc;
> >  	const char *subtype = NULL;
> > @@ -2906,6 +2907,13 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
> >  	if (IS_ERR(fc))
> >  		return PTR_ERR(fc);
> >  
> > +	/* check if there is a same super_block mount on path*/
> > +	check_mntpoint = fc->ops->check_mntpoint;
> > +	if (check_mntpoint)
> > +		err = check_mntpoint(fc, path);
> > +	if (err < 0)
> > +		goto err_fc;
> > +
> >  	if (subtype)
> >  		err = vfs_parse_fs_string(fc, "subtype",
> >  					  subtype, strlen(subtype));
> > @@ -2920,6 +2928,7 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
> >  	if (!err)
> >  		err = do_new_mount_fc(fc, path, mnt_flags);
> >  
> > +err_fc:
> >  	put_fs_context(fc);
> >  	return err;
> >  }
> > diff --git a/fs/proc/root.c b/fs/proc/root.c
> > index c7e3b1350ef8..0971d6b0bec2 100644
> > --- a/fs/proc/root.c
> > +++ b/fs/proc/root.c
> > @@ -237,11 +237,26 @@ static void proc_fs_context_free(struct fs_context *fc)
> >  	kfree(ctx);
> >  }
> >  
> > +static int proc_check_mntpoint(struct fs_context *fc, struct path *path)
> > +{
> > +	struct super_block *mnt_sb = path->mnt->mnt_sb;
> > +	struct proc_fs_info *fs_info;
> > +
> > +	if (strcmp(mnt_sb->s_type->name, "proc") == 0) {
> > +		fs_info = mnt_sb->s_fs_info;
> > +		if (fs_info->pid_ns == task_active_pid_ns(current) &&
> > +		    path->mnt->mnt_root == path->dentry)
> > +			return -EBUSY;
> > +	}
> > +	return 0;
> > +}
> > +
> >  static const struct fs_context_operations proc_fs_context_ops = {
> >  	.free		= proc_fs_context_free,
> >  	.parse_param	= proc_parse_param,
> >  	.get_tree	= proc_get_tree,
> >  	.reconfigure	= proc_reconfigure,
> > +	.check_mntpoint	= proc_check_mntpoint,
> >  };
> >  
> >  static int proc_init_fs_context(struct fs_context *fc)
> > diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> > index 6b54982fc5f3..090a05fb2d7d 100644
> > --- a/include/linux/fs_context.h
> > +++ b/include/linux/fs_context.h
> > @@ -119,6 +119,7 @@ struct fs_context_operations {
> >  	int (*parse_monolithic)(struct fs_context *fc, void *data);
> >  	int (*get_tree)(struct fs_context *fc);
> >  	int (*reconfigure)(struct fs_context *fc);
> > +	int (*check_mntpoint)(struct fs_context *fc, struct path *path);
> 
> Don't you think this should be it's own patch. It is after all internal
> api change. This also needs documentation. It would be confusing if
> someone convert to new mount api and there is one line which just
> address some proc stuff but even commit message does not address does
> every fs needs to add this. 
> 
> Documentation is very good shape right now and we are in face that
> everyone is migrating to use new mount api so everyting should be well
> documented.
> i
Thanks for your reply!

I will take commit message more carefully next time.
Sinece I am not quit sure about this patch, so I didn't write
Documentation for patch v1. AIViro had made it clear, so this 
patch is abondoned.
> >  };
> >  
> >  /*
> > -- 
> > 2.25.1
> > 
