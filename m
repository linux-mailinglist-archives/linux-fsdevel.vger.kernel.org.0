Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B04ACFD74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfJHPUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:20:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41496 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJHPUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:20:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FGDmx129867;
        Tue, 8 Oct 2019 15:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=642yCtgnZgHdh5fNCOen9zl/Y+SF8LYrhX2xizySqZg=;
 b=H+DkxC7PeXABOoFEEPLU7f00uD/WFCaNFf1rtdVUbkxnOt0t0/qHZwVwSM9WBDvp9y24
 SYj8uG26pHtKecak9Tunoh5gHIRZlUk24TFgiP6RdoQonr+oUXia8088uohdlEofNd7+
 t6a3XpQ4/zY9yafFDnkEvU/WyM7GI4RFrl/GwtqJaXwu2hBpv8WSxjru4D/Aq9RlEiFw
 GzdS6910W3549E6hSP+WtScWUys3jn0tbqKMd8l6013g+WCY2EBhc5UdqSM9X9DvhRDg
 p5/54N/2RU53sQj9RMrX5AXTJOEf4iwbN5iRKc7gNsxFKnJ8kU3GLLlE4K5F3TeVsn2t DA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vejkue2r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:20:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FF0SP196160;
        Tue, 8 Oct 2019 15:20:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vg1yw4mhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:20:30 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98FKTua012106;
        Tue, 8 Oct 2019 15:20:30 GMT
Received: from localhost (/10.159.136.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 08:20:29 -0700
Date:   Tue, 8 Oct 2019 08:20:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/20] xfs: remove xfs_reflink_dirty_extents
Message-ID: <20191008152028.GY13108@magnolia>
References: <20191008071527.29304-1-hch@lst.de>
 <20191008071527.29304-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008071527.29304-11-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080135
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:15:17AM +0200, Christoph Hellwig wrote:
> Now that xfs_file_unshare is not completely dumb we can just call it
> directly without iterating the extent and reflink btrees ourselves.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_reflink.c | 103 +++----------------------------------------
>  1 file changed, 5 insertions(+), 98 deletions(-)
> 
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index a9634110c783..7fc728a8852b 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1381,85 +1381,6 @@ xfs_reflink_remap_prep(
>  	return ret;
>  }
>  
> -/*
> - * The user wants to preemptively CoW all shared blocks in this file,
> - * which enables us to turn off the reflink flag.  Iterate all
> - * extents which are not prealloc/delalloc to see which ranges are
> - * mentioned in the refcount tree, then read those blocks into the
> - * pagecache, dirty them, fsync them back out, and then we can update
> - * the inode flag.  What happens if we run out of memory? :)
> - */
> -STATIC int
> -xfs_reflink_dirty_extents(
> -	struct xfs_inode	*ip,
> -	xfs_fileoff_t		fbno,
> -	xfs_filblks_t		end,
> -	xfs_off_t		isize)
> -{
> -	struct xfs_mount	*mp = ip->i_mount;
> -	xfs_agnumber_t		agno;
> -	xfs_agblock_t		agbno;
> -	xfs_extlen_t		aglen;
> -	xfs_agblock_t		rbno;
> -	xfs_extlen_t		rlen;
> -	xfs_off_t		fpos;
> -	xfs_off_t		flen;
> -	struct xfs_bmbt_irec	map[2];
> -	int			nmaps;
> -	int			error = 0;
> -
> -	while (end - fbno > 0) {
> -		nmaps = 1;
> -		/*
> -		 * Look for extents in the file.  Skip holes, delalloc, or
> -		 * unwritten extents; they can't be reflinked.
> -		 */
> -		error = xfs_bmapi_read(ip, fbno, end - fbno, map, &nmaps, 0);
> -		if (error)
> -			goto out;
> -		if (nmaps == 0)
> -			break;
> -		if (!xfs_bmap_is_real_extent(&map[0]))
> -			goto next;
> -
> -		map[1] = map[0];
> -		while (map[1].br_blockcount) {
> -			agno = XFS_FSB_TO_AGNO(mp, map[1].br_startblock);
> -			agbno = XFS_FSB_TO_AGBNO(mp, map[1].br_startblock);
> -			aglen = map[1].br_blockcount;
> -
> -			error = xfs_reflink_find_shared(mp, NULL, agno, agbno,
> -					aglen, &rbno, &rlen, true);
> -			if (error)
> -				goto out;
> -			if (rbno == NULLAGBLOCK)
> -				break;
> -
> -			/* Dirty the pages */
> -			xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -			fpos = XFS_FSB_TO_B(mp, map[1].br_startoff +
> -					(rbno - agbno));
> -			flen = XFS_FSB_TO_B(mp, rlen);
> -			if (fpos + flen > isize)
> -				flen = isize - fpos;
> -			error = iomap_file_unshare(VFS_I(ip), fpos, flen,
> -					&xfs_iomap_ops);
> -			xfs_ilock(ip, XFS_ILOCK_EXCL);
> -			if (error)
> -				goto out;
> -
> -			map[1].br_blockcount -= (rbno - agbno + rlen);
> -			map[1].br_startoff += (rbno - agbno + rlen);
> -			map[1].br_startblock += (rbno - agbno + rlen);
> -		}
> -
> -next:
> -		fbno = map[0].br_startoff + map[0].br_blockcount;
> -	}
> -out:
> -	return error;
> -}
> -
>  /* Does this inode need the reflink flag? */
>  int
>  xfs_reflink_inode_has_shared_extents(
> @@ -1596,10 +1517,7 @@ xfs_reflink_unshare(
>  	xfs_off_t		offset,
>  	xfs_off_t		len)
>  {
> -	struct xfs_mount	*mp = ip->i_mount;
> -	xfs_fileoff_t		fbno;
> -	xfs_filblks_t		end;
> -	xfs_off_t		isize;
> +	struct inode		*inode = VFS_I(ip);
>  	int			error;
>  
>  	if (!xfs_is_reflink_inode(ip))
> @@ -1607,20 +1525,12 @@ xfs_reflink_unshare(
>  
>  	trace_xfs_reflink_unshare(ip, offset, len);
>  
> -	inode_dio_wait(VFS_I(ip));
> +	inode_dio_wait(inode);
>  
> -	/* Try to CoW the selected ranges */
> -	xfs_ilock(ip, XFS_ILOCK_EXCL);
> -	fbno = XFS_B_TO_FSBT(mp, offset);
> -	isize = i_size_read(VFS_I(ip));
> -	end = XFS_B_TO_FSB(mp, offset + len);
> -	error = xfs_reflink_dirty_extents(ip, fbno, end, isize);
> +	error = iomap_file_unshare(inode, offset, len, &xfs_iomap_ops);
>  	if (error)
> -		goto out_unlock;
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -
> -	/* Wait for the IO to finish */
> -	error = filemap_write_and_wait(VFS_I(ip)->i_mapping);
> +		goto out;
> +	error = filemap_write_and_wait(inode->i_mapping);
>  	if (error)
>  		goto out;
>  
> @@ -1628,11 +1538,8 @@ xfs_reflink_unshare(
>  	error = xfs_reflink_try_clear_inode_flag(ip);
>  	if (error)
>  		goto out;
> -
>  	return 0;
>  
> -out_unlock:
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  out:
>  	trace_xfs_reflink_unshare_error(ip, error, _RET_IP_);
>  	return error;
> -- 
> 2.20.1
> 
