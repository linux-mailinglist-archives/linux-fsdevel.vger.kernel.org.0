Return-Path: <linux-fsdevel+bounces-189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016BF7C73AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 19:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2131E1C21386
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C90347CB;
	Thu, 12 Oct 2023 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB1q1Jf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88B339BD;
	Thu, 12 Oct 2023 17:04:40 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA14CA;
	Thu, 12 Oct 2023 10:04:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-406618d0991so12457525e9.2;
        Thu, 12 Oct 2023 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697130276; x=1697735076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LHgfYhq7AemM3CMY63djM9UPMuGnWJ3Ca40aCfcDv0=;
        b=VB1q1Jf2KTBfKkAWvU9qEjXoDf8EcFQY2qWhHU0U27kgdiu+ldcbi/Vb5dLj0DsIGw
         ZKg6aaCr1gaJ3JfcFnSY4FmrVb/gt27L3RC7RUUbradrlwS19z+6v8cV4M1iBQTjJPeb
         Odoi0FQ6eIZs2Nf96dYusIL8Fg+gcBDXh++1+FVMzVooEuppb4R6+F2Tu6lc9QP0RvgO
         AgxZBppa+wLnRSIehuxili6+kqle0ByGYOO1s+ArNxL43SSQcQaZCrRcEb98+iGV+lHR
         TISTPipnTR2PGGGXVq1e6zKCl2c1Q+Xb9fnH/84rKy2gGrmoIuVP7OMlGiXEh67r6UA0
         9SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697130276; x=1697735076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LHgfYhq7AemM3CMY63djM9UPMuGnWJ3Ca40aCfcDv0=;
        b=Tewgxr3cDAE8aFl+Lk79wFYAcQ2nfS0YBDlZ6yjU1X6UOZsYHbYzdT+fXCsQOQAExB
         ETjVQTIFU5fldNIWj0TGNMOvb6Co8yIFCCO/aG79MQMtpIaNcNdexDc9DKl0TnBTIICX
         4IC8L/yCGS+WWbgRb4e1aP7gL33v40v1TjFWraAzkBgQdmVg4x8/lHmyTOg9YC84rEbI
         hbbiU2PB13/JAhnhTBh1/qkNuKi4T9CofiR+JFVDuTveT/8Fe+W1KcIV5qPFakOCJWhB
         cJYKGmWUWFVlMWjzDUvXi5okILXNqQWn3KJs+7GbI2ahk7BJ7/cOA7tr16zA6N/bumUp
         u2YQ==
X-Gm-Message-State: AOJu0YyiYa5iv0L+NnWaHcX/Vu3cV1A5dxcI7JMVNasrIUAJumbj97Lz
	kPIGOfXWb4MEAsqXEHEO/Cc=
X-Google-Smtp-Source: AGHT+IH0xAcE4YpN2PK6WqZDga4ztB5LkRYTzIVE53cOl8uKk2DQm6dZmFs1iPawW4LIUtQS3pkW5Q==
X-Received: by 2002:a5d:628a:0:b0:320:bb1:5a73 with SMTP id k10-20020a5d628a000000b003200bb15a73mr21972024wru.22.1697130276078;
        Thu, 12 Oct 2023 10:04:36 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id h16-20020adffd50000000b003197869bcd7sm18875418wrs.13.2023.10.12.10.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:04:34 -0700 (PDT)
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
Subject: [PATCH v4 2/3] mm: update memfd seal write check to include F_SEAL_WRITE
Date: Thu, 12 Oct 2023 18:04:29 +0100
Message-ID: <913628168ce6cce77df7d13a63970bae06a526e0.1697116581.git.lstoakes@gmail.com>
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

The seal_check_future_write() function is called by shmem_mmap() or
hugetlbfs_file_mmap() to disallow any future writable mappings of an memfd
sealed this way.

The F_SEAL_WRITE flag is not checked here, as that is handled via the
mapping->i_mmap_writable mechanism and so any attempt at a mapping would
fail before this could be run.

However we intend to change this, meaning this check can be performed for
F_SEAL_WRITE mappings also.

The logic here is equally applicable to both flags, so update this function
to accommodate both and rename it accordingly.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/hugetlbfs/inode.c |  2 +-
 include/linux/mm.h   | 15 ++++++++-------
 mm/shmem.c           |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 06693bb1153d..5c333373dcc9 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -112,7 +112,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bae234d18d81..26d7dc3b342b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4078,25 +4078,26 @@ static inline void mem_dump_obj(void *object) {}
 #endif
 
 /**
- * seal_check_future_write - Check for F_SEAL_FUTURE_WRITE flag and handle it
+ * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
+ *                    handle them.
  * @seals: the seals to check
  * @vma: the vma to operate on
  *
- * Check whether F_SEAL_FUTURE_WRITE is set; if so, do proper check/handling on
- * the vma flags.  Return 0 if check pass, or <0 for errors.
+ * Check whether F_SEAL_WRITE or F_SEAL_FUTURE_WRITE are set; if so, do proper
+ * check/handling on the vma flags.  Return 0 if check pass, or <0 for errors.
  */
-static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
+static inline int seal_check_write(int seals, struct vm_area_struct *vma)
 {
-	if (seals & F_SEAL_FUTURE_WRITE) {
+	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
 		/*
 		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-		 * "future write" seal active.
+		 * write seals are active.
 		 */
 		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
 			return -EPERM;
 
 		/*
-		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
+		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
 		 * MAP_SHARED and read-only, take care to not allow mprotect to
 		 * revert protections on such mappings. Do this only for shared
 		 * mappings. For private mappings, don't need to mask
diff --git a/mm/shmem.c b/mm/shmem.c
index 6503910b0f54..cab053831fea 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2405,7 +2405,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
-- 
2.42.0


