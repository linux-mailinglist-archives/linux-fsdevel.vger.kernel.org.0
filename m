Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3811784C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 22:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbgCCVUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 16:20:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44329 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732574AbgCCVUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:20:13 -0500
Received: by mail-io1-f67.google.com with SMTP id u17so5254936iog.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 13:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=9Ar9/r7+BDbD/34+HvUiwsnB+crkZJI0IlD+vWVxgqE=;
        b=hDetCesyLVqxMuZBzdnRg3Ma39j3HZc4wwwuLyipCCGsekKV12SuCF8BKvEUUpHxuc
         jC3HgVPyG8lUm/lpU3qzTYWOZdH13K63QdtnfiV89yiIt+PuHnz6d7/tBtP+45do9hIL
         slqppSUkfVuHtkUCKwnpr6Ow7DRBF5kLrWaXl2XvZs8vzpqxQXk3Y8rd2DeMxJ53kSht
         Yz2MJqgnSLG0vdidG9l0BNurGcZUTH6f16079gqUSLhHZe7MEJbyfFcgrzxpye1BohQx
         JJQSUdBkXKu2iAumpdT3GLtoQTjhePL+h8g9GTetDHiUb98ShrZeALGaQdCVqHmXUhpq
         mR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=9Ar9/r7+BDbD/34+HvUiwsnB+crkZJI0IlD+vWVxgqE=;
        b=mLwo1Ol7X6asy8WsFjjLcWRZjPNPyr9yQhD2VZ4rlLD8+X53tf6WjjLb6HbetfuLyy
         v9tZKlx4s8Uhp++VuF8ORp2mWlT+j2xUbFOJXBx1Or60gim2uf7vn/UP8e/dyqktYV2e
         LM0IA/xydwHMtV8QDcbow5Yj6ZZ8h2wO/IxnAibkZIPtjPekeb8TaXLlIXH/Wk3GZDtf
         3BHqfoWfOeHdZkKzk0vdD2dWV2rdj61E02oK8f47eyTi/+AZRLsSeSfCEyLSMNqJ3btq
         h9TWkGKX0AtMqxQh+oMNP5jIIggPFyK3s7NOd26xLOLeKn7fYky1dP/OXibnvinTVbbI
         Mfbg==
X-Gm-Message-State: ANhLgQ1bV3Hl8RnHbl5NRCyCkmWkIDwKB8RllT9rGy6YPXkZuA3xYQq1
        tb2UdDAua/5UJ2IgqMFxBP49Og==
X-Google-Smtp-Source: ADFU+vsChgbp/RUru5Bbrjeylgm5V3IjHDbZa2SxSK8QlzRoPLGnxnXKVnO8cVl57MgyGLsiEoQeaw==
X-Received: by 2002:a5d:9694:: with SMTP id m20mr5839790ion.48.1583270412437;
        Tue, 03 Mar 2020 13:20:12 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c15sm8351270ilq.88.2020.03.03.13.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 13:20:11 -0800 (PST)
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
To:     Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com> <20200303131434.GA2373427@kroah.com>
 <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com> <20200303141030.GA2811@kroah.com>
 <CAG48ez3Z2V8J7dpO6t8nw7O2cMJ6z8vwLZXLAoKGH3OnCb-7JQ@mail.gmail.com>
 <20200303142407.GA47158@kroah.com>
 <030888a2-db3e-919d-d8ef-79dcc10779f9@kernel.dk>
 <acb1753c78a019fb0d54ba29077cef144047f70f.camel@kernel.org>
 <7a05adc8-1ca9-c900-7b24-305f1b3a9b86@kernel.dk>
 <dbb06c63c17c23fcacdd99e8b2266804ee39ffe5.camel@kernel.org>
 <dc84aa00-e570-8833-cf9f-d1001c52dd7a@kernel.dk>
 <cb2a7273a4cac7bac5f5b323e1958242b98e605e.camel@kernel.org>
 <f3e36d79-a324-678d-ae19-eaee14eaefbd@kernel.dk>
 <8b42bcc526a890395e8f25c2f209475101861257.camel@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <85af07aa-7b8f-39b3-419c-807500c03f52@kernel.dk>
