Return-Path: <linux-fsdevel+bounces-992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C7D7D4A38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870181C20B99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B1D219ED;
	Tue, 24 Oct 2023 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DFkldGMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13121115
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 08:33:52 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC6F1715
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd73395bceso3079607b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136430; x=1698741230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFyp/FJQdSo4OvDS2koRMpNI0AcMCWskpm09jBYSG+0=;
        b=DFkldGMdV2JxmJtnJ2BwYAUGwWXjuXpH7vMPy9/txF2bmv7IAxzKNlda7tFnfBzhrE
         Z7pWAxLLI6z0aHZ9pJ3N4u2AiEcqqd0J3CzRIyyASI7VkE997XKLXtrWN/KMGzl6av5r
         K61YgrGTJA97Gs5yThZ1YggtD87zhHjGzq3XRBF6NsJJmB5vU7VO8WVUOgCFtdEmY59z
         gKN0xeDUcGgkUDHBiU3yxZ6jGIF25XZdFLc9dSDO4DrexPZo7pV+xNoy957cUer4tTwN
         HjNj3vtdAQ99teS4CFZ1Sv3c107vn+9NFYi0Iykdk3lkVbogEJdgilgF7oAvh6u0h1fC
         xP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136430; x=1698741230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFyp/FJQdSo4OvDS2koRMpNI0AcMCWskpm09jBYSG+0=;
        b=bfPXW1tiATHNYFCJ4yy5dGmzW31HTlY6cNl0qtL+Pdth2PfO18oyUCDJorYjp8bqI3
         WU3pC4TIcjCLBerrO+NXiaqDFHLrPaRYw/Ch+yWmqbzf2TMmNCvbSM91vGKDNhZVb4yW
         82ReFolJUeX4VdCs7JiWGxsGF4/Shf4VVTiQUCCjMH1N1Lp5oIEBqhQuM/tCCBfrnDEQ
         3aFTbw/4rwnDCEChgBJOsRner+SooVtvP8HZ8jJ7g0EDTNJy+FDVugUGnqfvaFwxOIjr
         2EazzfrwG/wfFIZF4tGOqbh2bris7sgpV0QparZLTmXQ1HhvWY39RGHkKimhyFJLxp+B
         QICA==
X-Gm-Message-State: AOJu0YxRg38qmPMNWdlPHRZC583vccDLArkQNDri5N0e26PAcpjc92lG
	n5I5A2zbkp3nFqLIZtZn6+gAUA==
X-Google-Smtp-Source: AGHT+IFGRqPLSl0xQjtZhF9R2vYQNinwziWDialz1aZ2psT6bnUbvTADzmyVrOS+Nnq8WOBVXot69w==
X-Received: by 2002:aa7:8885:0:b0:68e:2c2a:5172 with SMTP id z5-20020aa78885000000b0068e2c2a5172mr16021661pfe.6.1698136429778;
        Tue, 24 Oct 2023 01:33:49 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.33.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:33:49 -0700 (PDT)
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
Subject: [PATCH v6 06/10] maple_tree: Update the documentation of maple tree
Date: Tue, 24 Oct 2023 16:32:54 +0800
Message-Id: <20231024083258.65750-7-zhangpeng.00@bytedance.com>
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

Introduce the new interface mtree_dup() in the documentation.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 Documentation/core-api/maple_tree.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api/maple_tree.rst
index 45defcf15da7..285e2d2b21ae 100644
--- a/Documentation/core-api/maple_tree.rst
+++ b/Documentation/core-api/maple_tree.rst
@@ -81,6 +81,9 @@ section.
 Sometimes it is necessary to ensure the next call to store to a maple tree does
 not allocate memory, please see :ref:`maple-tree-advanced-api` for this use case.
 
+You can use mtree_dup() to duplicate an entire maple tree. It is a more
+efficient way than inserting all elements one by one into a new tree.
+
 Finally, you can remove all entries from a maple tree by calling
 mtree_destroy().  If the maple tree entries are pointers, you may wish to free
 the entries first.
@@ -112,6 +115,7 @@ Takes ma_lock internally:
  * mtree_insert()
  * mtree_insert_range()
  * mtree_erase()
+ * mtree_dup()
  * mtree_destroy()
  * mt_set_in_rcu()
  * mt_clear_in_rcu()
-- 
2.20.1


