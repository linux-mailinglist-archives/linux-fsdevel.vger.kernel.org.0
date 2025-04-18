Return-Path: <linux-fsdevel+bounces-46653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9560CA92F95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 04:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79DE4459F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2E2263F39;
	Fri, 18 Apr 2025 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="aP42K654"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA4263C92;
	Fri, 18 Apr 2025 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941587; cv=pass; b=ewxb5FJb/7lUrrv0zHt/tB/bU6XH6podR37K/xJ5FTR5jhnEG0wFaLh/UPthrw5UGdWXzdwGGE6nZ5aJnVU+tOX9y94jn0Ea45e4LYir04+lkCFTelhgSPAAxBrNqmFlkHVVKUSiNetp7SwsNMBjcYvvP7z3trSPcXudG7Q3PqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941587; c=relaxed/simple;
	bh=YrQlA34UgEDnZhIwTgoLDnvQxHt5wzV7K9XFumD5R/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mhJO9bPz9zqBrsCcEQufmXEuI0Dx4Tg+XfghUFGbL/ZOipKW3rHK9jUgnHGKHjIDNjFxIYBEemPgWVJ6P3wfh2EBVEIi7uChR5XYSdTlnQuZ7X6Ns2/6vEqJRt0h/4w5oy9nZ9bhnvwQX4HPxyCpUpANax0Rih3uyQ+PAqm4/ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=aP42K654; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 550DD1A39AF;
	Fri, 18 Apr 2025 01:59:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.110.156.188])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E74541A41CB;
	Fri, 18 Apr 2025 01:59:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744941578; a=rsa-sha256;
	cv=none;
	b=0WM6aWy1czVlh004anQ08oBZzarf7qbIHK49l2C0PNci6u4idl/fYd2oOL7O3Y8RB+5IT5
	eIRenJTXjk8ecCuiP9++rvOKQYT8Grmm8CfwitFMCmo9TXfd1nPI57+1dCq0AMFiyAB7aS
	wzvrvImtI6kRz9vIOHtNFleXwqkjRJHvsGOGso3Ui1r3E5Tf7zWH2pmhDGYAgFU598ckla
	kJT6mlhVKwK3YMyYyPYbabwGXgV5V8vJAVMRSKUSul7rZI7B/ssvimUI87/gOHLX6eW+3g
	A575Y8ARzjTwFNjIQCZjZTMNH7GrZNtuy0TOBL6h317OW4xSBoiEMCBg3a45vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744941578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zEOAmzE+sZv90XpMJsEcv1fdnAY2ZyFOCOVC4uAZkCE=;
	b=PU/jGGb/J/pdwkoeDhPVnnQ4+TkiUQYWFsODQbLXS2Gb3LgrfZcZ4L+l/JfWy06arnVuHq
	MGUob08FU78E/gYmQ7v59FXZRILmUcnglGL61EnV6t2tmBWT72PWvLbwnO6LXvlOFG8s5o
	Mz+Nk5lDTtRZX/4XhLhqwUAHjDLg+NDeAbIOenJ+Pm3G8bYfVNXlfkWFrDVXrLeR7Ey8j+
	iKmlmK6wLwfo/KhpwM6SkFkSIRc57h/I/0mQOWhjvzyDbdTAjdLpapgSSN9vAGojFa7UOk
	8e86ZLSAfj4OzBcaBCSWCJO1ySAyiE2cDLsCux81G23Psjvx6eIl249vEi9BxA==
ARC-Authentication-Results: i=1;
	rspamd-7bd9ff6c58-xxcc2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Broad: 4c3fb7e5001df433_1744941578239_2862724236
X-MC-Loop-Signature: 1744941578239:1903151097
X-MC-Ingress-Time: 1744941578239
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.156.188 (trex/7.0.3);
	Fri, 18 Apr 2025 01:59:38 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4Zdycn0ZBJz88;
	Thu, 17 Apr 2025 18:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744941577;
	bh=zEOAmzE+sZv90XpMJsEcv1fdnAY2ZyFOCOVC4uAZkCE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=aP42K654m4vLdWbMLGpstTsOj6HsVlFIbRoEsYxp+M4l5rHuQOLl5s3Y+Uu2yyleX
	 e7toEc9FSD/kcVOlHq8ye4gVpURDInp3MEGBc+P8h2XaOn1VhlTnPe9ViOvH5zr5Ld
	 jCKEEkgIZo2HR7iAa45LPOHY3ffMDrv9M6TGCNyjAf+1eoA7d7kRiNuv01sQW+YmDu
	 IGZJNnKnKepZ3Q9FXW9acszetdtp26TcO1yAUlbK4oeyE4gt0nD8swfNvZlF4ipmTy
	 aIFU6+ooY/Apvfeh9Gk8xtdeBbs3SHKawZrL6PU9TLpbIX5oUb+WEsMgmrbxsUEi4l
	 TLnezOQh0Hxag==
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
Date: Thu, 17 Apr 2025 18:59:19 -0700
Message-Id: <20250418015921.132400-6-dave@stgolabs.net>
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

Convert to the new nonatomic flavor to benefit from potential
performance benefits and adapt in the future vs migration such
that semantics are kept.

- jbd2_journal_revoke(): can sleep (has might_sleep() in the beginning)

- jbd2_journal_cancel_revoke(): only used from do_get_write_access() and
    do_get_create_access() which do sleep. So can sleep.

- jbd2_clear_buffer_revoked_flags() - only called from journal commit code
    which sleeps. So can sleep.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
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


