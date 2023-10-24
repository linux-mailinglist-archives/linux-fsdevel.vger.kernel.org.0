Return-Path: <linux-fsdevel+bounces-987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209F57D4A24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9391C20BD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016611732;
	Tue, 24 Oct 2023 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B94SZKzS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A143C24
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 08:33:18 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCA5A1
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so3271515b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136397; x=1698741197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MLK4HxQMsxrLAQzNmdHMtQCN++SQMztyyHR1MHkRQQ=;
        b=B94SZKzSqsawfuayEI/UehMSGtS4IxKFKCX0IwoUmRF+6j0ja4TTqt59k0u7TDRF1p
         v8R7VVFKp8LBp57ATeW2It8DKLS65pyhb/4rSN1Fuow/XilrMzprvcYO9Ib6AryUsYvt
         YNxAebFQw7nuEBiyji2mdf1YCtIejq8msAXlzACmiB0SxmPyLjHzQ+MhHyFxUncgRaNY
         ET7bPkppLatdrhxoRPCaGsHcAf3WK9yj1xKa7paPjkbbjhvUENO6mKi7Wn9+gnuaK01H
         k5wygUCn0Bb+cF+rTWWBJX3aTMOhgtQZfmuJc8fNMRgGXEcKy9AQYfv8VFC5ClTASV/b
         OPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136397; x=1698741197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MLK4HxQMsxrLAQzNmdHMtQCN++SQMztyyHR1MHkRQQ=;
        b=du6VyGSnEZknml77gFPHUiRd/7T2ytHK1dtVCszCo+WL18dU1X8JcJgrHVNgi1YC7w
         j+FZEq38I7ozU0ulsQNhEVNnne9SuZkbBzQmt11hNjvuks7kIFl0iqVp+117SlZuGFQJ
         bhF9yrUTgHF3DcIYPgO8mrTdAqVS0+XWKU+dz4cxOa1TlG15DtP/vNmMPidC6zWYhJs1
         PPuatX9KUX12Ry2siqJfbSM1RCV7Y4YsRQ8ihvOFYZW+dGgkcTU4pJxMZTkBirMmbdyO
         nr+fkCBK7QMzlQ+yIENVZeprWmmu2Cg8YJ1V52n14eRT3bW2l8AfMNFMcGnNZzhvr3lq
         Omag==
X-Gm-Message-State: AOJu0Yzt5vQjybwcfJdO08vF2+uiSlyg3gGUOZnQ5Z/w6pADJ1awLyj0
	SHO6Wc59ajWbOksrjE8zqTPtXQ==
X-Google-Smtp-Source: AGHT+IHB77N08kpQP3kK7g9QlYWTNYn9tfxBH6TdMNcz14U0iu/fhKvY168Jlzr+1CThhjfwCpOJUw==
X-Received: by 2002:a05:6a00:2292:b0:6bd:7cbd:15a2 with SMTP id f18-20020a056a00229200b006bd7cbd15a2mr10659966pfe.26.1698136397397;
        Tue, 24 Oct 2023 01:33:17 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.33.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:33:17 -0700 (PDT)
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
Subject: [PATCH v6 01/10] maple_tree: Add mt_free_one() and mt_attr() helpers
Date: Tue, 24 Oct 2023 16:32:49 +0800
Message-Id: <20231024083258.65750-2-zhangpeng.00@bytedance.com>
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

Add two helpers:
1. mt_free_one(), used to free a maple node.
2. mt_attr(), used to obtain the attributes of maple tree.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb24d84a4922..ca7039633844 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -165,6 +165,11 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
 	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
 }
 
+static inline void mt_free_one(struct maple_node *node)
+{
+	kmem_cache_free(maple_node_cache, node);
+}
+
 static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 {
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
@@ -205,6 +210,11 @@ static unsigned int mas_mt_height(struct ma_state *mas)
 	return mt_height(mas->tree);
 }
 
+static inline unsigned int mt_attr(struct maple_tree *mt)
+{
+	return mt->ma_flags & ~MT_FLAGS_HEIGHT_MASK;
+}
+
 static inline enum maple_type mte_node_type(const struct maple_enode *entry)
 {
 	return ((unsigned long)entry >> MAPLE_NODE_TYPE_SHIFT) &
@@ -5573,7 +5583,7 @@ void mas_destroy(struct ma_state *mas)
 			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
 			total -= count;
 		}
-		kmem_cache_free(maple_node_cache, node);
+		mt_free_one(ma_mnode_ptr(node));
 		total--;
 	}
 
-- 
2.20.1


