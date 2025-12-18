Return-Path: <linux-fsdevel+bounces-71606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22380CCA473
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FF79304BBE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4A2FF155;
	Thu, 18 Dec 2025 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duotF76E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14B230264;
	Thu, 18 Dec 2025 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766034316; cv=none; b=BbWkvE8xiDkZuuctNGyOhO6sbXbH72o+Q0HAeSFtzrF73KfcjRSja4J/ZEfMWFn3Hb/NqXEgI33jfquqvMVYeyIfgrNghe2OBNrfU0+BQFKojghkcVzm/B2CBXOUrEBhB5z3vRkWc4W/E1JYB1qkSiXvxImnVxjVAre97OCRwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766034316; c=relaxed/simple;
	bh=gBbV5yeUfhIImp6mI01KoT0+A2JTzbVis+LTq2abbTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UkiCZztk/WY86DZIUf28SiVVABq5H/zCF2fwf5sT2y/HcTrvO4Feofrf64kQJgMwXqbfCIhM6H3y0kG+4/D8BCLzFjF1elhBlncneDkJvMj20AmK9XKgBYUJXTPnVGqGHDcTnLT0lKhb7yhUSUaC2GrLU4s5cWowo3Eu63CMGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duotF76E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC640C4CEFB;
	Thu, 18 Dec 2025 05:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766034315;
	bh=gBbV5yeUfhIImp6mI01KoT0+A2JTzbVis+LTq2abbTM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=duotF76EUsRl+7rGBOJdbmlNhsM53tdAotBSapjVpzxY0OLun6mE6dgMp4Xe/Bvd8
	 d3ZH3SrLisB5hWv+ux21RTkRo1dk6/KHW7be/YtBPaddp8kFUUeh8J6mEbH0lPNbb/
	 9LgBrMEj6QUtp5quWPXcX+yG6URHwIH9nUfPL3uMj3kxmEk1qjWrGJVzwxdulg4ULk
	 TUV1hKNwbMNdSo7zubNP2hm+euvbUuODvin7Kgb3seIenpe2feY8mu2SjIHnNNwWrK
	 Sh/VWkC3FUX5YoL6RWhGzTGI+QasKw32mKOGpmvJY4qJLdPhyB/Jud8t8x23G7ZBGX
	 1vTN8EIcWoWvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E5D68BC6;
	Thu, 18 Dec 2025 05:05:15 +0000 (UTC)
From: Bagas Sanjaya via B4 Relay <devnull+bagasdotme.gmail.com@kernel.org>
Date: Thu, 18 Dec 2025 12:05:00 +0700
Subject: [PATCH] VFS: fix dentry_create() kernel-doc comment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dentry-inline-v1-1-0107f4cd8246@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHuLQ2kC/x3MQQqAIBBG4avErBNUMqqrRAvJvxqIKTSiiO6et
 PwW7z2UEBmJuuKhiJMTb5JhyoLGxcsMxSGbrLbOWNOoADnirVhWFqhKt2YCPOrGUW72iImv/9c
 P7/sByOB+w18AAAA=
X-Change-ID: 20251218-dentry-inline-4091feeae685
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Benjamin Coddington <bcodding@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stephen Rothwell <sfr@canb.auug.org.au>, 
 Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989;
 i=bagasdotme@gmail.com; s=Zp7juWIhw0R1; h=from:subject:message-id;
 bh=gykyE4n1Bru42E0/IbBcoXj6P5uhnSGs7sDFNl0/sD8=;
 b=owGbwMvMwCX2bWenZ2ig32LG02pJDJnO3V0TTlS8uK4rEGv08MW3ue6Mz/WDfZZb7ZvJsJ97s
 3DxkkbLjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExkkTbDP92SKhWfjef6iy8a
 RzxVttaQ3KAzcebhMn73NZL6WrPf1jMy9CXrttxPKT0f/k1hicKsrHXGGsr8nDsyz/9ZsStdzPc
 BKwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp;
 fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
X-Endpoint-Received: by B4 Relay for bagasdotme@gmail.com/Zp7juWIhw0R1 with
 auth_id=581
X-Original-From: Bagas Sanjaya <bagasdotme@gmail.com>
Reply-To: bagasdotme@gmail.com

From: Bagas Sanjaya <bagasdotme@gmail.com>

Sphinx reports htmldocs warnings:

Documentation/filesystems/api-summary:56: fs/namei.c:4952: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/filesystems/api-summary:56: fs/namei.c:4942: ERROR: Unknown target name: "o". [docutils]

Fix them by escaping trailing underscore and wildcard.

Fixes: 977de00dfcf87e ("VFS: move dentry_create() from fs/open.c to fs/namei.c")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251216115252.709078e8@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Sphinx reports htmldocs warnings:

Documentation/filesystems/api-summary:56: fs/namei.c:4952: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/filesystems/api-summary:56: fs/namei.c:4942: ERROR: Unknown target name: "o". [docutils]

Fix them by escaping trailing underscore and wildcard.
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index aefb21bc0944e3..d575d671b4f960 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4939,7 +4939,7 @@ EXPORT_SYMBOL(start_creating_user_path);
 /**
  * dentry_create - Create and open a file
  * @path: path to create
- * @flags: O_ flags
+ * @flags: O\_ flags
  * @mode: mode bits for new file
  * @cred: credentials to use
  *
@@ -4950,7 +4950,7 @@ EXPORT_SYMBOL(start_creating_user_path);
  * the new file is to be created. The parent directory and the
  * negative dentry must reside on the same filesystem instance.
  *
- * On success, returns a "struct file *". Otherwise a ERR_PTR
+ * On success, returns a "struct file \*". Otherwise a ERR_PTR
  * is returned.
  */
 struct file *dentry_create(struct path *path, int flags, umode_t mode,

---
base-commit: 981be27a72d163610e8e1c342373930bae80ac99
change-id: 20251218-dentry-inline-4091feeae685

Best regards,
-- 
Bagas Sanjaya <bagasdotme@gmail.com>



