Return-Path: <linux-fsdevel+bounces-993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF897D4A3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D958B20FA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F0241F5;
	Tue, 24 Oct 2023 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GqvjHc99"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5423753
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 08:34:00 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35BFD68
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5a1d89ff4b9so2314195a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136436; x=1698741236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmT9t2gNl7JC/Wj/BeBLe/fYUtz3EaMSD0bTELVUlD4=;
        b=GqvjHc99IbEBZlveybU0D8fTBBlqe+5Ky0UCXDZB8PFwd279bHDMYd6DNStGBbmDYj
         ZrF/X5gQG3+6FzoP+wo6/xV+JHpxmEVyFE/bEp5FlnONxxEArr8+kVhdgW6brSJdenIc
         rW3fn0k6u9xzNZJQuCfokK9CMcg+LzehC2U6+Rnq6+97/iB8CKp+vYDsQDzvwpJOLMOK
         x9axsO7Bj0h7Qd5rjO9oW3CQVyvmNFRhqhcONU818lCuH7DkZswcSOL+lib8Zy33LKI3
         dMjmrg6dEawPdgMnDNO0ezM0C20fT2vrXjVCQ/ElhZpQc0LbBrg6MmtMQutR1LgExcSM
         4dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136436; x=1698741236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmT9t2gNl7JC/Wj/BeBLe/fYUtz3EaMSD0bTELVUlD4=;
        b=BlT8c3L8jnHPhgydTbSw9KVXj6vSVrnrImZknfj+qgp8weFqkd4OkOPgaJa08YNfCs
         hZ+EjdW0t2A82JwE2hZWDC+8kedotDFPtT4ghANeijYErL3M+oBHky8y/O2d7LFW7E6M
         erDz0huYRImlZSh+Vs7zSMfDZ2qcecwSLriuwOChKEgDiTopgNFJcGYkYC5cwHGly1dJ
         p8HPA5/sBQuDpLdBmJp+ustDlfb5mKUmXSn+tvYEG5XV9EdhtAG3edyiQn0M4sxbJmXB
         v6qJDSEJ5D3jmVFsksKAsymtqe5gAtCTm249RTh0M6JcBypbvoFjcf5mI9jPfiaYD9ES
         gesQ==
X-Gm-Message-State: AOJu0YyFFMlBqICX4vDUfVb6onWiYV076YHjSbvO2Gg7Fj8fsXYAx7fV
	h26jgtVWFWKc7IaXTqpVegC6Xg==
X-Google-Smtp-Source: AGHT+IF878eTLhy6MBaFtUQubSuP7YPQ3APPj4js3z/kylyjvhAgv4iCwOSuEsZvOnsr4GHMJn44lw==
X-Received: by 2002:a05:6a20:6a28:b0:161:28e0:9abd with SMTP id p40-20020a056a206a2800b0016128e09abdmr2218020pzk.16.1698136436387;
        Tue, 24 Oct 2023 01:33:56 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.33.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:33:56 -0700 (PDT)
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
Subject: [PATCH v6 07/10] maple_tree: Skip other tests when BENCH is enabled
Date: Tue, 24 Oct 2023 16:32:55 +0800
Message-Id: <20231024083258.65750-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


