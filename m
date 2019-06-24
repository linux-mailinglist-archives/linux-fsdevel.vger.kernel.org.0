Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2E51810
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfFXQJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 12:09:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53918 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfFXQJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:09:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OFxEFo102550;
        Mon, 24 Jun 2019 16:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xaAR1E4Fxz0Cts7pE7vSewbijB30THeaBrz9cGPEzU0=;
 b=EMnzYG7oVb8IMIJ3tAV/ebbrfMQwaICcRVmRJqEVySShYYAXJab8SE5BIv0/ICZTM31k
 wrQah8bDuEvgoahnj7t1SGz5f3SOnUryh/N3bS/t7aBKfwEyTUAZZn2eG619q8DuKDHI
 ZNa7vAMZXkGcpIBDK3tCFFK7yyL7Qu4nELk+xt+bsM0u4Q53GmSRhpbO3ZqSoEj4jKgM
 C//Ig6G/Z85Up0BAdn0x0MbKWPV+vYYxZNhNlt0ZyTg2oWd/MWPk2eJU5W6tOGxyMM6n
 qaXlZwFcRxPKM/WYG7SrRvNWX5wo9e8DaBxSvvYc20oTNJzmUnTpiCi2I1EAsDLMH/KH tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brsycdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:08:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OG7oQP047075;
        Mon, 24 Jun 2019 16:08:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t99f3byvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:08:41 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OG8ec2030270;
        Mon, 24 Jun 2019 16:08:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 09:08:40 -0700
Date:   Mon, 24 Jun 2019 09:08:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] xfs: remove the fork fields in the writepage_ctx
 and ioend
