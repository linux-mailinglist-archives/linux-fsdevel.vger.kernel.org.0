Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D2566935D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 10:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjAMJxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 04:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbjAMJxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:53:11 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877E669B2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 01:49:11 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230113094909epoutp028da9cb42596c0d214092209c776beb24~51WD4UhUc0340003400epoutp02X
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 09:49:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230113094909epoutp028da9cb42596c0d214092209c776beb24~51WD4UhUc0340003400epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673603349;
        bh=JFfnTIZ6r+JFqnxISaJYhf4OWzdmN8glG3wuo+kuUtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m3nsKSzrtjCMbWvbIJxKQXYlhqgrmlhCJLxxDyjx78NjSM4V1P6e5fGWx9B5dhomy
         5TT3AiLmnOqLko4AhppBdrryQH4eXuVzEpyzpijyN22dzDcRtwpJ47N8ZqXNXybfdn
         6SD8KbywjxBopeR3PTULfiYypUjUOihryT7elvH8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230113094908epcas5p32cc8d58dc22cb276c9545d4de3277062~51WDdBSnG1056810568epcas5p31;
        Fri, 13 Jan 2023 09:49:08 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Ntc7l0s3Lz4x9Pw; Fri, 13 Jan
        2023 09:49:07 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.4B.03362.21921C36; Fri, 13 Jan 2023 18:49:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230113082648epcas5p4ee201c621573efa1f799aa6878b42425~50OKXSuYZ3146431464epcas5p44;
        Fri, 13 Jan 2023 08:26:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230113082648epsmtrp24fb2eb877449d7b7ff9e43619667abce~50OKVwc7i0777607776epsmtrp2Y;
        Fri, 13 Jan 2023 08:26:48 +0000 (GMT)
X-AuditID: b6c32a4b-287ff70000010d22-71-63c12912cf5b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.23.10542.7C511C36; Fri, 13 Jan 2023 17:26:47 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230113082645epsmtip27d30ff675161a09cb1a12fe3ec6bade4~50OHi3HdA3218232182epsmtip2Q;
        Fri, 13 Jan 2023 08:26:45 +0000 (GMT)
Date:   Fri, 13 Jan 2023 13:56:23 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, anuj20.g@samsung.com,
        joshi.k@samsung.com, p.raghav@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 2/9] block: Add copy offload support infrastructure
