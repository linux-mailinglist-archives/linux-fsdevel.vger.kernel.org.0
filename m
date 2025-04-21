Return-Path: <linux-fsdevel+bounces-46785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C4CA94D87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 09:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B7A3B0794
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36620E037;
	Mon, 21 Apr 2025 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV2XrGLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617920DD6B
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222185; cv=none; b=YlncNXRlmpkeoMd1rTEnpovAMyt9io6wtglLbCa1yeuhKwv6JZE77ENWKONIU4HnGON6JDo3QjMpwBQIHOhdEWIu8Dhwq/xRmphT1edv3mk1nPta3lT9z4ycMAZgN6R7xLOjQHnJ5/W04O/iwkCilCGCx3QWqzo2qhzlz7y/0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222185; c=relaxed/simple;
	bh=wYqSObRhB5dmNBepFjwC/JS9oPLlV7y/4ktG0PPBbG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRkdc+Zzqzvv7BP1u9f4lypkbm46OBbnZFCZfacUoqbeiGDyGOqQcdIw9gh+hJ3WFGFyfrjlmphUxMR8W1LxtfkiXazLqNR+ipm51qNkrS5pZ+0U1ectS645rGVv6yptKk7b3Q3fDgL3DmFrSgTAb7dWaa2/S4D06RFA5yCCKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV2XrGLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CB0C4CEE4;
	Mon, 21 Apr 2025 07:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745222184;
	bh=wYqSObRhB5dmNBepFjwC/JS9oPLlV7y/4ktG0PPBbG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qV2XrGLuA4TxbeFKKa3vikmUz5ohMt470ezifGa9tt2D2XBwA+ceZmBQsnnZPWpXw
	 DuOeAT/iWPyVfcxt1Lc7kfCDoBYO/dUdq/1WpbCYYtF8TsKQUassoBfNKkoxipZvSM
	 eXMnQL2CBMCCJ+BlSeTj6lsBSCEvnY4o/ZJxAXqg08RGhE/U0QwgS226D3J8hNQpfQ
	 CmwGVytfvDM5ZMuZ6T1HPHmJfB7JVDy6XfwHLvDw9vp78/pJrsO6yFwL/inL1nAVeL
	 ifZTu9DqpfOQ02NbVT9h3BMYfkzJAhkx4ASDi8fw5xTkaQ1zEgZ6F1G/UebUg9uwr8
	 p6nAjjFMnaUsw==
Date: Mon, 21 Apr 2025 09:56:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
References: <20250421033509.GV2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421033509.GV2023217@ZenIV>

On Mon, Apr 21, 2025 at 04:35:09AM +0100, Al Viro wrote:
> Not since 8f2918898eb5 "new helpers: vfs_create_mount(), fc_mount()"
> back in 2018.  Get rid of the dead checks...
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Good idea. Fwiw, I've put this into vfs-6.16.mount with some other minor
stuff. If you're keeping it yourself let me know.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index d9ca80dcc544..fa17762268f5 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -355,12 +355,13 @@ static struct mount *alloc_vfsmnt(const char *name)
>  		if (err)
>  			goto out_free_cache;
>  
> -		if (name) {
> +		if (name)
>  			mnt->mnt_devname = kstrdup_const(name,
>  							 GFP_KERNEL_ACCOUNT);
> -			if (!mnt->mnt_devname)
> -				goto out_free_id;
> -		}
> +		else
> +			mnt->mnt_devname = "none";
> +		if (!mnt->mnt_devname)
> +			goto out_free_id;
>  
>  #ifdef CONFIG_SMP
>  		mnt->mnt_pcp = alloc_percpu(struct mnt_pcp);
> @@ -1268,7 +1269,7 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
>  	if (!fc->root)
>  		return ERR_PTR(-EINVAL);
>  
> -	mnt = alloc_vfsmnt(fc->source ?: "none");
> +	mnt = alloc_vfsmnt(fc->source);
>  	if (!mnt)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -5491,7 +5492,7 @@ static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
>  		seq->buf[seq->count] = '\0';
>  		seq->count = start;
>  		seq_commit(seq, string_unescape_inplace(seq->buf + start, UNESCAPE_OCTAL));
> -	} else if (r->mnt_devname) {
> +	} else {
>  		seq_puts(seq, r->mnt_devname);
>  	}
>  	return 0;
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index e133b507ddf3..5c555db68aa2 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -111,7 +111,7 @@ static int show_vfsmnt(struct seq_file *m, struct vfsmount *mnt)
>  		if (err)
>  			goto out;
>  	} else {
> -		mangle(m, r->mnt_devname ? r->mnt_devname : "none");
> +		mangle(m, r->mnt_devname);
>  	}
>  	seq_putc(m, ' ');
>  	/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
> @@ -177,7 +177,7 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
>  		if (err)
>  			goto out;
>  	} else {
> -		mangle(m, r->mnt_devname ? r->mnt_devname : "none");
> +		mangle(m, r->mnt_devname);
>  	}
>  	seq_puts(m, sb_rdonly(sb) ? " ro" : " rw");
>  	err = show_sb_opts(m, sb);
> @@ -199,17 +199,13 @@ static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
>  	int err;
>  
>  	/* device */
> +	seq_puts(m, "device ");
>  	if (sb->s_op->show_devname) {
> -		seq_puts(m, "device ");
>  		err = sb->s_op->show_devname(m, mnt_path.dentry);
>  		if (err)
>  			goto out;
>  	} else {
> -		if (r->mnt_devname) {
> -			seq_puts(m, "device ");
> -			mangle(m, r->mnt_devname);
> -		} else
> -			seq_puts(m, "no device");
> +		mangle(m, r->mnt_devname);
>  	}
>  
>  	/* mount point */