Message-ID: <20190624160839.GP5387@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-11-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240128
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:51AM +0200, Christoph Hellwig wrote:
> In preparation for moving the writeback code to iomap.c, replace the
> XFS-specific COW fork concept with the iomap IOMAP_F_SHARED flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c | 40 +++++++++++++++++++++-------------------
>  fs/xfs/xfs_aops.h |  2 +-
>  2 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 5d302ebe2a33..d9a7a9e6b912 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -28,7 +28,6 @@
>   */
>  struct xfs_writepage_ctx {
>  	struct iomap		iomap;
> -	int			fork;
>  	unsigned int		data_seq;
>  	unsigned int		cow_seq;
>  	struct xfs_ioend	*ioend;
> @@ -204,7 +203,7 @@ xfs_end_ioend(
>  	 */
>  	error = blk_status_to_errno(ioend->io_bio->bi_status);
>  	if (unlikely(error)) {
> -		if (ioend->io_fork == XFS_COW_FORK)
> +		if (ioend->io_flags & IOMAP_F_SHARED)
>  			xfs_reflink_cancel_cow_range(ip, offset, size, true);
>  		goto done;
>  	}
> @@ -212,7 +211,7 @@ xfs_end_ioend(
>  	/*
>  	 * Success: commit the COW or unwritten blocks if needed.
>  	 */
> -	if (ioend->io_fork == XFS_COW_FORK)
> +	if (ioend->io_flags & IOMAP_F_SHARED)
>  		error = xfs_reflink_end_cow(ip, offset, size);
>  	else if (ioend->io_type == IOMAP_UNWRITTEN)
>  		error = xfs_iomap_write_unwritten(ip, offset, size, false);
> @@ -233,7 +232,8 @@ xfs_ioend_can_merge(
>  {
>  	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
>  		return false;
> -	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
> +	if ((ioend->io_flags & IOMAP_F_SHARED) ^
> +	    (next->io_flags & IOMAP_F_SHARED))
>  		return false;
>  	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
>  	    (next->io_type == IOMAP_UNWRITTEN))
> @@ -319,7 +319,7 @@ xfs_end_bio(
>  	struct xfs_mount	*mp = ip->i_mount;
>  	unsigned long		flags;
>  
> -	if (ioend->io_fork == XFS_COW_FORK ||
> +	if ((ioend->io_flags & IOMAP_F_SHARED) ||
>  	    ioend->io_type == IOMAP_UNWRITTEN ||
>  	    xfs_ioend_is_append(ioend)) {
>  		spin_lock_irqsave(&ip->i_ioend_lock, flags);
> @@ -350,7 +350,7 @@ xfs_imap_valid(
>  	 * covers the offset. Be careful to check this first because the caller
>  	 * can revalidate a COW mapping without updating the data seqno.
>  	 */
> -	if (wpc->fork == XFS_COW_FORK)
> +	if (wpc->iomap.flags & IOMAP_F_SHARED)
>  		return true;
>  
>  	/*
> @@ -380,6 +380,7 @@ static int
>  xfs_convert_blocks(
>  	struct xfs_writepage_ctx *wpc,
>  	struct xfs_inode	*ip,
> +	int			whichfork,
>  	loff_t			offset)
>  {
>  	int			error;
> @@ -391,8 +392,8 @@ xfs_convert_blocks(
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
> @@ -413,6 +414,7 @@ xfs_map_blocks(
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
>  	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
> +	int			whichfork = XFS_DATA_FORK;
>  	struct xfs_bmbt_irec	imap;
>  	struct xfs_iext_cursor	icur;
>  	int			retries = 0;
> @@ -461,7 +463,7 @@ xfs_map_blocks(
>  		wpc->cow_seq = READ_ONCE(ip->i_cowfp->if_seq);
>  		xfs_iunlock(ip, XFS_ILOCK_SHARED);
>  
> -		wpc->fork = XFS_COW_FORK;
> +		whichfork = XFS_COW_FORK;
>  		goto allocate_blocks;
>  	}
>  
> @@ -484,8 +486,6 @@ xfs_map_blocks(
>  	wpc->data_seq = READ_ONCE(ip->i_df.if_seq);
>  	xfs_iunlock(ip, XFS_ILOCK_SHARED);
>  
> -	wpc->fork = XFS_DATA_FORK;
> -
>  	/* landed in a hole or beyond EOF? */
>  	if (imap.br_startoff > offset_fsb) {
>  		imap.br_blockcount = imap.br_startoff - offset_fsb;
> @@ -510,10 +510,10 @@ xfs_map_blocks(
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
> @@ -522,7 +522,8 @@ xfs_map_blocks(
>  		 * the former case, but prevent additional retries to avoid
>  		 * looping forever for the latter case.
>  		 */
> -		if (error == -EAGAIN && wpc->fork == XFS_COW_FORK && !retries++)
> +		if (error == -EAGAIN && (wpc->iomap.flags & IOMAP_F_SHARED) &&
> +		    !retries++)
>  			goto retry;
>  		ASSERT(error != -EAGAIN);
>  		return error;
> @@ -533,7 +534,7 @@ xfs_map_blocks(
>  	 * original delalloc one.  Trim the return extent to the next COW
>  	 * boundary again to force a re-lookup.
>  	 */
> -	if (wpc->fork != XFS_COW_FORK && cow_fsb != NULLFILEOFF) {
> +	if (!(wpc->iomap.flags & IOMAP_F_SHARED) && cow_fsb != NULLFILEOFF) {
>  		loff_t		cow_offset = XFS_FSB_TO_B(mp, cow_fsb);
>  
>  		if (cow_offset < wpc->iomap.offset + wpc->iomap.length)
> @@ -542,7 +543,7 @@ xfs_map_blocks(
>  
>  	ASSERT(wpc->iomap.offset <= offset);
>  	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
> -	trace_xfs_map_blocks_alloc(ip, offset, count, wpc->fork, &imap);
> +	trace_xfs_map_blocks_alloc(ip, offset, count, whichfork, &imap);
>  	return 0;
>  }
>  
> @@ -567,7 +568,7 @@ xfs_submit_ioend(
>  	int			status)
>  {
>  	/* Convert CoW extents to regular */
> -	if (!status && ioend->io_fork == XFS_COW_FORK) {
> +	if (!status && (ioend->io_flags & IOMAP_F_SHARED)) {
>  		/*
>  		 * Yuk. This can do memory allocation, but is not a
>  		 * transactional operation so everything is done in GFP_KERNEL
> @@ -621,8 +622,8 @@ xfs_alloc_ioend(
>  
>  	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
>  	INIT_LIST_HEAD(&ioend->io_list);
> -	ioend->io_fork = wpc->fork;
>  	ioend->io_type = wpc->iomap.type;
> +	ioend->io_flags = wpc->iomap.flags;
>  	ioend->io_inode = inode;
>  	ioend->io_size = 0;
>  	ioend->io_offset = offset;
> @@ -676,7 +677,8 @@ xfs_add_to_ioend(
>  	sector = (wpc->iomap.addr + offset - wpc->iomap.offset) >> 9;
>  
>  	if (!wpc->ioend ||
> -	    wpc->fork != wpc->ioend->io_fork ||
> +	    (wpc->iomap.flags & IOMAP_F_SHARED) !=
> +	    (wpc->ioend->io_flags & IOMAP_F_SHARED) ||
>  	    wpc->iomap.type != wpc->ioend->io_type ||
>  	    sector != bio_end_sector(wpc->ioend->io_bio) ||
>  	    offset != wpc->ioend->io_offset + wpc->ioend->io_size) {
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index 23c087f0bcbf..bf95837c59af 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -13,8 +13,8 @@ extern struct bio_set xfs_ioend_bioset;
>   */
>  struct xfs_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
> -	int			io_fork;	/* inode fork written back */
>  	u16			io_type;
> +	u16			io_flags;
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	xfs_off_t		io_offset;	/* offset in the file */
> -- 
> 2.20.1
> 
