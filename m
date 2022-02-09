Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CECC4AEF8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 11:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiBIKwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 05:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiBIKwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:52:16 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437AAC10369E
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 02:32:45 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220209103243epoutp0125827c540176997ad6aab5af95173150~SF5nojEHC1133311333epoutp01k
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 10:32:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220209103243epoutp0125827c540176997ad6aab5af95173150~SF5nojEHC1133311333epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644402763;
        bh=xz1oJ2eauM6E2SlW3H62ZnXt2LbVkrsLkClSGMzxM5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gJKUwqnhVh4I4eEzb5kLFjE5G7409xfvvGeKt+qACGvieoEoO33v4KfuM0giIpBep
         DUdJIWHvG8GD1ux0WMT12F46d4uu7OlfaWAUkoLSFw36mrtBgLftQCMaPOJO951k8G
         TUZtHoLhynEAcr8Q4trqEPbDcjzbI330oWtC5Gh8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220209103242epcas5p1b9d14dff4a692785d11aee0bb2235a63~SF5meCRJc1717917179epcas5p1M;
        Wed,  9 Feb 2022 10:32:42 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jtx5x45Sxz4x9Pt; Wed,  9 Feb
        2022 10:32:37 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.B1.06423.14893026; Wed,  9 Feb 2022 19:32:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220209102707epcas5p182e25eda8e43b51419436058022171fe~SF0uFk1Oc0483404834epcas5p1n;
        Wed,  9 Feb 2022 10:27:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220209102707epsmtrp2ddfbd25c2e7ca3b3aeb4800bc8d7bd91~SF0uEGeGg1548515485epsmtrp29;
        Wed,  9 Feb 2022 10:27:07 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-ad-6203984151ea
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.7E.29871.AF693026; Wed,  9 Feb 2022 19:27:06 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220209102702epsmtip28e2eb23f59a89efd5a93ca6a27d2a2cf~SF0qDrTpU0625906259epsmtip2R;
        Wed,  9 Feb 2022 10:27:02 +0000 (GMT)
Date:   Wed, 9 Feb 2022 15:52:08 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     mpatocka@redhat.com, javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        djwong@kernel.org, josef@toxicpanda.com, clm@fb.com,
        dsterba@suse.com, tytso@mit.edu, jack@suse.com,
        joshi.k@samsung.com, arnav.dawn@samsung.com,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH v2 03/10] block: Add copy offload support infrastructure
