Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42EB5151F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379574AbiD2RaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379536AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989CEA27FA
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZNKJWFDCUWil8jx/xHZmnIEY4w4yDlyboSDNkzjtICU=; b=Ph992qZNAl0F6XMJcn6N2/BBcY
        VdH9rl/eDs2xVZys8GqVgXe0P+Nz9+xkduDldVfs80sLR+M0oEoF4Ov2JPts4qot7NIUyMI9+n98U
        1/3pOwvi02aEED+HADweMbRyE2dsi9A5BdBWdCxzSRD73e9XyQRg4ttvT6xyH31WRpcixPG4rB+4t
        64kj+BTWSbxObvJvykTiEpfzVdOaWSgEF7ljGP7AP6rSUVX5O6dtocyOIy18ArGKqHj130xNZbGfG
        zU70QI+sa/4Pw8isrY+zawox6VishHklgcI4ZZq8im+C9J5O+Jpfg2dwGM8D63vqcG24qbIbSC7tB
        eGKg/fZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNZ-00CdZC-D7; Fri, 29 Apr 2022 17:26:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 26/69] filemap: Remove obsolete comment in lock_page
Date:   Fri, 29 Apr 2022 18:25:13 +0100
Message-Id: <20220429172556.3011843-27-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

We no longer need the page's inode pinned.  This comment dates back to
commit db37648cd6ce ("[PATCH] mm: non syncing lock_page()") which added
lock_page_nosync().  That was removed by commit 7eaceaccab5f ("block:
remove per-queue plugging") which also made this comment obsolete.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 65ae8f96554b..ab47579af434 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -908,9 +908,6 @@ static inline void folio_lock(struct folio *folio)
 		__folio_lock(folio);
 }
 
-/*
- * lock_page may only be called if we have the page's inode pinned.
- */
 static inline void lock_page(struct page *page)
 {
 	struct folio *folio;
-- 
2.34.1

