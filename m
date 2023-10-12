Return-Path: <linux-fsdevel+bounces-190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF897C73B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 19:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD591C210F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFFA34CCA;
	Thu, 12 Oct 2023 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKyrHvpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7682AB57;
	Thu, 12 Oct 2023 17:04:41 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7EED6;
	Thu, 12 Oct 2023 10:04:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so1158221f8f.1;
        Thu, 12 Oct 2023 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697130278; x=1697735078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkUJ0oO3Mp9xCXnylh1JdkHseQH/mUhjkeml5gm5SR8=;
        b=EKyrHvpe3wR6P8/JJLVVlxu74L7tuvaOtZLYAV60i5Qdk9bLS5Vp4TRpQMPanXcRIG
         HNfal8veY8MW4jukBlswEr9s8TtYCcm/Cv7MarTEP1tLYoI3OF8xSPmTzi/kTmuM7HlJ
         c9ouDVCNnFEJ697ucVTGzopnAXIlHxBZk3x9Ji9MeJ34LGt/zWbRICS3wR/S/e8Bk69S
         a8oGXCn+LD8SME9pxhaTjkIKacFE6D6q9ANZt5xFd2syMgp+kC4UDrSD+ucLMfSrPHsg
         AZxgDJGmTLhqpITP2CF8ILNJhCIQ1dSHwv2ze9Yl+UoSAaB97VLpf6+lEaeQBxxiPn+w
         eorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697130278; x=1697735078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkUJ0oO3Mp9xCXnylh1JdkHseQH/mUhjkeml5gm5SR8=;
        b=w3zobfsJvyT4yvIfjLmWAzo2KESGNkbozblTTk5HptZ/zSRKE5NiJRe8dP31oWgY5k
         NTH64CeZEgbUrii/lB3TgQbfTXTVVXqYVXYC76N4QuKgT/i/afgYpI5Oh69mv/nTOYqj
         tur+WwIdo5TJlM7cN65zcB1PRjI80+rZJ+sOdjcdtw7cCCloPD5YjYcL5qtUX6UGEVf+
         YkqM3GRwTGKCCTlgIkXAzJnPJ5F6AtM/vj9Xo61PwD8zohnRfcJQEyeNWhCvWdPXOb2l
         aEt4muFugEdgEFqH8t0TarHnBVPp/tmdI9O98O3DKkcRUD22xtO0KcyBt83hqC6O+E1v
         g8tQ==
X-Gm-Message-State: AOJu0YwOBYRp4wQdbF4OqJj6WVbM+Zx9BGSuBdXEm3lkQPLJaL9JcGXV
	chbzpemZqCtXEyeqwKljePM=
X-Google-Smtp-Source: AGHT+IGEfvOX2oiWBKkh4O/yKmWydOZ76wDsxaQCjAqvjCnNn57Y9QF5SeE6lMfg3rl+IKZUkH80og==
X-Received: by 2002:a05:6000:b0f:b0:32d:9572:6469 with SMTP id dj15-20020a0560000b0f00b0032d95726469mr1470249wrb.46.1697130277811;
        Thu, 12 Oct 2023 10:04:37 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id h16-20020adffd50000000b003197869bcd7sm18875418wrs.13.2023.10.12.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:04:36 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 3/3] mm: perform the mapping_map_writable() check after call_mmap()
Date: Thu, 12 Oct 2023 18:04:30 +0100
Message-ID: <55e413d20678a1bb4c7cce889062bbb07b0df892.1697116581.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697116581.git.lstoakes@gmail.com>
References: <cover.1697116581.git.lstoakes@gmail.com>
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

In order for a F_SEAL_WRITE sealed memfd mapping to have an opportunity to
clear VM_MAYWRITE, we must be able to invoke the appropriate vm_ops->mmap()
handler to do so. We would otherwise fail the mapping_map_writable() check
before we had the opportunity to avoid it.

This patch moves this check after the call_mmap() invocation. Only memfd
actively denies write access causing a potential failure here (in
memfd_add_seals()), so there should be no impact on non-memfd cases.

This patch makes the userland-visible change that MAP_SHARED, PROT_READ
mappings of an F_SEAL_WRITE sealed memfd mapping will now succeed.

There is a delicate situation with cleanup paths assuming that a writable
mapping must have occurred in circumstances where it may now not have. In
order to ensure we do not accidentally mark a writable file unwritable by
mistake, we explicitly track whether we have a writable mapping and
unmap only if we do.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217238
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0041e3631f6c..7f45a08e7973 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2752,6 +2752,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long charged = 0;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
+	bool writable_file_mapping = false;
 	pgoff_t vm_pgoff;
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
@@ -2846,17 +2847,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
-		if (is_shared_maywrite(vm_flags)) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
 		vma->vm_file = get_file(file);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
+		if (vma_is_shared_maywrite(vma)) {
+			error = mapping_map_writable(file->f_mapping);
+			if (error)
+				goto close_and_free_vma;
+
+			writable_file_mapping = true;
+		}
+
 		/*
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
@@ -2920,8 +2923,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	mm->map_count++;
 	if (vma->vm_file) {
 		i_mmap_lock_write(vma->vm_file->f_mapping);
-		if (vma_is_shared_maywrite(vma))
+		if (vma_is_shared_maywrite(vma)) {
 			mapping_allow_writable(vma->vm_file->f_mapping);
+			writable_file_mapping = true;
+		}
 
 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
 		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
@@ -2937,7 +2942,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
-	if (file && is_shared_maywrite(vm_flags))
+	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
 	file = vma->vm_file;
 	ksm_add_vma(vma);
@@ -2985,7 +2990,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
 			     vma->vm_end, vma->vm_end, true);
 	}
-	if (file && is_shared_maywrite(vm_flags))
+	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
-- 
2.42.0


