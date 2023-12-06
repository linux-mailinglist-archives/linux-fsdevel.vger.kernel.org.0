Return-Path: <linux-fsdevel+bounces-4982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A51E806FE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A11C208B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97FC36AF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Z8Ojc3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A661C10C7
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:37:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d98fde753eso30557377b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 02:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701859028; x=1702463828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9XWOv5VjGfqn4Ye4rb6vL096BWUdHwApYaIgHelXwhw=;
        b=2Z8Ojc3+f1h+IDCp5TfrmeRF8GsigP5YQiSIY77l2jHvzg0Q/CSwgB8/u/W+SR0+SN
         AtBv7CX4I8zATdAILvO+i+uysAG2HJP9Kgxg1PgpxNm4g2NWOwKSX9S5i3ECOzCyB7KG
         Jpe9s3g8ZvsyrEhpE6jNB5PVMc/88Sa2/ItrmTsSEhdYsoh4EBaVyLFP3mpQgMridE5I
         on4mjyLL6IQlgpjQG0mG1dk5AdXC/BJr1Zr7snqx6RoDAm94qPB24kVBf/tySg4V+uew
         8Hq7QA00cieb7ItkltuI2Jd918dEv8PWWzFgwAhnwR/Z8T0QLuj+x/t4weatrcLu+Usi
         f+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859028; x=1702463828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XWOv5VjGfqn4Ye4rb6vL096BWUdHwApYaIgHelXwhw=;
        b=DOKt09gqmfqO0TcrTyg9lOhl7d5++rdjthNepfvWCfqaWs+B1i1iS0FeuR/occUZmv
         qpku2YN+DqYqlWKU41TaOJmg4TWxpcKzu18167qRBDElpBTpEwBTZo4of7cRU1IZwDCf
         iQ4VybuhFMeX4i31sMw/gw7rEgbQqecpzCxzY1D1d1nln94JtOWTLOHBo0Z+h76YIx8M
         KmIo6dYjkjMbmY986cn/kX89WoJ5RsWaO2YON+3EAPwCuXKr+nDeJP0nQj1cyboxYtfj
         zFV+CFUH42oZ1op52oBdHiOnMgOBLRga+w1xUDl1GuRGqo6DXwrSFxubPUshA3YzZrbu
         sbxA==
X-Gm-Message-State: AOJu0YyIgdA/qMXte5yJoa0zZWmVALKpzcbXwKvqNEE/MbFVhvebuNrS
	Qr0KEIVn7yRA95oTUGTz6t0VL5alfpQ=
X-Google-Smtp-Source: AGHT+IGCulkBJ+T0+9Lwp1vGAWeNFtPWyIYRPjeboNOQrA1z+wrU7Uo8XHJ4cQLDzSxZ9W28kHwF5PDUnGI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:73f6:b5e2:415:6ba5])
 (user=surenb job=sendgmr) by 2002:a25:7690:0:b0:db4:6936:48b7 with SMTP id
 r138-20020a257690000000b00db4693648b7mr5580ybc.2.1701859027736; Wed, 06 Dec
 2023 02:37:07 -0800 (PST)
Date: Wed,  6 Dec 2023 02:36:55 -0800
In-Reply-To: <20231206103702.3873743-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231206103702.3873743-2-surenb@google.com>
Subject: [PATCH v6 1/5] mm/rmap: support move to different root anon_vma in folio_move_anon_rmap()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
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
2.43.0.rc2.451.g8631bc7472-goog


