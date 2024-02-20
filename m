Return-Path: <linux-fsdevel+bounces-12180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2789985C6E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 22:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9084A1F2172A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 21:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9DA151CF0;
	Tue, 20 Feb 2024 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="mwq8F39W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358C6133987
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463148; cv=none; b=ZTST7VocDykFN8DdxEwZogywOvMeHjw6pWx8LwEgaPL0puLjFqujlXcF0QW2eiA+dzdDv0OtoYir/wFJyQnjCMm9PmqJ1HFoKeYyIqTjHJaCeoV8FM+us3UYauF9z2lFRtPn39jnwBNRP7kvrrrhH/3r5QYGUHUzABGVXpPhka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463148; c=relaxed/simple;
	bh=Sa9XnNzOUnbgNkYAHS4e7F8S26nCdLi0piZgpOKNeDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ir430bKFbPYqjGA+rpFFOrwO+QFVQcUYK1b1MuCUa7hDpZTowBdIcBMPss8aVmuYxxSjOWdoCCIQ2VEmqE3/fZOUITTn4eCVTUSFziGZUWJrSMdqtfMWxEwNKVgruO05u0P6YTq6MR81CYrRcuwuF4pTKAfKgmk7Xj8tUEREQsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=mwq8F39W; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 2BA5E33505B;
	Tue, 20 Feb 2024 15:05:39 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 2BA5E33505B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1708463139;
	bh=dtYaL3N7QMcl7lULZfyZA9xhkGblVJ7tPRoP0kgwW5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mwq8F39WQzgG+65RjWMDqIhfso75OjbyNQRp+wKD4nMCnp6e67qN6uVDSc+kK1xBO
	 dDUfqA2v+hZjoQ7/LI+sj+K+jSdg1ZJ2hU80hbaZnpxF6G3OemPrYw8cv+QE6KBuPv
	 bcTVj/FFxjjvnMyCO+nAdJzsjf8EyaWZz2/WlsmJFa/3gDmrx5Txfh4Ij1S5fQjz6Q
	 mXsiScSE6AE4kQq9HWqA7P60mjjI8zYJVXyKN3nGUK9Cz3KJ9HwqBHrlcTrY5s2r5K
	 4ZtHqc0SXDOQnkjvUwttQcW6Al5QZc7zPmCKtDcu29cpCFo7yPLDH7DztvURgUDY0E
	 FH9q5HdORkzhw==
Message-ID: <c3528c22-8385-455f-8b72-a6302b60c360@sandeen.net>
Date: Tue, 20 Feb 2024 15:05:38 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efs: convert efs to use the new mount api
Content-Language: en-US
To: Bill O'Donnell <bodonnel@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, David Howells <dhowells@redhat.com>
References: <20240220164729.179594-1-bodonnel@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240220164729.179594-1-bodonnel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/24 8:45 AM, Bill O'Donnell wrote:
> Convert the efs filesystem to use the new mount API.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> ---
> 
> Changelog:
> v2: Remove efs_param_spec and efs_parse_param, since no mount options.

A few more items below

