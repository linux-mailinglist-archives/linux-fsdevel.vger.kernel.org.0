Return-Path: <linux-fsdevel+bounces-75404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNR3OyrzdmkzZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:52:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911BB83F8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46A2B300D32D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 04:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A62830E84A;
	Mon, 26 Jan 2026 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4DY+nA68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0813AA2F;
	Mon, 26 Jan 2026 04:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769403151; cv=none; b=m3u+GvFDS7sAQwN/YQkRy2AvXBKtYcS8LAwJFdli3fGivozwmmzOExRVIGpAEb3XqKJrVaknhzPIfb9XpCERdwZXyLdYTi7ER62K07bY6mHMa4cYrj3xRggPelh0yrhfuULiNLrJm+FJLfomIsmuM4249IRvCrZZfdicNSHK06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769403151; c=relaxed/simple;
	bh=pS4eEtEm5rynESMfbwfYPnVQncTadqU/aUPtgwAAjN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AcHFZbA1EM9EVKQB2BwDueSjBjJjxzIiPRufIivwc+9Tq02LNZdxROp71AUhGMI4Mw1hR7GgTMy0LzKkjfQ+DDEV+0eq+9OfpgckHf3/uptORtwikTk7gqE+6JuZDN4aLzyOGN1t7vjTzdu8vGhlgLuQr9BNqRA/dacDn+wriUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4DY+nA68; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pNvONlM06djPs13O5Qblg4h3hQTBMH5YrEOJt01du6I=; b=4DY+nA687CEyR82Rlm7seNgexK
	m83BvRaldlSZAl9nZwnEZgrII9lWmZdz2LHit+Ry+qAp6ChGRPfGKyoMzZzerGJiHppAYXD8N44dk
	tvkxLyJ3RmBMDqr8WGExAAKmxn22M7nOyK7x+6c8+rHieYkv+8VkvmltHQIqwpWdYcsj9Ns7A7VaX
	x7vuXdvO+o9Ud9xG0tSa9jknwdj0twEKtTWf19VnbsJ6dqsMt2BYuEMpNvSYtU9MEK7RYfGXdTGNe
	5mun4OQWUEz0zFIrYAxbzwRQHJvzmE1mPHaiWB+uu77uGVkpWiSWQ4pkFW1SFWi+/ZauVfKd/GLrB
	gr2+k33w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEaK-0000000BuOK-38N0;
	Mon, 26 Jan 2026 04:52:21 +0000
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
Subject: fsverity cleanups, speedup and memory usage optimization v3
Date: Mon, 26 Jan 2026 05:50:46 +0100
Message-ID: <20260126045212.1381843-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
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
	TAGGED_FROM(0.00)[bounces-75404-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: 911BB83F8A
X-Rspamd-Action: no action

Hi all,

this series has a hodge podge of fsverity enhances that I looked into as
part of the review of the xfs fsverity support series.

The first part calls fsverity code from VFS code instead of requiring
boilerplate in the file systems.  The first patch fixes a bug in btrfs
as part of that, as btrfs was missing a check.  An xfstests
test case for this was submitted already.

The middle part optimizes the fsverity read path by kicking off readahead
for the fsverity hashes from the data read submission context, which in my
simply testing showed huge benefits for sequential reads using dd.
I haven't been able to get fio to run on a preallocated fio file, but
I expect random read benefits would be significantly better than that
still.

The last part avoids the need for a pointer in every inode for fsverity
and instead uses a rhashtable lookup, which is done once per read_folio
or ->readahead invocation plus for btrfs only for each bio completion.
Right now this does not increse the number of inodes in
each slab, but for ext4 we are getting very close to that (within
16 bytes by my count).

Changes since v2:
 - use sizeof_field for .key_len
 - fix a rebase error that caused an extra fsverity_get_info in
   fsverity_init_verification_context
 - add verify.o to the build in the correct patch
 - fix handling of non-ENOENT ERR_PTR folios in
   generic_readahead_merkle_tree
 - split fixing the __filemap_get_folio error handling into a
   separate patch
 - fix the readahead range in fsverity_read_merkle_tree
 - remove __fsverity_readahead as a result of the above
 - simplify the start/end_hidx calculation in fsverity_readahead
 - drop the > i_size check in fsverity_readahead
 - use pgoff_t where applicable
 - constify fsverity_info pointers in the verification path
 - use IS_ENABLED to disable code not used for non-fsverity builds in
   ext4 and f2fs
 - allow bisection for non-fsverity builds by provinding a stub
   fsverity_info_addr prototype
 - drop the now superflous inode argument to
   fsverity_init_verification_context
 - improve the kerneldoc for fsverity_readahead
 - improve various commit messages
 - fix the barrier placement in fsverity_active
 - mark fsverity_active to work around stupid compilers

Changes since v1:
 - reorder to keep the most controversial part last
 - drop moving the open handling to common code (for now)
 - factor the page cache read code into common code
 - reduce the number of hash lookups
 - add a barrier in the fsverity_active that pairs with the cmpxchg
   that sets the inode flag.

Diffstat:
 fs/attr.c                    |   12 ++
 fs/btrfs/btrfs_inode.h       |    4 
 fs/btrfs/extent_io.c         |   37 +++++---
 fs/btrfs/inode.c             |   13 ---
 fs/btrfs/verity.c            |   11 --
 fs/buffer.c                  |   25 ++---
 fs/ext4/ext4.h               |    4 
 fs/ext4/inode.c              |    4 
 fs/ext4/readpage.c           |   34 ++++---
 fs/ext4/super.c              |    4 
 fs/ext4/verity.c             |   34 ++-----
 fs/f2fs/compress.c           |    7 -
 fs/f2fs/data.c               |   72 ++++++++++------
 fs/f2fs/f2fs.h               |   12 --
 fs/f2fs/file.c               |    4 
 fs/f2fs/inode.c              |    1 
 fs/f2fs/super.c              |    3 
 fs/f2fs/verity.c             |   34 ++-----
 fs/inode.c                   |    9 ++
 fs/verity/Makefile           |    1 
 fs/verity/enable.c           |   39 +++++----
 fs/verity/fsverity_private.h |   21 ++--
 fs/verity/open.c             |   82 ++++++++++--------
 fs/verity/pagecache.c        |   54 ++++++++++++
 fs/verity/read_metadata.c    |   17 ++-
 fs/verity/verify.c           |  104 +++++++++++++++---------
 include/linux/fsverity.h     |  186 +++++++++++++++----------------------------
 27 files changed, 438 insertions(+), 390 deletions(-)