Message-ID: <20220209102208.GB7698@test-zns>
MIME-Version: 1.0
In-Reply-To: <2e976611-6ba1-f986-91ce-d7f59fe4dd47@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUdRTHuQ/u3nVCb4D1A6aJWahxldcW4A8SNEK8jsxIOo5OY+AFLm92
        t92lzGoENxQBQTZrF4hlFYEBJAgIkUdDCG48RR6mvMwAeRQokMYKSQsXGv/7nDPf7znnd878
        SMy8kmdNRooVrEzMxAiITXj1TaHQ8X0NFuwyonaC9fcXTGHJcDoBv3tiwODjX0ZNoSpdw4NL
        nbcx2Du2GTbMZpvC7sUEFI5WrKCw/ooKhUUlLSicKMxD4Pn2bhQuPxTBlpUZAqqa7iKwYWAH
        rG9oxWFuwTgPpvxWQ8BC/QsUZiT1o7Ara5mAN0f6cfjnYisBE1MNvD02dG/fATpDOcujlboh
        nO7tjKMris8TdOXV03Td/XiCPtPRgtGa+b8J+oJylqBvJD4wpefGB3D68c/9BJ1WVYzQZVX9
        OF3Z/kWA+UfRuyJYJpSV2bLiEElopDjcS3DgcNAHQW7uLiJHkQfcKbAVM7Gsl8DXP8DRLzLG
        uBuB7adMTJwxFcDI5QJn710ySZyCtY2QyBVeAlYaGiN1lTrJmVh5nDjcScwqPEUuLu+4GYUn
        oiPy+5pxaZb05E8zg0Q8ojyajPBJQLmCiW96TZORTaQ5VYeAy+UVBBfMI2DkUTfCBc8QcGlq
        Gtuw6PMK1i0NCFClzq9bHiHgTmYasarCKXuQWVBtdJAkQe0A7SvkatqScgMzqYn4qh6j2nAw
        mbZaiU9aUP6gXV261sGMcgCTS2qC41dBa+YYvsp8yg9M5y7wVnkrZQcaq/UoN9EAH2hzpRz7
        gpQ/OD2gLMC0vorHsTVYmG1YGxRQKQhY7HiAcoEGAcqLSoJT7QZ36v9dq4pREUCdU4Vw+TfA
        t20/rOc3gwtLY+udzUCNdoPtwLUy3XodK3D3n4R1psGzuSsYt6JGFNQnFOAXkTezXnpd1kv9
        OHYAurp5Isu4PYyyAYUvSA6FoKzWWYeYFiNWrFQeG87K3aQiMfvZ/zcPkcRWIGu/Z/v+GmT4
        9ydOTQhKIk0IIDGBpVnbaSzY3CyU+fwUK5MEyeJiWHkT4ma8VgZmvTVEYvx+YkWQyNXDxdXd
        3d3V4113keB1s/bwcsacCmcUbDTLSlnZhg8l+dbxKDW8bX/Y0Jf7coSD3sI5bdSTeGbCSUIk
        J93zvsEL053p+erQoGFb37Glc/zvPa2H4UGXt1Ovv2VXmv/cLyr1+PG/tHvzGLOd6irhrYx0
        h8sWB5tPldYe0x/9pFb/ymutV00CJVbaShPHIZvlj6XBWOCe90pJw76uLYNke0M29JsaPemX
        5sP6Zdvv/nV0MqfZt3Fcnmt7CdPY0SbTUcUq6dStnl5hpY/h64WS5mb72BTD2SPlZ08EBVjc
        ru6xIk18+n29yzrnuxTa5w+h5TU+c+96UmB8xVx4bJSVr60/nYJqzz3tSM/HU3UfqhZ+VGs8
        D4metsYfCaO2TDsvVRUVKQ8LcHkEI9qOyeTMf/YooGnGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7bCSvO6vacxJBnfmmlrsufmZ1WL13X42
        i2kffjJbvD/4mNViUv8MdovfZ88zW1x+wmex991sVosLPxqZLB5v+s9ksWfRJCaLlauPMlk8
        X76Y0aLz9AUmiz8PDS2O/n/LZjHp0DVGi723tC327D3JYjF/2VN2i+7rO9gslh//x2QxseMq
        k8W5WX/YLA7fu8pi8frHSTaL1p6f7A7SHpeveHtMbH7H7tG84A6Lx+WzpR6bVnWyeWxeUu+x
        +2YDm0fTmaPMHjM+fWHz6G1+x+axs/U+q8fHp7dYPN7vu8rm0bdlFaPH+i1XWTw2n64OEIri
        sklJzcksSy3St0vgypgxKa/gVm7F4oMvmRoY74R0MXJySAiYSBxfvIy1i5GLQ0hgN6PE1jkL
        2SESkhLL/h5hhrCFJVb+e84OUfSEUeLx0VesIAkWARWJmcu2ARVxcLAJaEuc/s8BEhYRMJV4
        29PKAlLPLHCKReLcwt9g9cICPhKnp68FG8oroCPx4vd0NoihB5gkNvf8ZYdICEqcnPmEBcRm
        FtCSuPHvJRPIAmYBaYnl/8AWcAq4Sbya/xmsXFRAWeLAtuNMExgFZyHpnoWkexZC9wJG5lWM
        kqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMHJQktzB+P2VR/0DjEycTAeYpTgYFYS4T1V
        z5wkxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9N8Fy3V
        /w++qn7x/bmStYLZyKXzQdoqyWiRxv7LS1+lqTn2XVDe9Shbwv+KgPWKKdaq+wVFJkxadWJ2
        15FVx6wS1vxxFT3BVOvgczZAYOHFZ6xKJ7fsnPg3xkf237y+hd43V0UUV4kfbZ4lk/Blbmvn
        JC5mllKNi+6H2RVYgjxKLB0ZZ91bvThhk3Tg8871WxrDsxOLNniuk3/+2SItuedLVNN5+1iz
        7a9/Oa56WuwjlS3qqffC5b2Wx825+1zM+w/uXa9rabxG8opk+R/pa66nPVtFtB8xpn1/ypW+
        0nSBotrVr39ffBB5OnXzn+hvSnwZGV2fhfYFWqzgqeK2/KhitaTUivegW9WhgP0sE5VYijMS
        DbWYi4oTAetEuTmFAwAA
