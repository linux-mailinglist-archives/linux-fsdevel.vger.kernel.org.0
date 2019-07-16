Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C276B6AD57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfGPREk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 13:04:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34122 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387949AbfGPREk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:04:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so9416329pfo.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=hhrIECaqFeMtSYPOSGB1ON2ZYOrlKWK9vod56pIpsLQ=;
        b=UjxV0YYR7GZpUcI7FpxBoiVVzv6nox0oZFh2FKiMvJBxEGYW3nl008p3A1ACw3FdrB
         N5R7jrgtG10cPeXNTDZLHsu4GoozNz+ZoKCZs8qF+cB/1E/vruS66Ze7v+hheI30K7TK
         zsj7YwHYU8l5huvA6Qms0GLTjO61ew5bpGNhLk8bKXwO+M9oJkQgAwRabjis0SZekn2y
         i7BMlsuij6cuoPCQOr0fs+8nIOR96zkUpLjMz22/Ne1CT6Lm8waxJrRhZYGj8J2iXV9+
         CeBoItfQUnYfUm1q0Mnti0fCNy1Jwwj2VRqmCsjkQPaWxq9FzgrfeZ7rQ9UGklXHOrM+
         Ev6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=hhrIECaqFeMtSYPOSGB1ON2ZYOrlKWK9vod56pIpsLQ=;
        b=hSr0C+M3hphjhIcI6p3ijQstyTH68keZ6fl82aKN79yontjvhDn+/VqZr+6ZhwWj4m
         Lsbp+8qblqSQpyigVbysTfiNz8HK7Tbjotrid25vSeDmG+g35h5XDBHIwWT7KblRL/qG
         IbFvYfX1CQnP3bmn+cDW3Zqi119/qD+WFfyRNsYqFuQ+EG9yap9JnQTrstz16gP1ELhh
         DBSMJcS5A1Xv6v+9Cm1vRNoiU9i+zCfVeIlzJ71oiz6oz/mVJDz8IESCqrWxQTCaaIFW
         ooMEGzcgPEKPaZWar4taQxSMDfLmXu9eD+zK3zYVPb86WdHUSW9rFf+ZgmbcZMAFTt1/
         Q+Fw==
X-Gm-Message-State: APjAAAWWNd/4H0eRVcXEYR12oJOiGSXOHebKvRB30iecgjmtJeZITS+t
        QZxRBQz8ztZ3dDHlyTz6XhQ=
X-Google-Smtp-Source: APXvYqwgnPW8NxAKQsvaMAoRjHrw093NxvhmklN+shDDBYQUK5QwYI6bnH97tegrIEAjszSsONqk5g==
X-Received: by 2002:a17:90a:ad89:: with SMTP id s9mr38412611pjq.41.1563296679007;
        Tue, 16 Jul 2019 10:04:39 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id a128sm18361689pfb.185.2019.07.16.10.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 10:04:37 -0700 (PDT)