> ---
>  fs/efs/super.c | 91 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 61 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/efs/super.c b/fs/efs/super.c
> index f17fdac76b2e..d86c84e9e497 100644
> --- a/fs/efs/super.c
> +++ b/fs/efs/super.c
> @@ -14,19 +14,13 @@
>  #include <linux/buffer_head.h>
>  #include <linux/vfs.h>
>  #include <linux/blkdev.h>
> -
> +#include <linux/fs_context.h>
>  #include "efs.h"
>  #include <linux/efs_vh.h>
>  #include <linux/efs_fs_sb.h>
>  
>  static int efs_statfs(struct dentry *dentry, struct kstatfs *buf);
> -static int efs_fill_super(struct super_block *s, void *d, int silent);
> -
> -static struct dentry *efs_mount(struct file_system_type *fs_type,
> -	int flags, const char *dev_name, void *data)
> -{
> -	return mount_bdev(fs_type, flags, dev_name, data, efs_fill_super);
> -}
> +static int efs_init_fs_context(struct fs_context *fc);
>  
>  static void efs_kill_sb(struct super_block *s)
>  {
> @@ -35,15 +29,6 @@ static void efs_kill_sb(struct super_block *s)
>  	kfree(sbi);
>  }
>  
> -static struct file_system_type efs_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name		= "efs",
> -	.mount		= efs_mount,
> -	.kill_sb	= efs_kill_sb,
> -	.fs_flags	= FS_REQUIRES_DEV,
> -};
> -MODULE_ALIAS_FS("efs");
> -
>  static struct pt_types sgi_pt_types[] = {
>  	{0x00,		"SGI vh"},
>  	{0x01,		"SGI trkrepl"},
> @@ -63,6 +48,17 @@ static struct pt_types sgi_pt_types[] = {
>  	{0,		NULL}
>  };
>  
> +/*
> + * File system definition and registration.
> + */
> +static struct file_system_type efs_fs_type = {
> +	.owner			= THIS_MODULE,
> +	.name			= "efs",
> +	.kill_sb		= efs_kill_sb,
> +	.fs_flags		= FS_REQUIRES_DEV,
> +	.init_fs_context	= efs_init_fs_context,
> +};
> +MODULE_ALIAS_FS("efs");
>  
>  static struct kmem_cache * efs_inode_cachep;
>  
> @@ -108,18 +104,10 @@ static void destroy_inodecache(void)
>  	kmem_cache_destroy(efs_inode_cachep);
>  }
>  
> -static int efs_remount(struct super_block *sb, int *flags, char *data)
> -{
> -	sync_filesystem(sb);
> -	*flags |= SB_RDONLY;
> -	return 0;
> -}
> -
>  static const struct super_operations efs_superblock_operations = {
>  	.alloc_inode	= efs_alloc_inode,
>  	.free_inode	= efs_free_inode,
>  	.statfs		= efs_statfs,
> -	.remount_fs	= efs_remount,
>  };
>  
>  static const struct export_operations efs_export_ops = {
> @@ -249,26 +237,26 @@ static int efs_validate_super(struct efs_sb_info *sb, struct efs_super *super) {
>  	return 0;    
>  }
>  
> -static int efs_fill_super(struct super_block *s, void *d, int silent)
> +static int efs_fill_super(struct super_block *s, struct fs_context *fc)
>  {
>  	struct efs_sb_info *sb;
>  	struct buffer_head *bh;
>  	struct inode *root;
>  
> - 	sb = kzalloc(sizeof(struct efs_sb_info), GFP_KERNEL);
> +	sb = kzalloc(sizeof(struct efs_sb_info), GFP_KERNEL);

Ok, I guess this and elsewhere is fixing up whitespace oddities,
not adding them. :)

>  	if (!sb)
>  		return -ENOMEM;
>  	s->s_fs_info = sb;
>  	s->s_time_min = 0;
>  	s->s_time_max = U32_MAX;
> - 
> +
>  	s->s_magic		= EFS_SUPER_MAGIC;
>  	if (!sb_set_blocksize(s, EFS_BLOCKSIZE)) {
>  		pr_err("device does not support %d byte blocks\n",
>  			EFS_BLOCKSIZE);
>  		return -EINVAL;

I think this can (should?) be converted to:

		return invalf(fc,
			"device does not support %d byte blocks",
			EFS_BLOCKSIZE);

and similarly for other error printing failures along the fill_super path,
with appropriate variants of invalf()/errorf()/warnf()/etc

(dhowells - am I right about this?)

>  	}
> -  
> +
>  	/* read the vh (volume header) block */
>  	bh = sb_bread(s, 0);
>  
> @@ -294,7 +282,7 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
>  		pr_err("cannot read superblock\n");
>  		return -EIO;
>  	}
> -		
> +
>  	if (efs_validate_super(sb, (struct efs_super *) bh->b_data)) {
>  #ifdef DEBUG
>  		pr_warn("invalid superblock at block %u\n",
> @@ -328,6 +316,49 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
>  	return 0;
>  }
>  
> +static void efs_free_fc(struct fs_context *fc)
> +{
> +	kfree(fc->fs_private);
> +}

unneeded; see below

> +static int efs_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_bdev(fc, efs_fill_super);
> +}
> +
> +static int efs_reconfigure(struct fs_context *fc)
> +{
> +	sync_filesystem(fc->root->d_sb);

I think you need:

	fc->sb_flags |= SB_RDONLY;

here to preserve the original behavior in efs_remount()

> +
> +	return 0;
> +}
> +
> +struct efs_context {
> +	unsigned long s_mount_opts;
> +};

This looks unused, and probably also copied from zonefs, which used it
to store mount options - something efs doesn't have.

> +
> +static const struct fs_context_operations efs_context_opts = {
> +	.get_tree	= efs_get_tree,
> +	.reconfigure	= efs_reconfigure,
> +	.free		= efs_free_fc,
> +};
> +
> +/*
> + * Set up the filesystem mount context.
> + */
> +static int efs_init_fs_context(struct fs_context *fc)
> +{
> +	struct efs_context *ctx;
> +
> +	ctx = kzalloc(sizeof(struct efs_context), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	fc->fs_private = ctx;

so there's no reason to allocate and assign it here.
which means efs_free_fc() doesn't need to exist either.

> +	fc->ops = &efs_context_opts;
> +
> +	return 0;
> +}
> +
>  static int efs_statfs(struct dentry *dentry, struct kstatfs *buf) {
>  	struct super_block *sb = dentry->d_sb;
>  	struct efs_sb_info *sbi = SUPER_INFO(sb);


