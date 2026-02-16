Return-Path: <linux-fsdevel+bounces-77297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCD+FXkuk2mZ2AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:49:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B052E144CF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50BFA303D701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4E230E857;
	Mon, 16 Feb 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LeBUanw4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80B29D26D;
	Mon, 16 Feb 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253319; cv=none; b=EXWaWaj2yFPPGvGDRmLCAkRqB26NE/pgvXq0j66sxgUWaxNmdqrmlIZJlAwy+veJqTiLAzAlih7DVXsTAfFxGktcDBs7uCj6dTZLjAZdSOUFL1p4tnTvo/FbeIDDCxwaVbG7PKK4deMOSwfYVB5QnUlhAPiJUVGkM51VHaVLb4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253319; c=relaxed/simple;
	bh=3CB0xHGNkH+YsTFlC8f1CrMJKb+o7PHaRENKWCS4kFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tbmk0LIOqy81uWw74VxLKrLuSsdaKAk+dq53Nz3jCNxeG8fAiIPznYbZx4GhsnYTG/RPKzN73G1ZnhvPYE826G4LL9m32GmOz1b8XTkF4HzasMNwJaKSH3+7QNC5CSZfNewlWXt/d7I1ZHND6R/JpxkjuVvJ9NTP58UtQ22PKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LeBUanw4; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RnllYfzOls3PqrsuLzda2MhZBE57obQilCCnQxMfsmw=; b=LeBUanw4On3fVjFFdRZQzHNmWi
	UAeH3Q9e49uWXqOaJXEOyD14JcqQi5LHtkLRa08ENbeFkUSnOPYFmlesGy1mkcXiLQH35b4EUOv74
	vuom4f+SJmo619UC/uxH453LPs1M+5lhlI08Hv10KRC07cx1ea3EQ6tSjXI9UNLklUsaUZqn63In9
	5pJJOGGKezsWjFEN/tgK1EkANikh4i45YsmigrZvlHjV7asb8Vcaeh00ixg1viHRQXZc1huyNxrBs
	u/+0S9wngMM7cEuUhhrPPqpgK+8x6u8jDt7ML5r8MG/DkdyrMuEe92aCiE99OPi5B30BbtoFy2VLS
	EULA7IsQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vrztn-001KRs-Vv; Mon, 16 Feb 2026 15:48:32 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mszeredi@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>,
	syzbot+fdebb2dc960aa56c600a@syzkaller.appspotmail.com
Subject: [PATCH] fuse: fix uninit-value in fuse_dentry_revalidate()
Date: Mon, 16 Feb 2026 14:48:30 +0000
Message-ID: <20260216144830.48804-1-luis@igalia.com>
In-Reply-To: <69917e0d.050a0220.340abe.02e2.GAE@google.com>
References: <69917e0d.050a0220.340abe.02e2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77297-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[linux-fsdevel,fdebb2dc960aa56c600a];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: B052E144CF3
X-Rspamd-Action: no action

fuse_dentry_revalidate() may be called with a dentry that didn't had
->d_time initialised.  The issue was found with KMSAN, where lookup_open()
calls __d_alloc(), followed by d_revalidate(), as shown below:

=====================================================
BUG: KMSAN: uninit-value in fuse_dentry_revalidate+0x150/0x13d0 fs/fuse/dir.c:394
 fuse_dentry_revalidate+0x150/0x13d0 fs/fuse/dir.c:394
 d_revalidate fs/namei.c:1030 [inline]
 lookup_open fs/namei.c:4405 [inline]
 open_last_lookups fs/namei.c:4583 [inline]
 path_openat+0x1614/0x64c0 fs/namei.c:4827
 do_file_open+0x2aa/0x680 fs/namei.c:4859
[...]

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4466 [inline]
 slab_alloc_node mm/slub.c:4788 [inline]
 kmem_cache_alloc_lru_noprof+0x382/0x1280 mm/slub.c:4807
 __d_alloc+0x55/0xa00 fs/dcache.c:1740
 d_alloc_parallel+0x99/0x2740 fs/dcache.c:2604
 lookup_open fs/namei.c:4398 [inline]
 open_last_lookups fs/namei.c:4583 [inline]
 path_openat+0x135f/0x64c0 fs/namei.c:4827
 do_file_open+0x2aa/0x680 fs/namei.c:4859
[...]
=====================================================

Reported-by: syzbot+fdebb2dc960aa56c600a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69917e0d.050a0220.340abe.02e2.GAE@google.com
Fixes: 2396356a945b ("fuse: add more control over cache invalidation behaviour")
Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f25ee47822ad..66f0113ddfaf 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -481,6 +481,11 @@ static int fuse_dentry_init(struct dentry *dentry)
 	fd->dentry = dentry;
 	RB_CLEAR_NODE(&fd->node);
 	dentry->d_fsdata = fd;
+	/*
+	 * Initialising d_time (epoch) to '0' ensures the dentry is invalid
+	 * if compared to fc->epoch, which is initialized to '1'.
+	 */
+	dentry->d_time = 0;
 
 	return 0;
 }

