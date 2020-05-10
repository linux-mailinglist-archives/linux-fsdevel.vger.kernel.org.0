Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A141CC80E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgEJH4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbgEJH4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:56:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3613C061A0C;
        Sun, 10 May 2020 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9OkRp1p3UvpvhrMloqYZ5BRhhjLRydsct9faQtkGwTk=; b=XAAsRr6EjjN3/yVHeqs8/bO7PS
        YuqBIjDerF7M0TIVg8WyqS6VTVh0ppGXMA1Lk/vXdJQTjC+gw+bLoqvyj49cDzbCUHVjkylR5WfRC
        W/SP8iEe3jRFW7kyY4aEdOPrqGcypYxic7RaZSoEvkTrdY0g90ZJcHVMH9Vud0s9+SczW0EqvxmmW
        JplpkK9+vVvUCRYxaP/W791YtBayhgsNGzGcOmz+I8L8LMKeS4WJ2u1CVDeK478m53/XLI4u5CWpL
        NSfinyVz/L1BKxtiHquQl3xYyh+8U9qIO7gb3cw3Q0hxw74WqYXAitW1agV0smLp6loKx444KAQvG
        OMeYetgg==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXgoP-0008QV-Vf; Sun, 10 May 2020 07:55:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/31] c6x: use asm-generic/cacheflush.h
Date:   Sun, 10 May 2020 09:54:51 +0200
Message-Id: <20200510075510.987823-13-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

C6x needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/c6x/include/asm/cacheflush.h | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/c6x/include/asm/cacheflush.h b/arch/c6x/include/asm/cacheflush.h
index 4540b40475e6c..10922d528de6d 100644
--- a/arch/c6x/include/asm/cacheflush.h
+++ b/arch/c6x/include/asm/cacheflush.h
@@ -16,21 +16,6 @@
 #include <asm/page.h>
 #include <asm/string.h>
 
-/*
- * virtually-indexed cache management (our cache is physically indexed)
- */
-#define flush_cache_all()			do {} while (0)
-#define flush_cache_mm(mm)			do {} while (0)
-#define flush_cache_dup_mm(mm)			do {} while (0)
-#define flush_cache_range(mm, start, end)	do {} while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do {} while (0)
-#define flush_cache_vmap(start, end)		do {} while (0)
-#define flush_cache_vunmap(start, end)		do {} while (0)
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)			do {} while (0)
-#define flush_dcache_mmap_lock(mapping)		do {} while (0)
-#define flush_dcache_mmap_unlock(mapping)	do {} while (0)
-
 /*
  * physically-indexed cache management
  */
@@ -49,14 +34,12 @@ do {								  \
 			(unsigned long) page_address(page) + PAGE_SIZE)); \
 } while (0)
 
-
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 do {						     \
 	memcpy(dst, src, len);			     \
 	flush_icache_range((unsigned) (dst), (unsigned) (dst) + (len)); \
 } while (0)
 
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+#include <asm-generic/cacheflush.h>
 
 #endif /* _ASM_C6X_CACHEFLUSH_H */
-- 
2.26.2

