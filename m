Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD1410A686
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 23:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKZW1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 17:27:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51676 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKZW1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:27:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQHiBtP021691;
        Tue, 26 Nov 2019 17:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=4sv5aXvG7p2rqRw4vcIUjGx4angZBf6fjGNQjKM6LZk=;
 b=gy38REsAA8HJJvOIGIm1c4MoR43/giZvxyCsqkEO4Tgq6LlwaeLA0wxp60JP6EK6TqLl
 bC8kdWK4aot9uMBNIn0jxSI4/SBnyU1+8lAQQ8qjvw7/uH8OJizrd1y5nyaiRWbu8xrc
 6FyXKIXIZ2Eij7r0KUI8A/QpFFq20csQ1fG9mJv3gWwGt3/NibsqY7A35Ll1guVMXsJQ
 jHTLqtf7G5PC9YLifZPao0+0GNb3ITZEabfs4yblmvGFvz36ekzX2Q2o0UQbpQCcw+8R
 plc7qtRRSK8qbm0zOdTZqMOY3EMvLbc0CWxyFybGdEAA1aXJxjxR+ktGewKsAdFr2pAp 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wevqq8f0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 17:47:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQHdSO6150322;
        Tue, 26 Nov 2019 17:47:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wgvhadxxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 17:47:53 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQHln7K025668;
        Tue, 26 Nov 2019 17:47:49 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 09:47:48 -0800
Date:   Tue, 26 Nov 2019 09:47:47 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH TRIVIAL] iomap: remove unneeded variable in iomap_dio_rw()
Message-ID: <20191126174747.GU6211@magnolia>
References: <20191126122051.6041-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126122051.6041-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9453 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9453 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260149
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 26, 2019 at 01:20:51PM +0100, Johannes Thumshirn wrote:
> The 'start' variable indicates the start of a filemap and is set to the
> iocb's position, which we have already cached as 'pos', upon function
> entry.
> 
> 'pos' is used as a cursor indicating the current position and updated
> later in iomap_dio_rw(), but not before the last use of 'start'.
> 
> Remove 'start' as it's synonym for 'pos' before we're entering the loop
> calling iomapp_apply().
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1fc28c2da279..405456b12f03 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -397,7 +397,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	size_t count = iov_iter_count(iter);
> -	loff_t pos = iocb->ki_pos, start = pos;
> +	loff_t pos = iocb->ki_pos;
>  	loff_t end = iocb->ki_pos + count - 1, ret = 0;
>  	unsigned int flags = IOMAP_DIRECT;
>  	bool wait_for_completion = is_sync_kiocb(iocb);
> @@ -451,14 +451,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	}
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (filemap_range_has_page(mapping, start, end)) {
> +		if (filemap_range_has_page(mapping, pos, end)) {
>  			ret = -EAGAIN;
>  			goto out_free_dio;
>  		}
>  		flags |= IOMAP_NOWAIT;
>  	}
>  
> -	ret = filemap_write_and_wait_range(mapping, start, end);
> +	ret = filemap_write_and_wait_range(mapping, pos, end);
>  	if (ret)
>  		goto out_free_dio;
>  
> @@ -469,7 +469,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	 * pretty crazy thing to do, so we don't support it 100%.
>  	 */
>  	ret = invalidate_inode_pages2_range(mapping,
> -			start >> PAGE_SHIFT, end >> PAGE_SHIFT);
> +			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
>  	if (ret)
>  		dio_warn_stale_pagecache(iocb->ki_filp);
>  	ret = 0;
> -- 
> 2.16.4
> 
