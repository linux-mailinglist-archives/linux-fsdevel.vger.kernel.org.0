Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AA139D4E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 08:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFGGYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 02:24:45 -0400
Received: from m12-12.163.com ([220.181.12.12]:45456 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGGYp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Qrrb1
        rsPUF0AKmUKmPEmEGlMM3yy0iINcnL1U/Z5Su8=; b=YkFT7L1vlLQo7lyv7Q5PV
        vUvYoBQSqgLpJXxbeXKipbZnAdhXOv2XS+jHqsM0FeT2QUBLBjcK3AqCIJdxKQn5
        b76xzq5bbKu0+YS7qDQZDDBA+pC6oz0xVdG/0wVRzfZ1z0o/D2C4AKkI2cOxdK5z
        WsYsEguPpJoiUqW/n7OOd0=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowABHT6P9ur1gmagdIg--.2995S2;
        Mon, 07 Jun 2021 14:21:51 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: [PATCH] fs: aio: Fix a typo
Date:   Mon,  7 Jun 2021 14:20:49 +0800
Message-Id: <20210607062049.189901-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowABHT6P9ur1gmagdIg--.2995S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruryrKrW8Jr13Xw43KF47twb_yoW8JF1UpF
        4qk3WFkFWrCr12v3Wftryj9FySk39Y9FsFqaykAw1DArs5Xr1ruF4UtayDWFykWryxAFW3
        Za9Fqas8tw1kZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jl38nUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiSh+qUFPAOmbpDQAAsE
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'submited' to 'submitted', and
change 'peformance' to 'performance'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index e499cbcef117..2ddcabcaa370 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -850,7 +850,7 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 
 /*
  * exit_aio: called when the last user of mm goes away.  At this point, there is
- * no way for any new requests to be submited or any of the io_* syscalls to be
+ * no way for any new requests to be submitted or any of the io_* syscalls to be
  * called on the context.
  *
  * There may be outstanding kiocbs, but free_ioctx() will explicitly wait on
@@ -1181,7 +1181,7 @@ static long aio_read_events_ring(struct kioctx *ctx,
 	 * The mutex can block and wake us up and that will cause
 	 * wait_event_interruptible_hrtimeout() to schedule without sleeping
 	 * and repeat. This should be rare enough that it doesn't cause
-	 * peformance issues. See the comment in read_events() for more detail.
+	 * performance issues. See the comment in read_events() for more detail.
 	 */
 	sched_annotate_sleep();
 	mutex_lock(&ctx->ring_lock);
-- 
2.25.1


