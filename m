Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3827E342B34
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhCTFpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCTFpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:45:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF48C061762;
        Fri, 19 Mar 2021 22:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WOmo33gIE1uQvr79REoxKRtBf91u6djs8UiAd3KaghI=; b=KQ5QFeZeSiBnOgTSlzeiu4Z/z2
        IB6dMTS8aIFxS04DqMHPQTj1LDqdrStNk3XokvkM30SL0zSRlFE96HYMzfZZCTdcHmIzHNfFfktFn
        /VsQJIyRlkR5HY4RQLQ9z3mKmFvC4ZxyjM/5TvKT/2yw5I9rGGIE1lv5PvkEjppw6dKkCnASc5LtR
        W/qDni76+VLBhfL8C9Vepu6KhHV+4rWDfwKOv7tcJJ2Za/hthVCtPapdX8xgbp3QWH8aKCsfDZeHG
        sqvtbLVRHZCnDq2dea1M/7zUjiEjKOQdxraw3NwmCs/fa+4W/pbFzf02lQHPQdmvxJSlWS5xWMenq
        jZeQ/d9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUPp-005SnA-El; Sat, 20 Mar 2021 05:44:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 27/27] mm/doc: Build kerneldoc for various mm files
Date:   Sat, 20 Mar 2021 05:41:04 +0000
Message-Id: <20210320054104.1300774-28-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These files weren't included in the html docs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/mm-api.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index 874ae1250258..3af5875a1d9e 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -93,3 +93,10 @@ More Memory Management Functions
 
 .. kernel-doc:: mm/page_alloc.c
 .. kernel-doc:: mm/mempolicy.c
+
+.. kernel-doc:: include/linux/mm_types.h
+   :internal:
+.. kernel-doc:: include/linux/mm.h
+   :internal:
+.. kernel-doc:: mm/util.c
+   :functions: folio_mapping
-- 
2.30.2

