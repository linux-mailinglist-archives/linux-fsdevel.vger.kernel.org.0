Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A998979115A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 08:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352346AbjIDGau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 02:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbjIDGar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:30:47 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3594F4;
        Sun,  3 Sep 2023 23:30:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RfJff3YD5z4f3jM0;
        Mon,  4 Sep 2023 14:30:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDnFDGLefVkRQ7ICA--.14846S4;
        Mon, 04 Sep 2023 14:30:38 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 2/3] fuse: remove usage of FR_WATING flag
Date:   Mon,  4 Sep 2023 22:30:17 +0800
Message-Id: <20230904143018.5709-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230904143018.5709-1-shikemeng@huaweicloud.com>
References: <20230904143018.5709-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnFDGLefVkRQ7ICA--.14846S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7XryDJrWDAw4xKw47twb_yoW8Kw1kpF
        WxCa1jyFW7Xr4UW34fW34xZw1aq3yfAF93KryrGasIvFs8trZIkFn5KFyUWF17Zr4xXrsI
        g390grs7Zw1Yq37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRsXo7UUUUU
        =
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Each allocated request from fuse_request_alloc counts to num_waiting
before request is freed.
Simply drop num_waiting without FR_WAITING flag check in fuse_put_request
to remove unneeded usage of FR_WAITING flag.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fuse/dev.c    | 9 +--------
 fs/fuse/fuse_i.h | 2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 59e1357d4880..4f49b1946635 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -139,7 +139,6 @@ static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
 	req->in.h.gid = from_kgid(fc->user_ns, current_fsgid());
 	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
 
-	__set_bit(FR_WAITING, &req->flags);
 	if (for_background)
 		__set_bit(FR_BACKGROUND, &req->flags);
 
@@ -171,11 +170,7 @@ static void fuse_put_request(struct fuse_req *req)
 			spin_unlock(&fc->bg_lock);
 		}
 
-		if (test_bit(FR_WAITING, &req->flags)) {
-			__clear_bit(FR_WAITING, &req->flags);
-			fuse_drop_waiting(fc);
-		}
-
+		fuse_drop_waiting(fc);
 		fuse_request_free(req);
 	}
 }
@@ -495,7 +490,6 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 		if (!args->nocreds)
 			fuse_force_creds(req);
 
-		__set_bit(FR_WAITING, &req->flags);
 		__set_bit(FR_FORCE, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
@@ -556,7 +550,6 @@ int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 		if (!req)
 			return -ENOMEM;
 		atomic_inc(&fc->num_waiting);
-		__set_bit(FR_WAITING, &req->flags);
 		__set_bit(FR_BACKGROUND, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..45da5553bae3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -307,7 +307,6 @@ struct fuse_io_priv {
  * FR_ISREPLY:		set if the request has reply
  * FR_FORCE:		force sending of the request even if interrupted
  * FR_BACKGROUND:	request is sent in the background
- * FR_WAITING:		request is counted as "waiting"
  * FR_ABORTED:		the request was aborted
  * FR_INTERRUPTED:	the request has been interrupted
  * FR_LOCKED:		data is being copied to/from the request
@@ -321,7 +320,6 @@ enum fuse_req_flag {
 	FR_ISREPLY,
 	FR_FORCE,
 	FR_BACKGROUND,
-	FR_WAITING,
 	FR_ABORTED,
 	FR_INTERRUPTED,
 	FR_LOCKED,
-- 
2.30.0

