Return-Path: <linux-fsdevel+bounces-3324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153D47F34BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F44A1C20B0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D945A115;
	Tue, 21 Nov 2023 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSIvjtf7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4242DC1
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 09:16:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5caf61210e3so26255447b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 09:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700587009; x=1701191809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=He74YIcSIwOjGCEm7bMpO/TfFvRAcUHKo6jbQtwLQrs=;
        b=BSIvjtf7YoJbXznZ8LnCyXvILNcvkDvUcum+/teq0c+YIp8orZBaU6eMyJ8KzFzKTZ
         jY2sLFhHtP+WjSBQgS14EgfE9PxXK445diIgv0xqP4ELqx/lNyMFSOyB+/8y7BH/wsiP
         XRMlg2i7S80zbEFtEVKB4grC/+Yc8lODbua3ArpMoTIbvvfg8DVV0+h7XDfRT3umzd2D
         y8Fqes0KH7OW94OU4KBNo6uHziVHgidqwslwSh28eBuLjX70Rtm42Hdr76dpP+Bj+Ya1
         SbmQMGiPrdoHhzm0JsRGcitlDkPq6l+E7BWDtKueOpzepc0K+h8tUZwxcvQ/k/wWnbtN
         bstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700587009; x=1701191809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=He74YIcSIwOjGCEm7bMpO/TfFvRAcUHKo6jbQtwLQrs=;
        b=aUQ2urkKr3mm3mpwt/aRyEOgJPP7OXnzfSSu1yy1Sls4NZyS9adVMMqpNASTLX6RTw
         ukjvBR1I4SGR5kVhIbg5HYJt1gSk+9SCEquzrNmqDmy+11/5AA6C5DpT3+2y+R1RUyjd
         y3KSEHUi+t754HrnWn4tlBK1ahgVTiFys5OimfK3/MItTG1Lw2T6CkdTZHqnThp1Uy5T
         Ys2T2zvJeWcRQHJQruKd9r9rWYlQ37cBh9RFgktwAGJFLWReZWv8JSRG8D39cq/iiFqo
         SKjrYaX/0jR9c5DbCvbltQLmtBtKBygSRfpQBLABDcpjv295TW0xftHvYvqL9CVCH+xJ
         iqaA==
X-Gm-Message-State: AOJu0YwazBWZMtbolwmqfUsiawp5SbsRvj+c6ctEIBBm94kIlFVjJFUA
	rj1TyxlAaLpOJJ1K7p4kzgw04uSDA5Y=
X-Google-Smtp-Source: AGHT+IGyUrMT5Mj/g7lBAQcYKLbTTgQRTtXQcXK7X2hl+2vA5HYqDMy63skEG09MWnl+1v4a8CZ5k0TbKFY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:2045:f6d2:f01d:3fff])
 (user=surenb job=sendgmr) by 2002:a0d:fb03:0:b0:5c8:b756:f3af with SMTP id
 l3-20020a0dfb03000000b005c8b756f3afmr330699ywf.4.1700587009501; Tue, 21 Nov
 2023 09:16:49 -0800 (PST)
Date: Tue, 21 Nov 2023 09:16:34 -0800
In-Reply-To: <20231121171643.3719880-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231121171643.3719880-2-surenb@google.com>
Subject: [PATCH v5 1/5] mm/rmap: support move to different root anon_vma in folio_move_anon_rmap()
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
Acked-by: Peter Xu <peterx@redhat.com>
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
2.43.0.rc1.413.gea7ed67945-goog


