Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF327AEEB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 16:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjIZOFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjIZOFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:05:52 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54811D;
        Tue, 26 Sep 2023 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1695737140;
        bh=MJNUG6riqeXQx3T/lMM/Fo45o2kqZs4yb89ZYBEfbas=;
        h=From:To:Cc:Subject:Date;
        b=GovrFxyy0wuq6Ew9gX4aCYvFNViEqhk00T4PyyOxJiDZD/h1k8TabzlqTrmaIt2Hy
         slbeS+zwjQM9EAmS4jeb2c0CTk35yeXoeograhRo29hjOqfaZ1gfFbCrnm80GeAMRS
         PMPZIFiotHfue4b9otXtwvbj7GL3jlYh2fFoA08Y=
Received: from localhost.localdomain ([240e:430:2a38:9767:edcf:1da7:3272:2365])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id 14F3DC20; Tue, 26 Sep 2023 22:05:15 +0800
X-QQ-mid: xmsmtpt1695737115tmvj1up9w
Message-ID: <tencent_6E80209FC9C7F45EE61E3FB3E7952A226A07@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No0CqKXLwXs4YHFu0QR49iH5WMyF5VPiUbpXz5k2LyrVJN/3kk/J
         7LnMlyv5RlTucucJBJyE99cfZ/sjhyIdi/ysY3FM9bRmPhYyRS1c94ySS8fc1Yc5n3ErtZb2Fopi
         lck2B5X2YsQeW1Wvoqt+iNMkXS78h+R2PbNcY4kTxnA4BJDza8t3uNXwrSoDWv4qtBQl+mLRCD/6
         Q4gaZjaWHKkBVcfSXyH8HdtNcctH3bJoNTrkMAfiy7w90GjJnP60VeX+EK/5uEPUOr9/6XJKcX2F
         S8xvH59065+koZOuTPJ4QFWo+1M4bc0Lo5r8HLKurVC2U2kmHK+VH7mE9MmICAqW+qidVjmjJUaR
         Geg+sM4ccIQRcWzcwvR0fSFlQFOU1IvPBeT9+RfwtZ4rFc3JptbmKIlhvq9VG1yh2XakTbMuv9b9
         vRxYrN5o3BpRzWQa16crSNI5JmT4OB/D1bkAYeQXSLoiEm3lqD04q9aavbOzfLnPD7UwfYh6ZBE0
         Vfl61dUJSX3bheAE/0hUMiVMWQZOwwuqj6ALx3e5twfIgbgmxKa0epOG3ZxMI1azrPHgDgI2b1uO
         YSS1uwEsjvRGHkuO48U2el7g15FnBSyS5VmR3mj6bdqBvdoj/LiTK74h/7Q1EHDMLdeJeYVI7mNL
         CMv8cUD9i74aG/J9GK2WJKP1N1HGGt7vBzer0BhjF5SnC9FgfyGtdQsNGGoDt3awD4qJFlAYpL8R
         3IhLV80b6xUSOVvnj7GXAvVS47rQdNHwgUgJUFfd/6HlieyWWwkVIlFu2GVk+ucE2q0qdQ/hlUrH
         YSkPYnAWShjQ/CxgqE3LW4+vrAXwSOupwACLP4V+WdGHXeA/J3nc7LCeMnK79ptIZxR8+BzDt5/O
         PxRjNIJ5j+NjJJKpltErCMK7sZWD0VUKfDF/gpm8YTawKJpJJPfDi17oT/LmrbZ6s3elUQPyVGTv
         Jvu128cq5oZQvTzMKgpf5yiiT9iwsZGyXulIJ7YgV03Ocdo18iAIPKPwD2hFgAMWNkWHDq5zRZ+F
         WEfbDpkehaqgBHcfEG
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Subject: [PATCH] eventfd: move 'eventfd-count' printing out of spinlock
Date:   Tue, 26 Sep 2023 22:05:00 +0800
X-OQ-MSGID: <20230926140500.4944-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

It is better to print debug messages outside of the wqh.lock
spinlock where possible.

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
 fs/eventfd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 33a918f9566c..6c5fe0f40aa5 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -295,11 +295,13 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct eventfd_ctx *ctx = f->private_data;
+	unsigned long long count;
 
 	spin_lock_irq(&ctx->wqh.lock);
-	seq_printf(m, "eventfd-count: %16llx\n",
-		   (unsigned long long)ctx->count);
+	count = ctx->count;
 	spin_unlock_irq(&ctx->wqh.lock);
+
+	seq_printf(m, "eventfd-count: %16llx\n", count);
 	seq_printf(m, "eventfd-id: %d\n", ctx->id);
 	seq_printf(m, "eventfd-semaphore: %d\n",
 		   !!(ctx->flags & EFD_SEMAPHORE));
-- 
2.25.1

