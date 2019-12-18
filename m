Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF9E123CD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 03:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLRCCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 21:02:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56678 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfLRCCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:02:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI1sFMM041600;
        Wed, 18 Dec 2019 02:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=v5oSqbOb/3e2GlryDHkB07ZgP+GuwmTlR7z5M6VAa84=;
 b=jM03X+MsX8yxKKxoMCkhHbpDWCjrPdiaHsC4GYxLeHQr4/z5EomoZ66sbp68OE9hgGJD
 +pHJD2yc3TlXkqggRzDQsA7kmItJILE3++xWa4Hxb//Dybobd544Q5OmDGngrNdB73VS
 Y7dtg+mRqUFMwErXEgrHqAEWMRYhJ09kguqNRqPVvzSmheoKplwjjF4/OgvqT/uAWwWD
 V/EK2Aip0yHy1le9wxZhVkfKAsB83aOLBjvhb4hL7CxAPYtFNKhZ76RzmQONQdNcf6rj
 0RzRnPrGARHT3xzDuKC/sQsFEvghi6a5JZKG1vBxG85Vq6eVCnzLhQcFA+VR4n53bwon vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wvqpqagjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 02:02:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI1sMl4105628;
        Wed, 18 Dec 2019 02:02:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wxm7513hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 02:02:37 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBI22Yrv024981;
        Wed, 18 Dec 2019 02:02:35 GMT
Received: from localhost (/10.159.137.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 18:02:34 -0800
Date:   Tue, 17 Dec 2019 18:02:31 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        fdmanana@kernel.org, nborisov@suse.com, dsterba@suse.cz,
        jthumshirn@suse.de, linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/8] iomap: add a filesystem hook for direct I/O bio
 submission
Message-ID: <20191218020231.GL12766@magnolia>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
 <20191213195750.32184-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213195750.32184-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180014
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

Seems fine to me,
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
