Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372602648C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbgIJPaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 11:30:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731306AbgIJP3y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:29:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A467AF45;
        Thu, 10 Sep 2020 15:30:09 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     darrick.wong@oracle.com
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] iomap: Don't opencode SECTOR_SIZE macro
Date:   Thu, 10 Sep 2020 18:29:49 +0300
Message-Id: <20200910152949.3227-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 31eb680d8c64..4c688682236f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -29,7 +29,7 @@ struct iomap_page {
 	atomic_t		read_count;
 	atomic_t		write_count;
 	spinlock_t		uptodate_lock;
-	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
+	DECLARE_BITMAP(uptodate, PAGE_SIZE / SECTOR_SIZE);
 };
 
 static inline struct iomap_page *to_iomap_page(struct page *page)
-- 
2.17.1

