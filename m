Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857AC1893C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 02:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgCRBnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 21:43:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33619 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCRBnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:43:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id d22so19441740qtn.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2020 18:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adfBoclYKVZNMNefhSpixH6B98UG3x3vyleViU9e6t0=;
        b=tsA75bvNsVxlydE50EtN3v3OV43jLUZwBeqU7K9f4CJgdny+lloa8g8Ai3CcaLbxVj
         XQFVCtUY+yTbJGV7t6u6vdYlw1NrMdxKzI2b/VrwWKJ9FiMGUj62BqpmOy4bWuSbnLNQ
         Xw4Pj7IdhlFn6Gp/RlPuNp+bamLXdGS1Wx1SXB4rxRcxKdTU4PWpos/KmtXwsgPOgkHW
         d5etZGwMaclJi2PH5BM+JfxAHBxa0dbNKnzNHQWJIh4PPsZATsvH09l/vkQUuOyAy9LB
         c2hmVyINrHQSWbnXSB0clhCwlASTy7ZvaXIjND9IM16bO28/37vuq4tF0IK550VPgQ1v
         z9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adfBoclYKVZNMNefhSpixH6B98UG3x3vyleViU9e6t0=;
        b=hEBI2Fyag6MZWmLFQv2yACAYxRmh6UYOu7i/J4TstdLZThb7vexg2RUHNT4NdQsjAJ
         AJ2NR33LaYxIqEwh81U0fe4VOKAndsZXB0uLyUzY8K3I+SGfHnjJUsVkskAIKTDRysRC
         wJmlYme+OyVih3UImiEzBpJqIm0EzwhpiYXPsGsdFBi3bVQQyqwb5cgXeOd3qx+mdAn+
         +sfHbhTM0dIUL9c1yfUHwSTUmbOLAT/i1eYjYL2xaJddoDn5KcybeW8+dntF/7IcbPuw
         7X8TbKqJF9o4NiwHyffp8F5JbMRqhMmzeYl4fX3N4OXXl3Kv/Ys/8yIbAT2xmXq6HZHr
         oZeA==
X-Gm-Message-State: ANhLgQ1ZUVQ2Plad5haXhlxpJ3u3BOcioOUHv0YmviWISKEFsfaaGSj3
        fnPLHdjtizV/AYGIZlbapyMBcg==
X-Google-Smtp-Source: ADFU+vsvOxgc6z2IjrWovw/hSbhdYVegvhWE7xjTOoafRhx9mCRw45z1VgMOMz3Vo9eqSmJZfdnEjg==
X-Received: by 2002:aed:314c:: with SMTP id 70mr2006023qtg.334.1584495788809;
        Tue, 17 Mar 2020 18:43:08 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id m1sm3740883qtm.22.2020.03.17.18.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 18:43:08 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH 1/2] xarray: Add identifier names for function definition arguments
Date:   Tue, 17 Mar 2020 22:43:02 -0300
Message-Id: <f75ffec5b2d1a2e3f6ba9151732fb37cc2bed040.1584494902.git.vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1584494902.git.vitor@massaru.org>
References: <cover.1584494902.git.vitor@massaru.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix several checkpatch warnings such as:

WARNING: function definition argument 'struct xarray *' should also have an identifier name
+void *xa_load(struct xarray *, unsigned long index);

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 include/linux/xarray.h | 87 +++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index f73e1775ded0..a7dec1ec0967 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -344,21 +344,21 @@ struct xarray {
  */
 #define DEFINE_XARRAY_ALLOC1(name) DEFINE_XARRAY_FLAGS(name, XA_FLAGS_ALLOC1)
 
-void *xa_load(struct xarray *, unsigned long index);
-void *xa_store(struct xarray *, unsigned long index, void *entry, gfp_t);
-void *xa_erase(struct xarray *, unsigned long index);
-void *xa_store_range(struct xarray *, unsigned long first, unsigned long last,
-			void *entry, gfp_t);
-bool xa_get_mark(struct xarray *, unsigned long index, xa_mark_t);
-void xa_set_mark(struct xarray *, unsigned long index, xa_mark_t);
-void xa_clear_mark(struct xarray *, unsigned long index, xa_mark_t);
-void *xa_find(struct xarray *xa, unsigned long *index,
-		unsigned long max, xa_mark_t) __attribute__((nonnull(2)));
-void *xa_find_after(struct xarray *xa, unsigned long *index,
-		unsigned long max, xa_mark_t) __attribute__((nonnull(2)));
-unsigned int xa_extract(struct xarray *, void **dst, unsigned long start,
-		unsigned long max, unsigned int n, xa_mark_t);
-void xa_destroy(struct xarray *);
+void *xa_load(struct xarray *xa, unsigned long index);
+void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp);
+void *xa_erase(struct xarray *xa, unsigned long index);
+void *xa_store_range(struct xarray *xa, unsigned long first, unsigned long last,
+			void *entry, gfp_t gfp);
+bool xa_get_mark(struct xarray *xa, unsigned long index, xa_mark_t mark);
+void xa_set_mark(struct xarray *xa, unsigned long index, xa_mark_t mark);
+void xa_clear_mark(struct xarray *xa, unsigned long index, xa_mark_t mark);
+void *xa_find(struct xarray *xa, unsigned long *index, unsigned long max,
+		 xa_mark_t filter) __attribute__((nonnull(2)));
+void *xa_find_after(struct xarray *xa, unsigned long *index, unsigned long max,
+			xa_mark_t filter) __attribute__((nonnull(2)));
+unsigned int xa_extract(struct xarray *xa, void **dst, unsigned long start,
+		unsigned long max, unsigned int n, xa_mark_t filter);
+void xa_destroy(struct xarray *xa);
 
 /**
  * xa_init_flags() - Initialise an empty XArray with flags.
@@ -551,18 +551,19 @@ static inline bool xa_marked(const struct xarray *xa, xa_mark_t mark)
  * may also re-enable interrupts if the XArray flags indicate the
  * locking should be interrupt safe.
  */
