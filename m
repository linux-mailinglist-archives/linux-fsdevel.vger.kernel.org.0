Return-Path: <linux-fsdevel+bounces-4635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B994C80168C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7006F1F210BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DD1619A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TWxIjlLD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB9D6C
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:16 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d7201c9d51so862847b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468736; x=1702073536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7FY9F3PNpFwIYkm5ynwFuIi/6ljrtymCrqiOPVng78=;
        b=TWxIjlLDRpH9bgw3/lqRS57LZldUGEFBKrUu84va7NnIR+gdHXWpqeCUgqgGDy/Bth
         P/35qWiOFSKOO9RXAFndWFysZWXuhjN2SB+l18BuHtLrQnTZJvDZjF4SUfoFjsetAx15
         oi1TbSldRiUzdW6psiti+SP/dE/6v3KBRWOkZmAKBloPPkpduL9JYI7QckHps6aGZ2PJ
         1xyUVTu4K69+NQy+BvghbA/SttpjIlyp99gMU05ZtFSuabyjpDkLHlBu73nowKDX1U/9
         dbxpj3xTRAxC6hBErmkjAXOL5f3t1NQnfOQPqSwIlABJ35Z0ocdXOkm0g8v9yLgW8+ok
         Wgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468736; x=1702073536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7FY9F3PNpFwIYkm5ynwFuIi/6ljrtymCrqiOPVng78=;
        b=dW+rR5FsxUK4EOIRBhZk8lSOuq4MrS7MK5kzwtZ4wzOXCY8zmoZWbT1ySkRqDVQbmr
         LwlXk2cPAZ1VV6UlBhnDmC7D1jYGhB1LijPwwldpavhUWOuxA3XOtwCgDHUBwa3fM0da
         oY3PcyOVfI7OOqxNcIm8M6nF3mJteVdxzx9zYU2NYc7kab2L3MeVotzIdYQTkjEeUkS1
         9nQwzXbCqSZnni/8qz7M8vFhA8nnWQtCbxOymPkc4HEDaPNvWMUQYYgN2C07NVy+FHHH
         3o00Mq3WJjQLRfygyXBhDTCQnNk9et3jEw6uwAQ7ec5VEMNa/Yf5lbcNBAlIAtE/I1QY
         M6mQ==
X-Gm-Message-State: AOJu0YyBK0jduBcyAqteI1XtU/PlWkiNTilL7PMjrREHY+PDpxOQoYO+
	2RqYxMowOKvYmrx1Xx440YtLTQ==
X-Google-Smtp-Source: AGHT+IE/fapadgGWO7uKbXUjZX7CYQ/wtzItNgDJhEus4QLqw3fvL1mVDChh5SIzWPrBQwQT7yK8xA==
X-Received: by 2002:a81:b049:0:b0:5d2:913a:640d with SMTP id x9-20020a81b049000000b005d2913a640dmr357620ywk.47.1701468735788;
        Fri, 01 Dec 2023 14:12:15 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d19-20020a81ab53000000b005d336130ea3sm326221ywk.70.2023.12.01.14.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:15 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 16/46] btrfs: implement fscrypt ioctls
Date: Fri,  1 Dec 2023 17:11:13 -0500
Message-ID: <0a93a7133dabe9a3d65439af44bab19ba8c892ef.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@osandov.com>

These ioctls allow encryption to actually be used.

The set_encryption_policy ioctl is the thing which actually turns on
encryption, and therefore sets the ENCRYPT flag in the superblock. This
prevents the filesystem from being loaded on older kernels.

fscrypt provides CONFIG_FS_ENCRYPTION-disabled versions of all these
functions which just return -EOPNOTSUPP, so the ioctls don't need to be
compiled out if CONFIG_FS_ENCRYPTION isn't enabled.

We could instead gate this ioctl on the superblock having the flag set,
if we wanted to require mkfs with the encrypt flag in order to have a
filesystem with any encryption.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6acf898f693e..9968a36079c4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4573,6 +4573,34 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_fslabel(fs_info, argp);
 	case FS_IOC_SETFSLABEL:
 		return btrfs_ioctl_set_fslabel(file, argp);
+	case FS_IOC_SET_ENCRYPTION_POLICY: {
+		if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
+			return -EOPNOTSUPP;
+		if (sb_rdonly(fs_info->sb))
+			return -EROFS;
+		/*
+		 *  If we crash before we commit, nothing encrypted could have
+		 * been written so it doesn't matter whether the encrypted
+		 * state persists.
+		 */
+		btrfs_set_fs_incompat(fs_info, ENCRYPT);
+		return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
+	}
+	case FS_IOC_GET_ENCRYPTION_POLICY:
+		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
+	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
+		return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
+	case FS_IOC_ADD_ENCRYPTION_KEY:
+		return fscrypt_ioctl_add_key(file, (void __user *)arg);
+	case FS_IOC_REMOVE_ENCRYPTION_KEY:
+		return fscrypt_ioctl_remove_key(file, (void __user *)arg);
+	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
+		return fscrypt_ioctl_remove_key_all_users(file,
+							  (void __user *)arg);
+	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
+		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
+	case FS_IOC_GET_ENCRYPTION_NONCE:
+		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
 	case FITRIM:
 		return btrfs_ioctl_fitrim(fs_info, argp);
 	case BTRFS_IOC_SNAP_CREATE:
-- 
2.41.0


