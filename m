Return-Path: <linux-fsdevel+bounces-46522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9547A8ABFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 01:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C939E1899059
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 23:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28F22D86B4;
	Tue, 15 Apr 2025 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="SyQfGtul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E92D8DA3;
	Tue, 15 Apr 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759016; cv=pass; b=SALHclPLrPIU3i4ayEBXPDJNcWQEV23CjQfCS7LXaNyRTqpfSSrIRjBC22kwsZo+NF/0GfHjnxAqRQaRr99cgAwK5mqLcNKLlQKoZWENbAEwVDEaRlDoaUuI45RRyS6az+QUGEGw/MIKUtXIEMEa9cAqtZ821F1lf3ujQkDmqUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759016; c=relaxed/simple;
	bh=rJm00Lw9MejiGFiVzGyuCU25yiCG19QIA1wZPlFoyg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCkmC5DY91t54dcfGvogYkXbOrQzYldEv1o8mJ+3rx63YU/p9ZHhEPY0PcL4/y/c5Q6EOqpH06C+YamwZxHVR1vDVKCmraWMhburvddUNwrwz693Mgfe/N5QN25m7qQUumV3iSsjKdF6nJPXITneztwa5ujuNcfYbAoXiFY3t/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=SyQfGtul; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A410E1A4F6E;
	Tue, 15 Apr 2025 23:16:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.107.95.94])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4122D1A4FE0;
	Tue, 15 Apr 2025 23:16:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744759007; a=rsa-sha256;
	cv=none;
	b=ezPCxliX3Neqty+xipVIlcoDe0TzVCgeaBzX6Gta+nfU3iEam/iFJBr3el/Ft9AAzV1jed
	VDrnSaxoawSTN3DIWxnlpn6ReoBh+cRbBdoxvEuZ/e+FX0HfWH7PTkJmgimGAmYTC7FwxQ
	3zHGKiWBF2VorWiVhsjANHi34FKBeY78oV2em43A6oYfR0UY9xytYTCrTJhg2GIULwrNaC
	qogGTN+k2y9ABVr9YCTn7tHn4O4MP0nZKjEFE1X3XMscV0uRCU8PqtNZEGIKTzlIvSZ4Cd
	DX59JzTTo9FXbtkRjEEkwpsxjSQqICQ/jc6nJHPArmkBLENmdZlmymDsvcTOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744759007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1l01/oHMrv05TV0ULL7/RgVMZj90KQ8VPfIqNTQ9xYs=;
	b=7W3dzRToEk+k2/uG5S1+9P/T6IjIX7bxmihfzhkbtfcd99SOobdgQdktOBFf9G/eBi0bQe
	/lLv4PjThkjPwQ1OYOu7yuIE4fbXc2SbOVn7WHIeQ02vFnOdiE0YfZB2vUV4qd8Ab2gplg
	WmyvBd6jE3cmC3PFIOW3SGBCHSgD4xGO7YiqxSv01XwkVgzp7g+kME4QVdNgnTvlAREzM0
	/wg1qptjsvxa0jtGjZBW+zLYjjO8bWr0aqxs3O+QpgnMpwT+b7X7NMgg5KQTnMGJTruGXp
	AV3zNYcbGEcJcQlHiD/J14y7IYTV8EzbYJ8xgqH0xkjb0gmBBMZ7jEtLjgTNeg==
ARC-Authentication-Results: i=1;
	rspamd-5dd7f8b4cd-4m6r4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reign-Wide-Eyed: 76e12318560162e6_1744759007564_54610796
X-MC-Loop-Signature: 1744759007564:3970048582
X-MC-Ingress-Time: 1744759007564
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.95.94 (trex/7.0.3);
	Tue, 15 Apr 2025 23:16:47 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Zcg5p33MRz8V;
	Tue, 15 Apr 2025 16:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744759007;
	bh=1l01/oHMrv05TV0ULL7/RgVMZj90KQ8VPfIqNTQ9xYs=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=SyQfGtulaDKy2X3NY8kidDzYIlSRZblPYwswdENl4KWpjYVaXwuels7cffYPH4Bc9
	 nTST0RjauDvTe2l71YsnwNenD4HkOYxKHsaqZgghQxJLRJuT0evXgJOBZO9T9/JcTf
	 xFB33UBFxwzi0RkdVocWoidHLWnsAJP8vE3Yiezp7DN/upRuUUtjeN2X7uHm5OhoTf
	 dh0C4ikz+GsyVzYGV+DGDex2ZXMOouDeaF9wMYEkzHuPe/HKFbNvlyjQ+20EwVjZBU
	 H2pWGd/9WpjBX12zD/z2yV1TC8z0jNY4/aLYmwzZxAmRizzLrdIu82jd78WDKbDyfH
	 6KnltscSnjMvw==
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
Subject: [PATCH 5/7] fs/jbd2: use sleeping version of __find_get_block()
Date: Tue, 15 Apr 2025 16:16:33 -0700
Message-Id: <20250415231635.83960-6-dave@stgolabs.net>
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

Convert to the new nonatomic flavor to benefit from potential
performance benefits and adapt in the future vs migration such
that semantics are kept.

- jbd2_journal_revoke(): can sleep (has might_sleep() in the beginning)

- jbd2_journal_cancel_revoke(): only used from do_get_write_access() and
    do_get_create_access() which do sleep. So can sleep.

- jbd2_clear_buffer_revoked_flags() - only called from journal commit code
    which sleeps. So can sleep.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/jbd2/revoke.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 0cf0fddbee81..1467f6790747 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -345,7 +345,8 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 	bh = bh_in;
 
 	if (!bh) {
-		bh = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh = __find_get_block_nonatomic(bdev, blocknr,
+						journal->j_blocksize);
 		if (bh)
 			BUFFER_TRACE(bh, "found on hash");
 	}
@@ -355,7 +356,8 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 
 		/* If there is a different buffer_head lying around in
 		 * memory anywhere... */
-		bh2 = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh2 = __find_get_block_nonatomic(bdev, blocknr,
+						 journal->j_blocksize);
 		if (bh2) {
 			/* ... and it has RevokeValid status... */
 			if (bh2 != bh && buffer_revokevalid(bh2))
@@ -464,7 +466,8 @@ void jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	 * state machine will get very upset later on. */
 	if (need_cancel) {
 		struct buffer_head *bh2;
-		bh2 = __find_get_block(bh->b_bdev, bh->b_blocknr, bh->b_size);
+		bh2 = __find_get_block_nonatomic(bh->b_bdev, bh->b_blocknr,
+						 bh->b_size);
 		if (bh2) {
 			if (bh2 != bh)
 				clear_buffer_revoked(bh2);
@@ -492,9 +495,9 @@ void jbd2_clear_buffer_revoked_flags(journal_t *journal)
 			struct jbd2_revoke_record_s *record;
 			struct buffer_head *bh;
 			record = (struct jbd2_revoke_record_s *)list_entry;
-			bh = __find_get_block(journal->j_fs_dev,
-					      record->blocknr,
-					      journal->j_blocksize);
+			bh = __find_get_block_nonatomic(journal->j_fs_dev,
+							record->blocknr,
+							journal->j_blocksize);
 			if (bh) {
 				clear_buffer_revoked(bh);
 				__brelse(bh);
-- 
2.39.5


