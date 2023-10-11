Return-Path: <linux-fsdevel+bounces-101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BCE7C59FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E601C210B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08852231C;
	Wed, 11 Oct 2023 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNXTxxYy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D822305
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 17:04:43 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B020FB6;
	Wed, 11 Oct 2023 10:04:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3226cc3e324so20726f8f.3;
        Wed, 11 Oct 2023 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043880; x=1697648680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbhnCY2fikQ1AinIqQxLBb8QCAx728H2FEqV7zZ9MYo=;
        b=aNXTxxYyRU1h/m7KTax8TlzmFN6YMIe47qZa82V9RzOgRPNKItErFA3grksp/rSvEa
         fMqHIsOf7Ib/vAKwzJcIXISnQoHnDw/g/kFcqnrvo1T5+yaoHPQ73MRKG/ujyQ7+eDtp
         zDv3aAWg5tNPFjzjxLhpFj1kQ/mxWR4jrHW4eDMabKcvfun+stHa6QGqisMVahsHzahO
         8n/1oGbtLI1r7523UmRKJU0T6ROt9fAdgsRtBSRDLm+vaGE2i/d5Hj6N4msF4/0kqKdm
         XoLfjw+3zihzA1vQollpmqMSOXumbTsO561tEjGGYX+1oDCpN4upUGvk6NwEE49+9xbM
         naRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043880; x=1697648680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbhnCY2fikQ1AinIqQxLBb8QCAx728H2FEqV7zZ9MYo=;
        b=UBCQ5PYPQwsA1yucpwZ3SEGMW+MqDiJnobIKb3su5tJfpqpVvs5WdEGTuoqpE1KqFi
         kyNq2Fdo6HPtM++jjIeMl1qZ/dxstTGKOx+9I+HMJ8gzKR7I0OL9+AR5H6MlOI0LgeHh
         BD5r/tG8yBUoiJrcpfKBODRbyxgHLrIl/g4sZ9mZq8iXNDRbr14zfcunMQWakLT2G0kE
         yzPEKll37K8UCF2J8zEr8N/vGDAI3/NDBiLehH9FMxLgMpXkyX9AY1R7QWqY3rSbziev
         sEjcfFGqIqkihtmEPEpcefDnHEPtaFwrtchXIApb6TvIRxCEZiikecBLmT2i+L4kxZSy
         thbA==
X-Gm-Message-State: AOJu0Ywt6qevcyt3s11wceq9t5BB1IYkkQd2gDTZPa3a7oBbc5L+ysc7
	RNgtbmhZlJLLw6DawnNUT/Q=
X-Google-Smtp-Source: AGHT+IEZR2imRCe8uWt+o6P/wYTRJDWFEcZxMj9hpzpBcSeF+EKooItwoY41EIhLesMznrp4x8QUKQ==
X-Received: by 2002:a5d:62c6:0:b0:31f:d52a:82b3 with SMTP id o6-20020a5d62c6000000b0031fd52a82b3mr17821191wrv.46.1697043880104;
        Wed, 11 Oct 2023 10:04:40 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id y19-20020a05600c20d300b004075b3ce03asm3834495wmm.6.2023.10.11.10.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:04:39 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 4/5] mm: abstract merge for new VMAs into vma_merge_new_vma()
Date: Wed, 11 Oct 2023 18:04:30 +0100
Message-ID: <3dc71d17e307756a54781d4a4ce7315cf8b18bea.1697043508.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697043508.git.lstoakes@gmail.com>
References: <cover.1697043508.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Only in mmap_region() and copy_vma() do we attempt to merge VMAs which
occupy entirely new regions of virtual memory.

We can abstract this logic and make the intent of this invocations of it
completely explicit, rather than invoking vma_merge() with an inscrutable
 wall of parameters.

This also paves the way for a simplification of the core vma_merge()
implementation, as we seek to make it entirely an implementation detail.

The VMA merge call in mmap_region() occurs only for file-backed mappings,
where each of the parameters previously specified as NULL are defaulted to
NULL in vma_init() (called by vm_area_alloc()).

This matches the previous behaviour of specifying NULL for a number of
fields, however note that prior to this call we pass the VMA to the file
system driver via call_mmap(), which may in theory adjust fields that we
pass in to vma_merge_new_vma().

Therefore we actually resolve an oversight here by allowing for the fact
that the driver may have done this.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a516f2412f79..e5e50e547ebf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2485,6 +2485,20 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
 	return vma;
 }
 
+/*
+ * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
+ * must ensure that [start, end) does not overlap any existing VMA.
+ */
+static struct vm_area_struct
+*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
+		   struct vm_area_struct *vma, unsigned long start,
+		   unsigned long end, pgoff_t pgoff)
+{
+	return vma_merge(vmi, vma->vm_mm, prev, start, end, vma->vm_flags,
+			 vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
+			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2840,10 +2854,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vma_merge(&vmi, mm, prev, vma->vm_start,
-				    vma->vm_end, vma->vm_flags, NULL,
-				    vma->vm_file, vma->vm_pgoff, NULL,
-				    NULL_VM_UFFD_CTX, NULL);
+			merge = vma_merge_new_vma(&vmi, prev, vma,
+						  vma->vm_start, vma->vm_end,
+						  vma->vm_pgoff);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3385,9 +3398,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
-			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
-- 
2.42.0


