Return-Path: <linux-fsdevel+bounces-1282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2687D8D8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 05:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1FF1C20FCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 03:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E304423;
	Fri, 27 Oct 2023 03:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FjPwxfic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D81440F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 03:39:50 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8B1BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 20:39:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so578678a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 20:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698377985; x=1698982785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74qqxidjqyd9XulDVkugPZl+GB+TldL/DBrAezqtgJY=;
        b=FjPwxficg555/vc9VQXDvykvw7zH6mCk1PevNpsgcx0Ja3expzXJxa1ZA9Es80lVBn
         e9mn0iskHiJSVssYxDPuvnWXQAusKyNRQ/b+Cse859XGfMXgWkqNS2scD9K8s/Pfqtdj
         yzwDVCfjsZJPUlcvXOUqrjPqL5p1d+KJtEoMu1SArWBFPvggNKQ/ZLRG2rRAf7mCEahV
         ZAe6YBwnCGNBaYj20qJVzbuviJ75z8S4UFAvjddhSscfOmlt3rCYyNrKM58UpazOACQX
         7tTbFB+0MzqB74413jrbiUYZzzr5TNg7xi2FbviCvNP4w6cVK5/eIGh1lZIW6a32HXAh
         4mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698377985; x=1698982785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74qqxidjqyd9XulDVkugPZl+GB+TldL/DBrAezqtgJY=;
        b=qdMKUeyraCaHWqs+FxF+ptTyNKXrQpofdMMeQ4C9BBRelR6T3hju56P+GdIwca/9ne
         KK2n0+z73JIPqimf2Q8Yex99os4afloXBRfsVzPIV6QPNt1Nq7Na440RH6+lRJrRSP/S
         qAIXOK6GLX8Zr4Z9XQJd+lRvmQXzYHB6TqLkrki0dqVDcY5Kw2Ocj+JIuihtLW9fOqsv
         mNN1IviRQCZmdeoY+0g6CmizVENoH6vvBWGL6iRNYmBKslPD88d/8ZgGXffapqWPltSw
         8kGZzmmx8ddbUTj0rkDY1dEEL3K1qI9ohL1GMbTVxkOirOcwaCndPb7o1o6HJFMpjlHz
         uXBg==
X-Gm-Message-State: AOJu0YwPac89jZ5N1blMiQrBIrhHqbHxRI+EG2HNbQ9LGnkbwbFm3ETB
	zbIWxA0xLB9me2WpX+KliqSdHA==
X-Google-Smtp-Source: AGHT+IE0WBlgixccb7xQyscB6ftmdLDZ7xdSH5V+CyxdwveadRU+NlM0bptvnd1oQV9FJPaGCIUEEQ==
X-Received: by 2002:a17:90a:9708:b0:268:808:8e82 with SMTP id x8-20020a17090a970800b0026808088e82mr1969715pjo.1.1698377985415;
        Thu, 26 Oct 2023 20:39:45 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00267d9f4d340sm2345676pjb.44.2023.10.26.20.39.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Oct 2023 20:39:45 -0700 (PDT)
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
Subject: [PATCH v7 06/10] maple_tree: Update the documentation of maple tree
Date: Fri, 27 Oct 2023 11:38:41 +0800
Message-Id: <20231027033845.90608-7-zhangpeng.00@bytedance.com>
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

Introduce the new interface mtree_dup() in the documentation.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 Documentation/core-api/maple_tree.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api/maple_tree.rst
index 96f3d5f076b5..ccdd1615cf97 100644
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


