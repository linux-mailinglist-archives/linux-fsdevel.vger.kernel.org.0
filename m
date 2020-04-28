Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B12E1BC246
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 17:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgD1PIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 11:08:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35758 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgD1PIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:08:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SF2k5C186092;
        Tue, 28 Apr 2020 15:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SysIxrt1+3K/mFDr8ETFlGN5CMmYGDfWmfzP1tFr0mQ=;
 b=WpxwfZrMWczGXegatfOS6BuQBDTjF1jYTtxBcdPBTdrK7Z1JX5JG+NES713sOMR6/c0Y
 6EHZ08mEEMkVdF23TtksCpmHcL2ZgDMFDfxFYjO5k0PDoLhFI3bP4dVUgmTvhn2Ns9xS
 wYE3peCsa8btH28w7Aot77TqrkF6TlRt7TggXxWJZtfKqPxcw71hwwuwhBKbtbcZR3nA
 lcT9uuKDmbVT72gixKwaTq9iWilQJivgjcxxk/O3fCd1tWvmXGyBf98eT6HNhuJGW7v+
 o56n6F362Z4SGec6l4m/H++5rR6RSGdrhP9SD1hinDDaVeEuvC+M3YKRvluCRdQf+Otl eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30nucg0j39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:08:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SF79jw100819;
        Tue, 28 Apr 2020 15:08:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30my0dd9cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:08:13 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SF8Cke028981;
        Tue, 28 Apr 2020 15:08:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:08:12 -0700
Date:   Tue, 28 Apr 2020 08:08:10 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 07/11] iomap: fix the iomap_fiemap prototype
Message-ID: <20200428150810.GI6741@magnolia>
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427181957.1606257-8-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280118
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:19:53PM +0200, Christoph Hellwig wrote:
> iomap_fiemap should take u64 start and len arguments, just like the
> ->fiemap prototype.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/fiemap.c     | 2 +-
>  include/linux/iomap.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index fca3dfb9d964a..dd04e4added15 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -66,7 +66,7 @@ iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  }
>  
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
> -		loff_t start, loff_t len, const struct iomap_ops *ops)
> +		u64 start, u64 len, const struct iomap_ops *ops)
>  {
>  	struct fiemap_ctx ctx;
>  	loff_t ret;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b09463dae0db..63db02528b702 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -178,7 +178,7 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>  			const struct iomap_ops *ops);
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		loff_t start, loff_t len, const struct iomap_ops *ops);
> +		u64 start, u64 len, const struct iomap_ops *ops);
>  loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
>  		const struct iomap_ops *ops);
>  loff_t iomap_seek_data(struct inode *inode, loff_t offset,
> -- 
> 2.26.1
> 
