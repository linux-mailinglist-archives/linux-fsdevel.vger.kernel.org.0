Return-Path: <linux-fsdevel+bounces-78566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ4HNlJ9oGlgkQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:05:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA5F1ABAE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF52F30CDE7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF7143E497;
	Thu, 26 Feb 2026 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPrUls0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3344A1384;
	Thu, 26 Feb 2026 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121904; cv=none; b=me3t+dLjcLT9nyhq1sw8fjVv0MoqA5NCkIj0kcOJNnDOPvNqdaqirWFCuFq6aoRnbDEP6njuutl1Zo2wCkQx/rWKgedfym0Wr0f/TbVnl5QwOLeleCwWKHrrzQFttVV/WddwsV+uNbqo3bvaNuDz4gzLRI6MBzAcEot/rQsh15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121904; c=relaxed/simple;
	bh=WjoPQEYX62ntQ5KvwiKXATuVz2FXwgUeqUutOdHuQO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tcb6iIg8EgbZHJ5ypboyES+HmkFBW/y8lwWC0JPpKqmU2mJ5O1DPUgVxHF6vpqV0uBiibEJzI6eSDNQ7i7AtqQuMeobyG/vDsz1lq3+fFtU33P/MQ/5xPVE3mJ7I+F5NXuO/g27euoW92SRV+uGs93HIjVFmA7Y5QZQZO0NYlYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPrUls0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7722C19423;
	Thu, 26 Feb 2026 16:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121904;
	bh=WjoPQEYX62ntQ5KvwiKXATuVz2FXwgUeqUutOdHuQO8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HPrUls0pttYjYlcIKlZofSrqW3fdl89q1I46EFL3Ui9bdpMLXu3vRfiIrp+kzPgOB
	 RBwGgjaLoRKm+EPrhWUG+BdSYdVAcSPulqqKyq0D2N2CiCufQ3eJdG3aR2BdTNTnbu
	 bjpLNSiNZkUxPvxkTATzyMkvMjGekVrLYOsYBs6On/AAbw9x2Zqs7u1MaMV9I9C2c6
	 6R2p4D81mdC1vzc6ZV2IP/ocrLyha5EFh4BtvCHFduJPOHKMPy5UO4rPryiehYkb0B
	 rJ8gyGaCi9BxDhuhH0a1WTxBQ2XSn+7whUV7nvDaFlQEl4/fCBKyqX4TfllbLfUlYE
	 FEutDFpxmUvnQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:44 -0500
Subject: [PATCH 42/61] ocfs2: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-42-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12451; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WjoPQEYX62ntQ5KvwiKXATuVz2FXwgUeqUutOdHuQO8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0OfrfTZKHp1n/fmZIYEbIrkGI0Y5JPmrYRj
 XCtZRIknwaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtDgAKCRAADmhBGVaC
 FZmGD/wOCKbpkObKLXVuNdAaYn+YRBVtPHnVeinRG9CpA2zkvkmHkpGaJw/t/lRR305OQ4IOLnB
 +Re9+UFnwawHAWE83vUbqg1B0cRR7JhfVsn0ZmlzcXCSlkvZOqc/i+sYdDtOLmuhI7/lc97aqp6
 azifdrS19aKHKGTarMljUoY5siOudJImEtsrAB2RLSdmSeP3vt44DbWTkoBpYdWwk/hHvkEfz7N
 f8N97wz0ObO9lAcUiYQQ0x/DfBWP1Yg/EfWO0g7txRlYDqVFHP6fn7g682D6rXjcsQHuFrWvtkM
 egzSbbKNZrwORrEgFHYFPGgh2zHHs1V3LkQY80lyAimWjOSNe+TogzLtn5fLcZjZGdiAJkSxpti
 9wTBnJ0aw2aF/X/KZbCx3dcrG6tH1GImbBRli30p5izUd19v9aSL0T+Cq3FciE2Xkn6Jd27r7sx
 BsF21i7U33FM4efy7YEFCXah17EY0QvnHjLdZUPOfQ3sHryM6C6WLaet9c5UJTv2PHgp+ZcZNr1
 wcZd6gVc4CYe0Y1sivEREcbArmpfOuGdCu0oJzxJU71lra+jgK5UxFzz3Hq2XgjDi79HscgO2CI
 VRDYxVXvsM2OKidz2ccd+ymCIAuJ9Rp/UTYplRb8FGUProNn7xcIvpPMFlJ0k+6qGOGq9HE26dG
 lWMMkEsNAdXcYuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78566-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFA5F1ABAE5
X-Rspamd-Action: no action

