Return-Path: <linux-fsdevel+bounces-14429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C6487C965
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 08:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F17284A53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805C1429B;
	Fri, 15 Mar 2024 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kU55tM8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257913FE0;
	Fri, 15 Mar 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710488293; cv=none; b=NSPS95z+GhB5D/eJ6u4A+IdNc3VV1DKB3z1Wk5GaXNF7OBbBTUj0A/sa2BtbhL90f4XowHsOWlEWWenHm2/J7oXHFXWDqm5H82A3JmlcgS9siken3WWnTf/tva447m9UnjDj86uapgjGe+WZuSA+3yunYcnXTkdhu7r9nSHFfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710488293; c=relaxed/simple;
	bh=XWWRvsgk/0lGAj9U5B09PIVCpqzsHnTUgd04g+wpHSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uj5GXswrsTR0aP4p5rkfyfKXoC9c+9z32Pj+41txzvtdKeV7HmSd3sS/2+Vuf/vQMzfVDoeXvwI5EUwALUr0qZqV+umsVkvOopKcsG1WXLzGlRXqAH/PTjp6nPqBfw9MOF4BvF/xqzGJnn5fXuHy14FxyRz9vBzqkJPFssloG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kU55tM8u; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710488288; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5g45Kk7mH0mIdrRQacSl6eYr0tbYPGHsSpK+SWXMIFg=;
	b=kU55tM8udS+41uU6sB3rvgB4CPMcjO7bhsKYV5FQ6abFq2i92tLoe4bk2lmF3c0l8fF455vpKqzCf5PuZhEG7s1HBoWMAiNn0ZmdIX9QGD3SmFehsxUoX86m9hodAcwUQbIgw1wGInOBUAg1PfQT0dP6CV244f6Gmm4fzqvl/5s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2VapzI_1710488287;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W2VapzI_1710488287)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 15:38:07 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Add kernel-doc comments to proc_create_net_data_write()
Date: Fri, 15 Mar 2024 15:38:05 +0800
Message-Id: <20240315073805.77463-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function proc_create_net_data_write.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/proc/proc_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 2ba31b6d68c0..52f0b75cbce2 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -135,6 +135,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_data);
  * @parent: The parent directory in which to create.
  * @ops: The seq_file ops with which to read the file.
  * @write: The write method with which to 'modify' the file.
+ * @state_size: The size of the per-file private state to allocate.
  * @data: Data for retrieval by pde_data().
  *
  * Create a network namespaced proc file in the @parent directory with the
-- 
2.20.1.7.g153144c


