Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAEBA81A0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 14:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfHEMyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 08:54:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35650 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHEMyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:54:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so84323969wrm.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 05:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=e57kIhw84UdoXYrNs7u6qZqeIpMAhlE8YhPfmUmLsAE=;
        b=bQqCTq34wgFfdtdVtWegTOdl7MmW+AfxarR64NeIHp4LQp6ynvIUdEDwMkyOjKs5DG
         6FgAv3j3SZvF5Ki1cBprvYJ97kJGLqa90dDf+3BY9gOm54RGWQhCFwRVawNifRkrTTEh
         soE4MEUZy8Nv9QVDyt4lZbyQRjEjCI48iVozOO8HreRYqDav3e/pdiiRcqE7aIzcXYFF
         4Y5bF0VDfDasfeVfzNpAInozOec53/JKgWvqJrvHR2WQwa3d0euDOP6njI8AyDnape4l
         L/+s8PsBpxZDkXQgpgkT1656yBXQM8CfYT2E7Ce4ZdAtk1lT6OrBxW3L0M9LIECc/xpT
         LfGw==
X-Gm-Message-State: APjAAAW+XioMh89hmJLB5l/aDgW8bGvs0JoF8EfHTGBsOaX60dBZap88
        mfNFO002KMvdVx0py8vJcO1SlQ==
X-Google-Smtp-Source: APXvYqxJ0l+JA20tKoRTqcrCJnHeomP3OrayErUylUXTe7Djga/6v18vIWth305fLVn9r2S+n7r7gA==
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr15911537wro.190.1565009680767;
        Mon, 05 Aug 2019 05:54:40 -0700 (PDT)
Received: from orion.maiolino.org (11.72.broadband12.iol.cz. [90.179.72.11])
        by smtp.gmail.com with ESMTPSA id f1sm57936530wml.28.2019.08.05.05.54.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:54:40 -0700 (PDT)
Date:   Mon, 5 Aug 2019 14:54:38 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Damien.LeMoal@wdc.com,
        Christoph Hellwig <hch@lst.de>, agruenba@redhat.com
Subject: Re: [PATCH 3/5] xfs: remove the fork fields in the writepage_ctx and
 ioend
Message-ID: <20190805125438.va6qirxxhmr2isa4@orion.maiolino.org>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Damien.LeMoal@wdc.com,
        Christoph Hellwig <hch@lst.de>, agruenba@redhat.com
References: <156444951713.2682520.8109813555788585092.stgit@magnolia>
 <156444954007.2682520.7677605159311778499.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156444954007.2682520.7677605159311778499.stgit@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:19:00PM -0700, Darrick J. Wong wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> In preparation for moving the writeback code to iomap.c, replace the
