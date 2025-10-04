Return-Path: <linux-fsdevel+bounces-63438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA28BB91F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 23:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 199CE4E288E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 21:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193FE285CAB;
	Sat,  4 Oct 2025 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="m9BIjvpn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222B19F111;
	Sat,  4 Oct 2025 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759611848; cv=none; b=M/tGceEj7rsbBtG0NSYSgDCehP+C5sFPBdCSJxPLrcGPrtD/YLNu37SxwiMceB9O8nGLuhW3ykgKdxOKHm8V1P2sG7FtJr1tMPH+xpA80gF8vwHnrJAT3vxXM2H99iUUAusAxYJrgrQBwKfkMqXGNQPmt5hkpEM+QaNIuxkb/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759611848; c=relaxed/simple;
	bh=t4tVVnX1VsePxQnnaUUG3VOAS0org/M207j8oPGw82s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ox+nxeLKfxy4LL5vaqmgKt0Wb4yXStRrTH5WYHUuHcVVfXVapW2jZcQlP2BtnQkF2CZPdxhMIvEfrMwenOxMIYMqAHN0mh2J20WsLyLZCvGBCXtQenT4eXvkhfAJIzrNQydPMBzYfj4jIWMBgYKeKa299D6lp4CIz0NZ22QWkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=m9BIjvpn; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cfJ172GS1z9xxV;
	Sat,  4 Oct 2025 23:03:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759611835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MA/PGkEMxhPtELfy9Wv5T+xAaQgydXmuFGhLXJxbTYM=;
	b=m9BIjvpn0IEi8JQl8EuYREVSRLB62bnq27FhK+xRQqBAntfd3qwjM661O9IAnI9nIEaEkx
	znIaSaYcZcTdmjS7Y6DXeSSdlNxiYGvU9jNNZEYywATDs80q0UamZVazcAJlabToT6KCBJ
	xwMLtZvFN2WB7kjuhKMBVkAj3ijgo2O7TKC8+N9fSwCe3814n6blaAzSWnnwAdoFOTYXeA
	tQdlL293x3UIjC9xx3sLVdz7nDcDLVzVrq7SZwOSB3K/h39noqCMPwsbV9SRwRrQ5iLD1l
	7YZbF58Jeey8/PNtCX8/cQ/83oinX84wJG5XZx4iSp/oyzNSWQZL4Z/a5UskJw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	jack@suse.cz,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH] fs: Use a cleanup attribute in copy_fdtable()
Date: Sat,  4 Oct 2025 23:03:40 +0200
Message-ID: <20251004210340.193748-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cfJ172GS1z9xxV

This is a small cleanup in which by using the __free(kfree) cleanup
attribute we can avoid three labels to go to, and the code turns to be
more concise and easier to follow.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/file.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 28743b742e3c..32b937a04003 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -161,7 +161,7 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
  */
 static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 {
-	struct fdtable *fdt;
+	struct fdtable *fdt __free(kfree) = NULL;
 	unsigned int nr;
 	void *data;
 
@@ -214,18 +214,20 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 
 	fdt = kmalloc(sizeof(struct fdtable), GFP_KERNEL_ACCOUNT);
 	if (!fdt)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 	fdt->max_fds = nr;
 	data = kvmalloc_array(nr, sizeof(struct file *), GFP_KERNEL_ACCOUNT);
 	if (!data)
-		goto out_fdt;
+		return ERR_PTR(-ENOMEM);
 	fdt->fd = data;
 
 	data = kvmalloc(max_t(size_t,
 				 2 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr), L1_CACHE_BYTES),
 				 GFP_KERNEL_ACCOUNT);
-	if (!data)
-		goto out_arr;
+	if (!data) {
+		kvfree(fdt->fd);
+		return ERR_PTR(-ENOMEM);
+	}
 	fdt->open_fds = data;
 	data += nr / BITS_PER_BYTE;
 	fdt->close_on_exec = data;
@@ -233,13 +235,6 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 	fdt->full_fds_bits = data;
 
 	return fdt;
-
-out_arr:
-	kvfree(fdt->fd);
-out_fdt:
-	kfree(fdt);
-out:
-	return ERR_PTR(-ENOMEM);
 }
 
 /*
-- 
2.51.0


