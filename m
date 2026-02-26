Return-Path: <linux-fsdevel+bounces-78560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPeeAEN2oGmtjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:35:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE41AA902
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9498C30A7A77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4043D510;
	Thu, 26 Feb 2026 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcTCpPsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74143D4F9;
	Thu, 26 Feb 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121830; cv=none; b=L4vvcLir4q+oYzeeJ9hylhktWIGxyU3v+uMdQeiH1YTMpD5xI+/ZeCgxvkRoE379LHAckxlauc2ZvxF2PDZsMhzf4os2T9hLLF2Sb0Lipseay46C+RKvM/Cg2eztHjT7WK36jdXjTs3YG84ovbcPn6ouyrk2YquVXE1Fy1jefgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121830; c=relaxed/simple;
	bh=7ZXyl76yXKAVgEB9XnfKu8Y7KFxyRRm589E8p3gkT2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWt+4vrpiSoXhtEiBjQrq+I1RJ3dH79fHgTfA6fv3D11VXE+m2nKwdXBF53AiUareajsA/A5szeeo4WRD04HVOH4Wc0B4+AtDM7mK7i5IHdPGJTcP68ruhQWXVjvCM9wIxBcO7akUmnvighWHifwxLsPeJ/VhpbezFHqm2KtQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcTCpPsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2E7C2BCB3;
	Thu, 26 Feb 2026 16:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121829;
	bh=7ZXyl76yXKAVgEB9XnfKu8Y7KFxyRRm589E8p3gkT2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KcTCpPsqT0E5ocLxE89k0oKhHGVx7VoQTn3/uYe5/qXwIXPvYdQEwFRCyS6KM1cNQ
	 zBEzmngpDW+7qc2cn+9opn0tPt8pJ7awOyzzo0R5hQL5PQdk4CPX09raGl2N5LarlE
	 7+YA4JD9zTwdj4F6AXiUzJ9Vh7bLryWHvL9ZqFHCerZTQRHd/fYOQx7E1Wh7ou7xgX
	 BxRLHJs9N2l7iFfbzvFtwyb2aFJy0N6n6b9nIrxXFd0GZBeTaQbiZSvOMvGG+M89eU
	 MR+4+e3oV4GpXdunFeQDn39GpWw62ct90x3cMW7WCAK3bvjdi6sKTZKRMHVG66nLiR
	 F4O2Jt9m7SwHw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:38 -0500
Subject: [PATCH 36/61] isofs: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-36-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3467; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7ZXyl76yXKAVgEB9XnfKu8Y7KFxyRRm589E8p3gkT2s=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0Nmf52pdo656jlWG4t6yni37xfclzHx2ZRe
 Hw1/6GQjdmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtDQAKCRAADmhBGVaC
 FW3AD/9rOAXtG95ctw6n0QBFd93xKDo7vJh93xVrf1hM7M7M9YqMLCRzKaYvrvf8+yQ1GDCcm3J
 S/+kU0HuaVEfXXKjGWe8VYJS5AHh2kuXydz4f8AZaFEh5T3E/tj5W6xHU2l3kMYX9rKqM+TLKUV
 6eDA2MJcyUi8LBzCkaElVmMUIuvbHvuj5FeqDDymRc0g5DEq88RLsQafiDn+oIBtQav0OwofD/H
 UQA2j5KV382N7yGCPNhG0xeX70APRR15I5Jkkh5E3JyUIUuJ/dgFHSNUFUvA6gV7BOMc9T75Idw
 /HFKLptC7dGdiHO2WKVZBqq3/xTN6Dy8AiyxY/qR2SBAPlRvyagaRa5sg3Nh5fqyn7rEO+K1SWz
 p2A0gQ+Pf1CwKBuynNegFK7pPKf29/drS5qS45bhHmF3NH/U2HdfJL4P6FzfjulDLVEZChFiqJr
 Z5Qok9gagjzuWpfkx9r97B/LKvi2+qoJXIwoRY4kPevQhamlcZ5ep4h5Af18MGgCCLLFoT08ZmV
 qUabhq/rjFG0UEiy72/s0O3dRIfUi16mLehRNeqlBe539MhbgGK1XFlaDDUVcGvzWA9YBWDWwBb
 bIZSztIcE7iXdNRY3OdAt/IfwuQbe0vr8GuaY4IIHodKPolCQQghHhemHJpZ91FU9wQppzWJQ2Y
 BHEQ22WX0qewrzQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78560-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90EE41AA902
X-Rspamd-Action: no action

Update format strings and local variable types in isofs for the
i_ino type change from unsigned long to u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/isofs/compress.c | 2 +-
 fs/isofs/dir.c      | 2 +-
 fs/isofs/inode.c    | 6 +++---
 fs/isofs/namei.c    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 50b4cb3aea87c7fc46b8b5483162bce84573b483..397568b9c7e7d3e28873be02c8a4befcddaec7b5 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -156,7 +156,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 				else {
 					printk(KERN_DEBUG
 					       "zisofs: zisofs_inflate returned"
-					       " %d, inode = %lu,"
+					       " %d, inode = %llu,"
 					       " page idx = %d, bh idx = %d,"
 					       " avail_in = %ld,"
 					       " avail_out = %ld\n",
diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 2ca16c3fe5ef3427e5bbd0631eb8323ef3c58bf1..2fd9948d606e9c92f3003bfbaa4f0271c750a93d 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -152,7 +152,7 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 		    de_len < de->name_len[0] +
 					sizeof(struct iso_directory_record)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
-			       " in block %lu of inode %lu\n", block,
+			       " in block %lu of inode %llu\n", block,
 			       inode->i_ino);
 			brelse(bh);
 			return -EIO;
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 5c01536c5e8fecb73a95d801cdd3b8ee22011a3c..1d9a8aeee1fd55998abca74c7e171dc2bc242084 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1261,7 +1261,7 @@ static int isofs_read_level3_size(struct inode *inode)
 
 out_toomany:
 	printk(KERN_INFO "%s: More than 100 file sections ?!?, aborting...\n"
-		"isofs_read_level3_size: inode=%lu\n",
+		"isofs_read_level3_size: inode=%llu\n",
 		__func__, inode->i_ino);
 	goto out;
 }
@@ -1380,7 +1380,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 	/* I have no idea what file_unit_size is used for, so
 	   we will flag it for now */
 	if (de->file_unit_size[0] != 0) {
-		printk(KERN_DEBUG "ISOFS: File unit size != 0 for ISO file (%ld).\n",
+		printk(KERN_DEBUG "ISOFS: File unit size != 0 for ISO file (%lld).\n",
 			inode->i_ino);
 	}
 
@@ -1450,7 +1450,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 		/* XXX - parse_rock_ridge_inode() had already set i_rdev. */
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
 	} else {
-		printk(KERN_DEBUG "ISOFS: Invalid file type 0%04o for inode %lu.\n",
+		printk(KERN_DEBUG "ISOFS: Invalid file type 0%04o for inode %llu.\n",
 			inode->i_mode, inode->i_ino);
 		ret = -EIO;
 		goto fail;
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index 58f80e1b3ac0d5082c24b5dbfd064cf5bff7d5a5..8dd3911717e0cc221f60fb6447e1bf26cc2223dd 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -100,7 +100,7 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 		/* Basic sanity check, whether name doesn't exceed dir entry */
 		if (de_len < dlen + sizeof(struct iso_directory_record)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
-			       " in block %lu of inode %lu\n", block,
+			       " in block %lu of inode %llu\n", block,
 			       dir->i_ino);
 			brelse(bh);
 			return 0;

-- 
2.53.0


