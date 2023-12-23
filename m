Return-Path: <linux-fsdevel+bounces-6832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBAB81D44F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 14:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEEF1C21244
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A50DD52E;
	Sat, 23 Dec 2023 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qkAK/xX4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D14CD50C;
	Sat, 23 Dec 2023 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1703339632;
	bh=Ee0tYNZexbPVXAGBvkDgOutqhhXAAC/AoPNZbvbdlwM=;
	h=From:Date:Subject:To:Cc:From;
	b=qkAK/xX4+e5Fm9Cwe7OnOwVnV3kjMEg9u3ylyIVLiBHA3e1ArPhlQtGagyQ2lCdIK
	 HTAfOuwONryfUtIjex6bSDxVWMBj330uWDv1H+TO6tHtyrd0fCxDvz22RMRV2EBWd1
	 Jji8iFDS7WkCgIZh+BRrcu9IfeAPGdzwKCkO8o4I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 23 Dec 2023 14:53:47 +0100
Subject: [PATCH] sysctl: delete unused define SYSCTL_PERM_EMPTY_DIR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231223-sysctl-perm-empty-dir-v1-1-194edd9b09dd@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGrmhmUC/x3MSQqAMAxA0atI1gZsK1a8irhwiBpwKImIIt7d4
 vIt/n9ASZgUquQBoZOV9y3CpAn0c7tNhDxEg82sM9Y61Fv7Y8FAsiKt4bhxYEHfetPl5MrCdxD
 bIDTy9X/r5n0/9/DM6mcAAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703339632; l=1129;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Ee0tYNZexbPVXAGBvkDgOutqhhXAAC/AoPNZbvbdlwM=;
 b=gJ/VXmLeL0bESGRyabJyAwZYHRnxzRKg56eMMUH5IRbfzzw5lW+AHQX9vifII3taleCjDsyZc
 6Kg/7BD5jDpD/nwKYUSTSJGlNgKSh2r6CXmQydMIHR32kin7ikCdMgN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

It seems it was never used.

Fixes: 2f2665c13af4 ("sysctl: replace child with an enumeration")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This was originally part of the sysctl-const series [0], but it doesn't
really belong in there.
To slim down that series as much as possible, submit this patch on its
own.

[0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net/
---
 include/linux/sysctl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 61b40ea81f4d..26a38161c28f 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -255,8 +255,6 @@ extern int unaligned_enabled;
 extern int unaligned_dump_stack;
 extern int no_unaligned_warning;
 
-#define SYSCTL_PERM_EMPTY_DIR	(1 << 0)
-
 #else /* CONFIG_SYSCTL */
 
 static inline void register_sysctl_init(const char *path, struct ctl_table *table)

---
base-commit: a6fd07f80ab7bd94edb4d56c35e61117ffb9957e
change-id: 20231223-sysctl-perm-empty-dir-7a71b4e3867b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


