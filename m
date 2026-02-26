Return-Path: <linux-fsdevel+bounces-78571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKXlCXZ+oGlgkQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:10:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2EC1ABD6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 334B1313C223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45C04C77C0;
	Thu, 26 Feb 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L94xfs5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A44BCAC9;
	Thu, 26 Feb 2026 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121966; cv=none; b=Y7BKSVlFtdNffFd/Dho1REg/w3DZCEOjoMuqGmDh2RU1iZRANTVNnmlEhEuQIgJjux29FOQtOnHClhiOcvrY9P4xo+L6ytXmuMR6cOrK7103ISvR9oauxwesTD/HAzp1ILCRW03avsGRPZSHDDiFlJ0XdwKtJquwLqAuogC8g/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121966; c=relaxed/simple;
	bh=q+bcxkl7x+wO0XFiFu/znjyA1wp3zKjgxGfQeY8dkXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAdVJDc6WaPvrts0dqDv6CZguIwlTlmMYSGEupR2+oxtUJ2EpCUo57+F0hzgVzrOOR2cFUjhs3UHzCoIOGKOWhuRy+mymS+83RfxvB2A+kGvc81BCUdVVBreSKeU1GTd6Clzvw38FqEOg0Z5mHKQBaw4f6KGB52HJawF2wKuzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L94xfs5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2DBC19423;
	Thu, 26 Feb 2026 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121966;
	bh=q+bcxkl7x+wO0XFiFu/znjyA1wp3zKjgxGfQeY8dkXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L94xfs5r7lo8rSBYQNyS3HIEom/2svL4r4BMlz+u57ucCljy5GwDuDzExr4Qn59Yv
	 UeQbW3s0K6wkB8oiQXf8Qrf6bOznA+IrH94NqFzEFobhi0xJGsa33otRBe0vxGdSBL
	 o/xoyfMd/pP4jdrWJmB0RZTX8dgBTApl1jq2O+cEGORpCT6hXCX12kzYCzo5ErNxi9
	 jfkBUGApQRXOG8Z72SrVXZKCyxwrXPeX/7KSjwPoDzO/Q5Us+3trMFFSieiVbIKNDy
	 incYBTR819n1LcIo66kxqD+Ll8zJi0vAcgRSPMSxmTWzOJERHupi3COP4QK2k/Dqoh
	 swRH0gXeSfTog==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:49 -0500
Subject: [PATCH 47/61] ubifs: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-47-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20772; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=q+bcxkl7x+wO0XFiFu/znjyA1wp3zKjgxGfQeY8dkXE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0Q+IbHK4956UER9wi3fedY0n/I2aaROMBiB
 kyVS8oxqKqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtEAAKCRAADmhBGVaC
 FVMBD/4yItGJmJRvKwMWw0P4j1lljqw/kujaYTmyJytGnZoNsrVtmGe9c7ZOJ2EBVrBR697CyVM
 USBFHS42wKxWBjzoNuJeszljlbJjesRGPLcnRP0cFsNxNyzWAuChQLgFemibljHOHVVJnlPTKaE
 3pnv4iPn45fsZmImC7pEZUdFJK+Q8OOzI67CF5NeqDezLkOu17wt+jLRdh/QG8YPSCk1av+DAAW
 lApDJ0QFcZStQlZJFBF3Hff3iJdbnXu+87B5NGPAn39QTeJZOtsWCfSq3DBoJ+MGhSpIv71N7s1
 D3zkeBnE0Zlg4n8cCFLmejtKuC0Myhl80wHzI2Ro92Mt6Uc1QvZdUSrInJBCA06e0+Rm8CscbKb
 JfMaQi7gXtjfnSBFuS5VJrDEpDN/qIC5rftirzo48afSzsV+HDHVUyGAyNkFKwYDzbrDAa72Y85
 UebxvXtJElbQ/lciYxWS99bana/DVNi2wwjyrVPV/LQWq6kjkbAO+Q8754Z9GrFvj8Rdzx2Hhdb
 gyz9tchSOg50NJ7qVT+zL6RQibe0RD7pACR4WuVD3dUZGwW4+DXFez1Dus6uuCSPwyVBvVwgNP7
 yYN5pvfI2w/ZxZcmmzxZUBsYfYZBXy6Td0UvmlyOuQRHIiO9D4aaq62sqmGxfztBuLFYG8x/wTa
 qH2rjBE/wZg93dQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78571-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 2E2EC1ABD6A
