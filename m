Return-Path: <linux-fsdevel+bounces-78573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID2YN/N5oGmMkAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:50:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C41231AB2AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31F9232E8223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09634C956B;
	Thu, 26 Feb 2026 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmkL8rma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832244103E;
	Thu, 26 Feb 2026 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121992; cv=none; b=Bvw/CjLtp4YEka65StIO3j3zs7EwiUkz/oDJSPIocMdwJdVhXrsdnj4UgtLmZ1bE7esbA94UMA0BmLeVomAL+3gNNCWrp4a21vfgP1M/0gFAULMqyDaVgB42HDN5w/JTAe0E9L70zQSSDX7/UWzC1ulltbCoKs/JY7S5dZSYMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121992; c=relaxed/simple;
	bh=UzUJVkE54+5worUh+6CVBOEGlTktcxnLHEhhDzvvwXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNnbiiyqCUoZa8g7pU/lP2muWfvLZlHCKsHygNy/AoLRTt9IMjsPezZkt9RvkPrGvr9y63XyBggCjkwflNXsnnBE/kATg2DZzzChwZ8dfmLVYGhaee1xTGn7yLaSt+yJcYsNBSzH+ByzYIk7QSdoH1u4qBjh3o3QHGN+WgyyRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmkL8rma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED574C2BCAF;
	Thu, 26 Feb 2026 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121991;
	bh=UzUJVkE54+5worUh+6CVBOEGlTktcxnLHEhhDzvvwXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kmkL8rmaozr/GXIlU/D7mK8GBNmNhhiV1Q8VAayDic9ByvlDowdpB6ogncyg9UwTh
	 eB4Bkt9hNTQkgrFB3r8PReLXMHxe05on7pqliEoz7iGFB0kzcqew7EKfooZtTC/q/b
	 2+GnTXGg4O6SOWtV+Fe8HB4W61tD7peqZKcxEz3PejxRcNOmZaCfRDBHNsWSNfedzQ
	 EFNcjkR14TRnUEgdMnm2SqkWGdd7BAj7KDR9jYJyk5bZYwRMg8RAWJMn2SND0n2gSk
	 h/yARg/DV+fMiSaKvZCrWFBIexFCxpRm6k+xA0n59bFkA5KAcDomjBkNRLgD4hDRZU
	 tqWfvejc7L1/Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:51 -0500
