Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B552152FAEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 May 2022 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353989AbiEULM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 May 2022 07:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243920AbiEULMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:15 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05272E9F7;
        Sat, 21 May 2022 04:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZXvAiOORZJk+2KUX1I0y/bK94Dd0mtx55RA5nLehi6Y=;
  b=d5SlB1CMG3rFu+TRx3LRbslPbyGsXY+vCdqN9Xw+RNyTDuI0/elEifxF
   FWyfb684wL9vIdBbqlBsoqwKGnA0AlcnAlk3HLKCzlUqJzyyu/O7cJRLD
   31h2WRyaftNriGxA+tVO+Q6WMZXYvMK6d9MIhiHpo76t8r4rR6FJu+mse
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727927"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:57 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] writeback: fix typo in comment
Date:   Sat, 21 May 2022 13:10:42 +0200
Message-Id: <20220521111145.81697-32-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 fs/fs-writeback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a1074a26e784..a21d8f1a56d1 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -738,7 +738,7 @@ EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);
  * incorrectly attributed).
  *
  * To resolve this issue, cgroup writeback detects the majority dirtier of
- * an inode and transfers the ownership to it.  To avoid unnnecessary
+ * an inode and transfers the ownership to it.  To avoid unnecessary
  * oscillation, the detection mechanism keeps track of history and gives
  * out the switch verdict only if the foreign usage pattern is stable over
  * a certain amount of time and/or writeback attempts.

