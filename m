Return-Path: <linux-fsdevel+bounces-53974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA91AF99F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 19:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7496B17347D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93182D8394;
	Fri,  4 Jul 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pKspoYDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0492D837F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650856; cv=none; b=s7m16rutqV5Qat8bWt/soHJzmbo7grbSszpC7G5Xf9Ib+M1co3j/Odag3wGf49fJcyECDKBdM9YFO0m5Z4TcBG4nIV6nPCz2BgJ++ChSWRNwHlf3xwNZ9sG7Iu0J8aesQNSqWc7DvWOD4A/AnHyBuERYEn7Yj/eg4+QDDkgai38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650856; c=relaxed/simple;
	bh=j1y5fK2pSIFjeIzluaoTZB7LiubY9SK90IFdNX+JcVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQORxX/vBADa3af/AS4cRkUtDk9M+dcITYmeFUcl50RkMsTrI97imz+VnHhd+oEvPcGPyueGES+uq6DqL4LlAUzbywl+kg7BZGbf7m0ofT9jImhUFSrcyZf3EumoC0SQ5l5KI8A/PxbqFIl/XdWp6Uf+K9j/0JFMZj281EGF5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pKspoYDT; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2459c10e-d74c-4118-9b6d-c37d05ecec02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751650841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIRcNmmy2VbVp7gJQIkaTFfPIXvag7FLLr7FrIV0lQo=;
	b=pKspoYDT8P7/dYSLFT3Wcf6V3S1xlnly+2wS8ALTKH+MecAV9raqgDtRFHb0+N2lny17mW
	Urcm4546PBB3ywrgOhyT2lNXU6S1ODfdsqWVsxtfy8Ky7lG6s44qnb6dsS029GqH9Obmh5
	BPBmV3Y+sZ0PNlQN6O1PuI38XaEGhZU=
Date: Fri, 4 Jul 2025 10:40:18 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Content-Language: en-GB
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 kpsingh@kernel.org, mattbobrowski@google.com, m@maowtm.org, neil@brown.name
References: <20250617061116.3681325-1-song@kernel.org>
 <20250617061116.3681325-2-song@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250617061116.3681325-2-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/16/25 11:11 PM, Song Liu wrote:
> This helper walks an input path to its parent. Logic are added to handle
> walking across mount tree.
>
> This will be used by landlock, and BPF LSM.
>
> Suggested-by: Neil Brown <neil@brown.name>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>   fs/namei.c            | 95 +++++++++++++++++++++++++++++++++++--------
>   include/linux/namei.h |  2 +
>   2 files changed, 79 insertions(+), 18 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 4bb889fc980b..d0557c0b5cc8 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2048,36 +2048,95 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
>   	return nd->path.dentry;
>   }
>   
> -static struct dentry *follow_dotdot(struct nameidata *nd)
> +/**
> + * __path_walk_parent - Find the parent of the given struct path
> + * @path  - The struct path to start from
> + * @root  - A struct path which serves as a boundary not to be crosses.
> + *        - If @root is zero'ed, walk all the way to global root.
> + * @flags - Some LOOKUP_ flags.
> + *
> + * Find and return the dentry for the parent of the given path
> + * (mount/dentry). If the given path is the root of a mounted tree, it
> + * is first updated to the mount point on which that tree is mounted.
> + *
> + * If %LOOKUP_NO_XDEV is given, then *after* the path is updated to a new
> + * mount, the error EXDEV is returned.
> + *
> + * If no parent can be found, either because the tree is not mounted or
> + * because the @path matches the @root, then @path->dentry is returned
> + * unless @flags contains %LOOKUP_BENEATH, in which case -EXDEV is returned.
> + *
> + * Returns: either an ERR_PTR() or the chosen parent which will have had
> + * the refcount incremented.
> + */
> +static struct dentry *__path_walk_parent(struct path *path, const struct path *root, int flags)
>   {
> -	struct dentry *parent;
> -
> -	if (path_equal(&nd->path, &nd->root))
> +	if (path_equal(path, root))
>   		goto in_root;
> -	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
> -		struct path path;
> +	if (unlikely(path->dentry == path->mnt->mnt_root)) {
> +		struct path new_path;
>   
> -		if (!choose_mountpoint(real_mount(nd->path.mnt),
> -				       &nd->root, &path))
> +		if (!choose_mountpoint(real_mount(path->mnt),
> +				       root, &new_path))
>   			goto in_root;
> -		path_put(&nd->path);
> -		nd->path = path;
> -		nd->inode = path.dentry->d_inode;
> -		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
> +		path_put(path);
> +		*path = new_path;
> +		if (unlikely(flags & LOOKUP_NO_XDEV))
>   			return ERR_PTR(-EXDEV);
>   	}
>   	/* rare case of legitimate dget_parent()... */
> -	parent = dget_parent(nd->path.dentry);
> +	return dget_parent(path->dentry);

I have some confusion with this patch when crossing mount boundary.

In d_path.c, we have

static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
                           const struct path *root, struct prepend_buffer *p)
{
         while (dentry != root->dentry || &mnt->mnt != root->mnt) {
                 const struct dentry *parent = READ_ONCE(dentry->d_parent);

                 if (dentry == mnt->mnt.mnt_root) {
                         struct mount *m = READ_ONCE(mnt->mnt_parent);
                         struct mnt_namespace *mnt_ns;

                         if (likely(mnt != m)) {
                                 dentry = READ_ONCE(mnt->mnt_mountpoint);
                                 mnt = m;
                                 continue;
                         }
                         /* Global root */
                         mnt_ns = READ_ONCE(mnt->mnt_ns);
                         /* open-coded is_mounted() to use local mnt_ns */
                         if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
                                 return 1;       // absolute root
                         else
                                 return 2;       // detached or not attached yet
                 }

                 if (unlikely(dentry == parent))
                         /* Escaped? */
                         return 3;

                 prefetch(parent);
                 if (!prepend_name(p, &dentry->d_name))
                         break;
                 dentry = parent;
         }
         return 0;
}

