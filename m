Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD41E153D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbgEYUby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 16:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389950AbgEYUby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 16:31:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCACC061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2020 13:31:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d7so21619251eja.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2020 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RdmBZk3wWhWdfLnacS8DUs6RlId0X8/5siZUx0HN8Ng=;
        b=E6EtCHK3HwZjnoHerbcIjxe44Wozrz2D/brrhHJbbAQmbbDh6Q4BxS8hBiMb/MhDcH
         0N9Lqmt+JwQgXPK0hqyZ5S+DmE09cHYF252zw2ynmQV6L9JDZy4kS9Xkmcfc6zj4PeXy
         2uGRpMofC8DWSxwfDrE3xPpukIp5+GScVw471V90b19TjAicLvBOKy2vtveU0x4BfyKl
         0/sS7krOro164PEO/UHiabl24e7NbIy3ehmVoeDLwhyLhPyjVYcRByT4fY/rqtCuzxUD
         QG3rm8Tq+JKIU/5Q7CxMZBgweU8hfSwbpIaSnn2nEKJwqKbjrRk4tVJPJHWKnxJ0GzrH
         Ss6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RdmBZk3wWhWdfLnacS8DUs6RlId0X8/5siZUx0HN8Ng=;
        b=FLIXxb8Ylje+1/UpfIK+uoq+bQdK0iZdhNW3m/3FoPrbs4qs9VjEvAlBJ9imx7mSrM
         vQktJCvM64I/RHrZ6Gv7fhU81u+O/W61ym3jiqQC4fH3/BNMO5rjmeLFBa4EoFv44k9h
         6UVSnH37Esn6qt8kNQM4HtFN3HeGiby7DvNUAEALaPiWkXGCe5toK9Kz0CHnTjU2RRHW
         buQTia15RgdqDr1+N0Twu9qM9iqatn8wUz9mxRRAHWUErQFxtCdg1zjEpPeFlyDZK3CQ
         SxyHG0H+l3rTLMlna3yWlshcAMSR0ArQFq5P08syDs/f01yPyoih0OlD/ut/IWbL8hbi
         9n2w==
X-Gm-Message-State: AOAM5327GtWOtQrTrl0yb13TsEgsj0d5JFDMlSwSZR6pMVneNqsOhNsg
        s5xRMnoEhYZB7RyquaW/mUHCJw==
X-Google-Smtp-Source: ABdhPJyWU1kzWG3OXBGnLiZYT9Vi96JvKEJATvbFYfkxB5ca2OLlQ6pldcYkZGl1gmB01Q36RwIhSA==
X-Received: by 2002:a17:906:3597:: with SMTP id o23mr19545286ejb.174.1590438712716;
        Mon, 25 May 2020 13:31:52 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a9f3:8576:8bb4:4392])
        by smtp.gmail.com with ESMTPSA id s1sm17014881ejh.81.2020.05.25.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 13:31:52 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] mm_types.h: change set_page_private to inline function
Date:   Mon, 25 May 2020 22:31:49 +0200
Message-Id: <20200525203149.18802-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change it to inline function to make callers use the proper argument.
And no need for it to be macro per Andrew's comment [1].

[1] https://lore.kernel.org/lkml/20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org/

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 include/linux/mm_types.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e88dc5c65c01..64ede5f150dc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -240,7 +240,11 @@ static inline atomic_t *compound_pincount_ptr(struct page *page)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 
 #define page_private(page)		((page)->private)
-#define set_page_private(page, v)	((page)->private = (v))
+
+static inline void set_page_private(struct page *page, unsigned long private)
+{
+	page->private = private;
+}
 
 struct page_frag_cache {
 	void * va;
-- 
2.17.1

