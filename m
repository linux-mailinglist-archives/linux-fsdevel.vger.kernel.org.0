Return-Path: <linux-fsdevel+bounces-7723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C39A829E13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF2CB25CB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090974CE17;
	Wed, 10 Jan 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="LFL9ceFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C3E4C608;
	Wed, 10 Jan 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1704902183;
	bh=wQOXJIJsJ7TK3AdRldjWOw0I/FRpUAQIImnC0W7okJk=;
	h=From:To:Cc:Subject:Date;
	b=LFL9ceFdkgvzsuoC9RKNS4/j9v+H8n9ohcAoCU5J+LRtzUr/l18WqmDCAodMQ0F0y
	 X/aDu9XUxQzy9HK4XNERxNei2AI6/DpPFaMTj4ajETiLk6UESfEnY6LA8q3Eaed6/8
	 9A5v0IqrnC3pWATXdmr6j0j0kPgtVvrWoCLz5tIc=
Received: from localhost.localdomain ([2409:8a60:2a63:2f30:ff74:6daa:56dc:111e])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id BF136234; Wed, 10 Jan 2024 23:47:49 +0800
X-QQ-mid: xmsmtpt1704901669t7kbz5a5d
Message-ID: <tencent_0BAA2DEAF9208D49987457E6583F9BE79507@qq.com>
X-QQ-XMAILINFO: NojR6Ao/DkEDBb1YCk5PeOKZPS2yurQUYj2r9Yt9x6JBtQEZbkp7fGPKYGatb4
	 D2hHpJqq3ojfDXxgFtDWZ2S1X4YqciNh/aHgaP92FnaBybEEp4TWDkViTWHlWPH1ZOgfdijpkudJ
	 JMAc9lsHucXr5iu7urC20Ynepgueni8EKxqNOuwgtSkZWAdCpJVaVljsKjr8bnHgG80zfS9WiqsE
	 hHRRFPzbkxRH4O8YR2J8hsLsD9q8EbFVkoiyCfAVB3Ku4ECWV2quS+knS23nmckn4rQZOUrnAZbH
	 9XFr7EKYFmtoM3lyAeQy95qYXZPKbiq+ve3kZRx5p4p0TCp4/Too0W9Cl7U5ghe+W434fqcJIu53
	 cj9ZGRT3vhcIOrWxPL5ASVIGXKvlaYzyYoNub3XugxbDqPXCgXDNAaSv2HZasAYznwPWvojB4jbo
	 F2e+s989VDEp/5K/4+SRTUOLEXGiNtUqYcxZny1/Wv3GbNza9aSXXba9UU3RGOGKTxGla5RzV6A8
	 idbc/04xaEMjkqFQQ/k7JeDZNlQVEUOK0NjIUeN3QSOWM/tWW9/9v2IG4NUkUEbj6n22eacudrEv
	 Tm4rdb4PGyZsa4aykGAPa4MVJSNKSd6WnDOgKWMXPDKpduvW7FXGmJ3/W2uWI18P3aayjGicZz4P
	 v44eELgdWqEBjH4Uh0E+I6poip2dl1UxEQMRgayyKf4VNySL4ItZDvPhB5C8WgBtdDBx5uvhPJB6
	 IE99UI9Qyt3+HrH31BGW2dlV7koxePm+AJPJW4HthCS21xsKug7wssLTYqHHT8v5o/wWMRPSf4aF
	 PvVMOyAM6blZiz4T4VoxefzTatnp+vcQfnuOl3CBoPwW8rfPZAkEEFFfnOTpubKxeSX8eW1IARHd
	 PxwV8u+fCBvEiDInIWtLO1nWQS0wx5H9pu9nqLBRJleR+h2UskxoycDZgCKvEePau1YMGDpx+rMm
	 4kY3tqKGy7QnJ+lUL0N6DQqmtzcg1MauQvODf8GKE6yp14nJrbIDyxI4tpUa+nyZQ8b66JaTcxc0
	 qa06QDSw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: wenyang.linux@foxmail.com
To: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: add a BUILD_BUG_ON() to ensure consistency between EFD_SEMAPHORE and the uapi
Date: Wed, 10 Jan 2024 23:47:40 +0800
X-OQ-MSGID: <20240110154740.41888-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

introduce a BUILD_BUG_ON to check that the EFD_SEMAPHORE is equal to its
definition in the uapi file, just like EFD_CLOEXEC and EFD_NONBLOCK.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 93848573c877..c1f5d71e7197 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -502,6 +502,7 @@ static int do_eventfd(unsigned int count, int flags)
 	/* Check the EFD_* constants for consistency.  */
 	BUILD_BUG_ON(EFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(EFD_NONBLOCK != O_NONBLOCK);
+	BUILD_BUG_ON(EFD_SEMAPHORE != (1 << 0));
 
 	if (flags & ~EFD_FLAGS_SET)
 		return -EINVAL;
-- 
2.25.1


