Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7B642E1EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhJNTSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhJNTSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:18:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2468C061570;
        Thu, 14 Oct 2021 12:16:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c4so4829822pls.6;
        Thu, 14 Oct 2021 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3q38sz5TQLuQm8PTC3jj3CCsKPnl+MfPRH0XLTbJUc=;
        b=mXLIVQIouBthENaxBdm2VqBZIku4u1AGd6W1ZaaOxgWQiy5RX6VhPCGStH2EF4ChXs
         K2G81Kkyp2pxIrVSEhxA8f9yFcbr80Fdo5tERu/IrhoLs0lDsIxccMMFzVkHClRClqgO
         dUHbAKH/U2/O+nyYesmjSg1lwI7HjIPVHyQzKCmoCq/eBqqxBiLTQ2uVT4Pkn9uEGOF0
         L/roMKuworESHBDQC09yh/BSrwbEB5EylcuHOnI7s8guc4fPny4Jn/hfhpvrcoZzRS9b
         CIPsPEr107/cTZV4qS2DIHaO7UlB1lPQBfMx4YaO4S6tcpqQ+F9DF5o9BLHkjuAygjyB
         pAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3q38sz5TQLuQm8PTC3jj3CCsKPnl+MfPRH0XLTbJUc=;
        b=tNAXIbRaRv8wg0vrcmdGL/mMKEVKRxN/VFjlr+en3xQQ3GvBOZwVeoxFkse7Dgnesm
         OkI9mlpSyjFvfqcXcxOkr6uo3uWHOQHu/NmUTibxDA0TcHrm9CN7x6xeRyiQjveMeGEQ
         tSkO687VyWPwkGgLryXPc4cf8UumAlm2FtQ9MQKnLpqzqKsXU1bPSsm1LE80rfpymjKQ
         oNO5umYhuqfD9btYUJWHdboXA5hKga9kN0UGpPBfOZ9izxxBMtLn+gUzbChM8KaQDCUu
         Oh5RSkBhasLIptdn7p1t6GcwiurPGrrKcIBS+2W1B9GlXQ6AJ6Wsku2RbEG/Dwj4dyE9
         Bj+A==
X-Gm-Message-State: AOAM530GAOwguNeN7kY+6mWh+qrVcHBBR9UqDG+wpNhL3RtNgEP542uX
        4aF2Jwv0wtVwZ1TlAlOd0Dw=
X-Google-Smtp-Source: ABdhPJx8w4/5fJ9Y+BPcAC+KITIYMRcfP0E7okMaDz7ZTf22nTEU3eQ5AX8c63r9ilNdBR3nJCgaGw==
X-Received: by 2002:a17:90a:ba09:: with SMTP id s9mr8348022pjr.42.1634238988236;
        Thu, 14 Oct 2021 12:16:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x129sm3253922pfc.140.2021.10.14.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:16:27 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 3/6] mm: filemap: coding style cleanup for filemap_map_pmd()
Date:   Thu, 14 Oct 2021 12:16:12 -0700
Message-Id: <20211014191615.6674-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211014191615.6674-1-shy828301@gmail.com>
References: <20211014191615.6674-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A minor cleanup to the indent.

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

