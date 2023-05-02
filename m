Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD66F4DE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 01:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjEBX4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 19:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjEBX4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 19:56:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC0E213E
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 16:56:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-63b5e149e1fso2622085b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 16:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683071769; x=1685663769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdKcEQmaaWLxe2HiTbkU80Vf3btOicSKEWhjrrEdCro=;
        b=SyzGjzNi7EHG5k8wDd+xH8eat2wyOdXHzClWS8H2God9fXzYy212Ey1RaqjNMwN4Oc
         vVHPKzhXrxRkWS4Kujnd8ypMX5ysqjrCg5HHCG11NHP4r/2QAaTYWXTbzHJ2xUwpwIsK
         /+AJr9RGPEuBMB1QRpTr7nsgF2phaCsxeZl1+5ocMSHMtT/T6eIsVMZPqOjAR8Gtkvdg
         UAntmTtInu0WrqCro+B2cLss2JHJMmSoG8EMdw2CvO7O4yKKzmM0qjZM1Hhn5m55oI/W
         ugGV+tk1LHPfdCp5eaUjuXQivIGZXMdJzipjaOXDytwjViO2PMbdYNti4ea5xxYc/rsL
         U3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683071769; x=1685663769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdKcEQmaaWLxe2HiTbkU80Vf3btOicSKEWhjrrEdCro=;
        b=Ni67p4AX4Yi/JhTLUy0TZ9H3f96AfFqFfarcsY+q0ulVxgU0zmvBZngDDWNIqD61p1
         +eBWn0IISyv69eSRkME6fL3TjZvWCBxAMKpQzi3LJE3A//GelIV2lDnHach30ut/HPJw
         m1cDHnowugC/VdmKaUmitC2sHZzrkJql84jJa5UTL8KxXkvyeM3MezyMk7SCX3Lska/K
         NH+MoWBSCWnJcS0ObydO4/pWVfvwsFAvkjHB0gPL3E+TCAVt8gXOumvBRFXIqa2cl2uZ
         uIM+DBDzBcOuH4y3n6MRUbsj1FO+G6Kz20jMmBXCKwgLF9d6am/z/OUO0GctPlOolCLV
         e7hg==
X-Gm-Message-State: AC+VfDz/3bDq8OAJoCpaOUq+AnM0yKlGG7KKjY+a0jBwfog1jLrz0Zl4
        0zaPkCHGTcSANNbmM7uOwr8OOWmyQu88Q+ea5Q==
X-Google-Smtp-Source: ACHHUZ4uGtyigwr4nUSi3otC5a7lX2METWY1283Yc+awcEh00aN0uIMJwvcd5ZBL+DarH6qtHL28xEqjZBOaZg2lxw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:d52:b0:63d:3f94:8c3a with
 SMTP id n18-20020a056a000d5200b0063d3f948c3amr4655714pfv.6.1683071769151;
 Tue, 02 May 2023 16:56:09 -0700 (PDT)
Date:   Tue,  2 May 2023 23:56:03 +0000
In-Reply-To: <cover.1683069252.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1683069252.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <f15f57def8e69cf288f0646f819b784fe15fabe2.1683069252.git.ackerleytng@google.com>
Subject: [PATCH 2/2] fs: hugetlbfs: Fix logic to skip allocation on hit in
 page cache
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        jhubbard@nvidia.com
Cc:     vannapurve@google.com, erdemaktas@google.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When fallocate() is called twice on the same offset in the file, the
second fallocate() should succeed.

page_cache_next_miss() always advances index before returning, so even
on a page cache hit, the check would set present to false.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ecfdfb2529a3..f640cff1bbce 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -821,7 +821,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 */
 		struct folio *folio;
 		unsigned long addr;
-		bool present;
 
 		cond_resched();
 
@@ -845,10 +844,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		rcu_read_lock();
-		present = page_cache_next_miss(mapping, index, 1) != index;
-		rcu_read_unlock();
-		if (present) {
+		if (filemap_has_folio(mapping, index)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_drop_vma_policy(&pseudo_vma);
 			continue;
-- 
2.40.1.495.gc816e09b53d-goog