Subject: Re: io_uring question
To:     Filipp Mikoian <Filipp.Mikoian@acronis.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Cc:     "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
References: <76524892f9c048ea88c7d87295ec85ae@acronis.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92e17024-55ca-069d-3aae-56bd0b2e96f6@kernel.dk>
Date:   Tue, 16 Jul 2019 11:04:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <76524892f9c048ea88c7d87295ec85ae@acronis.com>
Content-Type: multipart/mixed;
 boundary="------------8BBD4C2D54EB7ED6320A967C"
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8BBD4C2D54EB7ED6320A967C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/19 5:21 AM, Filipp Mikoian wrote:
> Hi dear io_uring developers,
> 
> Recently I started playing with io_uring, and the main difference I expected
> to see with old AIO(io_submit(), etc.) was submission syscall(io_uring_enter())
> not blocking in case submission might take long time, e.g. if waiting for a slot
> in block device request queue is required. AFAIU, 'workers' machinery is used
> solely to be able to submit requests in async context, thus not forcing calling
> thread to block for a significant time. At worst EAGAIN is expected.
> 
> However, when I installed fresh 5.2.0-rc7 kernel on the machine with HDD with
> 64-requests-deep queue, I noticed significant increase in time spent in
> io_uring_enter() once request queue became full. Below you can find output
> of the program that submits random(in 1GB range) 4K read requests in batches
> of 32. Though O_DIRECT is used, the same phenomenon is observed when using
> page cache. Source code can be found here:
> https://github.com/Phikimon/io_uring_question
> 
> While analyzing stack dump, I found out that IOCB_NOWAIT flag being set
> does not prevent generic_file_read_iter() from calling blkdev_direct_IO(),
> so thread gets stuck for hundreds of milliseconds. However, I am not a
> Linux kernel expert, so I can not be sure this is actually related to the
> mentioned issue.
> 
> Is it actually expected that io_uring would sleep in case there is no slot
> in block device's request queue, or is this a bug of current implementation?
> 
> root@localhost:~/io_uring# uname -msr
> Linux 5.2.0-rc7 x86_64
> root@localhost:~/io_uring# hdparm -I /dev/sda | grep Model
> Model Number:       Hitachi HTS541075A9E680
> root@localhost:~/io_uring# cat /sys/block/sda/queue/nr_requests
> 64
> root@localhost:~/io_uring# ./io_uring_read_blkdev /dev/sda8
> submitted_already =   0, submitted_now =  32, submit_time =     246 us
> submitted_already =  32, submitted_now =  32, submit_time =     130 us
> submitted_already =  64, submitted_now =  32, submit_time =  189548 us
> submitted_already =  96, submitted_now =  32, submit_time =  121542 us
> submitted_already = 128, submitted_now =  32, submit_time =  128314 us
> submitted_already = 160, submitted_now =  32, submit_time =  136345 us
> submitted_already = 192, submitted_now =  32, submit_time =  162320 us
> root@localhost:~/io_uring# cat pstack_output # This is where process slept
> [<0>] io_schedule+0x16/0x40
> [<0>] blk_mq_get_tag+0x166/0x280
> [<0>] blk_mq_get_request+0xde/0x380
> [<0>] blk_mq_make_request+0x11e/0x5b0
> [<0>] generic_make_request+0x191/0x3c0
> [<0>] submit_bio+0x75/0x140
> [<0>] blkdev_direct_IO+0x3f8/0x4a0
> [<0>] generic_file_read_iter+0xbf/0xdc0
> [<0>] blkdev_read_iter+0x37/0x40
> [<0>] io_read+0xf6/0x180
> [<0>] __io_submit_sqe+0x1cd/0x6a0
> [<0>] io_submit_sqe+0xea/0x4b0
> [<0>] io_ring_submit+0x86/0x120
> [<0>] __x64_sys_io_uring_enter+0x241/0x2d0
> [<0>] do_syscall_64+0x60/0x1a0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [<0>] 0xffffffffffffffff

Sorry for originally missing this one! For this particular issue, it
looks like you are right, we don't honor NOWAIT for request allocation.
That's a bug, pondering how best to fix this. Can you try the attached
patch and see if it fixes it for you?

> 1. Inaccurate handling of errors in liburing/__io_uring_submit().
> Because liburing currently does not care about queue head that kernel
> sets, it cannot know how many entries have been actually consumed. In
> case e.g.  io_uring_enter() returns EAGAIN, and consumes none of the
> sqes, sq->sqe_head still advances in __io_uring_submit(), this can
> eventually cause both io_uring_submit() and io_uring_sqe() return 0
> forever.

I'll look into that one.

> 2. There is also a related issue -- when using IORING_SETUP_SQPOLL, in
> case polling kernel thread already went to sleep(IORING_SQ_NEED_WAKEUP
> is set), io_uring_enter() just wakes it up and immediately reports all
> @to_submit requests are consumed, while this is not true until awaken
> thread will manage to handle them. At least this contradicts with man
> page, which states:
>     > When the system call returns that a certain amount of SQEs have
>     > been consumed and submitted, it's safe to reuse SQE entries in
>     > the ring.
>     It is easy to reproduce this bug -- just change e.g. ->offset
>     field in the SQE immediately after io_uring_enter() successfully
>     returns and you will see that IO happened on new offset.

Not sure how best to convery that bit of information. If you're using
the sq thread for submission, then we cannot reliably tell the
application when an sqe has been consumed. The application must look for
completions (successful or errors) in the CQ ring.

> 3. Again due to lack of synchronization between io_sq_thread() and
> io_uring_enter(), in case the ring is full and IORING_SETUP_SQPOLL is
> used, it seems there is no other way for application to wait for slots
> in SQ to become available but busy waiting for *sq->khead to advance.
> Thus from one busy waiting thread we get two. Is this the expected
> behavior? Should the user of IORING_SETUP_SQPOLL busy wait for slots
> in SQ?

