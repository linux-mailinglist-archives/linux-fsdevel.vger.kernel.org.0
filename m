Return-Path: <linux-fsdevel+bounces-78544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH0vGnZzoGlZjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:23:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFFA1AA288
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71F9E3054D24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35F44611D4;
	Thu, 26 Feb 2026 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYTbh8az"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3F4657CC;
	Thu, 26 Feb 2026 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121629; cv=none; b=UEa82r9yAJntv893m5199/8YOYGbg7KgQ+6WogXodFFWmeTtsB68jJk/VUGXWyJO7VBdWgX0Q/Gt5XaaWflYikjUqmUdR4s80P1XoWk3geZIsM3Km6og9Lre8/uuKkAiXG84iID0f494qlaqkw/B50ynV/RtCOqsnCkyRk4G644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121629; c=relaxed/simple;
	bh=T4XOURJp5h6a0W+w6Slhd7r2zVOXmWLyb5oaovUOm6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=II+XvuXkQxRaoWugHpkmQdCQOYWW9BsBeZQs3zytIGfJ4FUFXRBDNdWkp78pHqW5cA4+wuNoNGgRXyGM0NfpE4fich84neZZq8SLcradoyHqsuO1X7oZiiQ9UCseJDRxqDrfRGoVCIaYplY+DwSSyKzJzut773wUJkMAzt8AhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYTbh8az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6ADC2BCB6;
	Thu, 26 Feb 2026 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121628;
	bh=T4XOURJp5h6a0W+w6Slhd7r2zVOXmWLyb5oaovUOm6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HYTbh8az9ttre2WoQ3PB5MGwQxAiiploAPcWAy93PIxVejigQcZDcMkTnfaGW8HgR
	 lTA7Pb1/NOMO83NTvalDUDSElKXMxtvLDHgmXRvT8DZq7TWtAODghENsLgepuGwCdh
	 Pb7MLLg/AFm5mEmSnA0W6cOba53KeeKBRJuWMNOtIkBDyNvU/lFp/7OHDCTFTd8izc
	 YzzeIR3xEvFuqHTvzU5WZ6akTwHBiLw/lG0kXIYOcle1pKp6l2vHhl3PhbFk1DlxXI
	 siJmnZMwWR2mTtQTkRDpA9w8jfwFg86GAPmVFa0vrH2ByNRt7nUjALiU7hMNSkimpP
	 r7/FNozXlhnEg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:22 -0500
