Return-Path: <linux-fsdevel+bounces-7167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B8B822AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3E8B21A02
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 10:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04D518AEB;
	Wed,  3 Jan 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnosXRj9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T8Jw5yon";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnosXRj9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T8Jw5yon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D518656;
	Wed,  3 Jan 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 533BD1F79F;
	Wed,  3 Jan 2024 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704276210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmpepAqj7QQML5bVbhgmYTjdiasXZsKlqOLdsFbMBJ4=;
	b=JnosXRj9YF46Sn+fb27Or2Ldt2HFY3RAWf92f4ULrMHmSwgExh3IvbQXY2L30AMXRpYIdS
	AfmzKEDnS8ApxaC+UEVEn7UUsLLO+auhSwXuZ8D00lrE8OOxKHssH7OK3pjRUFVJlodYSE
	nPzPKWkO8VQt3TpuPLtcjBJ6Nyrr1ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704276210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmpepAqj7QQML5bVbhgmYTjdiasXZsKlqOLdsFbMBJ4=;
	b=T8Jw5yonE9cHBIUet3udRaG9TmM/hGItjLBvyvAxmzeYR1yqWGgXJEWdgEUP5zyxJPu/GN
	zyavCCsmL5KkPaDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704276210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmpepAqj7QQML5bVbhgmYTjdiasXZsKlqOLdsFbMBJ4=;
	b=JnosXRj9YF46Sn+fb27Or2Ldt2HFY3RAWf92f4ULrMHmSwgExh3IvbQXY2L30AMXRpYIdS
	AfmzKEDnS8ApxaC+UEVEn7UUsLLO+auhSwXuZ8D00lrE8OOxKHssH7OK3pjRUFVJlodYSE
	nPzPKWkO8VQt3TpuPLtcjBJ6Nyrr1ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704276210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmpepAqj7QQML5bVbhgmYTjdiasXZsKlqOLdsFbMBJ4=;
	b=T8Jw5yonE9cHBIUet3udRaG9TmM/hGItjLBvyvAxmzeYR1yqWGgXJEWdgEUP5zyxJPu/GN
	zyavCCsmL5KkPaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40AA513AA6;
	Wed,  3 Jan 2024 10:03:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6lB6D/IwlWVJeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jan 2024 10:03:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D32CAA07EF; Wed,  3 Jan 2024 11:03:25 +0100 (CET)
Date: Wed, 3 Jan 2024 11:03:25 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v2 02/25] ext4: convert to exclusive lock while
 inserting delalloc extents
Message-ID: <20240103100325.jmzlai2xegn4skwm@quack3>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
 <20240102123918.799062-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102123918.799062-3-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JnosXRj9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T8Jw5yon
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 533BD1F79F
X-Spam-Flag: NO

On Tue 02-01-24 20:38:55, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> ext4_da_map_blocks() only hold i_data_sem in shared mode and i_rwsem
> when inserting delalloc extents, it could be raced by another querying
> path of ext4_map_blocks() without i_rwsem, .e.g buffered read path.
> Suppose we buffered read a file containing just a hole, and without any
> cached extents tree, then it is raced by another delayed buffered write
> to the same area or the near area belongs to the same hole, and the new
> delalloc extent could be overwritten to a hole extent.
> 
>  pread()                           pwrite()
>   filemap_read_folio()
>    ext4_mpage_readpages()
>     ext4_map_blocks()
>      down_read(i_data_sem)
>      ext4_ext_determine_hole()
>      //find hole
>      ext4_ext_put_gap_in_cache()
>       ext4_es_find_extent_range()
>       //no delalloc extent
>                                     ext4_da_map_blocks()
>                                      down_read(i_data_sem)
>                                      ext4_insert_delayed_block()
>                                      //insert delalloc extent
>       ext4_es_insert_extent()
>       //overwrite delalloc extent to hole
> 
> This race could lead to inconsistent delalloc extents tree and
> incorrect reserved space counter. Fix this by converting to hold
> i_data_sem in exclusive mode when adding a new delalloc extent in
> ext4_da_map_blocks().
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Looks good to me! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b0d3075be12..142c67f5c7fc 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1703,10 +1703,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  
>  	/* Lookup extent status tree firstly */
>  	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
> -		if (ext4_es_is_hole(&es)) {
> -			down_read(&EXT4_I(inode)->i_data_sem);
> +		if (ext4_es_is_hole(&es))
>  			goto add_delayed;
> -		}
>  
>  		/*
>  		 * Delayed extent could be allocated by fallocate.
> @@ -1748,8 +1746,10 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
>  	else
>  		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
> -	if (retval < 0)
> -		goto out_unlock;
> +	if (retval < 0) {
> +		up_read(&EXT4_I(inode)->i_data_sem);
> +		return retval;
> +	}
>  	if (retval > 0) {
>  		unsigned int status;
>  
> @@ -1765,24 +1765,21 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
>  				      map->m_pblk, status);
> -		goto out_unlock;
> +		up_read(&EXT4_I(inode)->i_data_sem);
> +		return retval;
>  	}
> +	up_read(&EXT4_I(inode)->i_data_sem);
>  
>  add_delayed:
> -	/*
> -	 * XXX: __block_prepare_write() unmaps passed block,
> -	 * is it OK?
> -	 */
> +	down_write(&EXT4_I(inode)->i_data_sem);
>  	retval = ext4_insert_delayed_block(inode, map->m_lblk);
> +	up_write(&EXT4_I(inode)->i_data_sem);
>  	if (retval)
> -		goto out_unlock;
> +		return retval;
>  
>  	map_bh(bh, inode->i_sb, invalid_block);
>  	set_buffer_new(bh);
>  	set_buffer_delay(bh);
> -
> -out_unlock:
> -	up_read((&EXT4_I(inode)->i_data_sem));
>  	return retval;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