Date:   Tue, 3 Mar 2020 14:20:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8b42bcc526a890395e8f25c2f209475101861257.camel@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------14741A061899066CFBF73E9C"
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------14741A061899066CFBF73E9C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 3/3/20 2:03 PM, Jeff Layton wrote:
> On Tue, 2020-03-03 at 13:33 -0700, Jens Axboe wrote:
>> On 3/3/20 12:43 PM, Jeff Layton wrote:
>>> On Tue, 2020-03-03 at 12:23 -0700, Jens Axboe wrote:
>>>> On 3/3/20 12:02 PM, Jeff Layton wrote:
>>>>> Basically, all you'd need to do is keep a pointer to struct file in the
>>>>> internal state for the chain. Then, allow userland to specify some magic
>>>>> fd value for subsequent chained operations that says to use that instead
>>>>> of consulting the fdtable. Maybe use -4096 (-MAX_ERRNO - 1)?
>>>>
>>>> BTW, I think we need two magics here. One that says "result from
>>>> previous is fd for next", and one that says "fd from previous is fd for
>>>> next". The former allows inheritance from open -> read, the latter from
>>>> read -> write.
>>>>
>>>
>>> Do we? I suspect that in almost all of the cases, all we'd care about is
>>> the last open. Also if you have unrelated operations in there you still
>>> have to chain the fd through somehow to the next op which is a bit hard
>>> to do with that scheme.
>>>
>>> I'd just have a single magic carveout that means "use the result of last
>>> open call done in this chain". If you do a second open (or pipe, or...),
>>> then that would put the old struct file pointer and drop a new one in
>>> there.
>>>
>>> If we really do want to enable multiple opens in a single chain though,
>>> then we might want to rethink this and consider some sort of slot table
>>> for storing open fds.
>>
>> I think the one magic can work, you just have to define your chain
>> appropriately for the case where you have multiple opens. That's true
>> for the two magic approach as well, of course, I don't want a stack of
>> open fds, just "last open" should suffice.
>>
> 
> Yep.
> 
>> I don't like the implicit close, if your op opens an fd, something
>> should close it again. You pass it back to the application in any case
>> for io_uring, so the app can just close it. Which means that your chain
>> should just include a close for whatever fd you open, unless you plan on
>> using it in the application aftwards.
>>
> 
> Yeah sorry, I didn't word that correctly. Let me try again:
> 
> My thinking was that you would still return the result of the open to
> userland, but also stash a struct file pointer in the internal chain
> representation. Then you just refer to that when you get the "magic" fd.
> 
> You'd still need to explicitly close the file though if you didn't want
> to use it past the end of the current chain. So, I guess you _do_ need
> the actual fd to properly close the file in that case.

Right, I'm caching both the fd and the file, we'll need both. See below,
quick hack. Needs a few prep patches, we always prepare the file upfront
and the prep handlers expect it to be there, we'd have to do things a
bit differently for that. And attached small test app that does
open+read+close.

> On another note, what happens if you do open+write+close and the write
> fails? Does the close still happen, or would you have to issue one
> separately after getting the result?

