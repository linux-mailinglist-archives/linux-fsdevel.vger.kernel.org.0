Return-Path: <linux-fsdevel+bounces-75735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIQ0FGAsemnd3gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:33:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2549A3FC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E5913100D61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833DC36D4F1;
	Wed, 28 Jan 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rw94uEjy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859936B07E;
	Wed, 28 Jan 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614060; cv=none; b=jX4FYoKfkSpHHQRevEr1m/tQN97AboonsRVjDcrOy5+lRzc32OimXIgEuEn63U29536cIljdSBY8cj/nTSrzERqUdkXjybMuPpk4ZO5WoBmpgYitGHlsFzPObGDxI0gLFWBvkwzh5NESxnTP1JPpO8lpEUf/24EN3xNTylClI00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614060; c=relaxed/simple;
	bh=w5AucakuYhDzYoPYelSdMZiMlMNIRzIcXJK8wKa9+Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WunegwA56bOuBnGJxPuWDDB13au1+6zfC9pMU+1doEBmbpRZAWgR7r6zFENvD7mem4v+CQxLp3M0gA3Yc8VU8dcFvvO89/VeaXHILB3O52q6Jy4iqCBE+Rs6UXAgkLJD+/BvooIW6uK4Xm4O7LirmHYv5Uub0IWL+LrVNJfXZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rw94uEjy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KiTYMSHGYkk7MMbd7gnpaW71B7FA3oikZ3Bx4Py5fbQ=; b=rw94uEjygaIGVu+CZ41z2AXxtY
	6lQSSJfdNSXgwT5eIoXsQZp/ARaCQqQupgcU2hWyaveFeNZK2uIaknumHd4DhxmL3xRAd1ziFm7pI
	lRtAqsA+hzZPA+/Nrf7fZjoGyMotLqRnDAK1Db/bTsaxMepV5D6eAceXfrtb1iJ+rI6cHBd90Z/u/
	IvD/pl9qQtVdrzb2vtSv7xXcIn/tizvYvrAcZ0DcIDN65qQEY0oSbWaPvcY3oY6gWl6Q+ITkN5rE+
	yx3YHRhAdhGiFablEF3kNZMkLiNmEcH5iSDygjDG1vBknkT0f8zR6N4/K3F+FIR1d8VSzSn/1jDwq
	TEkNXu7w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl7S8-0000000GHSx-28mF;
	Wed, 28 Jan 2026 15:27:33 +0000
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
Subject: [PATCH 07/15] fsverity: don't issue readahead for non-ENOENT errors from __filemap_get_folio
Date: Wed, 28 Jan 2026 16:26:19 +0100
Message-ID: <20260128152630.627409-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128152630.627409-1-hch@lst.de>
References: <20260128152630.627409-1-hch@lst.de>
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
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75735-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: B2549A3FC6
X-Rspamd-Action: no action

Issuing more reads on errors is not a good idea, especially when the
most common error here is -ENOMEM.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/verity/pagecache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
index f67248e9e768..eae419d8d091 100644
--- a/fs/verity/pagecache.c
+++ b/fs/verity/pagecache.c
@@ -22,7 +22,8 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
 	struct folio *folio;
 
 	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+	if (folio == ERR_PTR(-ENOENT) ||
+	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 
 		if (!IS_ERR(folio))
-- 
2.47.3


