Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E021C1CC7E3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgEJHzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgEJHzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:55:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D58DC061A0C;
        Sun, 10 May 2020 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cJrBcFesCCHH++zA2oY5v0CcV8x8Hy3MLhhCCmCGutI=; b=Cg8ydy2JfxDHx5WmYnD7+gYELd
        8yHBhwrMLD+8iu6qbARUIj6XxDlcwEvBbb7nXwQOrHKnxsroWOnlfuvlGUdDhV/0m1yHgAvs2wcX0
        0nTesUo6HDGCtNqlprctVmEu0OjdVaV3FrOqUb+WfUd0ujwRbQByelb9z40XX+8BlAzc6SQk4wMOS
        qx243a10+i11d788jTKiopU1cj87pLDj5CABp+NSUkX+73QGcY7uVvOAyFND1BQ33cdRDYJo3bl0r
        HjzhAWhnzcKcNLGIc7bhJZGHWJH0xu2Yeaz4OZVWbPkWTQzzgGanwZBO+suwdAD8iv4drunTvEGcH
        okQcV9+A==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXgny-0007sD-0h; Sun, 10 May 2020 07:55:22 +0000
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
Subject: [PATCH 03/31] MIPS: unexport __flush_icache_user_range
Date:   Sun, 10 May 2020 09:54:42 +0200
Message-Id: <20200510075510.987823-4-hch@lst.de>
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

__flush_icache_user_range is not used in modular code, so unexport it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/mm/cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 33b409391ddb6..ad6df1cea866f 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -36,7 +36,6 @@ EXPORT_SYMBOL_GPL(flush_icache_range);
 void (*local_flush_icache_range)(unsigned long start, unsigned long end);
 EXPORT_SYMBOL_GPL(local_flush_icache_range);
 void (*__flush_icache_user_range)(unsigned long start, unsigned long end);
-EXPORT_SYMBOL_GPL(__flush_icache_user_range);
 void (*__local_flush_icache_user_range)(unsigned long start, unsigned long end);
 EXPORT_SYMBOL_GPL(__local_flush_icache_user_range);
 
-- 
2.26.2