For any io_uring chain, if any link in the chain fails, then the rest of
the chain is errored. So if your open fails, you'd get -ECANCELED for
your read+close. If your read fails, just the close is errored. So yes,
you'd have to close the fd again if the chain doesn't fully execute.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0e2065614ace..bbaea6b3e16a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -488,6 +488,10 @@ enum {
 	REQ_F_NEED_CLEANUP_BIT,
 	REQ_F_OVERFLOW_BIT,
 	REQ_F_POLLED_BIT,
+	REQ_F_OPEN_FD_BIT,
+
+	/* not a real bit, just to check we're not overflowing the space */
+	__REQ_F_LAST_BIT,
 };
 
 enum {
@@ -532,6 +536,8 @@ enum {
 	REQ_F_OVERFLOW		= BIT(REQ_F_OVERFLOW_BIT),
 	/* already went through poll handler */
 	REQ_F_POLLED		= BIT(REQ_F_POLLED_BIT),
+	/* use chain previous open fd */
+	REQ_F_OPEN_FD		= BIT(REQ_F_OPEN_FD_BIT),
 };
 
 struct async_poll {
@@ -593,6 +599,8 @@ struct io_kiocb {
 			struct callback_head	task_work;
 			struct hlist_node	hash_node;
 			struct async_poll	*apoll;
+			struct file		*last_open_file;
+			int			last_open_fd;
 		};
 		struct io_wq_work	work;
 	};
@@ -1292,7 +1300,7 @@ static inline void io_put_file(struct io_kiocb *req, struct file *file,
 {
 	if (fixed)
 		percpu_ref_put(&req->ctx->file_data->refs);
-	else
+	else if (!(req->flags & REQ_F_OPEN_FD))
 		fput(file);
 }
 
@@ -1435,6 +1443,12 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 		list_del_init(&req->link_list);
 		if (!list_empty(&nxt->link_list))
 			nxt->flags |= REQ_F_LINK;
+		if (nxt->flags & REQ_F_OPEN_FD) {
+			WARN_ON_ONCE(nxt->file);
+			nxt->last_open_file = req->last_open_file;
+			nxt->last_open_fd = req->last_open_fd;
+			nxt->file = req->last_open_file;
+		}
 		*nxtptr = nxt;
 		break;
 	}
@@ -1957,37 +1971,20 @@ static bool io_file_supports_async(struct file *file)
 	return false;
 }
 
-static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      bool force_nonblock)
+static int __io_prep_rw(struct io_kiocb *req, bool force_nonblock)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw.kiocb;
-	unsigned ioprio;
-	int ret;
 
 	if (S_ISREG(file_inode(req->file)->i_mode))
 		req->flags |= REQ_F_ISREG;
 
-	kiocb->ki_pos = READ_ONCE(sqe->off);
 	if (kiocb->ki_pos == -1 && !(req->file->f_mode & FMODE_STREAM)) {
 		req->flags |= REQ_F_CUR_POS;
 		kiocb->ki_pos = req->file->f_pos;
 	}
 	kiocb->ki_hint = ki_hint_validate(file_write_hint(kiocb->ki_filp));
-	kiocb->ki_flags = iocb_flags(kiocb->ki_filp);
-	ret = kiocb_set_rw_flags(kiocb, READ_ONCE(sqe->rw_flags));
-	if (unlikely(ret))
-		return ret;
-
-	ioprio = READ_ONCE(sqe->ioprio);
-	if (ioprio) {
-		ret = ioprio_check_cap(ioprio);
-		if (ret)
-			return ret;
-
-		kiocb->ki_ioprio = ioprio;
-	} else
-		kiocb->ki_ioprio = get_current_ioprio();
+	kiocb->ki_flags |= iocb_flags(kiocb->ki_filp);
 
 	/* don't allow async punt if RWF_NOWAIT was requested */
 	if ((kiocb->ki_flags & IOCB_NOWAIT) ||
@@ -2011,6 +2008,31 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		kiocb->ki_complete = io_complete_rw;
 	}
 
+	return 0;
+}
+
+static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct kiocb *kiocb = &req->rw.kiocb;
+	unsigned ioprio;
+	int ret;
+
+	kiocb->ki_pos = READ_ONCE(sqe->off);
+
+	ret = kiocb_set_rw_flags(kiocb, READ_ONCE(sqe->rw_flags));
+	if (unlikely(ret))
+		return ret;
+
+	ioprio = READ_ONCE(sqe->ioprio);
+	if (ioprio) {
+		ret = ioprio_check_cap(ioprio);
+		if (ret)
+			return ret;
+
+		kiocb->ki_ioprio = ioprio;
+	} else
+		kiocb->ki_ioprio = get_current_ioprio();
+
 	req->rw.addr = READ_ONCE(sqe->addr);
 	req->rw.len = READ_ONCE(sqe->len);
 	/* we own ->private, reuse it for the buffer index */
