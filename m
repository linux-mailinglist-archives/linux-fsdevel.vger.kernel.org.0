Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870387BF259
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442111AbjJJFmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 01:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378580AbjJJFmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:42:42 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6336AA3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 22:42:39 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231010054237epoutp01942b4549d5bfe3de9d0c4c5fd6fc5f0d~MqJ5F_3K-2995029950epoutp01M
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 05:42:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231010054237epoutp01942b4549d5bfe3de9d0c4c5fd6fc5f0d~MqJ5F_3K-2995029950epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696916557;
        bh=6pbBvyHbWsmg3Q8Sb+ife4UjdqWf9M2wjjcRPO+cR84=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=tMxjC471p5FTMFJ78dtuEScuQwrz7LforEr9aDE6IqPaeTMCtHRPn20BceIeAPvZ0
         rZOgfvgeMFTZNwuooxAvIhJqlaDCMudu4+J3fTyZPQlaWfB5mbX6u1GHxwmoc7Y/jH
         yXgcePU4khAwqxxwjHx+MHR9MI5S0MWYZf6lm/lc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231010054236epcas5p18da41d54dd761bd64f1aff7660f9b748~MqJ4reWeW1846918469epcas5p18;
        Tue, 10 Oct 2023 05:42:36 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4S4Ptf0mnjz4x9Pv; Tue, 10 Oct
        2023 05:42:34 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.B4.09635.844E4256; Tue, 10 Oct 2023 14:42:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231010054232epcas5p403c57f2d1ea934e2f467a335c1a98a80~MqJ0jThGg3261432614epcas5p49;
        Tue, 10 Oct 2023 05:42:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231010054232epsmtrp19a530e7d09fc9311abc33722482699e8~MqJ0iXX_G1806218062epsmtrp1X;
        Tue, 10 Oct 2023 05:42:32 +0000 (GMT)
X-AuditID: b6c32a4b-563fd700000025a3-68-6524e448714f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.18.08788.844E4256; Tue, 10 Oct 2023 14:42:32 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231010054229epsmtip291997c51a435da8b8bfabd97dce755a4~MqJyPfxlg0159301593epsmtip2-;
        Tue, 10 Oct 2023 05:42:29 +0000 (GMT)
