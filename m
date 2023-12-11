Return-Path: <linux-fsdevel+bounces-5448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AED680BEEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 03:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4981F20F3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 02:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8396E11C8C;
	Mon, 11 Dec 2023 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bNGNFcwK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D0BD
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 18:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702260753;
	bh=6TWFxPY1kUlhrSWgrINRe1DqApRnIQlS+gpND9Ta4MI=;
	h=From:To:Cc:Subject:Date;
	b=bNGNFcwK+cCvY5Bu6pI/ki6FkCB75KUqpRCr6UeQi+kyhtwX5dDlYON9aS+lDPGJH
	 0ZB67Xg+pEvci9Xqfrx+sy72ZFl0s7qHxCAVZ367eNCh+p/8SLNbIghTJ9DC+wcFOg
	 SFZ1lDAl36Xu4LCRdoKEY4clt9E3lr3GR7pB1L3U=
Received: from localhost.localdomain ([220.196.194.33])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 2A51BCD8; Mon, 11 Dec 2023 10:10:37 +0800
X-QQ-mid: xmsmtpt1702260637t60bu86yh
Message-ID: <tencent_9AC493050A340C4EE35C545385FDC0D29B09@qq.com>
X-QQ-XMAILINFO: NUygYfydBsqcb3RjFTZfd+hMyAWVMrMbUpnpZtEylnHCuGFyeu4Cr8WJpqXXlA
	 Ot/eb9fV7Xu9qL3AYFvliWsPdrdbSvUZeq3YDd1J3+AZQ7Lfh2jgLcA5yex/gLG0XNIXcoM65qZm
	 hxwb8A16MXDLUj3YOvrMtZ15cbc0Ta5V0MPWMjM22jxY32LQ+xja4am36LGGhV0UKv+NLemyyxeO
	 q7LyDiz/PP0wT3fFNQu+EnktsTHP31S1P6f1p3MePV4a3ZrmCPtUq1k/Kg2D7XcoFTVR9pF3PYUC
	 lVJDZuyP7sggqzc4laleVc/sPLAZp1AmVp7QRcBD831zOfNs2cWOZQOnyOkLlwa6s3UXtmqQ6Gi6
	 ksE9PRIqcGjHnCUQVHDnVEJaX148yXRw8iReY8iygcWOcArO6YpzDAWhw0W2A0zxbWPN2Uv/a2C1
	 IqTbr/IGKFEz1lf+H4IY+0BxUAA3rgzyNnVOvseCUCqgOkhAXBR5/NjvoQblxJabwqSqq2NKnOGw
	 Ncly2D5KZ0gdVIg+S7ml8OB/4rQ8VGUwp5CljZUEKbWkzOtd+R05QAxHpoL0b3OhYUjFX3GkKFCa
	 It5kX8T1jjeyzPYEUztKSUwlA/L0xSUNulbxDqXjULc+m5novD8gRKelmQenq7EmDcfQq2lQjpSZ
	 qOfnps2W5LyCeGZ3Svoc5BU6pWgQh5vh5p+tfIWMi0yu1ldQWwr9xlKs8ntg/yriTcZkh5jhQJrz
	 uq5l9SX01/UZWP61cfloeJ3IOYghRjIW2en+HPEk5Q5QE5PTmXjMYpXX3se64VK6UA9lwUSXVdiz
	 +Djhiw99I6R8c2KhQCD+TCuGkBJfdtuq23jrAdb3RX6W6EeKc9jNgLgF69jbz5zyAI1VUFRITkvK
	 ZwGDXy4j6pZO18dGc4bN9te+d6DL1fyj3PWxc0YSpN06ut6vgQD/0suEypN/sMSfdFd9P2WX0x4K
	 FZIOsOAt9xKLY9H6gcgy/+a7kOooIK
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 11/11] exfat: remove duplicate update parent dir
Date: Mon, 11 Dec 2023 10:13:09 +0800
X-OQ-MSGID: <20231211021308.1376617-1-yuezhang.mo@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

For renaming, the directory only needs to be updated once if it
is in the same directory.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index b33497845a06..631ad9e8e32a 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1281,7 +1281,8 @@ static int exfat_rename(struct mnt_idmap *idmap,
 	}
 
 	inode_inc_iversion(old_dir);
-	mark_inode_dirty(old_dir);
+	if (new_dir != old_dir)
+		mark_inode_dirty(old_dir);
 
 	if (new_inode) {
 		exfat_unhash_inode(new_inode);
-- 
2.25.1


