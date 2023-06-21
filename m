Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB50F738C05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 18:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjFUQqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFUQqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:46:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5021BD1;
        Wed, 21 Jun 2023 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8TiSCbnL9mJc/af1uk/cttNt5G00aLFokvOncuurQEU=; b=ROBkxSuxyK2GHbWwt0qLgFJiv8
        zmj9C6CSHPQM7LyW41/OjbHPRndJOpiS6l5UG+bFw4bxt2G+Ca7A4O02XW/hXrAyAyyAbJMtRBI8r
        utehe7BbwNc6CVtpJO37VKw3d8j5SlrD8p0NYvoc8pLtWcqyqllAEQ9zMkh80iRJ0C6+pqSF/oH6C
        84eZ0XPv0VUhnwCY5IUj6PaAMQvlFyUmc2KJEaEsXJxuERpYSwSOxsIiY96AQnV53rDs25P4xDSor
        f26+lGIPExHjRgT8ClXur7P2d8b4h7khDh7JQZha7/A8GMB16vux2F4j1+4MR3dBM2Nyij9QAVuoG
        PqM1b+Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qC0y2-00EjEp-LV; Wed, 21 Jun 2023 16:46:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 13/13] mm: Remove unnecessary pagevec includes
Date:   Wed, 21 Jun 2023 17:45:57 +0100
Message-Id: <20230621164557.3510324-14-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230621164557.3510324-1-willy@infradead.org>
References: <20230621164557.3510324-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These files no longer need pagevec.h, mostly due to function declarations
being moved out of it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/fadvise.c        | 1 -
 mm/memory_hotplug.c | 1 -
 mm/migrate.c        | 1 -
 mm/readahead.c      | 1 -
 mm/swap_state.c     | 1 -
 5 files changed, 5 deletions(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index f684ffd7f9c9..6c39d42f16dc 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -14,7 +14,6 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
-#include <linux/pagevec.h>
 #include <linux/fadvise.h>
 #include <linux/writeback.h>
 #include <linux/syscalls.h>
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 35db4108bb15..3f231cf1b410 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -13,7 +13,6 @@
 #include <linux/pagemap.h>
 #include <linux/compiler.h>
 #include <linux/export.h>
-#include <linux/pagevec.h>
 #include <linux/writeback.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
diff --git a/mm/migrate.c b/mm/migrate.c
index ce35afdbc1e3..ee26f4a962ef 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -21,7 +21,6 @@
 #include <linux/buffer_head.h>
 #include <linux/mm_inline.h>
 #include <linux/nsproxy.h>
-#include <linux/pagevec.h>
 #include <linux/ksm.h>
 #include <linux/rmap.h>
 #include <linux/topology.h>
diff --git a/mm/readahead.c b/mm/readahead.c
index 47afbca1d122..a9c999aa19af 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -120,7 +120,6 @@
 #include <linux/export.h>
 #include <linux/backing-dev.h>
 #include <linux/task_io_accounting_ops.h>
-#include <linux/pagevec.h>
 #include <linux/pagemap.h>
 #include <linux/psi.h>
 #include <linux/syscalls.h>
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 4a5c7b748051..f8ea7015bad4 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -16,7 +16,6 @@
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
 #include <linux/blkdev.h>
-#include <linux/pagevec.h>
 #include <linux/migrate.h>
 #include <linux/vmalloc.h>
 #include <linux/swap_slots.h>
-- 
2.39.2

