Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1896512019
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244618AbiD0SMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 14:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiD0SMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:12:01 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207922B270
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 11:08:45 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220427180843epoutp0178b4eb173d27cb3946287b6379a7f3c2~p0yu7GyvV2002920029epoutp011
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 18:08:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220427180843epoutp0178b4eb173d27cb3946287b6379a7f3c2~p0yu7GyvV2002920029epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651082923;
        bh=/JbRXKA3/ARykIpMGGbQAmpbNBVgcwVPRHQxMrS0nUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TtGGtPBA1G2wZP6gJ2gClu2//g0yVYlAWVvTz5sMaWPp17Fhi0f6pIPTKZGMj2WLs
         xa3OqWLUAgxsdsz7GlcZL8JHEmfV1r8fRIGAvXjSmGr7PX/ryIvRZuDH5C+NpEGt3t
         92qJtpV+RB57PVuYttQ3aABn/+PQxwRzSvIQnh30=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220427180842epcas5p4d3cb15db2b9bb7cb199f3134d9ae49e9~p0yuLwjGh3079930799epcas5p4H;
        Wed, 27 Apr 2022 18:08:42 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KpRZZ3KqNz4x9Pq; Wed, 27 Apr
        2022 18:08:38 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.27.09762.6A689626; Thu, 28 Apr 2022 03:08:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220427152044epcas5p4c46d938a9bd50c208e31ecf1fdcc4368~pygEzuuGw2527625276epcas5p4w;
        Wed, 27 Apr 2022 15:20:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427152044epsmtrp1c1d3e4fd6ec3fcf9242ad99f1e68f4f2~pygEy2MTH1130711307epsmtrp1P;
        Wed, 27 Apr 2022 15:20:44 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-3a-626986a6ac8a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.48.08853.C4F59626; Thu, 28 Apr 2022 00:20:44 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427152043epsmtip2b5cec0ccc493e253275309c4ca4b2fd3~pygDdInx_0088200882epsmtip2Q;
        Wed, 27 Apr 2022 15:20:43 +0000 (GMT)
