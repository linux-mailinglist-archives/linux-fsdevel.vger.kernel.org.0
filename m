Return-Path: <linux-fsdevel+bounces-7537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F70826D71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B4F1C22281
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C463FE5F;
	Mon,  8 Jan 2024 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jy6tpFZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B93FB28
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C9473F743
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715799;
	bh=GtdhYLDKs9o20JRSF0JGIkdiKLo4c8K8/G8DvoYAW44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=jy6tpFZhfYdMKPc2T1yw/AlsYk6up/wkEUIJGDNovxV5t6t5jdqH99sS/u2QstfSR
	 XRWa6kEVslGqkz6HSenY6qhAQwB9IcvOsozqhqZBYKjdYqO1I5is1AT20cLWGcc0FR
	 94v1aUoxtjwlszZabirRWKWCYdZX0bhFYi6WlLjpDQm2WBR/bFAUFfSWbtfClfn//O
	 HYp+zsuN3z6K9SWM59S7F6zwSeryFxcrUhRz9R4xH9DnBWmhChaqvMIQhjTWBVWyTj
	 EERJcFeZ0B5GBr3iY+ZhC5k4HLCm7Q6D8+ZlQf2QDVC/oM6ycmcp6tQub6dRFPTXk0
	 G114XajQD8jqA==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e58b37aebso862120e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 04:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715798; x=1705320598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtdhYLDKs9o20JRSF0JGIkdiKLo4c8K8/G8DvoYAW44=;
        b=A76k7g5LomkbnyjrmMDYUant/D79wa/EHxaYpaCsaP0JWyXPlSKkimUsfDD8S7V4b3
         RGJBNY71/VDdGwBEWQ6pGqcH4iOi7dqpZJ1LscqmCAxjh8qceyIhC5d5y9FWCLpP9zI6
         bzLMuBi7m02yOqgyl7zKPV6eS2y23zbe10bGdp5QeLyC4eoY6p2qQrMzp6JWRuLw267B
         7xOMra8k4bLurmgeTI2TkIMXUN+1Hik0xiTPdU/f+26X78RKiK/ik+6y8H4sw2Ijwy8j
         Ev63zfaxrOrK6S3ax6jk7UXYUUc/MXj5cp3hVj8dCM326EwhMTFCouS0w0P/tDbVKwxa
         LosA==
X-Gm-Message-State: AOJu0YxnCKrMXOPGFFRjqsJHYLbN+Zttx0xuo+qzMaXjbJcO7jjt4ZBx
	ABRe+4Op3jdQR8wagFQc0vsKVLyAnIkfVfuoZpCnYObAO6pObRXrZj7iRc3qgg3jzQBJSYNW5cm
	R83TfPxogaELzP48MT6gmnF+NWwdwAiFGTzcI3e4ORu6s1KGGaw==
X-Received: by 2002:a05:6512:10d6:b0:50e:75ee:ec46 with SMTP id k22-20020a05651210d600b0050e75eeec46mr795190lfg.2.1704715798663;
        Mon, 08 Jan 2024 04:09:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUqcUNjknvfP6Ue7/xRuCDchF5ew85PuPQCa7e/qAm97tSZSidsvc4p703nLWJuX0caRvEzw==
X-Received: by 2002:a05:6512:10d6:b0:50e:75ee:ec46 with SMTP id k22-20020a05651210d600b0050e75eeec46mr795186lfg.2.1704715798368;
        Mon, 08 Jan 2024 04:09:58 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:09:57 -0800 (PST)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/9] fs/namespace: introduce fs_type->allow_idmap hook
Date: Mon,  8 Jan 2024 13:08:16 +0100
Message-Id: <20240108120824.122178-2-aleksandr.mikhalitsyn@canonical.com>
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

Right now we determine if filesystem support vfs idmappings
or not basing on the FS_ALLOW_IDMAP flag presence. This
"static" way works perfecly well for local filesystems
like ext4, xfs, btrfs, etc. But for network-like filesystems
like fuse, cephfs this approach is not ideal, because sometimes
proper support of vfs idmaps requires some extensions for the on-wire
protocol, which implies that changes have to be made not only
in the Linux kernel code but also in the 3rd party components like
libfuse, cephfs MDS server and so on.

We have seen that issue during our work on cephfs idmapped mounts [1]
with Christian, but right now I'm working on the idmapped mounts
support for fuse and I think that it is a right time for this extension.

[1] 5ccd8530dd7 ("ceph: handle idmapped mounts in create_request_message()")

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/namespace.c     | 3 ++-
 include/linux/fs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fbf0e596fcd3..02eb47b3d728 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4300,7 +4300,8 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 		return -EPERM;
 
 	/* The underlying filesystem doesn't support idmapped mounts yet. */
-	if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP))
+	if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP) ||
+	    (m->mnt_sb->s_type->allow_idmap && !m->mnt_sb->s_type->allow_idmap(m->mnt_sb)))
 		return -EINVAL;
 
 	/* We're not controlling the superblock. */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..f2e373b5420a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2377,6 +2377,7 @@ struct file_system_type {
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
+	bool (*allow_idmap)(struct super_block *);
 	struct dentry *(*mount) (struct file_system_type *, int,
 		       const char *, void *);
 	void (*kill_sb) (struct super_block *);
-- 
2.34.1