Update format strings and local variable types in ocfs2 for the
i_ino type change from unsigned long to u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ocfs2/alloc.c        |  2 +-
 fs/ocfs2/aops.c         |  4 ++--
 fs/ocfs2/dir.c          |  8 ++++----
 fs/ocfs2/dlmfs/dlmfs.c  | 10 +++++-----
 fs/ocfs2/extent_map.c   | 12 ++++++------
 fs/ocfs2/inode.c        |  2 +-
 fs/ocfs2/quota_local.c  |  2 +-
 fs/ocfs2/refcounttree.c | 10 +++++-----
 fs/ocfs2/xattr.c        |  4 ++--
 9 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 344fd4d95fbc8bd7a749e9d51d31b5682ff030d0..d40f5d205bce3675ffd37e0e6c228e88c1804a1a 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7318,7 +7318,7 @@ int ocfs2_commit_truncate(struct ocfs2_super *osb,
 		 * to check it up here before changing the tree.
 		*/
 		if (root_el->l_tree_depth && rec->e_int_clusters == 0) {
-			mlog(ML_ERROR, "Inode %lu has an empty "
+			mlog(ML_ERROR, "Inode %llu has an empty "
 				    "extent record, depth %u\n", inode->i_ino,
 				    le16_to_cpu(root_el->l_tree_depth));
 			status = ocfs2_remove_rightmost_empty_extent(osb,
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 17ba79f443ee736cb5225702c57d13f4019f3c52..c7ad912ec7a0d6fffd09c3d38f110e5d1517d829 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -137,7 +137,7 @@ int ocfs2_get_block(struct inode *inode, sector_t iblock,
 			      (unsigned long long)iblock, bh_result, create);
 
 	if (OCFS2_I(inode)->ip_flags & OCFS2_INODE_SYSTEM_FILE)
-		mlog(ML_NOTICE, "get_block on system inode 0x%p (%lu)\n",
+		mlog(ML_NOTICE, "get_block on system inode 0x%p (%llu)\n",
 		     inode, inode->i_ino);
 
 	if (S_ISLNK(inode->i_mode)) {
@@ -2146,7 +2146,7 @@ static int ocfs2_dio_wr_get_block(struct inode *inode, sector_t iblock,
 	    ((iblock + ((len - 1) >> i_blkbits)) > endblk))
 		len = (endblk - iblock + 1) << i_blkbits;
 
-	mlog(0, "get block of %lu at %llu:%u req %u\n",
+	mlog(0, "get block of %llu at %llu:%u req %u\n",
 			inode->i_ino, pos, len, total_len);
 
 	/*
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 1c8abf2c592caacbe734d49254b04d507925c9d1..b82fe4431eb1f0811d81525237d02c5a3f3b021c 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -794,7 +794,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
 	if (le16_to_cpu(el->l_count) !=
 	    ocfs2_extent_recs_per_dx_root(inode->i_sb)) {
 		ret = ocfs2_error(inode->i_sb,
-				  "Inode %lu has invalid extent list length %u\n",
+				  "Inode %llu has invalid extent list length %u\n",
 				  inode->i_ino, le16_to_cpu(el->l_count));
 		goto out;
 	}
@@ -812,7 +812,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
 
 		if (el->l_tree_depth) {
 			ret = ocfs2_error(inode->i_sb,
-					  "Inode %lu has non zero tree depth in btree tree block %llu\n",
+					  "Inode %llu has non zero tree depth in btree tree block %llu\n",
 					  inode->i_ino,
 					  (unsigned long long)eb_bh->b_blocknr);
 			goto out;
@@ -821,7 +821,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
 
 	if (le16_to_cpu(el->l_next_free_rec) == 0) {
 		ret = ocfs2_error(inode->i_sb,
-				  "Inode %lu has empty extent list at depth %u\n",
+				  "Inode %llu has empty extent list at depth %u\n",
 				  inode->i_ino,
 				  le16_to_cpu(el->l_tree_depth));
 		goto out;
@@ -839,7 +839,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
 
 	if (!found) {
 		ret = ocfs2_error(inode->i_sb,
-				  "Inode %lu has bad extent record (%u, %u, 0) in btree\n",
+				  "Inode %llu has bad extent record (%u, %u, 0) in btree\n",
 				  inode->i_ino,
 				  le32_to_cpu(rec->e_cpos),
 				  ocfs2_rec_clusters(el, rec));
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 45cce261da65cab7ef48b5b88c0de5d41fa57615..5821e33df78fd92fabc7fe7fa1c3b3c62c50f9f8 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -123,7 +123,7 @@ static int dlmfs_file_open(struct inode *inode,
 	if (S_ISDIR(inode->i_mode))
 		BUG();
 
-	mlog(0, "open called on inode %lu, flags 0x%x\n", inode->i_ino,
+	mlog(0, "open called on inode %llu, flags 0x%x\n", inode->i_ino,
 		file->f_flags);
 
 	status = dlmfs_decode_open_flags(file->f_flags, &level, &flags);
@@ -170,7 +170,7 @@ static int dlmfs_file_release(struct inode *inode,
 	if (S_ISDIR(inode->i_mode))
 		BUG();
 
-	mlog(0, "close called on inode %lu\n", inode->i_ino);
+	mlog(0, "close called on inode %llu\n", inode->i_ino);
 
 	if (fp) {
 		level = fp->fp_lock_level;
@@ -242,7 +242,7 @@ static ssize_t dlmfs_file_write(struct file *filp,
 	int bytes_left;
 	struct inode *inode = file_inode(filp);
 
-	mlog(0, "inode %lu, count = %zu, *ppos = %llu\n",
+	mlog(0, "inode %llu, count = %zu, *ppos = %llu\n",
 		inode->i_ino, count, *ppos);
 
 	if (*ppos >= DLM_LVB_LEN)
@@ -301,7 +301,7 @@ static void dlmfs_evict_inode(struct inode *inode)
 
 	clear_inode(inode);
 
-	mlog(0, "inode %lu\n", inode->i_ino);
+	mlog(0, "inode %llu\n", inode->i_ino);
 
 	ip = DLMFS_I(inode);
 	lockres = &ip->ip_lockres;
@@ -490,7 +490,7 @@ static int dlmfs_unlink(struct inode *dir,
 	int status;
 	struct inode *inode = d_inode(dentry);
 
-	mlog(0, "unlink inode %lu\n", inode->i_ino);
+	mlog(0, "unlink inode %llu\n", inode->i_ino);
 
 	/* if there are no current holders, or none that are waiting
 	 * to acquire a lock, this basically destroys our lockres. */
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index d68229422dda3423971d7ab0e9a4335acab8b344..eb5dcd17d43752c08eab423fd667b7c0363ba6a1 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -291,7 +291,7 @@ static int ocfs2_last_eb_is_empty(struct inode *inode,
 
 	if (el->l_tree_depth) {
 		ocfs2_error(inode->i_sb,
-			    "Inode %lu has non zero tree depth in leaf block %llu\n",
+			    "Inode %llu has non zero tree depth in leaf block %llu\n",
 			    inode->i_ino,
 			    (unsigned long long)eb_bh->b_blocknr);
 		ret = -EROFS;
@@ -427,7 +427,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
 
 		if (el->l_tree_depth) {
 			ocfs2_error(inode->i_sb,
-				    "Inode %lu has non zero tree depth in leaf block %llu\n",
+				    "Inode %llu has non zero tree depth in leaf block %llu\n",
 				    inode->i_ino,
 				    (unsigned long long)eb_bh->b_blocknr);
 			ret = -EROFS;
@@ -437,7 +437,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
 
 	if (le16_to_cpu(el->l_next_free_rec) > le16_to_cpu(el->l_count)) {
 		ocfs2_error(inode->i_sb,
-			    "Inode %lu has an invalid extent (next_free_rec %u, count %u)\n",
+			    "Inode %llu has an invalid extent (next_free_rec %u, count %u)\n",
 			    inode->i_ino,
 			    le16_to_cpu(el->l_next_free_rec),
 			    le16_to_cpu(el->l_count));
@@ -472,7 +472,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
 
 	if (!rec->e_blkno) {
 		ocfs2_error(inode->i_sb,
-			    "Inode %lu has bad extent record (%u, %u, 0)\n",
+			    "Inode %llu has bad extent record (%u, %u, 0)\n",
 			    inode->i_ino,
 			    le32_to_cpu(rec->e_cpos),
 			    ocfs2_rec_clusters(el, rec));
@@ -561,7 +561,7 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 v_cluster,
 
 		if (el->l_tree_depth) {
 			ocfs2_error(inode->i_sb,
-				    "Inode %lu has non zero tree depth in xattr leaf block %llu\n",
+				    "Inode %llu has non zero tree depth in xattr leaf block %llu\n",
 				    inode->i_ino,
 				    (unsigned long long)eb_bh->b_blocknr);
 			ret = -EROFS;
@@ -580,7 +580,7 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 v_cluster,
 
 		if (!rec->e_blkno) {
 			ocfs2_error(inode->i_sb,
-				    "Inode %lu has bad extent record (%u, %u, 0) in xattr\n",
+				    "Inode %llu has bad extent record (%u, %u, 0) in xattr\n",
 				    inode->i_ino,
 				    le32_to_cpu(rec->e_cpos),
 				    ocfs2_rec_clusters(el, rec));
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 03a51662ea8e79f7a64fcd320b974f954b2ea8bf..26025ba2656c66b61866deaff60a0da204745c4f 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1196,7 +1196,7 @@ static void ocfs2_clear_inode(struct inode *inode)
 				inode->i_nlink);
 
 	mlog_bug_on_msg(osb == NULL,
-			"Inode=%lu\n", inode->i_ino);
+			"Inode=%llu\n", inode->i_ino);
 
 	dquot_drop(inode);
 
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index c4e0117d8977807dd6f0f4df64e1ddf72a62ea09..346c455d089564aa8c9bdead9385ef0e9eaef5cf 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -471,7 +471,7 @@ static int ocfs2_recover_local_quota_file(struct inode *lqinode,
 	qsize_t spacechange, inodechange;
 	unsigned int memalloc;
 
-	trace_ocfs2_recover_local_quota_file((unsigned long)lqinode->i_ino, type);
+	trace_ocfs2_recover_local_quota_file((unsigned long long)lqinode->i_ino, type);
 
 	list_for_each_entry_safe(rchunk, next, &(rec->r_list[type]), rc_list) {
 		chunk = rchunk->rc_chunk;
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index c1cdececdfa4ef51a1bd3a5addad734b324b92c0..6d7f44d3e929d94f3ba6121cc30a867887e0bbe3 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -2341,7 +2341,7 @@ static int ocfs2_mark_extent_refcounted(struct inode *inode,
 					   cpos, len, phys);
 
 	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb))) {
-		ret = ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
+		ret = ocfs2_error(inode->i_sb, "Inode %llu want to use refcount tree, but the feature bit is not set in the super block\n",
 				  inode->i_ino);
 		goto out;
 	}
@@ -2524,7 +2524,7 @@ int ocfs2_prepare_refcount_change_for_del(struct inode *inode,
 	u64 start_cpos = ocfs2_blocks_to_clusters(inode->i_sb, phys_blkno);
 
 	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb))) {
-		ret = ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
+		ret = ocfs2_error(inode->i_sb, "Inode %llu want to use refcount tree, but the feature bit is not set in the super block\n",
 				  inode->i_ino);
 		goto out;
 	}
@@ -2650,7 +2650,7 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
 
 		if (el->l_tree_depth) {
 			ret = ocfs2_error(inode->i_sb,
-					  "Inode %lu has non zero tree depth in leaf block %llu\n",
+					  "Inode %llu has non zero tree depth in leaf block %llu\n",
 					  inode->i_ino,
 					  (unsigned long long)eb_bh->b_blocknr);
 			goto out;
@@ -2662,7 +2662,7 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
 		rec = &el->l_recs[i];
 
 		if (ocfs2_is_empty_extent(rec)) {
-			mlog_bug_on_msg(i != 0, "Inode %lu has empty record in "
+			mlog_bug_on_msg(i != 0, "Inode %llu has empty record in "
 					"index %d\n", inode->i_ino, i);
 			continue;
 		}
@@ -3325,7 +3325,7 @@ static int ocfs2_replace_cow(struct ocfs2_cow_context *context)
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
 	if (!ocfs2_refcount_tree(osb)) {
-		return ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
+		return ocfs2_error(inode->i_sb, "Inode %llu want to use refcount tree, but the feature bit is not set in the super block\n",
 				   inode->i_ino);
 	}
 
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 42ee5db362d3eb6df886d6721dd7398b8aca8cdb..4d55ad963ac514b4b4081447af0992345facd83a 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -3741,7 +3741,7 @@ static int ocfs2_xattr_get_rec(struct inode *inode,
 
 		if (el->l_tree_depth) {
 			ret = ocfs2_error(inode->i_sb,
-					  "Inode %lu has non zero tree depth in xattr tree block %llu\n",
+					  "Inode %llu has non zero tree depth in xattr tree block %llu\n",
 					  inode->i_ino,
 					  (unsigned long long)eb_bh->b_blocknr);
 			goto out;
@@ -3758,7 +3758,7 @@ static int ocfs2_xattr_get_rec(struct inode *inode,
 	}
 
 	if (!e_blkno) {
-		ret = ocfs2_error(inode->i_sb, "Inode %lu has bad extent record (%u, %u, 0) in xattr\n",
+		ret = ocfs2_error(inode->i_sb, "Inode %llu has bad extent record (%u, %u, 0) in xattr\n",
 				  inode->i_ino,
 				  le32_to_cpu(rec->e_cpos),
 				  ocfs2_rec_clusters(el, rec));

-- 
2.53.0


