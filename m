Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B81F9E29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 00:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKLXZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 18:25:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46694 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLXZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:25:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id 193so180224pfc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 15:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v/05ewFGIu4TLNi9D2OL0wDmLlrmscOb/YagM09gAds=;
        b=WVfBl5Z8fLpT/F7hpsoQIz/hJisIbSVPjS10XwLIRzWXm3MQ1kPy0fTIHhjTFBbjoS
         icV23ZNFHmpydn/hnhXxmB3q4f4ZInOJ772AccCmjb8sc8u4v1LS8cPpS1UZ63887C2/
         Jj4N5qkGo/1svgbFeMSpc6RsMo9iFpoLBHM+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v/05ewFGIu4TLNi9D2OL0wDmLlrmscOb/YagM09gAds=;
        b=d2wLBAxlXPx6DeKT/rMrOolCxtITFLlhd9NbGGEMBOqP2yh0mw1rGhX3tcYS/pOe0F
         n8E/c6kdIA1N6UEV+BpxK8ApLlFfMoCG2pFcIEdx/Ua1eB2Vd9X2uHtpAVnBlemEpmJE
         2tXP4BTYbu9GR941K+ldew998y2wsIcCldire9VJeHXJdzmRpuCc8emEjflP3VOCIa59
         +sOsHhaGUoZXiZvC9ghIQdosXYd8U2kX3FZIfKlaXgQEkzF7oys9pgliWIPx/W5Dxd/S
         kc8SCKxmGC+pMu2PiYVrThzmJGrficC/lGD0gUY9UdShTRtnbNoiLxFAFxX8BLCT0VVx
         Lvww==
X-Gm-Message-State: APjAAAVVn4xWsrPdrZWPdE4/jp+yo4makYZ1Bmk9kPVSO9dLfHtGxGA1
        G/bDy4UTf9QR7Hi9ZCeMxUNQ1g==
X-Google-Smtp-Source: APXvYqyBx5mL5/sNTTkpUmdCOW/egLPUqOpRV5xLG78w/QrLUZolYDx4HfZ4l10HpUCpqdk4kHuVrQ==
X-Received: by 2002:a17:90a:86c3:: with SMTP id y3mr524359pjv.102.1573601125368;
        Tue, 12 Nov 2019 15:25:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x2sm70930pge.76.2019.11.12.15.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:25:24 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:25:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] proc: Allow restricting permissions in /proc/sys
Message-ID: <201911121523.9C097E7D2C@keescook>
References: <ed51f7dd-50a2-fbf5-7ea8-4bab6d48279e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed51f7dd-50a2-fbf5-7ea8-4bab6d48279e@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ah! I see the v2 here now. :) Can you please include that in your
Subject next time, as "[PATCH v2] proc: Allow restricting permissions
in /proc/sys"? Also, can you adjust your MUA to not send a duplicate
attachment? The patch inline is fine.

Please CC akpm as well, since I think this should likely go through the
-mm tree.

Eric, do you have any other thoughts on this?

Thanks!

-Kees

