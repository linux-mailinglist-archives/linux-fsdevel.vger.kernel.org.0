Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF26E64E366
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLOVoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLOVoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9B5C767
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v/AkinrTDVgEfNNO6qpaH3R9dXVC5qhyWPsFiWk0rso=; b=UCttcRqbgCOPA62MHGB77ed36d
        Ozi+5KnHy+yfU5opNJK4JSbiVa8IkuZpoLr6OJgXfnT9EYroI/O1mhHq+BrhW3tvfBFqmSSWGsb1V
        ei6COEw+JllL6MJJG+fuh4qHHXIMI2wkZAcsyFK/3B+86wsVUJuUc6V4KocbOPN/nPPHfRhJ+DFX6
        CGHUs7AsYXu5ztDygodZzfKmb93PjMlDopZWDnDlMwR6ARYfq45laUsmQUVWMa9IVmK5OvAoYVSj8
        ia4i4rpxGQsc7GUvAudCzmC3zJiqZsLKAgZNmMJ3PbUlFsjpQLGINeeb3tCN3nsZFkfB1gLZ62XQc
        0rMNHcdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1O-00EmLc-PB; Thu, 15 Dec 2022 21:44:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/12] page_io: Remove buffer_head include
Date:   Thu, 15 Dec 2022 21:43:56 +0000
Message-Id: <20221215214402.3522366-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221215214402.3522366-1-willy@infradead.org>
References: <20221215214402.3522366-1-willy@infradead.org>
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

page_io never uses buffer_heads to do I/O.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 3a5f921b932e..905d9fcc0c96 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -18,7 +18,6 @@
 #include <linux/swap.h>
 #include <linux/bio.h>
 #include <linux/swapops.h>
-#include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/frontswap.h>
 #include <linux/blkdev.h>
-- 
2.35.1

