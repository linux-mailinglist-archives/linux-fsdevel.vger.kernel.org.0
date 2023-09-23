Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C4D7ABD10
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 03:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjIWBcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 21:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjIWBcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 21:32:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5892FF7
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 18:31:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c07ca1b44so47914747b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 18:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695432714; x=1696037514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmlRLzvRmqHtTQ7XfVaULJQdpUmF9g0LEd2VGVtMlKs=;
        b=G8owUdPznKVfLY45n4FQwwFNCPmcO1hv0oASRh5iwzDGrKQUSW0/GCJ665iIBhlwKK
         D8lQHxHOLRlGSHKaQgVPxw1U+crg7KdZ4UhMJR5n8G9zTuPet62f3XnykrnpPZe3wIj+
         aD077xa/f0N1AxbxBY00jXiOB6mADwPkCBaF1csm95Gi9eeLwQSg5k7oRN8ujBSy7IWP
         TAYyeMwI1Xw20t9oXEJ7zm1y5PpVNwknrcepH+ZZpWtrUn0IQWNzjc+y50vheI/imNtn
         zqe1waeQAanWmFpFCkZrOplL65HipkM8KgGrRkOZKyAxE/hUFVyuQmtCP1LV5fQSwkCN
         O88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695432714; x=1696037514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmlRLzvRmqHtTQ7XfVaULJQdpUmF9g0LEd2VGVtMlKs=;
        b=RjMI+khZ3yEP7hks9Exm381Uv5HL9y9zQ77OHflNl9c0ZZt3WzjFP36FOeokDpdXLb
         wTOKS7a0koBUjJoR/5VlqpEyJ7zKnTcbdngH67hjN+bVA8rQV35nB9kWLQnpSHX4yXq2
         jnHoCTP4kFTfIsI1Q2PmedyIxTElgA9A4jHxGL5wScCCm/2Bb1uALoCv840afiSj6M8S
         6IKQtZFxI+3EUW8U4S27MJi/12+hi61AKMyK32sf/rDUuuk63FXKajrZKNPwKjvazPkN
         irUuJ/D0Wk7OYdPBNzpekXKaiTnpXF0IBxA2K2w0XVcS2+C+Aa3MQFzTYbbpQusGAA3K
         9iUw==
X-Gm-Message-State: AOJu0Ywch9QEXCKiupsDEO0+F1YWQqImn1JC/4tcbIs5DgPG/lIlWBVx
        7Kytdbj7Vbvr1Z+ghu0y3Xm4ZWxMMkg=
X-Google-Smtp-Source: AGHT+IHrox59qxxuPIk8Ga14hkjCpjYszzofG63cVT9NaC90L+xjL83ej6dG0sFL+ZY5m2NWMQmGlw9XCjA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3398:6644:ed7f:bec9])
 (user=surenb job=sendgmr) by 2002:a25:cb0f:0:b0:d7f:2cb6:7d8c with SMTP id
 b15-20020a25cb0f000000b00d7f2cb67d8cmr11540ybg.13.1695432714541; Fri, 22 Sep
 2023 18:31:54 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:31:44 -0700
In-Reply-To: <20230923013148.1390521-1-surenb@google.com>
Mime-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230923013148.1390521-2-surenb@google.com>
Subject: [PATCH v2 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
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

From: Andrea Arcangeli <aarcange@redhat.com>

As far as the rmap code is concerned, UFFDIO_REMAP only alters the
page->mapping and page->index. It does it while holding the page
lock. However folio_referenced() is doing rmap walks without taking the
folio lock first, so folio_lock_anon_vma_read() must be updated to
re-check that the folio->mapping didn't change after we obtained the
anon_vma read lock.

UFFDIO_REMAP takes the anon_vma lock for writing before altering the
folio->mapping, so if the folio->mapping is still the same after
obtaining the anon_vma read lock (without the folio lock), the rmap
walks can go ahead safely (and UFFDIO_REMAP will wait the rmap walk to
complete before proceeding).

UFFDIO_REMAP serializes against itself with the folio lock.

All other places taking the anon_vma lock while holding the mmap_lock
for writing, don't need to check if the folio->mapping has changed
after taking the anon_vma lock, regardless of the folio lock, because
UFFDIO_REMAP holds the mmap_lock for reading.

There's one constraint enforced to allow this simplification: the
source pages passed to UFFDIO_REMAP must be mapped only in one vma,
but this constraint is an acceptable tradeoff for UFFDIO_REMAP
users.

The source addresses passed to UFFDIO_REMAP can be set as
VM_DONTCOPY with MADV_DONTFORK to avoid any risk of the mapcount of
the pages increasing if some thread of the process forks() before
UFFDIO_REMAP run.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/rmap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index ec7f8e6c9e48..c1ebbd23fa61 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -542,6 +542,7 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	struct anon_vma *root_anon_vma;
 	unsigned long anon_mapping;
 
+repeat:
 	rcu_read_lock();
 	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
 	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
@@ -586,6 +587,18 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	rcu_read_unlock();
 	anon_vma_lock_read(anon_vma);
 
+	/*
+	 * Check if UFFDIO_REMAP changed the anon_vma. This is needed
+	 * because we don't assume the folio was locked.
+	 */
+	if (unlikely((unsigned long) READ_ONCE(folio->mapping) !=
+		     anon_mapping)) {
+		anon_vma_unlock_read(anon_vma);
+		put_anon_vma(anon_vma);
+		anon_vma = NULL;
+		goto repeat;
+	}
+
 	if (atomic_dec_and_test(&anon_vma->refcount)) {
 		/*
 		 * Oops, we held the last refcount, release the lock
-- 
2.42.0.515.g380fc7ccd1-goog

