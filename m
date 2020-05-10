Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EF11CC7E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgEJHzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgEJHzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:55:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069FBC061A0C;
        Sun, 10 May 2020 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NvlDCJ52IZIXq0+H620wKd1v1G0M5nfx6BSZiQRK5ug=; b=NGBT7Ze+wzfIfeJsuo6D3LAmqC
        On5LQ/nUu5GokPFEn/bHNA6QR2B2+gEbQjCs6LY5hcdxLgPp8fxWD7Acl6JMe4XEeJ0IJbGUDiJVm
        t34DtEvDzzCpX8paEM+Ww56XbmW9GTJKA/z80k/AXQtvb98GSS3x+8olOuFURNUf0tUzd3LJh0dtV
        j5hNfyP2p5c75onJXMhJj6YVCVoGRHUmoi0UsKjHlrQXKzbgCJQK0jiufR8AboGLB7MZa130wVaza
        Tndf4BDbOM+388hCDQeCerJ9pCdswbu+IL4zQ/c4LRCjUV67J70U8+soFFD1tFcI50b2wk7yMHXMN
        uq3olJHg==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXgo0-0007vN-Vz; Sun, 10 May 2020 07:55:25 +0000
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
Subject: [PATCH 04/31] nds32: unexport flush_icache_page
Date:   Sun, 10 May 2020 09:54:43 +0200
Message-Id: <20200510075510.987823-5-hch@lst.de>
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

flush_icache_page is only used by mm/memory.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/mm/cacheflush.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index 254703653b6f5..8f168b33065fa 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -35,7 +35,6 @@ void flush_icache_page(struct vm_area_struct *vma, struct page *page)
 	kunmap_atomic((void *)kaddr);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(flush_icache_page);
 
 void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 	                     unsigned long addr, int len)
-- 
2.26.2

