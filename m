Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF343649B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhJUOqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhJUOqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:46:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729BC061243
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 07:44:19 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso709310otl.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GKl/YEYooFyGL+2sNbk3AcJ4DChd+kQm/2sjbVGOSiQ=;
        b=0MriM/SgRk3IxjGeEyZUKzN1luQ4YUgytB5kDf/Fzakg9HOmVLkdS/AFW/Wqo+URyz
         228HZjZsvmecaOjbSfSLgBkVst/P1N/7UmsWmajYXapSD8nKwjsmkShPIxpPjDYQMXTZ
         f09i0PInPdAOpbKhjRDkgdBZfnchv1e2qH1gX1O41f91fK/5LYm5T/iLrnsu4Ls3P9uk
         4qYsyvA99wMBlx4fxifVxcgcZuCiczsOX0L+OYxBXhfGbe7Pza2cSZ+CKMytRsggKwzQ
         LOFsGENh3gbjsrHs2OTOba64AeudX8DrRWOjZ9QrtxSrJE6MTUo909MlRE07RmVK2qPf
         kzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKl/YEYooFyGL+2sNbk3AcJ4DChd+kQm/2sjbVGOSiQ=;
        b=WAhqcleuXYl4+pJAV5rUgNGvlCPSGFMPpk9x5AK1VL5umKiaw6pPnXfdg9mjJ8S5hx
         0R4z3sEFC3fv9HtddXz0RJQRcm+lcnslWd9+1YCXAqLGWKlAJJJJ79WGaVKhLpxkbyQT
         GJwMr131+Wj1Ev27vfCHYskGbwKI8fchShtJ7Q/RhDHb+3jRWSovtlH/GfjFQpsDqgCS
         4gHX2WtyMkSnZkT1UZvraSK7vcXU3YcL8Nzbp91zHNb/QiaAdScy03Ha70tW3AYNFqXM
         Ii5RrrypruNwhD3wyU0ZZLY1EcS2eEBOx4rSeFcyoeU61XehxYnfBDowB3EycUjHy1mj
         /WsQ==
X-Gm-Message-State: AOAM531dPc39qkS+bLmFdzzokYf2ij0ruBTLVqOw1411tk2qWXKfIvel
        u2/bY42xOCgXxvuNgIWZUgJrWw==
X-Google-Smtp-Source: ABdhPJxCRLULewT0548HJPR34SD7Ab9C6gkaqryefEFSDCl9hVv4WgzqRQCNBNLmalERaxeUqL+4Dw==
X-Received: by 2002:a9d:655a:: with SMTP id q26mr5012723otl.130.1634827459093;
        Thu, 21 Oct 2021 07:44:19 -0700 (PDT)
Received: from ?IPv6:2600:380:783a:c43c:af64:c142:4db7:63ac? ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id r23sm1067552otg.71.2021.10.21.07.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 07:44:18 -0700 (PDT)
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments with
 a single argument
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
 <YXElk52IsvCchbOx@infradead.org> <YXFHgy85MpdHpHBE@infradead.org>
 <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
 <YXF8X3RgRfZpL3Cb@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk>
Date:   Thu, 21 Oct 2021 08:44:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXF8X3RgRfZpL3Cb@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/21/21 8:42 AM, Christoph Hellwig wrote:
> On Thu, Oct 21, 2021 at 08:34:38AM -0600, Jens Axboe wrote:
>> Incremental, are you happy with that comment?
> 
> Looks fine to me.

OK good, can I add your ack/review? I can send out a v3 if needed, but
seems a bit pointless for that small change.

Jeff, are you happy with this one too?


commit b676e2079074b06f362a33c1942977fa1b741fcd
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Oct 20 10:35:50 2021 -0600

    fs: replace the ki_complete two integer arguments with a single argument
    
    The second argument is only used by the USB gadget code, yet everyone
    pays the overhead of passing a zero to be passed into aio, where it
    ends up being part of the aio res2 value.
    
    Since we pass this value around as long, there's only 32-bits of
    information in each of these. Linux IO transfers are capped at INT_MAX
    anyway, so could not be any larger return value. For the one cases where
    we care about this second result, mask it into the upper bits of the
    value passed in. aio can then simply shift to get it.
    
    For everyone else, just pass in res as an argument like before. Update
    all ki_complete handlers to conform to the new prototype.
    
    Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/fops.c b/block/fops.c
