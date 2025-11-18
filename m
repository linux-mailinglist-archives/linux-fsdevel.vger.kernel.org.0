Return-Path: <linux-fsdevel+bounces-69022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603BC6BAF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 22:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BFE74E541D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 21:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47630BBBD;
	Tue, 18 Nov 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="NYaGxXjb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2D2F2619;
	Tue, 18 Nov 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500040; cv=pass; b=Nb7VXqDxFoNVara0ThE7Yorw7nF9pyZ8Sn7m/Fc+L/U6XmfuV3SdXo9d+9YzqZDEJ0oxCRGCyu2wBvro025bMMKlpHMwEszAN0UsEVkximfCuyj0FS3TzutRyMC2GVZ8TMNsmpc9zlUEWU2wxu+ANAN/hlON93u9reswQgsJvK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500040; c=relaxed/simple;
	bh=Rl+LWwm/F6LLCmzPURELEz1KLhIj2jXJhWGN38uzLqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cVN3kxZKhsh3yv9hRnaZ2pPskDEAdTmjSHXtlucH+QhUs/QWhPGYXifkpaKw//xQm/SZKDEzPT1XX0qe/fe2alJsu6OfEoJmVp7HgMA/un18nZTgbdqNp2uWdyMtiky524bVjhSOAR+TLNo8sZS+LJIBGMH4/KhWBS4w5My/u/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=NYaGxXjb; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F15F68225F1;
	Tue, 18 Nov 2025 21:07:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.96.111.23])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A38F082255A;
	Tue, 18 Nov 2025 21:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763500031;
	b=3xvAVGNQF7OYDSfz8B1Fry0vrxkDiwcHHKZlrU/FRTXa/9KUyLX9Xsezw5xgh2C4C8Qhe5
	mJqDV20G4qpe/9J6h40zqkC3JS9g6l3rPyt5X6R+eD3ICrbFlOxfyw83yAej/zQ8QVHeuj
	e8oxlqt8pTELirrt4Jdy9DO1DcajcoegAPw7gZARbSzr6u7uylVe62GgxCJd37EqWiWVlL
	554vDnzklfcyvLiyfFcFi1oC/kUSR4nFXq0UxdtJd2LUMFfjr+eqd9o+GMADn9VQUVfXrh
	TLZnZWcJAP7QIRiZouyksZOitevZrRwGP89Gk5f7gkm4jH7zk40Is12o8iHoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763500031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Xzmyt3GKrKQaox4O9ufiFqYIJ39dNKFppgyHgh4f09c=;
	b=CmxBBUbHtJ1OcE4s0Oq+RQSAL1EQ+y03GR39SGnRup5m6iqN4KEX+LCcfm0TCKatfos8mJ
	fdf2pdE7GrOF/MNs031YBl/n603RtuTAGBJLPFi3/uzeq796ZCYZjDNx42jQ8lrmH4CvOC
	Ko80+HRdkv6tRLfXKtCRe9Uh4naghonxYGD4EctrlMs/9G6QTvSk+mp/BxaH8gdDCPAKlD
	f5YQN1u1wc0vtCnsXgx9TmTuUoYjTQXJFQhlCx6MNF35hKFw7wqrur0I/3KE6khJ+80ZWM
	YztbhCruiq6ChjUlhsoOCbIoa6AjnLOaKLVMWLdxAw+ZdTJ7Gt9nd73MWBjurQ==
ARC-Authentication-Results: i=1;
	rspamd-55b59744f-pwhnm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Company: 584bef9c79272803_1763500031889_3875167955
X-MC-Loop-Signature: 1763500031889:3407066866
X-MC-Ingress-Time: 1763500031888
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.111.23 (trex/7.1.3);
	Tue, 18 Nov 2025 21:07:11 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4d9xy70yKZzyrB;
	Tue, 18 Nov 2025 13:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1763500031;
	bh=Xzmyt3GKrKQaox4O9ufiFqYIJ39dNKFppgyHgh4f09c=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=NYaGxXjb7SUNj+J1cpPifDkxJ2FSJvTyb8PwBF6LSawTemcLgUJE4KPQCW0YOxqqH
	 hn54gu0q0n1SGAJJJyeRPWAgq1CBwJ+hRMZ9zqlJTqkLgiuPy7B4GOdH/IoUvmYaRq
	 Y65XxSeic84bW0cCbsM45ol+bgP1w4zfSDSpfe7Vc9+/SlNCYBFd+pDtE7qoBVB+cw
	 ErxgOOHYo+GzmVU7NSBFuldwMRKpBHD61kJ1gP3jPMY5PJ67VUrcwXto7R3F/jVYZq
	 mmegGXNm7aFmAUK9mtT8JQ7n52tTyNOa7WlwYS+qprgoR+aIhQnnbKrOO0sJ0y3mwM
	 +7EfvcnD894iw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dhowells@redhat.com,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH v2] watch_queue: Use local kmap in post_one_notification()
Date: Tue, 18 Nov 2025 13:07:06 -0800
Message-Id: <20251118210706.1816303-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the now deprecated kmap_atomic() with kmap_local_page().

Optimize for the non-highmem cases and avoid disabling preemption and
pagefaults, the caller's context is atomic anyway, but that is irrelevant
to kmap. The memcpy itself does not require any such semantics and the
mapping would hold valid across context switches anyway. Further, highmem
is planned to to be removed[1].

[1] https://lore.kernel.org/all/4ff89b72-03ff-4447-9d21-dd6a5fe1550f@app.fastmail.com/
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/watch_queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 7e45559521af..52f89f1137da 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -119,9 +119,9 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	offset = note % WATCH_QUEUE_NOTES_PER_PAGE * WATCH_QUEUE_NOTE_SIZE;
 	get_page(page);
 	len = n->info & WATCH_INFO_LENGTH;
-	p = kmap_atomic(page);
+	p = kmap_local_page(page);
 	memcpy(p + offset, n, len);
-	kunmap_atomic(p);
+	kunmap_local(p);
 
 	buf = pipe_buf(pipe, head);
 	buf->page = page;
-- 
2.39.5