Date:   Wed, 27 Apr 2022 20:45:35 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] block: Add copy offload support infrastructure
Message-ID: <20220427151535.GC9558@test-zns>
MIME-Version: 1.0
In-Reply-To: <7d1fdd1e-c854-4744-8bec-7d222fb9be76@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmhu6ytswkg473Iha/z55nttj7bjar
        xd5b2hZ79p5ksbi8aw6bxfxlT9ktuq/vYLPY8aSR0YHDY+esu+wem5fUe+xsvc/q8X7fVTaP
        z5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgY
        mQIVJmRnzHrlVvCvrmJx8yaWBsbtSV2MnBwSAiYS+/81M3cxcnEICexmlFj5YQmU84lR4uvD
        pSwQzjdGiU03brHDtOz7fJoNIrGXUeL7oa1QLc8YJc7tvsYCUsUioCrR8+MwUBUHB5uAtsTp
        /xwgYREBU4m3Pa1gU5kFzjBKtL/fBTZVWMBHYvmJaYwgNq+AjsTPjllMELagxMmZT8Bmcgq4
        SWw5dJANxBYVUJY4sO04E8ggCYFODomXZw+xQpznIvFgyzMoW1ji1fEtUGdLSbzsb4OyyyW2
        ty2Aam5hlOg6dYoFImEvcXHPX7DNzAIZEr/fNjBCxGUlpp5aBxXnk+j9/YQJIs4rsWMejK0s
        sWb9AjYIW1Li2vdGKNtDYt7eJ9CA/M0ocXDjWcYJjPKzkHw3C8k+CFtHYsHuT2yzgKHHLCAt
        sfwfB4SpKbF+l/4CRtZVjJKpBcW56anFpgXGeanl8ChPzs/dxAhOqlreOxgfPfigd4iRiYPx
        EKMEB7OSCO+X3RlJQrwpiZVVqUX58UWlOanFhxhNgbE1kVlKNDkfmNbzSuINTSwNTMzMzEws
        jc0MlcR5T6VvSBQSSE8sSc1OTS1ILYLpY+LglGpg0pwUpjXpflfG+hssreqLWmNqfiQ6l73b
        Va5qz7Hd7cMnpsaMk7IqXtfZN9WpP3X97GZ1SpVHbcH1bCuTXQIv3/3+G/BDz2z2haIdqV0M
        JRmd7d3FG5JPiTzLPC54itlOa06HyucT+5YIqSoofv05M854+onJT6YpWa72X19zo9Yh+8IX
        L7ntNr+VN5z8vZbFVavmFuNSrviPzMI/5RdqFuQalrOXnJfw0w5vrHqx8CT7PW7j+vQ9b0Pk
        S28tEjc6JNbxc6JC44oj2ysucew/Kratr0Eq8bCE790UZ/90DYdgierHAZ4PXNZt8HHqXsz0
        avPeStOf6ifTdt6+OytHUpDj4v3Zr/tTOkJ6V0UosRRnJBpqMRcVJwIAJjebFTMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvK5PfGaSwc+Phha/z55nttj7bjar
        xd5b2hZ79p5ksbi8aw6bxfxlT9ktuq/vYLPY8aSR0YHDY+esu+wem5fUe+xsvc/q8X7fVTaP
        z5vkAlijuGxSUnMyy1KL9O0SuDLud91iLthXU7H5+Wr2BsYJCV2MnBwSAiYS+z6fZuti5OIQ
        EtjNKHFx8y9WiISkxLK/R5ghbGGJlf+es4PYQgJPGCVOvnEEsVkEVCV6fhwGaubgYBPQljj9
        nwMkLCJgKvG2p5UFZCazwBlGifb3u8B6hQV8JJafmMYIYvMK6Ej87JjFBLH4N6PEur7pzBAJ
        QYmTM5+wgNjMAloSN/69ZAJZwCwgLbH8H9gCTgE3iS2HDrKB2KICyhIHth1nmsAoOAtJ9ywk
        3bMQuhcwMq9ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOBC3NHYzbV33QO8TIxMF4
        iFGCg1lJhPfL7owkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
        ODilGphyy5ebrj72cEMpm3xSedHM3Hf7S9ZPLDyV5WNkOf+KhndknMu2D7W7pCbHrXZzepSx
        80bsY5PDWTMPfY4pMJmp8nEeQ0r+H/ad1w7wZLw6Oefw5/sMSv29ryqljx/8rtQ7yURad9rD
        DR8On9vQKFe59aXEi2tWPTpnRJ8s65BZ8yOw5pN3wpvelXJ309K+qluvOpwdI3TIt1goymmf
        a6THljCGiTue7ny/37Ny+b7jEaE1jZlVusLtYmWNS5LZMr4+/FN8+rr124knc72q30Qddjhe
        qPHo8+Mvmz2+G/2y9tRudZddK3Vkp6imzvZnMbuTVvK3v7vberX/xh0Lc9HGY5rlHrITmurP
        xe3aGcOgxFKckWioxVxUnAgAezrNQ/MCAAA=
X-CMS-MailID: 20220427152044epcas5p4c46d938a9bd50c208e31ecf1fdcc4368
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----0ZLlJYeDNsXsa2iHVDx88FJSiXNelWJlSsIznY99o6DAaXg4=_17ced_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426101921epcas5p341707619b5e836490284a42c92762083
References: <20220426101241.30100-1-nj.shetty@samsung.com>
        <CGME20220426101921epcas5p341707619b5e836490284a42c92762083@epcas5p3.samsung.com>
        <20220426101241.30100-3-nj.shetty@samsung.com>
        <7d1fdd1e-c854-4744-8bec-7d222fb9be76@opensource.wdc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------0ZLlJYeDNsXsa2iHVDx88FJSiXNelWJlSsIznY99o6DAaXg4=_17ced_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Apr 27, 2022 at 11:45:26AM +0900, Damien Le Moal wrote:
