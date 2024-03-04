Return-Path: <linux-fsdevel+bounces-13437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B69786FD0B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 10:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B901C225CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201F2562F;
	Mon,  4 Mar 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkRP4VuM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAA208DD;
	Mon,  4 Mar 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543908; cv=none; b=SGojyaKqdevy62oxRU3fg38t5em66kwuxG4FZnEBZNmfPULkY49S5nd3XUEMzndEEAIVTb6vweuX6ll+lcnTbqCg5k/0tKdcxGga2ZEbXnzHSh7h5lp51S0CxJMrcijAumH21oGmOc278T+JIzgpjKZ873eJHCLkUeFdY67qspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543908; c=relaxed/simple;
	bh=iIcoVUjRlYsRf3EzWL9aMWy1LM1drhYauQiWNrhqycA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kODaLlN4Xz3DsbxvvepjOuh05ouLRUSN5X+cN2Cjwc49i6wiURi8Jw6OmI6OfoeGfi2DPAj1dnVIKy6H6OK3WVuEpP2YKQ3HGti5PXvfcjTtOupM7wb3bspyTLn8ey+i1cRy3bPB9AqfNiC24cBPoXZdNU3ZEbHZhuJjyMBKZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkRP4VuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF05C433F1;
	Mon,  4 Mar 2024 09:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709543907;
	bh=iIcoVUjRlYsRf3EzWL9aMWy1LM1drhYauQiWNrhqycA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkRP4VuMgOJdbbQLJ4Y3sr1szCP+jS3LWglocdiHm1gTFqV7xNwdB9jdD24EQvm/c
	 URBAHeOH7mwVEBK2ocYhfQl/9jljaPhXcWg7UuzBIx1tB/KncI0LolAWKvX6M7bsWP
	 cH7nLWnrZPjsPPN/xveDb403ry0gMx1E7QvVM1OpCRNNXPZ1McHcfsJqlZR4CTMTXL
	 tqPVvQWBg1dQ5ZisZj9qYitHEf5AP7Q3H4ZXzppqgsaVgEyWPjqtGI3dfmdamiqanv
	 zVkwvHMVGVO6QIvjxG69oPDBnNOyQCVhxqb1zRxWSjFooyCQVfaGqxDj4NZBv3OX9J
	 WMP2e7TQAwmww==
Date: Mon, 4 Mar 2024 10:18:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] statx: stx_vol
Message-ID: <20240304-konfus-neugierig-5c7c9d5a8ad6@brauner>
References: <20240302220203.623614-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240302220203.623614-1-kent.overstreet@linux.dev>

On Sat, Mar 02, 2024 at 05:02:03PM -0500, Kent Overstreet wrote:
> Add a new statx field for (sub)volume identifiers.
> 
> This includes bcachefs support; we'll definitely want btrfs support as
> well.
> 
> Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: David Howells <dhowells@redhat.com>
> ---

As I've said many times before I'm supportive of this and would pick up
a patch like this. There's definitely a lot of userspace that would make
use of this that I'm aware of. If the btrfs people could provide an Ack
on this to express their support here that would be great.

And it would be lovely if we could expand the commit message a bit and
do some renaming/bikeshedding. Imho, STATX_SUBVOLUME_ID is great and
then stx_subvolume_id or stx_subvol_id. And then subvolume_id or
subvol_id for the field in struct kstat.

>  fs/bcachefs/fs.c          | 3 +++
>  fs/stat.c                 | 1 +
>  include/linux/stat.h      | 1 +
>  include/uapi/linux/stat.h | 4 +++-
>  4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 3f073845bbd7..d82f7f3f0670 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -840,6 +840,9 @@ static int bch2_getattr(struct mnt_idmap *idmap,
>  	stat->blksize	= block_bytes(c);
>  	stat->blocks	= inode->v.i_blocks;
>  
> +	stat->vol	= inode->ei_subvol;
> +	stat->result_mask |= STATX_VOL;
> +
>  	if (request_mask & STATX_BTIME) {
>  		stat->result_mask |= STATX_BTIME;
>  		stat->btime = bch2_time_to_timespec(c, inode->ei_inode.bi_otime);
> diff --git a/fs/stat.c b/fs/stat.c
> index 77cdc69eb422..80d5f7502d99 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -658,6 +658,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_mnt_id = stat->mnt_id;
>  	tmp.stx_dio_mem_align = stat->dio_mem_align;
>  	tmp.stx_dio_offset_align = stat->dio_offset_align;
> +	tmp.stx_vol = stat->vol;
>  
>  	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>  }
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 52150570d37a..9dc1b493ef1f 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -53,6 +53,7 @@ struct kstat {
>  	u32		dio_mem_align;
>  	u32		dio_offset_align;
>  	u64		change_cookie;
> +	u64		vol;
>  };
>  
>  /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 2f2ee82d5517..ae090d67946d 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -126,8 +126,9 @@ struct statx {
>  	__u64	stx_mnt_id;
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
> +	__u64	stx_vol;	/* Subvolume identifier */
>  	/* 0xa0 */
> -	__u64	__spare3[12];	/* Spare space for future expansion */
> +	__u64	__spare3[11];	/* Spare space for future expansion */
>  	/* 0x100 */
>  };
>  
> @@ -155,6 +156,7 @@ struct statx {
>  #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
>  #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
>  #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
> +#define STATX_VOL		0x00008000U	/* Want/got stx_vol */
>  
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>  
> -- 
> 2.43.0
> 

