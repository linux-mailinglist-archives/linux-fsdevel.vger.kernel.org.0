Return-Path: <linux-fsdevel+bounces-4746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DBD802D40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD101F210CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F3FBE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rRkFq96C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF72D45;
	Sun,  3 Dec 2023 23:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=zByUx3Gq6P8LcvcqSjdgxm/5wuG+rVoanucvNQrnBwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rRkFq96C53W4Qa03A41B32MvmVyDQRkTNCbQcM+Xuz/1K/4p2IVfE2RJFXISV9AT8
	 +m2cFw8KOv+tWlhuOzE6u2hMX6VCaCZMEltICxc898tMWOwUHR0wapekUgvvel1l/P
	 8jLMdDolwt2ssl4Gs0CMz+V1cUJtzZejX/mM8hrk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:30 +0100
Subject: [PATCH v2 17/18] sysctl: make ctl_table sysctl_mount_point const
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-17-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=707;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zByUx3Gq6P8LcvcqSjdgxm/5wuG+rVoanucvNQrnBwQ=;
 b=T4fe4Y4H+z9NMgxNToLMvDIdzWzUsQ1ROmqM+wleaFzcaGQIwqyaLjcqz7LoArGFd6dKvGI3b
 rnc8VQL+TsKC8bU/mHopWYEMAy89LdgzfJW/9Gr5m8N/9iOqPxqaHiW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is a first example on how to use const struct ctl_table.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d09107a5b43f..f2b663e0be33 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -30,7 +30,7 @@ static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
 /* Support for permanently empty directories */
-static struct ctl_table sysctl_mount_point[] = {
+static const struct ctl_table sysctl_mount_point[] = {
 	{ }
 };
 

-- 
2.43.0