> On 4/26/22 19:12, Nitesh Shetty wrote:
> > Introduce blkdev_issue_copy which supports source and destination bdevs,
> > and an array of (source, destination and copy length) tuples.
> > Introduce REQ_COPY copy offload operation flag. Create a read-write
> > bio pair with a token as payload and submitted to the device in order.
> > Read request populates token with source specific information which
> > is then passed with write request.
> > This design is courtesy Mikulas Patocka's token based copy
> > 
> > Larger copy will be divided, based on max_copy_sectors,
> > max_copy_range_sector limits.
> > 
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> > ---
> >  block/blk-lib.c           | 232 ++++++++++++++++++++++++++++++++++++++
> >  block/blk.h               |   2 +
> >  include/linux/blk_types.h |  21 ++++
> >  include/linux/blkdev.h    |   2 +
> >  include/uapi/linux/fs.h   |  14 +++
> >  5 files changed, 271 insertions(+)
> > 
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index 09b7e1200c0f..ba9da2d2f429 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -117,6 +117,238 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> >  }
> >  EXPORT_SYMBOL(blkdev_issue_discard);
> >  
> > +/*
> > + * Wait on and process all in-flight BIOs.  This must only be called once
> > + * all bios have been issued so that the refcount can only decrease.
> > + * This just waits for all bios to make it through bio_copy_end_io. IO
> > + * errors are propagated through cio->io_error.
> > + */
> > +static int cio_await_completion(struct cio *cio)
> > +{
> > +	int ret = 0;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&cio->lock, flags);
> > +	if (cio->refcount) {
> > +		cio->waiter = current;
> > +		__set_current_state(TASK_UNINTERRUPTIBLE);
> > +		spin_unlock_irqrestore(&cio->lock, flags);
> > +		blk_io_schedule();
> > +		/* wake up sets us TASK_RUNNING */
> > +		spin_lock_irqsave(&cio->lock, flags);
> > +		cio->waiter = NULL;
> > +		ret = cio->io_err;
> > +	}
> > +	spin_unlock_irqrestore(&cio->lock, flags);
> > +	kvfree(cio);
> 
> cio is allocated with kzalloc() == kmalloc(). So why the kvfree() here ?
>

acked.

> > +
> > +	return ret;
> > +}
> > +
> > +static void bio_copy_end_io(struct bio *bio)
> > +{
> > +	struct copy_ctx *ctx = bio->bi_private;
> > +	struct cio *cio = ctx->cio;
> > +	sector_t clen;
> > +	int ri = ctx->range_idx;
> > +	unsigned long flags;
> > +	bool wake = false;
> > +
> > +	if (bio->bi_status) {
> > +		cio->io_err = bio->bi_status;
> > +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - ctx->start_sec;
> > +		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);
> 
> long line.

Is it because line is more than 80 character, I thought limit is 100 now, so
went with longer lines ?

> 
> > +	}
> > +	__free_page(bio->bi_io_vec[0].bv_page);
> > +	kfree(ctx);
> > +	bio_put(bio);
> > +
> > +	spin_lock_irqsave(&cio->lock, flags);
> > +	if (((--cio->refcount) <= 0) && cio->waiter)
> > +		wake = true;
> > +	spin_unlock_irqrestore(&cio->lock, flags);
> > +	if (wake)
> > +		wake_up_process(cio->waiter);
> > +}
> > +
> > +/*
> > + * blk_copy_offload	- Use device's native copy offload feature
> > + * Go through user provide payload, prepare new payload based on device's copy offload limits.
> 
> long line.
> 

Same as above

> > + */
> > +int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
> > +		struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)
> 
> long line.
>

Same as above

> rlist is an array, but rlist naming implies a list. Why not call that
> argument "ranges" ?
> 
> The argument ordering is also strange. I would make that:
> 
> blk_copy_offload(struct block_device *src_bdev,
> 	         struct block_device *dst_bdev,
> 		 struct range_entry *rlist, int nr_srcs,
> 		 gfp_t gfp_mask)
> 

