Return-Path: <linux-fsdevel+bounces-46437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7C3A89663
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA38616B453
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B811527B4EB;
	Tue, 15 Apr 2025 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2I9xYRL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3D241CA2
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705334; cv=none; b=TmoEm0wsj0qa2LOrO8KHUmOFtF12zcbIEuyOKwj/7sfTfG1kBhfBE9GwB4sZdebEWvOTWLFZZsZyQDeSqAjH1E+8VtnS6BtyEltjE+rylwbN+qx5+4pWcM5FjjuKCPNORFaDSmBRHhWQNGpxv532gT+el2aiTDYZ1CB8hsXwXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705334; c=relaxed/simple;
	bh=v4AdgRWShMDdEaSkKGYnZY/wcte7dKVl4h+Fg7z7rgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXoz6KCFu4hjgxTYXk7SuA4jFf4DKJ89hyjEIezuLhepaT3p21Aa0iHTlXBaA5j5rJPClxqNxg+RjkFgjWtnvqb+7UGUcPo13xR5S5fsLgr8aZqGU0Ylakew8zZCvKHExGgaZCVfAJvcCKhkMjLgSC/GYDGaKs0smSQhIBa5hQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2I9xYRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19C5C4CEDD;
	Tue, 15 Apr 2025 08:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744705333;
	bh=v4AdgRWShMDdEaSkKGYnZY/wcte7dKVl4h+Fg7z7rgo=;
	h=From:To:Cc:Subject:Date:From;
	b=I2I9xYRL8WH/snoi+21PcvdoGKJ4uJriqvDV5/FBO5e1lDNGkAQVpKdXsZmFHzPuM
	 667isXnd+KB+CjQJt2ZxMSUXikwCTkf0x1hluLTZmi//xtAuiJJ8OFwRy+io4ced5B
	 Pnr5MslBSnlzu8WotSxSje3IzkMUwUN+iZSKdQ8XP1kLYVyEIqGZJJsbWNRZaugusU
	 ZZt513nxnmfsNzfw4M3669A5mp/m05VY23MLmHj8bRQh1RKYHqEYwAAHvVtJCvfALb
	 WjfbzTQr7jcUpDPRrikJuCSXNtia/03UpHn2DHUJuiBD8pneHuj7erJqYxo7HpYNO3
	 JleIk4gE/5TQA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Kconfig: switch CONFIG_SYSFS_SYCALL default to n
Date: Tue, 15 Apr 2025 10:22:04 +0200
Message-ID: <20250415-dezimieren-wertpapier-9fd18a211a41@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=brauner@kernel.org; h=from:subject:message-id; bh=v4AdgRWShMDdEaSkKGYnZY/wcte7dKVl4h+Fg7z7rgo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/E9cNfabk9pPny33P80ccbG2Xar56oMe1y9JamfNaX tUCty2sHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNR82Fk+MJ+fqeCQOH0iVcq 2G2ToloS7DxcPUSuS7HkZX7uCfJ+yPA/jEH94t6o/ScWCgSxRl/9tGmRYYbVqsiTgmyhTJs/HZj OAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

This odd system call will be removed in the future. Let's decouple it
from CONFIG_EXPERT and switch the default to n as a first step.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 init/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index dd2ea3b9a799..63f5974b9fa6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1555,6 +1555,16 @@ config SYSCTL_ARCH_UNALIGN_ALLOW
 	  the unaligned access emulation.
 	  see arch/parisc/kernel/unaligned.c for reference
 
+config SYSFS_SYSCALL
+	bool "Sysfs syscall support"
+	default n
+	help
+	  sys_sysfs is an obsolete system call no longer supported in libc.
+	  Note that disabling this option is more secure but might break
+	  compatibility with some systems.
+
+	  If unsure say N here.
+
 config HAVE_PCSPKR_PLATFORM
 	bool
 
@@ -1599,16 +1609,6 @@ config SGETMASK_SYSCALL
 
 	  If unsure, leave the default option here.
 
-config SYSFS_SYSCALL
-	bool "Sysfs syscall support" if EXPERT
-	default y
-	help
-	  sys_sysfs is an obsolete system call no longer supported in libc.
-	  Note that disabling this option is more secure but might break
-	  compatibility with some systems.
-
-	  If unsure say Y here.
-
 config FHANDLE
 	bool "open by fhandle syscalls" if EXPERT
 	select EXPORTFS
-- 
2.47.2


