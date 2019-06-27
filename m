Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C4A58DF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 00:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF0Waz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 18:30:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0Waz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:30:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RMUYwf007799;
        Thu, 27 Jun 2019 22:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=CXr3iKkSmSQSIcXuq9VIyjsTo6qK3758OvE/A9ICWUc=;
 b=MvgBepWika6C9lF7+24nwJWkhsnm6Z0N+oSpolFKYLudD3i+jJFaKrKcugAC42pHbFrl
 YRylsPVdD0AjWlymBxwgQfmphzfVa1V5GgAJNn9u4b3+ngddBiA1yWC1K6aSEF7fzNyf
 YOppxBS3CcslUB6p8QACsZI/iRLxlW/WM+ouJj0QefyhtOGJ+0H9DBBEVOkiE0I2poGc
 bBTxzOpZWNHXm3YoMbjojUEtilPRsmG3vdBMYnlMKTw11nDNwawgOvOqT0x9wHwrfStC
 qSY3OP20fTeZ6ecyFQhy+HBBZXDPqSEVgdpFqiV29GA/0zH9cXBjFZkwPE9L9lHQtj5t pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brtjrkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 22:30:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RMTo7l007786;
        Thu, 27 Jun 2019 22:30:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9acdgmjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 22:30:32 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5RMUUi9013338;
        Thu, 27 Jun 2019 22:30:30 GMT