@@ -2273,13 +2295,10 @@ static int io_read_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct iov_iter iter;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, sqe, force_nonblock);
+	ret = io_prep_rw(req, sqe);
 	if (ret)
 		return ret;
 
-	if (unlikely(!(req->file->f_mode & FMODE_READ)))
-		return -EBADF;
-
 	/* either don't need iovec imported or already have it */
 	if (!req->io || req->flags & REQ_F_NEED_CLEANUP)
 		return 0;
@@ -2304,6 +2323,13 @@ static int io_read(struct io_kiocb *req, bool force_nonblock)
 	size_t iov_count;
 	ssize_t io_size, ret;
 
+	ret = __io_prep_rw(req, force_nonblock);
+	if (ret)
+		return ret;
+
+	if (unlikely(!(req->file->f_mode & FMODE_READ)))
+		return -EBADF;
+
 	ret = io_import_iovec(READ, req, &iovec, &iter);
 	if (ret < 0)
 		return ret;
@@ -2362,13 +2388,10 @@ static int io_write_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct iov_iter iter;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, sqe, force_nonblock);
+	ret = io_prep_rw(req, sqe);
 	if (ret)
 		return ret;
 
-	if (unlikely(!(req->file->f_mode & FMODE_WRITE)))
-		return -EBADF;
-
 	/* either don't need iovec imported or already have it */
 	if (!req->io || req->flags & REQ_F_NEED_CLEANUP)
 		return 0;
@@ -2393,6 +2416,13 @@ static int io_write(struct io_kiocb *req, bool force_nonblock)
 	size_t iov_count;
 	ssize_t ret, io_size;
 
+	ret = __io_prep_rw(req, force_nonblock);
+	if (ret)
+		return ret;
+
+	if (unlikely(!(req->file->f_mode & FMODE_WRITE)))
+		return -EBADF;
+
 	ret = io_import_iovec(WRITE, req, &iovec, &iter);
 	if (ret < 0)
 		return ret;
@@ -2737,8 +2767,8 @@ static int io_openat2_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 static int io_openat2(struct io_kiocb *req, bool force_nonblock)
 {
+	struct file *file = NULL;
 	struct open_flags op;
-	struct file *file;
 	int ret;
 
 	if (force_nonblock)
@@ -2763,8 +2793,12 @@ static int io_openat2(struct io_kiocb *req, bool force_nonblock)
 err:
 	putname(req->open.filename);
 	req->flags &= ~REQ_F_NEED_CLEANUP;
-	if (ret < 0)
+	if (ret < 0) {
 		req_set_fail_links(req);
+	} else if (req->flags & REQ_F_LINK) {
+		req->last_open_file = file;
+		req->last_open_fd = ret;
+	}
 	io_cqring_add_event(req, ret);
 	io_put_req(req);
 	return 0;
@@ -2980,10 +3014,6 @@ static int io_close_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EBADF;
 
 	req->close.fd = READ_ONCE(sqe->fd);
-	if (req->file->f_op == &io_uring_fops ||
-	    req->close.fd == req->ctx->ring_fd)
-		return -EBADF;
-
 	return 0;
 }
 
