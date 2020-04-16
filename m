Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7531AD27B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 00:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgDPWBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728684AbgDPWBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:01:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A606C0610D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=H7DrjoL0HQZseiF+yl4BwbNrWBwT7gY2JKM9rjxN5LE=; b=kx3Xu9VmPmN2b5MwNLIgBNBm9J
        LD3yMlGa0nk8kS4VT+VJILXIoUBja75e271kC//IMYH2LV5zwU8XZ5elgZuZBoZV+o8WcHX0LMsaA
        tNDHvYUx3vkdynpthTmE5Vcfkn21oJhBoSfk1Wf1zpyxtxjqJRJ4AzFOKqM5XUBUFgFvEiQNHKJ7L
        4ctBh9SZOhl/wliRcHQedTlNbNXdNRoRyMdqlpY3zornS2829IZSy26eyvXKQOEHRPMq3bFAALGjo
        O/9VzS/IUmhItNs7mIKZ83YE0BCJwKW85dfmA8HIBN2Lsh2mNePA1taJ5WNiqTmZd96S+JDr4axC1
        AS9mawGA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPCZg-0003Ut-Ox; Thu, 16 Apr 2020 22:01:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v3 11/11] mm: Remove TestClearPageWriteback
Date:   Thu, 16 Apr 2020 15:01:30 -0700
Message-Id: <20200416220130.13343-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416220130.13343-1-willy@infradead.org>
References: <20200416220130.13343-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The last commit removed the only caller of TestClearPageWriteback(),
so remove the definition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 96c7d220c8cf..c6ad04f4863c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -365,7 +365,7 @@ PAGEFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
  * risky: they bypass page accounting.
  */
 TESTPAGEFLAG(Writeback, writeback, PF_NO_TAIL)
-	TESTSCFLAG(Writeback, writeback, PF_NO_TAIL)
+	TESTSETFLAG(Writeback, writeback, PF_NO_TAIL)
 PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
-- 
2.25.1

