Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5D80665
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390938AbfHCNzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 09:55:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfHCNzH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 09:55:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D318E85546;
        Sat,  3 Aug 2019 13:55:06 +0000 (UTC)
Received: from max.com (unknown [10.40.205.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B783600D1;
        Sat,  3 Aug 2019 13:55:05 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] iomap: Fix trivial typo
Date:   Sat,  3 Aug 2019 15:55:02 +0200
Message-Id: <20190803135502.19572-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 03 Aug 2019 13:55:06 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ba0511131868..4ab1ec0a282f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1258,7 +1258,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
  * all bios have been submitted and the ioend is really done.
  *
  * If @error is non-zero, it means that we have a situation where some part of
- * the submission process has failed after we have marked paged for writeback
+ * the submission process has failed after we have marked pages for writeback
  * and unlocked them. In this situation, we need to fail the bio and ioend
  * rather than submit it to IO. This typically only happens on a filesystem
  * shutdown.
-- 
2.20.1

