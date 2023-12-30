Return-Path: <linux-fsdevel+bounces-7030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4C820366
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 03:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6AE282193
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 02:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3AB10F7;
	Sat, 30 Dec 2023 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qel/S75D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C01843
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Dec 2023 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5d064f9e2a1so99484457b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Dec 2023 18:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703904971; x=1704509771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rx3xKuaGL8HWrRRVUoZvzccCFnr0zto7mWLIM9ls3L0=;
        b=Qel/S75DOdqITLXV/a6AJCG7SwRIIK5gtXS9EFvmWXhuy4iQzES6UqT9nImfBvJ1Am
         lwZYTx/V/lXyvkVeHn0AJGmlPWs5ZfpNYhvUY0x2zbuxJYoxRr5PcKjmFfeeQYrnCdSM
         Xan3gIDbivRTuDYRegFYQXB8OMRqH2O0Wz/mLaApt89RPdLnkVc4aeVUoDb9oUXTojTU
         510lvSk1btjP0Yy6iA5Bt7OfNmFTaS1AHZrEy0pGRN64E2Y5XdAyAtnXDSNW2qiUAH8a
         qfgk+THvTANiWWZAjjGhf+3ZacEaIKM2Af15BKa9bbZXtuyW/SqGgfhtA0y0RLle2XCG
         nEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703904971; x=1704509771;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rx3xKuaGL8HWrRRVUoZvzccCFnr0zto7mWLIM9ls3L0=;
        b=U04v5IqZT007aSsa3lfugz6OdB6PiCp2rH1AqZdEVSBhQFClG3edIH1lPfHfjMZdhf
         T9kj48FDYoSTBzHBmfU4mAFSGqdbYsq9OryRIjcYgmdSCDtsNR/vQ1LSf0c4ZSUGkAUF
         oOyrILESm5Bn1mHAFkw/TbtHMZCe3aaSpg8boW0e/9aUjyUKSk3OkR3nR5sXFVqMdpXY
         rw1pj49kekz/d3emJvxTq5P//WyrzmYYS73cnxQ8eaC3z02gDoVq8sW9GRE6yB+aU8Eu
         8WiIbr5iaiMbmuOY4cxJ6B01iUpeqSZQVvN92hUpnACM+DHq2AD4q8SSKy9gN1zSx+bC
         se1g==
X-Gm-Message-State: AOJu0Ywb6Vpe1L1Q45TyScZYHLGHud1arBhxYk3TweS8gq8B1u17cAdG
	q5AqXxAMgoAYA6zyQpD5v19shOca+yDnteo7ow==
X-Google-Smtp-Source: AGHT+IEa0V0G+LZdy2Xqpj9r4ydRhq229LLnwM8al0ZDxIMrbdtDuGldtaNSDvCbTs1jv2oUX2fZyzvUP58=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:aa12:a8e:81ce:b04d])
 (user=surenb job=sendgmr) by 2002:a5b:8d2:0:b0:dbe:269d:13f4 with SMTP id
 w18-20020a5b08d2000000b00dbe269d13f4mr219681ybq.0.1703904971448; Fri, 29 Dec
 2023 18:56:11 -0800 (PST)
Date: Fri, 29 Dec 2023 18:56:07 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231230025607.2476912-1-surenb@google.com>
Subject: [PATCH 1/1] userfaultfd: fix move_pages_pte() splitting folio under
 RCU read lock
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

While testing the split PMD path with lockdep enabled I've got an
"Invalid wait context" error caused by split_huge_page_to_list() trying
to lock anon_vma->rwsem while inside RCU read section. The issues is due
to move_pages_pte() calling split_folio() under RCU read lock. Fix this
by unmapping the PTEs and exiting RCU read section before splitting the
folio and then retrying. The same retry pattern is used when locking the
folio or anon_vma in this function.

Fixes: 94b01c885131 ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Patch applies over mm-unstable.
Please note that the SHA in Fixes tag is unstable.

 mm/userfaultfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5e718014e671..71393410e028 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1078,9 +1078,14 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 
 		/* at this point we have src_folio locked */
 		if (folio_test_large(src_folio)) {
+			/* split_folio() can block */
+			pte_unmap(&orig_src_pte);
+			pte_unmap(&orig_dst_pte);
+			src_pte = dst_pte = NULL;
 			err = split_folio(src_folio);
 			if (err)
 				goto out;
+			goto retry;
 		}
 
 		if (!src_anon_vma) {
-- 
2.43.0.472.g3155946c3a-goog


