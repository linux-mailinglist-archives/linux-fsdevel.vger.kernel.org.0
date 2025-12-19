Return-Path: <linux-fsdevel+bounces-71701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3761CCE1DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 02:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BDDF30115DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 01:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F62264B0;
	Fri, 19 Dec 2025 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhvgVWK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0E1E1DF0;
	Fri, 19 Dec 2025 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766106396; cv=none; b=NO/hIWV44ASCqkl807eBJoocljXG+gXs6/aL1rJutoE92pb9t5xqzl89+DzKW7S711qsSLSRogrw+AOgvlu4z6TGgugDoTp94nzyulpY0q70DwXonNngkEcDhXvjybP9xg9kkVGG9M+oHRJCrUQOpTQNhDWr8HZKSoHONf7S4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766106396; c=relaxed/simple;
	bh=Jz6xTdkIWbRf4JwQ0oyn1ju2pEVKbtDCK11HDqTa9Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F1B0kfazQiXzyqt7eVCGyE7IFth3NK5AAJtLV5XzUj2abo0yoxgNkvBV5msnXuj/U7beiRnvcfXDCkheE+Bkfvi7azOtXlOVxoOJlC3nIW98Klcx3tppwcTu/tQxAvZrBjllZ+T9HahQNp4YR7/9ifoQa6TFr1/2EV8SDAn/2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhvgVWK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17E9DC4CEFB;
	Fri, 19 Dec 2025 01:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766106396;
	bh=Jz6xTdkIWbRf4JwQ0oyn1ju2pEVKbtDCK11HDqTa9Dc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RhvgVWK/jpW7BphXF9m3/hhkZ9eebZlK1MzHWfC6ykhaG/LtKa6zU/2YO+PcA6DOh
	 6hpt5lrNwxhQQm+/LzS/zLkVNYvTdHOuhvxM+xa8nGgSMkBwgEnkXXc3vrOGVLYUnE
	 ZicHL6azCfajwuf4gH+qwNlQg2wMbTgfdkAnEg4G16FSsyXkEpZGUW4fiZKoLlneqe
	 OKV3uCrDjGT/Tk/JOEdfPiXdAcDL82ko2MPxCxgtHA5vtlywXD1RS4h8h1mmclbSfi
	 9SjXviPgCwViQ0VZrQbH0+PS+9fT+oELxEKKjTTz+v0SOiSvx4qUK0zIsPEAV2F7ZQ
	 asXjGzF9/2oAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057B6D711D2;
	Fri, 19 Dec 2025 01:06:36 +0000 (UTC)
From: Bagas Sanjaya via B4 Relay <devnull+bagasdotme.gmail.com@kernel.org>
Date: Fri, 19 Dec 2025 08:06:19 +0700
Subject: [PATCH v2] VFS: fix dentry_create() kernel-doc comment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-dentry-inline-v2-1-c074b5bfb3a6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAqlRGkC/3XMQQqDMBCF4avIrDslE6JNu+o9igtJJjqgsSQiF
 fHuTd13+T943w6Zk3CGR7VD4lWyzLGEvlTghi72jOJLg1a6Jk0WPcclbShxlMho1J0Cc8eNraF
 83omDfE7v1ZYeJC9z2k5+pd/6T1oJCRWpWzDOW22aZz91Ml7dPEF7HMcX3K8/raoAAAA=
X-Change-ID: 20251218-dentry-inline-4091feeae685
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Benjamin Coddington <bcodding@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stephen Rothwell <sfr@canb.auug.org.au>, 
 Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835;
 i=bagasdotme@gmail.com; s=Zp7juWIhw0R1; h=from:subject:message-id;
 bh=NzFzLqPLn+tL6t15hgLivh9hhV8Uu6nQkc/2k2IeoUw=;
 b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkuSyULj190sH/5XED3WMkkxz3lb26n33RX2NzEWeaRy
 Hw5miWyo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABNJmMnwV1ahIuv90ZXmvIGv
 UiTn+k12lv6p8y7L+fTqCsnCj5X/TzAyNKv995u/dqLRoUAXl9cinodO5akWbjgRv8fKLO7yBbH
 FXAA=
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

Fix them up.

Fixes: 977de00dfcf87e ("VFS: move dentry_create() from fs/open.c to fs/namei.c")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251216115252.709078e8@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes in v2:
- Add ellipsis placeholder on @flags description (Al Viro)
- Phrase return value struct (Al Viro)
- Link to v1: https://lore.kernel.org/r/20251218-dentry-inline-v1-1-0107f4cd8246@gmail.com
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index aefb21bc0944e3..ad6a9930dc68b5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4939,7 +4939,7 @@ EXPORT_SYMBOL(start_creating_user_path);
 /**
  * dentry_create - Create and open a file
  * @path: path to create
- * @flags: O_ flags
+ * @flags: O\_... flags
  * @mode: mode bits for new file
  * @cred: credentials to use
  *
@@ -4950,7 +4950,7 @@ EXPORT_SYMBOL(start_creating_user_path);
  * the new file is to be created. The parent directory and the
  * negative dentry must reside on the same filesystem instance.
  *
- * On success, returns a "struct file *". Otherwise a ERR_PTR
+ * On success, return a pointer to opened file. Otherwise a ERR_PTR
  * is returned.
  */
 struct file *dentry_create(struct path *path, int flags, umode_t mode,

---
base-commit: 981be27a72d163610e8e1c342373930bae80ac99
change-id: 20251218-dentry-inline-4091feeae685

Best regards,
-- 
Bagas Sanjaya <bagasdotme@gmail.com>



