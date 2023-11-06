Return-Path: <linux-fsdevel+bounces-2169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F787E2F79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E79B20A1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E60F2FE09;
	Mon,  6 Nov 2023 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ysTkbHTU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48D2EB1A
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:45 +0000 (UTC)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015AAD7F
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:44 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4ac20c41e82so881037e0c.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308523; x=1699913323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn4wfDb6jDre0GFiLqI3t3dfv/iDXvlKvBWKVyZYNgA=;
        b=ysTkbHTU8iID+jD5wYajxXB1YHDYloGiFBgfOiB7r0byuSyXPAzdEfi/oUDV8UyB5S
         3SgqrJXiNJ5VkAY/LC8eFo9E7/33+Qd3zAeZXrw23NpK20WUNT5Q9+qNVB11iGcpGkOB
         FtP02TbLWojHGW8cRdlgENI+2q32QA6ZlxjtQEPJOe6m5wxjzv0sBubS3jFub8Vjpbm2
         aGdTu9HuDSycDvERVVzkCRNVuGefZtQfY7sC+bNz/3pzIxjHEFKlivmCBpcmZscN6bIQ
         bmP8BXLgNlicVA2+WS6x0mbmR6F1XQcQZmlwe2ojELzTdGZvg77Fb1nqvZYnp569kE9X
         aDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308523; x=1699913323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn4wfDb6jDre0GFiLqI3t3dfv/iDXvlKvBWKVyZYNgA=;
        b=MM0H1nNzp9kJDg1r7FBeJZUsJ+KoVUMomAtnpqvu5wWuMqUOES/5sxjuqV03jvRsin
         hLCuZp615dGFPqKfq+nOVtizO/mLn7hMnrec64V10iZZTcZW8N+3dMkuWQSb45uHd3IG
         fxo6jPT4cKlExu19uuYP8sXmK2SbuqSg4WFajreRqEzArGqMG8AK7WXEAXffwkO0psgg
         WIpQL0Tf1axcFKLYYixkY0gtp6UQJYRRyNY7TwjBGvAAEQ+YTx/WstqBEuR+HOvvufkW
         k9mOEuqz1PJWJjgy+IT+yGwNnvKQR5iQj0xDzAIjy2bVcSZtSZ2bK2ESn4X/pY/anD5d
         Z9ww==
X-Gm-Message-State: AOJu0YzRZZHtQXTPPB5O5j0BKUvY3cP39yPiPP/Sdc9YHpPgvuUCAz6s
	gzo8eng8/cJE2gNwTbQuXlUZ6SCs1OYio42faE3L8g==
X-Google-Smtp-Source: AGHT+IGzjDwWUkB8LX7DQ7zorH80M40pkRDuP9BnGAXmsOru2oCKSePCo909yhMYibpvOivXGd/7UQ==
X-Received: by 2002:a1f:2c15:0:b0:49e:2145:1651 with SMTP id s21-20020a1f2c15000000b0049e21451651mr26913118vks.6.1699308523102;
        Mon, 06 Nov 2023 14:08:43 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id df1-20020a05622a0ec100b00403cce833eesm3744457qtb.27.2023.11.06.14.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:42 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 07/18] btrfs: add a NOSPACECACHE mount option flag
Date: Mon,  6 Nov 2023 17:08:15 -0500
Message-ID: <7723acf40642ab84b48f25f31e2894120d035b5d.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the old mount API we'd pre-populate the mount options with the
space cache settings of the file system, and then the user toggled them
on or off with the mount options.  When we switch to the new mount API
the mount options will be set before we get into opening the file
system, so we need a flag to indicate that the user explicitly asked for
-o nospace_cache so we can make the appropriate changes after the fact.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 1 +
 fs/btrfs/fs.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 072c45811c41..c70e507a28d0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2938,6 +2938,7 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 {
 	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
 	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
+	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
 }
 
 /*
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 318df6f9d9cb..ecfa13a9c2cf 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -188,6 +188,7 @@ enum {
 	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 27),
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 28),
 	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
+	BTRFS_MOUNT_NOSPACECACHE		= (1UL << 30),
 };
 
 /*
-- 
2.41.0