You could wait on cq ring completions, each sqe should trigger one.

> 4. Minor one: in case sq_thread_idle is set to ridiculously big
> value(e.g. 100 sec), kernel watchdog starts reporting this as a bug.
>     > Message from syslogd@centos-linux at Jun 21 20:00:04 ...
>     > kernel:watchdog: BUG: soft lockup - CPU#0 stuck for 21s!
>     > [io_uring-sq:10691]

Ah yes, cosmetic issue, I'll address that one as well.

-- 
Jens Axboe


--------------8BBD4C2D54EB7ED6320A967C
Content-Type: text/x-patch;
 name="io_uring-direct-nowait.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="io_uring-direct-nowait.patch"

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec680e84..81409162e662 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1959,10 +1959,14 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	data.cmd_flags = bio->bi_opf;
 	rq = blk_mq_get_request(q, bio, &data);
 	if (unlikely(!rq)) {
+		blk_qc_t ret = BLK_QC_T_NONE;
+
 		rq_qos_cleanup(q, bio);
-		if (bio->bi_opf & REQ_NOWAIT)
+		if (bio->bi_opf & REQ_NOWAIT_RET)
+			ret = BLK_QC_T_EAGAIN;
+		else if (bio->bi_opf & REQ_NOWAIT)
 			bio_wouldblock_error(bio);
-		return BLK_QC_T_NONE;
+		return ret;
 	}
 
 	trace_block_getrq(q, bio, bio->bi_opf);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index f00b569a9f89..6a09f483f15c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -344,15 +344,24 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	struct bio *bio;
 	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
+	bool nowait = (iocb->ki_flags & IOCB_NOWAIT) != 0;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
+	gfp_t gfp;
 	int ret = 0;
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
+	if (nowait)
+		gfp = GFP_NOWAIT;
+	else
+		gfp = GFP_KERNEL;
+
+	bio = bio_alloc_bioset(gfp, nr_pages, &blkdev_dio_pool);
+	if (!bio)
+		return -EAGAIN;
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->is_sync = is_sync = is_sync_kiocb(iocb);
@@ -397,6 +406,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			bio->bi_opf = dio_bio_write_op(iocb);
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
+		if (nowait)
+			bio->bi_opf |= (REQ_NOWAIT | REQ_NOWAIT_RET);
 
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
@@ -411,6 +422,10 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			}
 
 			qc = submit_bio(bio);
+			if (qc == BLK_QC_T_EAGAIN) {
+				ret = -EAGAIN;
+				goto err;
+			}
 
 			if (polled)
 				WRITE_ONCE(iocb->ki_cookie, qc);
@@ -431,7 +446,12 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			atomic_inc(&dio->ref);
 		}
 
-		submit_bio(bio);
+		qc = submit_bio(bio);
+		if (qc == BLK_QC_T_EAGAIN) {
+			ret = -EAGAIN;
+			goto err;
+		}
+
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
@@ -452,6 +472,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	}
 	__set_current_state(TASK_RUNNING);
 
+out:
 	if (!ret)
 		ret = blk_status_to_errno(dio->bio.bi_status);
 	if (likely(!ret))
@@ -459,6 +480,10 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 	bio_put(&dio->bio);
 	return ret;
+err:
+	if (!is_poll)
+		blk_finish_plug(&plug);
+	goto out;
 }
 
 static ssize_t
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index feff3fe4467e..3d89a3c04977 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -311,6 +311,7 @@ enum req_flag_bits {
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
 	__REQ_NOWAIT,           /* Don't wait if request will block */
+	__REQ_NOWAIT_RET,	/* Return would-block error inline */
 	/*
 	 * When a shared kthread needs to issue a bio for a cgroup, doing
 	 * so synchronously can lead to priority inversions as the kthread
@@ -345,6 +346,7 @@ enum req_flag_bits {
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
+#define REQ_NOWAIT_RET		(1ULL << __REQ_NOWAIT_RET)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
@@ -418,6 +420,7 @@ static inline int op_stat_group(unsigned int op)
 
 typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE		-1U
+#define BLK_QC_T_EAGAIN		-2U
 #define BLK_QC_T_SHIFT		16
 #define BLK_QC_T_INTERNAL	(1U << 31)
 

--------------8BBD4C2D54EB7ED6320A967C--
