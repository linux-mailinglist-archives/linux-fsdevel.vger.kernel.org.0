Return-Path: <linux-fsdevel+bounces-78561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEsdLwZ+oGlgkQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:08:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7605E1ABC2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 775C830EAE26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE348C8C4;
	Thu, 26 Feb 2026 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJlVm7bE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0142E006;
	Thu, 26 Feb 2026 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121842; cv=none; b=rD2XvBnU0kndGcfDnoDpJbqeWt1oYg/wOGpIgW3fdRjZyVysRO7OWE8Fq83w1ZWzWjADjlLpJelRELIbQYgN2ghTNdI4ZgT3YMIsca0TY3Hk9/AQncFPyTriNWFoAwyZ/8xiujG8dOw6o7dT913be9ztztMfwZAfvh1SBg9y7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121842; c=relaxed/simple;
	bh=HQnqBhHZU2sAWZhxdsq0PVvzgqOCHqHvsaI1swrWu1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9PC+25OCgDw4g51J951X/nAkPZFB28UisoX5jEOnbui5JUirKHAOdu5v6ia65Evm6IRZHW58NYzsVxdbobVNTAnK/iBPsmvJGAQFP8qbyY+Gsh4RuuDmK8uDiBlPYarek9dqn3lOcRXqrZN7SqjVvbdVCnPE8pZMGHCOWmc42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJlVm7bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D281C2BC86;
	Thu, 26 Feb 2026 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121841;
	bh=HQnqBhHZU2sAWZhxdsq0PVvzgqOCHqHvsaI1swrWu1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gJlVm7bE76zMjPY0CgXsfeaUiMCfDr29KRS7Vh4h2cufOsxVaL5HokgQrFZjvKWr0
	 LEH+khOHPUXIeREJ7JyKNIXJlLHTCAOxJPnAYoeWoFtolV2nTN/DhtW7MOAbUVibQc
	 WTdgnawaWwkZx/nuKKRr7IFt/5sE9Nl9CFm9QEukVr5io4yf2T5BY0t386rJEC+GEl
	 SflifBzQRFAoEaN/bU2SoYbHxhSyHeYnJKCUiuG46KLIUz85b/Ru9/lo2uzwMGJzZM
	 y3ZayvYKCJ9VnC/06j4fIoKbF7OIfu0CdyMytRJDWNemrerfOYGB0Kys9ZbiVmtqY5
	 73k3GRG0I2lLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:39 -0500
Subject: [PATCH 37/61] jffs2: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-37-ccceff366db9@kernel.org>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
In-Reply-To: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Sterba <dsterba@suse.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
 Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, 
 Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Yangtao Li <frank.li@vivo.com>, 
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
 Dave Kleikamp <shaggy@kernel.org>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 John Johansen <john.johansen@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
 Martin Schiller <ms@dev.tdt.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
 fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
 linux-x25@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4882; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HQnqBhHZU2sAWZhxdsq0PVvzgqOCHqHvsaI1swrWu1M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0NSWGyn7zHQs4lO9B7QHYKEbCOl3hhGFFiP
 wXI+jDlXyCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtDQAKCRAADmhBGVaC
 FSE6D/oDcjFvjSL27UnDC75n4tTWmF3e+3hOlngVHS0P8swlrVZHH8UB/b5H9mPfSBtEwXOQ1Kk
 MG7NQleGUa3kL6qeHvNkP+Nh8nsEaTHjrvHUZiIrhWp7x6ItgtwqyKAOBGvCIm/ta4v/QNNLCW/
 U7+MA/+xQRyCPuJMUkEEffctlwe12qlyupf0uWNsR0SVxcFfc6tuqzxl7CNAf81vEfaRGZXKOjf
 iBw1omDa0EZ5xyRlJQgyvwDn6gYmkqiCec2DjDz3n21jYMA6oUvsdVldlPSoT4jBRQwFxiTUZwY
 4WsvihWU3QXqlN3KfgXvQBm4yE9dar7P0n35DxdQm+bxDzg9hOxMx7DArTKBYlogjLiQiaEkbIJ
 QyD6nTO13d55OgImz6XzFTTGgQSBr6CVz67a1snb/v5o+133K6uJ5nJ1HNXeptjXGc5O8ea3YOW
 +A/zEnZ4mJfWGG2qeDI8yQVZnR5lZV6OyCbzZaLFZaxIvadZ6m4EWHmLfcblHaPIguoJbzdKyVJ
 9b4uhXscumqEchfZwL61TofMl1Wnc4+VvquOetaInENpVxsGuUyv5KxOr4RN1gknWp1mzefX5v0
 nusE399ByDmiN2rubObzc6m3vJLBare12HsXVGbGORpySeuYoRB/HJXyFKUH4NBTzeJfVgIZxL5
 flGSB6N+pfsDpgQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78561-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7605E1ABC2E
X-Rspamd-Action: no action

Update format strings and local variable types in jffs2 for the
i_ino type change from unsigned long to u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jffs2/dir.c  |  4 ++--
 fs/jffs2/file.c |  4 ++--
 fs/jffs2/fs.c   | 18 +++++++++---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 2b38ce1fd8e8d8d59e80f6ffb9ea2935f8cb27e4..c4088c3b4ac0362074cfa186c04f9c3afcccdff2 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -129,7 +129,7 @@ static int jffs2_readdir(struct file *file, struct dir_context *ctx)
 	struct jffs2_full_dirent *fd;
 	unsigned long curofs = 1;
 
