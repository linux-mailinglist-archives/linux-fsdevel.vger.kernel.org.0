Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663E22D0F49
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgLGLfj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgLGLfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:37 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B298C061A54;
        Mon,  7 Dec 2020 03:34:51 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id w4so8627283pgg.13;
        Mon, 07 Dec 2020 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaKSoEd8oO/EoBIYBO4UbeyIy7f7hbBSPRHqMQ3AnvY=;
        b=PzhKbqA5fZx1L/DdeOWbYK9XMQgh6O7ZLstwldRGSShPdyufij9rEkyE6yyPtqiQFR
         DvWZPV6HXWx47aXdj0c5QGrJYx5jyAb/hJu6ZyCLoid/KOSX4lnYuS1fkyC5qERNn/or
         fi52i7cA0Ydltn8kGuWGFLJllgTdoSaKxXa27xZA7ACXlEmO/koMkREMuXdB83dzkDs3
         bplK/YxucWjx5cD+h5V/dR0hD0kyXDZPv5eYvSZXBUPl8fSplms6k6vGbok9ayTpD/3z
         aXsvfT7CwDAq3W8zodGBCvxkyjKmS/58WaE/6abU2h1kr6g7+ePfVSLGuuKFpsJcEC4S
         +BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaKSoEd8oO/EoBIYBO4UbeyIy7f7hbBSPRHqMQ3AnvY=;
        b=oy2liVx1AWp8wIDUYNAiD4J1aMSGk9A+3gZvYM1ePUdxo5wPinjgZEZRvUUxQN51Ml
         I41Zk2Elu45GaJJtbiGTkXZWmOV5CSO/e0XSK+7XYOHvD/qWTRiiyRN0tqzsiZ/nsAu9
         0f1maZnmpUzNzfAoj1ippZ0+Fz8mkE80JF4+Q5pXLyE2fBooJpwCqi1r+bKh0ZG4YB4t
         xZEhIwzqU8I+FgxXdM/vNkb73NaMl5+xLGyBprAu4Zwi+zJeK2BodgPEIzlPUC6YnF1v
         6zTwnh6VifJWbprvxNS1LrsK4N95P2ba27S5OYaSAbgs0RNUrFcAYpDPO3g60EmLiCKn
         2R1g==
X-Gm-Message-State: AOAM530q86wxVOLN5FBcKztpkrHTrkfud/O6txoxYpoMW707pzqLqmDk
        NLFViHXEfdswHPctycchhBA=
X-Google-Smtp-Source: ABdhPJyqqW0fQyetyIn3XyHRcLkK2zOeQJNTeAqGI4VkfBmrNDEhNpiPMRzTChGwx86K9TucHV5VBg==
X-Received: by 2002:a17:902:7144:b029:da:7268:d730 with SMTP id u4-20020a1709027144b02900da7268d730mr15412723plm.20.1607340891184;
        Mon, 07 Dec 2020 03:34:51 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:50 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 21/37] mm: support dmem huge pmd for follow_pfn()
Date:   Mon,  7 Dec 2020 19:31:14 +0800
Message-Id: <c83a4e698999902057cdf8e3a662ec6837f6f466.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

follow_pfn() will get pfn of pmd if huge pmd is encountered.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 mm/memory.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6b60981..abb9148 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4807,15 +4807,23 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	int ret = -EINVAL;
 	spinlock_t *ptl;
 	pte_t *ptep;
+	pmd_t *pmdp = NULL;
 
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
 		return ret;
 
-	ret = follow_pte(vma->vm_mm, address, &ptep, &ptl);
+	ret = follow_pte_pmd(vma->vm_mm, address, NULL, &ptep, &pmdp, &ptl);
 	if (ret)
 		return ret;
-	*pfn = pte_pfn(*ptep);
-	pte_unmap_unlock(ptep, ptl);
+
+	if (pmdp) {
+		*pfn = pmd_pfn(*pmdp) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
+		spin_unlock(ptl);
+	} else {
+		*pfn = pte_pfn(*ptep);
+		pte_unmap_unlock(ptep, ptl);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(follow_pfn);
-- 
1.8.3.1

