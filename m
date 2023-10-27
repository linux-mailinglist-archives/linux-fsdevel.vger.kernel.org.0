Return-Path: <linux-fsdevel+bounces-1285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847597D8D96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 05:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA0028229C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 03:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6604423;
	Fri, 27 Oct 2023 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DDk4A7es"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A3440F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 03:40:15 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98404D4E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 20:40:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d104fa285so1350555a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 20:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698378008; x=1698982808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/TBSsqo/3PZG//kKjzBxqBhIhs+Qitm7vuazfD4aPI=;
        b=DDk4A7esaWB+86LNddvgqDFGUgvg28BtPxHclNVDfMg4e3q3fLwhP8/DGVObzZieaI
         /w7z3IrEiny0Z7GMRYS8WS6hhYXYzf6WkejXu8aJ5lzWacs4Vy8El4yX25hSWNC6YvwS
         utVcdaYgeReeIEfM8FE0CoUc1jCAvOpDQnw1aFpsakX6dkxB4mzjkBlghN/1ltsZPjDI
         If5DLS0+Jc+ER+3Swkg8YwzyumXanbouv4Q0BdgXJwIdtGdM0yDKBZWJLq8lEbVX3O7f
         MHODGKbBPvnAGdAVBqwrqNLi402k7beZvvnCiq6/BktDFqiId6l3XWX8sJU82Tub/OWq
         1SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698378008; x=1698982808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/TBSsqo/3PZG//kKjzBxqBhIhs+Qitm7vuazfD4aPI=;
        b=O/40cmJSoRVISsL+JMDH9nAY1cYbdQ/AszNXQnZ7QZFQ1gUDttG4kaJlEjWuEQlQro
         lzZ7rtdVz4RNsFIfohmgk26XJY7FjurLkM6tI/lkDZFJrSHR4ALCy7nRsQiIQ9l3LxnI
         S6U2FnKunYAqmOXB6zJcD1U77TDCN9UfwcGneSj2RAEuh88WPGFf/OMXNnxCvHiEIi0U
         sEqBqmrzoHRaMvNKrloZcnMnqxasAjF4EnMFnx3Gcahr+o2G4lT54BDou2Us/iB1quwD
         eu90PTPWpJvnXpup5nkg1VBzLpkJAk1VIk+EJ3LWhZ3ugg4jtWuQY/Z9Qea+YpDKMQw0
         Y9sQ==
X-Gm-Message-State: AOJu0YzWsxKeXsXSIeNArXdBzmN0xWi4/o9qPtJQkLt9qztNuoy4Xe/3
	RFT2iR0gK6//CzEZxXQt1QzabA==
X-Google-Smtp-Source: AGHT+IExlg2G7fYOUnFWtBHLrBsW1lyYgFaUWIXf6NstZ6E0c++iEGcYR48s2/F7tPuX752NBLahNg==
X-Received: by 2002:a17:90b:18e:b0:27d:2663:c5f4 with SMTP id t14-20020a17090b018e00b0027d2663c5f4mr1538778pjs.47.1698378008501;
        Thu, 26 Oct 2023 20:40:08 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00267d9f4d340sm2345676pjb.44.2023.10.26.20.40.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Oct 2023 20:40:08 -0700 (PDT)
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
Subject: [PATCH v7 09/10] maple_tree: Preserve the tree attributes when destroying maple tree
Date: Fri, 27 Oct 2023 11:38:44 +0800
Message-Id: <20231027033845.90608-10-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
References: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When destroying maple tree, preserve its attributes and then turn it
into an empty tree. This allows it to be reused without needing to be
reinitialized.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 718a222cc090..4439469442c7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6763,7 +6763,7 @@ void __mt_destroy(struct maple_tree *mt)
 	if (xa_is_node(root))
 		mte_destroy_walk(root, mt);
 
-	mt->ma_flags = 0;
+	mt->ma_flags = mt_attr(mt);
 }
 EXPORT_SYMBOL_GPL(__mt_destroy);
 
-- 
2.20.1


