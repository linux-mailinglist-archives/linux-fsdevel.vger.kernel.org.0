Return-Path: <linux-fsdevel+bounces-78563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF6JAsZ4oGmzkAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:45:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B551AAF99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 448823204AB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101474921B7;
	Thu, 26 Feb 2026 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyTB+PgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127943DA2B;
	Thu, 26 Feb 2026 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121867; cv=none; b=HwoC0RAM5AqO79MA8z4RbQY8oq7EInCjbWF6a12dV28+Dw1QqHObSIiWuC08s6Q42F7q5TKu3Q0YmT6y0N8qgZILF45j86gTQPnQ2/orj1YW0VnisCdCUHk8YgPlZ0I18PR19hu3XZqTCCv+OJeJmr0UXoBlN4WO1+sQBcQ/Vso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121867; c=relaxed/simple;
	bh=3gdRZB/bYaBq74nWKzTYBoxrmHjdrwN42kbAbXUAO1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrFrnWk0Tzevsz38AQMMKqqN59Msq1A+ZtwFMC87c/fgLYqLQmnCqL7GCx0nlwssPwBvQ+0eBzx0fI586J+CfBtD8FONMv30XIMxp1CuXcZ4zLLmrkvU0iOXaxJrVgJchRatBp6hYVPKCzFmtB5xHzQ37H61cOjk5YMMOj+pGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyTB+PgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6882DC2BCAF;
	Thu, 26 Feb 2026 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121866;
	bh=3gdRZB/bYaBq74nWKzTYBoxrmHjdrwN42kbAbXUAO1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iyTB+PgO5AoaN163AMcsotNvfXJuGhxw2cTMRntNhnt93ETFlbFc3PJnpiI4fcftF
	 QiMVFgL34YT6vMFgDtQ5pp5x3zuFr7xw0xcXxbRPnceBpAmIbSde2MA7Ix6CNLBDxl
	 xfDZdS64xn0x9jcrNDACgBBE+i3GvTW9KLEj9uurSWnH73nLcrxN8bG6K5ps0BlP32
	 hUml2ssxE5ImMag/sNw4Z4Jie9WtMK3TrTfo6An52tCSB6I9GtNO5Z/v0qm5YwD62X
	 TS/Bdak2CFmyn+OOPuqLm9D7AEx9dV0w+c8kCdRe47Z2CmYrXj8sh2cVuUvN7Bp7xX
	 BU59DAM8w9/Jw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:41 -0500
Subject: [PATCH 39/61] minix: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-39-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3gdRZB/bYaBq74nWKzTYBoxrmHjdrwN42kbAbXUAO1A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0OE+//p6uwDvrj0gzItm2YGfi4UxMBXmZ0C
 pGiklI3Fg+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtDgAKCRAADmhBGVaC
 FUouD/sF3zA4f3V+06shKK08E+NRNBErpZlePyQWQ2KtTi3YsBwsRapqP1ljo0hPlbf8XOgRPSs
 KWWT43ftfSdav6Mz/lDNUTR2mwgsVazb/FkQWmKzAsc+m+AEVdgUxr7vz27HuQIOpJJwlWbukWk
 HRth2j8IvUo6uiuOBoSZ0oFjPlQWjLQVmvlcfUzpkL7J1Mn2eB7xqhizUoWCSU6+fo8p1gDsDCG
 pLDwiJY669EWlSIP0aMdDDy8ImoK3ngSmxikBLziQ9afCInCr5KeuNfwtDhBUbDAR8NvQEQazk4
 yAbSr5uuOVhe8S6Q8Sf8D9R1KPRHrbd9dVt8uMEsdFtRxI+wDD0n9MWOnZgO/gnqicYyjvizxqs
 SspzvjH+moxKJ0E0NmHt4nSTyNejtNtF+pbXBRcrFN+Jz0K9WQoPqJdcG63LGYRb7KAEmp/8ALM
 50GCfPjpme+Qttn6Pr394fSBJbTVSTqAGIYiscVUGCZJjPQo/XUm7w/9IDIDxAGqKaYq8Qlsqqu
 2YL8VDMlffOar9Mpq0vZub6t+CMlZRCiPGySod1JkezjvHtPl0lriqGHrl+NkvGotWcZ1bI5rlt
 d3UlVgZH5x5bgNfmNJzxgO2vj1etSDC5g62YDX6JkogU++t2RQ8NF31NUf1aLbftqdLoCm3RHz7
 V+TirKKj2qfXDeQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78563-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5B551AAF99
X-Rspamd-Action: no action

Update format strings and local variable types in minix for the
i_ino type change from unsigned long to u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/minix/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 99541c6a5bbf13f3be27474a316b31d8db9fbce0..838b072b6cf0b54c955320916ac996e72f994a14 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -36,7 +36,7 @@ void __minix_error_inode(struct inode *inode, const char *function,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	printk(KERN_CRIT "minix-fs error (device %s): %s:%d: "
-	       "inode #%lu: comm %s: %pV\n",
+	       "inode #%llu: comm %s: %pV\n",
 	       inode->i_sb->s_id, function, line, inode->i_ino,
 	       current->comm, &vaf);
 	va_end(args);
@@ -520,7 +520,7 @@ void minix_set_inode(struct inode *inode, dev_t rdev)
 		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		init_special_inode(inode, inode->i_mode, rdev);
 	} else {
-		printk(KERN_DEBUG "MINIX-fs: Invalid file type 0%04o for inode %lu.\n",
+		printk(KERN_DEBUG "MINIX-fs: Invalid file type 0%04o for inode %llu.\n",
 		       inode->i_mode, inode->i_ino);
 		make_bad_inode(inode);
 	}
@@ -542,7 +542,7 @@ static struct inode *V1_minix_iget(struct inode *inode)
 		return ERR_PTR(-EIO);
 	}
 	if (raw_inode->i_nlinks == 0) {
-		printk("MINIX-fs: deleted inode referenced: %lu\n",
+		printk("MINIX-fs: deleted inode referenced: %llu\n",
 		       inode->i_ino);
 		brelse(bh);
 		iget_failed(inode);
@@ -580,7 +580,7 @@ static struct inode *V2_minix_iget(struct inode *inode)
 		return ERR_PTR(-EIO);
 	}
 	if (raw_inode->i_nlinks == 0) {
-		printk("MINIX-fs: deleted inode referenced: %lu\n",
+		printk("MINIX-fs: deleted inode referenced: %llu\n",
 		       inode->i_ino);
 		brelse(bh);
 		iget_failed(inode);
@@ -692,7 +692,7 @@ static int minix_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (wbc->sync_mode == WB_SYNC_ALL && buffer_dirty(bh)) {
 		sync_dirty_buffer(bh);
 		if (buffer_req(bh) && !buffer_uptodate(bh)) {
-			printk("IO error syncing minix inode [%s:%08lx]\n",
+			printk("IO error syncing minix inode [%s:%08llx]\n",
 				inode->i_sb->s_id, inode->i_ino);
 			err = -EIO;
 		}

-- 
2.53.0


