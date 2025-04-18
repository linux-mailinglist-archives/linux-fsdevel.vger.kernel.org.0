Return-Path: <linux-fsdevel+bounces-46652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E38A92F96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 04:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8187AEAB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 01:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27A263F38;
	Fri, 18 Apr 2025 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="b1brf5x1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D0263C9B;
	Fri, 18 Apr 2025 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941587; cv=pass; b=khGp05VS1HJy7FecZK9Q3NPwjlbYSGuyEkcCNsJgvQ9pWmfQyZttFMOH3qgiG00ZCEsCHplDDYVSe0uWgDlAsBastUDOgaPndJFeNvAK0pYPzSfVezcrii8x8oHj2GYFhTvdn97MHjJqJ09O+5SGGzhs1QKqboHyUnnCS0tK5r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941587; c=relaxed/simple;
	bh=I7YmJPVxFz9nOaKxkJ+l2msdjZcfJtt7f1VL7dLDwwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrhNXWQ0MSxeTW55eWHJyCGxGxnfa1p9KanZ+LyAZgbq1aehLnyHF7Zs7eNvWdybJXYjpSYzWQOpLlTF8UgOWb/LIzLoXKpY5zyybyPvMlUdspegzK/s491kGY3bpOXVQt6Yuh802cii0Oqsvi8IQD4S84XUVMTkHyPz8TA3B6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=b1brf5x1; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3896022B93;
	Fri, 18 Apr 2025 01:59:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.107.106.146])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C7E9223AAC;
	Fri, 18 Apr 2025 01:59:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744941578; a=rsa-sha256;
	cv=none;
	b=bsS5tFD0sykfK7zgraiMxA6Hqu34fBQvGqp/gPVXcbn9Ae7yU7jNNc8UR4b5rAXNa/rm9P
	cHrD0gwRYU7YUn8R53I5Y06jNSSvAdw8T8wBjFLoKlMc1ijYYBvHIYZszAWZsntuqztV+8
	tiMp7EG9joNDpwQSC30WAiKTGI9atNHK5zKtTADNVYzhWXdfyMGl0hbhTvozI8YsGjp4Pw
	YerUN7Gnxv/1kJS4NgKUVtmBIFh3748BU8PXyjCWBtBMj3rgMSw5iiNDuTl0mM1uTxehZ0
	/ne1HKj6YsKgcsGWrtgf3rGcaBIThc8aXi8Cdy1puedBdvmcuZywFlVspMhrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744941578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hKmDLBznBthDscmA9sgDkTXs0rwbYUAQtB+GXsoJPYI=;
	b=ECo5BCDzyir7+TlNjGln88KUGmCcrJNuxMMZ+EMa/uoxAkwoGjTgPinRzSSD/VIrbwBZu3
	5fTo6KNMLJfRJV0E/SCPpTgwIee4/xZOXej5ykmRgQ3DQ5KOXg8763GIRIZSldd7h+nMyt
	6HYp+LsqACtzOtweUC/f7EXPaxvEnuS9OoEAFPik7kvzb6lCbf9p2OzW8GcKkCpa3O6VfT
	84IPngyaw5h0Q+phAgCfUUF2yiwg2RqY6PJnm5vYxJU4subqvEkzzKOgbH+0NZRI9N8EDA
	EObJrViW4yWeGjj6W6jutGER1Qttej6EpeoFh7gqWNs4gAoW9bxZjGE1+6AQWA==
ARC-Authentication-Results: i=1;
	rspamd-7bd9ff6c58-nbb74;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cure-Invention: 47318de774abdd5a_1744941579134_174818650
X-MC-Loop-Signature: 1744941579134:3745978050
X-MC-Ingress-Time: 1744941579134
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.106.146 (trex/7.0.3);
	Fri, 18 Apr 2025 01:59:39 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4Zdycn706VzC4;
	Thu, 17 Apr 2025 18:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744941578;
	bh=hKmDLBznBthDscmA9sgDkTXs0rwbYUAQtB+GXsoJPYI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=b1brf5x1RNdEsMHccWQKbPpYYmJhWv8TlrH44E+XtoDEKd2xqrNlBhefpOMfAOxAR
	 Sgn57LrKi2zczUgmDPnStSt5fhN+u0dEp6udEBvEL9X7oRZOPRWIhH/dh8yNVMBOTI
	 kTenPmfdOZ8eZkNf9+JmzTlEpWVpNm/1OV7l0DkFqk+BEtZT4uAh6p7pM3Q31RjC/v
	 8Ev5BN3zhcnT38dqvqXDWyP9xkJMkSKlB9K1g9KM7Avj1F2gFvBT9MSo0sLKmVyEyo
	 e4Prr0i0XeH8VNUbF2FtnJdU+sjO+J6uJNmAqdlelEQLCQPndPfWTg4Ng499HiEQ+E
	 e1oe8wdmdIxBA==
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
Subject: [PATCH 6/7] fs/ext4: use sleeping version of sb_find_get_block()
Date: Thu, 17 Apr 2025 18:59:20 -0700
Message-Id: <20250418015921.132400-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250418015921.132400-1-dave@stgolabs.net>
References: <20250418015921.132400-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable ext4_free_blocks() to use it, which has a cond_resched to begin
with. Convert to the new nonatomic flavor to benefit from potential
performance benefits and adapt in the future vs migration such that
semantics are kept.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/ext4/mballoc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f88424c28194..1e98c5be4e0a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6642,7 +6642,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 		for (i = 0; i < count; i++) {
 			cond_resched();
 			if (is_metadata)
-				bh = sb_find_get_block(inode->i_sb, block + i);
+				bh = sb_find_get_block_nonatomic(inode->i_sb,
+								 block + i);
 			ext4_forget(handle, is_metadata, inode, bh, block + i);
 		}
 	}
-- 
2.39.5


