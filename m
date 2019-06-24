Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAAF50F56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfFXO5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:57:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFXO5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:57:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OEmwk1147744;
        Mon, 24 Jun 2019 14:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vf38MUSviZWXpFFR8zJqdfyvFiALTqyaKIAiW4IsZV8=;
 b=s4kRuya+oMnIKkUZwwbq3syP47ugfDN24rX/YobrHYymBFWm4hO36700Mwtj6FiCx+YD
 pwxsMt32ScfTgY9M0jlcH9AdzTGMJWuqN8qZDnh/EFCGnYpgIqup4oWQ/bTQYHqbjc7H
 d71vfRwA4Pp9Bv3PZ1jOMrnlSr0YUM22+cVqS4gol1DXCJzhPqrVgvfJiBUmtqw6xiFN
 xHil8CH6G8fvZOdk/rDI2OAxPI5ty2HFN69q3dRrws+5L2/oFKEzH6eOcAB/bcMmMRr8
 YSzuSBIIge64L6dl0kImWkbLg2YFb3XkUXydryssUCYNRB/L/pf/76vZv9VTi3AWer2K vQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t9c9pew80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 14:57:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OEtoMq037995;
        Mon, 24 Jun 2019 14:57:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t99f3apn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 14:57:10 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5OEv9Pu006338;
        Mon, 24 Jun 2019 14:57:09 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 07:57:08 -0700
Date:   Mon, 24 Jun 2019 07:57:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] xfs: initialize ioma->flags in xfs_bmbt_to_iomap
Message-ID: <20190624145707.GH5387@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:45AM +0200, Christoph Hellwig wrote:
> Currently we don't overwrite the flags field in the iomap in
> xfs_bmbt_to_iomap.  This works fine with 0-initialized iomaps on stack,
> but is harmful once we want to be able to reuse an iomap in the
> writeback code.

Is that going to affect all the other iomap users, or is xfs the only
one that assumes zero-initialized iomaps being passed into
->iomap_begin?

--D

> Replace the shared paramter with a set of initial
> flags an thus ensures the flags field is always reinitialized.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c | 28 +++++++++++++++++-----------
>  fs/xfs/xfs_iomap.h |  2 +-
>  fs/xfs/xfs_pnfs.c  |  2 +-
>  3 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 63d323916bba..6b29452bfba0 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -57,7 +57,7 @@ xfs_bmbt_to_iomap(
>  	struct xfs_inode	*ip,
>  	struct iomap		*iomap,
>  	struct xfs_bmbt_irec	*imap,
> -	bool			shared)
> +	u16			flags)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  
> @@ -82,12 +82,11 @@ xfs_bmbt_to_iomap(
>  	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
>  	iomap->bdev = xfs_find_bdev_for_inode(VFS_I(ip));
>  	iomap->dax_dev = xfs_find_daxdev_for_inode(VFS_I(ip));
> +	iomap->flags = flags;
>  
>  	if (xfs_ipincount(ip) &&
>  	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
>  		iomap->flags |= IOMAP_F_DIRTY;
> -	if (shared)
> -		iomap->flags |= IOMAP_F_SHARED;
>  	return 0;
>  }
>  
> @@ -543,6 +542,7 @@ xfs_file_iomap_begin_delay(
>  	struct xfs_iext_cursor	icur, ccur;
>  	xfs_fsblock_t		prealloc_blocks = 0;
>  	bool			eof = false, cow_eof = false, shared = false;
> +	u16			iomap_flags = 0;
>  	int			whichfork = XFS_DATA_FORK;
>  	int			error = 0;
>  
> @@ -710,7 +710,7 @@ xfs_file_iomap_begin_delay(
>  	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
>  	 * them out if the write happens to fail.
>  	 */
> -	iomap->flags |= IOMAP_F_NEW;
> +	iomap_flags |= IOMAP_F_NEW;
>  	trace_xfs_iomap_alloc(ip, offset, count, whichfork,
>  			whichfork == XFS_DATA_FORK ? &imap : &cmap);
>  done:
> @@ -718,14 +718,17 @@ xfs_file_iomap_begin_delay(
>  		if (imap.br_startoff > offset_fsb) {
>  			xfs_trim_extent(&cmap, offset_fsb,
>  					imap.br_startoff - offset_fsb);
> -			error = xfs_bmbt_to_iomap(ip, iomap, &cmap, true);
> +			error = xfs_bmbt_to_iomap(ip, iomap, &cmap,
> +					IOMAP_F_SHARED);
>  			goto out_unlock;
>  		}
>  		/* ensure we only report blocks we have a reservation for */
>  		xfs_trim_extent(&imap, cmap.br_startoff, cmap.br_blockcount);
>  		shared = true;
>  	}
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
> +	if (shared)
> +		iomap_flags |= IOMAP_F_SHARED;
> +	error = xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
>  out_unlock:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	return error;
> @@ -933,6 +936,7 @@ xfs_file_iomap_begin(
>  	xfs_fileoff_t		offset_fsb, end_fsb;
>  	int			nimaps = 1, error = 0;
>  	bool			shared = false;
> +	u16			iomap_flags = 0;
>  	unsigned		lockmode;
>  
>  	if (XFS_FORCED_SHUTDOWN(mp))
> @@ -1048,11 +1052,13 @@ xfs_file_iomap_begin(
>  	if (error)
>  		return error;
>  
> -	iomap->flags |= IOMAP_F_NEW;
> +	iomap_flags |= IOMAP_F_NEW;
>  	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
>  
>  out_finish:
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
> +	if (shared)
> +		iomap_flags |= IOMAP_F_SHARED;
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
>  
>  out_found:
>  	ASSERT(nimaps);
> @@ -1196,7 +1202,7 @@ xfs_seek_iomap_begin(
>  		if (data_fsb < cow_fsb + cmap.br_blockcount)
>  			end_fsb = min(end_fsb, data_fsb);
>  		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
> -		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, true);
> +		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
>  		/*
>  		 * This is a COW extent, so we must probe the page cache
>  		 * because there could be dirty page cache being backed
> @@ -1218,7 +1224,7 @@ xfs_seek_iomap_begin(
>  	imap.br_state = XFS_EXT_NORM;
>  done:
>  	xfs_trim_extent(&imap, offset_fsb, end_fsb);
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, false);
> +	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
>  out_unlock:
>  	xfs_iunlock(ip, lockmode);
>  	return error;
> @@ -1264,7 +1270,7 @@ xfs_xattr_iomap_begin(
>  	if (error)
>  		return error;
>  	ASSERT(nimaps);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, false);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
>  }
>  
>  const struct iomap_ops xfs_xattr_iomap_ops = {
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 5c2f6aa6d78f..71d0ae460c44 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -16,7 +16,7 @@ int xfs_iomap_write_direct(struct xfs_inode *, xfs_off_t, size_t,
>  int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
>  
>  int xfs_bmbt_to_iomap(struct xfs_inode *, struct iomap *,
> -		struct xfs_bmbt_irec *, bool shared);
> +		struct xfs_bmbt_irec *, u16);
>  xfs_extlen_t xfs_eof_alignment(struct xfs_inode *ip, xfs_extlen_t extsize);
>  
>  static inline xfs_filblks_t
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index bde2c9f56a46..12f664785248 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -185,7 +185,7 @@ xfs_fs_map_blocks(
>  	}
>  	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
>  
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, false);
> +	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
>  	*device_generation = mp->m_generation;
>  	return error;
>  out_unlock:
> -- 
> 2.20.1
> 