On Mon, Nov 04, 2019 at 02:07:29PM +0200, Topi Miettinen wrote:
> Several items in /proc/sys need not be accessible to unprivileged
> tasks. Let the system administrator change the permissions, but only
> to more restrictive modes than what the sysctl tables allow.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
> v2: actually keep track of changed permissions instead of relying on inode
> cache
> ---
>  fs/proc/proc_sysctl.c  | 42 ++++++++++++++++++++++++++++++++++++++----
>  include/linux/sysctl.h |  1 +
>  2 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index d80989b6c344..1f75382c49fd 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int
> mask)
>         if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
>                 return -EACCES;
> 
> +       error = generic_permission(inode, mask);
> +       if (error)
> +               return error;
> +
>         head = grab_header(inode);
>         if (IS_ERR(head))
>                 return PTR_ERR(head);
> @@ -835,17 +839,46 @@ static int proc_sys_permission(struct inode *inode,
> int mask)
>  static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
>  {
>         struct inode *inode = d_inode(dentry);
> +       struct ctl_table_header *head = grab_header(inode);
> +       struct ctl_table *table = PROC_I(inode)->sysctl_entry;
>         int error;
> 
> -       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
> +       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
>                 return -EPERM;
> 
> +       if (attr->ia_valid & ATTR_MODE) {
> +               umode_t max_mode = 0777; /* Only these bits may change */
> +
> +               if (IS_ERR(head))
> +                       return PTR_ERR(head);
> +
> +               if (!table) /* global root - r-xr-xr-x */
> +                       max_mode &= ~0222;
> +               else /*
> +                     * Don't allow permissions to become less
> +                     * restrictive than the sysctl table entry
> +                     */
> +                       max_mode &= table->mode;
> +
> +               /* Execute bits only allowed for directories */
> +               if (!S_ISDIR(inode->i_mode))
> +                       max_mode &= ~0111;
> +
> +               if (attr->ia_mode & ~S_IFMT & ~max_mode)
> +                       return -EPERM;
> +       }
> +
>         error = setattr_prepare(dentry, attr);
>         if (error)
>                 return error;
> 
>         setattr_copy(inode, attr);
>         mark_inode_dirty(inode);
> +
> +       if (table)
> +               table->current_mode = inode->i_mode;
> +       sysctl_head_finish(head);
> +
>         return 0;
>  }
> 
> @@ -861,7 +894,7 @@ static int proc_sys_getattr(const struct path *path,
> struct kstat *stat,
> 
>         generic_fillattr(inode, stat);
>         if (table)
> -               stat->mode = (stat->mode & S_IFMT) | table->mode;
> +               stat->mode = (stat->mode & S_IFMT) | table->current_mode;
> 
>         sysctl_head_finish(head);
>         return 0;
> @@ -981,7 +1014,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set
> *set,
>         memcpy(new_name, name, namelen);
>         new_name[namelen] = '\0';
>         table[0].procname = new_name;
> -       table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
> +       table[0].current_mode = table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
>         init_header(&new->header, set->dir.header.root, set, node, table);
> 
>         return new;
> @@ -1155,6 +1188,7 @@ static int sysctl_check_table(const char *path, struct
> ctl_table *table)
>                 if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
>                         err |= sysctl_err(path, table, "bogus .mode 0%o",
>                                 table->mode);
> +               table->current_mode = table->mode;
>         }
>         return err;
>  }
> @@ -1192,7 +1226,7 @@ static struct ctl_table_header *new_links(struct
> ctl_dir *dir, struct ctl_table
>                 int len = strlen(entry->procname) + 1;
>                 memcpy(link_name, entry->procname, len);
>                 link->procname = link_name;
> -               link->mode = S_IFLNK|S_IRWXUGO;
> +               link->current_mode = link->mode = S_IFLNK|S_IRWXUGO;
>                 link->data = link_root;
>                 link_name += len;
>         }
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 6df477329b76..7c519c35bf9c 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -126,6 +126,7 @@ struct ctl_table
>         void *data;
>         int maxlen;
>         umode_t mode;
> +       umode_t current_mode;
>         struct ctl_table *child;        /* Deprecated */
>         proc_handler *proc_handler;     /* Callback for text formatting */
>         struct ctl_table_poll *poll;
> -- 
> 2.24.0.rc1
> 

