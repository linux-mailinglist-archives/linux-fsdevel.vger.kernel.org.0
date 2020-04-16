Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B71ACB59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 17:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896217AbgDPPqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895889AbgDPPqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:46:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E86C061A10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=H7DrjoL0HQZseiF+yl4BwbNrWBwT7gY2JKM9rjxN5LE=; b=ADJhbB9ORIbqyXqjF2YTJ90fnF
        +ZPkKws73AJx4cUNAlN129pucGUOUhd4JyjYx8/Omh5Ut6VvNnEywGwE3uiue0HtaPPZfX2aGmYl1
        fzbNyPNihvSWcid5kcRq67CRz89knSCWHXEiaBkARiFgDdk998H8v7gmQ4DkJ1KJF9ltyauGkanL9
        56JXtmzXMAzP3CCZZscWOSkJJKq2UwAiu8HollYuqx4CpI/JX9lm1c4hCEMO8u7l8rTYmZkSdBAXA
        CL4X+FF7uCC3TWFjobNz8OabIbdvYhHwzzrQX7CgxCJ2xihaVvDtkwANumVQa5PjkISIuCou1zj3A
        DvGBcxYw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6iN-00006k-IJ; Thu, 16 Apr 2020 15:46:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 5/5] mm: Remove TestClearPageWriteback
Date:   Thu, 16 Apr 2020 08:46:06 -0700
Message-Id: <20200416154606.306-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416154606.306-1-willy@infradead.org>
References: <20200416154606.306-1-willy@infradead.org>
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

