Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0ABB3FC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 19:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbfIPRxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 13:53:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52620 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfIPRxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:53:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GHdEec048717;
        Mon, 16 Sep 2019 17:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Xs4sJDz0eRyWS9+st1Er0LrDq7hTfMidtu1AteCqjj8=;
 b=aFvbX+Km290nn84YUQnOLf135TPJg7JJ298STxMk0XJ+y6TXLLCcTaef+24U+0u6FN+3
 quA9I4nU2J6vjFmJCwnX2ns2OA11MFT/GT09aXasXm68CGJJi70+ozCaUSBbGNCRisBd
 o/GgiORWpz6WU/CJy7dqXzLQxLGN9rGh1MvbPO6vxRHONIG6jy2RhjKSGTCAOYw/qXNt
 bP8htwekEhN5xo7VhwOjKQ3B2ecHI9kP6kHTHOhuiAXJL3dpzE7SMEAFP9xZ8fyFihzS
 4qAcuEbuXkdxW2Y4utYo/hMjgrzzu2zJv3a7NMGd1tX5opX76oIEghVUInp1xvH0OyCq VQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2v2bx2sb4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 17:52:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GHcues157412;
        Mon, 16 Sep 2019 17:50:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2v0r1gtvph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 17:50:52 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8GHopeg011999;
        Mon, 16 Sep 2019 17:50:51 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 10:50:50 -0700
Date:   Mon, 16 Sep 2019 10:50:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 9/9] xfs: Get rid of ->bmap
Message-ID: <20190916175049.GD2229799@magnolia>
References: <20190911134315.27380-1-cmaiolino@redhat.com>
 <20190911134315.27380-10-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911134315.27380-10-cmaiolino@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160175
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 03:43:15PM +0200, Carlos Maiolino wrote:
> We don't need ->bmap anymore, only usage for it was FIBMAP, which is now
> gone.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
> 
> Changelog:
> 	V5:
> 		- Properly rebase against 5.3
> 		- iomap_{bmap(),bmap_actor()} are now used also by GFS2, so
> 		  don't remove them anymore
> 	V2:
> 		- Kill iomap_bmap() and iomap_bmap_actor()
> 
>  fs/xfs/xfs_aops.c  | 24 ------------------------
>  fs/xfs/xfs_trace.h |  1 -
>  2 files changed, 25 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 4e4a4d7df5ac..a2884537d2c2 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -1138,29 +1138,6 @@ xfs_vm_releasepage(
>  	return iomap_releasepage(page, gfp_mask);
>  }
>  
> -STATIC sector_t
> -xfs_vm_bmap(
> -	struct address_space	*mapping,
> -	sector_t		block)
> -{
> -	struct xfs_inode	*ip = XFS_I(mapping->host);
> -
> -	trace_xfs_vm_bmap(ip);
> -
> -	/*
> -	 * The swap code (ab-)uses ->bmap to get a block mapping and then
> -	 * bypasses the file system for actual I/O.  We really can't allow
> -	 * that on reflinks inodes, so we have to skip out here.  And yes,
> -	 * 0 is the magic code for a bmap error.
> -	 *
> -	 * Since we don't pass back blockdev info, we can't return bmap
> -	 * information for rt files either.
> -	 */
> -	if (xfs_is_cow_inode(ip) || XFS_IS_REALTIME_INODE(ip))

Uhhhh where does this check happen now?

--D

> -		return 0;
> -	return iomap_bmap(mapping, block, &xfs_iomap_ops);
> -}
> -
>  STATIC int
>  xfs_vm_readpage(
>  	struct file		*unused,
> @@ -1199,7 +1176,6 @@ const struct address_space_operations xfs_address_space_operations = {
>  	.set_page_dirty		= iomap_set_page_dirty,
>  	.releasepage		= xfs_vm_releasepage,
>  	.invalidatepage		= xfs_vm_invalidatepage,
> -	.bmap			= xfs_vm_bmap,
>  	.direct_IO		= noop_direct_IO,
>  	.migratepage		= iomap_migrate_page,
>  	.is_partially_uptodate  = iomap_is_partially_uptodate,
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index eaae275ed430..c226b562f5da 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -626,7 +626,6 @@ DEFINE_INODE_EVENT(xfs_readdir);
>  #ifdef CONFIG_XFS_POSIX_ACL
>  DEFINE_INODE_EVENT(xfs_get_acl);
>  #endif
> -DEFINE_INODE_EVENT(xfs_vm_bmap);
>  DEFINE_INODE_EVENT(xfs_file_ioctl);
>  DEFINE_INODE_EVENT(xfs_file_compat_ioctl);
>  DEFINE_INODE_EVENT(xfs_ioctl_setattr);
> -- 
> 2.20.1
> 
