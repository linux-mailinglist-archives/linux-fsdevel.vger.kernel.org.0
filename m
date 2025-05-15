Return-Path: <linux-fsdevel+bounces-49202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65850AB92B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 01:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616433B5571
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 23:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBE128F511;
	Thu, 15 May 2025 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="BpSzRLie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C619FA93;
	Thu, 15 May 2025 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747350824; cv=pass; b=lbE2t972A9I5gGeLvmsZMXw+8/KXmJK4IxF1PBSWDhkT7DMr7SkzcVqUkOdny6geIdbB76wH3f9OH8PmgXfNqiqZdBBZw6hL2bzqwzieyPMFTypY9iiBY/q3oB0SGtgilBfwDhi1MsUmIMkvikX3ZDBblI+v/IrX9Fuz2tTewK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747350824; c=relaxed/simple;
	bh=ZCGkHhXwVQRnTOe+lNrHq7OfguE4bhlkiEfGU59hepA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myMP+Vv8Bd9qjJBmGuD2n3ij1KHlwV2AgahSwIelAPTGYSSPtQ7wpveevwLQNmLF83lVOGwlALqACOZrpXlxNjYQOJ8doLSzdHUPaKx0MqJ3WvZ1f696dNeVbO3OgLXeOc+uvdIbNWdNSVfjmtTeSuCZ5NhIF9ym73fLutD96Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=BpSzRLie; arc=pass smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7BF1823A22;
	Thu, 15 May 2025 17:40:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a272.dreamhost.com (100-112-106-193.trex-nlb.outbound.svc.cluster.local [100.112.106.193])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1AF6A239CB;
	Thu, 15 May 2025 17:40:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1747330823; a=rsa-sha256;
	cv=none;
	b=KGd2MQRzAc3Jw5QNi3ppX3rPip8yx1f4vyQZ4mR7SN1ugv3rN6yUB+8ugG7cIvMlJuyl3K
	7mDXD5GjTABQP+V2wc8Mf8pp9RsdJ3vKQVrbS5Ly5v4LKVjrmj9OciKPAbS9J55oV07OVP
	jKyvlZMNN5WaAvayv9Bz+EQlvX+i2s+w204ocx2JgSD22f28AfKs1NvSW/rVNKURh4b8/B
	1ijfOWJlZxSF9tHOs+KEKzxnQXtx0c53YcMEF29q/rofuUXsT4jKxgJTViDgkkTu/lyVS8
	tosLDsGSP5n96GZUDdvyJFmWQpvkVTGhvKhDoHxVnOBV8BB7J4iKH/8BBQoD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1747330823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DiqDaihEdOkReJztOtQt4hmcT0IfYIVzd6AdHQkx+ic=;
	b=4hUFnvOIvLNXA5/WSLRVRo21X5L8fspegmXcSgY5swKtG64c+2olcK+z1JTylUhBYIaPOl
	tDvoMVcLusQI9CspzdT99szpeAfUG+MeClcF+hf8J7XFKxk5rk/mqR+wYBilKW1/X7AF1R
	oGALbWD0Aa6AWeHTlZ50PRCEsYqleJxdnG2irIfc2r9lgmhhT28a1bXROEJ325AZKyynuo
	44u296J+uk/1yta5lG4zqJ8CuKI4Iol3gjAlPbT+Oh3RITfU6qAYHBf76fS/k/3hxOKaLD
	AvKlkisJqsoel0X1bZ8KGatSYsFvd2lMff7F2WE9Xd/uEIjd5KTiqBxsNtpESA==
ARC-Authentication-Results: i=1;
	rspamd-5dcf5fb4c6-72pgw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Illustrious: 1c6d0da64ed65452_1747330823378_3902456520
X-MC-Loop-Signature: 1747330823378:4084077714
X-MC-Ingress-Time: 1747330823378
Received: from pdx1-sub0-mail-a272.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.106.193 (trex/7.0.3);
	Thu, 15 May 2025 17:40:23 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a272.dreamhost.com (Postfix) with ESMTPSA id 4ZyyCp2DbgzCS;
	Thu, 15 May 2025 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1747330823;
	bh=DiqDaihEdOkReJztOtQt4hmcT0IfYIVzd6AdHQkx+ic=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=BpSzRLieZbbTctjSokCrpdQ/huoCytneFWSaI9x3FPrQVAcMNEhS86y8FUwKnTrWb
	 8fkhdFwKCDJr8J5PXh6hsnMlMrIFK/gb4NTavXUmOsh5x70hAi7h8wwwLVU34XAEcw
	 bMtNfXohGs/wC/Efqv3mr3gs5Zn1ufpuF9icpFpdigBt2Ixi7YvttoSOBIENLh6zph
	 /7h/61Suk4pUWNWal2LhB6sKT8uHLzsl4vqB/e2SvctvHccsMiU9xvDIEu9K0/9PlS
	 V35DA/g500EtYHauGLlzqOMfrNL5rLGbIIjA+2qSXprPUExndouoavDSpfXIAQZoIp
	 WT0qH76MQ7/Sw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: brauner@kernel.org
Cc: jack@suse.cz,
	viro@zeniv.linux.org.uk,
	mcgrof@kernel.org,
	dave@stgolabs.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] fs/buffer: remove superfluous statements
Date: Thu, 15 May 2025 10:39:24 -0700
Message-Id: <20250515173925.147823-4-dave@stgolabs.net>
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

Get rid of those unnecessary return statements.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b02cced96529..210b43574a10 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -297,7 +297,6 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 
 still_busy:
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
-	return;
 }
 
 struct postprocess_bh_ctx {
@@ -422,7 +421,6 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 
 still_busy:
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
-	return;
 }
 
 /*
@@ -1684,7 +1682,6 @@ void block_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		filemap_release_folio(folio, 0);
 out:
 	folio_clear_mappedtodisk(folio);
-	return;
 }
 EXPORT_SYMBOL(block_invalidate_folio);
 
-- 
2.39.5


