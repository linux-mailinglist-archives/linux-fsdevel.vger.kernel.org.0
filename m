Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A496406F26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhIJQLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 12:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhIJQJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:09:39 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4041CC0613A0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 09:06:27 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id f6so3029677iox.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/3V2asYgEL3IE7mdskqpgHQZ4oGGrM9O3oWQARXZJX8=;
        b=HIjCu36ckpson0cUVfNHptlBNTsv81dBc5K/3SNUPKS1dLPAxX+G+Tvl/XTAVTkfbX
         GOlsFa+/89uxxKZEIkppbJA0uTOkLzZHsGNkn24F1L7JqHRQBGO7C0wnMjA0oIBwhso+
         1W0Xl/GJaIkq92imBG+cZZdNHLxWchbsHNMERmi3CNebtGvBFAt4N9Lo16wnD78chlvA
         4WhppEWsp8it46Jxxv4zV+No/qH4pJnKATCBZq6HmSo34+S64j5vat9swUro0aAZnCAz
         7OqXTqHwcMT6sV0pqQCfnrv5bHemasGZ1idhqAj1i1/m+RUPSoNLu0ukQFR19YsA5pOe
         K9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/3V2asYgEL3IE7mdskqpgHQZ4oGGrM9O3oWQARXZJX8=;
        b=ZwwzfQYFQvME7DklJfy4mc1Psiz9isUUYGeqagv/BjSGI0k8ig49NpY3nM4kqlrKxN
         7+VY2/AuWEEh+YHTJ3Uy914eW2lcdLFO7iO+H9H9icZF+VaqwgzA1D5jOJbdlikAOKtZ
         9zwP7c8nZ74xNAtldMyw3NBgmvAuMAQTo2jDC/Xyi2++4D0BI/klHAPz0Z+rV0tYD1Mw
         GE4L4Oa0p+aRh0qKp58grGGaqqSASGhD2AwS5mvc99ZhqeFFQU53qjAjs0OXg7dtp6p/
         BAotg6tF2njE74BPC1woEAS0sp7eRQxdNKFPD29Jz4/Kb7wqWgVEdBeJ4bIX87vN+CVJ
         /N/A==
X-Gm-Message-State: AOAM531p4v11PgLtwbTVOkA3A+YUkiDZfdMPr0kPqUESUbkGKit9fAyv
        gShkyf/YHjwcTS0i9CNXaRp7pd5GMGe6XJacOYM=
X-Google-Smtp-Source: ABdhPJwl4SWp8hlYVyStkdT3piQw4dgF0sMX6zBsoiIi3AnjHUggyeDOkkfkI99vY816jpRcPlCztw==
X-Received: by 2002:a6b:3e89:: with SMTP id l131mr7794490ioa.74.1631289986259;
        Fri, 10 Sep 2021 09:06:26 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x12sm2683824ilm.56.2021.09.10.09.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 09:06:25 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
From:   Jens Axboe <axboe@kernel.dk>
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
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk>
Message-ID: <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
Date:   Fri, 10 Sep 2021 10:06:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/21 9:04 AM, Jens Axboe wrote:
> We could pretty this up and have the state part be explicit in iov_iter,
> and have the store/restore parts end up in uio.h. That'd tie them closer
> together, though I don't expect iov_iter changes to be an issue. It
> would make it more maintainable, though. I'll try and hack up this
> generic solution, see if that looks any better.

Looks something like this. Not super pretty in terms of needing a define
for this, and maybe I'm missing something, but ideally we'd want it as
an anonymous struct that's defined inside iov_iter. Anyway, gets the
point across. Alternatively, since we're down to just a few members now,
we just duplicate them in each struct...

Would be split into two patches, one for the iov_state addition and
the save/restore helpers, and then one switching io_uring to use them.
Figured we'd need some agreement on this first...


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 855ea544807f..539c94299d64 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2608,8 +2608,6 @@ static bool io_resubmit_prep(struct io_kiocb *req)
 
 	if (!rw)
 		return !io_req_prep_async(req);
-	/* may have left rw->iter inconsistent on -EIOCBQUEUED */
-	iov_iter_revert(&rw->iter, req->result - iov_iter_count(&rw->iter));
 	return true;
 }
 
@@ -3431,14 +3429,23 @@ static bool need_read_all(struct io_kiocb *req)
 		S_ISBLK(file_inode(req->file)->i_mode);
 }
 
+static void io_iter_restore(struct iov_iter *iter, struct iov_iter_state *state,
+			    ssize_t did_bytes)
+{
+	iov_iter_restore_state(iter, state);
+	if (did_bytes > 0)
+		iov_iter_advance(iter, did_bytes);
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
+	struct iov_iter_state state;
+	ssize_t ret, ret2;
 
 	if (rw) {
 		iter = &rw->iter;
@@ -3448,8 +3455,8 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 		if (ret < 0)
 			return ret;
 	}
-	io_size = iov_iter_count(iter);
-	req->result = io_size;
+	req->result = iov_iter_count(iter);
+	iov_iter_save_state(iter, &state);
 
 	/* Ensure we clear previously set non-block flag */
 	if (!force_nonblock)
@@ -3463,7 +3470,7 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 		return ret ?: -EAGAIN;
 	}
 
