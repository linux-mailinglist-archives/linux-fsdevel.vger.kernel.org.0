Return-Path: <linux-fsdevel+bounces-22994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151179252E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 07:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC352856A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 05:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D993A1B5;
	Wed,  3 Jul 2024 05:19:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D722EE8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719983993; cv=none; b=bVaCazPv4NZYcJ93deOgrrW5z1INVc5rOsgGJLpf8BQtEWJt/CyTA3LA+wKlDxoguXrfJye+8JS4xeS51PnFPdCUT9obHLRxsTTqSZMwAaKKaZBNGHCLOVj/D0viAl1LoWv9Fenkr2ne2zJUW/WhxdeYJFSvWuJfQ5WEYLaU5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719983993; c=relaxed/simple;
	bh=kTWfOY9STuF9Hi/Y+RlugdLP4G4Ziv8bSvLbKL4tYaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1LjbFImJEp4fgN4M1RV1daFvLjMXN/IrS63H+96W2r+cpCVfD45UeAQ1iZIvf/c08PxEFLCtfMVkFR5loofOg5R94UecJ0eB3SFJKAA6anj+3L9jI+HrQS0Mu6FDtREtMRRakTruRdu2EXhjjh5PyHk1/51hUz2FnHA0XW6fhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 10CD82055FA2;
	Wed,  3 Jul 2024 14:19:43 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 4635JftD114138
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 14:19:42 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 4635JfKP681070
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 14:19:41 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4635JfZW681069;
	Wed, 3 Jul 2024 14:19:41 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH V2 1/3] fat: move debug into fat_mount_options
In-Reply-To: <f6155247-32ee-4cfe-b808-9102b17f7cd1@redhat.com> (Eric Sandeen's
	message of "Tue, 2 Jul 2024 17:41:22 -0500")
References: <ec599fc8-b32e-48cf-ac6c-09ded36468d5@redhat.com>
	<f6155247-32ee-4cfe-b808-9102b17f7cd1@redhat.com>
Date: Wed, 03 Jul 2024 14:19:41 +0900
Message-ID: <87ikxnrr0y.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sandeen <sandeen@redhat.com> writes:

> Move the debug variable into fat_mount_options for consistency and
> to facilitate conversion to new mount API.
>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good. (maybe, this patchset should go with your patch series with
fsparam_uid/gid?)

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> ---
>  fs/fat/fat.h   | 3 ++-
>  fs/fat/inode.c | 9 ++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 66cf4778cf3b..37ced7bb06d5 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -51,7 +51,8 @@ struct fat_mount_options {
>  		 tz_set:1,	   /* Filesystem timestamps' offset set */
>  		 rodir:1,	   /* allow ATTR_RO for directory */
>  		 discard:1,	   /* Issue discard requests on deletions */
> -		 dos1xfloppy:1;	   /* Assume default BPB for DOS 1.x floppies */
> +		 dos1xfloppy:1,	   /* Assume default BPB for DOS 1.x floppies */
> +		 debug:1;	   /* Not currently used */
>  };
>  
>  #define FAT_HASH_BITS	8
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index d9e6fbb6f246..2a6537ba0d49 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1132,7 +1132,7 @@ static const match_table_t vfat_tokens = {
>  };
>  
>  static int parse_options(struct super_block *sb, char *options, int is_vfat,
> -			 int silent, int *debug, struct fat_mount_options *opts)
> +			 int silent, struct fat_mount_options *opts)
>  {
>  	char *p;
>  	substring_t args[MAX_OPT_ARGS];
> @@ -1162,7 +1162,7 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
>  	opts->tz_set = 0;
>  	opts->nfs = 0;
>  	opts->errors = FAT_ERRORS_RO;
> -	*debug = 0;
> +	opts->debug = 0;
>  
>  	opts->utf8 = IS_ENABLED(CONFIG_FAT_DEFAULT_UTF8) && is_vfat;
>  
> @@ -1210,7 +1210,7 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
>  			opts->showexec = 1;
>  			break;
>  		case Opt_debug:
> -			*debug = 1;
> +			opts->debug = 1;
>  			break;
>  		case Opt_immutable:
>  			opts->sys_immutable = 1;
> @@ -1614,7 +1614,6 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
>  	struct msdos_sb_info *sbi;
>  	u16 logical_sector_size;
>  	u32 total_sectors, total_clusters, fat_clusters, rootdir_sectors;
> -	int debug;
>  	long error;
>  	char buf[50];
>  	struct timespec64 ts;
> @@ -1643,7 +1642,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
>  	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
>  			     DEFAULT_RATELIMIT_BURST);
>  
> -	error = parse_options(sb, data, isvfat, silent, &debug, &sbi->options);
> +	error = parse_options(sb, data, isvfat, silent, &sbi->options);
>  	if (error)
>  		goto out_fail;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

