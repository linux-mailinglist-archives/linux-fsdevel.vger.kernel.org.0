Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF13B6A2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 20:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfIRSBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 14:01:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfIRSBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:01:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHx5W1103972;
        Wed, 18 Sep 2019 18:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=IZbo1bEvR/pxP+73Pkwtv4D4nBc99+QpAuvKTftncwM=;
 b=EM7nAC3DDCMQbuC+BuYB21AhtjxYvwHHJLt5Aij5VHETiNOylJXNUHrTAaND4XCutGSv
 2bCbn0PFrEjQqAP8UwPcRDbKsHnjtNF/i5dt37MzLUE+Jb3biLzpRoUJPTpmusSn19qJ
 Rl8vlKtFFY1aiResx8CHNbIcryZvmqMhBBes4Vw7c5UO4cNgS6y2bm4Te5MTY1c+IDaj
 +xZw6fKJt3UBvSu7LL7Z0hu1zeRXSC6Zu6lO98dndOBGBDkh2m2+foHkkgtKLlHQeg0g
 QdpFREqtuTj0Zw2wS1wX2s4PkUB23PSBggjc37H6L5tfERV9dBNG2j8trG3ihld9TGZD 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v385dwmx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 18:01:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHcJBN172486;
        Wed, 18 Sep 2019 18:01:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2v37mn2j9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 18:01:00 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8II0xVS010218;
        Wed, 18 Sep 2019 18:01:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 11:00:59 -0700
Date:   Wed, 18 Sep 2019 11:00:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/19] xfs: rename the whichfork variable in
 xfs_buffered_write_iomap_begin
Message-ID: <20190918180058.GJ2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-18-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180160
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

On Mon, Sep 09, 2019 at 08:27:20PM +0200, Christoph Hellwig wrote:
> Renaming whichfork to allocfork in xfs_buffered_write_iomap_begin makes
> the usage of this variable a little more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_iomap.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 6dd143374d75..0e575ca1e3fc 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -862,7 +862,7 @@ xfs_buffered_write_iomap_begin(
>  	struct xfs_iext_cursor	icur, ccur;
>  	xfs_fsblock_t		prealloc_blocks = 0;
>  	bool			eof = false, cow_eof = false, shared = false;
> -	int			whichfork = XFS_DATA_FORK;
> +	int			allocfork = XFS_DATA_FORK;
>  	int			error = 0;
>  
>  	/* we can't use delayed allocations when using extent size hints */
> @@ -959,7 +959,7 @@ xfs_buffered_write_iomap_begin(
>  		 * Fork all the shared blocks from our write offset until the
>  		 * end of the extent.
>  		 */
> -		whichfork = XFS_COW_FORK;
> +		allocfork = XFS_COW_FORK;
>  		end_fsb = imap.br_startoff + imap.br_blockcount;
>  	} else {
>  		/*
> @@ -975,7 +975,7 @@ xfs_buffered_write_iomap_begin(
>  		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>  
>  		if (xfs_is_always_cow_inode(ip))
> -			whichfork = XFS_COW_FORK;
> +			allocfork = XFS_COW_FORK;
>  	}
>  
>  	error = xfs_qm_dqattach_locked(ip, false);
> @@ -983,7 +983,7 @@ xfs_buffered_write_iomap_begin(
>  		goto out_unlock;
>  
>  	if (eof) {
> -		prealloc_blocks = xfs_iomap_prealloc_size(ip, whichfork, offset,
> +		prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork, offset,
>  				count, &icur);
>  		if (prealloc_blocks) {
>  			xfs_extlen_t	align;
> @@ -1006,11 +1006,11 @@ xfs_buffered_write_iomap_begin(
>  	}
>  
>  retry:
> -	error = xfs_bmapi_reserve_delalloc(ip, whichfork, offset_fsb,
> +	error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
>  			end_fsb - offset_fsb, prealloc_blocks,
> -			whichfork == XFS_DATA_FORK ? &imap : &cmap,
> -			whichfork == XFS_DATA_FORK ? &icur : &ccur,
> -			whichfork == XFS_DATA_FORK ? eof : cow_eof);
> +			allocfork == XFS_DATA_FORK ? &imap : &cmap,
> +			allocfork == XFS_DATA_FORK ? &icur : &ccur,
> +			allocfork == XFS_DATA_FORK ? eof : cow_eof);
>  	switch (error) {
>  	case 0:
>  		break;
> @@ -1027,8 +1027,8 @@ xfs_buffered_write_iomap_begin(
>  		goto out_unlock;
>  	}
>  
> -	if (whichfork == XFS_COW_FORK) {
> -		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
> +	if (allocfork == XFS_COW_FORK) {
> +		trace_xfs_iomap_alloc(ip, offset, count, allocfork, &cmap);
>  		goto found_cow;
>  	}
>  
> @@ -1037,7 +1037,7 @@ xfs_buffered_write_iomap_begin(
>  	 * them out if the write happens to fail.
>  	 */
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -	trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
> +	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
>  
>  found_imap:
> -- 
> 2.20.1
> 
