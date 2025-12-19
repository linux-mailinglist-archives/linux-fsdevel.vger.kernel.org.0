Return-Path: <linux-fsdevel+bounces-71754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA5CD078E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 16:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10B7F300F324
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2EC349AE5;
	Fri, 19 Dec 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DeaVaYeZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MovZNv0m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="btfWSt74";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KHu/c+j1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C5D347FEE
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157484; cv=none; b=Qz4rSlU4pKhS+hGFZy62EMruGA0bVroaiOpH2s+Z708QWsZ5a3a/BkZwaKYWYFlCjtrKgE9vaGpuxW+V4q3hLVsgitQxGexSby+5t1IMrLrBOGFCQ4GWgx9wP2Hu7yBugHrrh2SM4s52x9f2pa0TTcaGnw7BpjPito1ZjR8m3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157484; c=relaxed/simple;
	bh=isoQpIgL7PSvlw1oyQDp5vhkOJ/ZiNuxNWeU9+w+4FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRa9xJPK1ix8S0wtdkhRu8errcXSydqdGE21roYyhV6XU55dqJ6WQKfxag3HnZhdP0E+Ilx+I43ZXQWhVvkt9nHNSqGLqXYGlI1ovDi+ILWL+7mWatLPYpcNEQNQllUZgb0UHJenGOsLGDvFhXxSkSVo88ShkCm7qKKmABrmZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DeaVaYeZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MovZNv0m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=btfWSt74; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KHu/c+j1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE58233714;
	Fri, 19 Dec 2025 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766157480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYGszoMFcAZQ2YN0RYeUI2C24RF8t1CbgiOkplxM+qk=;
	b=DeaVaYeZOjpQftigyY8b0CUG8yx90Gi9mnBhr2Q8CYHlMKeLaI3hPIfn+oD3ucS2BDX45X
	sgbE01+VFUXJ9cqyoNcssZMepjNeJ75gtGyfpik9u+Hwa2qVDQfn+DPYYQTNa2QlytxUiO
	yPSFvaMONynoxlk7Fw5/dRT1DNfmDcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766157480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYGszoMFcAZQ2YN0RYeUI2C24RF8t1CbgiOkplxM+qk=;
	b=MovZNv0mImpu57jeNP/ehltRalz3UGN6jZ7NvfB43gBLf7WccslqPRuic1dfWcVW9o/uAw
	OhWXAzgygGzmjbAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=btfWSt74;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="KHu/c+j1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766157479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYGszoMFcAZQ2YN0RYeUI2C24RF8t1CbgiOkplxM+qk=;
	b=btfWSt74oUu+T6/4sCHH+CJNdnIbuMRlwjQ7sVEudrD1QK/yb694qKxfC0MsupZmCKeZKh
	Lf8h0fGOlYU2iRGkyyp29nH8SqHbZRpiQTofce9GcuGLgai5ZDoZJJKiuLnjJ2W6b1ozeQ
	sHmaRDad+pU67gWnUqEe8fe9heFzgQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766157479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYGszoMFcAZQ2YN0RYeUI2C24RF8t1CbgiOkplxM+qk=;
	b=KHu/c+j1tbBhl6qEY41N6Lz9Sw2XS/xd0p6B1WqoNRomY1oED7POnriDsRALmfqDgAwCfc
	wZXRT7HACPf+BWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1E083EA63;
	Fri, 19 Dec 2025 15:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UeI3M6dsRWkCRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Dec 2025 15:17:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 870C6A090B; Fri, 19 Dec 2025 16:17:59 +0100 (CET)
Date: Fri, 19 Dec 2025 16:17:59 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next 2/7] ext4: don't split extent before submitting I/O
Message-ID: <7vuttijv2pqx2lgan5rkcw6ofi4uhrsfbmksg4doyq34rjidte@mnfd6cbehncq>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
 <20251213022008.1766912-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213022008.1766912-3-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,huawei.com,fnnas.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: DE58233714
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Sat 13-12-25 10:20:03, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, when writing back dirty pages to the filesystem with the
> dioread_nolock feature enabled and when doing DIO, if the area to be
> written back is part of an unwritten extent, the
> EXT4_GET_BLOCKS_IO_CREATE_EXT flag is set during block allocation before
> submitting I/O. The function ext4_split_convert_extents() then attempts
> to split this extent in advance. This approach is designed to prevents
> extent splitting and conversion to the written type from failing due to
> insufficient disk space at the time of I/O completion, which could
> otherwise result in data loss.
> 
> However, we already have two mechanisms to ensure successful extent
> conversion. The first is the EXT4_GET_BLOCKS_METADATA_NOFAIL flag, which
> is a best effort, it permits the use of 2% of the reserved space or
> 4,096 blocks in the file system when splitting extents. This flag covers
> most scenarios where extent splitting might fail. The second is the
> EXT4_EXT_MAY_ZEROOUT flag, which is also set during extent splitting. If
> the reserved space is insufficient and splitting fails, it does not
> retry the allocation. Instead, it directly zeros out the extra part of
> the extent, thereby avoiding splitting and directly converting the
> entire extent to the written type.
> 
> These two mechanisms also exist when I/Os are completed because there is
> a concurrency window between write-back and fallocate, which may still
> require us to split extents upon I/O completion. There is no much
> difference between splitting extents before submitting I/O. Therefore,
> It seems possible to defer the splitting until I/O completion, it won't
> increase the risk of I/O failure and data loss. On the contrary, if some
> I/Os can be merged when I/O completion, it can also reduce unnecessary
> splitting operations, thereby alleviating the pressure on reserved
> space.
> 
> In addition, deferring extent splitting until I/O completion can
> also simplify the IO submission process and avoid initiating unnecessary
> journal handles when writing unwritten extents.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 13 +------------
>  fs/ext4/inode.c   |  4 ++--
>  2 files changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e53959120b04..c98f7c5482b4 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3787,21 +3787,10 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)ee_block, ee_len);
>  
> -	/* If extent is larger than requested it is a clear sign that we still
> -	 * have some extent state machine issues left. So extent_split is still
> -	 * required.
> -	 * TODO: Once all related issues will be fixed this situation should be
> -	 * illegal.
> -	 */
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
>  		int flags = EXT4_GET_BLOCKS_CONVERT |
>  			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
> -#ifdef CONFIG_EXT4_DEBUG
> -		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
> -			     " len %u; IO logical block %llu, len %u",
> -			     inode->i_ino, (unsigned long long)ee_block, ee_len,
> -			     (unsigned long long)map->m_lblk, map->m_len);
> -#endif
> +
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  						  flags, NULL);
>  		if (IS_ERR(path))
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bb8165582840..ffde24ff7347 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2376,7 +2376,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  
>  	dioread_nolock = ext4_should_dioread_nolock(inode);
>  	if (dioread_nolock)
> -		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
> +		get_blocks_flags |= EXT4_GET_BLOCKS_UNWRIT_EXT;
>  
>  	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
>  	if (err < 0)
> @@ -3744,7 +3744,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>  	else if (EXT4_LBLK_TO_B(inode, map->m_lblk) >= i_size_read(inode))
>  		m_flags = EXT4_GET_BLOCKS_CREATE;
>  	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> +		m_flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
>  
>  	if (flags & IOMAP_ATOMIC)
>  		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

