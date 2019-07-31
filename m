Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 246307D1EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 01:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfGaXai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 19:30:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46512 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730702AbfGaXah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:30:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VNTPR4068751;
        Wed, 31 Jul 2019 23:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uKQ6FrOWWug9jtNTlA8D9pfPbivnqv1aQIK1Zj9uXs0=;
 b=aeNH+Y5eQItoM3XtpgXL3CQX+9cU1c41L66Bti8VLVZdeG83rcq/n6h5DIWaXKG9BUTK
 Nx69JO0VKlVEkHlpXb9wME5o743Yr71xerQ5RQ9pmHBYy6g/9/E1gTlmzc+vvRq5sYXV
 baoIs8NfGC1HXCekS4nwbVW2bCEhiWXUskNPA1g8olFIGU9dV1G6HdeJNHsqlXkYDcFN
 TQHayXps1NTihxU3UhEzrQdbWpMT5msvd3aY6xeb+wUvLoukD4w9+9yEoMjtFdZna+cH
 BlL4/rMsjLgkyH/LDpdZHtoz7GglRtEyZsVAtNcJJWeeTJ+fARXDUHeHFDxiWasUvrCe 1w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u0ejpr6h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:30:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VNS1Fo087495;
        Wed, 31 Jul 2019 23:30:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u38fbcu87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:30:11 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6VNUAbk001292;
        Wed, 31 Jul 2019 23:30:10 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 16:30:09 -0700
Date:   Wed, 31 Jul 2019 16:30:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 9/9] xfs: Get rid of ->bmap
Message-ID: <20190731233007.GA1561054@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-10-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731141245.7230-10-cmaiolino@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310231
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310231
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:12:45PM +0200, Carlos Maiolino wrote:
> We don't need ->bmap anymore, only usage for it was FIBMAP, which is now
> gone.
> 
> Also kill iomap_bmap() and iomap_bmap_actor once it has no users anymore.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
> 
> Changelog:
> 
> V2:
> 	- Kill iomap_bmap() and iomap_bmap_actor()
> 
>  fs/iomap.c         | 34 ----------------------------------
>  fs/xfs/xfs_aops.c  | 24 ------------------------
>  fs/xfs/xfs_trace.h |  1 -
>  3 files changed, 59 deletions(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 2b182abd18e8..12e6a575feb4 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c

Needs rebasing against 5.3-rc1.

> @@ -2153,37 +2153,3 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  }
>  EXPORT_SYMBOL_GPL(iomap_swapfile_activate);
>  #endif /* CONFIG_SWAP */
> -
> -static loff_t
> -iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap)
> -{
> -	sector_t *bno = data, addr;
> -
> -	if (iomap->type == IOMAP_MAPPED) {
> -		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
> -		if (addr > INT_MAX)
> -			WARN(1, "would truncate bmap result\n");
> -		else
> -			*bno = addr;
> -	}
> -	return 0;
> -}
> -
> -/* legacy ->bmap interface.  0 is the error return (!) */
> -sector_t
> -iomap_bmap(struct address_space *mapping, sector_t bno,
> -		const struct iomap_ops *ops)
> -{
> -	struct inode *inode = mapping->host;
> -	loff_t pos = bno << inode->i_blkbits;
> -	unsigned blocksize = i_blocksize(inode);
> -
> -	if (filemap_write_and_wait(mapping))
> -		return 0;
> -
> -	bno = 0;
> -	iomap_apply(inode, pos, blocksize, 0, ops, &bno, iomap_bmap_actor);
> -	return bno;
> -}
> -EXPORT_SYMBOL_GPL(iomap_bmap);
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 3619e9e8d359..76ee495eba1a 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -1006,29 +1006,6 @@ xfs_vm_releasepage(
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

Wait, this isn't the same check that was added to the xfs fiemap
implementation.

--D

> -		return 0;
> -	return iomap_bmap(mapping, block, &xfs_iomap_ops);
> -}
> -
>  STATIC int
>  xfs_vm_readpage(
>  	struct file		*unused,
> @@ -1067,7 +1044,6 @@ const struct address_space_operations xfs_address_space_operations = {
>  	.set_page_dirty		= iomap_set_page_dirty,
>  	.releasepage		= xfs_vm_releasepage,
>  	.invalidatepage		= xfs_vm_invalidatepage,
> -	.bmap			= xfs_vm_bmap,
>  	.direct_IO		= noop_direct_IO,
>  	.migratepage		= iomap_migrate_page,
>  	.is_partially_uptodate  = iomap_is_partially_uptodate,
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 47fb07d86efd..3a45a3971dce 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -621,7 +621,6 @@ DEFINE_INODE_EVENT(xfs_readdir);
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
