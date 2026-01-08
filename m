Return-Path: <linux-fsdevel+bounces-72856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7662D04600
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C4D3268D03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070AD480975;
	Thu,  8 Jan 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="s4Gv8mUr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9E4797E0;
	Thu,  8 Jan 2026 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882234; cv=none; b=e0f8z7yF49Blir2GwkD/drs4ouaSyhmhUMopPdta2T9t6bgb6ps2s0vxoPqnsZUEylzRNOxElNeXvjm8uDC6skUOO5tlzlccSmLudn47fkKKkfKfMHLFeJPHKBaN6QCSrBXth+LPt5rKpWPFBKT642qGWYDJ7+UAtZqwwiyJLn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882234; c=relaxed/simple;
	bh=oHzrn/YKm1v9/y3OAGS1fWPH/Lrrq//0GJ8jkKY7zXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfwRUgacXK2eqC7rFR3XnnpY1fOhIkPHE2cWhjaNdYbgW/qK0cfV7k0/pSXHVw9JsV2eP2Dq1bN1/KM9Uuu+FHEd6aGcGpO8QE+pCxnQmedwjeDhPwyH53v5KImSLy4iybAQQ6ugN1i1VM4GQ79ZhNUe28S+fbt/FIiWXbP+XJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=s4Gv8mUr; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from [127.0.1.1] (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 5857BE0808;
	Thu,  8 Jan 2026 15:23:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1767882224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBCaZcAw7lYROWMA4FR1wIDaRqeMWYrCac0sHyOVGdo=;
	b=s4Gv8mUrMSMQKiOQfkeHLtmgqhF6hM4PjKc3uLHdyGYyuLMQgaDZUzJDibGka0doB1e42Z
	ZlgJ9pqUaorhP0ie670QuZaAC2WdN8uVTqoSQMQ0/Y//jLp5ER6tVmEM3Sf0Xk1sZIaY/B
	s+IExAIEBI3ASm1JptHG2O+3tGDciCeu7qt31pty3vt2d+a6fE45BUgr7hG5aGF2MmVOi+
	PHGjz96jnO38Zv2J6JVIEsb07/M0jFlXm/wCNcC69zf4aMeyGx2DllijIGfru3+qgurr/D
	Oykupm9kVzt2Jh7ij79dhyVaokbTj4/M5hAdWztklBLhxwSP3P24GguOj/v25g==
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: horst@birthelmer.com
Date: Thu, 08 Jan 2026 15:23:36 +0100
Subject: [PATCH RFC v3 3/3] fuse: use the newly created helper functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-fuse-compounds-upstream-v3-3-8dc91ebf3740@ddn.com>
References: <20260108-fuse-compounds-upstream-v3-0-8dc91ebf3740@ddn.com>
In-Reply-To: <20260108-fuse-compounds-upstream-v3-0-8dc91ebf3740@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767882221; l=1650;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=hBTBh/XU+SpLC+CPyH6T9+v95NF2mhjgtHtbDpAVTXA=;
 b=MmQ7x5hb7Eg1uCglHXLS0FwbgKLN8Jwlu6oZSWPuO6aAtWvc2BV+At+e4aRIhBpHCX5aUC0KN
 hDIYlzUipe9DmOH/r4GfE5FS4P1Wo/cOYylpPHcD7O5MZXwGim6G+Jm
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

From: Horst Birthelmer <hbirthelmer@ddn.com>

new helper functions are:
- fuse_getattr_args_fill()
- fuse_open_args_fill()

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/dir.c  | 9 +--------
 fs/fuse/file.c | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff..ca8b69282c60 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1493,14 +1493,7 @@ static int fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
 		inarg.getattr_flags |= FUSE_GETATTR_FH;
 		inarg.fh = ff->fh;
 	}
-	args.opcode = FUSE_GETATTR;
-	args.nodeid = get_node_id(inode);
-	args.in_numargs = 1;
-	args.in_args[0].size = sizeof(inarg);
-	args.in_args[0].value = &inarg;
-	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(outarg);
-	args.out_args[0].value = &outarg;
+	fuse_getattr_args_fill(&args, get_node_id(inode), &inarg, &outarg);
 	err = fuse_simple_request(fm, &args);
 	if (!err) {
 		if (fuse_invalid_attr(&outarg.attr) ||
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 676f6bfde9f8..c0375b32967d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -73,14 +73,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
 	}
 
-	args.opcode = opcode;
-	args.nodeid = nodeid;
-	args.in_numargs = 1;
-	args.in_args[0].size = sizeof(inarg);
-	args.in_args[0].value = &inarg;
-	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(*outargp);
-	args.out_args[0].value = outargp;
+	fuse_open_args_fill(&args, nodeid, opcode, &inarg, outargp);
 
 	return fuse_simple_request(fm, &args);
 }

-- 
2.51.0