> XFS-specific COW fork concept with the iomap IOMAP_F_SHARED flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> ---
>  fs/xfs/xfs_aops.c |   42 ++++++++++++++++++++++--------------------
>  fs/xfs/xfs_aops.h |    2 +-
>  2 files changed, 23 insertions(+), 21 deletions(-)
> 
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 12f42922251c..93f1bf315585 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -23,7 +23,6 @@
>   */
>  struct xfs_writepage_ctx {
>  	struct iomap		iomap;
> -	int			fork;
>  	unsigned int		data_seq;
>  	unsigned int		cow_seq;
>  	struct xfs_ioend	*ioend;
> @@ -269,7 +268,7 @@ xfs_end_ioend(
>  	 */
>  	error = blk_status_to_errno(ioend->io_bio->bi_status);
>  	if (unlikely(error)) {
> -		if (ioend->io_fork == XFS_COW_FORK)
> +		if (ioend->io_flags & IOMAP_F_SHARED)
>  			xfs_reflink_cancel_cow_range(ip, offset, size, true);
>  		goto done;
>  	}
> @@ -277,7 +276,7 @@ xfs_end_ioend(
>  	/*
>  	 * Success: commit the COW or unwritten blocks if needed.
>  	 */
> -	if (ioend->io_fork == XFS_COW_FORK)
> +	if (ioend->io_flags & IOMAP_F_SHARED)
>  		error = xfs_reflink_end_cow(ip, offset, size);
>  	else if (ioend->io_type == IOMAP_UNWRITTEN)
>  		error = xfs_iomap_write_unwritten(ip, offset, size, false);
> @@ -301,7 +300,8 @@ xfs_ioend_can_merge(
>  {
>  	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
>  		return false;
> -	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
> +	if ((ioend->io_flags & IOMAP_F_SHARED) ^
> +	    (next->io_flags & IOMAP_F_SHARED))
>  		return false;
>  	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
>  	    (next->io_type == IOMAP_UNWRITTEN))
> @@ -408,7 +408,7 @@ xfs_end_bio(
>  	struct xfs_mount	*mp = ip->i_mount;
>  	unsigned long		flags;
>  
> -	if (ioend->io_fork == XFS_COW_FORK ||
> +	if ((ioend->io_flags & IOMAP_F_SHARED) ||
>  	    ioend->io_type == IOMAP_UNWRITTEN ||
>  	    ioend->io_private) {
>  		spin_lock_irqsave(&ip->i_ioend_lock, flags);
> @@ -439,7 +439,7 @@ xfs_imap_valid(
>  	 * covers the offset. Be careful to check this first because the caller
>  	 * can revalidate a COW mapping without updating the data seqno.
>  	 */
> -	if (wpc->fork == XFS_COW_FORK)
> +	if (wpc->iomap.flags & IOMAP_F_SHARED)
>  		return true;
>  
>  	/*
> @@ -469,6 +469,7 @@ static int
>  xfs_convert_blocks(
>  	struct xfs_writepage_ctx *wpc,
>  	struct xfs_inode	*ip,
> +	int			whichfork,
>  	loff_t			offset)
>  {
>  	int			error;
> @@ -480,8 +481,8 @@ xfs_convert_blocks(
>  	 * delalloc extent if free space is sufficiently fragmented.
>  	 */
>  	do {
> -		error = xfs_bmapi_convert_delalloc(ip, wpc->fork, offset,
> -				&wpc->iomap, wpc->fork == XFS_COW_FORK ?
> +		error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
> +				&wpc->iomap, whichfork == XFS_COW_FORK ?
>  					&wpc->cow_seq : &wpc->data_seq);
>  		if (error)
>  			return error;
> @@ -502,6 +503,7 @@ xfs_map_blocks(
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
>  	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
> +	int			whichfork = XFS_DATA_FORK;
>  	struct xfs_bmbt_irec	imap;
>  	struct xfs_iext_cursor	icur;
>  	int			retries = 0;
> @@ -550,7 +552,7 @@ xfs_map_blocks(
>  		wpc->cow_seq = READ_ONCE(ip->i_cowfp->if_seq);
>  		xfs_iunlock(ip, XFS_ILOCK_SHARED);
>  
> -		wpc->fork = XFS_COW_FORK;
> +		whichfork = XFS_COW_FORK;
>  		goto allocate_blocks;
>  	}
>  
> @@ -573,8 +575,6 @@ xfs_map_blocks(
>  	wpc->data_seq = READ_ONCE(ip->i_df.if_seq);
>  	xfs_iunlock(ip, XFS_ILOCK_SHARED);
>  
> -	wpc->fork = XFS_DATA_FORK;
> -
>  	/* landed in a hole or beyond EOF? */
>  	if (imap.br_startoff > offset_fsb) {
>  		imap.br_blockcount = imap.br_startoff - offset_fsb;
> @@ -599,10 +599,10 @@ xfs_map_blocks(
>  		goto allocate_blocks;
>  
>  	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0);
> -	trace_xfs_map_blocks_found(ip, offset, count, wpc->fork, &imap);
> +	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
>  	return 0;
>  allocate_blocks:
> -	error = xfs_convert_blocks(wpc, ip, offset);
> +	error = xfs_convert_blocks(wpc, ip, whichfork, offset);
>  	if (error) {
>  		/*
>  		 * If we failed to find the extent in the COW fork we might have
> @@ -611,7 +611,8 @@ xfs_map_blocks(
>  		 * the former case, but prevent additional retries to avoid
>  		 * looping forever for the latter case.
>  		 */
> -		if (error == -EAGAIN && wpc->fork == XFS_COW_FORK && !retries++)
> +		if (error == -EAGAIN && (wpc->iomap.flags & IOMAP_F_SHARED) &&
> +		    !retries++)
>  			goto retry;
>  		ASSERT(error != -EAGAIN);
>  		return error;
> @@ -622,7 +623,7 @@ xfs_map_blocks(
>  	 * original delalloc one.  Trim the return extent to the next COW
>  	 * boundary again to force a re-lookup.
>  	 */
> -	if (wpc->fork != XFS_COW_FORK && cow_fsb != NULLFILEOFF) {
> +	if (!(wpc->iomap.flags & IOMAP_F_SHARED) && cow_fsb != NULLFILEOFF) {
>  		loff_t		cow_offset = XFS_FSB_TO_B(mp, cow_fsb);
>  
>  		if (cow_offset < wpc->iomap.offset + wpc->iomap.length)
> @@ -631,7 +632,7 @@ xfs_map_blocks(
>  
>  	ASSERT(wpc->iomap.offset <= offset);
>  	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
> -	trace_xfs_map_blocks_alloc(ip, offset, count, wpc->fork, &imap);
> +	trace_xfs_map_blocks_alloc(ip, offset, count, whichfork, &imap);
>  	return 0;
>  }
>  
> @@ -665,14 +666,14 @@ xfs_submit_ioend(
>  	nofs_flag = memalloc_nofs_save();
>  
>  	/* Convert CoW extents to regular */
> -	if (!status && ioend->io_fork == XFS_COW_FORK) {
> +	if (!status && (ioend->io_flags & IOMAP_F_SHARED)) {
>  		status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
>  				ioend->io_offset, ioend->io_size);
>  	}
>  
>  	/* Reserve log space if we might write beyond the on-disk inode size. */
>  	if (!status &&
> -	    (ioend->io_fork == XFS_COW_FORK ||
> +	    ((ioend->io_flags & IOMAP_F_SHARED) ||
>  	     ioend->io_type != IOMAP_UNWRITTEN) &&
>  	    xfs_ioend_is_append(ioend) &&
>  	    !ioend->io_private)
> @@ -719,8 +720,8 @@ xfs_alloc_ioend(
>  
>  	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
>  	INIT_LIST_HEAD(&ioend->io_list);
> -	ioend->io_fork = wpc->fork;
>  	ioend->io_type = wpc->iomap.type;
> +	ioend->io_flags = wpc->iomap.flags;
>  	ioend->io_inode = inode;
>  	ioend->io_size = 0;
>  	ioend->io_offset = offset;
> @@ -774,7 +775,8 @@ xfs_add_to_ioend(
>  	bool			merged, same_page = false;
>  
>  	if (!wpc->ioend ||
> -	    wpc->fork != wpc->ioend->io_fork ||
> +	    (wpc->iomap.flags & IOMAP_F_SHARED) !=
> +	    (wpc->ioend->io_flags & IOMAP_F_SHARED) ||
>  	    wpc->iomap.type != wpc->ioend->io_type ||
>  	    sector != bio_end_sector(wpc->ioend->io_bio) ||
>  	    offset != wpc->ioend->io_offset + wpc->ioend->io_size) {
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index 6a45d675dcba..4a0226cdad4f 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -13,8 +13,8 @@ extern struct bio_set xfs_ioend_bioset;
>   */
>  struct xfs_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
> -	int			io_fork;	/* inode fork written back */
>  	u16			io_type;
> +	u16			io_flags;	/* IOMAP_F_* */
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	xfs_off_t		io_offset;	/* offset in the file */
> 

-- 
Carlos
