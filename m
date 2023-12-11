Return-Path: <linux-fsdevel+bounces-5538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1C80D37D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711D51C21400
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195BF4E1AC;
	Mon, 11 Dec 2023 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iayBRXoR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gq4/V/Ap";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JWHgZqlE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LOT2l8ZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D657CCD;
	Mon, 11 Dec 2023 09:16:43 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB0321FBA5;
	Mon, 11 Dec 2023 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702315002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMM9MhtfbhX3ac2GwN2bNfaO9rysjcTZQxYvC7ZInFI=;
	b=iayBRXoRt1U9Tx06ZmstRbm2XveoOAJmb3H+XQyGqUT3P+zbvLC3fS/O5gdFufKvW1RJbL
	HMAZWuUZsMPyvABJ9A7pruDU4AcTDQzuM5BmFOcMpPg01XOr3SfxgwFxns6FxAg/2+qgul
	KHf+4YKjdBDiM3v+jN0kV6uOJtPm9mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702315002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMM9MhtfbhX3ac2GwN2bNfaO9rysjcTZQxYvC7ZInFI=;
	b=gq4/V/ApNSLd8arCAs4Cj0nWb4kzCJLFsxslfo8GpIg7puEZ0qyubbSAqtkLM29rFvPuF8
	ndIRhrA/lTNRnYCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702315001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMM9MhtfbhX3ac2GwN2bNfaO9rysjcTZQxYvC7ZInFI=;
	b=JWHgZqlEi7oldnItx6+BGXsreHUxl8R9ft/84suL5jG5LaRmqAKzMeY6LughDoVWTxSxb9
	rW5hIssnw8gI0rAEpLlvK9UAsO7fbGs1YIoSbw2xr16Qo/X5Ibe7jENGrdL9fXsCKZpUqp
	y3jHwJaYT0d5U78xPtPgc7mX/juPtCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702315001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMM9MhtfbhX3ac2GwN2bNfaO9rysjcTZQxYvC7ZInFI=;
	b=LOT2l8ZTpVnEcJMtm2mTePZcOc0vT6wlx3GQAnb7ighTwutmzdGsMJruFV/tFdhmn/grFg
	7iaP+/qqGQPJ6eBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A98A0134B0;
	Mon, 11 Dec 2023 17:16:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /jojKflDd2VgGwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 17:16:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C28F8A07E3; Mon, 11 Dec 2023 18:16:40 +0100 (CET)
Date: Mon, 11 Dec 2023 18:16:40 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
	konishi.ryusuke@gmail.com, willy@infradead.org,
	akpm@linux-foundation.org, p.raghav@samsung.com, hare@suse.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 for-6.8/block 16/18] ext4: use new helper to read
 sb block
Message-ID: <20231211171640.teuuedr3dqzsvsmw@quack3>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
 <20231211140808.975527-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211140808.975527-1-yukuai1@huaweicloud.com>
X-Spam-Score: 5.80
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 5.81
X-Spamd-Result: default: False [5.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLg7z3ka1nnoi3zj4x13ixbdfk)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.963];
	 RCPT_COUNT_GT_50(0.00)[50];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,redhat.com,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,lists.linux.dev,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Mon 11-12-23 22:08:08, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Remove __ext4_sb_bread_gfp() and ext4_buffer_uptodate() that is defined