-	ret = rw_verify_area(READ, req->file, io_kiocb_ppos(kiocb), io_size);
+	ret = rw_verify_area(READ, req->file, io_kiocb_ppos(kiocb), state.count);
 	if (unlikely(ret)) {
 		kfree(iovec);
 		return ret;
@@ -3479,18 +3486,17 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
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
+	} else if (ret <= 0 || ret == state.count || !force_nonblock ||
 		   (req->flags & REQ_F_NOWAIT) || !need_read_all(req)) {
 		/* read all, failed, already did sync or don't want to retry */
 		goto done;
 	}
 
+	io_iter_restore(iter, &state, ret);
+
 	ret2 = io_setup_async_rw(req, iovec, inline_vecs, iter, true);
 	if (ret2)
 		return ret2;
@@ -3501,7 +3507,7 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 	iter = &rw->iter;
 
 	do {
-		io_size -= ret;
+		state.count -= ret;
 		rw->bytes_done += ret;
 		/* if we can retry, do so with the callbacks armed */
 		if (!io_rw_should_retry(req)) {
@@ -3520,7 +3526,7 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 			return 0;
 		/* we got some bytes, but not all. retry. */
 		kiocb->ki_flags &= ~IOCB_WAITQ;
-	} while (ret > 0 && ret < io_size);
+	} while (ret > 0 && ret < state.count);
 done:
 	kiocb_done(kiocb, ret, issue_flags);
 out_free:
@@ -3543,8 +3549,9 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	struct kiocb *kiocb = &req->rw.kiocb;
 	struct iov_iter __iter, *iter = &__iter;
 	struct io_async_rw *rw = req->async_data;
-	ssize_t ret, ret2, io_size;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
+	struct iov_iter_state state;
+	ssize_t ret, ret2;
 
 	if (rw) {
 		iter = &rw->iter;
@@ -3554,8 +3561,9 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		if (ret < 0)
 			return ret;
 	}
-	io_size = iov_iter_count(iter);
-	req->result = io_size;
+	req->result = iov_iter_count(iter);
+	iov_iter_save_state(iter, &state);
+	ret2 = 0;
 
 	/* Ensure we clear previously set non-block flag */
 	if (!force_nonblock)
@@ -3572,7 +3580,7 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	    (req->flags & REQ_F_ISREG))
 		goto copy_iov;
 
-	ret = rw_verify_area(WRITE, req->file, io_kiocb_ppos(kiocb), io_size);
+	ret = rw_verify_area(WRITE, req->file, io_kiocb_ppos(kiocb), state.count);
 	if (unlikely(ret))
 		goto out_free;
 
@@ -3619,9 +3627,7 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		kiocb_done(kiocb, ret2, issue_flags);
 	} else {
 copy_iov:
-		/* some cases will consume bytes even on error returns */
-		iov_iter_reexpand(iter, iter->count + iter->truncated);
-		iov_iter_revert(iter, io_size - iov_iter_count(iter));
+		io_iter_restore(iter, &state, ret2);
 		ret = io_setup_async_rw(req, iovec, inline_vecs, iter, false);
 		return ret ?: -EAGAIN;
 	}
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5265024e8b90..4f9d483096cd 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -27,11 +27,25 @@ enum iter_type {
 	ITER_DISCARD,
 };
 
+#define IOV_ITER_STATE					\
+	size_t iov_offset;				\
+	size_t count;					\
+	union {						\
+		unsigned long nr_segs;			\
+		struct {				\
+			unsigned int head;		\
+			unsigned int start_head;	\
+		};					\
+		loff_t xarray_start;			\
+	};						\
+
+struct iov_iter_state {
+	IOV_ITER_STATE;
+};
+
 struct iov_iter {
 	u8 iter_type;
 	bool data_source;
-	size_t iov_offset;
-	size_t count;
 	union {
 		const struct iovec *iov;
 		const struct kvec *kvec;
@@ -40,12 +54,10 @@ struct iov_iter {
 		struct pipe_inode_info *pipe;
 	};
 	union {
-		unsigned long nr_segs;
+		struct iov_iter_state state;
 		struct {
-			unsigned int head;
-			unsigned int start_head;
+			IOV_ITER_STATE;
 		};
-		loff_t xarray_start;
 	};
 	size_t truncated;
 };
@@ -55,6 +67,33 @@ static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 	return i->iter_type;
 }
 
+static inline void iov_iter_save_state(struct iov_iter *iter,
+				       struct iov_iter_state *state)
+{
+	*state = iter->state;
+}
+
+static inline void iov_iter_restore_state(struct iov_iter *iter,
+					  struct iov_iter_state *state)
+{
+	iter->iov_offset = state->iov_offset;
+	iter->count = state->count;
+
+	switch (iov_iter_type(iter)) {
+	case ITER_IOVEC:
+	case ITER_KVEC:
+	case ITER_BVEC:
+		iter->iov -= state->nr_segs - iter->nr_segs;
+		fallthrough;
+	case ITER_PIPE:
+	case ITER_XARRAY:
+		iter->nr_segs = state->nr_segs;
+		break;
+	case ITER_DISCARD:
+		break;
+	}
+}
+
 static inline bool iter_is_iovec(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_IOVEC;

-- 
Jens Axboe