index 49c7fc0085f7..1732617adbf5 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -164,7 +164,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 				ret = blk_status_to_errno(dio->bio.bi_status);
 			}
 
-			iocb->ki_complete(iocb, ret, 0);
+			iocb->ki_complete(iocb, ret);
 			if (flags & DIO_MULTI_BIO)
 				bio_put(&dio->bio);
 		} else {
@@ -318,7 +318,7 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 		ret = blk_status_to_errno(bio->bi_status);
 	}
 
-	iocb->ki_complete(iocb, ret, 0);
+	iocb->ki_complete(iocb, ret);
 
 	if (dio->flags & DIO_SHOULD_DIRTY) {
 		bio_check_pages_dirty(bio);
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 8bd288d2b089..3dd5a773c320 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1076,7 +1076,7 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
 	af_alg_free_resources(areq);
 	sock_put(sk);
 
-	iocb->ki_complete(iocb, err ? err : (int)resultlen, 0);
+	iocb->ki_complete(iocb, err ? err : (int)resultlen);
 }
 EXPORT_SYMBOL_GPL(af_alg_async_cb);
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 397bfafc4c25..66c6e0c5d638 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -550,7 +550,7 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 		blk_mq_complete_request(rq);
 }
 
-static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
+static void lo_rw_aio_complete(struct kiocb *iocb, u64 ret)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
@@ -623,7 +623,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	lo_rw_aio_do_completion(cmd);
 
 	if (ret != -EIOCBQUEUED)
-		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
+		lo_rw_aio_complete(&cmd->iocb, ret);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 7a249b752f3c..83a2f5b0a3a0 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -123,7 +123,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	return call_iter(iocb, &iter);
 }
 
-static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
+static void nvmet_file_io_done(struct kiocb *iocb, u64 ret)
 {
 	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
 	u16 status = NVME_SC_SUCCESS;
@@ -220,7 +220,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	}
 
 complete:
-	nvmet_file_io_done(&req->f.iocb, ret, 0);
+	nvmet_file_io_done(&req->f.iocb, ret);
 	return true;
 }
 
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index b471e726bb3d..c4ca7fa18e61 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -245,7 +245,7 @@ struct target_core_file_cmd {
 	struct bio_vec	bvecs[];
 };
 
-static void cmd_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
+static void cmd_rw_aio_complete(struct kiocb *iocb, u64 ret)
 {
 	struct target_core_file_cmd *cmd;
 
@@ -301,7 +301,7 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		ret = call_read_iter(file, &aio_cmd->iocb, &iter);
 
 	if (ret != -EIOCBQUEUED)
-		cmd_rw_aio_complete(&aio_cmd->iocb, ret, 0);
+		cmd_rw_aio_complete(&aio_cmd->iocb, ret);
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 8260f38025b7..8536f19d3c9a 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -831,7 +831,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 		kthread_unuse_mm(io_data->mm);
 	}
 
-	io_data->kiocb->ki_complete(io_data->kiocb, ret, ret);
+	io_data->kiocb->ki_complete(io_data->kiocb, ((u64) ret << 32) | ret);
 
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 539220d7f5b6..d3deb23eb2ab 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -469,7 +469,7 @@ static void ep_user_copy_worker(struct work_struct *work)
 		ret = -EFAULT;
 
 	/* completing the iocb can drop the ctx and mm, don't touch mm after */
-	iocb->ki_complete(iocb, ret, ret);
+	iocb->ki_complete(iocb, ((u64) ret << 32) | ret);
 
 	kfree(priv->buf);
 	kfree(priv->to_free);
