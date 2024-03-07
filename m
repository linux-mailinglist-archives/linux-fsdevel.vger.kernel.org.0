Return-Path: <linux-fsdevel+bounces-13913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A0187560F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 19:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31FA5B22349
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58C9132494;
	Thu,  7 Mar 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="kLi4m8HY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229D2C180
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836013; cv=none; b=EQHRiRrvIIOeBRgzaaalbniAZ/Nf0dgfhps5v5DFM9/rAOr1Erb51ul+jj0PexuzV9UIbr/l7UndljLgehrBvURD7Jmf4+vqmdCPuouHbHCFIFEkUQcIc4NHuW0n6ugceYuHv9910TEX+/0lxfAZDkYh5+brPsof5vupSC/4Kp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836013; c=relaxed/simple;
	bh=Rt99SPCAJ50PWE7YRClj1S9X95p0Y1E32PA8JUDG6ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipBXpFG0bESH851x9j7TNnAT9309V9+gTUzst7V6BZwBFN4viBpu3K9t6ZNkCOGMRIFw6foc9NI3QV20+OApCzjqi3JYJrKPOLlGkwBeOCBLCt+uP9xg15nYVTB7HIaHt/gb7q+U9JHMaqwd5d7Pn4W57iF7J7IA0g2ZP1Wsgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=kLi4m8HY; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 0D627147573;
	Thu,  7 Mar 2024 12:26:44 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 0D627147573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1709836005;
	bh=kp50K189Y2JsEEMPfNStm5wZDfBjA/FlTovxS5uRuj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kLi4m8HYn438a5KaGgjYiMwE9yOYQOSHtrFSZ1jIEHgSn+pBadDUzwBB1tEiO3rRr
	 uHAOM1bjTWXMdI3LPqtoBKGWxLxMC1IclUXBkXQJmi1q3NqplTxCNBdTUTqCTQdIz+
	 iWoMuqd9EWjQDrcYlAE4kGrZTzjy0ZxBrIhNIGfri3HItaK3Wol6yobWahTViEkZ+d
	 IUntGSCuHxmotXdwLVI2n5iK3pyfIQQ6SeE2pAz/51A87wDPzVOwl47WTdNIAGhNqu
	 Evtz9dGMCISxwlfoZ12hr+T0p3ZM5jnr5hcn0tLUn4itpOaDsH2Banv0kPo8xd/mHq
	 kInZxO/Rqr94g==
Message-ID: <78173c79-c77d-458f-8fd0-e4df748f1c38@sandeen.net>
Date: Thu, 7 Mar 2024 12:26:44 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] minix: convert minix to use the new mount api
Content-Language: en-US
To: Bill O'Donnell <bodonnel@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, sandeen@redhat.com
References: <20240307163325.998723-1-bodonnel@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240307163325.998723-1-bodonnel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/24 10:29 AM, Bill O'Donnell wrote:
> Convert the minix filesystem to use the new mount API.
> 
> Tested using mount and remount on minix device.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>

Looks good to me now, thanks

Acked-by: Eric Sandeen <sandeen@redhat.com>

> ---
> 
> v2: Remove unneeded minix_context struct and its allocation/freeing.
> 
> ---
>  fs/minix/inode.c | 48 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index 73f37f298087..7b2b394a0799 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -20,11 +20,11 @@
>  #include <linux/mpage.h>
>  #include <linux/vfs.h>
>  #include <linux/writeback.h>
> +#include <linux/fs_context.h>
>  
>  static int minix_write_inode(struct inode *inode,
>  		struct writeback_control *wbc);
>  static int minix_statfs(struct dentry *dentry, struct kstatfs *buf);
> -static int minix_remount (struct super_block * sb, int * flags, char * data);
>  
>  static void minix_evict_inode(struct inode *inode)
>  {
> @@ -111,19 +111,19 @@ static const struct super_operations minix_sops = {
>  	.evict_inode	= minix_evict_inode,
>  	.put_super	= minix_put_super,
>  	.statfs		= minix_statfs,
> -	.remount_fs	= minix_remount,
>  };
>  
> -static int minix_remount (struct super_block * sb, int * flags, char * data)
> +static int minix_reconfigure(struct fs_context *fc)
>  {
> -	struct minix_sb_info * sbi = minix_sb(sb);
>  	struct minix_super_block * ms;
> +	struct super_block *sb = fc->root->d_sb;
> +	struct minix_sb_info * sbi = sb->s_fs_info;
>  
>  	sync_filesystem(sb);
>  	ms = sbi->s_ms;
> -	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
> +	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
>  		return 0;
> -	if (*flags & SB_RDONLY) {
> +	if (fc->sb_flags & SB_RDONLY) {
>  		if (ms->s_state & MINIX_VALID_FS ||
>  		    !(sbi->s_mount_state & MINIX_VALID_FS))
>  			return 0;
> @@ -170,7 +170,7 @@ static bool minix_check_superblock(struct super_block *sb)
>  	return true;
>  }
>  
> -static int minix_fill_super(struct super_block *s, void *data, int silent)
> +static int minix_fill_super(struct super_block *s, struct fs_context *fc)
>  {
>  	struct buffer_head *bh;
>  	struct buffer_head **map;
> @@ -180,6 +180,7 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
>  	struct inode *root_inode;
>  	struct minix_sb_info *sbi;
>  	int ret = -EINVAL;
> +	int silent = fc->sb_flags & SB_SILENT;
>  
>  	sbi = kzalloc(sizeof(struct minix_sb_info), GFP_KERNEL);
>  	if (!sbi)
> @@ -371,6 +372,23 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
>  	return ret;
>  }
>  
> +static int minix_get_tree(struct fs_context *fc)
> +{
> +	 return get_tree_bdev(fc, minix_fill_super);
> +}
> +
> +static const struct fs_context_operations minix_context_ops = {
> +	.get_tree	= minix_get_tree,
> +	.reconfigure	= minix_reconfigure,
> +};
> +
> +static int minix_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops = &minix_context_ops;
> +
> +	return 0;
> +}
> +
>  static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>  	struct super_block *sb = dentry->d_sb;
> @@ -680,18 +698,12 @@ void minix_truncate(struct inode * inode)
>  		V2_minix_truncate(inode);
>  }
>  
> -static struct dentry *minix_mount(struct file_system_type *fs_type,
> -	int flags, const char *dev_name, void *data)
> -{
> -	return mount_bdev(fs_type, flags, dev_name, data, minix_fill_super);
> -}
> -
>  static struct file_system_type minix_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name		= "minix",
> -	.mount		= minix_mount,
> -	.kill_sb	= kill_block_super,
> -	.fs_flags	= FS_REQUIRES_DEV,
> +	.owner			= THIS_MODULE,
> +	.name			= "minix",
> +	.kill_sb		= kill_block_super,
> +	.fs_flags		= FS_REQUIRES_DEV,
> +	.init_fs_context	= minix_init_fs_context,
>  };
>  MODULE_ALIAS_FS("minix");
>  


