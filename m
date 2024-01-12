Return-Path: <linux-fsdevel+bounces-7890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5403B82C68D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 22:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB88FB21E18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5393C1772D;
	Fri, 12 Jan 2024 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioa98WZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3EE171A7;
	Fri, 12 Jan 2024 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-5f0c0ca5ef1so72855767b3.2;
        Fri, 12 Jan 2024 13:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705093722; x=1705698522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4S+35DUquzzrJ5+7T5okVgy43cWVNAQAsJj4jjuv6Q=;
        b=ioa98WZ8Va4tuP4VB2zzqAdvzx/JQBMAlrQjWCPkane+eTEcT8GZthOyRXUgDwdwTA
         tO+pMG86sXtcpeUeTunnNHce9p3hCgHibr8W9IWdKyxDtEKgaQeWS2V3eqIaioZOpMr+
         uOu2h4Kg55Hr+aS5x2jn7itAqKFI7O5Wk9XLukOntpl6e7rzbbH2tH7fA7BJQ3kolE3L
         YeJtYYVs6m+foR2o5gwFCIMvUvIrq12aOoejVWCGMAAj6jckHyuR/4ZRMmZaXzZzi0ry
         BDsoSZGVvMOzwxYJ4AOM9ciglInnzJSlkJbZl675rHTzOYSodaiglwHznGOXepCuIVVr
         OHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705093722; x=1705698522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4S+35DUquzzrJ5+7T5okVgy43cWVNAQAsJj4jjuv6Q=;
        b=X5e2UU8/vA3JyWvFKr899BwYhBcqixTiJA9zJgkcdY0vN320k6a9rH00rNd5NaQI9v
         T9potOSm1SJNjOuqoYgXUmfeIewIdaKOLs56ElckfZgN2bSy0elmKsk+zV2IRigCvd1P
         4RQcPVxlgtXVqeNZneMfmlEIZs/9+MxgoWK319ELbtnzsoJuKKhLLcrFqNw6U9TC3LzE
         7FEq5munLYzPvqkHELXCKAULr/lfEZiNmlqmz4ST0qc69EosQ8uQeC31fyvvo/KyNABu
         cjPwkYtmr8BioeTPSqlSrZ7Lo9R6YO1wPrFp8CKWC4aAVidaUAuksUFPzbE27TXPVJWH
         b6FA==
X-Gm-Message-State: AOJu0YyYVA/uLkDcstDx28fntWko1C5Wj6SupzZ4NbZiSsJ/dQFkJgjo
	r/UI+JuTd6sQKnUkHKLEBw==
X-Google-Smtp-Source: AGHT+IGRsPgz+XwLGzAMTdr4TneBPwC3lpqbDDfg8jvgpy1U4E2BXmn++/2IbozqwE6E9QDikpPIqQ==
X-Received: by 2002:a81:f201:0:b0:5e8:34a0:5284 with SMTP id i1-20020a81f201000000b005e834a05284mr1924773ywm.20.1705093722114;
        Fri, 12 Jan 2024 13:08:42 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id ci24-20020a05690c0a9800b005f93cc31ff0sm1635518ywb.72.2024.01.12.13.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 13:08:41 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	gregory.price@memverge.com,
	honggyu.kim@sk.com,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	mhocko@kernel.org,
	ying.huang@intel.com,
	vtavarespetr@micron.com,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com
Subject: [PATCH 2/3] mm/mempolicy: refactor a read-once mechanism into a function for re-use
Date: Fri, 12 Jan 2024 16:08:33 -0500
Message-Id: <20240112210834.8035-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240112210834.8035-1-gregory.price@memverge.com>
References: <20240112210834.8035-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move the use of barrier() to force policy->nodemask onto the stack into
a function `read_once_policy_nodemask` so that it may be re-used.

Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5da4fd79fd18..0abd3a3394ef 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1907,6 +1907,20 @@ unsigned int mempolicy_slab_node(void)
 	}
 }
 
+static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
+					      nodemask_t *mask)
+{
+	/*
+	 * barrier stabilizes the nodemask locally so that it can be iterated
+	 * over safely without concern for changes. Allocators validate node
+	 * selection does not violate mems_allowed, so this is safe.
+	 */
+	barrier();
+	__builtin_memcpy(mask, &pol->nodes, sizeof(nodemask_t));
+	barrier();
+	return nodes_weight(*mask);
+}
+
 /*
  * Do static interleaving for interleave index @ilx.  Returns the ilx'th
  * node in pol->nodes (starting from ilx=0), wrapping around if ilx
@@ -1914,20 +1928,12 @@ unsigned int mempolicy_slab_node(void)
  */
 static unsigned int interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 {
-	nodemask_t nodemask = pol->nodes;
+	nodemask_t nodemask;
 	unsigned int target, nnodes;
 	int i;
 	int nid;
-	/*
-	 * The barrier will stabilize the nodemask in a register or on
-	 * the stack so that it will stop changing under the code.
-	 *
-	 * Between first_node() and next_node(), pol->nodes could be changed
-	 * by other threads. So we put pol->nodes in a local stack.
-	 */
-	barrier();
 
-	nnodes = nodes_weight(nodemask);
+	nnodes = read_once_policy_nodemask(pol, &nodemask);
 	if (!nnodes)
 		return numa_node_id();
 	target = ilx % nnodes;
-- 
2.39.1


