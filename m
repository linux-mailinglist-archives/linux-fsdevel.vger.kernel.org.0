Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BF4406D37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 15:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhIJN7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhIJN7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:59:03 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C16C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 06:57:52 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n24so2413121ion.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=okxowYiYpVAz+QOVLwdcNcrp4VmSwPX31n5dFtu44U4=;
        b=emWQ7Ed3o/yh9av13hdO8A64Jqg0BHkBj74jZ9GWNmXLvTlst/JH0JlgnaGmR0g6oQ
         OpmVxkZY8X81nheWbAGNsBzbKGT4OfmhMRNbw9KQyK0cgS4McFgjjl4wnKpY1NvbBaf7
         +PB9Xt/bgNyoAU05qv2SLlxM+/aqoblXriO2etLGqW/tnQBZ0gaX+fU8G2cnR50yB3XK
         vZkUZngoEa7udrj227EonEZj/AmKcmZw/aWT64ff9VRlaw/3Un6GuH2c+pEx22WCR/Jh
         zCg6G08kRkE/qae2m8xD4nWkoV0ZmkFHib/Ny/g9x/Gq58m1fUi9IZFmCUCXVqt80K/5
         Wkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=okxowYiYpVAz+QOVLwdcNcrp4VmSwPX31n5dFtu44U4=;
        b=AyNpe5gHJ5BpHvS8J04q+kXuv8huMp1fTDdozfb6qKXRYs7zPFNqyqNA0n03tmXG+H
         uXtzsXauxv200mpWp7dEwZQsSASTF99jbUEmLhjJxs2g4cJN9x6qEMDW8J1Pz5ELWWbh
         1huOGtcmFMLQsx6OVjvNcVdyy975jNAQLb/CZgg2kNkl85ummZ46kl/pAE3Nrv64581R
         5ZQO3d+PB28Ei+j4Vl4BpdPM+U5fVwjB5rsPAOfYaCRBeofNTGXtjSqB7P7DSFGE8+PE
         TavgkaEfrOvrD3F81ka4hYSfTuxB5viWBBuY0sXVLIxV/zrVQZ0nkJzbujGupSFoHHWg
         9GVQ==
X-Gm-Message-State: AOAM531Yc5IXRh0wVjm2eiim1t2P/jydJWBaYoSJ1ZFmrLuJuGnNAwbC
        1xgcgUVKIM29rqudu1LXuWBi7f/PmEXeyQ==
X-Google-Smtp-Source: ABdhPJyxs/i5tyRSPvaZGRBl4794yVfWF/PP8MrdDXRWszUIpBx+KThTIBBNGhNdaGT/x1/7JrICdQ==
X-Received: by 2002:a5e:c00a:: with SMTP id u10mr7117244iol.60.1631282271309;
        Fri, 10 Sep 2021 06:57:51 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z26sm2544886iol.6.2021.09.10.06.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 06:57:50 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
Date:   Fri, 10 Sep 2021 07:57:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 9:36 PM, Al Viro wrote:
> On Thu, Sep 09, 2021 at 09:30:03PM -0600, Jens Axboe wrote:
> 
>>> Again, we should never, ever modify the iovec (or bvec, etc.) array in
>>> ->read_iter()/->write_iter()/->sendmsg()/etc. instances.  If you see
>>> such behaviour anywhere, report it immediately.  Any such is a blatant
>>> bug.
>>
>> Yes that was wrong, the iovec is obviously const. But that really
>> doesn't change the original point, which was that copying the iov_iter
>> itself unconditionally would be miserable.
> 
> Might very well be true, but... won't your patch hit the reimport on
> every short read?  And the cost of uaccess in there is *much* higher
> than copying of 48 bytes into local variable...
> 
> Or am I misreading your patch?  Note that short reads on reaching
> EOF are obviously normal - it's not a rare case at all.

It was just a quick hack, might very well be too eager to go through
those motions. But pondering this instead of sleeping, we don't need to
copy all of iov_iter in order to restore the state, and we can use the
same advance after restoring. So something like this may be more
palatable. Caveat - again untested, and I haven't tested the performance
impact of this at all.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 855ea544807f..4d6d4315deda 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2608,8 +2608,6 @@ static bool io_resubmit_prep(struct io_kiocb *req)
 
 	if (!rw)
 		return !io_req_prep_async(req);
-	/* may have left rw->iter inconsistent on -EIOCBQUEUED */
-	iov_iter_revert(&rw->iter, req->result - iov_iter_count(&rw->iter));
 	return true;
 }
 
@@ -3431,14 +3429,45 @@ static bool need_read_all(struct io_kiocb *req)
 		S_ISBLK(file_inode(req->file)->i_mode);
 }
 
