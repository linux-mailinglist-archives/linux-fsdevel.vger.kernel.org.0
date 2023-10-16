Return-Path: <linux-fsdevel+bounces-373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612267C9DC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 05:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F0428164F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88AA11702;
	Mon, 16 Oct 2023 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kCQ6ToiF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983FF9D8
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 03:23:26 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D6122
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27d3ede72f6so2177541a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426602; x=1698031402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFyp/FJQdSo4OvDS2koRMpNI0AcMCWskpm09jBYSG+0=;
        b=kCQ6ToiF4tK9Ah92GNg5TaAJH2qFerDDDeci+Dl8QIA4veI+7dF6r+thPfSwSjgPuw
         U0//5u/7iDbZV/sM1weFdoDACTZwbMou/Jd481oDYd7LXFNTbzixkHBuR8vTLBHT+ZkS
         U/oa9p9M37Xe8MgWDMpSwaKee3osY/BrU49JpLQtd3Gb05imftp3A1j+x1Ccoa0o+Q3z
         cCcCCvY32R+Zmwo0kZqUBMvLEuDv4gUi1Uq1Ysl1TbqxUmQ8o/ZTXzNK0id0oKd/wYiu
         s5bikXmmEINQF++9dUH4ths1yijV4Uos09tPr7uAjhGQAeHAf0WaNgkZ7ATYgZQlv70U
         /jpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426602; x=1698031402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFyp/FJQdSo4OvDS2koRMpNI0AcMCWskpm09jBYSG+0=;
        b=byDbuZruUPNiC6gstu8L1t0FtSHbhAetTWhbWzO+4Cskv2vy3tCA/JglORQwLPaYCC
         qKC4ffSpzIZ4MdrazTQRK9PFXX4+osMxC7q5LaUG6WcoSmkxot2tVelBcgTHkBzuPouw
         DkWJdFlGeBkUvtjawlPlIuktFfwfdLvEnmNSVUaIDDFcTCzOyR6FQh9W2gg65tcR8YXf
         R9NRqCPCE+Lx9tznwsR3L0tf3NN1x+/oRWeMBSrzk29bSC9MAl1kBqlJ7O7+3V/zTPiZ
         NTjHBWKJO9cKb7amluCn4NpP0dlMo2UO2ccEzl8dRdI94DGrZfUd7ib65dzuzR4omFRh
         bThQ==
X-Gm-Message-State: AOJu0YwBDU8BuMOmWte8tDDcKbuVWIo4uZwS/6LFoPd54WeUphHj2PSz
	oLaTi0gARAxyVAe4WHbc8Y+hdg==
X-Google-Smtp-Source: AGHT+IEmk/zJXO2kK7nOf720yU64zVWPpcUxkrQhPVMBOjATtllYWJlNEGVjqoAJdP0W8HkSSk7e1g==
X-Received: by 2002:a17:90a:f408:b0:27d:f85:9505 with SMTP id ch8-20020a17090af40800b0027d0f859505mr11824455pjb.24.1697426601858;
        Sun, 15 Oct 2023 20:23:21 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ae28800b0027758c7f585sm3452770pjz.52.2023.10.15.20.23.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Oct 2023 20:23:21 -0700 (PDT)
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
Subject: [PATCH v5 06/10] maple_tree: Update the documentation of maple tree
Date: Mon, 16 Oct 2023 11:22:22 +0800
Message-Id: <20231016032226.59199-7-zhangpeng.00@bytedance.com>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