Received: from localhost (/10.145.179.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 15:30:30 -0700
Date:   Thu, 27 Jun 2019 15:30:30 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] xfs: remove XFS_TRANS_NOFS
Message-ID: <20190627223030.GS5171@magnolia>
References: <20190627104836.25446-1-hch@lst.de>
 <20190627104836.25446-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627104836.25446-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270259
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270260
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 12:48:29PM +0200, Christoph Hellwig wrote:
> Instead of a magic flag for xfs_trans_alloc, just ensure all callers
> that can't relclaim through the file system use memalloc_nofs_save to
> set the per-task nofs flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/libxfs/xfs_shared.h |  1 -
>  fs/xfs/xfs_aops.c          | 35 ++++++++++++++++++++++-------------
>  fs/xfs/xfs_file.c          | 12 +++++++++---
>  fs/xfs/xfs_iomap.c         |  2 +-
>  fs/xfs/xfs_reflink.c       |  4 ++--
>  fs/xfs/xfs_trans.c         |  4 +---
>  6 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
> index b9094709bc79..c45acbd3add9 100644
> --- a/fs/xfs/libxfs/xfs_shared.h
> +++ b/fs/xfs/libxfs/xfs_shared.h
> @@ -65,7 +65,6 @@ void	xfs_log_get_max_trans_res(struct xfs_mount *mp,
>  #define XFS_TRANS_DQ_DIRTY	0x10	/* at least one dquot in trx dirty */
>  #define XFS_TRANS_RESERVE	0x20    /* OK to use reserved data blocks */
>  #define XFS_TRANS_NO_WRITECOUNT 0x40	/* do not elevate SB writecount */
> -#define XFS_TRANS_NOFS		0x80	/* pass KM_NOFS to kmem_alloc */
>  /*
>   * LOWMODE is used by the allocator to activate the lowspace algorithm - when
>   * free space is running low the extent allocator may choose to allocate an
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 243548b9d0cc..8b3070a40245 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -138,8 +138,7 @@ xfs_setfilesize_trans_alloc(
>  	struct xfs_trans	*tp;
>  	int			error;
>  
> -	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0,
> -				XFS_TRANS_NOFS, &tp);
> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
>  	if (error)
>  		return error;
>  
> @@ -240,8 +239,16 @@ xfs_end_ioend(
>  	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
>  	xfs_off_t		offset = ioend->io_offset;
>  	size_t			size = ioend->io_size;
> +	unsigned int		nofs_flag;
>  	int			error;
>  
> +	/*
> +	 * We can do memory allocation here, but aren't in transactional
> +	 * context.  To avoid memory allocation deadlocks set the task-wide
> +	 * nofs context for the following operations.

I think the wording of this is too indirect.  The reason we need to set
NOFS is because we could be doing writeback as part of reclaiming
memory, which means that we cannot recurse back into filesystems to
satisfy the memory allocation needed to create a transaction.  The NOFS
part applies to any memory allocation, of course.

If you're fine with the wording below I'll just edit that into the
patch:

	/*
	 * We can allocate memory here while doing writeback on behalf of
	 * memory reclaim.  To avoid memory allocation deadlocks set the
	 * task-wide nofs context for the following operations.
	 */
	nofs_flag = memalloc_nofs_save();

> +	 */
> +	nofs_flag = memalloc_nofs_save();
> +
>  	/*
>  	 * Just clean up the in-memory strutures if the fs has been shut down.
>  	 */
> @@ -282,6 +289,8 @@ xfs_end_ioend(
>  		list_del_init(&ioend->io_list);
>  		xfs_destroy_ioend(ioend, error);
>  	}
> +
> +	memalloc_nofs_restore(nofs_flag);
>  }
>  
>  /*
> @@ -641,21 +650,19 @@ xfs_submit_ioend(
>  	struct xfs_ioend	*ioend,
>  	int			status)
>  {
> +	unsigned int		nofs_flag;
> +
> +	/*
> +	 * We can do memory allocation here, but aren't in transactional
> +	 * context.  To avoid memory allocation deadlocks set the task-wide
> +	 * nofs context for the following operations.
> +	 */
> +	nofs_flag = memalloc_nofs_save();
> +
>  	/* Convert CoW extents to regular */
>  	if (!status && ioend->io_fork == XFS_COW_FORK) {
> -		/*
> -		 * Yuk. This can do memory allocation, but is not a
> -		 * transactional operation so everything is done in GFP_KERNEL
> -		 * context. That can deadlock, because we hold pages in
> -		 * writeback state and GFP_KERNEL allocations can block on them.
> -		 * Hence we must operate in nofs conditions here.
> -		 */
> -		unsigned nofs_flag;
> -
> -		nofs_flag = memalloc_nofs_save();
>  		status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
>  				ioend->io_offset, ioend->io_size);
> -		memalloc_nofs_restore(nofs_flag);
>  	}
>  
>  	/* Reserve log space if we might write beyond the on-disk inode size. */
> @@ -666,6 +673,8 @@ xfs_submit_ioend(
>  	    !ioend->io_append_trans)
>  		status = xfs_setfilesize_trans_alloc(ioend);
>  
> +	memalloc_nofs_restore(nofs_flag);
> +
>  	ioend->io_bio->bi_private = ioend;
>  	ioend->io_bio->bi_end_io = xfs_end_bio;
>  
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 916a35cae5e9..f2d806ef8f06 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -379,6 +379,7 @@ xfs_dio_write_end_io(
>  	struct inode		*inode = file_inode(iocb->ki_filp);
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	loff_t			offset = iocb->ki_pos;
> +	unsigned int		nofs_flag;
>  	int			error = 0;
>  
>  	trace_xfs_end_io_direct_write(ip, offset, size);
> @@ -395,10 +396,11 @@ xfs_dio_write_end_io(
>  	 */
>  	XFS_STATS_ADD(ip->i_mount, xs_write_bytes, size);
>  
> +	nofs_flag = memalloc_nofs_save();

Hmm, do we need this here?  I can't remember if there was a need for
setting NOFS under xfs_reflink_end_cow from a dio completion or if that
was purely the buffered writeback case...

--D

>  	if (flags & IOMAP_DIO_COW) {
>  		error = xfs_reflink_end_cow(ip, offset, size);
>  		if (error)
> -			return error;
> +			goto out;
>  	}
>  
>  	/*
> @@ -407,8 +409,10 @@ xfs_dio_write_end_io(
>  	 * earlier allows a racing dio read to find unwritten extents before
>  	 * they are converted.
>  	 */
> -	if (flags & IOMAP_DIO_UNWRITTEN)
> -		return xfs_iomap_write_unwritten(ip, offset, size, true);
> +	if (flags & IOMAP_DIO_UNWRITTEN) {
> +		error = xfs_iomap_write_unwritten(ip, offset, size, true);
> +		goto out;
> +	}
>  
>  	/*
>  	 * We need to update the in-core inode size here so that we don't end up
> @@ -430,6 +434,8 @@ xfs_dio_write_end_io(
>  		spin_unlock(&ip->i_flags_lock);
>  	}
>  
> +out:
> +	memalloc_nofs_restore(nofs_flag);
>  	return error;
>  }
>  
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 6b29452bfba0..461ea023b910 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -782,7 +782,7 @@ xfs_iomap_write_unwritten(
>  		 * complete here and might deadlock on the iolock.
>  		 */
>  		error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
> -				XFS_TRANS_RESERVE | XFS_TRANS_NOFS, &tp);
> +				XFS_TRANS_RESERVE, &tp);
>  		if (error)
>  			return error;
>  
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 680ae7662a78..0b23c2b29609 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -572,7 +572,7 @@ xfs_reflink_cancel_cow_range(
>  
>  	/* Start a rolling transaction to remove the mappings */
>  	error = xfs_trans_alloc(ip->i_mount, &M_RES(ip->i_mount)->tr_write,
> -			0, 0, XFS_TRANS_NOFS, &tp);
> +			0, 0, 0, &tp);
>  	if (error)
>  		goto out;
>  
> @@ -631,7 +631,7 @@ xfs_reflink_end_cow_extent(
>  
>  	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
>  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
> -			XFS_TRANS_RESERVE | XFS_TRANS_NOFS, &tp);
> +			XFS_TRANS_RESERVE, &tp);
>  	if (error)
>  		return error;
>  
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index b026f87608ce..2ad3faa12206 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -264,9 +264,7 @@ xfs_trans_alloc(
>  	 * GFP_NOFS allocation context so that we avoid lockdep false positives
>  	 * by doing GFP_KERNEL allocations inside sb_start_intwrite().
>  	 */
> -	tp = kmem_zone_zalloc(xfs_trans_zone,
> -		(flags & XFS_TRANS_NOFS) ? KM_NOFS : KM_SLEEP);
> -
> +	tp = kmem_zone_zalloc(xfs_trans_zone, KM_SLEEP);
>  	if (!(flags & XFS_TRANS_NO_WRITECOUNT))
>  		sb_start_intwrite(mp->m_super);
>  
> -- 
> 2.20.1
> 