+/*
+ * Stash the items we need to restore an iov_iter after a partial or
+ * -EAGAIN'ed result.
+ */
+struct iov_store {
+	ssize_t io_size;
+	size_t iov_offset;
+	unsigned long nr_segs;
+	const void *ptr;
+};
+
+static void io_iter_reset(struct iov_iter *iter, struct iov_store *store,
+			  ssize_t did_bytes)
+{
+	iter->count = store->io_size;
+	iter->iov_offset = store->iov_offset;
+	iter->nr_segs = store->nr_segs;
+	iter->iov = store->ptr;
+	if (did_bytes > 0)
+		iov_iter_advance(iter, did_bytes);
+}
+
+static void io_iov_store(struct iov_store *store, struct iov_iter *iter)
+{
+	store->io_size = iov_iter_count(iter);
+	store->iov_offset = iter->iov_offset;
+	store->nr_segs = iter->nr_segs;
+	store->ptr = iter->iov;
+}
+
 static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw.kiocb;
 	struct iov_iter __iter, *iter = &__iter;
 	struct io_async_rw *rw = req->async_data;
-	ssize_t io_size, ret, ret2;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
+	struct iov_store store;
+	ssize_t ret, ret2;
 
 	if (rw) {
 		iter = &rw->iter;
@@ -3448,8 +3477,8 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 		if (ret < 0)
 			return ret;
 	}
-	io_size = iov_iter_count(iter);
-	req->result = io_size;
+	io_iov_store(&store, iter);
+	req->result = store.io_size;
 
 	/* Ensure we clear previously set non-block flag */
 	if (!force_nonblock)
@@ -3463,7 +3492,7 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 		return ret ?: -EAGAIN;
 	}
 
-	ret = rw_verify_area(READ, req->file, io_kiocb_ppos(kiocb), io_size);
+	ret = rw_verify_area(READ, req->file, io_kiocb_ppos(kiocb), store.io_size);
 	if (unlikely(ret)) {
 		kfree(iovec);
 		return ret;
@@ -3479,18 +3508,17 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 		/* no retry on NONBLOCK nor RWF_NOWAIT */
 		if (req->flags & REQ_F_NOWAIT)
 			goto done;
-		/* some cases will consume bytes even on error returns */
-		iov_iter_reexpand(iter, iter->count + iter->truncated);
-		iov_iter_revert(iter, io_size - iov_iter_count(iter));
 		ret = 0;
 	} else if (ret == -EIOCBQUEUED) {
 		goto out_free;
-	} else if (ret <= 0 || ret == io_size || !force_nonblock ||
+	} else if (ret <= 0 || ret == store.io_size || !force_nonblock ||
 		   (req->flags & REQ_F_NOWAIT) || !need_read_all(req)) {
 		/* read all, failed, already did sync or don't want to retry */
 		goto done;
 	}
 
+	io_iter_reset(iter, &store, ret);
+
 	ret2 = io_setup_async_rw(req, iovec, inline_vecs, iter, true);
 	if (ret2)
 		return ret2;
@@ -3501,7 +3529,7 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 	iter = &rw->iter;
 
 	do {
-		io_size -= ret;
+		store.io_size -= ret;
 		rw->bytes_done += ret;
 		/* if we can retry, do so with the callbacks armed */
 		if (!io_rw_should_retry(req)) {
@@ -3520,7 +3548,7 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 			return 0;
 		/* we got some bytes, but not all. retry. */
 		kiocb->ki_flags &= ~IOCB_WAITQ;
-	} while (ret > 0 && ret < io_size);
+	} while (ret > 0 && ret < store.io_size);
 done:
 	kiocb_done(kiocb, ret, issue_flags);
 out_free:
@@ -3543,8 +3571,9 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	struct kiocb *kiocb = &req->rw.kiocb;
 	struct iov_iter __iter, *iter = &__iter;
 	struct io_async_rw *rw = req->async_data;
-	ssize_t ret, ret2, io_size;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
+	struct iov_store store;
+	ssize_t ret, ret2;
 
 	if (rw) {
 		iter = &rw->iter;
@@ -3554,8 +3583,10 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		if (ret < 0)
 			return ret;
 	}
-	io_size = iov_iter_count(iter);
-	req->result = io_size;
+
+	io_iov_store(&store, iter);
+	req->result = store.io_size;
+	ret2 = 0;
 
 	/* Ensure we clear previously set non-block flag */
 	if (!force_nonblock)
@@ -3572,7 +3603,7 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	    (req->flags & REQ_F_ISREG))
 		goto copy_iov;
 
-	ret = rw_verify_area(WRITE, req->file, io_kiocb_ppos(kiocb), io_size);
+	ret = rw_verify_area(WRITE, req->file, io_kiocb_ppos(kiocb), store.io_size);
 	if (unlikely(ret))
 		goto out_free;
 
@@ -3619,9 +3650,7 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		kiocb_done(kiocb, ret2, issue_flags);
 	} else {
 copy_iov:
-		/* some cases will consume bytes even on error returns */
-		iov_iter_reexpand(iter, iter->count + iter->truncated);
-		iov_iter_revert(iter, io_size - iov_iter_count(iter));
+		io_iter_reset(iter, &store, ret2);
 		ret = io_setup_async_rw(req, iovec, inline_vecs, iter, false);
 		return ret ?: -EAGAIN;
 	}

-- 
Jens Axboe

