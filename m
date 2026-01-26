Return-Path: <linux-fsdevel+bounces-75407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAIJNmrzdmkzZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:54:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BDB8405A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C638B300461C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 04:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FAD30E0F9;
	Mon, 26 Jan 2026 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yQM/eZ8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B213AA2F;
	Mon, 26 Jan 2026 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769403159; cv=none; b=jqC3PcxIaYhdcquZjuck7rgg0BYZ2Ujk6WqCiVnKOI/xHAc/xMAkXGj34Xx8WpAhCcWDyrtEor9+TfiAIPeyy8lQFhhF54BrTAr2JebQftu+DgIwprkBjJ6FpSHhYO5rdXdkxKVhy9iJ8ya89I64O6API/VC6Tr527CluzmznlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769403159; c=relaxed/simple;
	bh=HHPaCIvxn7ijiLY1PaT9zXlPLDg0nerBSLsePJHbmUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzh9kZqKtDMGJR/6CMieW8QEo1pJiGdKc/FOYRHdFUxRRyQbE1c0i/c6FwayWrfKw/3Bcxw5RyUMVV/tOZF3nwWW7iKS2mZIyY1G9GqViYDceVFIjCnufsxefw2T676Sg7SUUhYnp4IjE3C5Rfk9UFgDjGVY1hduwYYI57PWtpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yQM/eZ8W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JTIIqGdNnnTZ8/mFXJscuc9GxNFmE8A4i8uFXevVu+E=; b=yQM/eZ8WFbBdBrTMl+x5tw5XwW
	7yVA4ioCpASh43agtnJVjTgilg4y7S/x3Dx83KQdTAIatHxGPVjwcLOGEhw/5YP+/SeRGj+4CbgOK
	5EZ1wQ7T/6VY935/fuwJIKMkc2aFtcsYEFQdTgRIK33GWIWbEoWn2PsOz54EJIcztV9ufmKSfEF+F
	JQn+3L+IqrySRwR40dJYsrTCx9UM3p2+uJ/REWy99JE9/yh/qpW4M0nZno/576NbWcEIhj+3wfA6M
	9qfA5TcQ2x1l8KFuLrG8kFJeBGE55c5a4HjQ2IO4uKjoUOtGaqlXEfDoE9OG3CP48HYxyUtFZjaB/
	SOS7eAwg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEaa-0000000BuPh-09rw;
	Mon, 26 Jan 2026 04:52:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 03/16] ext4: don't build the fsverity work handler for !CONFIG_FS_VERITY
Date: Mon, 26 Jan 2026 05:50:49 +0100
Message-ID: <20260126045212.1381843-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126045212.1381843-1-hch@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75407-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79BDB8405A
X-Rspamd-Action: no action

Use IS_ENABLED to disable this code, leading to a slight size reduction:

   text	   data	    bss	    dec	    hex	filename
   4121	    376	     16	   4513	   11a1	fs/ext4/readpage.o.old
   4030	    328	     16	   4374	   1116	fs/ext4/readpage.o

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/readpage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index e7f2350c725b..267594ef0b2c 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -130,7 +130,8 @@ static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 		ctx->cur_step++;
 		fallthrough;
 	case STEP_VERITY:
-		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
+		if (IS_ENABLED(CONFIG_FS_VERITY) &&
+		    ctx->enabled_steps & (1 << STEP_VERITY)) {
 			INIT_WORK(&ctx->work, verity_work);
 			fsverity_enqueue_verify_work(&ctx->work);
 			return;
-- 
2.47.3


