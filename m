Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFBB2A82D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 16:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgKEP6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 10:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEP6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:58:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10719C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ziXSpYwwOv30Yzb19LL+zWTBXW+PnE0W8FC4eCONvg0=; b=GGj4A2GkuGRW2f1AocXrzSQ7TQ
        cIsDcLS70w40SM7bcQmiyyzWhvir67bsDeD5SHpnOPgUjW+N8K38E/oyeopXZgniyoVhSJsBN5kz+
        ViGxupTlwPSzRV+1lm9ZYu5BKE72EaYs8P7us1sY1o3ONXr+r+04c24ZaI3upS+OROyrVIWSDjyxH
        8WMkesWJTcY01fX3vMHR+vktfDYOfPwK2nNnjgndvyTBghNnwz3Xwrfpt2nzlEk+WZLTa8uCgeXP0
        yGbuZgkvGD2MhT4Ik7MQkOOXVUwGUn2Lk1E+iRwM/dwwpdcHuDOUZNHp7ZLm7HyjuIEMOyckuZlXb
        nHy4KbBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaheq-0002iv-Ay; Thu, 05 Nov 2020 15:58:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/3] bcachefs: Remove page_state_init_for_read
Date:   Thu,  5 Nov 2020 15:58:37 +0000
Message-Id: <20201105155838.10329-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201105155838.10329-1-willy@infradead.org>
References: <20201105155838.10329-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is dead code; delete the function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/bcachefs/fs-io.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index d390cbb82233..98d61d5bc84b 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -647,12 +647,6 @@ static void bch2_readpages_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static inline void page_state_init_for_read(struct page *page)
-{
-	SetPagePrivate(page);
-	page->private = 0;
-}
-
 struct readpages_iter {
 	struct address_space	*mapping;
 	struct page		**pages;
-- 
2.28.0

