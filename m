Return-Path: <linux-fsdevel+bounces-983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D47D4914
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 09:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620A41C20B58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E20414F88;
	Tue, 24 Oct 2023 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQo/BDGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72E15483
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 07:55:44 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33A11A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 00:55:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083f61312eso33757175e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698134141; x=1698738941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+18Cg9WmaAh8a3daasUHdD04vDnvoaOPywc9c9gIuw=;
        b=WQo/BDGEzqLN7tNiLQuoOFHvZfLVZKwF/BXzYhsP4nCXQgp4eDD7wQkVGR1HQrD1n8
         hSjcQyGDP0y9L3R1rGG8Ud/HXo8JmHZ+FKH4cdezXbg16SPMQuUNM448HXx2qn8xyu3j
         iAYEFl+hmIlo0b3wop6UOtd5N5nUYQrRp/W7drGvD14w0h00zvamyZEmuP6aajEBENy7
         p9xUwL6W9Yq2gYNqDzREERDTbjcV1yQoDl63n7j18C940xDLbXr9o54/0MqjtAzeLzgj
         oaH9uA6NWAX+B3LbgJveXxJ4YJLXumBzh73lsNTIvgUsdwk1bO+Wo5nc9z5dpg8QVFbR
         /VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698134141; x=1698738941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+18Cg9WmaAh8a3daasUHdD04vDnvoaOPywc9c9gIuw=;
        b=Pq7T5E4Y+qGI5ektPY+E9c2WhXhVpR5Bl4RPpxfUZVIBDQ3yE59W9jEemz8An5xOdc
         NGtFdSGoOzl2pfs1qkh7Rt4424Ll+dvqtdECZWsaxlcNusgHIZKWjV+3Yn2VPZlx1ydu
         gGLSifFoZFM63cuwsxGb7+k16OTZiA+/Eja9xTiStSJFRGjeQkgiIgTqngTXZ6cIvVG/
         fMHNBCciOSfKqdc+jvPmML1Z0JtDwHPgQFGVeZ+02EAubuzV0m8eF9B05vKmJPh/0CbY
         bnxo3Xj6R7Q4wG4bSlHM5YX3Z7zCYxr2rR/EsalXz5yMyRYJgjITjKV38J2t3d/OujoL
         LG0g==
X-Gm-Message-State: AOJu0YyAc1gcwAJourk85FaNKS37lvOKjidpALVkWhOuxKiP4uVvbv0+
	a/OJJz9UWrW34F3z64wBMP4=
X-Google-Smtp-Source: AGHT+IGHTmUr+pgzGDmBFz1x75w99MYvBGvhAeWEJxniTpOSArnqI1lUIZkOJfE6woIeL+zwVQwkKw==
X-Received: by 2002:a1c:770a:0:b0:406:53e4:4d23 with SMTP id t10-20020a1c770a000000b0040653e44d23mr8604561wmi.23.1698134140800;
        Tue, 24 Oct 2023 00:55:40 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id iv15-20020a05600c548f00b00405c7591b09sm11376199wmb.35.2023.10.24.00.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:55:40 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Bob Peterson <rpeterso@redhat.com>,
	gfs2@lists.linux.dev
Subject: [PATCH] gfs2: fs: derive f_fsid from s_uuid
Date: Tue, 24 Oct 2023 10:55:35 +0300
Message-Id: <20231024075535.2994553-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2 already has optional persistent uuid.

Use that uuid to report f_fsid in statfs(2), same as ext2/ext4/zonefs.

This allows gfs2 to be monitored by fanotify filesystem watch.
for example, with inotify-tools 4.23.8.0, the following command can be
used to watch changes over entire filesystem:

  fsnotifywatch --filesystem /mnt/gfs2

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Andreas,

I do not have a test setup for gfs2, but this change it quite trivial,
so I am posting it only compile tested.

There is no need to test fanotify. It enough to test statfs returns
a non-zero f_fsid, e.g.:

  strace -e fstatfs du /mnt/gfs2

Thanks,
Amir.

 fs/gfs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 02d93da21b2b..ea769af6bb23 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1006,6 +1006,7 @@ static int gfs2_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = sc.sc_dinodes + sc.sc_free;
 	buf->f_ffree = sc.sc_free;
 	buf->f_namelen = GFS2_FNAMESIZE;
+	buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);
 
 	return 0;
 }
-- 
2.34.1