-	jffs2_dbg(1, "jffs2_readdir() for dir_i #%lu\n", inode->i_ino);
+	jffs2_dbg(1, "jffs2_readdir() for dir_i #%llu\n", inode->i_ino);
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
@@ -211,7 +211,7 @@ static int jffs2_create(struct mnt_idmap *idmap, struct inode *dir_i,
 
 	jffs2_free_raw_inode(ri);
 
-	jffs2_dbg(1, "%s(): Created ino #%lu with mode %o, nlink %d(%d). nrpages %ld\n",
+	jffs2_dbg(1, "%s(): Created ino #%llu with mode %o, nlink %d(%d). nrpages %ld\n",
 		  __func__, inode->i_ino, inode->i_mode, inode->i_nlink,
 		  f->inocache->pino_nlink, inode->i_mapping->nrpages);
 
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 5e1ef4bc009b6e5b4818a7467639fc328c137c12..1e18d3a798409d23440a5890808bc25372549e93 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -88,7 +88,7 @@ static int jffs2_do_readpage_nolock(struct inode *inode, struct folio *folio)
 	unsigned char *kaddr;
 	int ret;
 
-	jffs2_dbg(2, "%s(): ino #%lu, page at offset 0x%lx\n",
+	jffs2_dbg(2, "%s(): ino #%llu, page at offset 0x%lx\n",
 		  __func__, inode->i_ino, folio->index << PAGE_SHIFT);
 
 	BUG_ON(!folio_test_locked(folio));
@@ -259,7 +259,7 @@ static int jffs2_write_end(const struct kiocb *iocb,
 	uint32_t writtenlen = 0;
 	void *buf;
 
-	jffs2_dbg(1, "%s(): ino #%lu, page at 0x%llx, range %d-%d, flags %lx\n",
+	jffs2_dbg(1, "%s(): ino #%llu, page at 0x%llx, range %d-%d, flags %lx\n",
 		  __func__, inode->i_ino, folio_pos(folio),
 		  start, end, folio->flags.f);
 
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index c3ce2c868f7a33476d5cde4f1af7c7ed9c6c6c41..d3561a9c3d2a836e2c1f9de87816b80d0a1cf2e0 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -43,7 +43,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	int ret;
 	int alloc_type = ALLOC_NORMAL;
 
-	jffs2_dbg(1, "%s(): ino #%lu\n", __func__, inode->i_ino);
+	jffs2_dbg(1, "%s(): ino #%llu\n", __func__, inode->i_ino);
 
 	/* Special cases - we don't want more than one data node
 	   for these types on the medium at any time. So setattr
@@ -243,7 +243,7 @@ void jffs2_evict_inode (struct inode *inode)
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 
-	jffs2_dbg(1, "%s(): ino #%lu mode %o\n",
+	jffs2_dbg(1, "%s(): ino #%llu mode %o\n",
 		  __func__, inode->i_ino, inode->i_mode);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
@@ -334,8 +334,8 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 		ret = jffs2_read_dnode(c, f, f->metadata, (char *)&jdev, 0, f->metadata->size);
 		if (ret < 0) {
 			/* Eep */
-			pr_notice("Read device numbers for inode %lu failed\n",
-				  (unsigned long)inode->i_ino);
+			pr_notice("Read device numbers for inode %llu failed\n",
+				  (unsigned long long)inode->i_ino);
 			goto error;
 		}
 		if (f->metadata->size == sizeof(jdev.old_id))
@@ -351,8 +351,8 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 		break;
 
 	default:
-		pr_warn("%s(): Bogus i_mode %o for ino %lu\n",
-			__func__, inode->i_mode, (unsigned long)inode->i_ino);
+		pr_warn("%s(): Bogus i_mode %o for ino %llu\n",
+			__func__, inode->i_mode, (unsigned long long)inode->i_ino);
 	}
 
 	mutex_unlock(&f->sem);
@@ -374,12 +374,12 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
 	struct iattr iattr;
 
 	if (!(inode_state_read_once(inode) & I_DIRTY_DATASYNC)) {
-		jffs2_dbg(2, "%s(): not calling setattr() for ino #%lu\n",
+		jffs2_dbg(2, "%s(): not calling setattr() for ino #%llu\n",
 			  __func__, inode->i_ino);
 		return;
 	}
 
-	jffs2_dbg(1, "%s(): calling setattr() for ino #%lu\n",
+	jffs2_dbg(1, "%s(): calling setattr() for ino #%llu\n",
 		  __func__, inode->i_ino);
 
 	iattr.ia_valid = ATTR_MODE|ATTR_UID|ATTR_GID|ATTR_ATIME|ATTR_MTIME|ATTR_CTIME;
@@ -428,7 +428,7 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
 	struct jffs2_inode_info *f;
 	int ret;
 
-	jffs2_dbg(1, "%s(): dir_i %ld, mode 0x%x\n",
+	jffs2_dbg(1, "%s(): dir_i %lld, mode 0x%x\n",
 		  __func__, dir_i->i_ino, mode);
 
 	c = JFFS2_SB_INFO(sb);

-- 
2.53.0


