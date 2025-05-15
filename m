Return-Path: <linux-fsdevel+bounces-49169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6278EAB8E14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D74500BCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E2258CED;
	Thu, 15 May 2025 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mtspwCnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from butterfly.birch.relay.mailchannels.net (butterfly.birch.relay.mailchannels.net [23.83.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60338F6E;
	Thu, 15 May 2025 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331270; cv=pass; b=qsEOQaiY+mhaWKcv+va0Bzgt9LVk7F9LK/dPnH8lZSdWKC6TEhm3hg6cV6mZkdoDwihQdxXZ4K8jMTlUG3+bu1n0gq/3nm41RXO82PcmLFCIP7OODHmLyJlcnheN5puez+V+D8gF0soVdTLbxgNKq45NpKqhGJ6uELFsr/fthis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331270; c=relaxed/simple;
	bh=1ZLqXLN+0CtA7lSqoU4+j+ku98B1aqVaDuag9S87Eb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvujlRQ/5//zfb8gHoExdc4IBnAwr7kU2CKNPwQMFlaq5IJ/GgVkc/Qpny2N2v6p2oK648wI/+8g6n4/PNVunLzgbTbyOc5+NkJnPALPoYI9AjfELBfusg7CIOXWe8fR5loyNEPf6vb+hqj6C8DbNLz1CMPlrsPa+34xG7e4SsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=mtspwCnm; arc=pass smtp.client-ip=23.83.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A386F8C2627;
	Thu, 15 May 2025 17:40:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a272.dreamhost.com (100-112-106-235.trex-nlb.outbound.svc.cluster.local [100.112.106.235])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4141F8C41AF;
	Thu, 15 May 2025 17:40:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1747330822; a=rsa-sha256;
	cv=none;
	b=WdNGt5ZF9N5tquLkvrMkKU8s4UI+DP3l93muOO4Ulq0kmVvMVrAHFSVIIDXbudirnY3kLV
	OzGqRekSL84Vsnivkz0Q4p7Wqnc0OaT5UQoESlvOllk8JKm9bCGvuUfK3dHk/kDxRKxnTu
	3EtDVtknNZDXljo26ByBGPiJj5pzMUsJOKgEtEvqOuATbWmR3mEATn6CSprleHawDuFY6R
	Rth5RWI8TqatjibMScC6aTriuk3F7tSbgntK5fqELsCs6hncXUHPuJLqYssLn54v4Vi58S
	FrW/9niSGJYqlFkCnXUmVF1I8Uec+KPv1GZDNPnmIpXckHq03YKUmxOzWNLj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1747330822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PUwJlI501A+YEcVb8tIq6C49fh9kJVYJGRjvv+65zK0=;
	b=306Mgf+u6zhlgAYYOap0lz2nZEM3sAFGqlF98L91Rmg82tPZdcQx2gjyYxO1HRs0Xl1WDi
	MIBEzHkcAc+vZVhfrfQQNZNaTBMTBOhJwcKVxE678LgeSGDsaEOAjilYghUJlnEWTq9GJE
	iLfrDnIpANfQDe5tMc1w5em6k1ygQQ7X/jKbliqO9/AZhVb9ivL9rDs7mnNie3Fr8bUi2H
	7M8hpz1aGrnc+t/Y4d1vQitBMuqeb19GuFCf8yaqyxMpfzrpGN4oY0F8AVkAjrFyDM+0QI
	QkJgwTYTMXkBUVOGCMUln8zWldNktiPWOJeJnAxCUeGm3rMJXyxTV3a6kokC/g==
ARC-Authentication-Results: i=1;
	rspamd-5dcf5fb4c6-p876r;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Fearful: 077927b01f83cd5a_1747330822542_926751560
X-MC-Loop-Signature: 1747330822542:4167291504
X-MC-Ingress-Time: 1747330822542
Received: from pdx1-sub0-mail-a272.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.106.235 (trex/7.0.3);
	Thu, 15 May 2025 17:40:22 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a272.dreamhost.com (Postfix) with ESMTPSA id 4ZyyCn1lv9zFM;
	Thu, 15 May 2025 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1747330822;
	bh=PUwJlI501A+YEcVb8tIq6C49fh9kJVYJGRjvv+65zK0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=mtspwCnm+xgC/0SYQKaOO6/JYsn40OYh9VcLPGIIBmJKGof2kze6kq62rFdkk3H0G
	 PgczgoW/E+jAXpB8KhaEEJQg+nHkKM0LVpxd3Hp1Rj3aOijUSO4q0PlFTm0PHEINiR
	 4f6OjE/Pd44jKHWvFELu+hptMuJP/fFjS8xXigCGuNAbGNBUG1xiWwI15AwIIKNv7c
	 zExIoFxszYpcvJhTCsN7oY5+9WvtD0Q20ymd1DWmFZgBbcYpXblX89Ulra9uBQJ/J2
	 TkZi6x6T150/g36/QU4tzXgzWbWKS8bl56iWMt0Rk3MGbuzVoXDnzSbv5psaJ0Gayp
	 2IOdmHLgv7kwQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: brauner@kernel.org
Cc: jack@suse.cz,
	viro@zeniv.linux.org.uk,
	mcgrof@kernel.org,
	dave@stgolabs.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] fs/buffer: avoid redundant lookup in getblk slowpath
Date: Thu, 15 May 2025 10:39:23 -0700
Message-Id: <20250515173925.147823-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250515173925.147823-1-dave@stgolabs.net>
References: <20250515173925.147823-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__getblk_slow() already implies failing a first lookup
as the fastpath, so try to create the buffers immediately
and avoid the redundant lookup. This saves 5-10% of the
total cost/latency of the slowpath.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 5a4342881f3b..b02cced96529 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1139,15 +1139,15 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 	for (;;) {
 		struct buffer_head *bh;
 
+		if (!grow_buffers(bdev, block, size, gfp))
+			return NULL;
+
 		if (blocking)
 			bh = __find_get_block_nonatomic(bdev, block, size);
 		else
 			bh = __find_get_block(bdev, block, size);
 		if (bh)
 			return bh;
-
-		if (!grow_buffers(bdev, block, size, gfp))
-			return NULL;
 	}
 }
 
-- 
2.39.5


