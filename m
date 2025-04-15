Return-Path: <linux-fsdevel+bounces-46520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A7A8ABF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 01:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F55441ADB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9372D8DB1;
	Tue, 15 Apr 2025 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="a+XFqJrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A61C54B2;
	Tue, 15 Apr 2025 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759013; cv=pass; b=FaHdiWg/HsRNb7unB7eDgDvxdO/48DAesIydJziHhWw3NnlZqkPOPt0oMUWET9xrTmqGxYCpNSZNXVwkaGTBEMi7tMGKAsIpDa/cqqxAXrRnPb+sRyUdd7bop40RKgDbL+z1bIRu8lckBkTX8MMScFlXeqaTWmDH5tSb0LC3Rt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759013; c=relaxed/simple;
	bh=vXp+7A6C1prdWk8YUf17h0mCxN/R5WpQdjq+ArmC760=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQCYGJumdWq2gFv9EhYHWNX4x5qM3wZhv9DBHltQZdmqO9sEMB4Uel5v2tWDNPAPVLzo/viZDaDeDbt7LY3PHumcwh+L0g96jlqfovTyir4CJ9bQTRv0PCW5PC0zghbcynP+G3XSzh66qzHrGY2WXxu2LR55YcxLBoBHsOm49kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=a+XFqJrr; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 184C34E4E5B;
	Tue, 15 Apr 2025 23:16:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (100-110-51-113.trex-nlb.outbound.svc.cluster.local [100.110.51.113])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A5E554E4E16;
	Tue, 15 Apr 2025 23:16:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744759004; a=rsa-sha256;
	cv=none;
	b=NTW3myPlETQscL1J+mXpbDHaHxx6yex13JilGByUZ78pzpOkYH1NNPR3klLH64uo6RuUP9
	VTCXwf0n1MSrZOohj9RY1V/alLVay73CasT63x05ijpn9bu8HvO2zQIslTbOJVaeYEBze4
	0C+aE4zwxUanjwU4bTJQsKSEWOo8A5ACR6KTtGs02pf3QUWwkPul28R/LHcVnJKNE00lE6
	i5ytejpaa4jy5pckwH3rlKcwGVHIDpXSgXFlhtJOTVlbh0HTU/tDKcMRjlbTDM04wd5kp5
	C8DGHblVpAx9BomVzl0+sfWGHXHybmC5fRkZUz1FpySIH3BbI81hDzuL2F/i/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744759004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7mbzxp8wiNL0OtR9zYzwyCfKKL0JnZdqXEtMAONmpHU=;
	b=GqG8wqpBNd/6Yf9muaJGH664VPVARwxhH9eBoYu566Z8Bwt/Nq6lgkCH7UkT/imriA7Zwp
	Rph2/vxCJJmMDycDbSmfyDXDD6c+UhaBwONbG5kaYUMcksc7W+zJPdlIz/mBou2RkhSXQV
	ZkwVqaGyuttZKvg7nAnKl/r1L5RyDCdFRjIGkOMFbFVOACEduqx3nmMuplflgLZrQLqw+z
	U7Em4eS2kNMyNHB2xCU7mhkDVR1fuPgA2FFEYtCPR/aJcqG61cvNfw5z+cYasI4366l7VD
	Z4BShXoDW4AIK3BlfjBPOk/mDZcf/c2KmrdUmqObOQ7w3pAbDDARFjXO1aBc4w==
ARC-Authentication-Results: i=1;
	rspamd-5dd7f8b4cd-qrpj4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hook-Fearful: 5407714374c9829c_1744759004996_2600025280
X-MC-Loop-Signature: 1744759004996:3493891324
X-MC-Ingress-Time: 1744759004996
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.51.113 (trex/7.0.3);
	Tue, 15 Apr 2025 23:16:44 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Zcg5l5T0Pz8V;
	Tue, 15 Apr 2025 16:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744759004;
	bh=7mbzxp8wiNL0OtR9zYzwyCfKKL0JnZdqXEtMAONmpHU=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=a+XFqJrr0fpF77UXqvxgA8PYjmYtGfYME29GQ/RXR4ipjs8xAa+OvvME4pXGxjizt
	 ZHBeqoxZxyT9d3CBdcwHfIv6o/BxmAAKWSMqtm977W6EcylHhIZevCVw+L3LWwwdPf
	 wDYSYCrh/17b4OjWeefNToeg6MiGvJLleRTxKr1kjFpOwUef/bQ0iOQgiV2NTfpwLM
	 LTJ7tsmWjcsMtal46NeBHqqwtGzJgPx4lr7znnU6psFziZ+iPCz18sqNupmYMfwc01
	 ZXAt5CNr14g6dMvDcrtofjYR+20shnRrMRnmovmqcGwPMOQ5QjuvUWsocS3RS6+eil
	 2REKCEDscH8HA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	brauner@kernel.org
Cc: mcgrof@kernel.org,
	willy@infradead.org,
	hare@suse.de,
	djwong@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 2/7] fs/buffer: introduce sleeping flavors for pagecache lookups
Date: Tue, 15 Apr 2025 16:16:30 -0700
Message-Id: <20250415231635.83960-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250415231635.83960-1-dave@stgolabs.net>
References: <20250415231635.83960-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __find_get_block_nonatomic() and sb_find_get_block_nonatomic()
calls for which users will be converted where safe. These versions
will take the folio lock instead of the mapping's private_lock.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c                 | 9 +++++++++
 include/linux/buffer_head.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index c72ebff1b3f0..64034638ee2c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1414,6 +1414,15 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 }
 EXPORT_SYMBOL(__find_get_block);
 
+/* same as __find_get_block() but allows sleeping contexts */
+struct buffer_head *
+__find_get_block_nonatomic(struct block_device *bdev, sector_t block,
+			   unsigned size)
+{
+	return find_get_block_common(bdev, block, size, false);
+}
+EXPORT_SYMBOL(__find_get_block_nonatomic);
+
 /**
  * bdev_getblk - Get a buffer_head in a block device's buffer cache.
  * @bdev: The block device.
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index f0a4ad7839b6..c791aa9a08da 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -222,6 +222,8 @@ void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
 			unsigned size);
+struct buffer_head *__find_get_block_nonatomic(struct block_device *bdev,
+			sector_t block, unsigned size);
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp);
 void __brelse(struct buffer_head *);
@@ -397,6 +399,12 @@ sb_find_get_block(struct super_block *sb, sector_t block)
 	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
 }
 
+static inline struct buffer_head *
+sb_find_get_block_nonatomic(struct super_block *sb, sector_t block)
+{
+	return __find_get_block_nonatomic(sb->s_bdev, block, sb->s_blocksize);
+}
+
 static inline void
 map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
 {
-- 
2.39.5


