Return-Path: <linux-fsdevel+bounces-78553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFWILyJ7oGkakQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:56:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CC61AB61B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1739A30D37DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720B3480323;
	Thu, 26 Feb 2026 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIeKZc37"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928B47ECE7;
	Thu, 26 Feb 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121742; cv=none; b=fDL2tTsnqajEBuqAM85Hpc8JT0pNjFm8GBOeby62S1DnPfpsi5J/48sbTBYaKiGnOxcvdOwNRREPRonRgFF6XND/xehK6mgRlI3X8VVYm1EaMxgR3A2/xH6zOr4UtFkAArBSrCs8ckO9kZXqDKfsPG+KJUBdwHpYRJyyh7scYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121742; c=relaxed/simple;
	bh=r4NQTMCAdJdTju60BKkzI9ZgcdPji05KczFBMoCN7/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4tRBw9r74UiFXoNMKHz2E7GQwmBSOkBpfT5uQ8x8JVEEb/u2TNaIXxGV3gGIBU9CAGQZ867sPbk1Fw9+JEpWLdUFJ/sOAQzYosQhFaxVMqZ02hTFGwrW/eD/G+Yz1X6CgyyLirgCV0D4bieyWWQDLHV8cwIm5z1tYy9zQVv2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIeKZc37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BA9C2BCB0;
	Thu, 26 Feb 2026 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121741;
	bh=r4NQTMCAdJdTju60BKkzI9ZgcdPji05KczFBMoCN7/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IIeKZc37Ng9MR9i0PG4PHPUvKUs8x/8M97lxx3hpHB6pv6XDnOisZ0nNCgz+ACp6X
	 bBneW9dqcyJmA8N+DzE/wME74yqR5PkAwepfFzbD+XqLAyHNdiia5tZqfdlvjRAwQ1
	 smLKQTnhuV1zmjp3kBX25ZNfa30WPnU/cl80mUs6X+8RJeVBFThXa5OX7cB405ODBB
	 020q3Aryu5IZs4v+b7uNLOH7f+2zOdchH0stYwjryyY512Vr5vj5LljegQZ30ee8C8
	 8dLkD6MWawf6hLtiijiZyqrNKFzSJSQZpHDIcfpMuYNMjJmubAY7lULJU7bbCo9sY9
	 dxMpjBOROvlcQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:31 -0500
Subject: [PATCH 29/61] efs: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-29-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=r4NQTMCAdJdTju60BKkzI9ZgcdPji05KczFBMoCN7/E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0L8HIg1mrked5hBecpnNFa4Zl5RR0TOro28
 77DuvubI2yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtCwAKCRAADmhBGVaC
 FXCEEACs4uqez2OwdNTA8bdFfOCIcaeA9+QQy5AhCZlueauFg4niQjP5FJUQqWj4EBcdYUUgDSD
 9O0MfFdiD55b9s2B2y1C0WprMQ1LAVc3V+c8BGmy0H7ReRxXViINdENWWjrUcGerbCPglhUulBA
 CiwgQKfHNJ6ojEwzWX1KE3GHnhl1ocMC430TV0xpEa0USKFXzhqLcTdHzWdC1sKgtcZhTGjCzyd
 eX0cEv+Vx0LBY81mvN7XaYLRyCcRR6yRMH42/2Q7hS8hWQO3IAvzL1sBV2mnnSmH6TYdvS25kdA
 x2EeCUoLJggmEGF/Q5KZf55MTXLOqgCkS1OiP9zYAkBH6EzgOSnv9X8JCRs62gtX7WNhd/nxJKl
 IKFFe4x+mQ7xnWu9W4IXNyWKrIIQ23TlzZtv361xWzq/2GmHoUNPyxhRPNyg28Z0UB8OO/mtKBd
 o2rv4l7wtdRyby/QV+6G5SC0Ob/19MX77a+4FPGMH8PmkZ2qcwn7t6MouQvthGV+kXJ01bi9ttC
 /5wgOjnQ8vZM1dZzyGhI6phRI8+/jLlJTFXmqLX+ZCfR/ke3hjxf7HmgZ+NjOLyMguXbm6HpDnn
 3+aI5rjLOyX/Rgn+wHYy296J0xSZvRbHMi5b8Qf/GGMH3A85276g/4QHvszZ+XFQyLR6LUgUPSx
 XQpdfsjLgWPecOg==
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
	TAGGED_FROM(0.00)[bounces-78553-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 20CC61AB61B
X-Rspamd-Action: no action

Update format strings and local variable types in efs for the
i_ino type change from unsigned long to u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/efs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 28407578f83ad5db1b8a7b082fa3e990b6b442ec..4b132729e6385de196e156400d17a86ed04dc2f4 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -132,7 +132,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	for(i = 0; i < EFS_DIRECTEXTENTS; i++) {
 		extent_copy(&(efs_inode->di_u.di_extents[i]), &(in->extents[i]));
 		if (i < in->numextents && in->extents[i].cooked.ex_magic != 0) {
-			pr_warn("extent %d has bad magic number in inode %lu\n",
+			pr_warn("extent %d has bad magic number in inode %llu\n",
 				i, inode->i_ino);
 			brelse(bh);
 			goto read_inode_error;
@@ -140,7 +140,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	}
 
 	brelse(bh);
-	pr_debug("efs_iget(): inode %lu, extents %d, mode %o\n",
+	pr_debug("efs_iget(): inode %llu, extents %d, mode %o\n",
 		 inode->i_ino, in->numextents, inode->i_mode);
 	switch (inode->i_mode & S_IFMT) {
 		case S_IFDIR: 
@@ -171,7 +171,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	return inode;
         
 read_inode_error:
-	pr_warn("failed to read inode %lu\n", inode->i_ino);
+	pr_warn("failed to read inode %llu\n", inode->i_ino);
 	iget_failed(inode);
 	return ERR_PTR(-EIO);
 }

-- 
2.53.0


