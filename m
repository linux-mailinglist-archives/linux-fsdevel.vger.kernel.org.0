Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8E74508C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 21:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGBTjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 15:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjGBTje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACCCE74;
        Sun,  2 Jul 2023 12:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FFC360C96;
        Sun,  2 Jul 2023 19:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122BBC433C8;
        Sun,  2 Jul 2023 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326732;
        bh=PKQtxYx4+Ba5XFJRPObA7ff9l1XnKj9UzK3MQN1769w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i67u38WDLwqpghuHMO1ASqXPo6RJnZlJf36yIVRm8oZWIckl27VliXTK8Rhym3bPv
         gV4DQVUhfTevm/CQiLvfQc2+ETxdKKTOcgnlEg2ZIyodgaipMj7anCjSeb9dAAn1KZ
         +/lG50ydcWhhJeyCtS0mS87w3ygVOHxQ6ok67mIooVrFXLOv2f/52fBdtYZ+4K51Ue
         OHovYiikPKftl1FWb7HX5m8cz2FexNwwl8uTtmWe0jcsMJJk/ZRQcqv5OwzyZt1/jA
         cnrB8BTSNRpxpTDNJy5etd64qSYFpdiGIqx8/48oLilkQDHsYtyFJLTmbai/GqWtD4
         NISvpcHLImIFQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.4 14/16] eventfd: show the EFD_SEMAPHORE flag in fdinfo
Date:   Sun,  2 Jul 2023 15:38:13 -0400
Message-Id: <20230702193815.1775684-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

[ Upstream commit 33d8b5d7824c7175ed968b8e89e6db3566e9c177 ]

The EFD_SEMAPHORE flag should be displayed in fdinfo,
as different value could affect the behavior of eventfd.

Suggested-by: Christian Brauner <brauner@kernel.org>
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
Message-Id: <tencent_05B9CFEFE6B9BC2A9B3A27886A122A7D9205@qq.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventfd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 6c06a527747f2..8aa36cd373516 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -33,10 +33,10 @@ struct eventfd_ctx {
 	/*
 	 * Every time that a write(2) is performed on an eventfd, the
 	 * value of the __u64 being written is added to "count" and a
-	 * wakeup is performed on "wqh". A read(2) will return the "count"
-	 * value to userspace, and will reset "count" to zero. The kernel
-	 * side eventfd_signal() also, adds to the "count" counter and
-	 * issue a wakeup.
+	 * wakeup is performed on "wqh". If EFD_SEMAPHORE flag was not
+	 * specified, a read(2) will return the "count" value to userspace,
+	 * and will reset "count" to zero. The kernel side eventfd_signal()
+	 * also, adds to the "count" counter and issue a wakeup.
 	 */
 	__u64 count;
 	unsigned int flags;
@@ -301,6 +301,8 @@ static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 		   (unsigned long long)ctx->count);
 	spin_unlock_irq(&ctx->wqh.lock);
 	seq_printf(m, "eventfd-id: %d\n", ctx->id);
+	seq_printf(m, "eventfd-semaphore: %d\n",
+		   !!(ctx->flags & EFD_SEMAPHORE));
 }
 #endif
 
-- 
2.39.2

