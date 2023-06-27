Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540797401F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjF0RQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjF0RQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:16:07 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7521FEB
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 10:16:04 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34580e1b012so4018175ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687886164; x=1690478164;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6Xn8vKcrj0bObxfJm9W0wwe2E97tlGPc/PMXOkTFsQ=;
        b=IK3cFZZUcgZ8OZBr4ybgHaoGHMl2koSIVGWXiKAuOIjqZvvu/Qc8dikdA+BVo4OlXA
         H6LfWyh5GmL9s5CEL3Mqf7Oylpo2XHoodjU1Yq72ZnYVHXLgwTQdnVMp+jwjTMBoVY0g
         2XR1LC4JgWOrbG5wIVCn6/4p+ECUDAvxcsc0SUEhf2BqDnItPFTGX65ASrH3jMfHpZLG
         PNpHEdzqOkXVJ+E7xh8uVXZPvJ2g6m/Q/Pb3vtnb/T7BVfGYzwDprAN4Lzvh7FrRdKPj
         Z+vEgLt3JGQEreYjaWkTHL8eJqODz6vrBOmLz0Ln0h09/n/qeKcAmE0RdOU/bpVsTln/
         liqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687886164; x=1690478164;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6Xn8vKcrj0bObxfJm9W0wwe2E97tlGPc/PMXOkTFsQ=;
        b=cNpQdlUjvRBn3I8tNIXTbeDmESq0SJYTJW89WGAWiAzTxxepHzFqjAEkjyOZ9SOhOj
         SiwRa/tEwG3palEip5jK/2cmohAI8u2g5mi9EiVbvvmgfwq5cRFw7LOvJsuLBVGOVru2
         cX4rzWdLr5N5K0GmKHmpxeKVjORFpDPu0paMEGBTpeo5XR2wzrQrsE6bjIRfS5Gd+KJW
         FcaZ7swayKqu4mVjzZWrrcctZGd1QHc7DdLsi+P1Ycxtph/zkGU0O6GOy9JN4IoQtWqD
         +fl6SosKAmPr06Hk5ux7M4hANeTrzRmZNbJbmXC4QgBw6xUh3AtDpBzG9226izYy9Cd9
         2Hug==
X-Gm-Message-State: AC+VfDwllXmqmDuY11SW2tae600f/kgjcSIseB8faHQzAdvGg20btqsT
        H5iW8hk64doKTPRIVXLKI0ic24JGY0B4Tvb3rps=
X-Google-Smtp-Source: ACHHUZ7Cr4jSmh1hCsaz6iSiYUeaIbRMjFDGy9WLk83Dj0t+F6e9BntPDYjTwVL8zmcdwLs5qNH1ew==
X-Received: by 2002:a05:6602:1690:b0:780:c6bb:ad8d with SMTP id s16-20020a056602169000b00780c6bbad8dmr3863311iow.0.1687886163666;
        Tue, 27 Jun 2023 10:16:03 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c4-20020a5ea804000000b00763699c3d02sm2928567ioa.0.2023.06.27.10.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 10:16:02 -0700 (PDT)
Message-ID: <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
Date:   Tue, 27 Jun 2023 11:16:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
In-Reply-To: <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/26/23 8:59?PM, Jens Axboe wrote:
> On 6/26/23 8:05?PM, Kent Overstreet wrote:
>> On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
>>> Doesn't reproduce for me with XFS. The above ktest doesn't work for me
>>> either:
>>
>> It just popped for me on xfs, but it took half an hour or so of looping
>> vs. 30 seconds on bcachefs.
> 
> OK, I'll try and leave it running overnight and see if I can get it to
> trigger.

I did manage to reproduce it, and also managed to get bcachefs to run
the test. But I had to add:

diff --git a/check b/check
index 5f9f1a6bec88..6d74bd4933bd 100755
--- a/check
+++ b/check
@@ -283,7 +283,7 @@ while [ $# -gt 0 ]; do
 	case "$1" in
 	-\? | -h | --help) usage ;;
 
-	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
+	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs|-bcachefs)
 		FSTYP="${1:1}"
 		;;
 	-overlay)

to ktest/tests/xfstests/ and run it with -bcachefs, otherwise it kept
failing because it assumed it was XFS.

I suspected this was just a timing issue, and it looks like that's
exactly what it is. Looking at the test case, it'll randomly kill -9
fsstress, and if that happens while we have io_uring IO pending, then we
process completions inline (for a PF_EXITING current). This means they
get pushed to fallback work, which runs out of line. If we hit that case
AND the timing is such that it hasn't been processed yet, we'll still be
holding a file reference under the mount point and umount will -EBUSY
fail.

