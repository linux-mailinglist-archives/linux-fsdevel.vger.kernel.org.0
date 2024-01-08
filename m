Return-Path: <linux-fsdevel+bounces-7543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B908826D84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CF01C2231D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC86B42056;
	Mon,  8 Jan 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oZgET+09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193AE41774
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9F1083F737
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715819;
	bh=AZ1e4DQplobEkYb2oelZJP/g6uMuj6ixR2NKn4USgqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=oZgET+09Ka8MNP9uDRDSiEXoBiVx6GYwnMHXNDL4GQCvAdtU6ymuhi9QMZobpNiLI
	 y1ek8B3KBeTZsMv6+8Ks72uRfZCg4wtlJezxSwDVrM35BRcg/jtf+xCloGAJzR6X6z
	 +6xcfcmko6NoOhs4lLGqR7TiSKPxzySaPUpzAERXy+22ef1l8OFK0/3UEYGggcRehO
	 E0GDqXmEwpqBocf/8ihFCUoiA62p2Tp90+5IJhkIe4hBNWne+pXHJ0izdMAIIb8i0z
	 OLoVaSAU5ObfDlMaLWu+Zg/BwHqwa9SXQVv2JJTIARsfe5hKzFDxWRceft2BaXmE0K
	 kuDSLTFwAhlig==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50eaa746598so1188809e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 04:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715819; x=1705320619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZ1e4DQplobEkYb2oelZJP/g6uMuj6ixR2NKn4USgqo=;
        b=LIITaWso6AxY4rlRlpCzNdi+IQxFbFewqtgUeCIVTxVX5+YbzM4RqV65FLvunaAUOz
         tJvg1tD3H64O+jQOv8xvLUh0lcrGU/zjg7WDmoazExg9raOMGGA8kf/VHjQVKOHuWyH0
         /0opqXKwD6n8Vg1gXD6RRqHtgXge6PjZ/YWNqxpQ8x2Hhn2MLWQekCbdBoz0SAsxsluv
         1enpZCC+0dB+NYynb7Phh9ds7WqrUUxnZbhRayQ5e5aHQkduFh1BK7bFQ7kw7QF940Dj
         I5wYoFCQIGpp7vLmI1bVqJZNYCmIJwSZ9F1Beo/rQrI7sFJS90/ii5rzGHq91Lfsudj3
         1uYg==
X-Gm-Message-State: AOJu0Yzez3KkKir416wkbVLgJsfqQxFEAcg8ZRmpVcQv0F+O9hfarzxF
	h6/ERZJqu5/lKbIJRhHR7nsk6h7EKMGhAY8kixQC23QpZL8EWWA3pavDTKdyqM84RzdiUZ1bn2Z
	/dUkhZSLLTtlXxAqqAoKwtX7Qjpp4SH42bvmVhobn9N+P3iKjjw==
X-Received: by 2002:ac2:44a8:0:b0:50e:7c6e:b411 with SMTP id c8-20020ac244a8000000b0050e7c6eb411mr1194728lfm.103.1704715819056;
        Mon, 08 Jan 2024 04:10:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7Nzn++Vuip8dKLKr2jYqNsa9FafczX9ul7wwW/1w2B0tbqsqXsHCty5yPcFNCQXD2vOYw2Q==
X-Received: by 2002:ac2:44a8:0:b0:50e:7c6e:b411 with SMTP id c8-20020ac244a8000000b0050e7c6eb411mr1194719lfm.103.1704715818859;
        Mon, 08 Jan 2024 04:10:18 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:10:17 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/9] fs/fuse: drop idmap argument from __fuse_get_acl
Date: Mon,  8 Jan 2024 13:08:22 +0100
Message-Id: <20240108120824.122178-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to have idmap in the __fuse_get_acl as we don't
have any use for it.

In the current POSIX ACL implementation, idmapped mounts are
taken into account on the userspace/kernel border
(see vfs_set_acl_idmapped_mnt() and vfs_posix_acl_to_xattr()).

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/acl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 3d192b80a561..3a3cd88bd3d7 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -12,7 +12,6 @@
 #include <linux/posix_acl_xattr.h>
 
 static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
-					struct mnt_idmap *idmap,
 					struct inode *inode, int type, bool rcu)
 {
 	int size;
@@ -74,7 +73,7 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
 	if (fuse_no_acl(fc, inode))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return __fuse_get_acl(fc, idmap, inode, type, false);
+	return __fuse_get_acl(fc, inode, type, false);
 }
 
 struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu)
@@ -90,8 +89,7 @@ struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu)
 	 */
 	if (!fc->posix_acl)
 		return NULL;
-
-	return __fuse_get_acl(fc, &nop_mnt_idmap, inode, type, rcu);
+	return __fuse_get_acl(fc,  inode, type, rcu);
 }
 
 int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
-- 
2.34.1


