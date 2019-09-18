Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4250AB68D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 19:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfIRRSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 13:18:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfIRRSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:18:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IGwrrT052809;
        Wed, 18 Sep 2019 17:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=WPOHkkVZMCHDG3mFzVWtIOPOfi7uoBLGxuqS2RZ5zaY=;
 b=jH0+ga8gBGA1JZAROIx/ywlo/LG011Ot/cw/beVOP+EZsF3UQnCifdChogLn1TJ2fAk5
 y7wHYkOIaT3UzObod36Xgmkl5TRie1WUlae+Q0wMKH2Js+OnbW+3GQ1YOe7Udl4YuayF
 M1xoXK1lBGjJys6r+gI7QzFiShkbt139AM58mih289V0vEANAQqQWRQPizWlEQTksPRe
 q4xZV0R0cyP+w+jKG9nl/DwP+grDXMgeUb2tDHzFPLmu9eKJpJqVNdc1nw1jeSczQBei
 8VEPkyBzcrNhrK4nfnbOlc//HzyKIjpw1L18i1U7yAu61jchKkgGrhdQ2VaPJ/ItD33N 6w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v385dwdgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:17:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IGx5gb006314;
        Wed, 18 Sep 2019 17:17:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2v37mncxqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:17:35 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8IHHYn5029700;
        Wed, 18 Sep 2019 17:17:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 10:17:34 -0700
Date:   Wed, 18 Sep 2019 10:17:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/19] xfs: remove xfs_reflink_dirty_extents
Message-ID: <20190918171733.GA2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-10-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:12PM +0200, Christoph Hellwig wrote:
> Now that xfs_file_unshare is not completely dumb we can just call it
> directly without iterating the extent and reflink btrees ourselves.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_reflink.c | 108 ++++---------------------------------------
>  1 file changed, 10 insertions(+), 98 deletions(-)
> 
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index cadc0456804d..73f8cce4722d 100644
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
> @@ -1589,6 +1510,11 @@ xfs_reflink_try_clear_inode_flag(
>  /*
>   * Pre-COW all shared blocks within a given byte range of a file and turn off
>   * the reflink flag if we unshare all of the file's blocks.
> + *
> + * Let iomap iterate all extents to see which are shared and not unwritten or
> + * delalloc and read them into the page cache, dirty them, fsync them back out,
> + * and then we can update the inode flag.  What happens if we run out of
> + * memory? :)

I don't know, what /does/ happen? :)

It /should/ be fine, right?  Writeback will start pushing the dirty
cache pages to disk, and since writeback only takes the ILOCK, it should
be able to perform the COW even while the unshare process sits on the
IOLOCK/MMAPLOCK.  True, the unshare process and writeback will both be
contending on the ILOCK, but that shouldn't be a problem...

...unless I'm missing something?  It sure does look nice to drain all
this other code out.

--D

>   */
>  int
>  xfs_reflink_unshare(
> @@ -1596,10 +1522,7 @@ xfs_reflink_unshare(
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
> @@ -1607,20 +1530,12 @@ xfs_reflink_unshare(
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
> @@ -1628,11 +1543,8 @@ xfs_reflink_unshare(
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
