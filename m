Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366F97D1D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 01:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfGaXZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 19:25:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59178 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfGaXZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:25:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VNOi9d179989;
        Wed, 31 Jul 2019 23:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=q51X6M2p0hhJWCY8lKahkQRSceDNa0XZZ87XdUgj7HI=;
 b=wZxCbBBI1jZMa4aYEI4Ib0E6xQVRdGEpLPVTSjOFBeYju3JHzw8MRydzfsL0RKdIQJun
 rp2NCX5wBWCrv/NGsAfKx7OAJEydbMCfIS0kziOdtEKW23xp5UhokcOlKCF5d8ZBjGUJ
 O9hrH/Qvkc4yODeGQGes4nQhjCi2FlCSqcNl2wB9wa4kslxPzy+rqPI1/bY9339tiDUd
 4QdHvb8zFJFytqO14a3NdXbhAvMRf6uSj+wf3vJRjivNUHd52+Ybntvrr79ibl31gJWv
 TxGCcQSJLuRsMmMKsESExHlelIGu2bp54dAZ/CitzduVvCmwrEhc1Q096eDBmF6Ff43z DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u0e1u0cfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:24:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VNNPBl078300;
        Wed, 31 Jul 2019 23:24:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2u2jp5kks1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:24:50 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6VNOn2I018728;
        Wed, 31 Jul 2019 23:24:49 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 16:24:49 -0700
Date:   Wed, 31 Jul 2019 16:24:47 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/9] iomap: Remove length and start fields from
 iomap_fiemap
Message-ID: <20190731232447.GX1561054@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-7-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731141245.7230-7-cmaiolino@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310230
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310230
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:12:42PM +0200, Carlos Maiolino wrote:
> fiemap_extent_info now embeds start and length parameters, users of
> iomap_fiemap() doesn't need to pass it individually anymore.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/gfs2/inode.c       | 4 +---
>  fs/iomap.c            | 4 +++-
>  fs/xfs/xfs_iops.c     | 8 ++------
>  include/linux/iomap.h | 2 +-
>  4 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 5e84d5963506..df31bd8ecf6f 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -2006,8 +2006,6 @@ static int gfs2_getattr(const struct path *path, struct kstat *stat,
>  
>  static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
> -	u64 start = fieinfo->fi_start;
> -	u64 len = fieinfo->fi_len;
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  	struct gfs2_holder gh;
>  	int ret;
> @@ -2018,7 +2016,7 @@ static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  	if (ret)
>  		goto out;
>  
> -	ret = iomap_fiemap(inode, fieinfo, start, len, &gfs2_iomap_ops);
> +	ret = iomap_fiemap(inode, fieinfo, &gfs2_iomap_ops);
>  
>  	gfs2_glock_dq_uninit(&gh);
>  
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 97cb9d486a7d..b1e88722e10b 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -1184,9 +1184,11 @@ iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  }
>  
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
> -		loff_t start, loff_t len, const struct iomap_ops *ops)
> +		 const struct iomap_ops *ops)
>  {
>  	struct fiemap_ctx ctx;
> +	loff_t start = fi->fi_start;
> +	loff_t len = fi->fi_len;
>  	loff_t ret;
>  
>  	memset(&ctx, 0, sizeof(ctx));
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 1f4354fa989b..b485190b7ecd 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1112,18 +1112,14 @@ xfs_vn_fiemap(
>  	struct inode		  *inode,
>  	struct fiemap_extent_info *fieinfo)
>  {
> -	u64	start = fieinfo->fi_start;
> -	u64	length = fieinfo->fi_len;
>  	int	error;
>  
>  	xfs_ilock(XFS_I(inode), XFS_IOLOCK_SHARED);
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
>  		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
> -		error = iomap_fiemap(inode, fieinfo, start, length,
> -				&xfs_xattr_iomap_ops);
> +		error = iomap_fiemap(inode, fieinfo, &xfs_xattr_iomap_ops);
>  	} else {
> -		error = iomap_fiemap(inode, fieinfo, start, length,
> -				&xfs_iomap_ops);
> +		error = iomap_fiemap(inode, fieinfo, &xfs_iomap_ops);
>  	}
>  	xfs_iunlock(XFS_I(inode), XFS_IOLOCK_SHARED);
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 0fefb5455bda..bc4c421ee822 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -145,7 +145,7 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>  			const struct iomap_ops *ops);
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		loff_t start, loff_t len, const struct iomap_ops *ops);
> +		const struct iomap_ops *ops);
>  loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
>  		const struct iomap_ops *ops);
>  loff_t iomap_seek_data(struct inode *inode, loff_t offset,
> -- 
> 2.20.1
> 
