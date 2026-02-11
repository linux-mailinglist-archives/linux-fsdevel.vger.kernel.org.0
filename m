Return-Path: <linux-fsdevel+bounces-76971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLPjFKvjjGkeuwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:16:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EBD1275C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 357E13016ED7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AC432C929;
	Wed, 11 Feb 2026 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LSZ5vb9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243E261B92
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770840995; cv=none; b=tXWrd8zeum7rP2wH2OO3NRnY+GVeJYlesxP9p5CGE52wnL4RyQK4vvH6eZsVYG71fph8aK0nJR+OZJ0cKWdDjL63NZITOHgvQyRIsooSGfGkGHVKw+smRKZyuBqQc3jhgWsOHj4xlgy9UYHyDxQu/br4O4iV+j3vF1/RuImildQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770840995; c=relaxed/simple;
	bh=tCxYlmvE2RSTJffQAPnPnokzoqUKNnI0XUoDP+EmFUY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KydbSJd6iK8RJ++lEp6rI894CJ9Rn0dz1WOHCDC4fAGcTDL4vmGU/dnxhjF4iY41n6c46P5vY8f0j244JTUAuNDbH+OQ5G/2TxPeF+TfocNC/v90RnNDVPEmatc18oT2UKEO7P7EKFgqO4PAMz30UiVX41YVT/uIQJ+jy/LNOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LSZ5vb9U; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=q0PCURprL8Iwxb8nlZHrbynPGTdsVXWHw4sE+j5oI0s=; b=LSZ5vb9UhFIYcyza/9N7INPADK
	caBGKAbKYr5rDcQ+jXgd+htnljjVDwJ7QH0ZRr1rnRGnYFYl6lhqnYakvuOrYXFsxFd3zs+of//Hv
	HparnEXFCj/3VrkUxy1cNyjJXKolq0WxhBa2kO0gQZ9y1Mn/fA6OrkKXbbgIIk71ECKkEdfL+LI4R
	IsKs3hNr83B50exB/pcFnZSH5mZGaUGPJLFVs6UmTMRxYMtPYd8LWnnfmarR3zHjz1YpeTFIBomqq
	XTL944HmohlMTZLtH6b91y5w1zXfz4bwNC8GFX3BfVzGztNf14oh7HFrXVbE3MLLaOlusVfn0fI3o
	I6hdkiBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vqGfd-0000000Bc4O-1Qzr;
	Wed, 11 Feb 2026 20:18:45 +0000
Date: Wed, 11 Feb 2026 20:18:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] udf: fix nls leak on udf_fill_super() failure
Message-ID: <20260211201845.GN3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76971-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+]
X-Rspamd-Queue-Id: 83EBD1275C6
X-Rspamd-Action: no action

[in viro/vfs.git #fixes at the moment; if you want to put it through your
tree, just say so]

On all failure exits that go to error_out there we have already moved the
nls reference from uopt->nls_map to sbi->s_nls_map, leaving NULL behind.
    
Fixes: c4e89cc674ac ("udf: convert to new mount API")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/udf/super.c b/fs/udf/super.c
index b2f168b0a0d1..97a51c64ad48 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2320,7 +2320,7 @@ static int udf_fill_super(struct super_block *sb, struct fs_context *fc)
 
 error_out:
 	iput(sbi->s_vat_inode);
-	unload_nls(uopt->nls_map);
+	unload_nls(sbi->s_nls_map);
 	if (lvid_open)
 		udf_close_lvid(sb);
 	brelse(sbi->s_lvid_bh);

