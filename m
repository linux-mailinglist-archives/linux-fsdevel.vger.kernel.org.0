Return-Path: <linux-fsdevel+bounces-4639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2C480169A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189F11F210A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF93F8DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="R4w4SWTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D810F9
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:20 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5d3d0f862f7so18586657b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468740; x=1702073540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Me6PFFvsP0oOFqy+GUmI2ph2kV3o9d2iI4+tysJcII=;
        b=R4w4SWTTpW7KzYVQauN2gp9dEJLYJxXeRqI1dUjH1mnXrGQbcgYh/RB6BwEzM36zuG
         DR+rtwFmnvM2sqWFCbQNWzTQKlCHDSty1vPrjTtbpvSaJN9/+/wHKL6kABRwmlFxl5LK
         yH4YFJtJi19Q/C9rDLr7ycrIWX+yeGPalKjpwaKfSZZqFDMoIdj2Rw+jE7VI5VmaVFdZ
         oadJAyt0c3SX4UUCAI9KPtEfLDHlFTMNEQ7BV/ZEPCDJbJ78OVCNeF2BZ5vtfelrLstn
         GTOAituqiMU2JBHWZx7cMAIVOWem2YdtGnKFBC8LEWkyPkZn5Deky7uujQFPVqIvtbCY
         1hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468740; x=1702073540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Me6PFFvsP0oOFqy+GUmI2ph2kV3o9d2iI4+tysJcII=;
        b=mV2CP6CadkucDBjkW4OtRndzmhmOwxl5COKcFd9eqRrU/AjHjcyIXiTM9Fr6PxPghS
         a2XYnPW0U/K7mAPO47ZtMofrQRU8Kkysux1ZKoj6QroCHtbQCoZUPiecXFNp+LlQbo6w
         RDGJIM0kSMTEJp2UMWSvUBh3PQUlXUO+IHALvZpM/Wu86xDtbBjse5Fb8EtSBw8Xw/NN
         Kq12BMT4vwJFt+m7fqep5zT4GnoToZia4WOFsht1KziEdpN4jnp1LlH91W/lUm3CXKIq
         8YqSnmnQiEwM36DdChl1PYG1N5KqgyrLwQHwXmsdjDP895QJwnSh6sXwMZYcUoHI5aPE
         lSlQ==
X-Gm-Message-State: AOJu0YzvI/oBLJdpaSE/hB8vY7v1UcTUx1viud9ogaFq6g5W0NOtBErs
	s4BOPJsjhCXhniG4naJpIGyhMQ==
X-Google-Smtp-Source: AGHT+IEjo91gSjhScAPnqj4DgQfMU9fMdxAI0H9kp/g/wavzbx2+kweH1uzNpCiiW7mdbbh3M9wYVg==
X-Received: by 2002:a0d:ee41:0:b0:57a:cf8:5b4 with SMTP id x62-20020a0dee41000000b0057a0cf805b4mr25684019ywe.51.1701468739945;
        Fri, 01 Dec 2023 14:12:19 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w197-20020a0dd4ce000000b005d6cb0e49f9sm389137ywd.105.2023.12.01.14.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:19 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 19/46] btrfs: turn on inlinecrypt mount option for encrypt
Date: Fri,  1 Dec 2023 17:11:16 -0500
Message-ID: <a3f216c6e951b8d1b3cb9b96dcd6d44e1c19bd9b.1701468306.git.josef@toxicpanda.com>
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

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

fscrypt's extent encryption requires the use of inline encryption or the
software fallback that the block layer provides; it is rather
complicated to allow software encryption with extent encryption due to
the timing of memory allocations. Thus, if btrfs has ever had a
encrypted file, or when encryption is enabled on a directory, update the
mount flags to include inlinecrypt.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c |  3 +++
 fs/btrfs/super.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0e8e2ca48a2e..48d751011d07 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4585,6 +4585,9 @@ long btrfs_ioctl(struct file *file, unsigned int
 		 * state persists.
 		 */
 		btrfs_set_fs_incompat(fs_info, ENCRYPT);
+		if (!(inode->i_sb->s_flags & SB_INLINECRYPT)) {
+			inode->i_sb->s_flags |= SB_INLINECRYPT;
+		}
 		return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
 	}
 	case FS_IOC_GET_ENCRYPTION_POLICY:
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 39a338e92115..462a23db26af 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -946,6 +946,16 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
+	if (btrfs_fs_incompat(fs_info, ENCRYPT)) {
+		if (IS_ENABLED(CONFIG_FS_ENCRYPTION_INLINE_CRYPT)) {
+			sb->s_flags |= SB_INLINECRYPT;
+		} else {
+			btrfs_err(fs_info, "encryption not supported");
+			err = -EINVAL;
+			goto fail_close;
+		}
+	}
+
 	inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-- 
2.41.0


