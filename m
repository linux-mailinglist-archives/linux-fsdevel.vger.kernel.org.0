Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3551E8BF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgE2X1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgE2X1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:27:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C55BC08C5C9;
        Fri, 29 May 2020 16:27:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoPM-000Bhy-0v; Fri, 29 May 2020 23:27:24 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] TEST_ACCESS_OK _never_ had been checked anywhere
Date:   Sat, 30 May 2020 00:27:21 +0100
Message-Id: <20200529232723.44942-6-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Once upon a time the predecessor of that thing (TEST_VERIFY_AREA)
used to be.  However, that had been gone for years now (and
the patch that introduced TEST_ACCESS_OK has not touched any
ifdefs - they got gradually removed later).  Just bury it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/pgtable_32.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 0dca7f7aeff2..fb10f2f8f4f0 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -32,13 +32,6 @@ extern pmd_t initial_pg_pmd[];
 void paging_init(void);
 void sync_initial_page_table(void);
 
-/*
- * Define this if things work differently on an i386 and an i486:
- * it will (on an i486) warn about kernel memory accesses that are
- * done without a 'access_ok( ..)'
- */
-#undef TEST_ACCESS_OK
-
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
 #else
-- 
2.11.0

