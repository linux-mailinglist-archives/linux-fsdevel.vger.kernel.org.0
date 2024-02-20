Return-Path: <linux-fsdevel+bounces-12111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D885B5A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553B31C20E59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5E5D75D;
	Tue, 20 Feb 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk5BHixs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04EB5D74F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418558; cv=none; b=XWG/DNNxr5NfJJIlzlY5zgu4vIIQ9wZMmfIrCxQcc0knA3LEdJ0w8VOIJAcfdmjlU4D1zZEfEi3RqzK7yU2olTec79pafg/rhYKFQ1rbWRKzF8IXQjD9Z+7+hEnrxNUHZPbcCpT/5z7ZNrnd8U2UwlMhUZhuZ9KCcu5lr5z46IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418558; c=relaxed/simple;
	bh=0Qw+14mNjKKdxGkTIrMy1/ptvttnT9nFDWONCQcZyhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3KRAGiXbjLiUgJsi04a7avAVmmpAvOMrHNOEPzY50iI66b3by73VPPrqQu1chUr++JNAU4/wb7ETWwFe4cx6P4TEFX+ffsuX2W3eUyDCKYHkEPMl5BeHj4bLdH1T2Mg0Q8cG+/gStjFQZHr7Tk2iUwgoVVg4uqBE8dXxs0q0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk5BHixs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2DCC43390;
	Tue, 20 Feb 2024 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708418558;
	bh=0Qw+14mNjKKdxGkTIrMy1/ptvttnT9nFDWONCQcZyhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pk5BHixs1iZ9PxIFvV0MMqq+6OGyuj836FD8DQcjxffkXirxHydbmnQ81o1vHJi4E
	 vnj9Aittj2CtO6qne1cx9OGlO1c4jk5K6qMOCRzdwXBJz1Nv8wByezPmHtUZR9007I
	 4F6j7X2KB1q5EYFsLEeQ6oM+nLlDOLuFQimbbkYjHkQZOTuqPbY93axfsnIollzdTd
	 8Ki3sdfOJeW0aNk4n8ijH327pgPALaNrUnDphAiMUdEtTNU/YOQ61VnKvz57wkDn+Z
	 /UbcG8/fHfmkn1An7hk0dcpIlX8DNmgDfgTSjEMvOAOOoog6r/nXALJlzKiX90+fg1
	 FQq9aVjnciNFQ==
Date: Tue, 20 Feb 2024 09:42:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bill O'Donnell <bodonnel@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] efs: convert efs to use the new mount api
Message-ID: <20240220-vagabunden-orchester-9067bc0c98a4@brauner>
References: <20240220003318.166143-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220003318.166143-1-bodonnel@redhat.com>

On Mon, Feb 19, 2024 at 06:33:18PM -0600, Bill O'Donnell wrote:
> Convert the efs filesystem to use the new mount API.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> ---

Thanks for doing this. One question below.

>  fs/efs/super.c | 114 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 84 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/efs/super.c b/fs/efs/super.c
> index f17fdac76b2e..c837ac89b384 100644
> --- a/fs/efs/super.c
> +++ b/fs/efs/super.c
> @@ -14,19 +14,14 @@
>  #include <linux/buffer_head.h>
>  #include <linux/vfs.h>
>  #include <linux/blkdev.h>
> -
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
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
> @@ -35,15 +30,6 @@ static void efs_kill_sb(struct super_block *s)
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
> @@ -63,6 +49,27 @@ static struct pt_types sgi_pt_types[] = {
>  	{0,		NULL}
>  };
>  
> +enum {
> +	Opt_explicit_open,
> +};
> +
> +static const struct fs_parameter_spec efs_param_spec[] = {
> +	fsparam_flag    ("explicit-open",       Opt_explicit_open),
> +	{}
> +};

That looks like it is copy-pasted from zonefs?

> +
> +/*
> + * File system definition and registration.
> + */
> +static struct file_system_type efs_fs_type = {
> +	.owner			= THIS_MODULE,
> +	.name			= "efs",
> +	.kill_sb		= efs_kill_sb,
> +	.fs_flags		= FS_REQUIRES_DEV,
> +	.init_fs_context	= efs_init_fs_context,
> +	.parameters		= efs_param_spec,
> +};
> +MODULE_ALIAS_FS("efs");
>  
>  static struct kmem_cache * efs_inode_cachep;
>  
> @@ -108,18 +115,10 @@ static void destroy_inodecache(void)
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
> @@ -249,26 +248,26 @@ static int efs_validate_super(struct efs_sb_info *sb, struct efs_super *super) {
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
>  	}
> -  
> +
>  	/* read the vh (volume header) block */
>  	bh = sb_bread(s, 0);
>  
> @@ -294,7 +293,7 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
>  		pr_err("cannot read superblock\n");
>  		return -EIO;
>  	}
> -		
> +
>  	if (efs_validate_super(sb, (struct efs_super *) bh->b_data)) {
>  #ifdef DEBUG
>  		pr_warn("invalid superblock at block %u\n",
> @@ -328,6 +327,61 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
>  	return 0;
>  }
>  
> +static void efs_free_fc(struct fs_context *fc)
> +{
> +	kfree(fc->fs_private);
> +}
> +
> +static int efs_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_bdev(fc, efs_fill_super);
> +}
> +
> +static int efs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	int token;
> +	struct fs_parse_result result;
> +
> +	token = fs_parse(fc, efs_param_spec, param, &result);
> +	if (token < 0)
> +		return token;

Any mount option here is completely ignored, no? Why even have any mount
options then? It's not required to implement ->parse_param.

> +	return 0;
> +}
> +
> +static int efs_reconfigure(struct fs_context *fc)
> +{
> +	sync_filesystem(fc->root->d_sb);
> +
> +	return 0;
> +}
> +
> +struct efs_context {
> +	unsigned long s_mount_opts;
> +};
> +
> +static const struct fs_context_operations efs_context_opts = {
> +	.parse_param	= efs_parse_param,
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
> +	fc->ops = &efs_context_opts;
> +
> +	return 0;
> +}
> +
>  static int efs_statfs(struct dentry *dentry, struct kstatfs *buf) {
>  	struct super_block *sb = dentry->d_sb;
>  	struct efs_sb_info *sbi = SUPER_INFO(sb);
> -- 
> 2.43.2
> 

