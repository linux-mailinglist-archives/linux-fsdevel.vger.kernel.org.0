Return-Path: <linux-fsdevel+bounces-54758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF3BB02B6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 16:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E24A15AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5A12820A7;
	Sat, 12 Jul 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jHeE+cRw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B25C8BEC;
	Sat, 12 Jul 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752330812; cv=none; b=cElU6PjQQNSbzQApKDG2LvxghVlqNnkRaosgYPXAN9MgPnoRR4DhgVBjfLqGVguF1C/bNw0mrHVsK9DfTOU21Mxsbo2T8u3QQPOgOyr64i70xtsCBPI16M6Qb6beJhjD1on5tJqNYmuOLCLTfTO3utDwMJOFx0VPgr3UM6yMtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752330812; c=relaxed/simple;
	bh=sIOKAD2MTUbXtcoW87WJAGTcHShe/qrRmPh438Vntwk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tpmNtFB9Ib0GEGOY63+OM6DECWqYQMrAFf5RTpyN1rCnzr0l5ZTckgKGESK3HYQTdi+Oz8UrpP/f/tpjSW0FtjbN/QsUro8DFCJiSineayzN4f9NBXjZb7JENhYtDz6D9yTq/xTZ4EXlAhLQWZxAmKKgrwM4Y8eSWR+48iKL0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jHeE+cRw; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=Zx/3aqFbue8q2T0
	EElnkI1Xd/UhLG7XGArEZaqXXprU=; b=jHeE+cRwj23BTwz/fEJGvEKncvYxpqz
	Oq3yWPq5uzgVpYETRVNBBsXb57qWAwk40vgQ96jjVUuqpnfFbfENFU98TxwXto+8
	Vkvrqsa62gU3jOrpFqcnwT9+sxdp4m4v9gMFf4Z6JwsygU3kow7JUH3QbyBd5Ts9
	FIn8tP5ihsME=
Received: from 163.com (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnuGXycXJooq1tCA--.53904S2;
	Sat, 12 Jul 2025 22:32:19 +0800 (CST)
From: Beibei Yang <13738176232@163.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13738176232@163.com,
	root <root@192.168.220.227>
Subject: [PATCH trivial] init: Fix comment typo in do_mounts_initrd.c
Date: Sat, 12 Jul 2025 07:32:14 -0700
Message-Id: <1752330734-85833-1-git-send-email-13738176232@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:PygvCgBnuGXycXJooq1tCA--.53904S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWDJw48tF1kCr45Cw4kJFb_yoWfKwbEga
	18XFs7JrsI93Wjyw47Cryrt3WDWrWFvF4rCF1rCryUta4kJr90kr92qr97G39F9r4j9FZx
	Ww4DX3yayr12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWyxiJUUUUU==
X-CM-SenderInfo: zprtljayrxljits6il2tof0z/1tbiYA+Ia2hya46JpwAAsd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

From: root <root@192.168.220.227>

The original comment incorrectly used "cwd" (current working directory)
when referring to the root change operation. The correct term should be
"pwd" (present working directory) as per process context semantics.

This is a pure comment correction with no functional impact.

Signed-off-by: Beibei Yang <13738176232@163.com>
---
 init/do_mounts_initrd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index f6867ba..173b569 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -107,7 +107,7 @@ static void __init handle_initrd(char *root_device_name)
 
 	/* move initrd to rootfs' /old */
 	init_mount("..", ".", NULL, MS_MOVE, NULL);
-	/* switch root and cwd back to / of rootfs */
+	/* switch root and pwd back to / of rootfs */
 	init_chroot("..");
 
 	if (new_decode_dev(real_root_dev) == Root_RAM0) {
-- 
1.8.3.1


