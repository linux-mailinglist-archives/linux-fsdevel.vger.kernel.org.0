Return-Path: <linux-fsdevel+bounces-1040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7E77D523A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD031C20BC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0E2B5D0;
	Tue, 24 Oct 2023 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1XFbROdL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34E2B5E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:46:51 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F9910D1
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d99ec34829aso5168218276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155208; x=1698760008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWOhaEKA8zMI+Iz0e6SkNPW5Kz551oWdhyAlPdtU984=;
        b=1XFbROdLiVVoN5uydLx7JI2SMR4wMa5dO4rGWCS3ucWQUgp7xD3Uzyga3UuvTJbPjm
         Fb+47YRq/bMpaN3E/eB5AwNie/G70xGjaCjNyWrqPmTvDb2rkdtqc3uQf9aQ1gnWUCjE
         QKxrw0Y/wn10DXzumW7IxBG4cDEADZzN9KbaQ2FIv5UWBdI2dOrlwWecw0OGsFRf5QxF
         jeq5BqGdkGUNO4rLanTanR8I/vNGHzjj8gUjKziIlqqh5dw4TEW7wdaqzxfbAp8TzWnI
         UHPJiV1xnBqRqC5VWZUmCosAbA2hlohjCCpOUUSjvso+AnyYb/QCZBMR7VbscOR7liFR
         qgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155208; x=1698760008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWOhaEKA8zMI+Iz0e6SkNPW5Kz551oWdhyAlPdtU984=;
        b=ly/yw7k3tWHf5LPN/uEALZWUIwCvX3LFSupRH+vEc0taTALYknyhngKBnQiPFUx7Sl
         Jhg5W/3edKVbwrMj0MJQmbnsDIDAsWqxaDW6JyO7BYLUfB/wKU6BEdcaPRtXijiKUlQp
         affNwzv7H0u2wpoGm9+sO6Uq98u2Wa959L5WvmWodNELDy8+TQKZqb3kVMIwWBpBuPsQ
         0mtExx9+44C/vIwsZNma52tKzHsY12/hS3DtQZ+xClr06Idr7kqrA5ljxTj7yIjwjTpa
         VCggl3dYUSkL0BDq5XHAmNAYCkHT85tLdYkKhfFklBpeSuqNBLlt1k6niER7ORKccF6G
         rcyQ==
X-Gm-Message-State: AOJu0Yww1JL0lrgad92EkYcSbf+AQA4KdjUr6WtNseMrdPnngWS5WnA2
	6THOx1z4XZ/Q38+WoOSiXwjf9U8uxTA=
X-Google-Smtp-Source: AGHT+IGS8NlUfJRUa0CiIFG8N+DG1BCVzQogfv9Ui1pQm5p1SwS7Eeeej+mjL+3fA2TwJ+bOdBMbqGXulW0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:b951:0:b0:da0:1ba4:6fa2 with SMTP id
 s17-20020a25b951000000b00da01ba46fa2mr82321ybm.4.1698155208197; Tue, 24 Oct
 2023 06:46:48 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:00 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-4-surenb@google.com>
Subject: [PATCH v2 03/39] fs: Convert alloc_inode_sb() to a macro
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

We're introducing alloc tagging, which tracks memory allocations by
callsite. Converting alloc_inode_sb() to a macro means allocations will
be tracked by its caller, which is a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 include/linux/fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4a40823c3c67..c545b1839e96 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2862,11 +2862,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
  * This must be used for allocating filesystems specific inodes to set
  * up the inode reclaim context correctly.
  */
-static inline void *
-alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
-{
-	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
-}
+#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
-- 
2.42.0.758.gaed0368e0e-goog


