Return-Path: <linux-fsdevel+bounces-78536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDzQKoJyoGlZjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:19:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655D1AA015
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B119133003C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B1644BCBC;
	Thu, 26 Feb 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8gbu+8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713A4279E2;
	Thu, 26 Feb 2026 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121529; cv=none; b=TKsklukpxG+vjVVPtl4UENP/9R7fVviv1FdGiQV8F2s17v+Ro+ZUly7o+78IWCsSqZeRkKIMknUtqhZsx3MAK9N/k+DSZJLO5fJZkoYDeBJtSlCZ4NvQKsr8hVKe8enDWNcOyVHjPO42bL+dXoqwkob0OTwwx9uddtf/vELKSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121529; c=relaxed/simple;
	bh=LhaFa78gxfrhAkvUGOb7wByUuSw4XO1wqjqmi2Bt73w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCynXBnmqmGk/qmdIuxpZKfLAGSAvNqJupd8PcIuBS/v27+Em8KG1Ga71WQUp6A6xmL9XnUROyDzxbZkzlZP1z3ab+UmO9/zSCwVn9+z4ESnwvr0NVd9bf9iTvDBvo4vaAW+9pVm7VAwtepFCCf/QA5V7J6heMaWd7TGdX953eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8gbu+8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079EFC2BCB2;
	Thu, 26 Feb 2026 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121528;
	bh=LhaFa78gxfrhAkvUGOb7wByUuSw4XO1wqjqmi2Bt73w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X8gbu+8hqujtbKGPCk1kPp9AdxgQQkyTYj9wJK4pj1AfA95WhjTKyFeU7i6QaQx8b
	 9Ff3kMpD1HN5KfULOr+hQsKWxQmHLkAeP2AwYvDEMOGrubBkhhmBzel+V+p2akshV1
	 lMz3PJMZnZ3E6m7Cnekjggj9x6kL/psFgxA0zBreX3Ap1EYofbu7Ejxxv0CvjQvEwo
	 pv0FRN5+u7frv/KT2CA/l2hCSPNpzsLDbVm5/wlga5nePBBel9/Lzzjqp5aAxJnnb9
	 r9dOcdTC67BuqOWlM2nS1BVbe/ZwHV9tHVtRL0tm2G1CHH8o8qUYytQdyn4RDGT86n
	 icn3ZCUgQkpwg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:14 -0500
Subject: [PATCH 12/61] nfsd: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-12-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3147; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LhaFa78gxfrhAkvUGOb7wByUuSw4XO1wqjqmi2Bt73w=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0HXohJrTDl3u7/VSJPdaDuhMnlyPMlaLAj3
 YUIRWFp4d2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtBwAKCRAADmhBGVaC
 FVSAD/45IqX6+xuwmnva5iqZm4UD0KnQsGRgRCvM4rewzSVs0kNhmwVYfo4M76X3WuZ3BmOnejp
 B8bCkH+cbUqTeSJlVrlu+gobSIGqkVTdEbP3RY7gDlsdRrdKrlX0KdFgKAuQ/F+c/kJHYJ8mdls
 XMWNXEkLSm4Oai/DNU0JWUGlbxQr8yLKjQr6tLqu2eSVNruMbH7P7rjKnFS1S/IUJ5Bt5R+dg+N
 MPcfRmX5vBEywbG8UbmpmrBSycvmIOu1E0xJ39xzHzAcGh+B6A+pJpll3EZJ8oMQjM71t99TuvX
 iSplgvSyk0Zftf/+KWp39q/iYqxtmn/QWSo3g750DjcneR3akuimY3L4StuTSmCDwHlE17nZllM
 vBwGoFwCrCpeFop2J9W+Vc4DojDlUAoL9Qjupq0+QAzWsowxM8g8TwUY/pqNEpG85H7dUOO3O+9
 BFKKL/vgVc/VQBGGG8NQnp+kxJGJmlzGlThmm25qVW95D7ViecdZFgRRlfXZ4VsoG1jUUTz+GM9
 VA2pkfO37UG6fnUG9Tlm4eE/MjOnYU81htNYZ175MzZhO14jPlYNj54a/SJDiSJUwO8lGHolcSC
 e2nIDBpzR86KF3pOF6P51Xv7IgnvEE/GNwB7C3YM70SH33V3PIgvJuvCmshoAcD2q53Ode6yQet
 YES9kPT7R903z7g==
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
	TAGGED_FROM(0.00)[bounces-78536-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 5655D1AA015
X-Rspamd-Action: no action

Update format strings from %ld/%lu to %lld/%llu for i_ino, which is
now a u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c    | 2 +-
 fs/nfsd/nfs4state.c | 4 ++--
 fs/nfsd/nfsfh.c     | 4 ++--
 fs/nfsd/vfs.c       | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 8fdbba7cad96443d92cc7fdeea6158c4cc681be1..334b63eb966e71e6af6adde61aa1123f01b4390b 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1039,7 +1039,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
 	}
 	inode = d_inode(path.dentry);
 
-	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
+	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%lld)\n",
 		 name, path.dentry, clp->name,
 		 inode->i_sb->s_id, inode->i_ino);
 	exp = exp_parent(cd, clp, &path);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6b9c399b89dfb71a52b9c97f0efe9a1dea0558a6..a569d89ac9123d66bb47e7d74c7c98610de21da2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1253,7 +1253,7 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 	if (ret) {
 		struct inode *inode = file_inode(f);
 
-		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%lu: %d\n",
+		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%llu: %d\n",
 					MAJOR(inode->i_sb->s_dev),
 					MINOR(inode->i_sb->s_dev),
 					inode->i_ino, ret);
@@ -2888,7 +2888,7 @@ static void nfs4_show_superblock(struct seq_file *s, struct nfsd_file *f)
 {
 	struct inode *inode = file_inode(f->nf_file);
 
-	seq_printf(s, "superblock: \"%02x:%02x:%ld\"",
+	seq_printf(s, "superblock: \"%02x:%02x:%llu\"",
 					MAJOR(inode->i_sb->s_dev),
 					 MINOR(inode->i_sb->s_dev),
 					 inode->i_ino);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18e6d4c4667ff14dc035f2eacff1d6..cfd143b41eb1fb53868f378d668905c1c7d5f868 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -601,9 +601,9 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	struct inode * inode = d_inode(dentry);
 	dev_t ex_dev = exp_sb(exp)->s_dev;
 
-	dprintk("nfsd: fh_compose(exp %02x:%02x/%ld %pd2, ino=%ld)\n",
+	dprintk("nfsd: fh_compose(exp %02x:%02x/%lld %pd2, ino=%lld)\n",
 		MAJOR(ex_dev), MINOR(ex_dev),
-		(long) d_inode(exp->ex_path.dentry)->i_ino,
+		(long long) d_inode(exp->ex_path.dentry)->i_ino,
 		dentry,
 		(inode ? inode->i_ino : 0));
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c884c3f34afb044ee5cacc962a04a97de2f7fd88..dde09f3734c2844a3fe0b6d18d596276a19aa2d1 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1163,7 +1163,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	} else if (unlikely(host_err == -EINVAL)) {
 		struct inode *inode = d_inode(fhp->fh_dentry);
 
-		pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
+		pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%lld\n",
 				    inode->i_sb->s_id, inode->i_ino);
 		host_err = -ESERVERFAULT;
 	}

-- 
2.53.0