Message-ID: <20230113082623.GA26951@green5>
MIME-Version: 1.0
In-Reply-To: <5ee0baea-9c4b-c792-011d-f4bae777257c@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTdxTO797b2wuz7Fpx+1kyRi6ZBh1IBeotghJn5A63jE2ZizOBptzQ
        jr7WB6BsDLBkkfhAwWwUGSBOBDYqoPJqFXE8CiJRAkYGSlhxASKK/UMc6VzLhcX/vvOd7+Sc
        75wcAhXm8UWEUmNk9RqZisJ9seu3Q0JChSG35OFPLkhpa38PSucXuVG6fuI0Ttvny3j0w842
        hLZdOIvQtfXdCN1RtYDQ3a+f4vTZrlFAT49YENo+toW22R0YPdx+HqcrLk3z6VZnHqBdv5r5
        dMPcM4zuGwugh9y9vDh/xvJ4EGfaLBN8ZuhRI8YMD5qYprrjONN88Qem42Euzpw8No8zz26M
        4Mypq3WAaR7IZlxNgUyT8ymSKDiUHqNgZamsPojVyLWpSk1aLLVvf/JHyVGScHGoWEpvp4I0
        MjUbS+35JDF0r1LlsUoFZchUJg+VKDMYqK07Y/Rak5ENUmgNxliK1aWqdJG6MINMbTBp0sI0
        rDFaHB6+LcojTElXFJbOoroTVSDL8lM5lgumvy8EPgQkI+FfrhmkEPgSQrIDQLdtlMcFLwCc
        vDjA5wIXgAV/HsdXS+62ODAu0Q7geHXvisoJoMOZj3pVGPkBnGlzelQEgZNb4MBrwkv7kxRc
        +LFrWY+SdzFYPDXJ8ybWkQmwpWcI82KBR9/TfIrP4bXQUepc5n3IHdA2a17WryeDYef1XoSb
        qNgHtp8I4/Ae2PKoDePwOjjbe5XPYRF0zdtXHGTC2pLLuHcISJoBtDywAC6xCxb0n142gJIK
        2H+nicfx78Fz/Q0Ix/vBk0vOlcYC2PrLKg6Gv1krVxpsgKMv83CveUgysL58ZVvPPTutcONF
        4H3LG94sb7Tj8IewsuMFbvGUo2QArPmX4GAItLZvrQS8OrCB1RnUaawhShehYTP/P7lcq24C
        y7+weV8rmJp8HtYFEAJ0AUiglL/A1n1TLhSkyo4cZfXaZL1JxRq6QJTnVmdQ0Xq51vNMGmOy
        OFIaHimRSCKlERIx9a6AvVYhF5JpMiObzrI6Vr9ahxA+olxkYDHli2/j6M78kvG+slD5iGMh
        bMQ+9/ZbgR9nffrl7j7ltitxR9eEuI5h+dONhvPK+9VrjJs0k349pdW5u0u+G3hpTZpUDKag
        Sig6EN9ad6uxFvz+x9SwwgoeCJ5IlFnkqyvS4hti2jw+ZjwcENcXUXPm3mfXiqTvLIrjHaJ4
        26WMmraKwnPOuoNuSc6mhTJzwo4l4z/lCpOj7LIw6X5Oc6Ofmoyu+tlJZspC72XkTNizYqhk
        8ps7r7DgrI3iacHfs0uHPnc+Hu0279qesDFp5wF5oyIwWx0x4yuygrSbXzPur3pvr41oZX2O
        yA5n0/v7Ds412KITF8sIokBlnK2lMINCJt6M6g2y/wB+KEPSlAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSvO4J0YPJBp9kLdafOsZs0TThL7PF
        6rv9bBZ7381mtbh5YCeTxZ5Fk5gsVq4+ymSxe+FHJouj/9+yWUw6dI3R4unVWUwWe29pW+zZ
        e5LF4vKuOWwW85c9ZbfY8aSR0eLz0hZ2i3Wv37NYnLglbXH+73FWBxGPWffPsnnsnHWX3eP8
        vY0sHpfPlnpsWtXJ5rF5Sb3H7psNbB69ze/YPN7vu8rm0bdlFaPH5tPVHp83yXlsevKWKYA3
        issmJTUnsyy1SN8ugSvj5/Mu5oIz8xgrFmzbw9zAuK+6i5GTQ0LAROLc9pMsXYxcHEICOxgl
        Xl26zAaRkJRY9vcIM4QtLLHy33N2iKJHjBLnlx1hAkmwCKhKvNz5BKibg4NNQFvi9H8OkLCI
        gJLEx/ZD7CA2s8AlFon/67VAbGEBL4ntx86zgNi8QOXHNvdBzfzAKLHg01d2iISgxMmZT1gg
        mrUkbvx7yQQyn1lAWmL5P7D5nALWEntetbCC2KICyhIHth1nmsAoOAtJ9ywk3bMQuhcwMq9i
        lEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOZS2tHYx7Vn3QO8TIxMF4iFGCg1lJhHfP
        0f3JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAZKXM/
        nXTNYteqt0wFXh8qZNpfTPPz6ZW51nHRZk+Zj8Py/fOctotu+uPatWjqxjVbX6wN5d/9JrCj
        58tvvnymNeaNG/Rsvk0VFHwS+YJrlj7vBIUz//fNPfzjZOq96zP++M6cEXp6z8Pf6yddnnVd
        brnafda4oICqp1JXBLp9U1T4otuErTZucN39RG27Z3Lx0ef3zziH+i35+eTXvDaeOQu/HeFJ
        XlWtbvb+2s+Svnc3uZV+NgpO9tHfcK2UI+nqwm+RnCHHNx2N0X0nG33ZhmfKfcudot33/Ocd
        6tXOsVzBL8h5MfXgkb57zxuF5ddbPTK0XlP/bcMfkdbSuZv+tR67UCEffGfzFkF+zoCSm0os
        xRmJhlrMRcWJAHneE8xUAwAA
