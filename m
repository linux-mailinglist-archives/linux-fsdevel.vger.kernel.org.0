Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B30435342
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhJTS6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 14:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhJTS6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:58:22 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126DAC06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 11:56:08 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s17so25857577ioa.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sBiOVQO8Jkvj1cgLTkB6Z1YHjRkBGEmLvET6u6LAmpE=;
        b=YTsDhaEGwMWn4tv3nQjUWRWSTsxOWZOlBVJ089eVjW1mc2f3ceCC1rbVNMf4rc9t4+
         NIbTyXwng8wWYSCQRcWSzKlgGWYriJbN0MOq+UB4zjs+BZ17TPSGXoVN0XltopNe3SS4
         hddAqA2G59DpqQE86vD/P/K2DIUArmCWzOZnz70d5L/cXG6MLrQe5Qs+Em+QucD7q5jf
         5KZZ1CHp8Ft2N9Z9Y5bYaBuPVCk60tEjsliPSAmM1Vnag+zaShIfLBeuGSBm0QQefi5u
         WyVPK9ZoFQ+OrqQF+VxpjJbA7S1rXU0Y9o7Dx3Drym/6AkU866nGRC75Nwp8Dv+twXgP
         OgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sBiOVQO8Jkvj1cgLTkB6Z1YHjRkBGEmLvET6u6LAmpE=;
        b=FiVrhi3YZ6i2LM049J1OmAVCYmiJ5Y80ld3IV/MNDi14Gh5i2O9sPlTfqZd7QVjD1s
         Tw+bv7ydT17d7yORAyMIHhVDHXHannjWuro77vEf379dIoZNUumfOqZQq7oStcdsNqGp
         Lh0dA7qZXWCuyU4GVfqh76ulHEifTi+2zgkb1VD9I//9rb47WVqF1H25XdaoECVF/UPk
         wV+S5sJGmJO1F8Gg9+ic1TQmG7AQ6NbVdKCcbod6uATPmFcpXZ/CBcnfKmSMnPwq6HNR
         iSv5RFXuWxWaJWSerBylr/AoJaoKwClFVCZZ+lotEugb3QO+W3Tx8gsxOIUA0OXXN+T3
         wa/Q==
X-Gm-Message-State: AOAM532uflP4l7xPTm0J3MMHdDjG1bcwK8yVrazWsbfWGurJLK5tFhxw
        eTVNg1qB18GjkrJsv6MDb0ajyQ==
X-Google-Smtp-Source: ABdhPJxNdy0wPZ4DHYqCDghMP5WIvR8WQgxtEPsfxpukPj4iMVYYIthopd1ZIJB9HOMQWJEhSJOTyg==
X-Received: by 2002:a02:6064:: with SMTP id d36mr762041jaf.80.1634756167247;
        Wed, 20 Oct 2021 11:56:07 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id v63sm1449499ioe.17.2021.10.20.11.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 11:56:06 -0700 (PDT)
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
From:   Jens Axboe <axboe@kernel.dk>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <x498ryno93g.fsf@segfault.boston.devel.redhat.com>
 <16a7a029-0d23-6a14-9ae9-79ab8a9adb34@kernel.dk>
 <x494k9bo84w.fsf@segfault.boston.devel.redhat.com>
 <80244d5b-692c-35ac-e468-2581ff869395@kernel.dk>
Message-ID: <8f5fdbbf-dc66-fabe-db3b-01b2085083b0@kernel.dk>
Date:   Wed, 20 Oct 2021 12:56:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <80244d5b-692c-35ac-e468-2581ff869395@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/20/21 12:41 PM, Jens Axboe wrote:
> Working on just changing it to a 64-bit type instead, then we can pass
> in both at once with res2 being the upper 32 bits. That'll keep the same
> API on the aio side.

Here's that as an incremental. Since we can only be passing in 32-bits
anyway across 32/64-bit, we can just make it an explicit 64-bit instead.
This generates the same code on 64-bit for calling ->ki_complete, and we
can trivially ignore the usb gadget issue as we now can pass in both
values (and fill them in on the aio side).

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 92b87aa8be86..66c6e0c5d638 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -550,7 +550,7 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 		blk_mq_complete_request(rq);
 }
 
-static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
+static void lo_rw_aio_complete(struct kiocb *iocb, u64 ret)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 80a0f35ae1dc..83a2f5b0a3a0 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -123,7 +123,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	return call_iter(iocb, &iter);
 }
 
