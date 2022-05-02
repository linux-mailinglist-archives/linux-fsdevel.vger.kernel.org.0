Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED42516A86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383434AbiEBGAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 02:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383366AbiEBGA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 02:00:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED29B205DE
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W9gIdbN5ezghRbuhjJdjlQ+L7bZoXSeXQZU4ixAuHk0=; b=inn0fDLiQF2FRP0TwrpAmKoD1J
        GioiJSQjN55DLi6wMfsDP4Q8vj9r1QZixn6RbFgN/JGkAUQobKt3A0w9XD/1ddSxNI6kwuPquY/7d
        WQHubcZMa8jGWyQw2nIQJUhHStezucjjePI1zYFQwBi0jEG9u5Mwq3cCu6npAu/6+a48mn7tPrQnP
        G/xSTzJ/vyfmfJ/pDvpLrZxrTVeKmw8cjCmCeDqbHwiSYGFmOgjkkPsmGL/RxWbZ74T8zZ3boZt6n
        V+jl5EnTf+9+Hi1nJdFATVI+SX413uDRerkDD7NKFyEl/YfWBjXvK/l2ifDK/yjepeMScvtUBJkJ8
        paFRzM+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2h-00EZWf-1Y; Mon, 02 May 2022 05:56:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 16/26] nilfs2: Remove comment about releasepage
Date:   Mon,  2 May 2022 06:56:04 +0100
Message-Id: <20220502055614.3473032-17-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we need a release_folio, we can add it back.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 26b8065401b0..538ca5473b0d 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -304,7 +304,6 @@ const struct address_space_operations nilfs_aops = {
 	.readahead		= nilfs_readahead,
 	.write_begin		= nilfs_write_begin,
 	.write_end		= nilfs_write_end,
-	/* .releasepage		= nilfs_releasepage, */
 	.invalidate_folio	= block_invalidate_folio,
 	.direct_IO		= nilfs_direct_IO,
 	.is_partially_uptodate  = block_is_partially_uptodate,
-- 
2.34.1

