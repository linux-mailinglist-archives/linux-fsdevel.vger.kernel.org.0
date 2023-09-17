Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96F67A3664
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbjIQPge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbjIQPgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:36:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9827A1B0;
        Sun, 17 Sep 2023 08:36:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6E91C433C8;
        Sun, 17 Sep 2023 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694964968;
        bh=tGnGlLxOw3O9Q2xKZYub2Abe8FhmTfUM3qmTqGuuWMQ=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=faG+7EHCzOomMsGXPBoymcntLOkZ1J7hfs947RAAJ7fO/BskAa/etpG0DFYP2b7Y0
         UBjJ9HHCiGQ1RSMVwQG401jTbJr9sZxRRp8LI7V55n4lLcVK1OY81gmhslfg4kCAF6
         y+mFnmd9+krWDEN2KeTuL43KnR7w0iFzV9EMPMbUTZk8OHDB4Nu2GBJFG6+51N/Hqp
         6FhjCBTGvWSZXOFBO4tMEX1E8Jt2RY8J5Ro8pfcmQl42+Y//7dLOWpbINlws2CsBXF
         4ob6F1AlnQIn/JU7gb3Uji5Ui0IKJdPWCXCCLWARBF9cZYm5x8Vs4duaRRUPVghKNF
         Xuo6J1sHiaslg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C2551CD37B4;
        Sun, 17 Sep 2023 15:36:08 +0000 (UTC)
From:   Jianguo Bao via B4 Relay <devnull+roidinev.gmail.com@kernel.org>
Date:   Sun, 17 Sep 2023 23:35:20 +0800
Subject: [PATCH v2] mm/writeback: Update filemap_dirty_folio() comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230917-trycontrib1-v2-1-66ae0ce8f7c3@gmail.com>
X-B4-Tracking: v=1; b=H4sIALccB2UC/23MSwrDIBSF4a2EO67FR2i0o+6jZBCNJhcaLSrSE
 Nx7bcYd/gfOd0CyEW2Ce3dAtAUTBt+CXzow6+QXS3BuDZxyQRUbSI67CT5H1IwYLZ2TPR1Ub6A
 93tE6/Jzac2y9Ysoh7ide2G/97xRGGJk15zdBtZRCPZZtwtfVhA3GWusXa+9gg6YAAAA=
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jianguo Bao <roidinev@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694964922; l=1148;
 i=roidinev@gmail.com; s=20230906; h=from:subject:message-id;
 bh=kvb09bksQ5sDwvuV+cJThLuKQhUb8lsRZC/HV07PBuA=;
 b=pT3oC5Q0lddFp2DM/hBD+Fq9TCIcs3SzJbQFAfGaMlUBjHTsRg9GZIcMdfhc8li3B5CQpTro4
 2R2UWQTOF6zAb78eiB8QQHFdw3Lq1xUrhUcHYxnvIzzKlC8kIBo99Ky
X-Developer-Key: i=roidinev@gmail.com; a=ed25519;
 pk=Itb2tVLere2RkCXs1smCQpxuXvWY0XesWo353ZMHfxs=
X-Endpoint-Received: by B4 Relay for roidinev@gmail.com/20230906 with auth_id=82
X-Original-From: Jianguo Bao <roidinev@gmail.com>
Reply-To: <roidinev@gmail.com>
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jianguo Bao <roidinev@gmail.com>

Change to use new address space operation dirty_folio

Signed-off-by: Jianguo Bao <roidinev@gmail.com>
---
Changes in v2:
- #1: Update author name.
- Link to v1: https://lore.kernel.org/r/20230917-trycontrib1-v1-1-db22630b8839@gmail.com
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b8d3d7040a50..001adbb4a180 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2679,7 +2679,7 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
  * @folio: Folio to be marked as dirty.
  *
  * Filesystems which do not use buffer heads should call this function
- * from their set_page_dirty address space operation.  It ignores the
+ * from their dirty_folio address space operation.  It ignores the
  * contents of folio_get_private(), so if the filesystem marks individual
  * blocks as dirty, the filesystem should handle that itself.
  *

---
base-commit: f0b0d403eabbe135d8dbb40ad5e41018947d336c
change-id: 20230917-trycontrib1-cb8ff840794c

Best regards,
-- 
Jianguo Bao <roidinev@gmail.com>

