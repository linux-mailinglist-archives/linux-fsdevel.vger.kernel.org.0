Return-Path: <linux-fsdevel+bounces-1023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C97D4F90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A076C1C20BD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 12:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39826E2D;
	Tue, 24 Oct 2023 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAOQ4cad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC518E2D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 12:15:06 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE8111
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 05:15:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-408002b5b9fso36289995e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698149702; x=1698754502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v30A5IhOIwmg5ZUv7VHg9IzaWKw352nSR9f8nRk9WvE=;
        b=RAOQ4cad1gSbErcxET4L9XFY6rwasLYQZNMkQkz8uW+cJBF9G0J2KEoLoq49+k0cVF
         a7W7c96CIOd9U4EkXAHjWyX2t6mCnGWbZyH+G8gEEcY3rr4idcSgebp2uNM3/Kaz4PZU
         0KIkmUwphgNBB+KdJE1Z8IrhKK+/Ezi8EQbkCWa9yGz31knPZ9exyiPk+NLPqemc70fB
         D75YJbL1fYj26lJR9QemauR2ZOH4+VGHu47QtXyUMZ6aG7BTa2GoEU7VmMbldiCryefU
         n/P/ghvquurvsUzg9ehw5FeJ5wLA8kDCe2sEvRKcUWpfdin9GBHtCEkJqqyMwedsNdGX
         vakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149702; x=1698754502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v30A5IhOIwmg5ZUv7VHg9IzaWKw352nSR9f8nRk9WvE=;
        b=gEyfZ/YGnJSSdFMSatBNUK9VRCxahrFhetHvKlkuNKEc5jLkuTVEwx5uhQoiK9t99d
         rHTC3tSNlk05Jh+4SY+pTdw0zPzm20df55i1cyNGJpSX93fg89PQ0/FYVLYxq+51CLqY
         /4E0j9spICuCbVLcQuVKjOYmYMZ2BNF2ksk5phfy1jmP8ccV9woZ9Xefdr+TGGBxTpYw
         MqIM6lSjQen1d3fgx+6J8zXwo0jaXtzvQMWFBQT6rdI3LaDW+QHAC0XL0Z/DicQW4WL5
         yrIgCcsCfPP25MBoQHs4IKo/ZbutB35zrT0YUjkBu6Bw3nXkqu1nhApRZZZcurs/gBi3
         jPvg==
X-Gm-Message-State: AOJu0Yz8igygDcYr4JvgrkxR/M3ElgyQGtn+CX/G5+Lgc4s1uMfdWoDe
	xQx/cO6wtVFhx4TR8xq7ypGEXWIvVojivQ==
X-Google-Smtp-Source: AGHT+IGaaeejxsHE1XPUoMKeVKqKcrNpXIgbSK+S2IX02wNM1D+7tdmte5TpOYGbbQp1wHouwdrmPw==
X-Received: by 2002:a05:600c:3d0e:b0:408:c6eb:9a87 with SMTP id bh14-20020a05600c3d0e00b00408c6eb9a87mr6072156wmb.24.1698149701367;
        Tue, 24 Oct 2023 05:15:01 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v19-20020a05600c471300b00405959bbf4fsm12035058wmo.19.2023.10.24.05.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:15:01 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] freevxfs: derive f_fsid from bdev->bd_dev
Date: Tue, 24 Oct 2023 15:14:57 +0300
Message-Id: <20231024121457.3014063-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The majority of blockdev filesystems, which do not have a UUID in their
on-disk format, derive f_fsid of statfs(2) from bdev->bd_dev.

Use the same practice for freevxfs.

This will allow reporting fanotify events with fanotify_event_info_fid.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christoph,

This is only compiled tested, but the change is quite trivial.
Could you pick up this patch? or ACK it so that Christian can take it?

Thanks,
Amir.

 fs/freevxfs/vxfs_super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index 310d73e254df..f13f47fd4279 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -76,6 +76,7 @@ vxfs_statfs(struct dentry *dentry, struct kstatfs *bufp)
 {
 	struct vxfs_sb_info		*infp = VXFS_SBI(dentry->d_sb);
 	struct vxfs_sb *raw_sb = infp->vsi_raw;
+	u64 id = huge_encode_dev(dentry->d_sb->s_bdev->bd_dev);
 
 	bufp->f_type = VXFS_SUPER_MAGIC;
 	bufp->f_bsize = dentry->d_sb->s_blocksize;
@@ -84,6 +85,7 @@ vxfs_statfs(struct dentry *dentry, struct kstatfs *bufp)
 	bufp->f_bavail = 0;
 	bufp->f_files = 0;
 	bufp->f_ffree = fs32_to_cpu(infp, raw_sb->vs_ifree);
+	bufp->f_fsid = u64_to_fsid(id);
 	bufp->f_namelen = VXFS_NAMELEN;
 
 	return 0;
-- 
2.34.1