@@ -492,15 +492,16 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
 	 * complete the aio request immediately.
 	 */
 	if (priv->to_free == NULL || unlikely(req->actual == 0)) {
+		u64 aio_ret;
+
 		kfree(req->buf);
 		kfree(priv->to_free);
 		kfree(priv);
 		iocb->private = NULL;
 		/* aio_complete() reports bytes-transferred _and_ faults */
-
-		iocb->ki_complete(iocb,
-				req->actual ? req->actual : (long)req->status,
-				req->status);
+		aio_ret = req->actual ? req->actual : (long)req->status;
+		aio_ret |= (u64) req->status << 32;
+		iocb->ki_complete(iocb, aio_ret);
 	} else {
 		/* ep_copy_to_user() won't report both; we hide some faults */
 		if (unlikely(0 != req->status))
diff --git a/fs/aio.c b/fs/aio.c
index 51b08ab01dff..3674abc43788 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1417,7 +1417,7 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 
-static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void aio_complete_rw(struct kiocb *kiocb, u64 res)
 {
 	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
 
@@ -1436,8 +1436,14 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 		file_end_write(kiocb->ki_filp);
 	}
 
-	iocb->ki_res.res = res;
-	iocb->ki_res.res2 = res2;
+	/*
+	 * Historically we've only had one real user of res2, the USB
+	 * gadget code, everybody else just passes back zero. As we pass
+	 * 32-bits of value at most for either value, bundle these up and
+	 * pass them in one u64 value.
+	 */
+	iocb->ki_res.res = lower_32_bits(res);
+	iocb->ki_res.res2 = upper_32_bits(res);
 	iocb_put(iocb);
 }
 
@@ -1508,7 +1514,7 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 		ret = -EINTR;
 		fallthrough;
 	default:
-		req->ki_complete(req, ret, 0);
+		req->ki_complete(req, ret);
 	}
 }
 
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index fac2e8e7b533..b2f44ff8eae2 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -37,11 +37,11 @@ static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
 /*
  * Handle completion of a read from the cache.
  */
-static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
+static void cachefiles_read_complete(struct kiocb *iocb, u64 ret)
 {
 	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
 
-	_enter("%ld,%ld", ret, ret2);
+	_enter("%llu", (unsigned long long) ret);
 
 	if (ki->term_func) {
 		if (ret >= 0)
@@ -139,7 +139,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 		fallthrough;
 	default:
 		ki->was_async = false;
-		cachefiles_read_complete(&ki->iocb, ret, 0);
+		cachefiles_read_complete(&ki->iocb, ret);
 		if (ret > 0)
 			ret = 0;
 		break;
@@ -159,12 +159,12 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 /*
  * Handle completion of a write to the cache.
  */
-static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
+static void cachefiles_write_complete(struct kiocb *iocb, u64 ret)
 {
 	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
 	struct inode *inode = file_inode(ki->iocb.ki_filp);
 
-	_enter("%ld,%ld", ret, ret2);
+	_enter("%llu", (unsigned long long) ret);
 
 	/* Tell lockdep we inherited freeze protection from submission thread */
 	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
@@ -244,7 +244,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 		fallthrough;
 	default:
 		ki->was_async = false;
-		cachefiles_write_complete(&ki->iocb, ret, 0);
+		cachefiles_write_complete(&ki->iocb, ret);
 		if (ret > 0)
 			ret = 0;
 		break;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5c1954ff3a82..41f4ca038191 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1022,7 +1022,7 @@ static void ceph_aio_complete(struct inode *inode,
 	ceph_put_cap_refs(ci, (aio_req->write ? CEPH_CAP_FILE_WR :
 						CEPH_CAP_FILE_RD));
 
-	aio_req->iocb->ki_complete(aio_req->iocb, ret, 0);
+	aio_req->iocb->ki_complete(aio_req->iocb, ret);
 
 	ceph_free_cap_flush(aio_req->prealloc_cf);
 	kfree(aio_req);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 13f3182cf796..1b855fcb179e 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3184,7 +3184,7 @@ static void collect_uncached_write_data(struct cifs_aio_ctx *ctx)
 	mutex_unlock(&ctx->aio_mutex);
 
 	if (ctx->iocb && ctx->iocb->ki_complete)
-		ctx->iocb->ki_complete(ctx->iocb, ctx->rc, 0);
+		ctx->iocb->ki_complete(ctx->iocb, ctx->rc);
 	else
 		complete(&ctx->done);
 }
@@ -3917,7 +3917,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 	mutex_unlock(&ctx->aio_mutex);
 
 	if (ctx->iocb && ctx->iocb->ki_complete)
-		ctx->iocb->ki_complete(ctx->iocb, ctx->rc, 0);
+		ctx->iocb->ki_complete(ctx->iocb, ctx->rc);
 	else
 		complete(&ctx->done);
 }
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 453dcff0e7f5..654443558047 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -307,7 +307,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 
 		if (ret > 0 && dio->op == REQ_OP_WRITE)
 			ret = generic_write_sync(dio->iocb, ret);
-		dio->iocb->ki_complete(dio->iocb, ret, 0);
+		dio->iocb->ki_complete(dio->iocb, ret);
 	}
 
 	kmem_cache_free(dio_cache, dio);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 11404f8c21c7..e6039f22311b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -687,7 +687,7 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 			spin_unlock(&fi->lock);
 		}
 
