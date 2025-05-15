Return-Path: <linux-fsdevel+bounces-49167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8CDAB8DFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1657B6216
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028D825A2C0;
	Thu, 15 May 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="d6MUmXIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE9146593;
	Thu, 15 May 2025 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330830; cv=pass; b=PmxQU8jBL4PjqUZh3xqDljNwZf1DN2YJoHDKGv1acNZ/DOXbD1xvNvOZBnjODupbha8lChkEjmf0WU76sx1oceGonuNq8oHtMhkKJQMrPxWUJEW3oV9Wk1xdilzrkQW5Jmx/V1NAcPgfbe4H6gib9yVwc+ZafW2fnDRqAuiBRt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330830; c=relaxed/simple;
	bh=3QdRH/Xwp5B9xckttKM+J35tFyTQOQ7YD4Oixg52R/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PESKbXZWuBcQrKrg+8IuykvDfVXM+w2bNWoTmLBOsL9dNtrtuaW4tvjbOdVje2p708Qopjj9ais8NLgYU0On4aONRyJExI67WWN/BNqGMptslTqEVrkpBJjALw0oJbkpD4FZLvhINB6apfua5ubojnkkbhyCL7ewRfJ2N/LenRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=d6MUmXIi; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C2E592C279B;
	Thu, 15 May 2025 17:40:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a272.dreamhost.com (100-112-107-83.trex-nlb.outbound.svc.cluster.local [100.112.107.83])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 334832C33E9;
	Thu, 15 May 2025 17:40:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1747330821; a=rsa-sha256;
	cv=none;
	b=mk384z56yzkRha7K2Kl/R++SkFtPvQfwvrOjJIBZk3k8r+AA/HQr4RVT/OYu/ac04Ro0Ph
	3QirFBLiKtUU5GzJpTqGlQzrKL4goIamFCrt0YnbEfHHAbSsyuGRXMFZgwEaRkm0rkN4yt
	CcqFHWIrYisGKwJ19O4VtlCPkVCkDBsUdZniBpqaXtCTdJrCt8defkB5HVulrZEOilfYng
	mb9vbwSwgNPavJpkJ8/XgfiLUDB+cxZ3HfSOHY9roUz8KsJ47PYGToHWvlS2JiXkbu/ALB
	FqOXkZi61Zqs7s3NxNos0j0cay8YueV0IS4dGbgZm4ZSEY8fn8gdT8LUBpQ1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1747330821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=z2K3h8DtdtYAr0P/C5Y1cu0vq9ldHY8qjqE9Mw3c1yM=;
	b=l5sttM/mQI8Wl2CKxTxGzqGkayxeuh3qB8qaMVXaXhduQsOai7agQzZd3PbPuWMh3VhTRJ
	8xTgqxs70eBXddf01mi5yAYGr6tUNjewVmgqwOwYKFQw2jqS/5Dqlt+qudxgS1Jt/+MwcH
	ZScBWjJsy1HOVZLATB4nzt/101If/IIe58aXF6Wc4uzJ66pjTwwhmiI2swZVLlcALt8psy
	UEDUlvxxSc6vnWk0mXCSV/IgtqYm+Z/+wcIwOTEQTdopSGEgOYQwnSvZJ9H/vemJUplSmh
	10f186bCKMUp+eRg77vEayvsPMJknkQVdhJ2w+DbFZGoYPdjkCO19bYWLpl5sQ==
ARC-Authentication-Results: i=1;
	rspamd-5dcf5fb4c6-pd69g;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Coil: 2cb33266341beb2f_1747330821593_1556686013
X-MC-Loop-Signature: 1747330821593:4255569526
X-MC-Ingress-Time: 1747330821593
Received: from pdx1-sub0-mail-a272.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.107.83 (trex/7.0.3);
	Thu, 15 May 2025 17:40:21 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a272.dreamhost.com (Postfix) with ESMTPSA id 4ZyyCm3jRvz6x;
	Thu, 15 May 2025 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1747330821;
	bh=z2K3h8DtdtYAr0P/C5Y1cu0vq9ldHY8qjqE9Mw3c1yM=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=d6MUmXIixeqCYdXU2OeVbwE8vqTd4bXERn1FFN+vYngW8q+yNQzaAIloX8a3lbsRh
	 IHAgUFHlb3xJFmw++S2PQlD3xQW99hQfS1L65fDh0BDeb7Ke6CnKiFaIYAXae5Jclu
	 z/fcCqOl1xQMgggt7jiLBsZliYldQk0yC27ZVabgy5M0+4CYI6iOaHBTDzlVSj4MYe
	 OSY4jc4CkzJmgxCPu2nElKrxTBrmoZdjVridzqCRS9mVvsX0XD7PFjVjvLJuq+Wqlt
	 uNkRjQwL8WOTcswOeThhPP4rK6uikU63++w30EKfI3ulPZnlYCZ6uMus13iDEhp/Rl
	 s+dw6n72f30TQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: brauner@kernel.org
Cc: jack@suse.cz,
	viro@zeniv.linux.org.uk,
	mcgrof@kernel.org,
	dave@stgolabs.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] fs/buffer: use sleeping lookup in __getblk_slowpath()
Date: Thu, 15 May 2025 10:39:22 -0700
Message-Id: <20250515173925.147823-2-dave@stgolabs.net>
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

Just as with the fast path, call the lookup variant depending
on the gfp flags.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b8e1e6e325cd..5a4342881f3b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1122,6 +1122,8 @@ static struct buffer_head *
 __getblk_slow(struct block_device *bdev, sector_t block,
 	     unsigned size, gfp_t gfp)
 {
+	bool blocking = gfpflags_allow_blocking(gfp);
+
 	/* Size must be multiple of hard sectorsize */
 	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
 			(size < 512 || size > PAGE_SIZE))) {
@@ -1137,7 +1139,10 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 	for (;;) {
 		struct buffer_head *bh;
 
-		bh = __find_get_block(bdev, block, size);
+		if (blocking)
+			bh = __find_get_block_nonatomic(bdev, block, size);
+		else
+			bh = __find_get_block(bdev, block, size);
 		if (bh)
 			return bh;
 
-- 
2.39.5


