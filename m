Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544D461F64C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 15:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiKGOjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 09:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiKGOj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:39:27 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A49DAC
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Nov 2022 06:39:24 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 130so10797366pfu.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Nov 2022 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6TvDdbCfOFs2I+iL4RcjGNCKdWvMmyCATmQ3FshHxU=;
        b=IV2FEGbOiNN/tLwXwoAJ/4SlSc1Bq2GjBsZCTmq/ohib1LBF2o1WlsF/eJQwVQwcat
         y/bCpjfFCcPCAbVgqkjwTmzYl4UHMi2WdpZDXc8DXv1GfERk3Pk+Ioes3v8AzMUjyxHS
         LmUSp+8pE67A0caKrna9qN5cKoKMZdiESJo6tONcL0dPVCY5kR8bctECwOB7u2i6MKAN
         if4218rbtQb7KbBPvp5x0KXkUmNBPxnEYNwyqRmwZ5c8VF+zZeNqDDq11dK7Uxbj3LsM
         OpB0q/Gv1WiwYXNhYTQ6hAqsB8dgqTH10WprmCkHn1ymvswzviI8UMFjTaHdOtJF/p/z
         eX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r6TvDdbCfOFs2I+iL4RcjGNCKdWvMmyCATmQ3FshHxU=;
        b=h2X5hMAcagecTp9yx6A+H3E9smEIGzAaoVAgQFilFyb+shV14Tozwzg6Vhi4DoQ2ej
         SR5xeCtpv4S1frxJ8WCfhC6icMgZN1BVs2Y9tsBRyWmxESX/MMJzEwyLIxBBXSBc2bPt
         PZ8cp5zZCcKyRFIwpsUgmodFZ/1z8y4L82J//mQjCmZjOVESgS2QMrYq4nmobFnOZlbU
         XnTteYsbpqhX7HPuYpROEObK5FzH5GivQa1npoANBGysbIkIcX1zYccPIR7JFo1lcJm4
         h8LMHQofg1EYMnqjuTxHqan/7AUFXF9/ArsOEw93O3c+hai57MgWAPtj8TWoafHZr79z
         6RGA==
X-Gm-Message-State: ACrzQf0Y1bR0N0OcAylJ3nm0LDAkdpfxqq7o0jYKwXPMRLTi34jHSuMn
        lCHWuVLgimeM3NT+D2K/GzU+VD5SmOwl0g==
X-Google-Smtp-Source: AMsMyM4fy/LnBsjjgKIDyFkSutpNfRUyLWr1fegTtE7n/FN46oDH1vQJA32TkgLoYC5dSooetmmW0g==
X-Received: by 2002:a65:6ccd:0:b0:439:2033:6ee with SMTP id g13-20020a656ccd000000b00439203306eemr44065416pgw.271.1667831964177;
        Mon, 07 Nov 2022 06:39:24 -0800 (PST)
