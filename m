Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ADC6E18AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 02:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDNAMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 20:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDNAMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:12:02 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E33C1E
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:12:00 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s18-20020a170902ea1200b001a1f4137086so8846751plg.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681431120; x=1684023120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGz+M9nFtzHbGGbLaqDB42+XLCRk5tnoOBaeHE6w0dg=;
        b=S5LluL5NFzRfMffvrC48pA8vM9jBztEWtYOdVu6RC2ufBdtUUSqD+XyBpvK1yq+IN2
         IHnZhiT1W0yssxQ4r7Y9clMkV6zvB2ogiOPODlbRwrRyDr07/qDDpZBBDVLk/N65uZzy
         CN1ozoAyt0GCn/Q/UB/ZvGZUO3F2PMmedv6i9jH6jJ0uY0cAH01PJa7G0h1cPoPbYq3f
         IdXBPJH4a6Ro/C6Sct1ltwBhbcLCAMsdz4Y30Y2jgpBNq+x1h2YwjODMyjFmoi8MJRCf
         dDhFwUgzHhEfG/8I1Qg7KrBG7Crz9lPVWk5qe+WYi0MTtv3ZN9nLmsTMDMwmdbsD2L57
         OQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681431120; x=1684023120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGz+M9nFtzHbGGbLaqDB42+XLCRk5tnoOBaeHE6w0dg=;
        b=R4Wd71V312AH9m+SZTrb2WreFhJwKWe2FoYUX26pe1Yrjk/JdBJretYdvR12/PM/A7
         a+W0lzar/oO+5oEz7IvpAzJjfIFX9SleZUODpFGDVg4VuCsp32ndjOFgPy8dAhAew2D7
         7um/JUGfvtSepWJpq+OUpqiN2xTEVHpwJFFUUrZT3QAX280zNnLYkdLDOj4dTJOBj5Gv
         BQovNV5jp1uT6a8qpyURBJKJ/o3nPbYTlp/VYCAipkEuV+99nT3WJe1O05zwZT8VVdds
         HzOWe21eWlF1YI1JI6Q/dZANaWJwFMqAOKIEOJiRjwHfDX+8/hdV3iCHsmuZAozpd10h
         8Q1w==
X-Gm-Message-State: AAQBX9eizL+Bz/cuQSug3Z6stbnFjkRUvaNuhyKuVm1dgza1zTpJg3xz
        5/x/pt+Qhi2+nyhyoG46k2TedIeZOkMRP8tP7w==
X-Google-Smtp-Source: AKy350YIYIzzkTKMTgAPyGCMhA2HHi565MHAj4RU3xofJGGDi/ggUb7Aj3J6+1abX8zL+AMGXGGHN+6shLHAP2f2mA==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:bd90:b0:19a:f9d9:28d4 with
 SMTP id q16-20020a170902bd9000b0019af9d928d4mr282396pls.3.1681431120479; Thu,
 13 Apr 2023 17:12:00 -0700 (PDT)
Date:   Fri, 14 Apr 2023 00:11:50 +0000
In-Reply-To: <cover.1681430907.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1681430907.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <476aa5a107994d293dcdfc5a620cc52f625768c2.1681430907.git.ackerleytng@google.com>
Subject: [RFC PATCH 1/6] mm: shmem: Refactor out shmem_shared_policy() function
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        muchun.song@linux.dev, feng.tang@intel.com, brgerst@gmail.com,
        rdunlap@infradead.org, masahiroy@kernel.org,
        mailhol.vincent@wanadoo.fr, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor out shmem_shared_policy() to allow reading of a file's shared
mempolicy

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/shmem_fs.h |  7 +++++++
 mm/shmem.c               | 10 ++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d9e57485a686..bc1eeb4b4bd9 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -134,6 +134,13 @@ static inline bool shmem_file(struct file *file)
 	return shmem_mapping(file->f_mapping);
 }
 
+static inline struct shared_policy *shmem_shared_policy(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	return &SHMEM_I(inode)->policy;
+}
+
 /*
  * If fallocate(FALLOC_FL_KEEP_SIZE) has been used, there may be pages
  * beyond i_size's notion of EOF, which fallocate has committed to reserving:
diff --git a/mm/shmem.c b/mm/shmem.c
index b053cd1f12da..4f801f398454 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2248,20 +2248,22 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 }
 
 #ifdef CONFIG_NUMA
+
 static int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
 {
-	struct inode *inode = file_inode(vma->vm_file);
-	return mpol_set_shared_policy(&SHMEM_I(inode)->policy, vma, mpol);
+	struct shared_policy *info;
+
+	info = shmem_shared_policy(vma->vm_file);
+	return mpol_set_shared_policy(info, vma, mpol);
 }
 
 static struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
 					  unsigned long addr)
 {
-	struct inode *inode = file_inode(vma->vm_file);
 	pgoff_t index;
 
 	index = ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
-	return mpol_shared_policy_lookup(&SHMEM_I(inode)->policy, index);
+	return mpol_shared_policy_lookup(shmem_shared_policy(vma->vm_file), index);
 }
 #endif
 
-- 
2.40.0.634.g4ca3ef3211-goog

