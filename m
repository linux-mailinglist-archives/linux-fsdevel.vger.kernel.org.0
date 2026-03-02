Return-Path: <linux-fsdevel+bounces-78980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C77fEYf1pWmkIQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:39:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF8A1E0122
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ACD8303365F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEF64BCAA4;
	Mon,  2 Mar 2026 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBMBqtar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A47423A6B;
	Mon,  2 Mar 2026 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483359; cv=none; b=FNAcqSkoP3VL4vfx/+6Ff/kF5S8UnM7rZz14lUvpGPnywBSPOSL5p8Q1mCEt259WoT6y0GCIUZ97oNaLYJ5EVL8F12pje96PqKknPYUSHfcLrU0TOMe+hNEgFS9JtoWK6RaVvOD18R0pr68XHYPdjRgH678WZC7eeFQRuiTHYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483359; c=relaxed/simple;
	bh=eZCt7O/cBHS6+jaXbF0bDvdTJVnhNrKq3wa2lAjd6r8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eHsTdnGzqXUABadgkBfHL516DfAwYe35ZNe0K6NtvcRff96dSoNPYbg/KG0OptplqWpVgq5qpX13svI/spUW5XHlleI0PvWcSnANy5LnMcyO2cuVceSrIqltEbzzOSY78KCmXPWHELbz9hC3Rb+hYVT/Se8sAIQMh5RNo7uoIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBMBqtar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4398CC19425;
	Mon,  2 Mar 2026 20:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483359;
	bh=eZCt7O/cBHS6+jaXbF0bDvdTJVnhNrKq3wa2lAjd6r8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fBMBqtart3aD0C9RzMfCHTMFx3kcpZai+WoV3/wlDdnhCRn576Oi01in8ttP89rrE
	 1jbLEXnH+DHrEGsYmqJiPrBONqu8+W536+wcd7gPdwUXljUJbhXOcQjv3U58cWs1Bw
	 yvA04Z5/1tYmvhR6EIwuN4x6yE4TQ3vij1yl36SwVS+9uAikR3ofEAIaHwhf28yVQI
	 nnWs1kCVddFM1M6h5PvLxCCq1vG4N3N0eg9OcH++fLDnbg2+WgxiVb6DgHnL1XIpBG
	 kmEmtZg4iFg5s/AtPz7mqssjfeXGuS5qEvVqKxEZGY+sy05o1BzDpXrkCWS3pnQ490
	 lHm6Qt5QdCPrA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:24:02 -0500
