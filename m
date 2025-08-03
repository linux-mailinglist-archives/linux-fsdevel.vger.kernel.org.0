Return-Path: <linux-fsdevel+bounces-56559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA159B1943D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7FB3B1DB9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D919D156C6F;
	Sun,  3 Aug 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VcOX2KXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170D2836F;
	Sun,  3 Aug 2025 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754231431; cv=none; b=DyJDUZ+nlI07dp9Mx71en30BbwEFsQyOpBfuefa1YStCiVUlzHO6d6jJ6CY8rXRuppwhVsJ+RCKHCAHwfW5HxFV8VMCtmdAIMpFrK2HY42fwH/d8h97ydoXXKe3xXY1lV4RTnSjgg9p+m0l+vRFnrHFT48a7R7iCbvlJND3v438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754231431; c=relaxed/simple;
	bh=sIOKAD2MTUbXtcoW87WJAGTcHShe/qrRmPh438Vntwk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ghxpF8hDDbppJJ5SJQMaa17Y6vshQbr5FoHhCVR180tOefOH6wqxrGokau96GU184t9fCL9tnR8UA3unopegrXFdkZib+vcDut1VGYyPGpEBTAnh4kO54MHQzz2gywfxyU6C7gBgdz8Bf3zCY2sLoROZG/W7fxUeGstZPNUmN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VcOX2KXw; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=Zx/3aqFbue8q2T0
	EElnkI1Xd/UhLG7XGArEZaqXXprU=; b=VcOX2KXwKAsJL+lcuEBLEu8XulA539Z
	uWMjdSFKr6aBpC3/v4yeXumJCx9d7Jg9NhsFNXYyS+HjHziFzKpr2QIUgaFabRXL
	cbB5+5TCASX4JDSYPfdc9+gifdZum7DnIumLOz4V1b2Z7Vk4DxoClOWWpJWh5I9z
	h3uSrfAQ97fw=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXHs5Bco9ofBxoJQ--.5397S2;
	Sun, 03 Aug 2025 22:29:22 +0800 (CST)
From: Beibei Yang <13738176232@163.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13738176232@163.com,
	root <root@192.168.220.227>
Subject: [PATCH trivial] init: Fix comment typo in do_mounts_initrd.c
Date: Sun,  3 Aug 2025 07:29:18 -0700
Message-Id: <1754231358-3544-1-git-send-email-13738176232@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:_____wAXHs5Bco9ofBxoJQ--.5397S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWDJw48tF1kCr45Cw4kJFb_yoWfKwbEga
	18XFs7JrsI93Wjyw47Cryrt3WDWrWFvF4rCF1rCryUta4kJr90kr92qr97G39F9r4j9FZx
	Ww4DX3yayr12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWyxiJUUUUU==
X-CM-SenderInfo: zprtljayrxljits6il2tof0z/1tbiYhGea2iPaWfA-wAAsQ
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


