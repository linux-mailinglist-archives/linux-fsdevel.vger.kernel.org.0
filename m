Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6360C11EF38
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2019 01:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLNAbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 19:31:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfLNAbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 19:31:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBE0T3bH056076;
        Sat, 14 Dec 2019 00:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=2+aushzn/gdzakkI2/WSXNHpsaRfP/OYJl7Mtl74URg=;
 b=sFUxnbKkhrBjQJ345yQDqcZLe1LCEjxv6S9vj9YB5TF6GqTUxxLf8ddEG5OQ7eBEKt3c
 96+yFbabbDQck7I5vBHQ9YhJO4Z+CT/gyuB3ob3u/6hxUG0sha/3YRcRTlRH+JmoER0A
 WTdWKO/Tgn6Y4lYK1ciWANZu9q+ytPr9YSy0uLbX+xwSQqdx/CQ5bnSy/tZv/bef0kHs
 IuDu8NviKHcMixKG5it7D9nMkrjoG3Y6/kxJhqt2nWMLyIrd2Wzy8BX7vFH5TqxLEiup
 HR3BDQRbMlr2+ZB/8AEunRrLmHDORBcAI2am6alN43Y/byg8OQiduy8en3NAaxex1TS/ /w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wrw4nrs31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Dec 2019 00:31:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBE0Sqi9060329;
        Sat, 14 Dec 2019 00:31:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wvdtvjqxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Dec 2019 00:31:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBE0V7Bs031068;
        Sat, 14 Dec 2019 00:31:07 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 16:31:06 -0800
Date:   Fri, 13 Dec 2019 16:31:05 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        fdmanana@kernel.org, nborisov@suse.com, dsterba@suse.cz,
        jthumshirn@suse.de, linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/8] iomap: add a filesystem hook for direct I/O bio
 submission
Message-ID: <20191214003105.GA99860@magnolia>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
 <20191213195750.32184-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213195750.32184-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912140001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912140001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 01:57:44PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This helps filesystems to perform tasks on the bio while submitting for
> I/O. This could be post-write operations such as data CRC or data
> replication for fs-handled RAID.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c  | 14 +++++++++-----
>  include/linux/iomap.h |  2 ++
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 23837926c0c5..1a3bf3bd86fb 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -59,7 +59,7 @@ int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
>  EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
>  
>  static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
> -		struct bio *bio)
> +		struct bio *bio, loff_t pos)
>  {
>  	atomic_inc(&dio->ref);
>  
> @@ -67,7 +67,11 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
>  		bio_set_polled(bio, dio->iocb);
>  
>  	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
> -	dio->submit.cookie = submit_bio(bio);
> +	if (dio->dops && dio->dops->submit_io)
> +		dio->submit.cookie = dio->dops->submit_io(bio,
> +				dio->iocb->ki_filp, pos);
> +	else
> +		dio->submit.cookie = submit_bio(bio);
>  }
>  
>  static ssize_t iomap_dio_complete(struct iomap_dio *dio)
> @@ -191,7 +195,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  	get_page(page);
>  	__bio_add_page(bio, page, len, 0);
>  	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
> -	iomap_dio_submit_bio(dio, iomap, bio);
> +	iomap_dio_submit_bio(dio, iomap, bio, pos);
>  }
>  
>  static loff_t
> @@ -299,11 +303,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		}
>  
>  		dio->size += n;
> -		pos += n;
>  		copied += n;
>  
>  		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> -		iomap_dio_submit_bio(dio, iomap, bio);
> +		iomap_dio_submit_bio(dio, iomap, bio, pos);
> +		pos += n;
>  	} while (nr_pages);
>  
>  	/*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b09463dae0d..2b093a23ef1c 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -252,6 +252,8 @@ int iomap_writepages(struct address_space *mapping,
>  struct iomap_dio_ops {
>  	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
>  		      unsigned flags);
> +	blk_qc_t (*submit_io)(struct bio *bio, struct file *file,
> +			  loff_t file_offset);
>  };
>  
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> -- 
> 2.16.4
> 
