Return-Path: <linux-fsdevel+bounces-1464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B9D7DA468
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 02:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A2A1C211C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 00:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD7441A;
	Sat, 28 Oct 2023 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0WMvlORC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96A2912
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 00:38:27 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AFE1BE
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 17:38:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cfdacf8fso35201007b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 17:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698453505; x=1699058305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd9WkLbC3/9tKbDr398vMG9sjKzgB6769/dIszrNtnA=;
        b=0WMvlORCh5eNdKteXyjztoAPal+jeVc94WtxFTyTPkacbGB6Uy7qO0oopPVCMS9Kd1
         R6uAt5fpwgyCJTj6v7zu5LWroSrxw7hWH7F/AskFMri4nDXpZkTWBMaZW5AVkZQ0Eb9T
         jaDFBOuWJSii9w/2Cm/unGNPKIB8qRnOenqt+O5DWva8wHHvYiCmxo9awZtx1LPi3Apq
         LPrhLrbJ/r3UdBs9s+lelrfO58TjmSAnP3SWoou9mSBNB5lEebCs5TllNteyXojSprgu
         a6rNx+UM8kpYJMO1nM1Ty7iSYJGeNOx5rsG217WxbZEvhhW1P2LLKscvERjDHj3XKy3G
         /+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698453505; x=1699058305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd9WkLbC3/9tKbDr398vMG9sjKzgB6769/dIszrNtnA=;
        b=XNQWj9wpLOGZ/XL1mhwnkprtvrjJdOh6xWjFQQrz1bEnBRv/KCo14M2okKzpv9AicY
         HNJe+M7awF4eLK17gU0LTJ5NLkPTb7WVOLWAqYrYLMdGAxVKCTNdexFiqOKsDpsNHmAG
         ys8NAgsxdPUAxilRs+VX4UZBlGXb/K3tHB8gx0VdXyba1xEETel5hWEeM4jhpp/6o+sC
         NyCz1VUuGBFN3p7NvX4EyqSiponAClKd9+2ZjGhayJuPlR/ZsRUBU0Yl4lZjYbNUkvWl
         RnkTZJN1fTW1N9ZOvvm+FdXy0PrGfxnxczmF3UDyKsJqJhUOWzFpzgunVWN9RdEgmbvC
         iBxg==
X-Gm-Message-State: AOJu0YxTWJ959pw+mfzbbz/p4bM06Up5sZ0V8T+Lb+kIXSvzexrfZAE0
	/xdrz3CD/wB/8909W9g1ov6CNsT+644=
X-Google-Smtp-Source: AGHT+IEhFUjmYdEXljORLOc7MoR1TUT63j0H8MtfIU3FFKJvRVJyyGkKkhRak6IgKRfrZGiSU7tVlIjlryE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cba3:7e7f:79e4:fa57])
 (user=surenb job=sendgmr) by 2002:a81:7648:0:b0:59b:b0b1:d75a with SMTP id
 j8-20020a817648000000b0059bb0b1d75amr194570ywk.4.1698453504908; Fri, 27 Oct
 2023 17:38:24 -0700 (PDT)
Date: Fri, 27 Oct 2023 17:38:11 -0700
In-Reply-To: <20231028003819.652322-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231028003819.652322-2-surenb@google.com>
Subject: [PATCH v4 1/5] mm/rmap: support move to different root anon_vma in folio_move_anon_rmap()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	surenb@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

From: Andrea Arcangeli <aarcange@redhat.com>

For now, folio_move_anon_rmap() was only used to move a folio to a
different anon_vma after fork(), whereby the root anon_vma stayed
unchanged. For that, it was sufficient to hold the folio lock when
calling folio_move_anon_rmap().

However, we want to make use of folio_move_anon_rmap() to move folios
between VMAs that have a different root anon_vma. As folio_referenced()
performs an RMAP walk without holding the folio lock but only holding the
anon_vma in read mode, holding the folio lock is insufficient.

When moving to an anon_vma with a different root anon_vma, we'll have to
hold both, the folio lock and the anon_vma lock in write mode.
Consequently, whenever we succeeded in folio_lock_anon_vma_read() to
read-lock the anon_vma, we have to re-check if the mapping was changed
in the meantime. If that was the case, we have to retry.

Note that folio_move_anon_rmap() must only be called if the anon page is
exclusive to a process, and must not be called on KSM folios.

This is a preparation for UFFDIO_MOVE, which will hold the folio lock,
the anon_vma lock in write mode, and the mmap_lock in read mode.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/rmap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 7a27a2b41802..525c5bc0b0b3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -542,6 +542,7 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	struct anon_vma *root_anon_vma;
 	unsigned long anon_mapping;
 
+retry:
 	rcu_read_lock();
 	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
 	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
@@ -552,6 +553,17 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
 	root_anon_vma = READ_ONCE(anon_vma->root);
 	if (down_read_trylock(&root_anon_vma->rwsem)) {
+		/*
+		 * folio_move_anon_rmap() might have changed the anon_vma as we
+		 * might not hold the folio lock here.
+		 */
+		if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
+			     anon_mapping)) {
+			up_read(&root_anon_vma->rwsem);
+			rcu_read_unlock();
+			goto retry;
+		}
+
 		/*
 		 * If the folio is still mapped, then this anon_vma is still
 		 * its anon_vma, and holding the mutex ensures that it will
@@ -586,6 +598,18 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	rcu_read_unlock();
 	anon_vma_lock_read(anon_vma);
 
+	/*
+	 * folio_move_anon_rmap() might have changed the anon_vma as we might
+	 * not hold the folio lock here.
+	 */
+	if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
+		     anon_mapping)) {
+		anon_vma_unlock_read(anon_vma);
+		put_anon_vma(anon_vma);
+		anon_vma = NULL;
+		goto retry;
+	}
+
 	if (atomic_dec_and_test(&anon_vma->refcount)) {
 		/*
 		 * Oops, we held the last refcount, release the lock
-- 
2.42.0.820.g83a721a137-goog


