Return-Path: <linux-fsdevel+bounces-374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9B7C9DC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 05:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C213B20BDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 03:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593712B8D;
	Mon, 16 Oct 2023 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PGqbqWCd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7AB11C89
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 03:23:37 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED3F4
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b709048f32so1385863b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426608; x=1698031408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmT9t2gNl7JC/Wj/BeBLe/fYUtz3EaMSD0bTELVUlD4=;
        b=PGqbqWCdExRsioHDuhcF8pwe4rhDYhMiyYzpENET4J8HssE32sg5UT+tPIiLfnGHSS
         qf5Ubjwg/btvdCzgY0RRW/5jmsfBXJH9o9xjijTkWbq42NA2/cT4SrAPyXQRlbIVg7oS
         XvbYUpObqP0jpqdiZiVGQ8fIl1mz6hBbtDP2ZMx1buFYCrN86DV/YjDgbWxTCR6/SV7u
         oaTYx/mnAOs0+xlSlBaZeq2jwDTccLFbG6m7SmXayyZWkcwP1Vh2l5OWqYsVXYCeAsxX
         YZEzL77M++I5C9xdMppQ1ViLBU4TPbLQFGa9y1qc9B+rzSkMZ++Lo7NSaqKYRp7qmcjw
         bA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426608; x=1698031408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmT9t2gNl7JC/Wj/BeBLe/fYUtz3EaMSD0bTELVUlD4=;
        b=n7wEH6ZPBBmnUomUXVH0Czykzs/eT1XeZTeR48QNcCsJXPJrmoL8duPoW7s6pO0KBo
         Z5Oyf3fDOyjyGydC+YZ0elR6GkMlkMLCN374ZsVGcir+nx7eMJqRAKlxo6X/MODTyPg+
         t4jPDc00XU5osyc34+RQVhZv++lLsWAYeqwjkUnIzoPBHfZ2DJcQ7Vtp5nhrL73IQ7k2
         YjeaaQ1rH5ue5DQNctbZok3S6kSowKbhMv/dD7dOykdzvQhYuZqQBGJ4fbQtMpm3dliv
         TvzbRsbNxuC+UHbER3cgwy5Er/5nDjitYSeIVgzKXxWWVKpnkRfMMy1i3qx7CdzNGPXD
         faWw==
X-Gm-Message-State: AOJu0YxOWEtlP8e80p4vfCVJm1Sm5+Q8d6xrTHXzvmDPwpoHm4Ty74y7
	wyZEVRPhIo3gekYMTAyWdQ62dQ==
X-Google-Smtp-Source: AGHT+IFvL4hHx8r3LC1uMkvj+QBP/kQF+gthm2OJTyOv0wHL/s0lrpx6RI7lgcxm3OD63XtqW60qEg==
X-Received: by 2002:a05:6a21:a58b:b0:15d:607b:5a39 with SMTP id gd11-20020a056a21a58b00b0015d607b5a39mr34613164pzc.30.1697426608596;
        Sun, 15 Oct 2023 20:23:28 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ae28800b0027758c7f585sm3452770pjz.52.2023.10.15.20.23.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Oct 2023 20:23:28 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: Liam.Howlett@oracle.com,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	willy@infradead.org,
	brauner@kernel.org,
	surenb@google.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	oliver.sang@intel.com,
	mst@redhat.com
Cc: zhangpeng.00@bytedance.com,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 07/10] maple_tree: Skip other tests when BENCH is enabled
Date: Mon, 16 Oct 2023 11:22:23 +0800
Message-Id: <20231016032226.59199-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Skip other tests when BENCH is enabled so that performance can be
measured in user space.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c            | 8 ++++----
 tools/testing/radix-tree/maple.c | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 464eeb90d5ad..de470950714f 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3585,10 +3585,6 @@ static int __init maple_tree_seed(void)
 
 	pr_info("\nTEST STARTING\n\n");
 
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	check_root_expand(&tree);
-	mtree_destroy(&tree);
-
 #if defined(BENCH_SLOT_STORE)
 #define BENCH
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
@@ -3646,6 +3642,10 @@ static int __init maple_tree_seed(void)
 	goto skip;
 #endif
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_root_expand(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_iteration(&tree);
 	mtree_destroy(&tree);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 12b3390e9591..cb5358674521 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36299,7 +36299,9 @@ void farmer_tests(void)
 
 void maple_tree_tests(void)
 {
+#if !defined(BENCH)
 	farmer_tests();
+#endif
 	maple_tree_seed();
 	maple_tree_harvest();
 }
-- 
2.20.1


