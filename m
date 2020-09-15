Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8626A7B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgIOPAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 11:00:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53022 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgIOO7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:59:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FEsvh3085178;
        Tue, 15 Sep 2020 14:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=mlThoEMSQhnrF2B05hNa3u+h6x1vqKwVnvXnWiW5QVk=;
 b=HbERskiOrilJ40tG6czBgl8d7tVhMbTQp7EaVuB2v8HAZl6RpHwpNhx/5Xr8c/o3vWir
 7I36DDb+c5Ar/cFDkhArjuGwcnNuHYNzp/L0Twyvnc3gYibHtclDfheLsDFLHnRV4jME
 vBDLlEcNGZ0pxEO0m+LCspGO117c4qm/LJ/mCkURL6T163HoDuijSiFZ21JQi3zZWrWW
 IJtqrFJLLNnmhY2c4RmvCeGlnhR3tBFUhfaNNk91yXFZjok4Y/rf10bgsyJpjFiee6Ai
 DrhniYtjFHJx5QZQ94INkT/1meXmKfombfMZhSVnA7KwTAnNsMJrNFZstdT/n3jXZleB uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33gp9m5k2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 14:58:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FEtqM4072492;
        Tue, 15 Sep 2020 14:58:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33hm30p1am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 14:58:12 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FEw5qW018021;
        Tue, 15 Sep 2020 14:58:05 GMT
Received: from [192.168.0.190] (/68.201.65.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 14:58:05 +0000
Subject: Re: [PATCH v2 2/9] fs: Introduce i_blocks_per_page
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-3-willy@infradead.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Autocrypt: addr=dave.kleikamp@oracle.com; prefer-encrypt=mutual; keydata=
 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
 rnNNL3zBkwD3nWcTxFnX
Message-ID: <e5b56c99-6fc9-26ff-9573-0f14a473f092@oracle.com>
Date:   Tue, 15 Sep 2020 09:58:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910234707.5504-3-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/20 6:47 PM, Matthew Wilcox (Oracle) wrote:
> This helper is useful for both THPs and for supporting block size larger
> than page size.  Convert all users that I could find (we have a few
> different ways of writing this idiom, and I may have missed some).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

For jfs:
Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>  fs/iomap/buffered-io.c  |  8 ++++----
>  fs/jfs/jfs_metapage.c   |  2 +-
>  fs/xfs/xfs_aops.c       |  2 +-
>  include/linux/pagemap.h | 16 ++++++++++++++++
>  4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d81a9a86c5aa..330f86b825d7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -46,7 +46,7 @@ iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
>  
> -	if (iop || i_blocksize(inode) == PAGE_SIZE)
> +	if (iop || i_blocks_per_page(inode, page) <= 1)
>  		return iop;
>  
>  	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
> @@ -147,7 +147,7 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	unsigned int i;
>  
>  	spin_lock_irqsave(&iop->uptodate_lock, flags);
> -	for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
> +	for (i = 0; i < i_blocks_per_page(inode, page); i++) {
>  		if (i >= first && i <= last)
>  			set_bit(i, iop->uptodate);
>  		else if (!test_bit(i, iop->uptodate))
> @@ -1077,7 +1077,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
>  		mapping_set_error(inode->i_mapping, -EIO);
>  	}
>  
> -	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
> +	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
>  
>  	if (!iop || atomic_dec_and_test(&iop->write_count))
> @@ -1373,7 +1373,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	int error = 0, count = 0, i;
>  	LIST_HEAD(submit_list);
>  
> -	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
> +	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
>  
>  	/*
> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index a2f5338a5ea1..176580f54af9 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
> @@ -473,7 +473,7 @@ static int metapage_readpage(struct file *fp, struct page *page)
>  	struct inode *inode = page->mapping->host;
>  	struct bio *bio = NULL;
>  	int block_offset;
> -	int blocks_per_page = PAGE_SIZE >> inode->i_blkbits;
> +	int blocks_per_page = i_blocks_per_page(inode, page);
>  	sector_t page_start;	/* address of page in fs blocks */
>  	sector_t pblock;
>  	int xlen;
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index b35611882ff9..55d126d4e096 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -544,7 +544,7 @@ xfs_discard_page(
>  			page, ip->i_ino, offset);
>  
>  	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> -			PAGE_SIZE / i_blocksize(inode));
> +			i_blocks_per_page(inode, page));
>  	if (error && !XFS_FORCED_SHUTDOWN(mp))
>  		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
>  out_invalidate:
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 50d2c39b47ab..f7f602040913 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -975,4 +975,20 @@ static inline int page_mkwrite_check_truncate(struct page *page,
>  	return offset;
>  }
>  
> +/**
> + * i_blocks_per_page - How many blocks fit in this page.
> + * @inode: The inode which contains the blocks.
> + * @page: The page (head page if the page is a THP).
> + *
> + * If the block size is larger than the size of this page, return zero.
> + *
> + * Context: The caller should hold a refcount on the page to prevent it
> + * from being split.
> + * Return: The number of filesystem blocks covered by this page.
> + */
> +static inline
> +unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
> +{
> +	return thp_size(page) >> inode->i_blkbits;
> +}
>  #endif /* _LINUX_PAGEMAP_H */
> 
