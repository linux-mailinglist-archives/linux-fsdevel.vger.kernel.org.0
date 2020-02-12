Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBE615A00E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgBLEUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:20:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgBLESq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UEEB4xcwawu3PE2qZV8LQki9JonFO23BUNIp+IfEYZY=; b=huDOzVl6Bk4e98P/yVaPtrZR7/
        7+Vrye8M7d37D2jF4l2CgwYVJxrxcXfYnkcQ/YIZFzibgM0J5VTkhmbPRjBumtkEJXa06OAZv+scn
        DHfSfY1hs7FEwHbTLzMnsE99GjBNAV3xybDvtoVCyyQwtmEf1vPgO3FjzD6NySy4ctFemvkV5GOeq
        2SPtjcSXcgF7gxCqhVYLn05GIMQpmc7i2vpvnLiX4fVEq57nNW8dyWeEJ/ErT01ClUwhZ6WYC2QRw
        LPtzX/IN1v6HSlHJIxaY/nRlpATOVEWihWcsQY8nhjBREQyhwmiezDt/5ycSvWInIZLFJuEj8FMd8
        SWVmJRyg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006mp-M7; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/25] mm: Fix documentation of FGP flags
Date:   Tue, 11 Feb 2020 20:18:25 -0800
Message-Id: <20200212041845.25879-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We never had PCG flags; they've been called FGP flags since their
introduction in 2014.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 83ce9ce0bee1..3204293f9b58 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1577,12 +1577,12 @@ EXPORT_SYMBOL(find_lock_entry);
  * pagecache_get_page - find and get a page reference
  * @mapping: the address_space to search
  * @offset: the page index
- * @fgp_flags: PCG flags
+ * @fgp_flags: FGP flags
  * @gfp_mask: gfp mask to use for the page cache data page allocation
  *
  * Looks up the page cache slot at @mapping & @offset.
  *
- * PCG flags modify how the page is returned.
+ * FGP flags modify how the page is returned.
  *
  * @fgp_flags can be:
  *
-- 
2.25.0

