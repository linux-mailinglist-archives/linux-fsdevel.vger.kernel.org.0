Return-Path: <linux-fsdevel+bounces-6810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DDF81D213
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 05:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F471C21EFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 04:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845D15D1;
	Sat, 23 Dec 2023 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="j3WbecYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557841368;
	Sat, 23 Dec 2023 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703304329; bh=9xIgd02ObOuj54s7xcHHTnWTHw+ZVQIeUoYaZEUZRtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j3WbecYv+HgFEFXRYnnKihyWjtqOgkwwf45d43gtPTsiQ2M6n+jnKaEFieRGztFH0
	 SPmxaWpwj5VOx4XxB85XGYtNmJC3XzWYWooRh2YZiLu5po/D/aze8CiB9OC4zg1/1C
	 SpIIAFQ7AzEyeyzdq7VkBI6aDqd4Ym78Sm/KCT4g=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 15B0E030; Sat, 23 Dec 2023 12:05:27 +0800
X-QQ-mid: xmsmtpt1703304327t3rpz07u0
Message-ID: <tencent_C789B86EF5AED70CAF27CF06EF52C1C66106@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQ56/bDmN3iU/naJcSLOFboafrVjtuRh941spThL5B2uJoSzK3G9
	 E/rQ0Ia7ACu8X2B71OeOkGnwblrpuiOVWee9takTREre8XbtSWRozwp0KWC2fbl7qFK6kgW5rzgj
	 FyDWFiorRCtSaJ1kZwHxJfqkD4ETkNirZMX8J3GtMZyQb8iK34lj+S6gJcDtQO2Yx20gqIXs8pZs
	 WLgvQ08w4m3Ey0T7G30q3K8+R/P0A3r9pDpxhgjq/fbCz9KLYFXh84jEjztGvq34OavZ7pPEn28W
	 QLGZpjsyYVPXJcT1Qd48DLNhlR/s1IsV3hksZnG7tB2sAJYE8mVZ/IzbTKttOFQpNVD9I2+HKnyq
	 h2XFdmqZrCL30snllUajwlToNB0r9LmiCVINnviQwdgacPFz7ibxKu7ihFKhv5X4k8E6z3isVCGR
	 nMzyJv/ShTF8V1JExLzJmNZVO2elVa/su5W2TjMFxUakmjrfMOA/p+VJU3XMyhVgjy49mDx8ThVK
	 qPmxNbBxfEHXwkTDFmnzYIb/42NierzHg6A5gjMgojwzv9ftHFHBhXjx1UTDsZNreU1S7X1J5oF0
	 MjeI6c2iGnCueVDUMKhuizQJ4GlDqrwjxwYk1Kddx+DLoK4vLsULR2UqirasYM+M1vhB+l7D3MOs
	 ZUzQMtAwa6gIZRfmoRyf9r/JfQ4R2XNOvY75mg/mOuFUWSeKQknZz41ufY2MG+Z6crlQ56i50nGg
	 +SRy2mQWAROpQqttocnfYdJfoKxfXgkpXuF3TAoKfTEZ0gZKlzBtkMhH38BSt0PK2FvH1L6yf3q+
	 8jRbLRtXEwYyYUPgY3babOIvdsvGSFPkUPGAJdM2ea89ksl97+I/tHNCI8xdQEgvGZVROFxXf2sP
	 Oo80f/3qBRDNLMkVAuqB6ufF0KSxXPH6lb3mUd2aImqOn8QcQaBxl/wAYjDv/vEQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f987ceaddc6bcc334cde@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs/ntfs3: fix warning in ntfs_load_attr_list
Date: Sat, 23 Dec 2023 12:05:27 +0800
X-OQ-MSGID: <20231223040527.1940850-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000006ee8fe060d16e2a5@google.com>
References: <0000000000006ee8fe060d16e2a5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvmalloc needs to check __GFP_NOWARN, so this flag should be passed before
applying for memory.

Fixes: fc471e39e38f ("fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)")
Reported-and-tested-by: syzbot+f987ceaddc6bcc334cde@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ntfs3/attrlist.c | 4 ++--
 fs/ntfs3/bitmap.c   | 2 +-
 fs/ntfs3/super.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 7c01735d1219..e631ecc1b9df 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -53,7 +53,7 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 	if (!attr->non_res) {
 		lsize = le32_to_cpu(attr->res.data_size);
 		/* attr is resident: lsize < record_size (1K or 4K) */
-		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
+		le = kvmalloc(al_aligned(lsize), GFP_KERNEL | __GFP_NOWARN);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
@@ -91,7 +91,7 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 		 * the result is 16M bytes per attribute list.
 		 * Use kvmalloc to allocate in range [several Kbytes - dozen Mbytes]
 		 */
-		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
+		le = kvmalloc(al_aligned(lsize), GFP_KERNEL | __GFP_NOWARN);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 63f14a0232f6..49e660be9a0f 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -660,7 +660,7 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 		wnd->bits_last = wbits;
 
 	wnd->free_bits =
-		kvmalloc_array(wnd->nwnd, sizeof(u16), GFP_KERNEL | __GFP_ZERO);
+		kvmalloc_array(wnd->nwnd, sizeof(u16), GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN);
 
 	if (!wnd->free_bits)
 		return -ENOMEM;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9153dffde950..87778834aa9c 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1413,7 +1413,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	bytes = inode->i_size;
-	sbi->def_table = t = kvmalloc(bytes, GFP_KERNEL);
+	sbi->def_table = t = kvmalloc(bytes, GFP_KERNEL | __GFP_NOWARN);
 	if (!t) {
 		err = -ENOMEM;
 		goto put_inode_out;
-- 
2.43.0


