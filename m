Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C778188E0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 20:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgCQTc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 15:32:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44868 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgCQTc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:32:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id y2so11763778wrn.11;
        Tue, 17 Mar 2020 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lkrlnh41qEla6doz611nE2A+6RV961H8nQhZ4jF0FBc=;
        b=ga94Wv3QbxmIG+2zHQj69KekHTY2A/PZdhbtGvL23ZPWaG0bRdKbtKxOwvYImXiZtK
         dfFs2H9QJiuyK92EKJCq2fFn3g2Hel2Y2OYG3SGQ962RYuBhZs2fgKmlBqhVnk1CDMS6
         eCCNnK4CAspVwg2dceinBwPK/CdRG1SXc70dcvhQtdDGL9CmIBXrsBSF8Gp8KXw5Mu8h
         wLwbCVurrVjKVWfaTyM8agQjm2zrTJeLKo7lHryGifuRnVjiUmoWWKtoGi3LCQyv3K+T
         MedVpEvA1wmYU+gJL5oOrQyTijAK5SfWQJNj0bQZVvM7X+XXJd59Gb3tckoVdUbirc6u
         5v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lkrlnh41qEla6doz611nE2A+6RV961H8nQhZ4jF0FBc=;
        b=VVYJUbrTCeUDK9GMcoSkR3hMQeSI+74f28EQv2ICsSBJsH+ux9rs9MZ37yEqvd5n+c
         ml54Vs+HDr1lavgPhlT6Y3M1tIWVrWa4Feway5A5+Z3CVPLxj4+oGuXboer/iFXYUZiI
         cH4HujI8i6Yw4yNGWaXN0ksPIMgQ4brv826iW7CPU//NKZynpdGrDO9JiliHua8y4h4j
         BXGwgGG1SzoVCyPcAUj3BVuGFh9JzYaUMa6HKPwwf0Lpn0FMVbiJ9xwfmRfi59y7Bgq2
         Uv/dUBIUxIm3X8mybtp7gzF+kbz+MCj3bUcPrXPxlqskQ2Y4mVAMjgUBl/s6peBJ47aT
         zuVw==
X-Gm-Message-State: ANhLgQ2wwjq294rLZVpiJVwaijt0IuxGpJxFOyKCMenBVRL0FhQ9DQ2U
        4H3mvOD6cdu6sPIdSVpUeA==
X-Google-Smtp-Source: ADFU+vt26S9CVSgs4QLsmbqlt8QeiFohBL2uesG6RFcE6CR1K8EvKFJsPsZAswdxLzma3hT2RI3ovw==
X-Received: by 2002:adf:a489:: with SMTP id g9mr609258wrb.44.1584473546689;
        Tue, 17 Mar 2020 12:32:26 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.254.169])
        by smtp.gmail.com with ESMTPSA id t1sm5946323wrq.36.2020.03.17.12.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 12:32:25 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com
Subject: [PATCH 5/5] proc: inline m_next_vma into m_next
Date:   Tue, 17 Mar 2020 22:32:01 +0300
Message-Id: <20200317193201.9924-5-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317193201.9924-1-adobriyan@gmail.com>
References: <20200317193201.9924-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

It's clearer to just put this inline.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/task_mmu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9f10ef72b839..87641df8c0d0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -123,14 +123,6 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static struct vm_area_struct *
-m_next_vma(struct proc_maps_private *priv, struct vm_area_struct *vma)
-{
-	if (vma == priv->tail_vma)
-		return NULL;
-	return vma->vm_next ?: priv->tail_vma;
-}
-
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
@@ -173,9 +165,15 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
-	struct vm_area_struct *next;
+	struct vm_area_struct *next, *vma = v;
+
+	if (vma == priv->tail_vma)
+		next = NULL;
+	else if (vma->vm_next)
+		next = vma->vm_next;
+	else
+		next = priv->tail_vma;
 
-	next = m_next_vma(priv, v);
 	*ppos = next ? next->vm_start : -1UL;
 
 	return next;
-- 
2.25.0