X-CMS-MailID: 20220209102707epcas5p182e25eda8e43b51419436058022171fe
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----whw7GLWDXQn0DNT5QbpmV5iNJmL06zVCQqLt8G63uv36fYb2=_5f708_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141918epcas5p4f9badc0c3f3f0913f091c850d2d3bd81
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141918epcas5p4f9badc0c3f3f0913f091c850d2d3bd81@epcas5p4.samsung.com>
        <20220207141348.4235-4-nj.shetty@samsung.com>
        <2e976611-6ba1-f986-91ce-d7f59fe4dd47@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------whw7GLWDXQn0DNT5QbpmV5iNJmL06zVCQqLt8G63uv36fYb2=_5f708_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

O Tue, Feb 08, 2022 at 04:21:19PM +0900, Damien Le Moal wrote:
> On 2/7/22 23:13, Nitesh Shetty wrote:
> > Introduce blkdev_issue_copy which supports source and destination bdevs,
> > and a array of (source, destination and copy length) tuples.
> 
> s/a/an
>

acked

> > Introduce REQ_COP copy offload operation flag. Create a read-write
> 
> REQ_COPY ?
>

acked

> > bio pair with a token as payload and submitted to the device in order.
> > the read request populates token with source specific information which
> > is then passed with write request.
> > Ths design is courtsey Mikulas Patocka<mpatocka@>'s token based copy
> 
> s/Ths design is courtsey/This design is courtesy of
>

acked

> > 
> > Larger copy operation may be divided if necessary by looking at device
> > limits.
> 
> may or will ?
> by looking at -> depending on the ?
> 

Larger copy will be divided, based on max_copy_sectors,max_copy_range_sector
limits. Will add in next series.

> > 
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> > Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> > ---
> >  block/blk-lib.c           | 216 ++++++++++++++++++++++++++++++++++++++
> >  block/blk-settings.c      |   2 +
> >  block/blk.h               |   2 +
> >  include/linux/blk_types.h |  20 ++++
> >  include/linux/blkdev.h    |   3 +
> >  include/uapi/linux/fs.h   |  14 +++
> >  6 files changed, 257 insertions(+)
> > 
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index 1b8ced45e4e5..3ae2c27b566e 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -135,6 +135,222 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
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
> > +
> > +	while (atomic_read(&cio->refcount)) {
> > +		cio->waiter = current;
> > +		__set_current_state(TASK_UNINTERRUPTIBLE);
> > +		blk_io_schedule();
> > +		/* wake up sets us TASK_RUNNING */
> > +		cio->waiter = NULL;
> > +		ret = cio->io_err;
> 
> Why is this in the loop ?
>

agree.

> > +	}
> > +	kvfree(cio);
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
> > +
> > +	if (bio->bi_status) {
> > +		cio->io_err = bio->bi_status;
> > +		clen = (bio->bi_iter.bi_sector - ctx->start_sec) << SECTOR_SHIFT;
> > +		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);
> > +	}
> > +	__free_page(bio->bi_io_vec[0].bv_page);
> > +	kfree(ctx);
> > +	bio_put(bio);
> > +
> > +	if (atomic_dec_and_test(&cio->refcount) && cio->waiter)
> > +		wake_up_process(cio->waiter);
> 
> This looks racy: the cio->waiter test and wakeup are not atomic.

agreed, will remove atomic for refcount and add if check and wakeup in locks
in next version.

