Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7C7B1BF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 14:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjI1MRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 08:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjI1MRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:17:23 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB5819E
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 05:17:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:e207:8adb:af22:7f1e])
        by andre.telenet-ops.be with bizsmtp
        id rQHK2A00S3w8i7m01QHKuZ; Thu, 28 Sep 2023 14:17:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qlpwt-004mRT-3u;
        Thu, 28 Sep 2023 14:17:19 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qlpxH-001OBp-IL;
        Thu, 28 Sep 2023 14:17:19 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iomap: Spelling s/preceeding/preceding/g
Date:   Thu, 28 Sep 2023 14:17:18 +0200
Message-Id: <46f1ca7817b5febb90c0f1f9881a1c2397b827d0.1695903391.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a misspelling of "preceding".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 644479ccefbd0f18..5db54ca29a35acf3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1049,7 +1049,7 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 
 /*
  * Scan the data range passed to us for dirty page cache folios. If we find a
- * dirty folio, punch out the preceeding range and update the offset from which
+ * dirty folio, punch out the preceding range and update the offset from which
  * the next punch will start from.
  *
  * We can punch out storage reservations under clean pages because they either
-- 
2.34.1