-static void nvmet_file_io_done(struct kiocb *iocb, long ret)
+static void nvmet_file_io_done(struct kiocb *iocb, u64 ret)
 {
 	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
 	u16 status = NVME_SC_SUCCESS;
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 968ace2ddf64..c4ca7fa18e61 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -245,7 +245,7 @@ struct target_core_file_cmd {
 	struct bio_vec	bvecs[];
 };
 
-static void cmd_rw_aio_complete(struct kiocb *iocb, long ret)
+static void cmd_rw_aio_complete(struct kiocb *iocb, u64 ret)
 {
 	struct target_core_file_cmd *cmd;
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index e20c19a0f106..8536f19d3c9a 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -831,7 +831,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 		kthread_unuse_mm(io_data->mm);
 	}
 
-	io_data->kiocb->ki_complete(io_data->kiocb, ret);
+	io_data->kiocb->ki_complete(io_data->kiocb, ((u64) ret << 32) | ret);
 
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index ad1739dbfab9..d3deb23eb2ab 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -469,7 +469,7 @@ static void ep_user_copy_worker(struct work_struct *work)
 		ret = -EFAULT;
 
 	/* completing the iocb can drop the ctx and mm, don't touch mm after */
-	iocb->ki_complete(iocb, ret);
+	iocb->ki_complete(iocb, ((u64) ret << 32) | ret);
 
 	kfree(priv->buf);
 	kfree(priv->to_free);
@@ -492,14 +492,16 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
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
-				req->actual ? req->actual : (long)req->status);
+		aio_ret = req->actual ? req->actual : (long)req->status;
+		aio_ret |= (u64) req->status << 32;
+		iocb->ki_complete(iocb, aio_ret);
 	} else {
 		/* ep_copy_to_user() won't report both; we hide some faults */
 		if (unlikely(0 != req->status))
diff --git a/fs/aio.c b/fs/aio.c
index 836dc7e48db7..e39c61dccf37 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1417,7 +1417,7 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 
-static void aio_complete_rw(struct kiocb *kiocb, long res)
+static void aio_complete_rw(struct kiocb *kiocb, u64 res)
 {
 	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
 
@@ -1436,8 +1436,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
 		file_end_write(kiocb->ki_filp);
 	}
 
-	iocb->ki_res.res = res;
-	iocb->ki_res.res2 = 0;
+	iocb->ki_res.res = res & 0xffffffff;
+	iocb->ki_res.res2 = res >> 32;
 	iocb_put(iocb);
 }
 
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index effe37ef8629..b2f44ff8eae2 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -37,11 +37,11 @@ static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
 /*
  * Handle completion of a read from the cache.
  */
-static void cachefiles_read_complete(struct kiocb *iocb, long ret)
+static void cachefiles_read_complete(struct kiocb *iocb, u64 ret)
 {
 	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
 
-	_enter("%ld", ret);
+	_enter("%llu", (unsigned long long) ret);
 
 	if (ki->term_func) {
 		if (ret >= 0)
@@ -159,12 +159,12 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 /*
  * Handle completion of a write to the cache.
  */
-static void cachefiles_write_complete(struct kiocb *iocb, long ret)
+static void cachefiles_write_complete(struct kiocb *iocb, u64 ret)
 {
 	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
 	struct inode *inode = file_inode(ki->iocb.ki_filp);
 
-	_enter("%ld", ret);
+	_enter("%llu", (unsigned long long) ret);
 
 	/* Tell lockdep we inherited freeze protection from submission thread */
 	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5ad046145f29..0ed6c199f394 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2672,7 +2672,7 @@ static void __io_complete_rw(struct io_kiocb *req, long res, long res2,
 	__io_req_complete(req, issue_flags, req->result, io_put_rw_kbuf(req));
 }
 
-static void io_complete_rw(struct kiocb *kiocb, long res)
+static void io_complete_rw(struct kiocb *kiocb, u64 res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
@@ -2683,7 +2683,7 @@ static void io_complete_rw(struct kiocb *kiocb, long res)
 	io_req_task_work_add(req);
 }
 
-static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
+static void io_complete_rw_iopoll(struct kiocb *kiocb, u64 res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index ac461a499882..ff7db16aea2e 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -272,7 +272,7 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	kmem_cache_free(ovl_aio_request_cachep, aio_req);
 }
 
-static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
+static void ovl_aio_rw_complete(struct kiocb *iocb, u64 res)
 {
 	struct ovl_aio_req *aio_req = container_of(iocb,
 						   struct ovl_aio_req, iocb);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0dcb9020a7b3..3c809ce2518c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -330,7 +330,7 @@ struct kiocb {
 	randomized_struct_fields_start
 
 	loff_t			ki_pos;
-	void (*ki_complete)(struct kiocb *iocb, long ret);
+	void (*ki_complete)(struct kiocb *iocb, u64 ret);
 	void			*private;
 	int			ki_flags;
 	u16			ki_hint;

-- 
Jens Axboe

