Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2865280E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 11:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfFYJ1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 05:27:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43415 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfFYJ1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:27:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so16992649wru.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Tqn0XsSi/4YD7ZlmU6wfa+zp1PqcP2Zu3pbhFPe06Y=;
        b=ZaCvQomp0Io9vi4ZQxZAI892vL67TiTgJ1AmlbxDYvNjhjAzndgJ2+aZLubYypJv9D
         K83aDzBwjlNZ3oeNggC1kAHrANbVPk2hifGf05mIr8f2IYXk7T75GMbCdW6VM5vWWGn+
         yX3deTetWPzW+cwfuXamZj9woRBXunzN5EDUwz/mnLYLofVyuV8PWH13wzm6Moi3LWd6
         +sL43lCKuIU1Zyf1jA+GdU1mYvIz89SgeXOdBaQCmKINbJzw5s4VTrMY2x5LAeEnWf5A
         6wz3Tu0ZxqfxrnyKP/ntDm1MgAudwYPyY/slB1Kpc1o1vw/1IFciGLEfPp0VTgOSUz1m
         jfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Tqn0XsSi/4YD7ZlmU6wfa+zp1PqcP2Zu3pbhFPe06Y=;
        b=XilKCtPhYgRzt6QKho51/2WAjvqsMrgDNGVn3ASVwyYkEvDVI3usi043+l9UvCRTVV
         ZxCYQvrpa6s1CuJFBEIn2tt44KMh0k1KpyntRcmg8cCsAH1YUvgrhBG3Rla1mkSaz6A7
         mtgx1yRfwwUUv6scA1eRNorKMeg5lp4fD/5yFi0jFGQPp1HgEE56fUZHw5eAK+HXDFOL
         N9Z2XjJqxHBcA7gvQ7pGWuD0Cq25zUj0+1jPYb72ZesffabNS3CdJ3Kn4BAOCEjFm9zw
         1oxo0JFIb9qpzLDBf0I8LJ9XqxI+8jDxRpB8LiArnxu2WiGkgTz2F2d6ivx8D9Nfwb5I
         DgKg==
X-Gm-Message-State: APjAAAXRY12AsZVOLAuxKoJfaijmKhjGDAxqn1RYYKduXdIyhAaLsWVV
        lPafxA6JMx1eRN/4QxK/7eumZg==
X-Google-Smtp-Source: APXvYqyVlnUPQN5LnTAef8GBwr27xOaXhu/vlrP3sS/cKVrRf93EqtxK+8tUlR277cKY1O/giCg7TQ==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr37429818wrw.232.1561454849774;
        Tue, 25 Jun 2019 02:27:29 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id n10sm12248929wrw.83.2019.06.25.02.27.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 02:27:29 -0700 (PDT)