-void *__xa_erase(struct xarray *, unsigned long index);
-void *__xa_store(struct xarray *, unsigned long index, void *entry, gfp_t);
-void *__xa_cmpxchg(struct xarray *, unsigned long index, void *old,
-		void *entry, gfp_t);
-int __must_check __xa_insert(struct xarray *, unsigned long index,
-		void *entry, gfp_t);
-int __must_check __xa_alloc(struct xarray *, u32 *id, void *entry,
-		struct xa_limit, gfp_t);
-int __must_check __xa_alloc_cyclic(struct xarray *, u32 *id, void *entry,
-		struct xa_limit, u32 *next, gfp_t);
-void __xa_set_mark(struct xarray *, unsigned long index, xa_mark_t);
-void __xa_clear_mark(struct xarray *, unsigned long index, xa_mark_t);
+void *__xa_erase(struct xarray *xa, unsigned long index);
+void *__xa_store(struct xarray *xa, unsigned long index,
+		void *entry, gfp_t gfp);
+void *__xa_cmpxchg(struct xarray *xa, unsigned long index, void *old,
+		void *entry, gfp_t gfp);
+int __must_check __xa_insert(struct xarray *xa, unsigned long index,
+		void *entry, gfp_t gfp);
+int __must_check __xa_alloc(struct xarray *xa, u32 *id, void *entry,
+		struct xa_limit limit, gfp_t gfp);
+int __must_check __xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
+		struct xa_limit limit, u32 *next, gfp_t gfp);
+void __xa_set_mark(struct xarray *xa, unsigned long index, xa_mark_t mark);
+void __xa_clear_mark(struct xarray *xa, unsigned long index, xa_mark_t mark);
 
 /**
  * xa_store_bh() - Store this entry in the XArray.
@@ -1137,8 +1138,8 @@ struct xa_node {
 	};
 };
 
-void xa_dump(const struct xarray *);
-void xa_dump_node(const struct xa_node *);
+void xa_dump(const struct xarray *xa);
+void xa_dump_node(const struct xa_node *node);
 
 #ifdef XA_DEBUG
 #define XA_BUG_ON(xa, x) do {					\
@@ -1489,21 +1490,21 @@ static inline bool xas_retry(struct xa_state *xas, const void *entry)
 	return true;
 }
 
-void *xas_load(struct xa_state *);
-void *xas_store(struct xa_state *, void *entry);
-void *xas_find(struct xa_state *, unsigned long max);
-void *xas_find_conflict(struct xa_state *);
+void *xas_load(struct xa_state *xas);
+void *xas_store(struct xa_state *xas, void *entry);
+void *xas_find(struct xa_state *xas, unsigned long max);
+void *xas_find_conflict(struct xa_state *xas);
 
-bool xas_get_mark(const struct xa_state *, xa_mark_t);
-void xas_set_mark(const struct xa_state *, xa_mark_t);
-void xas_clear_mark(const struct xa_state *, xa_mark_t);
-void *xas_find_marked(struct xa_state *, unsigned long max, xa_mark_t);
-void xas_init_marks(const struct xa_state *);
+bool xas_get_mark(const struct xa_state *xas, xa_mark_t mark);
+void xas_set_mark(const struct xa_state *xas, xa_mark_t mark);
+void xas_clear_mark(const struct xa_state *xas, xa_mark_t mark);
+void *xas_find_marked(struct xa_state *xas, unsigned long max, xa_mark_t mark);
+void xas_init_marks(const struct xa_state *xas);
 
-bool xas_nomem(struct xa_state *, gfp_t);
-void xas_pause(struct xa_state *);
+bool xas_nomem(struct xa_state *xas, gfp_t gfp);
+void xas_pause(struct xa_state *xas);
 
-void xas_create_range(struct xa_state *);
+void xas_create_range(struct xa_state *xas);
 
 /**
  * xas_reload() - Refetch an entry from the xarray.
@@ -1721,8 +1722,8 @@ enum {
 #define xas_for_each_conflict(xas, entry) \
 	while ((entry = xas_find_conflict(xas)))
 
-void *__xas_next(struct xa_state *);
-void *__xas_prev(struct xa_state *);
+void *__xas_next(struct xa_state *xas);
+void *__xas_prev(struct xa_state *xas);
 
 /**
  * xas_prev() - Move iterator to previous index.
-- 
2.21.1