Yes, looks better. We will update in next version.
One doubt, this arguments ordering is based on size ?
Since we ordered it with logic that, we use nr_srcs to get number of entries
in rlist(ranges).

> > +{
> > +	struct request_queue *sq = bdev_get_queue(src_bdev);
> > +	struct request_queue *dq = bdev_get_queue(dst_bdev);
> > +	struct bio *read_bio, *write_bio;
> > +	struct copy_ctx *ctx;
> > +	struct cio *cio;
> > +	struct page *token;
> > +	sector_t src_blk, copy_len, dst_blk;
> > +	sector_t remaining, max_copy_len = LONG_MAX;
> > +	unsigned long flags;
> > +	int ri = 0, ret = 0;
> > +
> > +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
> > +	if (!cio)
> > +		return -ENOMEM;
> > +	cio->rlist = rlist;
> > +	spin_lock_init(&cio->lock);
> > +
> > +	max_copy_len = min_t(sector_t, sq->limits.max_copy_sectors, dq->limits.max_copy_sectors);
> > +	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
> > +			(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;
> 
> But max_copy_range_sectors is for one sector only, right ? So what is this
> second min3() doing ? It is mixing up total length and one range length.
> The device should not have reported a per range max length larger than the
> total length in the first place, right ? If it does, that would be a very
> starnge device...
> 

Yeah you are right, makes sense, will update in next version.

> > +
> > +	for (ri = 0; ri < nr_srcs; ri++) {
> > +		cio->rlist[ri].comp_len = rlist[ri].len;
> > +		src_blk = rlist[ri].src;
> > +		dst_blk = rlist[ri].dst;
> > +		for (remaining = rlist[ri].len; remaining > 0; remaining -= copy_len) {
> > +			copy_len = min(remaining, max_copy_len);
> > +
> > +			token = alloc_page(gfp_mask);
> > +			if (unlikely(!token)) {
> > +				ret = -ENOMEM;
> > +				goto err_token;
> > +			}
> > +
> > +			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> > +			if (!ctx) {
> > +				ret = -ENOMEM;
> > +				goto err_ctx;
> > +			}
> > +			ctx->cio = cio;
> > +			ctx->range_idx = ri;
> > +			ctx->start_sec = dst_blk;
> > +
> > +			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
> > +					gfp_mask);
> > +			if (!read_bio) {
> > +				ret = -ENOMEM;
> > +				goto err_read_bio;
> > +			}
> > +			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
> > +			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> > +			/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
> > +			read_bio->bi_iter.bi_size = copy_len;
> > +			ret = submit_bio_wait(read_bio);
> > +			bio_put(read_bio);
> > +			if (ret)
> > +				goto err_read_bio;
> > +
> > +			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
> > +					gfp_mask);
> > +			if (!write_bio) {
> > +				ret = -ENOMEM;
> > +				goto err_read_bio;
> > +			}
> > +			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
> > +			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
> > +			/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
> > +			write_bio->bi_iter.bi_size = copy_len;
> > +			write_bio->bi_end_io = bio_copy_end_io;
> > +			write_bio->bi_private = ctx;
> > +
> > +			spin_lock_irqsave(&cio->lock, flags);
> > +			++cio->refcount;
> 
> Shouldn't this be an atomic_t ?
> 

We changed it to normal variable and used a single spin_lock to avoid race
condition on refcount and current process wakeup in completion path.
Since for making copy asynchronous, we needed to store process
context as well. So there was a possibility of race condition.
https://lore.kernel.org/all/20220209102208.GB7698@test-zns/

> And wrap lines please. Many are too long.
> 
> > +			spin_unlock_irqrestore(&cio->lock, flags);
> > +
> > +			submit_bio(write_bio);
> > +			src_blk += copy_len;
> > +			dst_blk += copy_len;
> > +		}
> > +	}
> > +
> > +	/* Wait for completion of all IO's*/
> > +	return cio_await_completion(cio);
> > +
> > +err_read_bio:
> > +	kfree(ctx);
> > +err_ctx:
> > +	__free_page(token);
> > +err_token:
> > +	rlist[ri].comp_len = min_t(sector_t, rlist[ri].comp_len, (rlist[ri].len - remaining));
> > +
> > +	cio->io_err = ret;
> > +	return cio_await_completion(cio);
> > +}
> > +
> > +static inline int blk_copy_sanity_check(struct block_device *src_bdev,
> > +		struct block_device *dst_bdev, struct range_entry *rlist, int nr)
> > +{
> > +	unsigned int align_mask = max(
> > +			bdev_logical_block_size(dst_bdev), bdev_logical_block_size(src_bdev)) - 1;
> > +	sector_t len = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < nr; i++) {
> > +		if (rlist[i].len)
> > +			len += rlist[i].len;
> > +		else
> > +			return -EINVAL;
> 
> Reverse the if condition and return to avoid the else.
> 

acked

> > +		if ((rlist[i].dst & align_mask) || (rlist[i].src & align_mask) ||
> > +				(rlist[i].len & align_mask))
> > +			return -EINVAL;
> > +		rlist[i].comp_len = 0;
> > +	}
> > +
> > +	if (len && len >= MAX_COPY_TOTAL_LENGTH)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static inline bool blk_check_copy_offload(struct request_queue *src_q,
> > +		struct request_queue *dest_q)
> > +{
> > +	if (blk_queue_copy(dest_q) && blk_queue_copy(src_q))
> > +		return true;
> > +
> > +	return false;
> 
> return blk_queue_copy(dest_q) && blk_queue_copy(src_q);
> 
> would be simpler.
> 

acked

> > +}
> > +
> > +/*
> > + * blkdev_issue_copy - queue a copy
> > + * @src_bdev:	source block device
> > + * @nr_srcs:	number of source ranges to copy
> > + * @rlist:	array of source/dest/len
> > + * @dest_bdev:	destination block device
> > + * @gfp_mask:   memory allocation flags (for bio_alloc)
> > + *
> > + * Description:
> > + *	Copy source ranges from source block device to destination block device.
> > + *	length of a source range cannot be zero.
> > + */
> > +int blkdev_issue_copy(struct block_device *src_bdev, int nr,
> > +		struct range_entry *rlist, struct block_device *dest_bdev, gfp_t gfp_mask)
> 
> same comment as above about args order and naming.
> 

