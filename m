Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B477B569D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 17:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbjJBP0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbjJBP0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:26:47 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0726A9;
        Mon,  2 Oct 2023 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1696260400;
        bh=HdkrU/Yo/BYxGx0eytoTbyvF4iLbWStQw9vUbY4Xghw=;
        h=From:To:Cc:Subject:Date;
        b=GlL6mRpT7MmdmgVq6Okdz9omjEHFLagjUFK+XPAMD3z3ThAkg05O2C0x294TZv0GK
         q1zkahtYhsvsARkWo2CV2L3Adl6h9sfIFch4qYmdXERaGq7Kwt4SJRzKrO2wlG6QHQ
         ZFBeRMvOmWp1eg5wC+3+zXNOvkplIttPeKfPEwFY=
Received: from localhost.localdomain ([240e:430:cc3:362a:ac65:29f0:b0a3:8952])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 3461804C; Mon, 02 Oct 2023 23:13:06 +0800
X-QQ-mid: xmsmtpt1696259586tyiyz6z58
Message-ID: <tencent_4967A8AA14EACCA0BB4999F40066023FDC07@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8Sp/0JIoR+MNVp8+Al7LIJ32QzPYxksm4iZY6SrbD8I3UP+jWDo
         dc5rza/PqCWE9YsaIUxHXpJcMXIb8PIoVm4AR5B52mSrPIeqPrFLP5guk51ZhwjciWG3vn35YfJ6
         HKCFVwNoGlfqKUXiX2lE362npwG+13Y7FddiWu9Ysj4+x55MWhkTM6FzGXYhdWCKqwBvwm2QOAlu
         2M74jFUlMp55Y1k88/2T7EaN9DzHkyR7HvJkDwre4SYv8ZX78rkhqBdNTXTy47gRB5bVDP2UBrhy
         30rAAj2VbQXx0/F9iRacbQXwNN5keMi50LMGOb+r65EMCKUtgdsevMzskwGkgm0oVcfSmTPL91ij
         2t/M9kX3600/LSBCcBFhYtv2WhZqGdtZ2XY8+A5F6aZ7U8nQomDnuXPvsySrw9xMzkCy02wkpNDP
         UA7ptxdHWhNe62F4Bj1io/2i+AzLvQJDcO6jn3jT2kn7+g3o3Wi2GGcIi1S+rh0Xk2aSam6KsHQg
         2v/OsbES4m1JMqYEccChNHtWJygyIxg0HyqOqcjB86MYuoqhnl2VuDYojbNv8v6h+R46IwUUZjCX
         ZRe3u8pbgtN9ZN5MJldiGDDbMuVkpA69VP1ujEiJw0Qh0YUNmKmDn7RzHOaiJAqkKWLkQe6XO6in
         NlMD4Kt77gcZE0lkxtc8nPoYSNJJo1kHNuIm22GvfM1Ub4s31cGlLEQG5XDqKK1pz9ar1tAHBDze
         LwmMpYuYnHSoKXEaraS75PyUdtcdNeBaClB5HyJsvnNnkH41v3tNsEehQkG2MxtWNlSI7ichMjbo
         48YUg7+Kf8X1avWk/0clWbAjwoiMClwJxvewBixdEO/3UFozOLTIm1wTCX2cBHuItMGmRAnR0/nv
         R1hBJkgnCDiPhfLTeccrDGnpDZ7dhpBczKB66Io0urP4w/bjIwLpTuSoPqA8V2gEfqXq+cpt7SSo
         6m6cKAZMrAkxQUbHhDP2boBj+DvVPhiiqYY3hZyrtLP4u+pG5J0i2QcAj/fA/gMTSNi3l2vzMV8j
         zH/6u+z4IHvEH3Bifp84EW0L/ByLsoj5B+z2uWbg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] eventfd: move 'eventfd-count' printing out of spinlock
Date:   Mon,  2 Oct 2023 23:13:02 +0800
X-OQ-MSGID: <20231002151302.3829-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

When printing eventfd->count, interrupts will be disabled and a spinlock
will be obtained, competing with eventfd_write().

In a single CPU container, one process frequently calls eventfd_write()
and another process frequently prints eventfd->count, as follows:

Tasks: 372 total,   3 running, 369 sleeping,   0 stopped,   0 zombie
%Cpu(s): 1.8 us, 4.5 sy, 0.0 ni, 92.5 id, 0.0 wa, 0.0 hi, 1.2 si, 0.0 st
MiB Mem :  13595.9 total,   4627.0 free,   2536.6 used,   6432.2 buff/cache
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.  10727.2 avail Mem

    PID USER  PR  NI    VIRT  RES  SHR S  %CPU  %MEM   TIME+ COMMAND    P
1893151 test  20   0    2364  896  896 R  49.2   0.0  6:03.49 a.out     3
1893080 test  20   0  244748 5376 4224 R  48.8   0.0  6:52.34 test_zmq  3

 # ./perf stat -e  'probe:eventfd_write' -I 10000
 #           time             counts unit events
    10.004950650            396,394      probe:eventfd_write
    20.015871354            396,403      probe:eventfd_write
    30.026916173            397,624      probe:eventfd_write
    40.037815761            396,363      probe:eventfd_write
    50.048964887            396,168      probe:eventfd_write
    60.059711824            396,656      probe:eventfd_write
    70.065021841            397,286      probe:eventfd_write
    80.072792225            397,476      probe:eventfd_write
    90.083883162            394,014      probe:eventfd_write

By moving the "eventfd-count" print out of the spinlock and merging
multiple seq_printf() into one, it could improve a bit.
After applying this patch, the competition has been slightly alleviated,
and eventfd_writ() has more opportunities to be executed, as follows:

 # ./perf stat -e  'probe:eventfd_write' -I 10000
 #           time             counts unit events
    10.010058911            397,550      probe:eventfd_write
    20.021065452            397,771      probe:eventfd_write
    30.032054749            397,509      probe:eventfd_write
    40.034853809            397,605      probe:eventfd_write
    50.045754449            396,926      probe:eventfd_write
    60.056373938            396,867      probe:eventfd_write
    70.067280837            397,542      probe:eventfd_write
    80.078232498            397,011      probe:eventfd_write
    90.089215771            397,311      probe:eventfd_write

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Eric Biggers <ebiggers@google.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 8aa36cd37351..3b893f21923d 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -295,13 +295,18 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct eventfd_ctx *ctx = f->private_data;
+	unsigned long long cnt;
 
 	spin_lock_irq(&ctx->wqh.lock);
-	seq_printf(m, "eventfd-count: %16llx\n",
-		   (unsigned long long)ctx->count);
+	cnt = ctx->count;
 	spin_unlock_irq(&ctx->wqh.lock);
-	seq_printf(m, "eventfd-id: %d\n", ctx->id);
-	seq_printf(m, "eventfd-semaphore: %d\n",
+
+	seq_printf(m,
+		   "eventfd-count: %16llx\n"
+		   "eventfd-id: %d\n"
+		   "eventfd-semaphore: %d\n",
+		   cnt,
+		   ctx->id,
 		   !!(ctx->flags & EFD_SEMAPHORE));
 }
 #endif
-- 
2.25.1