Subject: [PATCH v2 018/110] afs: use PRIino format for i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-18-e5388800dae0@kernel.org>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
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
 Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, 
 Joerg Reuter <jreuter@yaina.de>, Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
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
 linux-x25@vger.kernel.org, audit@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3901; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eZCt7O/cBHS6+jaXbF0bDvdTJVnhNrKq3wa2lAjd6r8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfH0RWX8wpryRk/QgAbjn1Q1ANZbw4V+PFw8A
 vATQsWHGvyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXx9AAKCRAADmhBGVaC
 FQaAD/9DyJTyKKu/cuTCajh+8TP5xfDXlFmrEcCNSHdEiwWEokDdm2i1zkGOG7X37vO2jK00FQo
 WjBIS9/SahFHFKYltsILzhUTsyqG2dGgqlMHmmvEsPlH3sY4ceSTCVxr7QPAAXw4qs0Ubk5uk6v
 66Ta9GmMoq1EVnQdLiocwj8ezT1Tip7XxRvuesh0eaZ4t7PYnVShZvOq/8pxR5lBdi2x4UawIyY
 Da9WRPW2K3CENHKIL0mMv6M8duTJvIpXQM+1jTZ/GxO2pPtbYoVrDsdcZbOufwZv+2khcznhGTr
 asoLO2U26rig19ah9eoWCs8/wlRtvU+8z6/OlVXeeF9rGXbbLuE4iSPpUqP7jxBQfwMuHj5ZCX4
 EOxwz8pdqTN+NW6Z5baBdvt2ZlIAiut/DYl1I+MiPUYp/UJ2QqGbCm1lZoP/SYCEtNaAzTbIKAJ
 u11RPrKEnI/046wbiTYxb3VWrNRz9oxghsSipLPEgFccdFxmdm61J1ol2HcWaSxC6rrtcP7Bevq
 KGc12QzSt8zNfENsH+pM2JNf7XxMK5LTyXT3D4pnmbZsw+aKFwf3r2GmTAt+nCEuWwd050ur19+
 4lYSgVxjvBOPBGW+PkSFoOwP1q2Ro8/isBujNxmKasNg0fsW9KA5a9E/0PjiIrziosap53nhDmG
 NQgJaccyKt30Rqw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 7AF8A1E0122
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78980-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Convert afs i_ino format strings to use the PRIino format
macro in preparation for the widening of i_ino via kino_t.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/afs/dir.c        | 10 +++++-----
 fs/afs/dir_search.c |  2 +-
 fs/afs/dynroot.c    |  2 +-
 fs/afs/inode.c      |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78caef3f13388c5f604e4970bc0874de168b57f3..52accf0a8d9d2e4dfdff444080683d5ab16d8e69 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -148,7 +148,7 @@ static bool afs_dir_check_block(struct afs_vnode *dvnode, size_t progress,
 				union afs_xdr_dir_block *block)
 {
 	if (block->hdr.magic != AFS_DIR_MAGIC) {
-		pr_warn("%s(%lx): [%zx] bad magic %04x\n",
+		pr_warn("%s(%" PRIino "x): [%zx] bad magic %04x\n",
 		       __func__, dvnode->netfs.inode.i_ino,
 		       progress, ntohs(block->hdr.magic));
 		trace_afs_dir_check_failed(dvnode, progress);
@@ -214,7 +214,7 @@ static int afs_dir_check(struct afs_vnode *dvnode)
  */
 static int afs_dir_open(struct inode *inode, struct file *file)
 {
-	_enter("{%lu}", inode->i_ino);
+	_enter("{%" PRIino "u}", inode->i_ino);
 
 	BUILD_BUG_ON(sizeof(union afs_xdr_dir_block) != 2048);
 	BUILD_BUG_ON(sizeof(union afs_xdr_dirent) != 32);
@@ -523,7 +523,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 	int retry_limit = 100;
 	int ret;
 
-	_enter("{%lu},%llx,,", dir->i_ino, ctx->pos);
+	_enter("{%" PRIino "u},%llx,,", dir->i_ino, ctx->pos);
 
 	do {
 		if (--retry_limit < 0) {
@@ -610,7 +610,7 @@ static int afs_do_lookup_one(struct inode *dir, const struct qstr *name,
 	};
 	int ret;
 
-	_enter("{%lu},{%.*s},", dir->i_ino, name->len, name->name);
+	_enter("{%" PRIino "u},{%.*s},", dir->i_ino, name->len, name->name);
 
 	/* search the directory */
 	ret = afs_dir_iterate(dir, &cookie.ctx, NULL, _dir_version);
@@ -783,7 +783,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 	long ret;
 	int i;
 
-	_enter("{%lu},%p{%pd},", dir->i_ino, dentry, dentry);
+	_enter("{%" PRIino "u},%p{%pd},", dir->i_ino, dentry, dentry);
 
 	cookie = kzalloc_obj(struct afs_lookup_cookie);
 	if (!cookie)
diff --git a/fs/afs/dir_search.c b/fs/afs/dir_search.c
index d2516e55b5edb273677c9cedb6f15524bc56348d..903cefd81f3f2ccbdb28264b5e99151f5a54d1ce 100644
--- a/fs/afs/dir_search.c
+++ b/fs/afs/dir_search.c
@@ -194,7 +194,7 @@ int afs_dir_search(struct afs_vnode *dvnode, const struct qstr *name,
 	struct afs_dir_iter iter = { .dvnode = dvnode, };
 	int ret, retry_limit = 3;
 
-	_enter("{%lu},,,", dvnode->netfs.inode.i_ino);
+	_enter("{%" PRIino "u},,,", dvnode->netfs.inode.i_ino);
 
 	if (!afs_dir_init_iter(&iter, name))
 		return -ENOENT;
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index aa56e8951e037b2e3fa9fc452b43e7bd2d61b926..448083d79c3d0d2f29934e105f48d617330de8b4 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -59,7 +59,7 @@ static struct inode *afs_iget_pseudo_dir(struct super_block *sb, ino_t ino)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	_debug("GOT INODE %p { ino=%lu, vl=%llx, vn=%llx, u=%x }",
+	_debug("GOT INODE %p { ino=%" PRIino "u, vl=%llx, vn=%llx, u=%x }",
 	       inode, inode->i_ino, fid.vid, fid.vnode, fid.unique);
 
 	vnode = AFS_FS_I(inode);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index dde1857fcabb302cc6b06cc018fb1e4108ec6284..a0261c2c246a379689cbaa44b7ec456f1a986142 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -683,7 +683,7 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct key *key;
 	int ret, seq;
 
-	_enter("{ ino=%lu v=%u }", inode->i_ino, inode->i_generation);
+	_enter("{ ino=%" PRIino "u v=%u }", inode->i_ino, inode->i_generation);
 
 	if (vnode->volume &&
 	    !(query_flags & AT_STATX_DONT_SYNC) &&

-- 
2.53.0