acked

> > +{
> > +	struct request_queue *src_q = bdev_get_queue(src_bdev);
> > +	struct request_queue *dest_q = bdev_get_queue(dest_bdev);
> > +	int ret = -EINVAL;
> > +
> > +	if (!src_q || !dest_q)
> > +		return -ENXIO;
> > +
> > +	if (!nr)
> > +		return -EINVAL;
> > +
> > +	if (nr >= MAX_COPY_NR_RANGE)
> > +		return -EINVAL;
> 
> Where do you check the number of ranges against what the device can do ?
>

The present implementation submits only one range at a time. This was done to 
make copy offload generic, so that other types of copy implementation such as
XCOPY should be able to use same infrastructure. Downside at present being
NVMe copy offload is not optimal.

> > +
> > +	if (bdev_read_only(dest_bdev))
> > +		return -EPERM;
> > +
> > +	ret = blk_copy_sanity_check(src_bdev, dest_bdev, rlist, nr);
> > +	if (ret)
> > +		return ret;
> 
> nr check should be in this function...
> 
> > +
> > +	if (blk_check_copy_offload(src_q, dest_q))
> 
> ...which should be only one function with this one.
> 

Sure, we can combine blk_copy_sanity_check and blk_check_copy_offload.

> > +		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(blkdev_issue_copy);
> > +
> >  static int __blkdev_issue_write_zeroes(struct block_device *bdev,
> >  		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
> >  		struct bio **biop, unsigned flags)
> > diff --git a/block/blk.h b/block/blk.h
> > index 434017701403..6010eda58c70 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -291,6 +291,8 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
> >  		break;
> >  	}
> >  
> > +	if (unlikely(op_is_copy(bio->bi_opf)))
> > +		return false;
> >  	/*
> >  	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
> >  	 * This is a quick and dirty check that relies on the fact that
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index c62274466e72..f5b01f284c43 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -418,6 +418,7 @@ enum req_flag_bits {
> >  	/* for driver use */
> >  	__REQ_DRV,
> >  	__REQ_SWAP,		/* swapping request. */
> > +	__REQ_COPY,		/* copy request */
> >  	__REQ_NR_BITS,		/* stops here */
> >  };
> >  
> > @@ -443,6 +444,7 @@ enum req_flag_bits {
> >  
> >  #define REQ_DRV			(1ULL << __REQ_DRV)
> >  #define REQ_SWAP		(1ULL << __REQ_SWAP)
> > +#define REQ_COPY		(1ULL << __REQ_COPY)
> >  
> >  #define REQ_FAILFAST_MASK \
> >  	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
> > @@ -459,6 +461,11 @@ enum stat_group {
> >  	NR_STAT_GROUPS
> >  };
> >  
> > +static inline bool op_is_copy(unsigned int op)
> > +{
> > +	return (op & REQ_COPY);
> > +}
> > +
> >  #define bio_op(bio) \
> >  	((bio)->bi_opf & REQ_OP_MASK)
> >  
> > @@ -533,4 +540,18 @@ struct blk_rq_stat {
> >  	u64 batch;
> >  };
> >  
> > +struct cio {
> > +	struct range_entry *rlist;
> 
> naming... This is an array, right ?
>

acked, will update in next version.

> > +	struct task_struct *waiter;     /* waiting task (NULL if none) */
> > +	spinlock_t lock;		/* protects refcount and waiter */
> > +	int refcount;
> > +	blk_status_t io_err;
> > +};
> > +
> > +struct copy_ctx {
> > +	int range_idx;
> > +	sector_t start_sec;
> > +	struct cio *cio;
> > +};
> > +
> >  #endif /* __LINUX_BLK_TYPES_H */
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 3596fd37fae7..c6cb3fe82ba2 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1121,6 +1121,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> >  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
> >  int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
> >  		sector_t nr_sects, gfp_t gfp);
> > +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> > +		struct range_entry *src_rlist, struct block_device *dest_bdev, gfp_t gfp_mask);
> >  
> >  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
> >  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index bdf7b404b3e7..822c28cebf3a 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -64,6 +64,20 @@ struct fstrim_range {
> >  	__u64 minlen;
> >  };
> >  
> > +/* Maximum no of entries supported */
> > +#define MAX_COPY_NR_RANGE	(1 << 12)
> 
> This value should be used also when setting the limits in the previous
> patch. max_copy_nr_ranges and max_hw_copy_nr_ranges must be bounded by it.
> 

acked.

> > +
> > +/* maximum total copy length */
> > +#define MAX_COPY_TOTAL_LENGTH	(1 << 27)
> 
> Same for this one. And where does this magic number come from ?
>

We used this as max size for local testing, so as not to hang resources in case
of emulation. Feel free to suggest better values if you have anything in mind !!

> > +
> > +/* Source range entry for copy */
> > +struct range_entry {
> > +	__u64 src;
> > +	__u64 dst;
> > +	__u64 len;
> > +	__u64 comp_len;
> 
> Please describe the fields of this structure. The meaning of them is
> really not clear from the names.
> 

acked

> > +};
> > +
> >  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
> >  #define FILE_DEDUPE_RANGE_SAME		0
> >  #define FILE_DEDUPE_RANGE_DIFFERS	1
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

------0ZLlJYeDNsXsa2iHVDx88FJSiXNelWJlSsIznY99o6DAaXg4=_17ced_
Content-Type: text/plain; charset="utf-8"


------0ZLlJYeDNsXsa2iHVDx88FJSiXNelWJlSsIznY99o6DAaXg4=_17ced_--
