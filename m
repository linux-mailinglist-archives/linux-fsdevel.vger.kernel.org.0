Return-Path: <linux-fsdevel+bounces-71765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1FECD105C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 18:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9CF930B1D58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B035E529;
	Fri, 19 Dec 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uRkGcRWE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yOOBW2SY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uRkGcRWE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yOOBW2SY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1335A95F
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766162822; cv=none; b=L6btn6h7mlbz5A36nRNchKgcPkk5G8QU9bfC+OLfd+xjq4YQ5THGZcAPOmIJVi7xGeXDxi4oNX7THiu0w62ApfcoauSfvAucY48znTLaphc8OfHmJHsSK1RxpFLHUXhyAtjsDl5Vi3jjdG0dMTCwcmNU4cyHOlVh7xxBA7ZE44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766162822; c=relaxed/simple;
	bh=6IAz/DgibssxpXWM5OEKgnMa3zhoSWiIHa+YPnGvuJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brn1+UA03XUvGSsMqsVMa/xuZuyFGSiUnkyrx+u4ToeLQmwuTUVFJEke53VP/D9XppbKyvbtlTJbI8zpcOie1Rkp9p5iPBSFO8Lr/uo3wmGUkKyptLq1c+sk99PIqcCUhRE6w2umZ4wapKAkGx4s9IR3j/d9e0kLHa42XIaGTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uRkGcRWE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yOOBW2SY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uRkGcRWE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yOOBW2SY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E8D333742;
	Fri, 19 Dec 2025 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766162817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivrjhi16zNRk9RAiTT2eb2crRxXyhi3JrTO91uwFab8=;
	b=uRkGcRWEo6DrM1102Um9aNopEbw0sm7lh8+Sjgy1+5UVE8WW4g23nXtT0gxtl4vKT0O1KB
	0xjb5uSYgJdIHEv2k0ikxbvAZ27yJ9Uk4BVolQ0lmiJmC6f5LbAmpI32nO018/ODnbS8Vg
	Ja68rps9Zl/phuk+3Nl7dpipMcr6wbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766162817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivrjhi16zNRk9RAiTT2eb2crRxXyhi3JrTO91uwFab8=;
	b=yOOBW2SYeVZRExcT8g8UVEPx4zKOI3P1PSQ9RlGfgA64oGQwOemXkEfsmgR6RViWrPQE5o
	phG+kVMFIaHv5pAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766162817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivrjhi16zNRk9RAiTT2eb2crRxXyhi3JrTO91uwFab8=;
	b=uRkGcRWEo6DrM1102Um9aNopEbw0sm7lh8+Sjgy1+5UVE8WW4g23nXtT0gxtl4vKT0O1KB
	0xjb5uSYgJdIHEv2k0ikxbvAZ27yJ9Uk4BVolQ0lmiJmC6f5LbAmpI32nO018/ODnbS8Vg
	Ja68rps9Zl/phuk+3Nl7dpipMcr6wbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766162817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivrjhi16zNRk9RAiTT2eb2crRxXyhi3JrTO91uwFab8=;
	b=yOOBW2SYeVZRExcT8g8UVEPx4zKOI3P1PSQ9RlGfgA64oGQwOemXkEfsmgR6RViWrPQE5o
	phG+kVMFIaHv5pAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FA033EA63;
	Fri, 19 Dec 2025 16:46:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mCTOA4GBRWlqVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Dec 2025 16:46:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2B8EA090B; Fri, 19 Dec 2025 17:46:56 +0100 (CET)
Date: Fri, 19 Dec 2025 17:46:56 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next 7/7] ext4: remove EXT4_GET_BLOCKS_IO_CREATE_EXT
Message-ID: <qk4yw6xpmgzy3yhufoztirledrazo6gyh4sgri3d5fmpajloev@lt677they3mw>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
 <20251213022008.1766912-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213022008.1766912-8-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,huawei.com,fnnas.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,huawei.com:email]

On Sat 13-12-25 10:20:08, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> We do not use EXT4_GET_BLOCKS_IO_CREATE_EXT or split extents before
> submitting I/O; therefore, remove the related code.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    |  9 ---------
>  fs/ext4/extents.c | 29 -----------------------------
>  fs/ext4/inode.c   | 11 -----------
>  3 files changed, 49 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9a71357f192d..174c51402864 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -707,15 +707,6 @@ enum {
>  	 * found an unwritten extent, we need to split it.
>  	 */
>  #define EXT4_GET_BLOCKS_SPLIT_NOMERGE		0x0008
> -	/*
> -	 * Caller is from the dio or dioread_nolock buffered IO, reqest to
> -	 * create an unwritten extent if it does not exist or split the
> -	 * found unwritten extent. Also do not merge the newly created
> -	 * unwritten extent, io end will convert unwritten to written,
> -	 * and try to merge the written extent.
> -	 */
> -#define EXT4_GET_BLOCKS_IO_CREATE_EXT		(EXT4_GET_BLOCKS_SPLIT_NOMERGE|\
> -					 EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT)
>  	/* Convert unwritten extent to initialized. */
>  #define EXT4_GET_BLOCKS_CONVERT			0x0010
>  	/* Eventual metadata allocation (due to growing extent tree)
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c98f7c5482b4..c7c66ab825e7 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3925,34 +3925,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	trace_ext4_ext_handle_unwritten_extents(inode, map, flags,
>  						*allocated, newblock);
>  
> -	/* get_block() before submitting IO, split the extent */
> -	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE) {
> -		int depth;
> -
> -		path = ext4_split_convert_extents(handle, inode, map, path,
> -						  flags, allocated);
> -		if (IS_ERR(path))
> -			return path;
> -		/*
> -		 * shouldn't get a 0 allocated when splitting an extent unless
> -		 * m_len is 0 (bug) or extent has been corrupted
> -		 */
> -		if (unlikely(*allocated == 0)) {
> -			EXT4_ERROR_INODE(inode,
> -					 "unexpected allocated == 0, m_len = %u",
> -					 map->m_len);
> -			err = -EFSCORRUPTED;
> -			goto errout;
> -		}
> -		/* Don't mark unwritten if the extent has been zeroed out. */
> -		path = ext4_find_extent(inode, map->m_lblk, path, flags);
> -		if (IS_ERR(path))
> -			return path;
> -		depth = ext_depth(inode);
> -		if (ext4_ext_is_unwritten(path[depth].p_ext))
> -			map->m_flags |= EXT4_MAP_UNWRITTEN;
> -		goto out;
> -	}
>  	/* IO end_io complete, convert the filled extent to written */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT) {
>  		path = ext4_convert_unwritten_extents_endio(handle, inode,
> @@ -4006,7 +3978,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  		goto errout;
>  	}
>  
> -out:
>  	map->m_flags |= EXT4_MAP_NEW;
>  map_out:
>  	map->m_flags |= EXT4_MAP_MAPPED;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 39348ee46e5c..fa579e857baf 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -588,7 +588,6 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  				  struct ext4_map_blocks *map, int flags)
>  {
> -	struct extent_status es;
>  	unsigned int status;
>  	int err, retval = 0;
>  
> @@ -649,16 +648,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  			return err;
>  	}
>  
> -	/*
> -	 * If the extent has been zeroed out, we don't need to update
> -	 * extent status tree.
> -	 */
> -	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE &&
> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
> -		if (ext4_es_is_written(&es))
> -			return retval;
> -	}
> -
>  	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>  			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