-		io->iocb->ki_complete(io->iocb, res, 0);
+		io->iocb->ki_complete(io->iocb, res);
 	}
 
 	kref_put(&io->refcnt, fuse_io_release);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5edde3b2f72d..0ed6c199f394 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2672,7 +2672,7 @@ static void __io_complete_rw(struct io_kiocb *req, long res, long res2,
 	__io_req_complete(req, issue_flags, req->result, io_put_rw_kbuf(req));
 }
 
-static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw(struct kiocb *kiocb, u64 res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
@@ -2683,7 +2683,7 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 	io_req_task_work_add(req);
 }
 
-static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw_iopoll(struct kiocb *kiocb, u64 res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
@@ -2891,7 +2891,7 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
 		ret = -EINTR;
 		fallthrough;
 	default:
-		kiocb->ki_complete(kiocb, ret, 0);
+		kiocb->ki_complete(kiocb, ret);
 	}
 }
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 83ecfba53abe..811c898125a5 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -125,7 +125,7 @@ static void iomap_dio_complete_work(struct work_struct *work)
 	struct iomap_dio *dio = container_of(work, struct iomap_dio, aio.work);
 	struct kiocb *iocb = dio->iocb;
 
-	iocb->ki_complete(iocb, iomap_dio_complete(dio), 0);
+	iocb->ki_complete(iocb, iomap_dio_complete(dio));
 }
 
 /*
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 2e894fec036b..7a5f287c5391 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -275,7 +275,7 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq)
 			res = (long) dreq->count;
 			WARN_ON_ONCE(dreq->count < 0);
 		}
-		dreq->iocb->ki_complete(dreq->iocb, res, 0);
+		dreq->iocb->ki_complete(dreq->iocb, res);
 	}
 
 	complete(&dreq->completion);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c88ac571593d..ff7db16aea2e 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -272,14 +272,14 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	kmem_cache_free(ovl_aio_request_cachep, aio_req);
 }
 
-static void ovl_aio_rw_complete(struct kiocb *iocb, long res, long res2)
+static void ovl_aio_rw_complete(struct kiocb *iocb, u64 res)
 {
 	struct ovl_aio_req *aio_req = container_of(iocb,
 						   struct ovl_aio_req, iocb);
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
 	ovl_aio_cleanup_handler(aio_req);
-	orig_iocb->ki_complete(orig_iocb, res, res2);
+	orig_iocb->ki_complete(orig_iocb, res);
 }
 
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 31029a91f440..3c809ce2518c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -330,7 +330,7 @@ struct kiocb {
 	randomized_struct_fields_start
 
 	loff_t			ki_pos;
-	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
+	void (*ki_complete)(struct kiocb *iocb, u64 ret);
 	void			*private;
 	int			ki_flags;
 	u16			ki_hint;

-- 
Jens Axboe

