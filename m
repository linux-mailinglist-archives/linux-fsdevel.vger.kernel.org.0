Return-Path: <linux-fsdevel+bounces-33474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849A59B92AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FF22812DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D201A76A3;
	Fri,  1 Nov 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="JkCUprLn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjRKYQ1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C01A4F19;
	Fri,  1 Nov 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469323; cv=none; b=D8wsiTwrkVZpR80+UuTvwaYK1n6/EeWyH4hBpbvvAo5IN3dLOOep5Wem+k44ru33o1pFuQwJbNh5wwe3JB8PwNjaeRYOokLXdQUjBmqz7mDb0KTNEeXMSBRChzDn1mkjZgPsy0dsDsbXBIY8SDmt0cri2lIh3ZvNsWRy20uF/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469323; c=relaxed/simple;
	bh=5Do7ib1t9wQVq/1iPe/AkeFeP/J3/r4KeqETrfO42PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQJrC/gzaHc7nJzaREiT+vHQySU2AUSgro10A3OSfsawXT3lzIsJJXHtGjLC03HEbpNkk0XoAYrVSa6HgHbaHoZ7f2uGfI8mPbxVHfWp0J4ub+wmAu2WnAKhlyooEbbpl/iU4KlYqFIeDQNtCDYisPpVDWvU9sUxYku8WePxz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=JkCUprLn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjRKYQ1I; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C43F11400F5;
	Fri,  1 Nov 2024 09:55:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 01 Nov 2024 09:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730469320; x=
	1730555720; bh=vbcRh1xLMXs6D1grY6D0p73XgEN+cd/HL4E330kHx6c=; b=J
	kCUprLncek+LzEggD0igyOs90C6oSDpQBlltIfHM9SMjdv8LisciQqMXyjH0mOzJ
	HkvzzemqzpCsda8hkOTzDjXuiLsWrv7K+CJPnrQNPBzG+I45sByYeXyY+NmuUTUg
	QAxV+/Snd+QOkmnJS90Dp6CfgsvZk96DLjQcVkRcmPXTwu4BaomPlMUKgNnzuxHm
	WrTJ0tPSF9rLl8AuHWsLiguZ20/Yghz8df0/As8MpAotcyUadpzui2H0xzpRTzxT
	iEjpyLNTyq4bj7IDCXjwBBQgRVPNL7pCSwNlDdp3kpP8O79ESZN9mNSSaQuVkEcP
	kgecCAg7jjpUQxyEGJ5rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730469320; x=1730555720; bh=v
	bcRh1xLMXs6D1grY6D0p73XgEN+cd/HL4E330kHx6c=; b=UjRKYQ1IkwohDzR9L
	aHu8pJB4lnMgSEGyLkLSQNRSsd6QzeRa68z4qEPLxQLlr4ylCcsPqkhvKa88hxxX
	aMIhlKbMcCIl4JaRtqC3USypyreQXkh1pYqE6vDmkSBezwlkd+tJ8/5Z9bLrrWQC
	sfYjIA9krug06IgF6yoihGN2477d6C0WK/lwHMFysloa0Da+eMyN6JuizzaraMz5
	K2+l26Uv5YOcc2RO54yzG55qNou1C3vhLGevMb+bimsb9ZGXMzDPNTHDIbP9i0EE
	koNz8OY+CJmGFK95A0XwaoNsqD20sKQqIHfUpO5cMjvMFyKOABrCQ0D5SQO10Gfy
	G3/1g==
X-ME-Sender: <xms:x90kZ1447YFQ2olNoixA2cmqplepQphVCqxXkBOOGBWqTqrGTW8W_Q>
    <xme:x90kZy6QQzWRpx7xpLWPd17jHdrCc4ECWY3SMS3k9BUMlU1Nou90gtNkj__7PVSaj
    svvKvdC4jd6Z9OYVM8>
X-ME-Received: <xmr:x90kZ8cPFid5pA3Yjc1DgtO2_TjiZ-q7KQAN0xI4WVt73b0KA1U7pfadcwn54vnARK-30wNB6fb1EeIKFhQ_8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefgrhhinhcuufhhvghphhgvrhgu
    uceovghrihhnrdhshhgvphhhvghrugesvgegfedrvghuqeenucggtffrrghtthgvrhhnpe
    eggedvkedtuedvgfevvdehieevveejkeelieektdfggeevgfeiieejtdffledtieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvrhhinhdrsh
    hhvghphhgvrhgusegvgeefrdgvuhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnsegsrhgruhhnvghrrdhioh
    dprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohep
    sghluhgtrgesuggvsghirghnrdhorhhgpdhrtghpthhtohepvghrihhnrdhshhgvphhhvg
    hrugesvgegfedrvghu
X-ME-Proxy: <xmx:x90kZ-Lt6NhLX1M3RuyqJh3zwXyyl4qikpQvluqRFpRZ0VEdADz81Q>
    <xmx:x90kZ5IZgiVocNRB1e5XjxrfuuEaomNMyD0kR5HQ6O2oL_DaB2Ttwg>
    <xmx:x90kZ3yr3IpoHAdW3ZkuUZ0itfn_7Zcbt0uNhiFG3hcBW-nCAiLNuw>
    <xmx:x90kZ1L983L8uZ9Mw3E357GCICQeJaolPGjdh0itejepenpES-BMEA>
    <xmx:yN0kZx9xsU3xruug_EHDS3CGXCxxA_p9J2esXkyI-6D3lYX9QokFXFsg>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 09:55:19 -0400 (EDT)
From: Erin Shepherd <erin.shepherd@e43.eu>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: christian@brauner.io,
	paul@paul-moore.com,
	bluca@debian.org,
	erin.shepherd@e43.eu
Subject: [PATCH 2/4] pidfs: implement file handle export support
Date: Fri,  1 Nov 2024 13:54:50 +0000
Message-ID: <20241101135452.19359-3-erin.shepherd@e43.eu>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241101135452.19359-1-erin.shepherd@e43.eu>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64-bit platforms, userspace can read the pidfd's inode in order to
get a never-repeated PID identifier. On 32-bit platforms this identifier
is not exposed, as inodes are limited to 32 bits. Instead expose the
identifier via export_fh, which makes it available to userspace via
name_to_handle_at

Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
---
 fs/pidfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 80675b6bf884..c8e7e9011550 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/anon_inodes.h>
+#include <linux/exportfs.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/magic.h>
@@ -347,6 +348,25 @@ static const struct dentry_operations pidfs_dentry_operations = {
 	.d_prune	= stashed_dentry_prune,
 };
 
+static int pidfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,
+			   struct inode *parent)
+{
+	struct pid *pid = inode->i_private;
+
+	if (*max_len < 2) {
+		*max_len = 2;
+		return FILEID_INVALID;
+	}
+
+	*max_len = 2;
+	*(u64 *)fh = pid->ino;
+	return FILEID_KERNFS;
+}
+
+static const struct export_operations pidfs_export_operations = {
+	.encode_fh = pidfs_encode_fh,
+};
+
 static int pidfs_init_inode(struct inode *inode, void *data)
 {
 	inode->i_private = data;
@@ -382,6 +402,7 @@ static int pidfs_init_fs_context(struct fs_context *fc)
 		return -ENOMEM;
 
 	ctx->ops = &pidfs_sops;
+	ctx->eops = &pidfs_export_operations;
 	ctx->dops = &pidfs_dentry_operations;
 	fc->s_fs_info = (void *)&pidfs_stashed_ops;
 	return 0;
-- 
2.46.1


