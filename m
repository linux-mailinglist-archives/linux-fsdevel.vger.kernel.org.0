Return-Path: <linux-fsdevel+bounces-71255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A0ECBB2B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 20:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DADCC3001828
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B113B227E95;
	Sat, 13 Dec 2025 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G/MkELk5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D12F3C25;
	Sat, 13 Dec 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765654253; cv=none; b=EySde9MJ3DvXdNxehXtScX++VugBxUmMpE0IwH3EAx9icW3EL60kWolT2/oZ2g5PFU85ngQ335ZO1zMG5LwsOyASlFTwtnnxO6A856ulhLdk1H28GROvpY66KWkRCX64aP/A3ebF/+/8FA9iUZKQr6wMY8mPRhupHexGJFS/zR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765654253; c=relaxed/simple;
	bh=d8njymtR4/jbvIfPAdYRDnDuS8vhtJ3JijFBhwv1+/k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TlT2GUfkAsLx2mB1OcTEVez75n56HQ/nhG7+o4Ikb12J0EXp+MYKg0KJxXFrZ0xXVlezIoMYDPk4uK81Jok8zTAHTxJ3Tk+u319gy0qQ3MC4ID4jbwLQgMBTlveNxaW90MA1ojvNz1Zdy0jt+TffQ6UchMtCmUt5du3XOhRb5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G/MkELk5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=iMvZQ1pWr8b+zE0
	/xw84/kP2nIFjFF/6x294EGxypAA=; b=G/MkELk5eaZ4E8LHxv9omQ09N5e4tLE
	nrSe+6Xn3DnW2o57n90+aFRbkhiaVIcj2qzsP+PT62YbRWTT1wXXsH2MTvc2Ht2C
	JjCPhlxkucDnApn3oL66FXM/TeplFwgkutd27W2uVdE5xC4ISfEnTBzYHK6MBroc
	jz3HSe8ID5ag=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX__vLvj1pibQWAQ--.63519S2;
	Sun, 14 Dec 2025 03:30:37 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: adobriyan@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] proc: Redundant header files exist
Date: Sat, 13 Dec 2025 11:30:18 -0800
Message-Id: <20251213193018.3250-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDX__vLvj1pibQWAQ--.63519S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRxWrGDUUUU
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbC+h2QPGk9vt1xUQAA3c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The header file fs.h is already included by /proc-fs.h
Let's remove it

Signed-off-by: Lizhe <sensor1010@163.com>
---
 fs/proc/version.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/version.c b/fs/proc/version.c
index 02e3c3cd4a9a..63fb49ce8c2e 100644
--- a/fs/proc/version.c
+++ b/fs/proc/version.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
-- 
2.17.1