X-Rspamd-Action: no action

Update format strings and local variable types in ubifs for the
i_ino type change from unsigned long to u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ubifs/debug.c   |  8 ++++----
 fs/ubifs/dir.c     | 28 ++++++++++++++--------------
 fs/ubifs/file.c    | 28 ++++++++++++++--------------
 fs/ubifs/journal.c |  6 +++---
 fs/ubifs/super.c   | 16 ++++++++--------
 fs/ubifs/tnc.c     |  4 ++--
 fs/ubifs/xattr.c   | 14 +++++++-------
 7 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 160c16aa7b6e7088355582670357262ab3930225..5794de5a9069f20302b6630c39c1452183137acc 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -230,7 +230,7 @@ void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode)
 	int count = 2;
 
 	pr_err("Dump in-memory inode:");
-	pr_err("\tinode          %lu\n", inode->i_ino);
+	pr_err("\tinode          %llu\n", inode->i_ino);
 	pr_err("\tsize           %llu\n",
 	       (unsigned long long)i_size_read(inode));
 	pr_err("\tnlink          %u\n", inode->i_nlink);
@@ -1101,7 +1101,7 @@ int dbg_check_synced_i_size(const struct ubifs_info *c, struct inode *inode)
 	if (ui->ui_size != ui->synced_i_size && !ui->dirty) {
 		ubifs_err(c, "ui_size is %lld, synced_i_size is %lld, but inode is clean",
 			  ui->ui_size, ui->synced_i_size);
-		ubifs_err(c, "i_ino %lu, i_mode %#x, i_size %lld", inode->i_ino,
+		ubifs_err(c, "i_ino %llu, i_mode %#x, i_size %lld", inode->i_ino,
 			  inode->i_mode, i_size_read(inode));
 		dump_stack();
 		err = -EINVAL;
@@ -1163,7 +1163,7 @@ int dbg_check_dir(struct ubifs_info *c, const struct inode *dir)
 	kfree(pdent);
 
 	if (i_size_read(dir) != size) {
-		ubifs_err(c, "directory inode %lu has size %llu, but calculated size is %llu",
+		ubifs_err(c, "directory inode %llu has size %llu, but calculated size is %llu",
 			  dir->i_ino, (unsigned long long)i_size_read(dir),
 			  (unsigned long long)size);
 		ubifs_dump_inode(c, dir);
@@ -1171,7 +1171,7 @@ int dbg_check_dir(struct ubifs_info *c, const struct inode *dir)
 		return -EINVAL;
 	}
 	if (dir->i_nlink != nlink) {
-		ubifs_err(c, "directory inode %lu has nlink %u, but calculated nlink is %u",
+		ubifs_err(c, "directory inode %llu has nlink %u, but calculated nlink is %u",
 			  dir->i_ino, dir->i_nlink, nlink);
 		ubifs_dump_inode(c, dir);
 		dump_stack();
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 4c9f57f3b2adbbd396b288878cb18fa87cdbd0df..86d41e077e4d621dbb8c448acd0065c8ac7ae225 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -223,7 +223,7 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
 	struct fscrypt_name nm;
 
-	dbg_gen("'%pd' in dir ino %lu", dentry, dir->i_ino);
+	dbg_gen("'%pd' in dir ino %llu", dentry, dir->i_ino);
 
 	err = fscrypt_prepare_lookup(dir, dentry, &nm);
 	if (err == -ENOENT)
@@ -281,7 +281,7 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	if (IS_ENCRYPTED(dir) &&
 	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 	    !fscrypt_has_permitted_context(dir, inode)) {
-		ubifs_warn(c, "Inconsistent encryption contexts: %lu/%lu",
+		ubifs_warn(c, "Inconsistent encryption contexts: %llu/%llu",
 			   dir->i_ino, inode->i_ino);
 		iput(inode);
 		inode = ERR_PTR(-EPERM);
@@ -318,7 +318,7 @@ static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
 	 * parent directory inode.
 	 */
 
-	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
+	dbg_gen("dent '%pd', mode %#hx in dir ino %llu",
 		dentry, mode, dir->i_ino);
 
 	err = ubifs_budget_space(c, &req);
@@ -386,7 +386,7 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	 * atomically.
 	 */
 
-	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
+	dbg_gen("dent '%pd', mode %#hx in dir ino %llu",
 		dentry, mode, dir->i_ino);
 
 	inode = ubifs_new_inode(c, dir, mode, false);
@@ -460,7 +460,7 @@ static int ubifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	 * be released via writeback.
 	 */
 
-	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
+	dbg_gen("dent '%pd', mode %#hx in dir ino %llu",
 		dentry, mode, dir->i_ino);
 
 	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
@@ -589,7 +589,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 	bool encrypted = IS_ENCRYPTED(dir);
 	struct ubifs_dir_data *data = file->private_data;
 
-	dbg_gen("dir ino %lu, f_pos %#llx", dir->i_ino, ctx->pos);
+	dbg_gen("dir ino %llu, f_pos %#llx", dir->i_ino, ctx->pos);
 
 	if (ctx->pos > UBIFS_S_KEY_HASH_MASK || ctx->pos == 2)
 		/*
@@ -764,7 +764,7 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 	 * changing the parent inode.
 	 */
 
-	dbg_gen("dent '%pd' to ino %lu (nlink %d) in dir ino %lu",
+	dbg_gen("dent '%pd' to ino %llu (nlink %d) in dir ino %llu",
 		dentry, inode->i_ino,
 		inode->i_nlink, dir->i_ino);
 	ubifs_assert(c, inode_is_locked(dir));
@@ -836,7 +836,7 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
 	 * deletions.
 	 */
 
-	dbg_gen("dent '%pd' from ino %lu (nlink %d) in dir ino %lu",
+	dbg_gen("dent '%pd' from ino %llu (nlink %d) in dir ino %llu",
 		dentry, inode->i_ino,
 		inode->i_nlink, dir->i_ino);
 
@@ -941,7 +941,7 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
 	 * because we have extra space reserved for deletions.
 	 */
 
-	dbg_gen("directory '%pd', ino %lu in dir ino %lu", dentry,
+	dbg_gen("directory '%pd', ino %llu in dir ino %llu", dentry,
 		inode->i_ino, dir->i_ino);
 	ubifs_assert(c, inode_is_locked(dir));
 	ubifs_assert(c, inode_is_locked(inode));
@@ -1018,7 +1018,7 @@ static struct dentry *ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	 * directory inode.
 	 */
 
-	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
+	dbg_gen("dent '%pd', mode %#hx in dir ino %llu",
 		dentry, mode, dir->i_ino);
 
 	err = ubifs_budget_space(c, &req);
@@ -1096,7 +1096,7 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	 * directory inode.
 	 */
 
-	dbg_gen("dent '%pd' in dir ino %lu", dentry, dir->i_ino);
+	dbg_gen("dent '%pd' in dir ino %llu", dentry, dir->i_ino);
 
 	if (S_ISBLK(mode) || S_ISCHR(mode)) {
 		dev = kmalloc_obj(union ubifs_dev_desc, GFP_NOFS);
@@ -1183,7 +1183,7 @@ static int ubifs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 					.dirtied_ino = 1 };
 	struct fscrypt_name nm;
 
-	dbg_gen("dent '%pd', target '%s' in dir ino %lu", dentry,
+	dbg_gen("dent '%pd', target '%s' in dir ino %llu", dentry,
 		symname, dir->i_ino);
 
 	err = fscrypt_prepare_symlink(dir, symname, len, UBIFS_MAX_INO_DATA,
@@ -1349,7 +1349,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 *   ino_req: marks the target inode as dirty and does not write it.
 	 */
 
-	dbg_gen("dent '%pd' ino %lu in dir ino %lu to dent '%pd' in dir ino %lu flags 0x%x",
+	dbg_gen("dent '%pd' ino %llu in dir ino %llu to dent '%pd' in dir ino %llu flags 0x%x",
 		old_dentry, old_inode->i_ino, old_dir->i_ino,
 		new_dentry, new_dir->i_ino, flags);
 
@@ -1597,7 +1597,7 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	 * parent directory inodes.
 	 */
 
-	dbg_gen("dent '%pd' ino %lu in dir ino %lu exchange dent '%pd' ino %lu in dir ino %lu",
+	dbg_gen("dent '%pd' ino %llu in dir ino %llu exchange dent '%pd' ino %llu in dir ino %llu",
 		old_dentry, fst_inode->i_ino, old_dir->i_ino,
 		new_dentry, snd_inode->i_ino, new_dir->i_ino);
 
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index cd04755e792a7f8e7d33ed4e67806cd202c71fad..e73c28b12f97fd1fbeb67510434e499eab84da70 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -90,7 +90,7 @@ static int read_block(struct inode *inode, struct folio *folio, size_t offset,
 	return 0;
 
 dump:
-	ubifs_err(c, "bad data node (block %u, inode %lu)",
+	ubifs_err(c, "bad data node (block %u, inode %llu)",
 		  block, inode->i_ino);
 	ubifs_dump_node(c, dn, UBIFS_MAX_DATA_NODE_SZ);
 	return -EINVAL;
@@ -106,7 +106,7 @@ static int do_readpage(struct folio *folio)
 	loff_t i_size = i_size_read(inode);
 	size_t offset = 0;
 
-	dbg_gen("ino %lu, pg %lu, i_size %lld, flags %#lx",
+	dbg_gen("ino %llu, pg %lu, i_size %lld, flags %#lx",
 		inode->i_ino, folio->index, i_size, folio->flags.f);
 	ubifs_assert(c, !folio_test_checked(folio));
 	ubifs_assert(c, !folio->private);
@@ -162,7 +162,7 @@ static int do_readpage(struct folio *folio)
 			dbg_gen("hole");
 			err = 0;
 		} else {
-			ubifs_err(c, "cannot read page %lu of inode %lu, error %d",
+			ubifs_err(c, "cannot read page %lu of inode %llu, error %d",
 				  folio->index, inode->i_ino, err);
 		}
 	}
@@ -212,7 +212,7 @@ static int write_begin_slow(struct address_space *mapping,
 	int err, appending = !!(pos + len > inode->i_size);
 	struct folio *folio;
 
-	dbg_gen("ino %lu, pos %llu, len %u, i_size %lld",
+	dbg_gen("ino %llu, pos %llu, len %u, i_size %lld",
 		inode->i_ino, pos, len, inode->i_size);
 
 	/*
@@ -526,7 +526,7 @@ static int ubifs_write_end(const struct kiocb *iocb,
 	loff_t end_pos = pos + len;
 	int appending = !!(end_pos > inode->i_size);
 
-	dbg_gen("ino %lu, pos %llu, pg %lu, len %u, copied %d, i_size %lld",
+	dbg_gen("ino %llu, pos %llu, pg %lu, len %u, copied %d, i_size %lld",
 		inode->i_ino, pos, folio->index, len, copied, inode->i_size);
 
 	if (unlikely(copied < len && !folio_test_uptodate(folio))) {
@@ -599,7 +599,7 @@ static int populate_page(struct ubifs_info *c, struct folio *folio,
 	size_t offset = 0;
 	pgoff_t end_index;
 
-	dbg_gen("ino %lu, pg %lu, i_size %lld, flags %#lx",
+	dbg_gen("ino %llu, pg %lu, i_size %lld, flags %#lx",
 		inode->i_ino, folio->index, i_size, folio->flags.f);
 
 	end_index = (i_size - 1) >> PAGE_SHIFT;
@@ -680,7 +680,7 @@ static int populate_page(struct ubifs_info *c, struct folio *folio,
 	return 0;
 
 out_err:
-	ubifs_err(c, "bad data node (block %u, inode %lu)",
+	ubifs_err(c, "bad data node (block %u, inode %llu)",
 		  page_block, inode->i_ino);
 	return -EINVAL;
 }
@@ -913,7 +913,7 @@ static int do_writepage(struct folio *folio, size_t len)
 	}
 	if (err) {
 		mapping_set_error(folio->mapping, err);
-		ubifs_err(c, "cannot write folio %lu of inode %lu, error %d",
+		ubifs_err(c, "cannot write folio %lu of inode %llu, error %d",
 			  folio->index, inode->i_ino, err);
 		ubifs_ro_mode(c, err);
 	}
@@ -987,7 +987,7 @@ static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc)
 	loff_t i_size =  i_size_read(inode), synced_i_size;
 	int err, len = folio_size(folio);
 
-	dbg_gen("ino %lu, pg %lu, pg flags %#lx",
+	dbg_gen("ino %llu, pg %lu, pg flags %#lx",
 		inode->i_ino, folio->index, folio->flags.f);
 	ubifs_assert(c, folio->private != NULL);
 
@@ -1106,7 +1106,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 	int offset = new_size & (UBIFS_BLOCK_SIZE - 1), budgeted = 1;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 
-	dbg_gen("ino %lu, size %lld -> %lld", inode->i_ino, old_size, new_size);
+	dbg_gen("ino %llu, size %lld -> %lld", inode->i_ino, old_size, new_size);
 	memset(&req, 0, sizeof(struct ubifs_budget_req));
 
 	/*
@@ -1258,7 +1258,7 @@ int ubifs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 
-	dbg_gen("ino %lu, mode %#x, ia_valid %#x",
+	dbg_gen("ino %llu, mode %#x, ia_valid %#x",
 		inode->i_ino, inode->i_mode, attr->ia_valid);
 	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err)
@@ -1308,7 +1308,7 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	int err;
 
-	dbg_gen("syncing inode %lu", inode->i_ino);
+	dbg_gen("syncing inode %llu", inode->i_ino);
 
 	if (c->ro_mount)
 		/*
@@ -1495,7 +1495,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct ubifs_budget_req req = { .new_page = 1 };
 	int err, update_time;
 
-	dbg_gen("ino %lu, pg %lu, i_size %lld",	inode->i_ino, folio->index,
+	dbg_gen("ino %llu, pg %lu, i_size %lld",	inode->i_ino, folio->index,
 		i_size_read(inode));
 	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 
@@ -1531,7 +1531,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 	err = ubifs_budget_space(c, &req);
 	if (unlikely(err)) {
 		if (err == -ENOSPC)
-			ubifs_warn(c, "out of space for mmapped file (inode number %lu)",
+			ubifs_warn(c, "out of space for mmapped file (inode number %llu)",
 				   inode->i_ino);
 		return VM_FAULT_SIGBUS;
 	}
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index e28ab4395e5ca404d8e8d8f735c3113b58bcc941..40a95a2fad50039f39917e71da7b71a735237469 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -982,7 +982,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 	int kill_xattrs = ui->xattr_cnt && last_reference;
 	u8 hash[UBIFS_HASH_ARR_SZ];
 
-	dbg_jnl("ino %lu, nlink %u", inode->i_ino, inode->i_nlink);
+	dbg_jnl("ino %llu, nlink %u", inode->i_ino, inode->i_nlink);
 
 	if (kill_xattrs && ui->xattr_cnt > ubifs_xattr_max_cnt(c)) {
 		ubifs_err(c, "Cannot delete inode, it has too many xattrs!");
@@ -1743,7 +1743,7 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 			int dn_len = le32_to_cpu(dn->size);
 
 			if (dn_len <= 0 || dn_len > UBIFS_BLOCK_SIZE) {
-				ubifs_err(c, "bad data node (block %u, inode %lu)",
+				ubifs_err(c, "bad data node (block %u, inode %llu)",
 					  blk, inode->i_ino);
 				ubifs_dump_node(c, dn, dn_size);
 				err = -EUCLEAN;
@@ -1987,7 +1987,7 @@ int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode,
 	u8 hash_host[UBIFS_HASH_ARR_SZ];
 	u8 hash[UBIFS_HASH_ARR_SZ];
 
-	dbg_jnl("ino %lu, ino %lu", host->i_ino, inode->i_ino);
+	dbg_jnl("ino %llu, ino %llu", host->i_ino, inode->i_ino);
 	ubifs_assert(c, inode->i_nlink > 0);
 	ubifs_assert(c, mutex_is_locked(&host_ui->ui_mutex));
 
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 03bf924756ca003809d229837a970d5935450f23..9a77d8b64ffa70f9d5b695fb3d87c22cb223704f 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -92,7 +92,7 @@ static int validate_inode(struct ubifs_info *c, const struct inode *inode)
 		return 5;
 
 	if (!ubifs_compr_present(c, ui->compr_type)) {
-		ubifs_warn(c, "inode %lu uses '%s' compression, but it was not compiled in",
+		ubifs_warn(c, "inode %llu uses '%s' compression, but it was not compiled in",
 			   inode->i_ino, ubifs_compr_name(c, ui->compr_type));
 	}
 
@@ -248,14 +248,14 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 	return inode;
 
 out_invalid:
-	ubifs_err(c, "inode %lu validation failed, error %d", inode->i_ino, err);
+	ubifs_err(c, "inode %llu validation failed, error %d", inode->i_ino, err);
 	ubifs_dump_node(c, ino, UBIFS_MAX_INO_NODE_SZ);
 	ubifs_dump_inode(c, inode);
 	err = -EINVAL;
 out_ino:
 	kfree(ino);
 out:
-	ubifs_err(c, "failed to read inode %lu, error %d", inode->i_ino, err);
+	ubifs_err(c, "failed to read inode %llu, error %d", inode->i_ino, err);
 	iget_failed(inode);
 	return ERR_PTR(err);
 }
@@ -316,12 +316,12 @@ static int ubifs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 * As an optimization, do not write orphan inodes to the media just
 	 * because this is not needed.
 	 */
-	dbg_gen("inode %lu, mode %#x, nlink %u",
+	dbg_gen("inode %llu, mode %#x, nlink %u",
 		inode->i_ino, (int)inode->i_mode, inode->i_nlink);
 	if (inode->i_nlink) {
 		err = ubifs_jnl_write_inode(c, inode);
 		if (err)
-			ubifs_err(c, "can't write inode %lu, error %d",
+			ubifs_err(c, "can't write inode %llu, error %d",
 				  inode->i_ino, err);
 		else
 			err = dbg_check_inode_size(c, inode, ui->ui_size);
@@ -357,7 +357,7 @@ static void ubifs_evict_inode(struct inode *inode)
 		 */
 		goto out;
 
-	dbg_gen("inode %lu, mode %#x", inode->i_ino, (int)inode->i_mode);
+	dbg_gen("inode %llu, mode %#x", inode->i_ino, (int)inode->i_mode);
 	ubifs_assert(c, !icount_read(inode));
 
 	truncate_inode_pages_final(&inode->i_data);
@@ -375,7 +375,7 @@ static void ubifs_evict_inode(struct inode *inode)
 		 * Worst case we have a lost orphan inode wasting space, so a
 		 * simple error message is OK here.
 		 */
-		ubifs_err(c, "can't delete inode %lu, error %d",
+		ubifs_err(c, "can't delete inode %llu, error %d",
 			  inode->i_ino, err);
 
 out:
@@ -399,7 +399,7 @@ static void ubifs_dirty_inode(struct inode *inode, int flags)
 	ubifs_assert(c, mutex_is_locked(&ui->ui_mutex));
 	if (!ui->dirty) {
 		ui->dirty = 1;
-		dbg_gen("inode %lu",  inode->i_ino);
+		dbg_gen("inode %llu",  inode->i_ino);
 	}
 }
 
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 694b08d27d7d9c7d9d7d9039f406637c702f8613..52c758c5290d8cc425fdc6d49c608d0cb0ba7ff7 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -3561,8 +3561,8 @@ int dbg_check_inode_size(struct ubifs_info *c, const struct inode *inode,
 
 out_dump:
 	block = key_block(c, key);
-	ubifs_err(c, "inode %lu has size %lld, but there are data at offset %lld",
-		  (unsigned long)inode->i_ino, size,
+	ubifs_err(c, "inode %llu has size %lld, but there are data at offset %lld",
+		  (unsigned long long)inode->i_ino, size,
 		  ((loff_t)block) << UBIFS_BLOCK_SHIFT);
 	mutex_unlock(&c->tnc_mutex);
 	ubifs_dump_inode(c, inode);
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index c21a0c2b3e907c1572780d4a3e48cc9d2a11b9d6..b5a9ab9d8a10adcf49e6d7228d385cb986e6e75e 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -76,7 +76,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
 				.dirtied_ino_d = ALIGN(host_ui->data_len, 8) };
 
 	if (host_ui->xattr_cnt >= ubifs_xattr_max_cnt(c)) {
-		ubifs_err(c, "inode %lu already has too many xattrs (%d), cannot create more",
+		ubifs_err(c, "inode %llu already has too many xattrs (%d), cannot create more",
 			  host->i_ino, host_ui->xattr_cnt);
 		return -ENOSPC;
 	}
@@ -88,7 +88,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
 	 */
 	names_len = host_ui->xattr_names + host_ui->xattr_cnt + fname_len(nm) + 1;
 	if (names_len > XATTR_LIST_MAX) {
-		ubifs_err(c, "cannot add one more xattr name to inode %lu, total names length would become %d, max. is %d",
+		ubifs_err(c, "cannot add one more xattr name to inode %llu, total names length would become %d, max. is %d",
 			  host->i_ino, names_len, XATTR_LIST_MAX);
 		return -ENOSPC;
 	}
@@ -390,7 +390,7 @@ ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	int err, len, written = 0;
 	struct fscrypt_name nm = {0};
 
-	dbg_gen("ino %lu ('%pd'), buffer size %zd", host->i_ino,
+	dbg_gen("ino %llu ('%pd'), buffer size %zd", host->i_ino,
 		dentry, size);
 
 	down_read(&host_ui->xattr_sem);
@@ -498,7 +498,7 @@ int ubifs_purge_xattrs(struct inode *host)
 	if (ubifs_inode(host)->xattr_cnt <= ubifs_xattr_max_cnt(c))
 		return 0;
 
-	ubifs_warn(c, "inode %lu has too many xattrs, doing a non-atomic deletion",
+	ubifs_warn(c, "inode %llu has too many xattrs, doing a non-atomic deletion",
 		   host->i_ino);
 
 	down_write(&ubifs_inode(host)->xattr_sem);
@@ -641,7 +641,7 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
 					   &init_xattrs, NULL);
 	if (err) {
 		struct ubifs_info *c = dentry->i_sb->s_fs_info;
-		ubifs_err(c, "cannot initialize security for inode %lu, error %d",
+		ubifs_err(c, "cannot initialize security for inode %llu, error %d",
 			  inode->i_ino, err);
 	}
 	return err;
@@ -652,7 +652,7 @@ static int xattr_get(const struct xattr_handler *handler,
 			   struct dentry *dentry, struct inode *inode,
 			   const char *name, void *buffer, size_t size)
 {
-	dbg_gen("xattr '%s', ino %lu ('%pd'), buf size %zd", name,
+	dbg_gen("xattr '%s', ino %llu ('%pd'), buf size %zd", name,
 		inode->i_ino, dentry, size);
 
 	name = xattr_full_name(handler, name);
@@ -665,7 +665,7 @@ static int xattr_set(const struct xattr_handler *handler,
 			   const char *name, const void *value,
 			   size_t size, int flags)
 {
-	dbg_gen("xattr '%s', host ino %lu ('%pd'), size %zd",
+	dbg_gen("xattr '%s', host ino %llu ('%pd'), size %zd",
 		name, inode->i_ino, dentry, size);
 
 	name = xattr_full_name(handler, name);

-- 
2.53.0


