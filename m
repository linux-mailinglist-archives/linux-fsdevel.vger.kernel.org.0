Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2664354F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 23:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhJTVKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 17:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhJTVKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:10:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7532DC06161C;
        Wed, 20 Oct 2021 14:08:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g184so23617386pgc.6;
        Wed, 20 Oct 2021 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Upl2CqhTTaM00XnpLoxyW/y8TEVonM+yQlK+1g9tkk=;
        b=WLzGSX3ENSUti+x/9HxR5yoXNlIjgCpOn4O6vgnTjn4Yi04LrO6SIIWK3dFKfB9EGd
         M7ynjmL+9UYppcrJrhQPZKNM2+w2TWZgeH6cSRvRVLOk9S4Rtm4/VANyJ45RFzCuxTig
         b2aJFdXT5F3AbVtWtJn5JR1/SDGwLFpCUGY/aBn1AAJQHf+cNVXmHQa8wKW5jJg0/0Ly
         cSznQwqrk9dIRHuh+JBgTOgKUDUGMRAaJBFOQbRvtE9WGvsrfPlmYAnn4yuXDM+IkPyZ
         WoR7zpd56cf0AgGhBNjpK1Ef9zwrvFkLnWoq5DtNhiZDJmHmeeB5rbbcl9ISI1shgE6a
         KFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Upl2CqhTTaM00XnpLoxyW/y8TEVonM+yQlK+1g9tkk=;
        b=Z1zu23p2RdXgdaLtCZpRDbEyOJZBHmDaC/90g+mNBB6t3iCwYTsZbpGAuRi7KlG2kY
         fkClJ08somj9XA1ehAhg2SvcR95oG+vdu22l/F/M5ySUn+yrY2ocLw0a68V8ZgT2x++T
         m0W8eNP0rIoPcsgSKhdpq/SeMM8iX47yHkU1iYRtGN7KtFP1tgZF0gnmCFxAt/++aePC
         vw3tdxitzXe+/lINuoJldkJFzm3LK0LW4h/TQHdZvbHQaFw1bijQ6aMIobrCsHKKNLal
         i8csgvP41XwuzfVi3iLmM1Mv9QIWpCBhnAW+/O+wdW/0quCNnYTVyxbMg2KDTtSC5cVf
         aSYw==
X-Gm-Message-State: AOAM530uEZy4G38CZtoQZtjMmkEtU8RnuUOOJXvN5unBP7u5jhoMoko2
        CanclBY2BSEl2KtJgBTlcGw=
X-Google-Smtp-Source: ABdhPJy6C62a+2ttxe2Xo+4qddg6gKC6Bx74zTBsozFIfxwEH0P32OFZiHIgg4KqTuua0h4Pxbr1jA==
X-Received: by 2002:aa7:9099:0:b0:44c:a3b5:ca52 with SMTP id i25-20020aa79099000000b0044ca3b5ca52mr1619862pfa.85.1634764085050;
        Wed, 20 Oct 2021 14:08:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id i8sm3403143pfo.117.2021.10.20.14.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:08:04 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 3/6] mm: filemap: coding style cleanup for filemap_map_pmd()
Date:   Wed, 20 Oct 2021 14:07:52 -0700
Message-Id: <20211020210755.23964-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211020210755.23964-1-shy828301@gmail.com>
References: <20211020210755.23964-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A minor cleanup to the indent.

Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/filemap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index dae481293b5d..2acc2b977f66 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	}
 
 	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
-	    vm_fault_t ret = do_set_pmd(vmf, page);
-	    if (!ret) {
-		    /* The page is mapped successfully, reference consumed. */
-		    unlock_page(page);
-		    return true;
-	    }
+		vm_fault_t ret = do_set_pmd(vmf, page);
+		if (!ret) {
+			/* The page is mapped successfully, reference consumed. */
+			unlock_page(page);
+			return true;
+		}
 	}
 
 	if (pmd_none(*vmf->pmd)) {
-- 
2.26.2