Date:   Tue, 25 Jun 2019 11:27:28 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/25] vfs: Allow fsinfo() to query what's in an
 fs_context [ver #14]
Message-ID: <20190625092728.z3jn3gbyopzcg2it@brauner.io>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
 <156138535407.25627.15015993364565647650.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156138535407.25627.15015993364565647650.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:09:14PM +0100, David Howells wrote:
> Allow fsinfo() to be used to query the filesystem attached to an fs_context
> once a superblock has been created or if it comes from fspick().
> 
> The caller must specify AT_FSINFO_FROM_FSOPEN in the parameters and must

Yeah, I like that better than how it was before.

> supply the fd from fsopen() as dfd and must set filename to NULL.
> 
> This is done with something like:
> 
> 	fd = fsopen("ext4", 0);
> 	...
> 	struct fsinfo_params params = {
> 		.at_flags = AT_FSINFO_FROM_FSOPEN;
> 		...
> 	};
> 	fsinfo(fd, NULL, &params, ...);
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/fsinfo.c                |   46 +++++++++++++++++++++++++++++++++++++++++++-
>  fs/statfs.c                |    2 +-
>  include/uapi/linux/fcntl.h |    2 ++
>  3 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> index 49b46f96dda3..c24701f994d1 100644
> --- a/fs/fsinfo.c
> +++ b/fs/fsinfo.c
> @@ -8,6 +8,7 @@
>  #include <linux/security.h>
>  #include <linux/uaccess.h>
>  #include <linux/fsinfo.h>
> +#include <linux/fs_context.h>
>  #include <uapi/linux/mount.h>
>  #include "internal.h"
>  
> @@ -340,6 +341,42 @@ static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams *params)
>  	return ret;
>  }
>  
> +/*
> + * Allow access to an fs_context object as created by fsopen() or fspick().
> + */
> +static int vfs_fsinfo_fscontext(int fd, struct fsinfo_kparams *params)
> +{
> +	struct fs_context *fc;
> +	struct fd f = fdget(fd);
> +	int ret;
> +
> +	if (!f.file)
> +		return -EBADF;
> +
> +	ret = -EINVAL;
> +	if (f.file->f_op == &fscontext_fops)

Don't you mean != ?

if (f.file->f_op != &fscontext_fops)

> +		goto out_f;
> +	ret = -EOPNOTSUPP;
> +	if (fc->ops == &legacy_fs_context_ops)
> +		goto out_f;
> +
> +	ret = mutex_lock_interruptible(&fc->uapi_mutex);
> +	if (ret == 0) {
> +		ret = -EIO;

Why EIO when there's no root dentry?

> +		if (fc->root) {
> +			struct path path = { .dentry = fc->root };
> +
> +			ret = vfs_fsinfo(&path, params);
> +		}
> +
> +		mutex_unlock(&fc->uapi_mutex);
> +	}
> +
> +out_f:
> +	fdput(f);
> +	return ret;
> +}
> +
>  /*
>   * Return buffer information by requestable attribute.
>   *
> @@ -445,6 +482,9 @@ SYSCALL_DEFINE5(fsinfo,
>  		params.request = user_params.request;
>  		params.Nth = user_params.Nth;
>  		params.Mth = user_params.Mth;
> +

[1]:

> +		if ((params.at_flags & AT_FSINFO_FROM_FSOPEN) && filename)
> +			return -EINVAL;
>  	} else {
>  		params.request = FSINFO_ATTR_STATFS;
>  	}
> @@ -453,6 +493,8 @@ SYSCALL_DEFINE5(fsinfo,
>  		user_buf_size = 0;
>  		user_buffer = NULL;
>  	}
> +	if ((params.at_flags & AT_FSINFO_FROM_FSOPEN) && filename)
> +		return -EINVAL;

Sorry, why is this checked twice (see [1])? Or is the diff just
misleading here?

>  
>  	/* Allocate an appropriately-sized buffer.  We will truncate the
>  	 * contents when we write the contents back to userspace.
> @@ -500,7 +542,9 @@ SYSCALL_DEFINE5(fsinfo,
>  	if (!params.buffer)
>  		goto error_scratch;
>  
> -	if (filename)
> +	if (params.at_flags & AT_FSINFO_FROM_FSOPEN)
> +		ret = vfs_fsinfo_fscontext(dfd, &params);
> +	else if (filename)
>  		ret = vfs_fsinfo_path(dfd, filename, &params);
>  	else
>  		ret = vfs_fsinfo_fd(dfd, &params);
> diff --git a/fs/statfs.c b/fs/statfs.c
> index eea7af6f2f22..b9b63d9f4f24 100644
> --- a/fs/statfs.c
> +++ b/fs/statfs.c
> @@ -86,7 +86,7 @@ int vfs_statfs(const struct path *path, struct kstatfs *buf)
>  	int error;
>  
>  	error = statfs_by_dentry(path->dentry, buf);
> -	if (!error)
> +	if (!error && path->mnt)
>  		buf->f_flags = calculate_f_flags(path->mnt);
>  	return error;
>  }
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 1d338357df8a..6a2402a8fa30 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -91,6 +91,8 @@
>  #define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
>  #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
>  
> +#define AT_FSINFO_FROM_FSOPEN	0x2000	/* Examine the fs_context attached to dfd by fsopen() */
> +
>  #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
>  
>  
> 