@@ -3013,6 +3043,18 @@ static int io_close(struct io_kiocb *req, bool force_nonblock)
 {
 	int ret;
 
+	if (req->flags & REQ_F_OPEN_FD) {
+		if (req->close.fd != IOSQE_FD_LAST_OPEN)
+			return -EBADF;
+		req->close.fd = req->last_open_fd;
+		req->last_open_file = NULL;
+		req->last_open_fd = -1;
+	}
+
+	if (req->file->f_op == &io_uring_fops ||
+	    req->close.fd == req->ctx->ring_fd)
+		return -EBADF;
+
 	req->close.put_file = NULL;
 	ret = __close_fd_get_file(req->close.fd, &req->close.put_file);
 	if (ret < 0)
@@ -3437,8 +3479,14 @@ static int __io_accept(struct io_kiocb *req, bool force_nonblock)
 		return -EAGAIN;
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
-	if (ret < 0)
+	if (ret < 0) {
 		req_set_fail_links(req);
+	} else if (req->flags & REQ_F_LINK) {
+		rcu_read_lock();
+		req->last_open_file = fcheck_files(current->files, ret);
+		rcu_read_unlock();
+		req->last_open_fd = ret;
+	}
 	io_cqring_add_event(req, ret);
 	io_put_req(req);
 	return 0;
@@ -4779,6 +4827,14 @@ static int io_req_set_file(struct io_submit_state *state, struct io_kiocb *req,
 		return 0;
 
 	fixed = (flags & IOSQE_FIXED_FILE);
+	if (fd == IOSQE_FD_LAST_OPEN) {
+		if (fixed)
+			return -EBADF;
+		req->flags |= REQ_F_OPEN_FD;
+		req->file = NULL;
+		return 0;
+	}
+
 	if (unlikely(!fixed && req->needs_fixed_file))
 		return -EBADF;
 
@@ -7448,6 +7504,7 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 
 	BUILD_BUG_ON(ARRAY_SIZE(io_op_defs) != IORING_OP_LAST);
+	BUILD_BUG_ON(__REQ_F_LAST_BIT >= 8 * sizeof(int));
 	req_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
 	return 0;
 };
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 53b36311cdac..3ccf74efe381 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -77,6 +77,12 @@ enum {
 /* always go async */
 #define IOSQE_ASYNC		(1U << IOSQE_ASYNC_BIT)
 
+/*
+ * 'magic' ->fd values don't point to a real fd, but rather define how fds
+ * can be inherited through links in a chain
+ */
+#define IOSQE_FD_LAST_OPEN	(-4096)	/* previous result is fd */
+
 /*
  * io_uring_setup() flags
  */

-- 
Jens Axboe


--------------14741A061899066CFBF73E9C
Content-Type: text/x-csrc; charset=UTF-8;
 name="orc.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="orc.c"

/* SPDX-License-Identifier: MIT */
/*
 * Description: open+read+close link sequence with fd passing
 *
 */
#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

#include "liburing.h"

static int test_orc(struct io_uring *ring, const char *fname)
{
	struct io_uring_cqe *cqe;
	struct io_uring_sqe *sqe;
	char buf[4096];
	int ret, i;

	sqe = io_uring_get_sqe(ring);
	io_uring_prep_openat(sqe, AT_FDCWD, fname, O_RDONLY, 0);
	sqe->flags |= IOSQE_IO_LINK;
	sqe->user_data = IORING_OP_OPENAT;

	sqe = io_uring_get_sqe(ring);
	io_uring_prep_read(sqe, -4096, buf, sizeof(buf), 0);
	sqe->flags |= IOSQE_IO_LINK;
	sqe->user_data = IORING_OP_READ;

	sqe = io_uring_get_sqe(ring);
	io_uring_prep_close(sqe, -4096);
	sqe->user_data = IORING_OP_CLOSE;

	ret = io_uring_submit(ring);
	if (ret != 3) {
		fprintf(stderr, "sqe submit failed: %d\n", ret);
		goto err;
	}

	for (i = 0; i < 3; i++) {
		ret = io_uring_wait_cqe(ring, &cqe);
		if (ret < 0) {
			fprintf(stderr, "wait completion %d\n", ret);
			goto err;
		}

		printf("%d: op=%u, res=%d\n", i, (unsigned) cqe->user_data, cqe->res);
		io_uring_cqe_seen(ring, cqe);
	}

	return 0;
err:
	return 1;
}

int main(int argc, char *argv[])
{
	struct io_uring ring;
	int ret;

	if (argc < 2) {
		fprintf(stderr, "%s: <file>\n", argv[0]);
		return 1;
	}

	ret = io_uring_queue_init(8, &ring, 0);
	if (ret) {
		fprintf(stderr, "ring setup failed: %d\n", ret);
		return 1;
	}

	ret = test_orc(&ring, argv[1]);
	if (ret) {
		fprintf(stderr, "test_orc failed\n");
		return ret;
	}

	return 0;
}

--------------14741A061899066CFBF73E9C--
