Return-Path: <linux-fsdevel+bounces-71762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975FACD0F47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 108373095A9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C8D32826F;
	Fri, 19 Dec 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W5w+7HUe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eQoWVWX+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W5w+7HUe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eQoWVWX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96833D4E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766162434; cv=none; b=JCgPPnCDD0gxA3ykki+iLzvsh8+we3W3XDbcTG/48KkwCOmsYHXD74uwzQ2Ar0i13ArIwUa+2FldMD9fjFunYYX44eb5h7N/+ROU24a3/Z1+N9M37uLMw7+OzC3BtNsPZTGhMzOnzhMj6ZuN606wP5gxE2+70DpLV+HwggSvdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766162434; c=relaxed/simple;
	bh=QgHlIMY0JttPFMP6CmWdOYfl00+E2m3IjSQY6sRbw5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9F18JUm9vtCXUFUTUK5Gzml6HiEPFIO3cW7vm62hrkP9soW6OESxHRfv553BGmEf49eyvvZTScalBnsiEpu13qG1IvPTpfaxGUY4MHhwNLRES9bc2hVBThNG1QTO7qqj9ix5CSko/y5yYpfo0WjpjK6mVn7THUVk1dxdVfVVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W5w+7HUe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eQoWVWX+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W5w+7HUe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eQoWVWX+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E0AD5BD00;
	Fri, 19 Dec 2025 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766162427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYwwSlkc6rG+ZQjgY71BoHufRNc1Sg35moOo3m0Gv8s=;
	b=W5w+7HUeVyFzlbb75Gb+yRn/NkCzKy7Prv/+KI3qLVUWz6Rr4L/uP0zggPTKm+juHBKW3j
	iDRo1OMHTSHhSNz2vqnGc41jpiIndGIWj+Co4r2t1ec68PrnzrBlOGGa3yeP958jmTR/Wo
	oX+VhGvzrcVgryzc3K/HNMImTtRH1MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766162427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYwwSlkc6rG+ZQjgY71BoHufRNc1Sg35moOo3m0Gv8s=;
	b=eQoWVWX+xBSVA3x0mFYtC3vtuNgwxbNhCNgSaykD8EojensRVQntQu45ItegM/5a10319/
	El0UEVj881QDMJCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766162427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYwwSlkc6rG+ZQjgY71BoHufRNc1Sg35moOo3m0Gv8s=;
	b=W5w+7HUeVyFzlbb75Gb+yRn/NkCzKy7Prv/+KI3qLVUWz6Rr4L/uP0zggPTKm+juHBKW3j
	iDRo1OMHTSHhSNz2vqnGc41jpiIndGIWj+Co4r2t1ec68PrnzrBlOGGa3yeP958jmTR/Wo
	oX+VhGvzrcVgryzc3K/HNMImTtRH1MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766162427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYwwSlkc6rG+ZQjgY71BoHufRNc1Sg35moOo3m0Gv8s=;
	b=eQoWVWX+xBSVA3x0mFYtC3vtuNgwxbNhCNgSaykD8EojensRVQntQu45ItegM/5a10319/
	El0UEVj881QDMJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8785F3EA63;
	Fri, 19 Dec 2025 16:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DUTTIPt/RWnsVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Dec 2025 16:40:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28705A090B; Fri, 19 Dec 2025 17:40:23 +0100 (CET)
Date: Fri, 19 Dec 2025 17:40:23 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next 4/7] ext4: remove useless ext4_iomap_overwrite_ops
Message-ID: <ejn2uuiwgbxnfzzza4bm4xjpxdkwgjtbu6spbi5njdwy4mwa73@jaxlr2a57o7o>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
 <20251213022008.1766912-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213022008.1766912-5-yi.zhang@huaweicloud.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Sat 13-12-25 10:20:05, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> ext4_iomap_overwrite_ops was introduced in commit 8cd115bdda17 ("ext4:
> Optimize ext4 DIO overwrites"), which can optimize pure overwrite
> performance by dropping the IOMAP_WRITE flag to only query the mapped
> mapping information. This avoids starting a new journal handle, thereby
> improving speed. Later, commit 9faac62d4013 ("ext4: optimize file
> overwrites") also optimized similar scenarios, but it performs the check
> later, examining the mappings status only when the actual block mapping
> is needed. Thus, it can handle the previous commit scenario. That means
> in the case of an overwrite scenario, the condition
> "offset + length <= i_size_read(inode)" in the write path must always be
> true.
> 
> Therefore, it is acceptable to remove the ext4_iomap_overwrite_ops,
> which will also clarify the write and read paths of ext4_iomap_begin.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Nice simplification! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/ext4.h  |  1 -
>  fs/ext4/file.c  |  5 +----
>  fs/ext4/inode.c | 24 ------------------------
>  3 files changed, 1 insertion(+), 29 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 56112f201cac..9a71357f192d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3909,7 +3909,6 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
>  }
>  
>  extern const struct iomap_ops ext4_iomap_ops;
> -extern const struct iomap_ops ext4_iomap_overwrite_ops;
>  extern const struct iomap_ops ext4_iomap_report_ops;
>  
>  static inline int ext4_buffer_uptodate(struct buffer_head *bh)
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 9f571acc7782..6b4b68f830d5 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -506,7 +506,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	loff_t offset = iocb->ki_pos;
>  	size_t count = iov_iter_count(from);
> -	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>  	bool extend = false, unwritten = false;
>  	bool ilock_shared = true;
>  	int dio_flags = 0;
> @@ -573,9 +572,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			goto out;
>  	}
>  
> -	if (ilock_shared && !unwritten)
> -		iomap_ops = &ext4_iomap_overwrite_ops;
> -	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> +	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
>  			   dio_flags, NULL, 0);
>  	if (ret == -ENOTBLK)
>  		ret = 0;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 08a296122fe0..88144e2ce3e2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3830,10 +3830,6 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		}
>  		ret = ext4_iomap_alloc(inode, &map, flags);
>  	} else {
> -		/*
> -		 * This can be called for overwrites path from
> -		 * ext4_iomap_overwrite_begin().
> -		 */
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
>  	}
>  
> @@ -3862,30 +3858,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	return 0;
>  }
>  
> -static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
> -		loff_t length, unsigned flags, struct iomap *iomap,
> -		struct iomap *srcmap)
> -{
> -	int ret;
> -
> -	/*
> -	 * Even for writes we don't need to allocate blocks, so just pretend
> -	 * we are reading to save overhead of starting a transaction.
> -	 */
> -	flags &= ~IOMAP_WRITE;
> -	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
> -	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
> -	return ret;
> -}
> -
>  const struct iomap_ops ext4_iomap_ops = {
>  	.iomap_begin		= ext4_iomap_begin,
>  };
>  
> -const struct iomap_ops ext4_iomap_overwrite_ops = {
> -	.iomap_begin		= ext4_iomap_overwrite_begin,
> -};
> -
>  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>  				   loff_t length, unsigned int flags,
>  				   struct iomap *iomap, struct iomap *srcmap)
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