X-CMS-MailID: 20230113082648epcas5p4ee201c621573efa1f799aa6878b42425
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----r7zkWJCji.Ym_y_k8RXupob0Z-0SuwAVE8dxRRT6SQvRmvau=_a549c_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230112120039epcas5p49ccf70d806c530c8228130cc25737b51
References: <20230112115908.23662-1-nj.shetty@samsung.com>
        <CGME20230112120039epcas5p49ccf70d806c530c8228130cc25737b51@epcas5p4.samsung.com>
        <20230112115908.23662-3-nj.shetty@samsung.com>
        <5ee0baea-9c4b-c792-011d-f4bae777257c@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------r7zkWJCji.Ym_y_k8RXupob0Z-0SuwAVE8dxRRT6SQvRmvau=_a549c_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Jan 12, 2023 at 03:43:07PM +0100, Hannes Reinecke wrote:
> On 1/12/23 12:58, Nitesh Shetty wrote:
> > Introduce blkdev_issue_copy which supports source and destination bdevs,
> > and an array of (source, destination and copy length) tuples.
> > Introduce REQ_COPY copy offload operation flag. Create a read-write
> > bio pair with a token as payload and submitted to the device in order.
> > Read request populates token with source specific information which
> > is then passed with write request.
> > This design is courtesy Mikulas Patocka's token based copy
> > 
> > Larger copy will be divided, based on max_copy_sectors limit.
> > 
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > ---
> >   block/blk-lib.c           | 358 ++++++++++++++++++++++++++++++++++++++
> >   block/blk.h               |   2 +
> >   include/linux/blk_types.h |  44 +++++
> >   include/linux/blkdev.h    |   3 +
> >   include/uapi/linux/fs.h   |  15 ++
> >   5 files changed, 422 insertions(+)
> > 
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index e59c3069e835..2ce3c872ca49 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -115,6 +115,364 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> >   }
> >   EXPORT_SYMBOL(blkdev_issue_discard);
> > +/*
> > + * For synchronous copy offload/emulation, wait and process all in-flight BIOs.
> > + * This must only be called once all bios have been issued so that the refcount
> > + * can only decrease. This just waits for all bios to make it through
> > + * bio_copy_*_write_end_io. IO errors are propagated through cio->io_error.
> > + */
> > +static int cio_await_completion(struct cio *cio)
> > +{
> > +	int ret = 0;
> > +
> > +	atomic_dec(&cio->refcount);
> > +
> > +	if (cio->endio)
> > +		return 0;
> > +
> > +	if (atomic_read(&cio->refcount)) {
> > +		__set_current_state(TASK_UNINTERRUPTIBLE);
> > +		blk_io_schedule();
> > +	}
> > +
> Wouldn't it be better to use 'atomic_dec_return()' to avoid a potential race
> condition between atomic_dec() and atomic_read()?
> 

cio keeps total number of submitted IOs. For async copy(with endio handler) we
just return after decrementing refcount, if we use atomic_dec_return, we need
to have that endio check twice.
Also this function is called after all the submissions are complete. So race
condition shouldn't happen with this ordered calling.

> > +	ret = cio->io_err;
> > +	kfree(cio);
> > +
> > +	return ret;
> > +}
> > +
> > +static void blk_copy_offload_write_end_io(struct bio *bio)
> > +{
> > +	struct copy_ctx *ctx = bio->bi_private;
> > +	struct cio *cio = ctx->cio;
> > +	sector_t clen;
> > +	int ri = ctx->range_idx;
> > +
> > +	if (bio->bi_status) {
> > +		cio->io_err = blk_status_to_errno(bio->bi_status);
> > +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
> > +			cio->ranges[ri].dst;
> > +		cio->ranges[ri].comp_len = min_t(sector_t, clen,
> > +				cio->ranges[ri].comp_len);
> > +	}
> > +	__free_page(bio->bi_io_vec[0].bv_page);
> > +	bio_put(bio);
> > +
> > +	if (atomic_dec_and_test(&ctx->refcount))
> > +		kfree(ctx);
> > +	if (atomic_dec_and_test(&cio->refcount)) {
> 
> _Two_ atomic_dec() in a row?
> Why?
> 
> And if that really is required please add a comment.
> 

cio is used to keep track of all the submitted IOs.

ctx is used to keep track of single IO. Each IOs again has 4 parts.
1.READ submission (process/submitter context)
2.READ completion (interrupt context, can't submit WRITE bio here, so we
create a workqueue and submit)
3.WRITE submission by worker (process context)
4.WRITE completion (interrupt context)
So there is a concurrent access to ctx.
Especially if IO is for zoned device we need to maintain order of
READ submissions, so that WRITE order is same as READ.

So cio and ctx refcount serve different purpose and updated accordingly.
Agreed, I can add better comments in next version.

> > +		if (cio->endio) {
> > +			cio->endio(cio->private, cio->io_err);
> > +			kfree(cio);
> > +		} else
> > +			blk_wake_io_task(cio->waiter);
> > +	}
> > +}
> > +
> > +static void blk_copy_offload_read_end_io(struct bio *read_bio)
> > +{
> > +	struct copy_ctx *ctx = read_bio->bi_private;
> > +	struct cio *cio = ctx->cio;
> > +	sector_t clen;
> > +	int ri = ctx->range_idx;
> > +	unsigned long flags;
> > +
> > +	if (read_bio->bi_status) {
> > +		cio->io_err = blk_status_to_errno(read_bio->bi_status);
> > +		goto err_rw_bio;
> > +	}
> > +
> > +	/* For zoned device, we check if completed bio is first entry in linked
> > +	 * list,
> > +	 * if yes, we start the worker to submit write bios.
> > +	 * if not, then we just update status of bio in ctx,
> > +	 * once the worker gets scheduled, it will submit writes for all
> > +	 * the consecutive REQ_COPY_READ_COMPLETE bios.
> > +	 */
> > +	if (bdev_is_zoned(ctx->write_bio->bi_bdev)) {
> > +		spin_lock_irqsave(&cio->list_lock, flags);
> > +		ctx->status = REQ_COPY_READ_COMPLETE;
> > +		if (ctx == list_first_entry(&cio->list,
> > +					struct copy_ctx, list)) {
> > +			spin_unlock_irqrestore(&cio->list_lock, flags);
> > +			schedule_work(&ctx->dispatch_work);
> > +			goto free_read_bio;
> > +		}
> > +		spin_unlock_irqrestore(&cio->list_lock, flags);
> > +	} else
> > +		schedule_work(&ctx->dispatch_work);
> > +
> > +free_read_bio:
> > +	bio_put(read_bio);
> > +
> > +	return;
> > +
> > +err_rw_bio:
> > +	clen = (read_bio->bi_iter.bi_sector << SECTOR_SHIFT) -
> > +					cio->ranges[ri].src;
> > +	cio->ranges[ri].comp_len = min_t(sector_t, clen,
> > +					cio->ranges[ri].comp_len);
> > +	__free_page(read_bio->bi_io_vec[0].bv_page);
> > +	bio_put(ctx->write_bio);
> > +	bio_put(read_bio);
> > +	if (atomic_dec_and_test(&ctx->refcount))
> > +		kfree(ctx);
> > +	if (atomic_dec_and_test(&cio->refcount)) {
> 
> Same here.
> 
> > +		if (cio->endio) {
> > +			cio->endio(cio->private, cio->io_err);
> > +			kfree(cio);
> > +		} else
> > +			blk_wake_io_task(cio->waiter);
> > +	}
> > +}
> > +
> > +static void blk_copy_dispatch_work_fn(struct work_struct *work)
> > +{
> > +	struct copy_ctx *ctx = container_of(work, struct copy_ctx,
> > +			dispatch_work);
> > +
> > +	submit_bio(ctx->write_bio);
> > +}
> > +
> > +static void blk_zoned_copy_dispatch_work_fn(struct work_struct *work)
> > +{
> > +	struct copy_ctx *ctx = container_of(work, struct copy_ctx,
> > +			dispatch_work);
> > +	struct cio *cio = ctx->cio;
> > +	unsigned long flags = 0;
> > +
> > +	atomic_inc(&cio->refcount);
> > +	spin_lock_irqsave(&cio->list_lock, flags);
> > +
> > +	while (!list_empty(&cio->list)) {
> > +		ctx = list_first_entry(&cio->list, struct copy_ctx, list);
> > +
> That is ever so odd; it'll block 'cio->list' for the time of processing.
> Wouldn't it be better to move 'cio->list' to a private list, and do away
> with the list_lock during processing?
> 

For zoned devices we need to maintain ordering of IOs. Because write
cant be out of order. So we maintain this list.
Again this IO list is accessed concurrently by
a. READ submission
b. READ completion
c. WRITE submission(worker).
So moving to private list won't be possible I feel.
Since we are using global list, we require the lock to synchronize this list.

> > +		if (ctx->status == REQ_COPY_READ_PROGRESS)
> > +			break;
> > +
> > +		atomic_inc(&ctx->refcount);
> > +		ctx->status = REQ_COPY_WRITE_PROGRESS;
> > +		spin_unlock_irqrestore(&cio->list_lock, flags);
> > +		submit_bio(ctx->write_bio);
> > +		spin_lock_irqsave(&cio->list_lock, flags);
> > +
> > +		list_del(&ctx->list);
> > +		if (atomic_dec_and_test(&ctx->refcount))
> > +			kfree(ctx);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&cio->list_lock, flags);
> > +	if (atomic_dec_and_test(&cio->refcount))
> > +		blk_wake_io_task(cio->waiter);
> > +}
> > +
> > +/*
> > + * blk_copy_offload	- Use device's native copy offload feature.
> > + * we perform copy operation by sending 2 bio.
> > + * 1. First we send a read bio with REQ_COPY flag along with a token and source
> > + * and length. Once read bio reaches driver layer, device driver adds all the
> > + * source info to token and does a fake completion.
> > + * 2. Once read opration completes, we issue write with REQ_COPY flag with same
> > + * token. In driver layer, token info is used to form a copy offload command.
> > + *
> > + * For conventional devices we submit write bio independentenly once read
> > + * completes. For zoned devices , reads can complete out of order, so we
> > + * maintain a linked list and submit writes in the order, reads are submitted.
> > + */
> > +static int blk_copy_offload(struct block_device *src_bdev,
> > +		struct block_device *dst_bdev, struct range_entry *ranges,
> > +		int nr, cio_iodone_t end_io, void *private, gfp_t gfp_mask)
> > +{
> > +	struct cio *cio;
> > +	struct copy_ctx *ctx;
> > +	struct bio *read_bio, *write_bio;
> > +	struct page *token;
> > +	sector_t src_blk, copy_len, dst_blk;
> > +	sector_t rem, max_copy_len;
> > +	int ri = 0, ret = 0;
> > +	unsigned long flags;
> > +
> > +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
> > +	if (!cio)
> > +		return -ENOMEM;
> > +	cio->ranges = ranges;
> > +	atomic_set(&cio->refcount, 1);
> > +	cio->waiter = current;
> > +	cio->endio = end_io;
> > +	cio->private = private;
> > +	if (bdev_is_zoned(dst_bdev)) {
> > +		INIT_LIST_HEAD(&cio->list);
> > +		spin_lock_init(&cio->list_lock);
> > +	}
> > +
> > +	max_copy_len = min(bdev_max_copy_sectors(src_bdev),
> > +			bdev_max_copy_sectors(dst_bdev)) << SECTOR_SHIFT;
> > +
> > +	for (ri = 0; ri < nr; ri++) {
> > +		cio->ranges[ri].comp_len = ranges[ri].len;
> > +		src_blk = ranges[ri].src;
> > +		dst_blk = ranges[ri].dst;
> > +		for (rem = ranges[ri].len; rem > 0; rem -= copy_len) {
> > +			copy_len = min(rem, max_copy_len);
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
> > +			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY
> > +					| REQ_SYNC | REQ_NOMERGE, gfp_mask);
> > +			if (!read_bio) {
> > +				ret = -ENOMEM;
> > +				goto err_read_bio;
> > +			}
> > +			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE
> > +					| REQ_COPY | REQ_SYNC | REQ_NOMERGE,
> > +					gfp_mask);
> > +			if (!write_bio) {
> > +				cio->io_err = -ENOMEM;
> > +				goto err_write_bio;
> > +			}
> > +
> > +			ctx->cio = cio;
> > +			ctx->range_idx = ri;
> > +			ctx->write_bio = write_bio;
> > +			atomic_set(&ctx->refcount, 1);
> > +
> > +			if (bdev_is_zoned(dst_bdev)) {
> > +				INIT_WORK(&ctx->dispatch_work,
> > +					blk_zoned_copy_dispatch_work_fn);
> > +				INIT_LIST_HEAD(&ctx->list);
> > +				spin_lock_irqsave(&cio->list_lock, flags);
> > +				ctx->status = REQ_COPY_READ_PROGRESS;
> > +				list_add_tail(&ctx->list, &cio->list);
> > +				spin_unlock_irqrestore(&cio->list_lock, flags);
> > +			} else
> > +				INIT_WORK(&ctx->dispatch_work,
> > +					blk_copy_dispatch_work_fn);
> > +
> > +			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> > +			read_bio->bi_iter.bi_size = copy_len;
> > +			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
> > +			read_bio->bi_end_io = blk_copy_offload_read_end_io;
> > +			read_bio->bi_private = ctx;
> > +
> > +			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
> > +			write_bio->bi_iter.bi_size = copy_len;
> > +			write_bio->bi_end_io = blk_copy_offload_write_end_io;
> > +			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
> > +			write_bio->bi_private = ctx;
> > +
> > +			atomic_inc(&cio->refcount);
> > +			submit_bio(read_bio);
> > +			src_blk += copy_len;
> > +			dst_blk += copy_len;
> > +		}
> > +	}
> > +
> > +	/* Wait for completion of all IO's*/
> > +	return cio_await_completion(cio);
> > +
> > +err_write_bio:
> > +	bio_put(read_bio);
> > +err_read_bio:
> > +	kfree(ctx);
> > +err_ctx:
> > +	__free_page(token);
> > +err_token:
> > +	ranges[ri].comp_len = min_t(sector_t,
> > +			ranges[ri].comp_len, (ranges[ri].len - rem));
> > +
> > +	cio->io_err = ret;
> > +	return cio_await_completion(cio);
> > +}
> > +
> > +static inline int blk_copy_sanity_check(struct block_device *src_bdev,
> > +	struct block_device *dst_bdev, struct range_entry *ranges, int nr)
> > +{
> > +	unsigned int align_mask = max(bdev_logical_block_size(dst_bdev),
> > +					bdev_logical_block_size(src_bdev)) - 1;
> > +	sector_t len = 0;
> > +	int i;
> > +
> > +	if (!nr)
> > +		return -EINVAL;
> > +
> > +	if (nr >= MAX_COPY_NR_RANGE)
> > +		return -EINVAL;
> > +
> > +	if (bdev_read_only(dst_bdev))
> > +		return -EPERM;
> > +
> > +	for (i = 0; i < nr; i++) {
> > +		if (!ranges[i].len)
> > +			return -EINVAL;
> > +
> > +		len += ranges[i].len;
> > +		if ((ranges[i].dst & align_mask) ||
> > +				(ranges[i].src & align_mask) ||
> > +				(ranges[i].len & align_mask))
> > +			return -EINVAL;
> > +		ranges[i].comp_len = 0;
> > +	}
> > +
> > +	if (len && len >= MAX_COPY_TOTAL_LENGTH)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static inline bool blk_check_copy_offload(struct request_queue *src_q,
> > +		struct request_queue *dst_q)
> > +{
> > +	return blk_queue_copy(dst_q) && blk_queue_copy(src_q);
> > +}
> > +
> > +/*
> > + * blkdev_issue_copy - queue a copy
> > + * @src_bdev:	source block device
> > + * @dst_bdev:	destination block device
> > + * @ranges:	array of source/dest/len,
> > + *		ranges are expected to be allocated/freed by caller
> > + * @nr:		number of source ranges to copy
> > + * @end_io:	end_io function to be called on completion of copy operation,
> > + *		for synchronous operation this should be NULL
> > + * @private:	end_io function will be called with this private data, should be
> > + *		NULL, if operation is synchronous in nature
> > + * @gfp_mask:   memory allocation flags (for bio_alloc)
> > + *
> > + * Description:
> > + *	Copy source ranges from source block device to destination block
> > + *	device. length of a source range cannot be zero. Max total length of
> > + *	copy is limited to MAX_COPY_TOTAL_LENGTH and also maximum number of
> > + *	entries is limited to MAX_COPY_NR_RANGE
> > + */
> > +int blkdev_issue_copy(struct block_device *src_bdev,
> > +	struct block_device *dst_bdev, struct range_entry *ranges, int nr,
> > +	cio_iodone_t end_io, void *private, gfp_t gfp_mask)
> > +{
> > +	struct request_queue *src_q = bdev_get_queue(src_bdev);
> > +	struct request_queue *dst_q = bdev_get_queue(dst_bdev);
> > +	int ret = -EINVAL;
> > +
> > +	ret = blk_copy_sanity_check(src_bdev, dst_bdev, ranges, nr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (blk_check_copy_offload(src_q, dst_q))
> > +		ret = blk_copy_offload(src_bdev, dst_bdev, ranges, nr,
> > +				end_io, private, gfp_mask);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(blkdev_issue_copy);
> > +
> >   static int __blkdev_issue_write_zeroes(struct block_device *bdev,
> >   		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
> >   		struct bio **biop, unsigned flags)
> > diff --git a/block/blk.h b/block/blk.h
> > index 4c3b3325219a..6d9924a7d559 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -304,6 +304,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
> >   		break;
> >   	}
> > +	if (unlikely(op_is_copy(bio->bi_opf)))
> > +		return false;
> >   	/*
> >   	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
> >   	 * This is a quick and dirty check that relies on the fact that
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 99be590f952f..de1638c87ecf 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -422,6 +422,7 @@ enum req_flag_bits {
> >   	 */
> >   	/* for REQ_OP_WRITE_ZEROES: */
> >   	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
> > +	__REQ_COPY,		/* copy request */
> >   	__REQ_NR_BITS,		/* stops here */
> >   };
> > @@ -451,6 +452,7 @@ enum req_flag_bits {
> >   #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
> >   #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
> > +#define REQ_COPY	((__force blk_opf_t)(1ULL << __REQ_COPY))
> >   #define REQ_FAILFAST_MASK \
> >   	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
> > @@ -477,6 +479,11 @@ static inline bool op_is_write(blk_opf_t op)
> >   	return !!(op & (__force blk_opf_t)1);
> >   }
> > +static inline bool op_is_copy(blk_opf_t op)
> > +{
> > +	return (op & REQ_COPY);
> > +}
> > +
> >   /*
> >    * Check if the bio or request is one that needs special treatment in the
> >    * flush state machine.
> > @@ -536,4 +543,41 @@ struct blk_rq_stat {
> >   	u64 batch;
> >   };
> > +typedef void (cio_iodone_t)(void *private, int status);
> > +
> > +struct cio {
> > +	struct range_entry *ranges;
> > +	struct task_struct *waiter;     /* waiting task (NULL if none) */
> > +	atomic_t refcount;
> > +	int io_err;
> > +	cio_iodone_t *endio;		/* applicable for async operation */
> > +	void *private;			/* applicable for async operation */
> > +
> > +	/* For zoned device we maintain a linked list of IO submissions.
> > +	 * This is to make sure we maintain the order of submissions.
> > +	 * Otherwise some reads completing out of order, will submit writes not
> > +	 * aligned with zone write pointer.
> > +	 */
> > +	struct list_head list;
> > +	spinlock_t list_lock;
> > +};
> > +
> > +enum copy_io_status {
> > +	REQ_COPY_READ_PROGRESS,
> > +	REQ_COPY_READ_COMPLETE,
> > +	REQ_COPY_WRITE_PROGRESS,
> > +};
> > +
> > +struct copy_ctx {
> > +	struct cio *cio;
> > +	struct work_struct dispatch_work;
> > +	struct bio *write_bio;
> > +	atomic_t refcount;
> > +	int range_idx;			/* used in error/partial completion */
> > +
> > +	/* For zoned device linked list is maintained. Along with state of IO */
> > +	struct list_head list;
> > +	enum copy_io_status status;
> > +};
> > +
> >   #endif /* __LINUX_BLK_TYPES_H */
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 807ffb5f715d..48e9160b7195 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1063,6 +1063,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> >   		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
> >   int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
> >   		sector_t nr_sects, gfp_t gfp);
> > +int blkdev_issue_copy(struct block_device *src_bdev,
> > +		struct block_device *dst_bdev, struct range_entry *ranges,
> > +		int nr, cio_iodone_t end_io, void *private, gfp_t gfp_mask);
> >   #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
> >   #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index b3ad173f619c..9248b6d259de 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -67,6 +67,21 @@ struct fstrim_range {
> >   /* maximum total copy length */
> >   #define MAX_COPY_TOTAL_LENGTH	(1 << 27)
> > +/* Maximum no of entries supported */
> > +#define MAX_COPY_NR_RANGE	(1 << 12)
> > +
> > +/* range entry for copy offload, all fields should be byte addressed */
> > +struct range_entry {
> > +	__u64 src;		/* source to be copied */
> > +	__u64 dst;		/* destination */
> > +	__u64 len;		/* length in bytes to be copied */
> > +
> > +	/* length of data copy actually completed. This will be filled by
> > +	 * kernel, once copy completes
> > +	 */
> > +	__u64 comp_len;
> > +};
> > +
> >   /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
> >   #define FILE_DEDUPE_RANGE_SAME		0
> >   #define FILE_DEDUPE_RANGE_DIFFERS	1
> 
> Cheers,
> 
> Hannes
> 

Thanks,
Nitesh Shetty

------r7zkWJCji.Ym_y_k8RXupob0Z-0SuwAVE8dxRRT6SQvRmvau=_a549c_
Content-Type: text/plain; charset="utf-8"


------r7zkWJCji.Ym_y_k8RXupob0Z-0SuwAVE8dxRRT6SQvRmvau=_a549c_--
