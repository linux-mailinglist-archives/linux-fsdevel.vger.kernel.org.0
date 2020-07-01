Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D195C210FA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 17:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbgGAPrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 11:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbgGAPrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:47:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B4C08C5C1;
        Wed,  1 Jul 2020 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=oI/fY2RaXZUuyPG0X0PgxHQGxPFAsCvWrszGWSl/80o=; b=0toF8QDQEBaPnwGAYdAMyHSxHB
        i9i0k6LM1BUo0xVtQT+fOXgsgYLyO7ckqgiCz6Xcs4EtHpqxJxtylMBRJn+LEMabaGzJZgdkzllhb
        CMJ90sA+Q30hvqTDq1FkSpV8h5vFaXJrhXcF1hy++XPTcIitcN6WChR0EpcV2Y1KwdU3Mu7WrMXBy
        jiE44pcCQbogt11eI/tqOX0ayHVEZzGY7owwxbGOSacCk5FvkS8rkeY7RhkJQaxbGxKUQkwwI2ILw
        lK6dbG1Oy7TyUIZP9p+QcyOpZoeMFH1SqoLDJud+pMRG6kGtpcJqEpIDPLQm477LFs39/UgbRbGuc
        /Sn5oU4g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqexT-0003VV-QR; Wed, 01 Jul 2020 15:47:36 +0000
Subject: [PATCH -mmotm] mm/memory-failure: remove stub function
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
References: <20200701045312.af2lR%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <adb60490-484f-a154-e163-725e35a821dc@infradead.org>
Date:   Wed, 1 Jul 2020 08:47:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701045312.af2lR%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

This stub is no longer needed since the function is no longer
inside an #ifdef/#endif block.

Fixes this build error:

../mm/memory-failure.c:180:13: error: redefinition of ‘page_handle_poison’

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c |    4 ----
 1 file changed, 4 deletions(-)

--- mmotm-2020-0630-2152.orig/mm/memory-failure.c
+++ mmotm-2020-0630-2152/mm/memory-failure.c
@@ -169,10 +169,6 @@ int hwpoison_filter(struct page *p)
 	return 0;
 }
 
-static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
-{
-	return true;
-}
 #endif
 
 EXPORT_SYMBOL_GPL(hwpoison_filter);