Message-ID: <d25ae351-5131-1b3e-4ae8-bacb674008de@samsung.com>
Date:   Tue, 10 Oct 2023 11:12:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 04/15] fs: Restore write hint support
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
From:   Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231005194129.1882245-5-bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJsWRmVeSWpSXmKPExsWy7bCmlq7HE5VUg1PLDS1e/rzKZrH6bj+b
        xevDnxgtpn34yWxxeupZJotVD8ItLj/hs1i5+iiTxZyzDUwWT9bPYrbYe0vbYs/ekywW3dd3
        sFksP/6PyeLBn8fsFuf/Hmd1EPC4fMXbY+esu+wel8+Wemxa1cnmsftmA5vHx6e3WDz6tqxi
        9Pi8Sc6j/UA3k8emJ2+ZAriism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
        EnNTbZVcfAJ03TJzgP5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YW
        l+al6+WlllgZGhgYmQIVJmRn9M3cxFSwWK3i9LmF7A2MT+S6GDk5JARMJD5tWMnaxcjFISSw
        m1FizZeFUM4nRon9R84yQTjfGCWefNrNAtMyZ8tRqKq9jBIH33xhg3DeMkr8uLCfHaSKV8BO
        YvqyhYwgNouAqsTjxb+g4oISJ2c+AZskKpAk8evqHLAaYQEbicvfb7KB2MwC4hK3nsxnArFF
        BNwkGq7uAlvALNDEIvHt2V4gh4ODTUBT4sLkUpAaTgEriecbLzJC9MpLbH87hxni0jccEp+O
        Qj3qItFwYBUjhC0s8er4FnYIW0riZX8blJ0scWnmOSYIu0Ti8Z6DULa9ROupfmaQtcxAa9fv
        0odYxSfR+/sJE0hYQoBXoqNNCKJaUeLepKesELa4xMMZS6BsD4n919Yyw8NtU8MU1gmMCrOQ
        QmUWku9nIflmFsLmBYwsqxglUwuKc9NTi00LjPNSy+ERnpyfu4kRnMy1vHcwPnrwQe8QIxMH
        4yFGCQ5mJRHeR5kqqUK8KYmVValF+fFFpTmpxYcYTYHRM5FZSjQ5H5hP8kriDU0sDUzMzMxM
        LI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYMrYVHiUMyog7foH31+WSmZJBuf6Moy1
        D8oz9hz4IuC3tP5tUKHZj/02KfOuXHjPHym7qmfBzu6wajfX7atszsbXfJxdzTrD8vvauIb2
        l1Kc9nqzhPls5nZ5X9oeJfvvjLhGhsJeHeUiH/3/UTl/RJmf5kd8y21sPnz5tUHi4TUt56ZP
        /77jyRfRl+fXHHRt4OG+rGO2V3u26YmHk64FxQu/e/13xZojhbICnTP8Myxl02tlCs/48J5z
        DBG+37LC5neFsF/K91VfnBImF+p2sIa/6U6cnThf3M3VSeOXkPC7I3ufZN0L/rpw4/Efr56+
        aavT5zqcu1H6v0H7lQqLeQFulklPlpgp6pXvfqSUosRSnJFoqMVcVJwIAFcY2Y9vBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSvK7HE5VUgzuPRC1e/rzKZrH6bj+b
        xevDnxgtpn34yWxxeupZJotVD8ItLj/hs1i5+iiTxZyzDUwWT9bPYrbYe0vbYs/ekywW3dd3
        sFksP/6PyeLBn8fsFuf/Hmd1EPC4fMXbY+esu+wel8+Wemxa1cnmsftmA5vHx6e3WDz6tqxi
        9Pi8Sc6j/UA3k8emJ2+ZAriiuGxSUnMyy1KL9O0SuDL6Zm5iKlisVnH63EL2BsYncl2MnBwS
        AiYSc7YcZe1i5OIQEtjNKDGreycLREJcovnaD3YIW1hi5b/n7BBFrxkl7h48ywiS4BWwk5i+
        bCGYzSKgKvF48S92iLigxMmZT8AGiQokSey538gEYgsL2Ehc/n6TDcRmBlpw68l8sLiIgJtE
        w9VdbCALmAVaWCTeH+0CKxIS2MsocfRVYhcjBwebgKbEhcmlIGFOASuJ5xsvMkLMMZPo2toF
        ZctLbH87h3kCo9AsJGfMQrJuFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vO
        z93ECI5cLa0djHtWfdA7xMjEwXiIUYKDWUmE91GmSqoQb0piZVVqUX58UWlOavEhRmkOFiVx
        3m+ve1OEBNITS1KzU1MLUotgskwcnFINTLJTlFQa57BvE/3o4W/R/55lV1t6xsuHe5ZpdZxN
        8tW1KWY0dz8sF8/yc9Lqa8rdoWqnjs+S3lU978gLZs+LXA8WMrutk92+wrrxrn5T6e0Ipz8d
        q9LZ24qEtvi+nXA7s1lX9N4N06sX4rdyPrPuMamef1SEQ9CVrfREdaXM0XtHNux4rL28zvtg
        dvX/iSlbWHLS7/rLt8z6JdBqyKIdJuBbk/+gq+VDg8eWq7Yx9/8EX005VGVSlte6rSxncbxl
        n2uc3hnrD4d6vvP18H/c2ix+vYnx8vQjur/Ew9TWPXAorevbfY+rwbhNoWGyvvMUd8aOqh8F
        J1jk9aTPccttifSfvEzq5haJf37fF/orsRRnJBpqMRcVJwIA4AiiPEsDAAA=
X-CMS-MailID: 20231010054232epcas5p403c57f2d1ea934e2f467a335c1a98a80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231005194217epcas5p1538a3730290bbb38adca08f8c80f328e
References: <20231005194129.1882245-1-bvanassche@acm.org>
        <CGME20231005194217epcas5p1538a3730290bbb38adca08f8c80f328e@epcas5p1.samsung.com>
        <20231005194129.1882245-5-bvanassche@acm.org>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/6/2023 1:10 AM, Bart Van Assche wrote:
