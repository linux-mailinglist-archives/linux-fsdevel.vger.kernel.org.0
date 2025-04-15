Return-Path: <linux-fsdevel+bounces-46521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A8A8ABFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 01:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5333BF463
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8FA2D8DC5;
	Tue, 15 Apr 2025 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="pg09XEWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE91C54B2;
	Tue, 15 Apr 2025 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759016; cv=pass; b=jlPqcWOC1c8OrJd8PyPxPCVASOibdKXJc6V/q/GoPC1aIBVsUpzTc3Nw0zRrwptnVq3kxBmwEysSQevLYPp2GmsIjEQtj1vNPOl+G7952MYOszVrrMpX4Giyr2fX81qzxDGIr1RXYzV7DCnifgYhzhjTZ/bW3aePPmzxlWZOiE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759016; c=relaxed/simple;
	bh=5J3ljwPyF1mfwRP7vhzDB2o1aUde7xmI5aCYQrijMjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aY6wfDBRE4adrFPWmh3ai89pitclLPIl/5Nk7RJc8MjavSQefMetaYkAopAW0v1gZvyn3plZLiq44Hn5aApHwsjeOo2BnnWiXpzeFPB/M983nzOtgz8pzO6OA3tbOQPgaqmricAWibaDBDT82L913B5voozsRbdPtupH/CcoYAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=pg09XEWF; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7EF532C5169;
	Tue, 15 Apr 2025 23:16:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (100-109-60-75.trex-nlb.outbound.svc.cluster.local [100.109.60.75])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1AFCA2C5171;
	Tue, 15 Apr 2025 23:16:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744759008; a=rsa-sha256;
	cv=none;
	b=clEznkgPy+EiYjqUnRdlPY8Xp256oAtxLK8cc6A+4Gm0epRB7VXUfT7ExZGEN77rddkfpL
	e0bl49d7HoXQON5YjRd6det+et3bFtNO2oigtM0yRuu5IwLfEU9gYhtYrcdzfaV9Q3uvF8
	9I3D6+u+VzZuHvbq2PXTYnvrOQXVsCYCF/HuFTa3bqHP+Q9NdEgX2tn0d9sUUmFl4/mEnW
	VXtgXvRQK+kCoaz2rMnLQkfJVcKiyHkbwgWX43W1hkg/RehTG6ZRBzHn5eeI14GOQ3+kYP
	EMl8S6uqzmsZ6Xl0cWOwY1E9fXMnJY6fz7czshQxgFpbhgXCBY+Cgpb/tpINQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744759008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6FfTau9BvNuszvB4UDUEdiDHpoFoAKapXPdYyQlxMQo=;
	b=nURM1QbZ8resQiKJZ/eyNe7DaQHlU3vRHyL+780WHcnXyDRCbixiPFP16n6TH0NhroRl1D
	xPpvLcNj3xrkRYbRF5ZcrQkgcllEchx6ElHLL4F+W8pqaOyGYSFqRw3J7PihrHE3M8xkOB
	0OHAr+jP85LNrDg9+WvH7KNr+XAg7BO0d9eqgrgCy3N+u9Sy2wWBva6EZramdT5R0C8Yq/
	vjRkiG3pzzJg3zuoCRcU6Iji6lFWh8YQq4Lc4aqFgI+QqZ7p/nGUpBGiKa5YA3/44Ji4w5
	1LO7RSsVHEYHeJ4NKRhJinCQoPclOXybu4Ogx2A3QlPMRS+1YavkncfEcOpVgQ==
ARC-Authentication-Results: i=1;
	rspamd-5dd7f8b4cd-xblgx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Whimsical: 522e76535dc1ed42_1744759008414_2568278399
X-MC-Loop-Signature: 1744759008414:2054462833
X-MC-Ingress-Time: 1744759008414
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.60.75 (trex/7.0.3);
	Tue, 15 Apr 2025 23:16:48 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Zcg5q22wGz2Y;
	Tue, 15 Apr 2025 16:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744759008;
	bh=6FfTau9BvNuszvB4UDUEdiDHpoFoAKapXPdYyQlxMQo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=pg09XEWFvL3hZNxtY/VDXfDL5ZCooaIA8HYiDt/u/3oux4VT9K+jFGKbHmVcjzcPd
	 grF69IcAdvJuY6lGH3U4/s2hAcRJmU4emU7ho9eAladkVMV0mPpiMQ8uR5VIcXeGhJ
	 vbbiGvxCYpow72dtTdU44yfi998QZ3/xlVXJc+E2IaMPjqFmeyCfoXEL7K48GQTKXL
	 pSLU0TMODhtWFMf3XokCIOdycNz68Q8+R1xTT/xebpBQXzL6DsqHIS0qi0JruhBBpq
	 btnXHvFG5Gwle0+0tiyXuey0J8Wuxvx9iYVTA9cX59YKm57EnrjLMlceY6qH6Jozp8
	 338AqUh01jPjg==
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
Date: Tue, 15 Apr 2025 16:16:34 -0700
Message-Id: <20250415231635.83960-7-dave@stgolabs.net>
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

Enable ext4_free_blocks() to use it, which has a cond_resched to begin
with. Convert to the new nonatomic flavor to benefit from potential
performance benefits and adapt in the future vs migration such that
semantics are kept.

Suggested-by: Jan Kara <jack@suse.cz>
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


