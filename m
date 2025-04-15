Return-Path: <linux-fsdevel+bounces-46526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83BFA8AD0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 02:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08342443D59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 00:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370151C54B2;
	Wed, 16 Apr 2025 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MNKB93FB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CCE28DD0;
	Wed, 16 Apr 2025 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764776; cv=pass; b=WonmANqY0VvgAEVvgBe1rbKjVCMYmWsTn14Agmno7JStPseUdmIuwpIUfpKzog7qkRsrPqV6ARkk2/4ysa+vcQvnfgx9pjtkzGUqG86O/msxWNUi8c133ZAlC7RbP/K9SXijFx8e/a4GVjLX08gwyqTrFqT9BC9c2em6TZsVKrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764776; c=relaxed/simple;
	bh=DGEiI0J0IsO72e9mhDRaGawCuz/hLM1g1qEY7AU5G2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TeaIRmfKizs/3Dltw4IlbGzPR9OkkVZma7txfewIou+Fa5UqAiY876xssI4tXI/P4rzQbayGHwaKRtnm99CPP/0pQLIfDyn6mFvDjyyX6rlrdZjSlp20vTSdSS/CvmCsC7owliZ3KInQEl8/Lo/LeGrUpskmPIlosB5rfuyrKhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MNKB93FB; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EC6892C38BA;
	Tue, 15 Apr 2025 23:16:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.110.51.173])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8BDD52C517B;
	Tue, 15 Apr 2025 23:16:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744759005; a=rsa-sha256;
	cv=none;
	b=A5YBa6qqVAqi5HK1NVPY/z9YeSGUoedGVCD7dfFGlnj7AeQiLeoAkSLi7+WMng8iJXdXo8
	9MgbWW8eKxOY71aMmbU2gJbgJL9V4wUmGNx+SBYl/ix74RTk3IEqBVhnfKiz2XyqrFPQYW
	7kUHcjEgAmjvxkC8LlZlUEkb7tMEmu77yTyhv3TUfEVeq15nnhYRq0kT8pfs4KmUFd0F9V
	u8dLsuQudyGqE9sOWAfsRLXPwAxUkywLWf74qO08VdWVuz3s9i6vS+3hgcmmsdYBBcJxAd
	3tc/UcCKMBFZUc5Ohe8sZ6iAnty3vM1svFGK2oITDqTUrXJWBkqZCNvXGQz9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744759005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uHREBisV1DDhdKY8B6xaTzgB1WkfIIV5PMPRwi7cLCg=;
	b=dBTIgFrxySGjHVFBz4J+O6wUEUWaH3vGAr86teKCXnIOdw+3OqcDC6a4iA6mtXp5rMADM5
	/3NmvOjet25nqcGuOvWouHozYUn9C7XsEBkWsQ5oxJ62EKob2yhbpR4xwJgoyAnaKzeQVR
	ZXjfZSQLuJ10QPRHJ+YQAQwMslkMNqpHUq6N3nlfkucLu5HzgyaAJA/Z47KG96DBCmMujC
	uV0flEGYXQTVfjmVi3dAddtsN/bPIZonzO0uHgykSczHcNYzNpFI3YU13i7nnQyCAHKX/V
	dhQLe2AdT7dC45rKudssmcDs1X80E5gnkG5shMzTB/O3lu2qCT3AotHba7j2aA==
ARC-Authentication-Results: i=1;
	rspamd-5dd7f8b4cd-4m6r4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Irritate: 42ddaa952653b5b1_1744759005864_3471668932
X-MC-Loop-Signature: 1744759005864:1886427043
X-MC-Ingress-Time: 1744759005864
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.51.173 (trex/7.0.3);
	Tue, 15 Apr 2025 23:16:45 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Zcg5m52GBz6g;
	Tue, 15 Apr 2025 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744759005;
	bh=uHREBisV1DDhdKY8B6xaTzgB1WkfIIV5PMPRwi7cLCg=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=MNKB93FB1rPUY2XJUD/TCQK/S/jnxwGI48Z8zGnQjymdXzKrs0r/t32sKKXfb8umN
	 Ni8fqN3c2Mx16cUOrAMuyhz7EHU+vX3aGbKyEjE++OHM3jVhWHKpfQ0SMEj3idEd2K
	 a6QymDXhWyj8rA3Q9HQKnMQqlX31vYw4e0AkxQ6kq+H6SrGLjO4hNgUqi4vlrs/0Ju
	 1CukRBbuvmBUA0ww0wv4XLpVbxQut6bOK9wo1YQv8/KQ/XV/jm3ECcqAlhpiPYfy1T
	 c3zvrKYbhFSaIdEzQ7fnUNE2Xth0FWmvyfAFWX7U1+CuR9PA6d5l82QsPHcCRHNXce
	 +sbW4crlsINbg==
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
Subject: [PATCH 3/7] fs/buffer: use sleeping version of __find_get_block()
Date: Tue, 15 Apr 2025 16:16:31 -0700
Message-Id: <20250415231635.83960-4-dave@stgolabs.net>
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

Convert to the new nonatomic flavor to benefit from potential performance
benefits and adapt in the future vs migration such that semantics
are kept.

Convert write_boundary_block() which already takes the buffer
lock as well as bdev_getblk() depending on the respective gpf flags.
There are no changes in semantics.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 64034638ee2c..f8e63885604b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -658,7 +658,9 @@ EXPORT_SYMBOL(generic_buffers_fsync);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize)
 {
-	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
+	struct buffer_head *bh;
+
+	bh = __find_get_block_nonatomic(bdev, bblock + 1, blocksize);
 	if (bh) {
 		if (buffer_dirty(bh))
 			write_dirty_buffer(bh, 0);
@@ -1440,8 +1442,12 @@ EXPORT_SYMBOL(__find_get_block_nonatomic);
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp)
 {
-	struct buffer_head *bh = __find_get_block(bdev, block, size);
+	struct buffer_head *bh;
+
+	if (gfpflags_allow_blocking(gfp))
+		bh = __find_get_block_nonatomic(bdev, block, size);
+	else
+		bh = __find_get_block(bdev, block, size);
 
 	might_alloc(gfp);
 	if (bh)
--
2.39.5