> > +}
> > +
> > +/*
> > + * blk_copy_offload	- Use device's native copy offload feature
> > + * Go through user provide payload, prepare new payload based on device's copy offload limits.
> > + */
> > +int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
> > +		struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)
> > +{
> > +	struct request_queue *sq = bdev_get_queue(src_bdev);
> > +	struct request_queue *dq = bdev_get_queue(dst_bdev);
> > +	struct bio *read_bio, *write_bio;
> > +	struct copy_ctx *ctx;
> > +	struct cio *cio;
> > +	struct page *token;
> > +	sector_t src_blk, copy_len, dst_blk;
> > +	sector_t remaining, max_copy_len = LONG_MAX;
> > +	int ri = 0, ret = 0;
> > +
> > +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
> > +	if (!cio)
> > +		return -ENOMEM;
> > +	atomic_set(&cio->refcount, 0);
> > +	cio->rlist = rlist;
> > +
> > +	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_sectors,
> > +			(sector_t)dq->limits.max_copy_sectors);
> 
> sq->limits.max_copy_sectors is already by definition smaller than
> LONG_MAX, so there is no need for the min3 here.
>

acked

> > +	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
> > +			(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;> +
> > +	for (ri = 0; ri < nr_srcs; ri++) {
> > +		cio->rlist[ri].comp_len = rlist[ri].len;
> > +		for (remaining = rlist[ri].len, src_blk = rlist[ri].src, dst_blk = rlist[ri].dst;
> > +			remaining > 0;
> > +			remaining -= copy_len, src_blk += copy_len, dst_blk += copy_len) {
> 
> This is unreadable.
> 

Sure, I will simplify the loops in next version.

> > +			copy_len = min(remaining, max_copy_len);
> > +
> > +			token = alloc_page(gfp_mask);
> > +			if (unlikely(!token)) {
> > +				ret = -ENOMEM;
> > +				goto err_token;
> > +			}
> > +
> > +			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
> > +					gfp_mask);
> > +			if (!read_bio) {
> > +				ret = -ENOMEM;
> > +				goto err_read_bio;
> > +			}
> > +			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
> > +			read_bio->bi_iter.bi_size = copy_len;
> > +			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> > +			ret = submit_bio_wait(read_bio);
> > +			if (ret) {
> > +				bio_put(read_bio);
> > +				goto err_read_bio;
> > +			}
> > +			bio_put(read_bio);
> > +			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> > +			if (!ctx) {
> > +				ret = -ENOMEM;
> > +				goto err_read_bio;
> > +			}
> 
> This should be done before the read.
>

acked.

> > +			ctx->cio = cio;
> > +			ctx->range_idx = ri;
> > +			ctx->start_sec = rlist[ri].src;
> > +
> > +			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
> > +					gfp_mask);
> > +			if (!write_bio) {
> > +				ret = -ENOMEM;
> > +				goto err_read_bio;
> > +			}
> > +
> > +			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
> > +			write_bio->bi_iter.bi_size = copy_len;
> > +			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
> > +			write_bio->bi_end_io = bio_copy_end_io;
> > +			write_bio->bi_private = ctx;
> > +			atomic_inc(&cio->refcount);
> > +			submit_bio(write_bio);
> > +		}
> > +	}
> > +
> > +	/* Wait for completion of all IO's*/
> > +	return cio_await_completion(cio);
> > +
> > +err_read_bio:
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
> > +		if ((rlist[i].dst & align_mask) || (rlist[i].src & align_mask) ||
> > +				(rlist[i].len & align_mask))
> > +			return -EINVAL;
> > +		rlist[i].comp_len = 0;
> > +	}
> > +
> > +	if (!len && len >= MAX_COPY_TOTAL_LENGTH)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static inline bool blk_check_copy_offload(struct request_queue *src_q,
> > +		struct request_queue *dest_q)
> > +{
> > +	if (dest_q->limits.copy_offload == BLK_COPY_OFFLOAD &&
> > +			src_q->limits.copy_offload == BLK_COPY_OFFLOAD)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * blkdev_issue_copy - queue a copy
> > + * @src_bdev:	source block device
> > + * @nr_srcs:	number of source ranges to copy
> > + * @src_rlist:	array of source ranges
> > + * @dest_bdev:	destination block device
> > + * @gfp_mask:   memory allocation flags (for bio_alloc)
> > + * @flags:	BLKDEV_COPY_* flags to control behaviour
> > + *
> > + * Description:
> > + *	Copy source ranges from source block device to destination block device.
> > + *	length of a source range cannot be zero.
> > + */
> > +int blkdev_issue_copy(struct block_device *src_bdev, int nr,
> > +		struct range_entry *rlist, struct block_device *dest_bdev,
> > +		gfp_t gfp_mask, int flags)
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
> > +
> > +	if (bdev_read_only(dest_bdev))
> > +		return -EPERM;
> > +
> > +	ret = blk_copy_sanity_check(src_bdev, dest_bdev, rlist, nr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (blk_check_copy_offload(src_q, dest_q))
> > +		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(blkdev_issue_copy);
> > +
> >  /**
> >   * __blkdev_issue_write_same - generate number of bios with same page
> >   * @bdev:	target blockdev
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 818454552cf8..4c8d48b8af25 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -545,6 +545,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >  	t->max_segment_size = min_not_zero(t->max_segment_size,
> >  					   b->max_segment_size);
> >  
> > +	t->max_copy_sectors = min_not_zero(t->max_copy_sectors, b->max_copy_sectors);
> 
> Why min_not_zero ? If one of the underlying drive does not support copy
> offload, you cannot report that the top drive does.
>

agreed. Will update in next series.

> > +
> >  	t->misaligned |= b->misaligned;
> >  
> >  	alignment = queue_limit_alignment_offset(b, start);
> > diff --git a/block/blk.h b/block/blk.h
> > index abb663a2a147..94d2b055750b 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -292,6 +292,8 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
> >  		break;
> >  	}
> >  
> > +	if (unlikely(op_is_copy(bio->bi_opf)))
> > +		return false;
> >  	/*
> >  	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
> >  	 * This is a quick and dirty check that relies on the fact that
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 5561e58d158a..0a3fee8ad61c 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -418,6 +418,7 @@ enum req_flag_bits {
> >  	/* for driver use */
> >  	__REQ_DRV,
> >  	__REQ_SWAP,		/* swapping request. */
> > +	__REQ_COPY,		/* copy request*/
> >  	__REQ_NR_BITS,		/* stops here */
> >  };
> >  
> > @@ -442,6 +443,7 @@ enum req_flag_bits {
> >  
> >  #define REQ_DRV			(1ULL << __REQ_DRV)
> >  #define REQ_SWAP		(1ULL << __REQ_SWAP)
> > +#define REQ_COPY		(1ULL << __REQ_COPY)
> >  
> >  #define REQ_FAILFAST_MASK \
> >  	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
> > @@ -498,6 +500,11 @@ static inline bool op_is_discard(unsigned int op)
> >  	return (op & REQ_OP_MASK) == REQ_OP_DISCARD;
> >  }
> >  
> > +static inline bool op_is_copy(unsigned int op)
> > +{
> > +	return (op & REQ_COPY);
> > +}
> > +
> >  /*
> >   * Check if a bio or request operation is a zone management operation, with
> >   * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a special case
> > @@ -532,4 +539,17 @@ struct blk_rq_stat {
> >  	u64 batch;
> >  };
> >  
> > +struct cio {
> > +	atomic_t refcount;
> > +	blk_status_t io_err;
> > +	struct range_entry *rlist;
> > +	struct task_struct *waiter;     /* waiting task (NULL if none) */
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
> > index f63ae50f1de3..15597488040c 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1120,6 +1120,9 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> >  		struct bio **biop);
> >  struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
> >  		gfp_t gfp_mask);
> > +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> > +		struct range_entry *src_rlist, struct block_device *dest_bdev,
> > +		gfp_t gfp_mask, int flags);
> >  
> >  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
> >  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index bdf7b404b3e7..55bca8f6e8ed 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -64,6 +64,20 @@ struct fstrim_range {
> >  	__u64 minlen;
> >  };
> >  
> > +/* Maximum no of entries supported */
> > +#define MAX_COPY_NR_RANGE	(1 << 12)
> > +
> > +/* maximum total copy length */
> > +#define MAX_COPY_TOTAL_LENGTH	(1 << 21)
> > +
> > +/* Source range entry for copy */
> > +struct range_entry {
> > +	__u64 src;
> > +	__u64 dst;
> > +	__u64 len;
> > +	__u64 comp_len;
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

 -- 
Thank you
Nitesh

------whw7GLWDXQn0DNT5QbpmV5iNJmL06zVCQqLt8G63uv36fYb2=_5f708_
Content-Type: text/plain; charset="utf-8"


------whw7GLWDXQn0DNT5QbpmV5iNJmL06zVCQqLt8G63uv36fYb2=_5f708_--
