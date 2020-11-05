Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009AE2A8ABD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 00:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbgKEX2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 18:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbgKEX2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:28:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B216FC0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 15:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6Aw1oqRx/np877asxjL+MXjv9T95JdZa5uoyaDSiS7A=; b=Y3wC466a9GsM1gPSRFbIB2BpwR
        tLrYg4uHtICwRUUmRtxZ7fBBf5a7YLkF8ludQpB/yjiUqlrREo0WMglRi6C6qL5jpWZkd4TlBHHCg
        RKtCRskfMxPitsZMNMJMdemhFUSjFq3GhEB8fvfRNrFmS/50E8rar7PNXES4fd9TIBtTFO6SJ3zW8
        VbbZpm7LU5ixHa4RBMLsRTVCka8YqaLlzq2mR3T4w/Wfz62U22f/bBHDk9yE+qCC8Ru3BnoCwgo/d
        ZD2LlFavMKpVVDg2ntKYygV0hkUPA6hwuD+0FoP9KPjGrkH0Sq0SEoxpo0RIHqYCAXjUo69WnCfrd
        mLH4nGJg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaogN-00062c-6J; Thu, 05 Nov 2020 23:28:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 2/3] bcachefs: Remove page_state_init_for_read
Date:   Thu,  5 Nov 2020 23:28:38 +0000
Message-Id: <20201105232839.23100-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201105232839.23100-1-willy@infradead.org>
References: <20201105232839.23100-1-willy@infradead.org>
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
index 82794680a524..46abf3bdf489 100644
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

