Return-Path: <linux-fsdevel+bounces-7905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344DA82CC8D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE1F1F21DE3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ADA210F0;
	Sat, 13 Jan 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="C3cVHZwz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF06210E1;
	Sat, 13 Jan 2024 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705146666; bh=9hZq7TcGcl2DGxECsv0Ebzbyr1A9X1v0BNjSFl+A1aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C3cVHZwzmYsW+jqADlOsss0kZPQgBa9jKPwDAyqOTrFbzCgRpmMFRbWp4XUr0yCP+
	 01Hb3PHGK+XoeaHaLPqGnfNmH4tbvCZdrkrrE75BXW2vT+rAFsAnw9eduSrLiuAacI
	 Q+trbCcNcxOttxRBEGoV4vF1qunKUEA5lyKI1cUY=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7238E448; Sat, 13 Jan 2024 19:28:35 +0800
X-QQ-mid: xmsmtpt1705145315tbfs81lrf
Message-ID: <tencent_BEF36CE365896CC3B36456B765576766C105@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2w0/HgP7bscZFbrNQ6Z0syXFbsb9Ax6uOONSKscJtVTVn8sxCYS
	 0VjKj33QxKGXISBSHshLRWBhU86KQ8KgM/LL6hMEn/zkEL6UlDZK09ijsxUOTQUZA3e/iQ/wJFo3
	 d9Osf4cg7OsOIEQD1vfV0uBhorlv5s/XlpCfM4ivUgqFYUr4q2r8N9ubtb5URDldo6qtu9o+D3QU
	 X5zcYN7ip2o/LPFE46ycXAWjE/y8+/nWH0ejHR+HWb9Kkmlc0R7GWMgOFEJ+PhLFmi8EtZHgg5Tu
	 5f9sQ2rR36mym0GgBtc4AFxqoTuVFB573eTtCkgOHIqyw4AbhFuCYZRwd5yuZYkms4GU7AHlFwxe
	 Fmi6foZN5ZWO5WYAU2dQKuSZ0A5INDHF249n4up705CZ/0+BkUKIaE0427MCLt3ReUUEnl+SN5Bl
	 CLq+dkxElreY4WW2ArLKW00B7i43/sReYjVNZ1NJt9SSJuEadUAyeHFic8seENnt40uKwMzfnyRM
	 9V54vt/GCN1gfO0SE0uXED4sNBoYVNRrFbjzlHaXN7tEmUtYApevUit5s7jelfZJ6Iy9MQMiSSzw
	 F6hL6iKNtKdJBqEfAHO7JlMyVhlLCNuuwMxC7dFYqdD4RjY7jBTWKo2eEQrbnPgmZJxz8MOAzjgf
	 Gcrf+h6r/R3LhRA+03nb8bn2qiGKg2rYI4WGsTB8jorEIw5o50gtNnNSfpO6MNc40cAfVffTKFJY
	 13DmxDk+L6595jxI9o1dMz3slt+Esp3m6BigGNsvkENUTjJti7dYlCKCJIuXdaqrT1xxM6mTqH6J
	 uV55l5cvWACvvFFsB2BHYb3fQ2k/JwKGfhLf0UB8Dfl2sjkwp0c1KDxyAfLcR6F28Pc+SqMB1Cr8
	 E4OIzw9oh6qW9Nk6puiU1HjDZgK7xnyNahj60gZy51smUz9MqKocFHz55li9keR+J/R2wQRLcr
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a5e651ca75fa0260acd5@syzkaller.appspotmail.com
Cc: chao@kernel.org,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] f2fs: fix uaf in destroy_device_list
Date: Sat, 13 Jan 2024 19:28:31 +0800
X-OQ-MSGID: <20240113112830.1732178-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000aac725060ed0b15c@google.com>
References: <000000000000aac725060ed0b15c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the call to f2fs_fill_super() fails, only the memory occupied by sbi is 
released, but s_fs_info is not set to NULL, this will cause the current issue
to occur. 

Reported-and-tested-by: syzbot+a5e651ca75fa0260acd5@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d00d21a8b53a..9939e2445b1e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4879,6 +4879,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_sbi:
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 
 	/* give only one another chance */
-- 
2.43.0


