Return-Path: <linux-fsdevel+bounces-48086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD52AA94F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5647A51DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97273258CF6;
	Mon,  5 May 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKmOHCi5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B918B47D;
	Mon,  5 May 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453425; cv=none; b=l2ayQkv8VuB7fMIA0vTfGZyJp2dwHiw2y17WbmV6RKw11EuhWHTCt0p3WrzIVVB8iAXBUbMnEL/nALmWQDxqpwBsU+86zEdVLOh4jXQDg5pTxYTPnO+TdE5UrjcF+83iMv5WYiqGiWXePfS+BWmccEAOYZInCxXT3A+tOFaTxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453425; c=relaxed/simple;
	bh=zWfY1vmuQi68izjgxT0dgn4PZjEV3azHt33lIIPHMLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwpNaNHZ/1P2QKTPkAiqMpgj8nZ/p+TYOfOzmXUi3w0YSlIq5yuoLll0ei4WtTX2ytN4YI5xeJ6LHXxf9A+dD3B/NBSBI2gSRrMANsYLvL9UJtEvE3S5M9XDNmHMoprnWkx4FYahtoX7g7RxMRDzZ68tjdJ+EZYen3lnG0wJ3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKmOHCi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EDBC4CEE4;
	Mon,  5 May 2025 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746453424;
	bh=zWfY1vmuQi68izjgxT0dgn4PZjEV3azHt33lIIPHMLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKmOHCi5cOQZs6L5xhgZlIvHyq++ccvU+BL7ByQ5DEGhO78SnBHdD2xaU6FEGFlTe
	 Dqi5wFXMrmTM0DE0NhzahfiLiJO7AJlz+6XfpDvLpPc0djnqEPHbaGxcwdzJODPcio
	 8Nj9NQ+6NSuUyMwDryFvlr52tFFI0+VWZw2qGfLSvCvSrMHIxl1IKHsvneRJspiSjz
	 f7shFYSEBXw+YeXNuTlK57epEiG1lD7H82L1mEl6F9Op4pyaj87sJlShPqQQD/xzrJ
	 jTzeIhLrIlsuu6qZh4zue9CZYWeMwl+OM9iPSXK16wAgavRU8B9ZBuMMDBFd5lJGRt
	 /lmLNuWGXKMtA==
Date: Mon, 5 May 2025 15:57:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH][RFC][CFT] kill vfs_submount(), already
Message-ID: <20250505-geteilt-qualifizieren-0c94320e7f7e@brauner>
References: <20250503212925.GZ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250503212925.GZ2023217@ZenIV>

On Sat, May 03, 2025 at 10:29:25PM +0100, Al Viro wrote:
> The last remaining user of vfs_submount() (tracefs) is easy to convert
> to fs_context_for_submount(); do that and bury that thing, along with
> SB_SUBMOUNT
> 
> If nobody objects, I'm going to throw that into the mount-related pile;
> alternatively, that could be split into kernel/trace.c part (in invariant
> branch, to be pulled by tracefs folks and into the mount pile before
> the rest of the patch).  Preferences?
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 07f636036b86..293e6f925eff 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1297,21 +1297,6 @@ struct vfsmount *vfs_kern_mount(struct file_system_type *type,
>  }
>  EXPORT_SYMBOL_GPL(vfs_kern_mount);
>  
> -struct vfsmount *
> -vfs_submount(const struct dentry *mountpoint, struct file_system_type *type,
> -	     const char *name, void *data)
> -{
> -	/* Until it is worked out how to pass the user namespace
> -	 * through from the parent mount to the submount don't support
> -	 * unprivileged mounts with submounts.
> -	 */
> -	if (mountpoint->d_sb->s_user_ns != &init_user_ns)
> -		return ERR_PTR(-EPERM);
> -
> -	return vfs_kern_mount(type, SB_SUBMOUNT, name, data);
> -}
> -EXPORT_SYMBOL_GPL(vfs_submount);
> -
>  static struct mount *clone_mnt(struct mount *old, struct dentry *root,
>  					int flag)
>  {
> diff --git a/fs/super.c b/fs/super.c
> index 97a17f9d9023..1886e4c930e0 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -823,13 +823,6 @@ struct super_block *sget(struct file_system_type *type,
>  	struct super_block *old;
>  	int err;
>  
> -	/* We don't yet pass the user namespace of the parent
> -	 * mount through to here so always use &init_user_ns
> -	 * until that changes.
> -	 */
> -	if (flags & SB_SUBMOUNT)
> -		user_ns = &init_user_ns;

Oh thank god this disgusting hack is finally gone.

> -
>  retry:
>  	spin_lock(&sb_lock);
>  	if (test) {
> @@ -849,7 +842,7 @@ struct super_block *sget(struct file_system_type *type,
>  	}
>  	if (!s) {
>  		spin_unlock(&sb_lock);
> -		s = alloc_super(type, (flags & ~SB_SUBMOUNT), user_ns);
> +		s = alloc_super(type, flags, user_ns);
>  		if (!s)
>  			return ERR_PTR(-ENOMEM);
>  		goto retry;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..515e702d98ae 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1240,7 +1240,6 @@ extern int send_sigurg(struct file *file);
>  /* These sb flags are internal to the kernel */
>  #define SB_DEAD         BIT(21)
>  #define SB_DYING        BIT(24)
> -#define SB_SUBMOUNT     BIT(26)
>  #define SB_FORCE        BIT(27)
>  #define SB_NOSEC        BIT(28)
>  #define SB_BORN         BIT(29)
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index fa488721019f..7b6248ba4428 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -51,6 +51,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/sort.h>
>  #include <linux/io.h> /* vmap_page_range() */
> +#include <linux/fs_context.h>
>  
>  #include <asm/setup.h> /* COMMAND_LINE_SIZE */
>  
> @@ -10072,6 +10073,8 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
>  {
>  	struct vfsmount *mnt;
>  	struct file_system_type *type;
> +	struct fs_context *fc;
> +	int ret;
>  
>  	/*
>  	 * To maintain backward compatibility for tools that mount
> @@ -10081,10 +10084,20 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
>  	type = get_fs_type("tracefs");
>  	if (!type)
>  		return NULL;
> -	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
> +
> +	fc = fs_context_for_submount(type, mntpt);
> +	if (IS_ERR(fc))
> +		return ERR_CAST(fc);
> +
> +	ret = vfs_parse_fs_string(fc, "source",
> +				  "tracefs", strlen("tracefs"));
> +	if (!ret)
> +		mnt = fc_mount(fc);
> +	else
> +		mnt = ERR_PTR(ret);
> +
> +	put_fs_context(fc);
>  	put_filesystem(type);
> -	if (IS_ERR(mnt))
> -		return NULL;
>  	return mnt;
>  }
>  