> From 3cde64e0aa2734c335355ee6d0d9f12c1f1e8a87 Mon Sep 17 00:00:00 2001
> From: Topi Miettinen <toiwoton@gmail.com>
> Date: Sun, 3 Nov 2019 16:36:43 +0200
> Subject: [PATCH] proc: Allow restricting permissions in /proc/sys
> 
> Several items in /proc/sys need not be accessible to unprivileged
> tasks. Let the system administrator change the permissions, but only
> to more restrictive modes than what the sysctl tables allow.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  fs/proc/proc_sysctl.c  | 42 ++++++++++++++++++++++++++++++++++++++----
>  include/linux/sysctl.h |  1 +
>  2 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index d80989b6c344..1f75382c49fd 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int mask)
>  	if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
>  		return -EACCES;
>  
> +	error = generic_permission(inode, mask);
> +	if (error)
> +		return error;
> +
>  	head = grab_header(inode);
>  	if (IS_ERR(head))
>  		return PTR_ERR(head);
> @@ -835,17 +839,46 @@ static int proc_sys_permission(struct inode *inode, int mask)
>  static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
>  {
>  	struct inode *inode = d_inode(dentry);
> +	struct ctl_table_header *head = grab_header(inode);
> +	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
>  	int error;
>  
> -	if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
> +	if (attr->ia_valid & (ATTR_UID | ATTR_GID))
>  		return -EPERM;
>  
> +	if (attr->ia_valid & ATTR_MODE) {
> +		umode_t max_mode = 0777; /* Only these bits may change */
> +
> +		if (IS_ERR(head))
> +			return PTR_ERR(head);
> +
> +		if (!table) /* global root - r-xr-xr-x */
> +			max_mode &= ~0222;
> +		else /*
> +		      * Don't allow permissions to become less
> +		      * restrictive than the sysctl table entry
> +		      */
> +			max_mode &= table->mode;
> +
> +		/* Execute bits only allowed for directories */
> +		if (!S_ISDIR(inode->i_mode))
> +			max_mode &= ~0111;
> +
> +		if (attr->ia_mode & ~S_IFMT & ~max_mode)
> +			return -EPERM;
> +	}
> +
>  	error = setattr_prepare(dentry, attr);
>  	if (error)
>  		return error;
>  
>  	setattr_copy(inode, attr);
>  	mark_inode_dirty(inode);
> +
> +	if (table)
> +		table->current_mode = inode->i_mode;
> +	sysctl_head_finish(head);
> +
>  	return 0;
>  }
>  
> @@ -861,7 +894,7 @@ static int proc_sys_getattr(const struct path *path, struct kstat *stat,
>  
>  	generic_fillattr(inode, stat);
>  	if (table)
> -		stat->mode = (stat->mode & S_IFMT) | table->mode;
> +		stat->mode = (stat->mode & S_IFMT) | table->current_mode;
>  
>  	sysctl_head_finish(head);
>  	return 0;
> @@ -981,7 +1014,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
>  	memcpy(new_name, name, namelen);
>  	new_name[namelen] = '\0';
>  	table[0].procname = new_name;
> -	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
> +	table[0].current_mode = table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
>  	init_header(&new->header, set->dir.header.root, set, node, table);
>  
>  	return new;
> @@ -1155,6 +1188,7 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
>  		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
>  			err |= sysctl_err(path, table, "bogus .mode 0%o",
>  				table->mode);
> +		table->current_mode = table->mode;
>  	}
>  	return err;
>  }
> @@ -1192,7 +1226,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
>  		int len = strlen(entry->procname) + 1;
>  		memcpy(link_name, entry->procname, len);
>  		link->procname = link_name;
> -		link->mode = S_IFLNK|S_IRWXUGO;
> +		link->current_mode = link->mode = S_IFLNK|S_IRWXUGO;
>  		link->data = link_root;
>  		link_name += len;
>  	}
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 6df477329b76..7c519c35bf9c 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -126,6 +126,7 @@ struct ctl_table
>  	void *data;
>  	int maxlen;
>  	umode_t mode;
> +	umode_t current_mode;
>  	struct ctl_table *child;	/* Deprecated */
>  	proc_handler *proc_handler;	/* Callback for text formatting */
>  	struct ctl_table_poll *poll;
> -- 
> 2.24.0.rc1
> 


-- 
Kees Cook