As far as I can tell, this can happen with aio as well, it's just harder
to hit. If the fput happens while the task is exiting, then fput will
end up being delayed through a workqueue as well. The test case assumes
that once it's reaped the exit of the killed task that all files are
released, which isn't necessarily true if they are done out-of-line.

For io_uring specifically, it may make sense to wait on the fallback
work. The below patch does this, and should fix the issue. But I'm not
fully convinced that this is really needed, as I do think this can
happen without io_uring as well. It just doesn't right now as the test
does buffered IO, and aio will be fully sync with buffered IO. That
means there's either no gap where aio will hit it without O_DIRECT, or
it's just small enough that it hasn't been hit.


diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3bca7a79efda..7abad5cb2131 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -150,7 +150,6 @@ static void io_clean_op(struct io_kiocb *req);
 static void io_queue_sqe(struct io_kiocb *req);
 static void io_move_task_work_from_local(struct io_ring_ctx *ctx);
 static void __io_submit_flush_completions(struct io_ring_ctx *ctx);
-static __cold void io_fallback_tw(struct io_uring_task *tctx);
 
 struct kmem_cache *req_cachep;
 
@@ -1248,6 +1247,49 @@ static inline struct llist_node *io_llist_cmpxchg(struct llist_head *head,
 	return cmpxchg(&head->first, old, new);
 }
 
+#define NR_FALLBACK_CTX	8
+
+static __cold void io_flush_fallback(struct io_ring_ctx **ctxs, int *nr_ctx)
+{
+	int i;
+
+	for (i = 0; i < *nr_ctx; i++) {
+		struct io_ring_ctx *ctx = ctxs[i];
+
+		flush_delayed_work(&ctx->fallback_work);
+		percpu_ref_put(&ctx->refs);
+	}
+	*nr_ctx = 0;
+}
+
+static __cold void io_flush_fallback_add(struct io_ring_ctx *ctx,
+					 struct io_ring_ctx **ctxs, int *nr_ctx)
+{
+	percpu_ref_get(&ctx->refs);
+	ctxs[(*nr_ctx)++] = ctx;
+	if (*nr_ctx == NR_FALLBACK_CTX)
+		io_flush_fallback(ctxs, nr_ctx);
+}
+
+static __cold void io_fallback_tw(struct io_uring_task *tctx, bool sync)
+{
+	struct llist_node *node = llist_del_all(&tctx->task_list);
+	struct io_ring_ctx *ctxs[NR_FALLBACK_CTX];
+	struct io_kiocb *req;
+	int nr_ctx = 0;
+
+	while (node) {
+		req = container_of(node, struct io_kiocb, io_task_work.node);
+		node = node->next;
+		if (sync)
+			io_flush_fallback_add(req->ctx, ctxs, &nr_ctx);
+		if (llist_add(&req->io_task_work.node,
+			      &req->ctx->fallback_llist))
+			schedule_delayed_work(&req->ctx->fallback_work, 1);
+	}
+	io_flush_fallback(ctxs, &nr_ctx);
+}
+
 void tctx_task_work(struct callback_head *cb)
 {
 	struct io_tw_state ts = {};
@@ -1260,7 +1302,7 @@ void tctx_task_work(struct callback_head *cb)
 	unsigned int count = 0;
 
 	if (unlikely(current->flags & PF_EXITING)) {
-		io_fallback_tw(tctx);
+		io_fallback_tw(tctx, true);
 		return;
 	}
 
@@ -1289,20 +1331,6 @@ void tctx_task_work(struct callback_head *cb)
 	trace_io_uring_task_work_run(tctx, count, loops);
 }
 
-static __cold void io_fallback_tw(struct io_uring_task *tctx)
-{
-	struct llist_node *node = llist_del_all(&tctx->task_list);
-	struct io_kiocb *req;
-
-	while (node) {
-		req = container_of(node, struct io_kiocb, io_task_work.node);
-		node = node->next;
-		if (llist_add(&req->io_task_work.node,
-			      &req->ctx->fallback_llist))
-			schedule_delayed_work(&req->ctx->fallback_work, 1);
-	}
-}
-
 static void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -1377,7 +1405,7 @@ void __io_req_task_work_add(struct io_kiocb *req, unsigned flags)
 	if (likely(!task_work_add(req->task, &tctx->task_work, ctx->notify_method)))
 		return;
 
-	io_fallback_tw(tctx);
+	io_fallback_tw(tctx, false);
 }
 
 static void __cold io_move_task_work_from_local(struct io_ring_ctx *ctx)

-- 
Jens Axboe