> by ext4, and convert to use common helper __bread_gfp2() and
> buffer_uptodate_or_error().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    | 13 -------------
>  fs/ext4/inode.c   |  8 ++++----
>  fs/ext4/super.c   | 45 ++++++++++-----------------------------------
>  fs/ext4/symlink.c |  2 +-
>  4 files changed, 15 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index a5d784872303..8377f6c5264f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3824,19 +3824,6 @@ extern const struct iomap_ops ext4_iomap_ops;
>  extern const struct iomap_ops ext4_iomap_overwrite_ops;
>  extern const struct iomap_ops ext4_iomap_report_ops;
>  
> -static inline int ext4_buffer_uptodate(struct buffer_head *bh)
> -{
> -	/*
> -	 * If the buffer has the write error flag, we have failed
> -	 * to write out data in the block.  In this  case, we don't
> -	 * have to read the block because we may read the old data
> -	 * successfully.
> -	 */
> -	if (buffer_write_io_error(bh))
> -		set_buffer_uptodate(bh);
> -	return buffer_uptodate(bh);
> -}
> -
>  #endif	/* __KERNEL__ */
>  
>  #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 61277f7f8722..efb0af6f02f7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -887,7 +887,7 @@ struct buffer_head *ext4_bread(handle_t *handle, struct inode *inode,
>  	bh = ext4_getblk(handle, inode, block, map_flags);
>  	if (IS_ERR(bh))
>  		return bh;
> -	if (!bh || ext4_buffer_uptodate(bh))
> +	if (!bh || buffer_uptodate_or_error(bh))
>  		return bh;
>  
>  	ret = ext4_read_bh_lock(bh, REQ_META | REQ_PRIO, true);
> @@ -915,7 +915,7 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
>  
>  	for (i = 0; i < bh_count; i++)
>  		/* Note that NULL bhs[i] is valid because of holes. */
> -		if (bhs[i] && !ext4_buffer_uptodate(bhs[i]))
> +		if (bhs[i] && !buffer_uptodate_or_error(bhs[i]))
>  			ext4_read_bh_lock(bhs[i], REQ_META | REQ_PRIO, false);
>  
>  	if (!wait)
> @@ -4392,11 +4392,11 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  	bh = sb_getblk(sb, block);
>  	if (unlikely(!bh))
>  		return -ENOMEM;
> -	if (ext4_buffer_uptodate(bh))
> +	if (buffer_uptodate_or_error(bh))
>  		goto has_buffer;
>  
>  	lock_buffer(bh);
> -	if (ext4_buffer_uptodate(bh)) {
> +	if (buffer_uptodate_or_error(bh)) {
>  		/* Someone brought it uptodate while we waited */
>  		unlock_buffer(bh);
>  		goto has_buffer;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c5fcf377ab1f..ae41204f52d4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -180,7 +180,7 @@ void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
>  {
>  	BUG_ON(!buffer_locked(bh));
>  
> -	if (ext4_buffer_uptodate(bh)) {
> +	if (buffer_uptodate_or_error(bh)) {
>  		unlock_buffer(bh);
>  		return;
>  	}
> @@ -191,7 +191,7 @@ int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io
>  {
>  	BUG_ON(!buffer_locked(bh));
>  
> -	if (ext4_buffer_uptodate(bh)) {
> +	if (buffer_uptodate_or_error(bh)) {
>  		unlock_buffer(bh);
>  		return 0;
>  	}
> @@ -214,49 +214,24 @@ int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
>  	return ext4_read_bh(bh, op_flags, NULL);
>  }
>  
> -/*
> - * This works like __bread_gfp() except it uses ERR_PTR for error
> - * returns.  Currently with sb_bread it's impossible to distinguish
> - * between ENOMEM and EIO situations (since both result in a NULL
> - * return.
> - */
> -static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
> -					       sector_t block,
> -					       blk_opf_t op_flags, gfp_t gfp)
> -{
> -	struct buffer_head *bh;
> -	int ret;
> -
> -	bh = sb_getblk_gfp(sb, block, gfp);
> -	if (bh == NULL)
> -		return ERR_PTR(-ENOMEM);
> -	if (ext4_buffer_uptodate(bh))
> -		return bh;
> -
> -	ret = ext4_read_bh_lock(bh, REQ_META | op_flags, true);
> -	if (ret) {
> -		put_bh(bh);
> -		return ERR_PTR(ret);
> -	}
> -	return bh;
> -}
> -
>  struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
>  				   blk_opf_t op_flags)
>  {
> -	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
> -			~__GFP_FS) | __GFP_MOVABLE;
> +	struct buffer_head *bh = __bread_gfp2(sb->s_bdev, block,
> +					      sb->s_blocksize,
> +					      REQ_META | op_flags,
> +					      __GFP_MOVABLE);
>  
> -	return __ext4_sb_bread_gfp(sb, block, op_flags, gfp);
> +	return bh ? bh : ERR_PTR(-EIO);
>  }
>  
>  struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
>  					    sector_t block)
>  {
> -	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
> -			~__GFP_FS);
> +	struct buffer_head *bh = __bread_gfp2(sb->s_bdev, block,
> +					      sb->s_blocksize, 0, 0);
>  
> -	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
> +	return bh ? bh : ERR_PTR(-EIO);
>  }
>  
>  void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
> diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
> index 75bf1f88843c..49e918221aac 100644
> --- a/fs/ext4/symlink.c
> +++ b/fs/ext4/symlink.c
> @@ -94,7 +94,7 @@ static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
>  		bh = ext4_getblk(NULL, inode, 0, EXT4_GET_BLOCKS_CACHED_NOWAIT);
>  		if (IS_ERR(bh))
>  			return ERR_CAST(bh);
> -		if (!bh || !ext4_buffer_uptodate(bh))
> +		if (!bh || !buffer_uptodate_or_error(bh))
>  			return ERR_PTR(-ECHILD);
>  	} else {
>  		bh = ext4_bread(NULL, inode, 0, 0);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

