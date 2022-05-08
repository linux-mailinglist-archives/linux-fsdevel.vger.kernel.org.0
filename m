Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AE151F12A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiEHUc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiEHUc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:32:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35383BE3B
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kkCNfBTfba7xDrYz14rR4zqJeO5mJifkXG11yRqXDzM=; b=MfA1Epxuu29kkBTujfGOcx8L08
        H/9FcoQc8OjsQ4MhTa0LfQZzi5W8I4RZkKNP07x1wDytj5FGUb4hqKep27nEjYcww3sEDyS4JTsyI
        1WNt94iU3s2Mf8Qkev1jH7CjfaWD7sjBp/3+C5ED8zn2bA9NG4SUznBiuSA7F4IX5OdpcBCPnc84y
        SQQD8Xhway0Ze0v5KYvhQ7aOxYe6jvEA9Vis48dpHAJSco294fiuzUKdo3SGYB+6hOCqeCh0x9xiK
        mbNrJxAZB/eclVsBZbDxgBO9XYRWyh5IAow5DTGvhwuQG67Xp0U4K7dwD/TAokFYw6M0VK9CfVsrj
        gs1iPkCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnWY-002nUC-D4; Sun, 08 May 2022 20:29:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] Appoint myself page cache maintainer
Date:   Sun,  8 May 2022 21:28:48 +0100
Message-Id: <20220508202849.666756-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YngbFluT9ftR5dqf@casper.infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
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

This feels like a sufficiently distinct area of responsibility to be
worth separating out from both MM and VFS.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d47c5e7c6ae..5871ec2e1b3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14833,6 +14833,18 @@ F:	Documentation/core-api/padata.rst
 F:	include/linux/padata.h
 F:	kernel/padata.c
 
+PAGE CACHE
+M:	Matthew Wilcox (Oracle) <willy@infradead.org>
+L:	linux-fsdevel@vger.kernel.org
+S:	Supported
+T:	git git://git.infradead.org/users/willy/pagecache.git
+F:	Documentation/filesystems/locking.rst
+F:	Documentation/filesystems/vfs.rst
+F:	include/linux/pagemap.h
+F:	mm/filemap.c
+F:	mm/page-writeback.c
+F:	mm/readahead.c
+
 PAGE POOL
 M:	Jesper Dangaard Brouer <hawk@kernel.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
-- 
2.34.1

