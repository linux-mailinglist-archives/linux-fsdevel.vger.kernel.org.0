Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84326B6A37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfIRSGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 14:06:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55344 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfIRSGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:06:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHx3VU117152;
        Wed, 18 Sep 2019 18:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=nyN5Fr4+cxFEk3kASyO5Cbd+n1VUn3Co5xpoRfdP74g=;
 b=CR/rCqJd9oTfnBmWL+f30LwjMKb1bytiKJrj4Bti0wWfWzN1bS9dqJxoy/5bk0t4g1ZS
 uE7OTEZO4op6kGPRCt+RdvOauwLQO9BvuOfLv/IM5A2NayiEBYYAYtjDydg5M1bm6Ii4
 Sj/d3YiIHWlTbJBbWuSNmzlHd22/o340wD3Yc570nF6/KIKLV7RxvY5SX19HHgR2syL7
 00pz+8nHz4xBzhvPwqjqtrxgX5T6YWgZZ6l9wAwKqFCKHW+faerGZgdi5/miJJHz3Iyg
 3mdp9YXLnvCGzRBZ2cUj6jVYVoFO8w2ytEMtHRCIguAQV//pgAK0VqXGnVLze0gcR0qf Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2v385dwmeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 18:06:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8II3fb4038239;
        Wed, 18 Sep 2019 18:06:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2v37mn2tpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 18:06:09 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8II68mw013641;
        Wed, 18 Sep 2019 18:06:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 11:06:08 -0700
Date:   Wed, 18 Sep 2019 11:06:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/19] xfs: cleanup xfs_iomap_write_unwritten
Message-ID: <20190918180607.GK2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-19-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180161
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:21PM +0200, Christoph Hellwig wrote:
> Move more checks into the helpers that determine if we need a COW
> operation or allocation and split the return path for when an existing
> data for allocation has been found versus a new allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_iomap.c | 74 ++++++++++++++++++++++++----------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 0e575ca1e3fc..e4e79aa5b695 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -642,23 +642,42 @@ xfs_iomap_write_unwritten(
>  static inline bool
>  imap_needs_alloc(
>  	struct inode		*inode,
> +	unsigned		flags,
>  	struct xfs_bmbt_irec	*imap,
>  	int			nimaps)
>  {
> -	return !nimaps ||
> -		imap->br_startblock == HOLESTARTBLOCK ||
> -		imap->br_startblock == DELAYSTARTBLOCK ||
> -		(IS_DAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN);
> +	/* don't allocate blocks when just zeroing */
> +	if (flags & IOMAP_ZERO)
> +		return false;
> +	if (!nimaps ||
> +	    imap->br_startblock == HOLESTARTBLOCK ||
> +	    imap->br_startblock == DELAYSTARTBLOCK)
> +		return true;
> +	/* we convert unwritten extents before copying the data for DAX */
> +	if (IS_DAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN)
> +		return true;
> +	return false;
>  }
>  
>  static inline bool
> -needs_cow_for_zeroing(
> +imap_needs_cow(
> +	struct xfs_inode	*ip,
>  	struct xfs_bmbt_irec	*imap,
> +	unsigned int		flags,
>  	int			nimaps)
>  {
> -	return nimaps &&
> -		imap->br_startblock != HOLESTARTBLOCK &&
> -		imap->br_state != XFS_EXT_UNWRITTEN;
> +	if (!xfs_is_cow_inode(ip))
> +		return false;
> +
> +	/* when zeroing we don't have to COW holes or unwritten extents */
> +	if (flags & IOMAP_ZERO) {
> +		if (!nimaps ||
> +		    imap->br_startblock == HOLESTARTBLOCK ||
> +		    imap->br_state == XFS_EXT_UNWRITTEN)
> +			return false;
> +	}
> +
> +	return true;
>  }
>  
>  static int
> @@ -734,7 +753,6 @@ xfs_direct_write_iomap_begin(
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
>  	int			nimaps = 1, error = 0;
>  	bool			shared = false;
> -	u16			iomap_flags = 0;
>  	unsigned		lockmode;
>  
>  	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
> @@ -761,12 +779,7 @@ xfs_direct_write_iomap_begin(
>  	 * Break shared extents if necessary. Checks for non-blocking IO have
>  	 * been done up front, so we don't need to do them here.
>  	 */
> -	if (xfs_is_cow_inode(ip)) {
> -		/* if zeroing doesn't need COW allocation, then we are done. */
> -		if ((flags & IOMAP_ZERO) &&
> -		    !needs_cow_for_zeroing(&imap, nimaps))
> -			goto out_found;
> -
> +	if (imap_needs_cow(ip, &imap, flags, nimaps)) {
>  		/* may drop and re-acquire the ilock */
>  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
>  				&lockmode, flags & IOMAP_DIRECT);
> @@ -778,18 +791,17 @@ xfs_direct_write_iomap_begin(
>  		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>  	}
>  
> -	/* Don't need to allocate over holes when doing zeroing operations. */
> -	if (flags & IOMAP_ZERO)
> -		goto out_found;
> +	if (imap_needs_alloc(inode, flags, &imap, nimaps))
> +		goto allocate_blocks;
>  
> -	if (!imap_needs_alloc(inode, &imap, nimaps))
> -		goto out_found;
> +	xfs_iunlock(ip, lockmode);
> +	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
>  
> -	/* If nowait is set bail since we are going to make allocations. */
> -	if (flags & IOMAP_NOWAIT) {
> -		error = -EAGAIN;
> +allocate_blocks:
> +	error = -EAGAIN;
> +	if (flags & IOMAP_NOWAIT)
>  		goto out_unlock;
> -	}
>  
>  	/*
>  	 * We cap the maximum length we map to a sane size  to keep the chunks
> @@ -808,22 +820,12 @@ xfs_direct_write_iomap_begin(
>  	 */
>  	if (lockmode == XFS_ILOCK_EXCL)
>  		xfs_ilock_demote(ip, lockmode);
> -	error = xfs_iomap_write_direct(ip, offset, length, &imap,
> -			nimaps);
> +	error = xfs_iomap_write_direct(ip, offset, length, &imap, nimaps);
>  	if (error)
>  		return error;
>  
> -	iomap_flags |= IOMAP_F_NEW;
>  	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
> -
> -out_finish:
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
> -
> -out_found:
> -	ASSERT(nimaps);
> -	xfs_iunlock(ip, lockmode);
> -	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
> -	goto out_finish;
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
>  
>  out_found_cow:
>  	xfs_iunlock(ip, lockmode);
> -- 
> 2.20.1
> 