Subject: [PATCH 49/61] ufs: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-49-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9194; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UzUJVkE54+5worUh+6CVBOEGlTktcxnLHEhhDzvvwXo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0QVGhyJJXjlb0Ncw4uXhIxu6EV5MOzZNNp3
 gvBgg8J/O2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtEAAKCRAADmhBGVaC
 Ff+iD/wO+msPOQaend9RGYlXSQlSmXaivymDEu0nuVAnKZyjZbYxWvPNY2bhJjvYsPkvh+MWd3f
 8cMRNKE51rT2lYPI9r8YmbARRKckpiLX8YRuXQL26fwGK7qferIdfm/fxBQWMGuZb3B5xUExPwB
 MQXfy6cKzU9bynP1/NVvS8lAzFGnd/+I4SbsODF6dmbeehYcuIn1vQ4ggbv7iiWL8qNf2dtPAHh
 RLwCH9pZ3weunInHQbgOMowX2nZow+LkI0VFrVx2m4z54vRYdl6JIlxkG6PZXNEU1V/+BuxVPFV
 aC0WizkgjFeIdzzeMF81SoHOMOrleC1ZP+CLELNh/7VBCzX+5ZJjuT2m7fUr0y0X2al4NiTM6+E
 RnJJr8b019swsihaUbYJiTL0jiq5z5t5XzkZkJJRlqsPQNCqYUUrD+WsBEQ+r5eW/P+EdgZBDEd
 zwycEJ5ba9Sp3eF2fTEZ6d518Ri948FUEmDt0VrJestxGs6a9mmg25imFrXNOjfziIw6WENc6/U
 TJv7lBjDApR3WVdhISSn9oGRuOc0EaBDKdvQDB2DriRAla8NcD9AEgjaOp/S726BSztATlmMu3O
 G0Pc/ZYkAoZy4dExx5I3JPwmK3Xmwo0OiktEYvcT0znNkk34XPloOoANLg762thAyWbbxRUmte4
 28SOSQyVJZbEdpg==
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
	TAGGED_FROM(0.00)[bounces-78573-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: C41231AB2AA
X-Rspamd-Action: no action

Update format strings and local variable types in ufs for the
i_ino type change from unsigned long to u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ufs/balloc.c |  6 +++---
 fs/ufs/dir.c    | 10 +++++-----
 fs/ufs/ialloc.c |  6 +++---
 fs/ufs/inode.c  | 18 +++++++++---------
 fs/ufs/ufs_fs.h |  6 +++---
 fs/ufs/util.c   |  2 +-
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 194ed3ab945e3eae94db085ee8d37eb1a4439470..628edfde3a9fd73852930094c19ae6944858f2c4 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -245,7 +245,7 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 	sector_t end, i;
 	struct buffer_head *head, *bh;
 
-	UFSD("ENTER, ino %lu, count %u, oldb %llu, newb %llu\n",
+	UFSD("ENTER, ino %llu, count %u, oldb %llu, newb %llu\n",
 	      inode->i_ino, count,
 	     (unsigned long long)oldb, (unsigned long long)newb);
 
@@ -340,7 +340,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 	unsigned cgno, oldcount, newcount;
 	u64 tmp, request, result;
 	
-	UFSD("ENTER, ino %lu, fragment %llu, goal %llu, count %u\n",
+	UFSD("ENTER, ino %llu, fragment %llu, goal %llu, count %u\n",
 	     inode->i_ino, (unsigned long long)fragment,
 	     (unsigned long long)goal, count);
 	
@@ -583,7 +583,7 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 	unsigned oldcg, i, j, k, allocsize;
 	u64 result;
 	
-	UFSD("ENTER, ino %lu, cgno %u, goal %llu, count %u\n",
+	UFSD("ENTER, ino %llu, cgno %u, goal %llu, count %u\n",
 	     inode->i_ino, cgno, (unsigned long long)goal, count);
 
 	sb = inode->i_sb;
diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 43f1578ab8666a9611d4a77f5aababfce812fbe4..f10a50f7e78b8020fd216eff19c147b20bd332c1 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -150,7 +150,7 @@ static bool ufs_check_folio(struct folio *folio, char *kaddr)
 
 Ebadsize:
 	ufs_error(sb, __func__,
-		  "size of directory #%lu is not a multiple of chunk size",
+		  "size of directory #%llu is not a multiple of chunk size",
 		  dir->i_ino
 	);
 	goto fail;
@@ -169,7 +169,7 @@ static bool ufs_check_folio(struct folio *folio, char *kaddr)
 Einumber:
 	error = "inode out of bounds";
 bad_entry:
-	ufs_error(sb, __func__, "bad entry in directory #%lu: %s - "
+	ufs_error(sb, __func__, "bad entry in directory #%llu: %s - "
 		   "offset=%llu, rec_len=%d, name_len=%d",
 		   dir->i_ino, error, folio_pos(folio) + offs,
 		   rec_len, ufs_get_de_namlen(sb, p));
@@ -177,7 +177,7 @@ static bool ufs_check_folio(struct folio *folio, char *kaddr)
 Eend:
 	p = (struct ufs_dir_entry *)(kaddr + offs);
 	ufs_error(sb, __func__,
-		   "entry in directory #%lu spans the page boundary"
+		   "entry in directory #%llu spans the page boundary"
 		   "offset=%llu",
 		   dir->i_ino, folio_pos(folio) + offs);
 fail:
@@ -258,7 +258,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 	struct ufs_inode_info *ui = UFS_I(dir);
 	struct ufs_dir_entry *de;
 
-	UFSD("ENTER, dir_ino %lu, name %s, namlen %u\n", dir->i_ino, name, namelen);
+	UFSD("ENTER, dir_ino %llu, name %s, namlen %u\n", dir->i_ino, name, namelen);
 
 	if (npages == 0 || namelen > UFS_MAXNAMLEN)
 		goto out;
@@ -434,7 +434,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 
 		if (IS_ERR(kaddr)) {
 			ufs_error(sb, __func__,
-				  "bad page in #%lu",
+				  "bad page in #%llu",
 				  inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
 			return PTR_ERR(kaddr);
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index 73531827ecee12b3dff09aef0acc0e374b00fb29..8e51f4630d186ae49aa987ca46df20960f300614 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -63,7 +63,7 @@ void ufs_free_inode (struct inode * inode)
 	int is_directory;
 	unsigned ino, cg, bit;
 	
-	UFSD("ENTER, ino %lu\n", inode->i_ino);
+	UFSD("ENTER, ino %llu\n", inode->i_ino);
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -317,7 +317,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 		bh = sb_bread(sb, uspi->s_sbbase + ufs_inotofsba(inode->i_ino));
 		if (!bh) {
 			ufs_warning(sb, "ufs_read_inode",
-				    "unable to read inode %lu\n",
+				    "unable to read inode %llu\n",
 				    inode->i_ino);
 			err = -EIO;
 			goto fail_remove_inode;
@@ -336,7 +336,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	}
 	mutex_unlock(&sbi->s_lock);
 
-	UFSD("allocating inode %lu\n", inode->i_ino);
+	UFSD("allocating inode %llu\n", inode->i_ino);
 	UFSD("EXIT\n");
 	return inode;
 
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index e2b0a35de2a7000f46a298114c1dcaffa17c43dc..2a8728c879796403166f713d1b4ee1b05fe1ffed 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -400,7 +400,7 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 
 	mutex_lock(&UFS_I(inode)->truncate_mutex);
 
-	UFSD("ENTER, ino %lu, fragment %llu\n", inode->i_ino, (unsigned long long)fragment);
+	UFSD("ENTER, ino %llu, fragment %llu\n", inode->i_ino, (unsigned long long)fragment);
 	if (unlikely(!depth)) {
 		ufs_warning(sb, "ufs_get_block", "block > big");
 		err = -EIO;
@@ -595,7 +595,7 @@ static int ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
 	struct super_block *sb = inode->i_sb;
 	umode_t mode;
 
-	UFSD("Reading ufs2 inode, ino %lu\n", inode->i_ino);
+	UFSD("Reading ufs2 inode, ino %llu\n", inode->i_ino);
 	/*
 	 * Copy data to the in-core inode.
 	 */
@@ -662,7 +662,7 @@ struct inode *ufs_iget(struct super_block *sb, unsigned long ino)
 
 	bh = sb_bread(sb, uspi->s_sbbase + ufs_inotofsba(inode->i_ino));
 	if (!bh) {
-		ufs_warning(sb, "ufs_read_inode", "unable to read inode %lu\n",
+		ufs_warning(sb, "ufs_read_inode", "unable to read inode %llu\n",
 			    inode->i_ino);
 		goto bad_inode;
 	}
@@ -793,17 +793,17 @@ static int ufs_update_inode(struct inode * inode, int do_sync)
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct buffer_head * bh;
 
-	UFSD("ENTER, ino %lu\n", inode->i_ino);
+	UFSD("ENTER, ino %llu\n", inode->i_ino);
 
 	if (inode->i_ino < UFS_ROOTINO ||
 	    inode->i_ino > (uspi->s_ncg * uspi->s_ipg)) {
-		ufs_warning (sb, "ufs_read_inode", "bad inode number (%lu)\n", inode->i_ino);
+		ufs_warning (sb, "ufs_read_inode", "bad inode number (%llu)\n", inode->i_ino);
 		return -1;
 	}
 
 	bh = sb_bread(sb, ufs_inotofsba(inode->i_ino));
 	if (!bh) {
-		ufs_warning (sb, "ufs_read_inode", "unable to read inode %lu\n", inode->i_ino);
+		ufs_warning (sb, "ufs_read_inode", "unable to read inode %llu\n", inode->i_ino);
 		return -1;
 	}
 	if (uspi->fs_magic == UFS2_MAGIC) {
@@ -891,7 +891,7 @@ static void ufs_trunc_direct(struct inode *inode)
 	unsigned int old_tail, new_tail;
 	struct to_free ctx = {.inode = inode};
 
-	UFSD("ENTER: ino %lu\n", inode->i_ino);
+	UFSD("ENTER: ino %llu\n", inode->i_ino);
 
 	new_frags = DIRECT_FRAGMENT;
 	// new_frags = first fragment past the new EOF
@@ -956,7 +956,7 @@ static void ufs_trunc_direct(struct inode *inode)
 		}
 	}
 done:
-	UFSD("EXIT: ino %lu\n", inode->i_ino);
+	UFSD("EXIT: ino %llu\n", inode->i_ino);
 }
 
 static void free_full_branch(struct inode *inode, u64 ind_block, int depth)
@@ -1169,7 +1169,7 @@ static int ufs_truncate(struct inode *inode, loff_t size)
 {
 	int err = 0;
 
-	UFSD("ENTER: ino %lu, i_size: %llu, old_i_size: %llu\n",
+	UFSD("ENTER: ino %llu, i_size: %llu, old_i_size: %llu\n",
 	     inode->i_ino, (unsigned long long)size,
 	     (unsigned long long)i_size_read(inode));
 
diff --git a/fs/ufs/ufs_fs.h b/fs/ufs/ufs_fs.h
index 0905f9a16b9150b656bd6d8966c0f8cc220b439d..b8dc354ae90f4a0839303f89c87bd2940db62b99 100644
--- a/fs/ufs/ufs_fs.h
+++ b/fs/ufs/ufs_fs.h
@@ -226,10 +226,10 @@ typedef __u16 __bitwise __fs16;
  *     inode number to cylinder group number.
  *     inode number to file system block address.
  */
-#define	ufs_inotocg(x)		((x) / uspi->s_ipg)
-#define	ufs_inotocgoff(x)	((x) % uspi->s_ipg)
+#define	ufs_inotocg(x)		((unsigned int)(x) / uspi->s_ipg)
+#define	ufs_inotocgoff(x)	((unsigned int)(x) % uspi->s_ipg)
 #define	ufs_inotofsba(x)	(((u64)ufs_cgimin(ufs_inotocg(x))) + ufs_inotocgoff(x) / uspi->s_inopf)
-#define	ufs_inotofsbo(x)	((x) % uspi->s_inopf)
+#define	ufs_inotofsbo(x)	((unsigned int)(x) % uspi->s_inopf)
 
 /*
  * Compute the cylinder and rotational position of a cyl block addr.
diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 034b1d82c355ca49ec917e98dcfcc6d80e6eb00b..dff6f74618def7bd5687bd7427f3001a78b708b8 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -203,7 +203,7 @@ struct folio *ufs_get_locked_folio(struct address_space *mapping,
 		folio = read_mapping_folio(mapping, index, NULL);
 
 		if (IS_ERR(folio)) {
-			printk(KERN_ERR "ufs_change_blocknr: read_mapping_folio error: ino %lu, index: %lu\n",
+			printk(KERN_ERR "ufs_change_blocknr: read_mapping_folio error: ino %llu, index: %lu\n",
 			       mapping->host->i_ino, index);
 			return folio;
 		}

-- 
2.53.0