Received: from [10.4.186.187] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id w184-20020a6262c1000000b0056b9ec7e2desm4542236pfb.125.2022.11.07.06.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 06:39:23 -0800 (PST)
Message-ID: <83c2acbe-c664-0a7c-c41c-d27dd985ebc2@bytedance.com>
Date:   Mon, 7 Nov 2022 22:39:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [External] [PATCH] erofs: fix use-after-free of fsid and
 domain_id string
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-fsdevel@vger.kernel.org
References: <20221021023153.1330-1-jefflexu@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20221021023153.1330-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/10/21 10:31, Jingbo Xu 写道:
> When erofs instance is remounted with fsid or domain_id mount option
> specified, the original fsid and domain_id string pointer in sbi->opt
> is directly overridden with the fsid and domain_id string in the new
> fs_context, without freeing the original fsid and domain_id string.
> What's worse, when the new fsid and domain_id string is transferred to
> sbi, they are not reset to NULL in fs_context, and thus they are freed
> when remount finishes, while sbi is still referring to these strings.
> 
> Reconfiguration for fsid and domain_id seems unusual. Thus clarify this
> restriction explicitly and dump a warning when users are attempting to
> do this.
> 
> Besides, to fix the use-after-free issue, move fsid and domain_id from
> erofs_mount_opts to outside.
> 
> Fixes: c6be2bd0a5dd ("erofs: register fscache volume")
> Fixes: 8b7adf1dff3d ("erofs: introduce fscache-based domain")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>   fs/erofs/fscache.c  | 14 +++++++-------
>   fs/erofs/internal.h |  6 ++++--
>   fs/erofs/super.c    | 39 ++++++++++++++++++++++-----------------
>   fs/erofs/sysfs.c    |  8 ++++----
>   4 files changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index fe05bc51f9f2..03de503a1b85 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -403,13 +403,13 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
>   static int erofs_fscache_register_volume(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	char *domain_id = sbi->opt.domain_id;
> +	char *domain_id = sbi->domain_id;
>   	struct fscache_volume *volume;
>   	char *name;
>   	int ret = 0;
>   
>   	name = kasprintf(GFP_KERNEL, "erofs,%s",
> -			 domain_id ? domain_id : sbi->opt.fsid);
> +			 domain_id ? domain_id : sbi->fsid);
>   	if (!name)
>   		return -ENOMEM;
>   
> @@ -435,7 +435,7 @@ static int erofs_fscache_init_domain(struct super_block *sb)
>   	if (!domain)
>   		return -ENOMEM;
>   
> -	domain->domain_id = kstrdup(sbi->opt.domain_id, GFP_KERNEL);
> +	domain->domain_id = kstrdup(sbi->domain_id, GFP_KERNEL);
>   	if (!domain->domain_id) {
>   		kfree(domain);
>   		return -ENOMEM;
> @@ -472,7 +472,7 @@ static int erofs_fscache_register_domain(struct super_block *sb)
>   
>   	mutex_lock(&erofs_domain_list_lock);
>   	list_for_each_entry(domain, &erofs_domain_list, list) {
> -		if (!strcmp(domain->domain_id, sbi->opt.domain_id)) {
> +		if (!strcmp(domain->domain_id, sbi->domain_id)) {
>   			sbi->domain = domain;
>   			sbi->volume = domain->volume;
>   			refcount_inc(&domain->ref);
> @@ -609,7 +609,7 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>   						    char *name, bool need_inode)
>   {
> -	if (EROFS_SB(sb)->opt.domain_id)
> +	if (EROFS_SB(sb)->domain_id)
>   		return erofs_domain_register_cookie(sb, name, need_inode);
>   	return erofs_fscache_acquire_cookie(sb, name, need_inode);
>   }
> @@ -641,7 +641,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	struct erofs_fscache *fscache;
>   
> -	if (sbi->opt.domain_id)
> +	if (sbi->domain_id)
>   		ret = erofs_fscache_register_domain(sb);
>   	else
>   		ret = erofs_fscache_register_volume(sb);
> @@ -649,7 +649,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   		return ret;
>   
>   	/* acquired domain/volume will be relinquished in kill_sb() on error */
> -	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
> +	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, true);
>   	if (IS_ERR(fscache))
>   		return PTR_ERR(fscache);
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 1701df48c446..05dc68627722 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -75,8 +75,6 @@ struct erofs_mount_opts {
>   	unsigned int max_sync_decompress_pages;
>   #endif
>   	unsigned int mount_opt;
> -	char *fsid;
> -	char *domain_id;
>   };
>   
>   struct erofs_dev_context {
> @@ -89,6 +87,8 @@ struct erofs_dev_context {
>   struct erofs_fs_context {
>   	struct erofs_mount_opts opt;
>   	struct erofs_dev_context *devs;
> +	char *fsid;
> +	char *domain_id;
>   };
>   
>   /* all filesystem-wide lz4 configurations */
> @@ -170,6 +170,8 @@ struct erofs_sb_info {
>   	struct fscache_volume *volume;
>   	struct erofs_fscache *s_fscache;
>   	struct erofs_domain *domain;
> +	char *fsid;
> +	char *domain_id;
>   };
>   
>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 2cf96ce1c32e..1c7dcca702b3 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -579,9 +579,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		break;
>   	case Opt_fsid:
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
> -		kfree(ctx->opt.fsid);
> -		ctx->opt.fsid = kstrdup(param->string, GFP_KERNEL);
> -		if (!ctx->opt.fsid)
> +		kfree(ctx->fsid);
> +		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
> +		if (!ctx->fsid)
>   			return -ENOMEM;
>   #else
>   		errorfc(fc, "fsid option not supported");
> @@ -589,9 +589,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		break;
>   	case Opt_domain_id:
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
> -		kfree(ctx->opt.domain_id);
> -		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
> -		if (!ctx->opt.domain_id)
> +		kfree(ctx->domain_id);
> +		ctx->domain_id = kstrdup(param->string, GFP_KERNEL);
> +		if (!ctx->domain_id)
>   			return -ENOMEM;
>   #else
>   		errorfc(fc, "domain_id option not supported");
> @@ -728,10 +728,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   
>   	sb->s_fs_info = sbi;
>   	sbi->opt = ctx->opt;
> -	ctx->opt.fsid = NULL;
> -	ctx->opt.domain_id = NULL;
>   	sbi->devs = ctx->devs;
>   	ctx->devs = NULL;
> +	sbi->fsid = ctx->fsid;
> +	ctx->fsid = NULL;
> +	sbi->domain_id = ctx->domain_id;
> +	ctx->domain_id = NULL;
>   
>   	if (erofs_is_fscache_mode(sb)) {
>   		sb->s_blocksize = EROFS_BLKSIZ;
> @@ -820,7 +822,7 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>   {
>   	struct erofs_fs_context *ctx = fc->fs_private;
>   
> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->opt.fsid)
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
>   		return get_tree_nodev(fc, erofs_fc_fill_super);
>   
>   	return get_tree_bdev(fc, erofs_fc_fill_super);
> @@ -834,6 +836,9 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
>   
>   	DBG_BUGON(!sb_rdonly(sb));
>   
> +	if (ctx->fsid || ctx->domain_id)
> +		erofs_info(sb, "ignoring reconfiguration for fsid|domain_id.");
> +
>   	if (test_opt(&ctx->opt, POSIX_ACL))
>   		fc->sb_flags |= SB_POSIXACL;
>   	else
> @@ -873,8 +878,8 @@ static void erofs_fc_free(struct fs_context *fc)
>   	struct erofs_fs_context *ctx = fc->fs_private;
>   
>   	erofs_free_dev_context(ctx->devs);
> -	kfree(ctx->opt.fsid);
> -	kfree(ctx->opt.domain_id);
> +	kfree(ctx->fsid);
> +	kfree(ctx->domain_id);
>   	kfree(ctx);
>   }
>   
> @@ -944,8 +949,8 @@ static void erofs_kill_sb(struct super_block *sb)
>   	erofs_free_dev_context(sbi->devs);
>   	fs_put_dax(sbi->dax_dev, NULL);
>   	erofs_fscache_unregister_fs(sb);
> -	kfree(sbi->opt.fsid);
> -	kfree(sbi->opt.domain_id);
> +	kfree(sbi->fsid);
> +	kfree(sbi->domain_id);
>   	kfree(sbi);
>   	sb->s_fs_info = NULL;
>   }
> @@ -1098,10 +1103,10 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   	if (test_opt(opt, DAX_NEVER))
>   		seq_puts(seq, ",dax=never");
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
> -	if (opt->fsid)
> -		seq_printf(seq, ",fsid=%s", opt->fsid);
> -	if (opt->domain_id)
> -		seq_printf(seq, ",domain_id=%s", opt->domain_id);
> +	if (sbi->fsid)
> +		seq_printf(seq, ",fsid=%s", sbi->fsid);
> +	if (sbi->domain_id)
> +		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
>   #endif
>   	return 0;
>   }
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 783bb7b21b51..fd476961f742 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -210,14 +210,14 @@ int erofs_register_sysfs(struct super_block *sb)
>   	int err;
>   
>   	if (erofs_is_fscache_mode(sb)) {
> -		if (sbi->opt.domain_id) {
> -			str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id,
> -					sbi->opt.fsid);
> +		if (sbi->domain_id) {
> +			str = kasprintf(GFP_KERNEL, "%s,%s", sbi->domain_id,
> +					sbi->fsid);
>   			if (!str)
>   				return -ENOMEM;
>   			name = str;
>   		} else {
> -			name = sbi->opt.fsid;
> +			name = sbi->fsid;
>   		}
>   	} else {
>   		name = sb->s_id;