At the mount boundary and not at root mount, the code has
	dentry = READ_ONCE(mnt->mnt_mountpoint);
	mnt = m; /* 'mnt' will be parent mount */
	continue;

After that, we have
	const struct dentry *parent = READ_ONCE(dentry->d_parent);
	if (dentry == mnt->mnt.mnt_root) {
		/* assume this is false */
	}
	...
	prefetch(parent);
         if (!prepend_name(p, &dentry->d_name))
                 break;
         dentry = parent;

So the prepend_name(p, &dentry->d_name) is actually from mnt->mnt_mountpoint.

In your above code, maybe we should return path->dentry in the below if statement?

         if (unlikely(path->dentry == path->mnt->mnt_root)) {
                 struct path new_path;

                 if (!choose_mountpoint(real_mount(path->mnt),
                                        root, &new_path))
                         goto in_root;
                 path_put(path);
                 *path = new_path;
                 if (unlikely(flags & LOOKUP_NO_XDEV))
                         return ERR_PTR(-EXDEV);
+		return path->dentry;
         }
         /* rare case of legitimate dget_parent()... */
         return dget_parent(path->dentry);

Also, could you add some selftests cross mount points? This will
have more coverages with __path_walk_parent().

> +
> +in_root:
> +	if (unlikely(flags & LOOKUP_BENEATH))
> +		return ERR_PTR(-EXDEV);
> +	return dget(path->dentry);
> +}
> +
> +/**
> + * path_walk_parent - Walk to the parent of path
> + * @path: input and output path.
> + * @root: root of the path walk, do not go beyond this root. If @root is
> + *        zero'ed, walk all the way to real root.
> + *
> + * Given a path, find the parent path. Replace @path with the parent path.
> + * If we were already at the real root or a disconnected root, @path is
> + * not changed.
> + *
> + * Returns:
> + *  0  - if @path is updated to its parent.
> + *  <0 - if @path is already the root (real root or @root).
> + */
> +int path_walk_parent(struct path *path, const struct path *root)
> +{
> +	struct dentry *parent;
> +
> +	parent = __path_walk_parent(path, root, LOOKUP_BENEATH);
> +
> +	if (IS_ERR(parent))
> +		return PTR_ERR(parent);
> +
> +	if (parent == path->dentry) {
> +		dput(parent);
> +		return -ENOENT;
> +	}
> +	dput(path->dentry);
> +	path->dentry = parent;
> +	return 0;
> +}
> +

[...]


