Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F168F564F3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiGDIDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiGDIDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:03:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056E55A2
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jul 2022 01:03:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w185so4563970pfb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Jul 2022 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9ptmB3XGt31Pq8FBcI5MbA2yBypm+2JGBZYReeKeY8=;
        b=Q9uOsaM9gkzoT9XZMryjeJeF4CqBEe4f122QMdyvIZ9OW46Gs7GZNeNtv9XtFxnCJJ
         fJqRhw9DxUt5HANWF5eFN4LhPRwVHx/FispChp8KKIr9C6S/zq1dZ9KG9pK2KmbLIap8
         uS3E0XSoWiw8KERhpzJsdlrcOYmCZE9mIS152hhNij8jcjSAnsvF0v726taSw+Dj8qt6
         2pGaOxOcxT5Q98YX++uFB1kri4Vpa1ZLOLSXgZR6PtXp0jdOhRjRdMI8kPpt3zrDBKDe
         Vy3YfYkRNeVmXc3niV/aK3gvgb6va+fJXbTRWgmK+kKE3xJvF326absJFF6oeeKY+VSS
         cCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9ptmB3XGt31Pq8FBcI5MbA2yBypm+2JGBZYReeKeY8=;
        b=y+eKPbJuNY+8hN33fLPfpHIiOfw/7CNMTjOSBFE2Pw8RWywe185O/FfpMwcCIO2NGs
         EZ+p0crFxkgWdXWpQJ97uXh2fpaguaFF/XfT/NhIwgYNjLR6j9ypX9O2IX+bSh0bUsJz
         Eab0VSVCUGhcQ8SxkTA+2iERj5TywGnMzSHXU+RszPWObt1zem7lPYbfS6rgAQqycdjx
         VGoie9Tk4pxPTWUKMHUZ90T+MKrhs9cfcq5FhopUxfSzK1D9IQHKN1Pd3aDXqdhnnhaI
         XOyDLXJwxJhlTyjz1fmwmDWMGfBIicPEOmIZThO7vMdoqJ1Gv8H2EIlJbWh+MdoL50DT
         AGjg==
X-Gm-Message-State: AJIora8Wj3O7jkl7eYZ5zlqYN8c8Hg+OnipdP1y3364PKEXtRfQFRn1l
        qD9AJqPWBS6ZhFuL69tTI9BIPg==
X-Google-Smtp-Source: AGRyM1svsqJoBsj5Q1XvMG+PjZFAD50xTrVz1dkapvyAi5JFA6rZcft884USVJUlz+5c+8OcIXlzng==
X-Received: by 2002:a65:640e:0:b0:412:2906:bb25 with SMTP id a14-20020a65640e000000b004122906bb25mr6567449pgv.82.1656921818983;
        Mon, 04 Jul 2022 01:03:38 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0052089e1b88esm20352965pfe.192.2022.07.04.01.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:03:38 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org, jgg@ziepe.ca,
        jhubbard@nvidia.com, william.kucharski@oracle.com,
        dan.j.williams@intel.com, jack@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: fix missing wake-up event for FSDAX pages
Date:   Mon,  4 Jul 2022 15:40:54 +0800
Message-Id: <20220704074054.32310-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FSDAX page refcounts are 1-based, rather than 0-based: if refcount is
1, then the page is freed.  The FSDAX pages can be pinned through GUP,
then they will be unpinned via unpin_user_page() using a folio variant
to put the page, however, folio variants did not consider this special
case, the result will be to miss a wakeup event (like the user of
__fuse_dax_break_layouts()).

Fixes: d8ddc099c6b3 ("mm/gup: Add gup_put_folio()")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 517f9deba56f..32aaa7b06f5a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1223,6 +1223,9 @@ static inline __must_check bool try_get_page(struct page *page)
  */
 static inline void folio_put(struct folio *folio)
 {
+	if (put_devmap_managed_page(&folio->page))
+		return;
+
 	if (folio_put_testzero(folio))
 		__folio_put(folio);
 }
@@ -1243,8 +1246,13 @@ static inline void folio_put(struct folio *folio)
  */
 static inline void folio_put_refs(struct folio *folio, int refs)
 {
-	if (folio_ref_sub_and_test(folio, refs))
-		__folio_put(folio);
+	/*
+	 * For fsdax managed pages we need to catch refcount transition
+	 * from 2 to 1:
+	 */
+	if (refs > 1)
+		folio_ref_sub(folio, refs - 1);
+	folio_put(folio);
 }
 
 void release_pages(struct page **pages, int nr);
@@ -1268,15 +1276,7 @@ static inline void folios_put(struct folio **folios, unsigned int nr)
 
 static inline void put_page(struct page *page)
 {
-	struct folio *folio = page_folio(page);
-
-	/*
-	 * For some devmap managed pages we need to catch refcount transition
-	 * from 2 to 1:
-	 */
-	if (put_devmap_managed_page(&folio->page))
-		return;
-	folio_put(folio);
+	folio_put(page_folio(page));
 }
 
 /*
-- 
2.11.0

