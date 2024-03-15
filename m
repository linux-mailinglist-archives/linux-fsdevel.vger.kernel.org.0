Return-Path: <linux-fsdevel+bounces-14430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BBB87C990
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 09:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE73D1C20E6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FB914AB7;
	Fri, 15 Mar 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j2Sd8sD+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43B14A81;
	Fri, 15 Mar 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710489782; cv=none; b=aOFJFFUQOcFV5rsrLry8aJP1kAQtKUJ/8B/YRJRVDKsfaUMpRdZWpMZVTAfHnKIOOpIlAsRvFn6XuDCxrpGlayta/TdI5E2rjivnPzyD/D3P7pLf6oMvXsZxiiRZFUOd994vC/SxgnLqjNyoJ5gPzSYE3dRAWXEEWJ4eFFguvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710489782; c=relaxed/simple;
	bh=5VXojIAw1rUEiDYt/FqIAe1/xML+Njh0heiWvOiIMpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oKyAm9sVC0OzNUJ3WYFwALGlq/QB7/VmkL+8LGrp/ldfgpiucEICD3JoCDpXRUtBceqzcR90NnUKNfyQyxtV71/Vp0GWnJZHX2h/iSY05IuzyWu5O27qYepIfr8cbuUa1Yn9sJj4ZwJ2Hn33IwPjP/75b9zQ0EsaLpSUF6nRjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j2Sd8sD+; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710489775; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VlFgL/hqqTQBtF/3e4KvW9i65ABrJaWnIIhbg5CUY+Y=;
	b=j2Sd8sD+Xvlwy3m3rx/hvivIkxxRltJTN7660cKVrDNFgL2D3yYFAcVIUnIA5gQ0MnUQSQlDPCD+xUFvdFvyhrFaz3yQDXgrZVOKXkxPKW5z9+h3yW1rQfuDjOEX9TAD+11+snPmj6Ymt8JJtlw1D9tLorLj0mnUp7fR75eVU2E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2VhelH_1710489774;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W2VhelH_1710489774)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 16:02:55 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Add kernel-doc comments to cuse_process_init_reply()
Date: Fri, 15 Mar 2024 16:02:53 +0800
Message-Id: <20240315080253.2066-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function  cuse_process_init_reply.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/fuse/cuse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index b6cad106c37e..0b2da7b7e2ad 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -310,6 +310,10 @@ struct cuse_init_args {
 /**
  * cuse_process_init_reply - finish initializing CUSE channel
  *
+ * @fm: The fuse mount information containing the CUSE connection.
+ * @args: The arguments passed to the init reply.
+ * @error: The error code signifying if any error occurred during the process.
+ *
  * This function creates the character device and sets up all the
  * required data structures for it.  Please read the comment at the
  * top of this file for high level overview.
-- 
2.20.1.7.g153144c