Subject: [PATCH 20/61] afs: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-20-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3827; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=T4XOURJp5h6a0W+w6Slhd7r2zVOXmWLyb5oaovUOm6s=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0Jd3rTJKBznl41a30r5qtD/z0aeq/r47sgP
 CVEl5KncpyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtCQAKCRAADmhBGVaC
 FfTFD/91T+jSkWFt3wxt6E+853oG/5gpw6xS6mUwZV8IgcoYswcYSqbkTpqsCPaikzV0xFXpX+p
 92d/7BN9iTdm3au3BsH44pHnkX7XObNAg9sdTQP52K6DjP4Ufwz7XbXpPc0tQ2fThZjUWNGiOJ6
 bme3H1hM/w0HUxB2616Sz0uqNvSQGjvaUnUv72hTiXrsEkZ4m3tYZDBBP/Uiq9vEV4vgQn99aMC
 JrQDxxuyEz5xnv9psyVOfUi7H8UCZmc0rqJDf7njZ/Qf9W1K1iSTJiCAmz8prECctblCpvbBewD
 ue7i7WUwkbgbb8INumtZy3sWluypc5dMkD1zRITFM7W4trbEHZx2P3g2pJbplJ4SlgpS0ahhVsk
 Shfnhfm7R3smVsVJBsM9s3OmcMuTO8LFbLFyVK6q/6RO5qnx45HwHHsP4oLAs79iBQLqFt93DOa
 iO3Z6XuLlcEM7M2hi90gY2GAKLbiLs6G/QWEpfFC+IVSoCJqXFcBv8vbp5JGPSPrlubPwc1myaF
 TS5RtvR/iXMmTfsM7ypKOkxmThIMIFh/phF4TckHqHH7B8FfxJC+36v9VFeimnBDc92ZfkCM1Ae
 R070EpuJNv/2J3/k9D2zcnmnuhcgE5roc4eEEVayPUeRtrDZkWkX6QNUOAsKz2oJ97LwFSIPkWZ
 xjAju7Q478qpNxQ==
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
	TAGGED_FROM(0.00)[bounces-78544-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFFFA1AA288
X-Rspamd-Action: no action

Update format strings and local variable types in afs for the
i_ino type change from unsigned long to u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/afs/dir.c        | 10 +++++-----
 fs/afs/dir_search.c |  2 +-
 fs/afs/dynroot.c    |  2 +-
 fs/afs/inode.c      |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78caef3f13388c5f604e4970bc0874de168b57f3..aaaa55878ffd28691777668261f577d7a9472d6d 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -148,7 +148,7 @@ static bool afs_dir_check_block(struct afs_vnode *dvnode, size_t progress,
 				union afs_xdr_dir_block *block)
 {
 	if (block->hdr.magic != AFS_DIR_MAGIC) {
-		pr_warn("%s(%lx): [%zx] bad magic %04x\n",
+		pr_warn("%s(%llx): [%zx] bad magic %04x\n",
 		       __func__, dvnode->netfs.inode.i_ino,
 		       progress, ntohs(block->hdr.magic));
 		trace_afs_dir_check_failed(dvnode, progress);
@@ -214,7 +214,7 @@ static int afs_dir_check(struct afs_vnode *dvnode)
  */
 static int afs_dir_open(struct inode *inode, struct file *file)
 {
-	_enter("{%lu}", inode->i_ino);
+	_enter("{%llu}", inode->i_ino);
 
 	BUILD_BUG_ON(sizeof(union afs_xdr_dir_block) != 2048);
 	BUILD_BUG_ON(sizeof(union afs_xdr_dirent) != 32);
@@ -523,7 +523,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 	int retry_limit = 100;
 	int ret;
 
-	_enter("{%lu},%llx,,", dir->i_ino, ctx->pos);
+	_enter("{%llu},%llx,,", dir->i_ino, ctx->pos);
 
 	do {
 		if (--retry_limit < 0) {
@@ -610,7 +610,7 @@ static int afs_do_lookup_one(struct inode *dir, const struct qstr *name,
 	};
 	int ret;
 
-	_enter("{%lu},{%.*s},", dir->i_ino, name->len, name->name);
+	_enter("{%llu},{%.*s},", dir->i_ino, name->len, name->name);
 
 	/* search the directory */
 	ret = afs_dir_iterate(dir, &cookie.ctx, NULL, _dir_version);
@@ -783,7 +783,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 	long ret;
 	int i;
 
-	_enter("{%lu},%p{%pd},", dir->i_ino, dentry, dentry);
+	_enter("{%llu},%p{%pd},", dir->i_ino, dentry, dentry);
 
 	cookie = kzalloc_obj(struct afs_lookup_cookie);
 	if (!cookie)
diff --git a/fs/afs/dir_search.c b/fs/afs/dir_search.c
index d2516e55b5edb273677c9cedb6f15524bc56348d..104411c0692f570a217d8f0e6fd35818eaa02932 100644
--- a/fs/afs/dir_search.c
+++ b/fs/afs/dir_search.c
@@ -194,7 +194,7 @@ int afs_dir_search(struct afs_vnode *dvnode, const struct qstr *name,
 	struct afs_dir_iter iter = { .dvnode = dvnode, };
 	int ret, retry_limit = 3;
 
-	_enter("{%lu},,,", dvnode->netfs.inode.i_ino);
+	_enter("{%llu},,,", dvnode->netfs.inode.i_ino);
 
 	if (!afs_dir_init_iter(&iter, name))
 		return -ENOENT;
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index aa56e8951e037b2e3fa9fc452b43e7bd2d61b926..1d5e33bc750224d063446ea952d5ef97a2481010 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -59,7 +59,7 @@ static struct inode *afs_iget_pseudo_dir(struct super_block *sb, ino_t ino)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	_debug("GOT INODE %p { ino=%lu, vl=%llx, vn=%llx, u=%x }",
+	_debug("GOT INODE %p { ino=%llu, vl=%llx, vn=%llx, u=%x }",
 	       inode, inode->i_ino, fid.vid, fid.vnode, fid.unique);
 
 	vnode = AFS_FS_I(inode);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index dde1857fcabb302cc6b06cc018fb1e4108ec6284..a5173434f7862e92a127994c56b89f530ad4c298 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -683,7 +683,7 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct key *key;
 	int ret, seq;
 
-	_enter("{ ino=%lu v=%u }", inode->i_ino, inode->i_generation);
+	_enter("{ ino=%llu v=%u }", inode->i_ino, inode->i_generation);
 
 	if (vnode->volume &&
 	    !(query_flags & AT_STATX_DONT_SYNC) &&

-- 
2.53.0


