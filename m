Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C41D4E48C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 11:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfFUJsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 05:48:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33928 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfFUJsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:48:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so5950999wrl.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2019 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3sR1fsmOSmMKPt8ApFzplMSFtr7yaH3nHZVGcmffx0Q=;
        b=GV35dJjszA2zyHawIt2qliimXzvnUf0QFh4LXG6Qrac1iPxZRxa0EV3PU1oiQ3rqgI
         w2dWQImPU9+JzAZD4UHzer/YglnG9xfKpla/T1B1o3XfW6P++B4wKJzaBkKBpyDIpaxp
         fOzqNdhAXv1JUkvFNBoXaEIcNVqoz9UGPppTawtHbf+ElY2DsjcTpUutsbyyv5HjJiDs
         sa023duB/cjPXzrkXUROEYjvu0yhO6SRf6I3fDpLNculp9vqjPgQ/yWWGFW4LU9gYOjK
         X0c6PHgiC1AOvAcu8hn5SrY2wHe3+MnG3/DQ1W6owW76RuaKyWXi8d0RJHNHYpnylfJN
         cJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3sR1fsmOSmMKPt8ApFzplMSFtr7yaH3nHZVGcmffx0Q=;
        b=ceAnvmZy04CRXiowOYg4SQTcqf2jcg/0iyN7395Rvl3Gpnxnd+5I2XVvYEqGNSo/bX
         3BN+ddXG9xEcKzUrsxo1DSTurHgqADd0bsT7YK/4wNG4QUrXvZ0KCX5lzOO5fg8ZBxtg
         LFLUML4644/TPB9bBFFH4drFFMb5VS93aQAM3m2u3Uos8u3Y2Hvpdne/8ZN68drkaKge
         Z27zz/P2TXEnebvLN8uUeDEOUMbi5Der4PobpgQf10FuT0/Nl/HiWhM/XRAeJ0JtCQhn
         Mal9QtvI/cGzu+x2nU+7iLEHNi+8daolLfe0EanSF3pAUooKWwLlWYp3dADIuCWKGsoh
         MpcQ==
X-Gm-Message-State: APjAAAUi7rFpnyrk5yMzmbCdcxBAwUuOPnRIB0DGMhmkkHnVpeWwl5TN
        XaAxQscepJjJYHjQP6HjaebN5Q==
X-Google-Smtp-Source: APXvYqwCnu1hdf21Y7luHVjdpSkHECqDwwuknTo9xsscjgheBeySu0sil9T4YyQsIlO/8EnrX+BBiw==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr60848301wrv.186.1561110480029;
        Fri, 21 Jun 2019 02:48:00 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id 66sm1941602wma.11.2019.06.21.02.47.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:47:59 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:47:58 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 02/25] vfs: Allow fsinfo() to query what's in an
 fs_context [ver #13]
Message-ID: <20190621094757.zijugn6cfulmchnf@brauner.io>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
 <155905627927.1662.13276277442207649583.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <155905627927.1662.13276277442207649583.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 04:11:19PM +0100, David Howells wrote:
> Allow fsinfo() to be used to query the filesystem attached to an fs_context
> once a superblock has been created or if it comes from fspick().
> 
> This is done with something like:
> 
> 	fd = fsopen("ext4", 0);
> 	...
> 	fsconfig(fd, fsconfig_cmd_create, ...);
> 	fsinfo(fd, NULL, ...);
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/fsinfo.c |   30 +++++++++++++++++++++++++++++-
>  fs/statfs.c |    2 +-
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> index f9a63410e9a2..14db881dd02d 100644
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
> @@ -315,13 +316,40 @@ static int vfs_fsinfo_path(int dfd, const char __user *filename,
>  	return ret;
>  }
>  
> +static int vfs_fsinfo_fscontext(struct fs_context *fc,
> +				struct fsinfo_kparams *params)
> +{
> +	int ret;
> +
> +	if (fc->ops == &legacy_fs_context_ops)
> +		return -EOPNOTSUPP;
> +
> +	ret = mutex_lock_interruptible(&fc->uapi_mutex);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = -EIO;
> +	if (fc->root) {
> +		struct path path = { .dentry = fc->root };
> +
> +		ret = vfs_fsinfo(&path, params);
> +	}
> +
> +	mutex_unlock(&fc->uapi_mutex);
> +	return ret;
> +}
> +
>  static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams *params)
>  {
>  	struct fd f = fdget_raw(fd);

You're using fdget_raw() which means you want to allow O_PATH fds but
below you're checking whether the f_ops correspond to
fscontext_fops. If it's an O_PATH f_ops will be set to empty_fops so
you'll always end up in the vfs_fsinfo branch. Is that your intention?

That means the new mount api doesn't support fsinfo() without using a
non-O_PATH fd, right? Why the fallback then?

Christian

>  	int ret = -EBADF;
>  
>  	if (f.file) {
> -		ret = vfs_fsinfo(&f.file->f_path, params);
> +		if (f.file->f_op == &fscontext_fops)
> +			ret = vfs_fsinfo_fscontext(f.file->private_data,
> +						   params);
> +		else
> +			ret = vfs_fsinfo(&f.file->f_path, params);
>  		fdput(f);
>  	}
>  	return ret;
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
> 