> This patch reverts a small subset of commit c75e707fe1aa ("block: remove
> the per-bio/request write hint"). The following functionality has been
> restored:
> - In F2FS, store data lifetime information in struct bio.
> - In fs/iomap and fs/mpage.c, restore the code that sets the data
>    lifetime.
> 
> A new header file is introduced for the new bio_[sg]et_data_lifetime()
> functions because there is no other header file yet that includes both
> <linux/fs.h> and <linux/ioprio.h>.
> 
> The value WRITE_LIFE_NONE is mapped onto the data lifetime 0. This is
> consistent with NVMe TPAR4093a. From that TPAR: "A value of 1h specifies
> the shortest Data Lifetime. A value of 3Fh specifies the longest Data
> Lifetime." This is also consistent with the SCSI specifications. From
> T10 document 23-024r3: "0h: no relative lifetime is applicable; 1h:
> shortest relative lifetime; ...; 3fh: longest relative lifetime".
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   fs/f2fs/data.c              |  3 +++
>   fs/iomap/buffered-io.c      |  3 +++
>   fs/mpage.c                  |  2 ++
>   include/linux/fs-lifetime.h | 20 ++++++++++++++++++++
>   4 files changed, 28 insertions(+)
>   create mode 100644 include/linux/fs-lifetime.h
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 916e317ac925..2962cb335897 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -6,6 +6,7 @@
>    *             http://www.samsung.com/
>    */
>   #include <linux/fs.h>
> +#include <linux/fs-lifetime.h>
>   #include <linux/f2fs_fs.h>
>   #include <linux/buffer_head.h>
>   #include <linux/sched/mm.h>
> @@ -478,6 +479,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>   	} else {
>   		bio->bi_end_io = f2fs_write_end_io;
>   		bio->bi_private = sbi;
> +		bio_set_data_lifetime(bio,
> +			f2fs_io_type_to_rw_hint(sbi, fio->type, fio->temp));
>   	}
>   	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
>   
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 644479ccefbd..9bf05342ca65 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -6,6 +6,7 @@
>   #include <linux/module.h>
>   #include <linux/compiler.h>
>   #include <linux/fs.h>
> +#include <linux/fs-lifetime.h>
>   #include <linux/iomap.h>
>   #include <linux/pagemap.h>
>   #include <linux/uio.h>
> @@ -1660,6 +1661,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
>   			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
>   			       GFP_NOFS, &iomap_ioend_bioset);
>   	bio->bi_iter.bi_sector = sector;
> +	bio_set_data_lifetime(bio, inode->i_write_hint);
>   	wbc_init_bio(wbc, bio);
>   
>   	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
> @@ -1690,6 +1692,7 @@ iomap_chain_bio(struct bio *prev)
>   	new = bio_alloc(prev->bi_bdev, BIO_MAX_VECS, prev->bi_opf, GFP_NOFS);
>   	bio_clone_blkg_association(new, prev);
>   	new->bi_iter.bi_sector = bio_end_sector(prev);
> +	bio_set_data_lifetime(new, bio_get_data_lifetime(prev));
>   
>   	bio_chain(prev, new);
>   	bio_get(prev);		/* for iomap_finish_ioend */
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 242e213ee064..888ca71c9ea7 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -20,6 +20,7 @@
>   #include <linux/gfp.h>
>   #include <linux/bio.h>
>   #include <linux/fs.h>
> +#include <linux/fs-lifetime.h>
>   #include <linux/buffer_head.h>
>   #include <linux/blkdev.h>
>   #include <linux/highmem.h>
> @@ -612,6 +613,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
>   				GFP_NOFS);
>   		bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
>   		wbc_init_bio(wbc, bio);
> +		bio_set_data_lifetime(bio, inode->i_write_hint);
>   	}
>   
>   	/*
> diff --git a/include/linux/fs-lifetime.h b/include/linux/fs-lifetime.h
> new file mode 100644
> index 000000000000..0e652e00cfab
> --- /dev/null
> +++ b/include/linux/fs-lifetime.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/bio.h>
> +#include <linux/fs.h>
> +#include <linux/ioprio.h>
> +
> +static inline enum rw_hint bio_get_data_lifetime(struct bio *bio)
> +{
> +	/* +1 to map 0 onto WRITE_LIFE_NONE. */
> +	return IOPRIO_PRIO_LIFETIME(bio->bi_ioprio) + 1;
> +}
> +
> +static inline void bio_set_data_lifetime(struct bio *bio, enum rw_hint lifetime)
> +{
> +	/* -1 to map WRITE_LIFE_NONE onto 0. */
> +	if (lifetime != 0)
> +		lifetime--;

How the driver can figure when lifetime is not set, and when it is set 
to WRITE_LIFE_NONE? If it uses IOPRIO_PRIO_LIFETIME (as patch 8 does), 
it will see 0 in both cases.
F2FS fs-based whint_mode seems to expect distinct streams for 
WRITE_LIFE_NOT_SET and WRITE_LIFE_NONE.
