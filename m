Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13D720D7CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgF2Tcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbgF2Tcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:45 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AAEC031408
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oxs4z7Z79Co1vJxi157TWwSOkUasU+//trUBVUDxZkM=; b=HKltuita8+l7k0bQRtgFFH+toD
        D7fXyqyUnOnObLeoLbQbA2O39DGmNDHVM9B9dzVc9vKllt9x/rNmDLOp0jTztpKk63B4hIwhzu8/y
        qJArKaHYD64incweeiOJuwLHzsJfZ0ZGDbPDOlba3cb5eoXBgiTQzC741M3JbRU6AWZ8oHHh0USx+
        /1ToDMNn9ysYxl8XPW3uolbHBJ9dBv4skaZIH6ziXkU4XTkTuYXjHR4Xtm20DIMrYxFDcM2u6+FIa
        9NEpO94W5S2d2cTTaKW/bu/Yvf3LKK/9N4N3xykzSGsyhbZRS7sILCNsaVFtnuQSY2RIb7JFik+uv
        nmQJyUpA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpxFT-0002Yy-Ur; Mon, 29 Jun 2020 17:07:16 +0000
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ntfs: remove extraneous semicolons
Message-ID: <ff7e2edd-e30b-2d61-c6fa-87cd06dcf231@infradead.org>
Date:   Mon, 29 Jun 2020 10:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Coccinelle scripts report:

fs/ntfs/lcnalloc.c:902:2-3: Unneeded semicolon
fs/ntfs/super.c:1615:2-3: Unneeded semicolon
fs/ntfs/super.c:1684:2-3: Unneeded semicolon

so remove the extraneous semicolons.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
---
 fs/ntfs/lcnalloc.c |    2 +-
 fs/ntfs/super.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200629.orig/fs/ntfs/lcnalloc.c
+++ linux-next-20200629/fs/ntfs/lcnalloc.c
@@ -899,7 +899,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni,
 		}
 		/* We have freed @to_free real clusters. */
 		real_freed = to_free;
-	};
+	}
 	/* Go to the next run and adjust the number of clusters left to free. */
 	++rl;
 	if (count >= 0)
--- linux-next-20200629.orig/fs/ntfs/super.c
+++ linux-next-20200629/fs/ntfs/super.c
@@ -1612,7 +1612,7 @@ read_partial_attrdef_page:
 		memcpy((u8*)vol->attrdef + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
@@ -1681,7 +1681,7 @@ read_partial_upcase_page:
 		memcpy((char*)vol->upcase + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)

