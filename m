Return-Path: <linux-fsdevel+bounces-2260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCAB7E41D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 15:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9202810C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF8E31584;
	Tue,  7 Nov 2023 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSkVJ5+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9DF3158E
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 14:30:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D239798
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 06:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699367415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZQt7pg+hz5jNDMSq3EOjA/DhangBBizVIEI+137usOY=;
	b=NSkVJ5+ftE4JkhKMQ3cbTufoCWpr/+yEx8qOU6q7C10vLgZzfqPLSrgzjZhvzyYOC3gP5u
	1T2E3EFQ/j36/UlNL75HyNh4L72uoI0tcJKMz2UUkwhctj7pouJkLmshHHJUHCjykrmuvW
	4K6uNHwArFo9+aNEOkEne3NzVwxECPQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-V9kYxtMfNECgslkEdv3_hw-1; Tue, 07 Nov 2023 09:30:13 -0500
X-MC-Unique: V9kYxtMfNECgslkEdv3_hw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2800e025bc7so4417127a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 06:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699367412; x=1699972212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQt7pg+hz5jNDMSq3EOjA/DhangBBizVIEI+137usOY=;
        b=niJCZ3ylihFKM24NjRfV8OOli/i9dye4E6sHdyKxNy1aZPN2crWV/V0ZTdpRcVRusW
         88LWBH7MXiLaERPFxqUdOAA82yWb6dxWFx+9CtrAP56WpdiEs4/Omb/BfmTb6T7pEc+C
         0ho162XnB4dnk1HgKqQgbjvE/lKdQsE20s1uOPifCde1L2z4ERX6vKL46i4llAvqOp3h
         f6Z/KShFfanycTA4943mrlwBdbYB9QDx63zAawc3U8Bo6CzpujqQn9QSWq7R4eDf2dEK
         IiiIDSGi9CY1ZwfA4gZfaBjegcRZHo+udjFAwWxsHSu6P5MGIVw5uREHWGjecwipzOHu
         R1PA==
X-Gm-Message-State: AOJu0Yxz5tF/D4S/J2PVA8sMFVvBx2UVG14JpgRZhMK7qT49MAEES9+2
	mE+CuI0Ihdvash7+6RQuyaihKIltesmhNScQgCMx8oqD/iH/W2jIq0/gpdl6k7qLe55XMrTXter
	v7OpOnAcRoMwF41m28ZxW8PShdg==
X-Received: by 2002:a17:90b:384b:b0:280:fc91:ad5d with SMTP id nl11-20020a17090b384b00b00280fc91ad5dmr4664061pjb.19.1699367412375;
        Tue, 07 Nov 2023 06:30:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuwPioMxYU0e32tVho4oh9okqj5EPRVrzMFmBiBPbOflyaQu6oF+fw0oH5qrNe5mI5XH8QUw==
X-Received: by 2002:a17:90b:384b:b0:280:fc91:ad5d with SMTP id nl11-20020a17090b384b00b00280fc91ad5dmr4664041pjb.19.1699367412059;
        Tue, 07 Nov 2023 06:30:12 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id f92-20020a17090a706500b0026f90d7947csm7762399pjk.34.2023.11.07.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:30:11 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] exfat: Fix uninit-value access in __exfat_write_inode()
Date: Tue,  7 Nov 2023 23:30:02 +0900
Message-ID: <20231107143002.1342295-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported the following uninit-value access issue:

=====================================================
BUG: KMSAN: uninit-value in exfat_set_entry_time+0x309/0x360 fs/exfat/misc.c:99
 exfat_set_entry_time+0x309/0x360 fs/exfat/misc.c:99
 __exfat_write_inode+0x7ae/0xdb0 fs/exfat/inode.c:59
 __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163
 exfat_truncate+0x121/0x540 fs/exfat/file.c:211
 exfat_setattr+0x116c/0x1a40 fs/exfat/file.c:312
 notify_change+0x1934/0x1a30 fs/attr.c:499
 do_truncate+0x224/0x2a0 fs/open.c:66
 handle_truncate fs/namei.c:3280 [inline]
 do_open fs/namei.c:3626 [inline]
 path_openat+0x56c6/0x5f20 fs/namei.c:3779
 do_filp_open+0x21c/0x5a0 fs/namei.c:3809
 do_sys_openat2+0x1ba/0x2f0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_creat fs/open.c:1531 [inline]
 __se_sys_creat fs/open.c:1525 [inline]
 __x64_sys_creat+0xe3/0x140 fs/open.c:1525
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 exfat_set_entry_time+0x302/0x360 fs/exfat/misc.c:99
 __exfat_write_inode+0x7ae/0xdb0 fs/exfat/inode.c:59
 __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163
 exfat_truncate+0x121/0x540 fs/exfat/file.c:211
 exfat_setattr+0x116c/0x1a40 fs/exfat/file.c:312
 notify_change+0x1934/0x1a30 fs/attr.c:499
 do_truncate+0x224/0x2a0 fs/open.c:66
 handle_truncate fs/namei.c:3280 [inline]
 do_open fs/namei.c:3626 [inline]
 path_openat+0x56c6/0x5f20 fs/namei.c:3779
 do_filp_open+0x21c/0x5a0 fs/namei.c:3809
 do_sys_openat2+0x1ba/0x2f0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_creat fs/open.c:1531 [inline]
 __se_sys_creat fs/open.c:1525 [inline]
 __x64_sys_creat+0xe3/0x140 fs/open.c:1525
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable ts created at:
 __exfat_write_inode+0x102/0xdb0 fs/exfat/inode.c:29
 __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163

CPU: 0 PID: 13839 Comm: syz-executor.7 Not tainted 6.6.0-14500-g1c41041124bd #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
=====================================================

Commit 4c72a36edd54 ("exfat: convert to new timestamp accessors") changed
__exfat_write_inode() to use new timestamp accessor functions.

As for mtime, inode_set_mtime_to_ts() is called after
exfat_set_entry_time(). This causes the above issue because `ts` is not
initialized when exfat_set_entry_time() is called. The same issue can occur
for atime.

This patch resolves this issue by calling inode_get_mtime() and
inode_get_atime() before exfat_set_entry_time() to initialize `ts`.

Fixes: 4c72a36edd54 ("exfat: convert to new timestamp accessors")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/exfat/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 875234179d1f..e7ff58b8e68c 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -56,18 +56,18 @@ int __exfat_write_inode(struct inode *inode, int sync)
 			&ep->dentry.file.create_time,
 			&ep->dentry.file.create_date,
 			&ep->dentry.file.create_time_cs);
+	ts = inode_get_mtime(inode);
 	exfat_set_entry_time(sbi, &ts,
 			     &ep->dentry.file.modify_tz,
 			     &ep->dentry.file.modify_time,
 			     &ep->dentry.file.modify_date,
 			     &ep->dentry.file.modify_time_cs);
-	inode_set_mtime_to_ts(inode, ts);
+	ts = inode_get_atime(inode);
 	exfat_set_entry_time(sbi, &ts,
 			     &ep->dentry.file.access_tz,
 			     &ep->dentry.file.access_time,
 			     &ep->dentry.file.access_date,
 			     NULL);
-	inode_set_atime_to_ts(inode, ts);
 
 	/* File size should be zero if there is no cluster allocated */
 	on_disk_size = i_size_read(inode);
-- 
2.41.0


