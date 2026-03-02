Return-Path: <linux-fsdevel+bounces-78968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGqnK+T4pWlGIgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:53:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B97381E10CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 777D831A1E76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDFC481667;
	Mon,  2 Mar 2026 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHRCSLbm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0347F2F7;
	Mon,  2 Mar 2026 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483201; cv=none; b=h4+tH50XMuBv+A6LxPbWJysqur698xYyGvPFBXzMj9l46XkqRGlVoItdTIND+/exH4O5QaCD6XBZ83FXAY9MIagnAwTXvPInZEoJlghzArQ2gHKukhkF8LCJ58Z0G6g1GthYJZcVoDqN/OI2jdAETRFwcJ0oJGWljkMC/Wvp/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483201; c=relaxed/simple;
	bh=4iiVFn4d/3+J9CYZ7cMd/iIzCbmkrAgoQsKJr+eskdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IRx/sYBmDZb7BtsMF5VR+Bf/5MJMgBR2sziWKQEfAVfYyw6Kwp0Uh0tS0qk5Nvt5hvBces4quknQ7eRh2cw0MZgxj0OJFXXJm1TSeJvW0TEe4P1S4gAhlfLh9w9Y9H3NvDQi7gjJNd/oTVxmBdHip27rpuVURkbQjj9k+ujfr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHRCSLbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40510C19423;
	Mon,  2 Mar 2026 20:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483201;
	bh=4iiVFn4d/3+J9CYZ7cMd/iIzCbmkrAgoQsKJr+eskdU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tHRCSLbm1sW9Rpfj3EbefugTWfTlzZDsPNBOWWpC3Oa532uR7PjpEiIlu9EpwnRU7
	 PVrU3lj+Y67sBI+NxxHaHWq8rIhouvu0Uy4R+2KtaNwRBZHPnRJhZQ57VRFR8VO9WK
	 LaTMBoOp4YY0HkDwyCSLELu9HB6FE1bB3b2fD3sq8rRTV2jkLNZLYvuzpbhN3hQ5b2
	 c+MU2oL/jtC68HOF5JGfUY68PRs1czrLbkIa88aA++vK92z2VNRCrjA/OcSByXVVrP
	 OBLHe66VmdP6/szUvSlRw4IqnKmHryh2oFh7pFz9U4sZ6EHtcgGDklmxiP8gBULfE6
	 bmpLb/blUyKBg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:23:51 -0500
Subject: [PATCH v2 007/110] ext4: use PRIino format for i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-7-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=89894; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4iiVFn4d/3+J9CYZ7cMd/iIzCbmkrAgoQsKJr+eskdU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfHxi1N5KOGgRSFtTMI9ADiILBN9P+jJkQ4yv
 dEHVxWjFcGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXx8QAKCRAADmhBGVaC
 FSxmEACap7v1a9l1WxvQi+bo2AiUFGkHoBMyzHwisDbtX9SMh2iOtYZQAF5SMMntVKGIEBdKuF7
 EEZuNlAqyanRuVrYwAAHiSj/w+1b1CM74oTV7StaEF+oHr+iPloxa/mxDC/O73is6k3PIePrXi7
 +cQcTCwLdhjxCvp0CPLcd5Y4wvWYu4ui1NihqR2/IbYuVLZHvkg6xDWHj0OmPc7QDgu5IURMBEJ
 d28XeLkwmwpayjm5qmVTb0s8VvK0JfRiO8pdXi+YYsWmUJamDXrl8IV1B7nQ0gn1AtaBd/pWy6W
 J7AIdLH27iX+PBeo2qmS0Y0bHf7JXSxogj1c6xPUeUlMErRTNIY7P3uW+yIEuo8PVyJUa2EAQMi
 FAMoNA8V8E2+GQ4+RTCJJFsibPGNIA4Gbvx+GUFyTv/YdXRS5XvRUVOE0Uc7lY19CZB8BXTUDXo
 F/U6ibtmaA7pbcxDZBFC5i1GJJoykATCCQ7augfUWQI8F6zIShwCO3xpm75WMZDvbnr7j8VaZxm
 lOkvn2mqG0dYlJzF8jd9qzsjjvZUVxiamaNNkSr58uJPDaIZvXqkaQZa8/YBImxKcEsVG9iq0Ds
 po4QuwppZ5Kz6zm+7Rna/MOOPSJ0cHqLeD96CS4Z5jB2gQ2z0mYVgm4ghGbkgFG3n7gmkw4dw8L
 sk3WiCuLPxmliWw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: B97381E10CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78968-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Convert ext4 i_ino format strings to use the PRIino format
macro in preparation for the widening of i_ino via kino_t.

In trace events, change __field(ino_t, ...) to __field(u64, ...)
and update TP_printk format strings to %llu/%llx to match the
widened field type.

Update local variables and function parameters that hold i_ino
values from unsigned long to kino_t.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/dir.c               |   2 +-
 fs/ext4/ext4.h              |   4 +-
 fs/ext4/extents.c           |   8 +-
 fs/ext4/extents_status.c    |  28 +--
 fs/ext4/fast_commit.c       |   8 +-
 fs/ext4/ialloc.c            |  10 +-
 fs/ext4/indirect.c          |   2 +-
 fs/ext4/inline.c            |  14 +-
 fs/ext4/inode.c             |  22 +--
 fs/ext4/ioctl.c             |   4 +-
 fs/ext4/mballoc.c           |   6 +-
 fs/ext4/migrate.c           |   2 +-
 fs/ext4/move_extent.c       |  20 +--
 fs/ext4/namei.c             |  10 +-
 fs/ext4/orphan.c            |  16 +-
 fs/ext4/page-io.c           |  10 +-
 fs/ext4/super.c             |  22 +--
 fs/ext4/xattr.c             |  10 +-
 include/trace/events/ext4.h | 423 ++++++++++++++++++++++----------------------
 19 files changed, 311 insertions(+), 310 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 28b2a3deb954fe275cd2f7290f2daeafa2d3dbed..785d482b0ff01686ed420508e826eb8d2745aa92 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -535,7 +535,7 @@ static int call_filldir(struct file *file, struct dir_context *ctx,
 	struct super_block *sb = inode->i_sb;
 
 	if (!fname) {
-		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: comm %s: "
+		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%" PRIino "u: comm %s: "
 			 "called with null fname?!?", __func__, __LINE__,
 			 inode->i_ino, current->comm);
 		return 0;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 293f698b7042438b2757790717db22bca060797d..d2bf5f7db5524c50626833a82987f89965ab7f67 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -92,7 +92,7 @@
  */
 #ifdef CONFIG_EXT4_DEBUG
 #define ext_debug(ino, fmt, ...)					\
-	pr_debug("[%s/%d] EXT4-fs (%s): ino %lu: (%s, %d): %s:" fmt,	\
+	pr_debug("[%s/%d] EXT4-fs (%s): ino %" PRIino "u: (%s, %d): %s:" fmt,	\
 		 current->comm, task_pid_nr(current),			\
 		 ino->i_sb->s_id, ino->i_ino, __FILE__, __LINE__,	\
 		 __func__, ##__VA_ARGS__)
@@ -3229,7 +3229,7 @@ extern void __dump_mmp_msg(struct super_block *, struct mmp_struct *mmp,
 extern __printf(7, 8)
 void __ext4_grp_locked_error(const char *, unsigned int,
 			     struct super_block *, ext4_group_t,
-			     unsigned long, ext4_fsblk_t,
+			     kino_t, ext4_fsblk_t,
 			     const char *, ...);
 
 #define EXT4_ERROR_INODE(inode, fmt, a...) \
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ae3804f36535aeca4009bfae992e1f2f665aded2..668bb30771fb4fb33e75971b4488359e636d7d1b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4603,7 +4603,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 		}
 		ret = ext4_map_blocks(handle, inode, &map, flags);
 		if (ret <= 0) {
-			ext4_debug("inode #%lu: block %u: len %u: "
+			ext4_debug("inode #%" PRIino "u: block %u: len %u: "
 				   "ext4_ext_map_blocks returned %d",
 				   inode->i_ino, map.m_lblk,
 				   map.m_len, ret);
@@ -4955,7 +4955,7 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
 		ret = ext4_map_blocks(handle, inode, &map, flags);
 		if (ret != max_blocks)
 			ext4_msg(inode->i_sb, KERN_INFO,
-				     "inode #%lu: block %u: len %u: "
+				     "inode #%" PRIino "u: block %u: len %u: "
 				     "split block mapping found for atomic write, "
 				     "ret = %d",
 				     inode->i_ino, map.m_lblk,
@@ -4974,7 +4974,7 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
 
 	if (ret <= 0 || ret2)
 		ext4_warning(inode->i_sb,
-			     "inode #%lu: block %u: len %u: "
+			     "inode #%" PRIino "u: block %u: len %u: "
 			     "returned %d or %d",
 			     inode->i_ino, map.m_lblk,
 			     map.m_len, ret, ret2);
@@ -5031,7 +5031,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 				      EXT4_EX_NOCACHE);
 		if (ret <= 0)
 			ext4_warning(inode->i_sb,
-				     "inode #%lu: block %u: len %u: "
+				     "inode #%" PRIino "u: block %u: len %u: "
 				     "ext4_ext_map_blocks returned %d",
 				     inode->i_ino, map.m_lblk,
 				     map.m_len, ret);
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index a1538bac51c61d81881be2e3fd67113f24c16df1..01ab48602798f0cdf6312e8bbe130dc319405bff 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -214,7 +214,7 @@ static void ext4_es_print_tree(struct inode *inode)
 	struct ext4_es_tree *tree;
 	struct rb_node *node;
 
-	printk(KERN_DEBUG "status extents for inode %lu:", inode->i_ino);
+	printk(KERN_DEBUG "status extents for inode %" PRIino "u:", inode->i_ino);
 	tree = &EXT4_I(inode)->i_es_tree;
 	node = rb_first(&tree->root);
 	while (node) {
@@ -703,7 +703,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
 		if (!ext4_es_is_written(es) && !ext4_es_is_unwritten(es)) {
 			if (in_range(es->es_lblk, ee_block, ee_len)) {
 				pr_warn("ES insert assertion failed for "
-					"inode: %lu we can find an extent "
+					"inode: %" PRIino "u we can find an extent "
 					"at block [%d/%d/%llu/%c], but we "
 					"want to add a delayed/hole extent "
 					"[%d/%d/%llu/%x]\n",
@@ -721,7 +721,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
 		 */
 		if (es->es_lblk < ee_block ||
 		    ext4_es_pblock(es) != ee_start + es->es_lblk - ee_block) {
-			pr_warn("ES insert assertion failed for inode: %lu "
+			pr_warn("ES insert assertion failed for inode: %" PRIino "u "
 				"ex_status [%d/%d/%llu/%c] != "
 				"es_status [%d/%d/%llu/%c]\n", inode->i_ino,
 				ee_block, ee_len, ee_start,
@@ -731,7 +731,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
 		}
 
 		if (ee_status ^ es_status) {
-			pr_warn("ES insert assertion failed for inode: %lu "
+			pr_warn("ES insert assertion failed for inode: %" PRIino "u "
 				"ex_status [%d/%d/%llu/%c] != "
 				"es_status [%d/%d/%llu/%c]\n", inode->i_ino,
 				ee_block, ee_len, ee_start,
@@ -744,7 +744,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
 		 * that we don't want to add an written/unwritten extent.
 		 */
 		if (!ext4_es_is_delayed(es) && !ext4_es_is_hole(es)) {
-			pr_warn("ES insert assertion failed for inode: %lu "
+			pr_warn("ES insert assertion failed for inode: %" PRIino "u "
 				"can't find an extent at block %d but we want "
 				"to add a written/unwritten extent "
 				"[%d/%d/%llu/%x]\n", inode->i_ino,
@@ -779,7 +779,7 @@ static void ext4_es_insert_extent_ind_check(struct inode *inode,
 			 * We want to add a delayed/hole extent but this
 			 * block has been allocated.
 			 */
-			pr_warn("ES insert assertion failed for inode: %lu "
+			pr_warn("ES insert assertion failed for inode: %" PRIino "u "
 				"We can find blocks but we want to add a "
 				"delayed/hole extent [%d/%d/%llu/%x]\n",
 				inode->i_ino, es->es_lblk, es->es_len,
@@ -788,13 +788,13 @@ static void ext4_es_insert_extent_ind_check(struct inode *inode,
 		} else if (ext4_es_is_written(es)) {
 			if (retval != es->es_len) {
 				pr_warn("ES insert assertion failed for "
-					"inode: %lu retval %d != es_len %d\n",
+					"inode: %" PRIino "u retval %d != es_len %d\n",
 					inode->i_ino, retval, es->es_len);
 				return;
 			}
 			if (map.m_pblk != ext4_es_pblock(es)) {
 				pr_warn("ES insert assertion failed for "
-					"inode: %lu m_pblk %llu != "
+					"inode: %" PRIino "u m_pblk %llu != "
 					"es_pblk %llu\n",
 					inode->i_ino, map.m_pblk,
 					ext4_es_pblock(es));
@@ -809,7 +809,7 @@ static void ext4_es_insert_extent_ind_check(struct inode *inode,
 		}
 	} else if (retval == 0) {
 		if (ext4_es_is_written(es)) {
-			pr_warn("ES insert assertion failed for inode: %lu "
+			pr_warn("ES insert assertion failed for inode: %" PRIino "u "
 				"We can't find the block but we want to add "
 				"a written extent [%d/%d/%llu/%x]\n",
 				inode->i_ino, es->es_lblk, es->es_len,
@@ -919,7 +919,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
-	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %lu\n",
+	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %" PRIino "u\n",
 		 lblk, len, pblk, status, delalloc_reserve_used, inode->i_ino);
 
 	if (!len)
@@ -1631,7 +1631,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
-	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
+	es_debug("remove [%u/%u) from extent status tree of inode %" PRIino "u\n",
 		 lblk, len, inode->i_ino);
 
 	if (!len)
@@ -1821,7 +1821,7 @@ int ext4_seq_es_shrinker_info_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "  %lu shrunk objects\n", es_stats->es_stats_shrunk);
 	if (inode_cnt)
 		seq_printf(seq,
-		    "maximum:\n  %lu inode (%u objects, %u reclaimable)\n"
+		    "maximum:\n  %" PRIino "u inode (%u objects, %u reclaimable)\n"
 		    "  %llu us max scan time\n",
 		    max->vfs_inode.i_ino, max->i_es_all_nr, max->i_es_shk_nr,
 		    div_u64(es_stats->es_stats_max_scan_time, 1000));
@@ -1998,7 +1998,7 @@ static void ext4_print_pending_tree(struct inode *inode)
 	struct rb_node *node;
 	struct pending_reservation *pr;
 
-	printk(KERN_DEBUG "pending reservations for inode %lu:", inode->i_ino);
+	printk(KERN_DEBUG "pending reservations for inode %" PRIino "u:", inode->i_ino);
 	tree = &EXT4_I(inode)->i_pending_tree;
 	node = rb_first(&tree->root);
 	while (node) {
@@ -2214,7 +2214,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
-	es_debug("add [%u/%u) delayed to extent status tree of inode %lu\n",
+	es_debug("add [%u/%u) delayed to extent status tree of inode %" PRIino "u\n",
 		 lblk, len, inode->i_ino);
 	if (!len)
 		return;
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f575751f1cae430eead31afa4f7d03ade1099d4a..8c6512d4ebcbd377186e4ce1ad5811b626d095db 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -616,7 +616,7 @@ static int __track_range(handle_t *handle, struct inode *inode, void *arg,
 		(struct __track_range_args *)arg;
 
 	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb)) {
-		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
+		ext4_debug("Special inode %" PRIino "u being modified\n", inode->i_ino);
 		return -ECANCELED;
 	}
 
@@ -914,7 +914,7 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	spin_unlock(&ei->i_fc_lock);
 
 	cur_lblk_off = old_blk_size;
-	ext4_debug("will try writing %d to %d for inode %ld\n",
+	ext4_debug("will try writing %d to %d for inode %" PRIino "u\n",
 		   cur_lblk_off, new_blk_size, inode->i_ino);
 
 	while (cur_lblk_off <= new_blk_size) {
@@ -1792,7 +1792,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 
 	cur = start;
 	remaining = len;
-	ext4_debug("ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %ld\n",
+	ext4_debug("ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %" PRIino "u\n",
 		  start, start_pblk, len, ext4_ext_is_unwritten(ex),
 		  inode->i_ino);
 
@@ -1903,7 +1903,7 @@ ext4_fc_replay_del_range(struct super_block *sb,
 	if (ret)
 		goto out;
 
-	ext4_debug("DEL_RANGE, inode %ld, lblk %d, len %d\n",
+	ext4_debug("DEL_RANGE, inode %" PRIino "u, lblk %d, len %d\n",
 			inode->i_ino, le32_to_cpu(lrange.fc_lblk),
 			le32_to_cpu(lrange.fc_len));
 	while (remaining > 0) {
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b20a1bf866abedf3a768ee8a147f108ea09ecb01..35899f04a995b2b8b0fad275ad1920467701f54b 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -253,13 +253,13 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 		return;
 	}
 	if (icount_read(inode) > 1) {
-		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: count=%d",
+		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%" PRIino "u: count=%d",
 			 __func__, __LINE__, inode->i_ino,
 			 icount_read(inode));
 		return;
 	}
 	if (inode->i_nlink) {
-		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: nlink=%d\n",
+		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%" PRIino "u: nlink=%d\n",
 			 __func__, __LINE__, inode->i_ino, inode->i_nlink);
 		return;
 	}
@@ -631,7 +631,7 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 	 *
 	 * So add our directory's i_ino into the starting point for the hash.
 	 */
-	*group = (*group + parent->i_ino) % ngroups;
+	*group = (*group + (unsigned int)parent->i_ino) % ngroups;
 
 	/*
 	 * Use a quadratic hash to find a group with a free inode and some free
@@ -1275,7 +1275,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		 * twice.
 		 */
 		err = -EIO;
-		ext4_error(sb, "failed to insert inode %lu: doubly allocated?",
+		ext4_error(sb, "failed to insert inode %" PRIino "u: doubly allocated?",
 			   inode->i_ino);
 		ext4_mark_group_bitmap_corrupted(sb, group,
 					EXT4_GROUP_INFO_IBITMAP_CORRUPT);
@@ -1344,7 +1344,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		goto fail_free_drop;
 	}
 
-	ext4_debug("allocating inode %lu\n", inode->i_ino);
+	ext4_debug("allocating inode %" PRIino "u\n", inode->i_ino);
 	trace_ext4_allocate_inode(inode, dir, mode);
 	brelse(inode_bitmap_bh);
 	return ret;
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index da76353b3a5750987d7b4803c388248b749a68a8..ba53698cef951676f409203fbf76439510a39dbc 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -102,7 +102,7 @@ static int ext4_block_to_path(struct inode *inode,
 		offsets[n++] = i_block & (ptrs - 1);
 		final = ptrs;
 	} else {
-		ext4_warning(inode->i_sb, "block %lu > max in inode %lu",
+		ext4_warning(inode->i_sb, "block %lu > max in inode %" PRIino "u",
 			     i_block + direct_blocks +
 			     indirect_blocks + double_blocks, inode->i_ino);
 	}
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1f6bc05593df165776fda3ab2c272af586d80279..fbdad8395f92ef5683a7bd65d683650a0ec04bc3 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -119,7 +119,7 @@ int ext4_get_max_inline_size(struct inode *inode)
 	error = ext4_get_inode_loc(inode, &iloc);
 	if (error) {
 		ext4_error_inode_err(inode, __func__, __LINE__, 0, -error,
-				     "can't get inode location %lu",
+				     "can't get inode location %" PRIino "u",
 				     inode->i_ino);
 		return 0;
 	}
@@ -512,7 +512,7 @@ static int ext4_read_inline_folio(struct inode *inode, struct folio *folio)
 	BUG_ON(folio->index);
 
 	if (!EXT4_I(inode)->i_inline_off) {
-		ext4_warning(inode->i_sb, "inode %lu doesn't have inline data.",
+		ext4_warning(inode->i_sb, "inode %" PRIino "u doesn't have inline data.",
 			     inode->i_ino);
 		goto out;
 	}
@@ -934,7 +934,7 @@ void ext4_show_inline_dir(struct inode *dir, struct buffer_head *bh,
 	struct ext4_dir_entry_2 *de = inline_start;
 	void *dlimit = inline_start + inline_size;
 
-	trace_printk("inode %lu\n", dir->i_ino);
+	trace_printk("inode %" PRIino "u\n", dir->i_ino);
 	offset = 0;
 	while ((void *)de < dlimit) {
 		de_len = ext4_rec_len_from_disk(de->rec_len, inline_size);
@@ -1071,7 +1071,7 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
 	ret = ext4_create_inline_data(handle, inode, inline_size);
 	if (ret) {
 		ext4_msg(inode->i_sb, KERN_EMERG,
-			"error restoring inline_data for inode -- potential data loss! (inode %lu, error %d)",
+			"error restoring inline_data for inode -- potential data loss! (inode %" PRIino "u, error %d)",
 			inode->i_ino, ret);
 		return;
 	}
@@ -1740,7 +1740,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 	err = ext4_get_inode_loc(dir, &iloc);
 	if (err) {
 		EXT4_ERROR_INODE_ERR(dir, -err,
-				     "error %d getting inode %lu block",
+				     "error %d getting inode %" PRIino "u block",
 				     err, dir->i_ino);
 		return false;
 	}
@@ -1755,7 +1755,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 	de = (struct ext4_dir_entry_2 *)ext4_raw_inode(&iloc)->i_block;
 	if (!le32_to_cpu(de->inode)) {
 		ext4_warning(dir->i_sb,
-			     "bad inline directory (dir #%lu) - no `..'",
+			     "bad inline directory (dir #%" PRIino "u) - no `..'",
 			     dir->i_ino);
 		goto out;
 	}
@@ -1769,7 +1769,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 					 iloc.bh, inline_pos,
 					 inline_size, offset)) {
 			ext4_warning(dir->i_sb,
-				     "bad inline directory (dir #%lu) - "
+				     "bad inline directory (dir #%" PRIino "u) - "
 				     "inode %u, rec_len %u, name_len %d"
 				     "inline size %d",
 				     dir->i_ino, le32_to_cpu(de->inode),
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 396dc3a5d16b4dc4d3e5c6541871a9bb896f6d7a..1d694672c851dd255f905de3d6260b24295ce30f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -262,7 +262,7 @@ void ext4_evict_inode(struct inode *inode)
 		err = ext4_truncate(inode);
 		if (err) {
 			ext4_error_err(inode->i_sb, -err,
-				       "couldn't truncate inode %lu (err %d)",
+				       "couldn't truncate inode %" PRIino "u (err %d)",
 				       inode->i_ino, err);
 			goto stop_handle;
 		}
@@ -342,7 +342,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
 	spin_lock(&ei->i_block_reservation_lock);
 	trace_ext4_da_update_reserve_space(inode, used, quota_claim);
 	if (unlikely(used > ei->i_reserved_data_blocks)) {
-		ext4_warning(inode->i_sb, "%s: ino %lu, used %d "
+		ext4_warning(inode->i_sb, "%s: ino %" PRIino "u, used %d "
 			 "with only %d reserved data blocks",
 			 __func__, inode->i_ino, used,
 			 ei->i_reserved_data_blocks);
@@ -475,7 +475,7 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 	if (es_map->m_lblk != map->m_lblk ||
 	    es_map->m_flags != map->m_flags ||
 	    es_map->m_pblk != map->m_pblk) {
-		printk("ES cache assertion failed for inode: %lu "
+		printk("ES cache assertion failed for inode: %" PRIino "u "
 		       "es_cached ex [%d/%d/%llu/%x] != "
 		       "found ex [%d/%d/%llu/%x] retval %d flags %x\n",
 		       inode->i_ino, es_map->m_lblk, es_map->m_len,
@@ -515,7 +515,7 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
 	if (unlikely(retval != map2.m_len)) {
 		ext4_warning(inode->i_sb,
 			     "ES len assertion failed for inode "
-			     "%lu: retval %d != map->m_len %d",
+			     "%" PRIino "u: retval %d != map->m_len %d",
 			     inode->i_ino, retval, map2.m_len);
 		WARN_ON(1);
 	}
@@ -563,7 +563,7 @@ int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 	if (unlikely(retval != map->m_len)) {
 		ext4_warning(inode->i_sb,
 			     "ES len assertion failed for inode "
-			     "%lu: retval %d != map->m_len %d",
+			     "%" PRIino "u: retval %d != map->m_len %d",
 			     inode->i_ino, retval, map->m_len);
 		WARN_ON(1);
 	}
@@ -630,7 +630,7 @@ int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 
 	if (unlikely(retval != map->m_len)) {
 		ext4_warning(inode->i_sb,
-			     "ES len assertion failed for inode %lu: "
+			     "ES len assertion failed for inode %" PRIino "u: "
 			     "retval %d != map->m_len %d",
 			     inode->i_ino, retval, map->m_len);
 		WARN_ON(1);
@@ -937,7 +937,7 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
 {
 	int ret = 0;
 
-	ext4_debug("ext4_get_block_unwritten: inode %lu, create flag %d\n",
+	ext4_debug("ext4_get_block_unwritten: inode %" PRIino "u, create flag %d\n",
 		   inode->i_ino, create);
 	ret = _ext4_get_block(inode, iblock, bh_result,
 			       EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
@@ -1659,7 +1659,7 @@ void ext4_da_release_space(struct inode *inode, int to_free)
 		 * harmless to return without any action.
 		 */
 		ext4_warning(inode->i_sb, "ext4_da_release_space: "
-			 "ino %lu, to_free %d with only %d reserved "
+			 "ino %" PRIino "u, to_free %d with only %d reserved "
 			 "data blocks", inode->i_ino, to_free,
 			 ei->i_reserved_data_blocks);
 		WARN_ON(1);
@@ -2491,7 +2491,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 			}
 			ext4_msg(sb, KERN_CRIT,
 				 "Delayed block allocation failed for "
-				 "inode %lu at logical offset %llu with"
+				 "inode %" PRIino "u at logical offset %llu with"
 				 " max blocks %u with error %d",
 				 inode->i_ino,
 				 (unsigned long long)map->m_lblk,
@@ -2535,7 +2535,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		err2 = ext4_mark_inode_dirty(handle, inode);
 		if (err2) {
 			ext4_error_err(inode->i_sb, -err2,
-				       "Failed to mark inode %lu dirty",
+				       "Failed to mark inode %" PRIino "u dirty",
 				       inode->i_ino);
 		}
 		if (!err)
@@ -2909,7 +2909,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		if (IS_ERR(handle)) {
 			ret = PTR_ERR(handle);
 			ext4_msg(inode->i_sb, KERN_CRIT, "%s: jbd2_start: "
-			       "%ld pages, ino %lu; err %d", __func__,
+			       "%ld pages, ino %" PRIino "u; err %d", __func__,
 				wbc->nr_to_write, inode->i_ino, ret);
 			/* Release allocated io_end */
 			ext4_put_io_end(mpd->io_submit.io_end);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 3ae9cb50a0c057f10f6bda8165ba45fd2c368cfb..dcd71f84d9a80f464349e75e4dbbf62757dfeb03 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -477,7 +477,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	if (err < 0) {
 		/* No need to update quota information. */
 		ext4_warning(inode->i_sb,
-			"couldn't mark inode #%lu dirty (err %d)",
+			"couldn't mark inode #%" PRIino "u dirty (err %d)",
 			inode->i_ino, err);
 		/* Revert all changes: */
 		swap_inode_data(inode, inode_bl);
@@ -493,7 +493,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	if (err < 0) {
 		/* No need to update quota information. */
 		ext4_warning(inode_bl->i_sb,
-			"couldn't mark inode #%lu dirty (err %d)",
+			"couldn't mark inode #%" PRIino "u dirty (err %d)",
 			inode_bl->i_ino, err);
 		goto revert;
 	}
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 20e9fdaf4301b61c9d54401ed95067db6b6b8173..f597135a669a53c05a5fd8f48c02a43ef4f1cdb0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2266,7 +2266,7 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	folio_get(ac->ac_buddy_folio);
 	/* store last allocated for subsequent stream allocation */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
-		int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
+		int hash = (unsigned int)ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
 
 		WRITE_ONCE(sbi->s_mb_last_groups[hash], ac->ac_f_ex.fe_group);
 	}
@@ -3032,7 +3032,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	/* if stream allocation is enabled, use global goal */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
-		int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
+		int hash = (unsigned int)ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
 
 		ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_groups[hash]);
 		ac->ac_g_ex.fe_start = -1;
@@ -5628,7 +5628,7 @@ void ext4_discard_preallocations(struct inode *inode)
 	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
-	mb_debug(sb, "discard preallocation for inode %lu\n",
+	mb_debug(sb, "discard preallocation for inode %" PRIino "u\n",
 		 inode->i_ino);
 	trace_ext4_discard_preallocations(inode,
 			atomic_read(&ei->i_prealloc_active));
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 96ab95167bd6e10ba86e61a60cb0be9fbafe157f..43103816b80ef4901858bcd789acb0ffb2612317 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -455,7 +455,7 @@ int ext4_ext_migrate(struct inode *inode)
 	 * log, so disable fast commits for this transaction.
 	 */
 	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MIGRATE, handle);
-	goal = (((inode->i_ino - 1) / EXT4_INODES_PER_GROUP(inode->i_sb)) *
+	goal = (div_u64(inode->i_ino - 1, EXT4_INODES_PER_GROUP(inode->i_sb)) *
 		EXT4_INODES_PER_GROUP(inode->i_sb)) + 1;
 	owner[0] = i_uid_read(inode);
 	owner[1] = i_gid_read(inode);
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index ce1f738dff938c5685ef87099df4c87702657a39..89df4e0591055ec3c365bd51995a523e5b4d83d1 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -420,21 +420,21 @@ static int mext_check_validity(struct inode *orig_inode,
 
 	/* origin and donor should be different inodes */
 	if (orig_inode == donor_inode) {
-		ext4_debug("ext4 move extent: The argument files should not be same inode [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: The argument files should not be same inode [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
 
 	/* origin and donor should belone to the same filesystem */
 	if (orig_inode->i_sb != donor_inode->i_sb) {
-		ext4_debug("ext4 move extent: The argument files should be in same FS [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: The argument files should be in same FS [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
 
 	/* Regular file check */
 	if (!S_ISREG(orig_inode->i_mode) || !S_ISREG(donor_inode->i_mode)) {
-		ext4_debug("ext4 move extent: The argument files should be regular file [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: The argument files should be regular file [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
@@ -477,26 +477,26 @@ static int mext_check_validity(struct inode *orig_inode,
 	}
 
 	if (donor_inode->i_mode & (S_ISUID|S_ISGID)) {
-		ext4_debug("ext4 move extent: suid or sgid is set to donor file [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: suid or sgid is set to donor file [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
 
 	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode)) {
-		ext4_debug("ext4 move extent: donor should not be immutable or append file [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: donor should not be immutable or append file [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EPERM;
 	}
 
 	/* Ext4 move extent does not support swap files */
 	if (IS_SWAPFILE(orig_inode) || IS_SWAPFILE(donor_inode)) {
-		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -ETXTBSY;
 	}
 
 	if (ext4_is_quota_file(orig_inode) || ext4_is_quota_file(donor_inode)) {
-		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EOPNOTSUPP;
 	}
@@ -523,7 +523,7 @@ static int mext_check_adjust_range(struct inode *orig_inode,
 	/* Start offset should be same */
 	if ((orig_start & ~(PAGE_MASK >> orig_inode->i_blkbits)) !=
 	    (donor_start & ~(PAGE_MASK >> orig_inode->i_blkbits))) {
-		ext4_debug("ext4 move extent: orig and donor's start offsets are not aligned [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: orig and donor's start offsets are not aligned [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
@@ -533,7 +533,7 @@ static int mext_check_adjust_range(struct inode *orig_inode,
 	    (*len > EXT_MAX_BLOCKS) ||
 	    (donor_start + *len >= EXT_MAX_BLOCKS) ||
 	    (orig_start + *len >= EXT_MAX_BLOCKS))  {
-		ext4_debug("ext4 move extent: Can't handle over [%u] blocks [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: Can't handle over [%u] blocks [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
 			   EXT_MAX_BLOCKS,
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
@@ -550,7 +550,7 @@ static int mext_check_adjust_range(struct inode *orig_inode,
 	else if (donor_eof < donor_start + *len - 1)
 		*len = donor_eof - donor_start;
 	if (!*len) {
-		ext4_debug("ext4 move extent: len should not be 0 [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: len should not be 0 [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index c4b5e252af0efbfcbaf83688a32d445327a74a02..e659897787de1cc7e587af191908408162511db4 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -144,7 +144,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		bh = ext4_bread(NULL, inode, block, 0);
 	if (IS_ERR(bh)) {
 		__ext4_warning(inode->i_sb, func, line,
-			       "inode #%lu: lblock %lu: comm %s: "
+			       "inode #%" PRIino "u: lblock %lu: comm %s: "
 			       "error %ld reading directory block",
 			       inode->i_ino, (unsigned long)block,
 			       current->comm, PTR_ERR(bh));
@@ -841,7 +841,7 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	indirect = root->info.indirect_levels;
 	if (indirect >= ext4_dir_htree_level(dir->i_sb)) {
 		ext4_warning(dir->i_sb,
-			     "Directory (ino: %lu) htree depth %#06x exceed"
+			     "Directory (ino: %" PRIino "u) htree depth %#06x exceed"
 			     "supported value", dir->i_ino,
 			     ext4_dir_htree_level(dir->i_sb));
 		if (ext4_dir_htree_level(dir->i_sb) < EXT4_HTREE_LEVEL) {
@@ -1793,7 +1793,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 		    !fscrypt_has_permitted_context(dir, inode)) {
 			ext4_warning(inode->i_sb,
-				     "Inconsistent encryption contexts: %lu/%lu",
+				     "Inconsistent encryption contexts: %" PRIino "u/%" PRIino "u",
 				     dir->i_ino, inode->i_ino);
 			iput(inode);
 			return ERR_PTR(-EPERM);
@@ -2227,7 +2227,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
 	blocksize =  dir->i_sb->s_blocksize;
-	dxtrace(printk(KERN_DEBUG "Creating index: inode %lu\n", dir->i_ino));
+	dxtrace(printk(KERN_DEBUG "Creating index: inode %" PRIino "u\n", dir->i_ino));
 	BUFFER_TRACE(bh, "get_write_access");
 	retval = ext4_journal_get_write_access(handle, dir->i_sb, bh,
 					       EXT4_JTR_NONE);
@@ -2523,7 +2523,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			restart = 1;
 		}
 		if (add_level && levels == ext4_dir_htree_level(sb)) {
-			ext4_warning(sb, "Directory (ino: %lu) index full, "
+			ext4_warning(sb, "Directory (ino: %" PRIino "u) index full, "
 					 "reach max htree level :%d",
 					 dir->i_ino, levels);
 			if (ext4_dir_htree_level(sb) < EXT4_HTREE_LEVEL) {
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index c0022f0bff8749badfe80d2a7628bea5ce96ab1e..7082af298f1c648fba8a1aa1141b3c76f4c15e22 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -179,8 +179,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	} else
 		brelse(iloc.bh);
 
-	ext4_debug("superblock will point to %lu\n", inode->i_ino);
-	ext4_debug("orphan inode %lu will point to %d\n",
+	ext4_debug("superblock will point to %" PRIino "u\n", inode->i_ino);
+	ext4_debug("orphan inode %" PRIino "u will point to %d\n",
 			inode->i_ino, NEXT_ORPHAN(inode));
 out:
 	ext4_std_error(sb, err);
@@ -249,7 +249,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	}
 
 	mutex_lock(&sbi->s_orphan_lock);
-	ext4_debug("remove inode %lu from orphan list\n", inode->i_ino);
+	ext4_debug("remove inode %" PRIino "u from orphan list\n", inode->i_ino);
 
 	prev = ei->i_orphan.prev;
 	list_del_init(&ei->i_orphan);
@@ -284,7 +284,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 		struct inode *i_prev =
 			&list_entry(prev, struct ext4_inode_info, i_orphan)->vfs_inode;
 
-		ext4_debug("orphan inode %lu will point to %u\n",
+		ext4_debug("orphan inode %" PRIino "u will point to %u\n",
 			  i_prev->i_ino, ino_next);
 		err = ext4_reserve_inode_write(handle, i_prev, &iloc2);
 		if (err) {
@@ -328,9 +328,9 @@ static void ext4_process_orphan(struct inode *inode,
 	if (inode->i_nlink) {
 		if (test_opt(sb, DEBUG))
 			ext4_msg(sb, KERN_DEBUG,
-				"%s: truncating inode %lu to %lld bytes",
+				"%s: truncating inode %" PRIino "u to %lld bytes",
 				__func__, inode->i_ino, inode->i_size);
-		ext4_debug("truncating inode %lu to %lld bytes\n",
+		ext4_debug("truncating inode %" PRIino "u to %lld bytes\n",
 			   inode->i_ino, inode->i_size);
 		inode_lock(inode);
 		truncate_inode_pages(inode->i_mapping, inode->i_size);
@@ -349,9 +349,9 @@ static void ext4_process_orphan(struct inode *inode,
 	} else {
 		if (test_opt(sb, DEBUG))
 			ext4_msg(sb, KERN_DEBUG,
-				"%s: deleting unreferenced inode %lu",
+				"%s: deleting unreferenced inode %" PRIino "u",
 				__func__, inode->i_ino);
-		ext4_debug("deleting unreferenced inode %lu\n",
+		ext4_debug("deleting unreferenced inode %" PRIino "u\n",
 			   inode->i_ino);
 		(*nr_orphans)++;
 	}
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index a8c95eee91b79e36ebde09fac9033be359baf8fc..09046cfb58dd52a2fe682560fa09e39e902dd0a2 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -180,7 +180,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 	struct super_block *sb = inode->i_sb;
 	int ret = 0;
 
-	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %lu,list->next 0x%p,"
+	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %" PRIino "u,list->next 0x%p,"
 		   "list->prev 0x%p\n",
 		   io_end, inode->i_ino, io_end->list.next, io_end->list.prev);
 
@@ -204,7 +204,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 		ext4_msg(sb, KERN_EMERG,
 			 "failed to convert unwritten extents to written "
 			 "extents -- potential data loss!  "
-			 "(inode %lu, error %d)", inode->i_ino, ret);
+			 "(inode %" PRIino "u, error %d)", inode->i_ino, ret);
 	}
 
 	ext4_clear_io_unwritten_flag(io_end);
@@ -221,7 +221,7 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
 	if (list_empty(head))
 		return;
 
-	ext4_debug("Dump inode %lu completed io list\n", inode->i_ino);
+	ext4_debug("Dump inode %" PRIino "u completed io list\n", inode->i_ino);
 	list_for_each_entry(io_end, head, list) {
 		cur = &io_end->list;
 		before = cur->prev;
@@ -229,7 +229,7 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
 		after = cur->next;
 		io_end1 = container_of(after, ext4_io_end_t, list);
 
-		ext4_debug("io 0x%p from inode %lu,prev 0x%p,next 0x%p\n",
+		ext4_debug("io 0x%p from inode %" PRIino "u,prev 0x%p,next 0x%p\n",
 			    io_end, inode->i_ino, io_end0, io_end1);
 	}
 #endif
@@ -366,7 +366,7 @@ static void ext4_end_bio(struct bio *bio)
 	if (bio->bi_status) {
 		struct inode *inode = io_end->inode;
 
-		ext4_warning(inode->i_sb, "I/O error %d writing to inode %lu "
+		ext4_warning(inode->i_sb, "I/O error %d writing to inode %" PRIino "u "
 			     "starting block %llu)",
 			     bio->bi_status, inode->i_ino,
 			     (unsigned long long)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 43f680c750ae6b2cacb35bcaad262ba234676ef4..17463e9cc893cf3158a5a75d64d453956373f149 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -848,12 +848,12 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 		vaf.va = &args;
 		if (block)
 			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
-			       "inode #%lu: block %llu: comm %s: %pV\n",
+			       "inode #%" PRIino "u: block %llu: comm %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
 			       block, current->comm, &vaf);
 		else
 			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
-			       "inode #%lu: comm %s: %pV\n",
+			       "inode #%" PRIino "u: comm %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
 			       current->comm, &vaf);
 		va_end(args);
@@ -888,13 +888,13 @@ void __ext4_error_file(struct file *file, const char *function,
 		vaf.va = &args;
 		if (block)
 			printk(KERN_CRIT
-			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
+			       "EXT4-fs error (device %s): %s:%d: inode #%" PRIino "u: "
 			       "block %llu: comm %s: path %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
 			       block, current->comm, path, &vaf);
 		else
 			printk(KERN_CRIT
-			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
+			       "EXT4-fs error (device %s): %s:%d: inode #%" PRIino "u: "
 			       "comm %s: path %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
 			       current->comm, path, &vaf);
@@ -1035,14 +1035,14 @@ void __ext4_warning_inode(const struct inode *inode, const char *function,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: "
-	       "inode #%lu: comm %s: %pV\n", inode->i_sb->s_id,
+	       "inode #%" PRIino "u: comm %s: %pV\n", inode->i_sb->s_id,
 	       function, line, inode->i_ino, current->comm, &vaf);
 	va_end(args);
 }
 
 void __ext4_grp_locked_error(const char *function, unsigned int line,
 			     struct super_block *sb, ext4_group_t grp,
-			     unsigned long ino, ext4_fsblk_t block,
+			     kino_t ino, ext4_fsblk_t block,
 			     const char *fmt, ...)
 __releases(bitlock)
 __acquires(bitlock)
@@ -1061,7 +1061,7 @@ __acquires(bitlock)
 		printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: group %u, ",
 		       sb->s_id, function, line, grp);
 		if (ino)
-			printk(KERN_CONT "inode %lu: ", ino);
+			printk(KERN_CONT "inode %" PRIino "u: ", ino);
 		if (block)
 			printk(KERN_CONT "block %llu:",
 			       (unsigned long long) block);
@@ -1170,7 +1170,7 @@ static void dump_orphan_list(struct super_block *sb, struct ext4_sb_info *sbi)
 	list_for_each(l, &sbi->s_orphan) {
 		struct inode *inode = orphan_list_entry(l);
 		printk(KERN_ERR "  "
-		       "inode %s:%lu at %p: mode %o, nlink %d, next %d\n",
+		       "inode %s:%" PRIino "u at %p: mode %o, nlink %d, next %d\n",
 		       inode->i_sb->s_id, inode->i_ino, inode,
 		       inode->i_mode, inode->i_nlink,
 		       NEXT_ORPHAN(inode));
@@ -1446,7 +1446,7 @@ static void ext4_free_in_core_inode(struct inode *inode)
 {
 	fscrypt_free_inode(inode);
 	if (!list_empty(&(EXT4_I(inode)->i_fc_list))) {
-		pr_warn("%s: inode %ld still in fc list",
+		pr_warn("%s: inode %" PRIino "u still in fc list",
 			__func__, inode->i_ino);
 	}
 	kmem_cache_free(ext4_inode_cachep, EXT4_I(inode));
@@ -1456,7 +1456,7 @@ static void ext4_destroy_inode(struct inode *inode)
 {
 	if (ext4_inode_orphan_tracked(inode)) {
 		ext4_msg(inode->i_sb, KERN_ERR,
-			 "Inode %lu (%p): inode tracked as orphan!",
+			 "Inode %" PRIino "u (%p): inode tracked as orphan!",
 			 inode->i_ino, EXT4_I(inode));
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
 				EXT4_I(inode), sizeof(struct ext4_inode_info),
@@ -1467,7 +1467,7 @@ static void ext4_destroy_inode(struct inode *inode)
 	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ERROR_FS) &&
 	    WARN_ON_ONCE(EXT4_I(inode)->i_reserved_data_blocks))
 		ext4_msg(inode->i_sb, KERN_ERR,
-			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
+			 "Inode %" PRIino "u (%p): i_reserved_data_blocks (%u) not cleared!",
 			 inode->i_ino, EXT4_I(inode),
 			 EXT4_I(inode)->i_reserved_data_blocks);
 }
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7bf9ba19a89db2cd9e9536191eb904afe4c5f5d8..13d8f5c80b3128e3cf1044e57fd667f47f90ad6d 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -64,7 +64,7 @@
 
 #ifdef EXT4_XATTR_DEBUG
 # define ea_idebug(inode, fmt, ...)					\
-	printk(KERN_DEBUG "inode %s:%lu: " fmt "\n",			\
+	printk(KERN_DEBUG "inode %s:%" PRIino "u: " fmt "\n",			\
 	       inode->i_sb->s_id, inode->i_ino, ##__VA_ARGS__)
 # define ea_bdebug(bh, fmt, ...)					\
 	printk(KERN_DEBUG "block %pg:%lu: " fmt "\n",			\
@@ -1035,7 +1035,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 	ref_count = ext4_xattr_inode_get_ref(ea_inode);
 	if ((ref_count == 0 && ref_change < 0) || (ref_count == U64_MAX && ref_change > 0)) {
 		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
-			"EA inode %lu ref wraparound: ref_count=%lld ref_change=%d",
+			"EA inode %" PRIino "u ref wraparound: ref_count=%lld ref_change=%d",
 			ea_inode->i_ino, ref_count, ref_change);
 		brelse(iloc.bh);
 		ret = -EFSCORRUPTED;
@@ -1046,7 +1046,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 
 	if (ref_change > 0) {
 		if (ref_count == 1) {
-			WARN_ONCE(ea_inode->i_nlink, "EA inode %lu i_nlink=%u",
+			WARN_ONCE(ea_inode->i_nlink, "EA inode %" PRIino "u i_nlink=%u",
 				  ea_inode->i_ino, ea_inode->i_nlink);
 
 			set_nlink(ea_inode, 1);
@@ -1055,7 +1055,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 	} else {
 		if (ref_count == 0) {
 			WARN_ONCE(ea_inode->i_nlink != 1,
-				  "EA inode %lu i_nlink=%u",
+				  "EA inode %" PRIino "u i_nlink=%u",
 				  ea_inode->i_ino, ea_inode->i_nlink);
 
 			clear_nlink(ea_inode);
@@ -2854,7 +2854,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 
 cleanup:
 	if (error && (mnt_count != le16_to_cpu(sbi->s_es->s_mnt_count))) {
-		ext4_warning(inode->i_sb, "Unable to expand inode %lu. Delete some EAs or run e2fsck.",
+		ext4_warning(inode->i_sb, "Unable to expand inode %" PRIino "u. Delete some EAs or run e2fsck.",
 			     inode->i_ino);
 		mnt_count = le16_to_cpu(sbi->s_es->s_mnt_count);
 	}
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index a3e8fe414df85c53e8aa15836ab93c3ae514c815..7d66bef799e4d3859d88d0c738811088d7543505 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -138,14 +138,14 @@ TRACE_DEFINE_ENUM(CR_ANY_FREE);
 			 { CR_ANY_FREE, "CR_ANY_FREE" })
 
 TRACE_EVENT(ext4_other_inode_update_time,
-	TP_PROTO(struct inode *inode, ino_t orig_ino),
+	TP_PROTO(struct inode *inode, u64 orig_ino),
 
 	TP_ARGS(inode, orig_ino),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
-		__field(	ino_t,	orig_ino		)
+		__field(	u64,	ino			)
+		__field(	u64,	orig_ino		)
 		__field(	uid_t,	uid			)
 		__field(	gid_t,	gid			)
 		__field(	__u16, mode			)
@@ -160,10 +160,10 @@ TRACE_EVENT(ext4_other_inode_update_time,
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d orig_ino %lu ino %lu mode 0%o uid %u gid %u",
+	TP_printk("dev %d,%d orig_ino %llu ino %llu mode 0%o uid %u gid %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->orig_ino,
-		  (unsigned long) __entry->ino, __entry->mode,
+		  __entry->orig_ino,
+		  __entry->ino, __entry->mode,
 		  __entry->uid, __entry->gid)
 );
 
@@ -174,7 +174,7 @@ TRACE_EVENT(ext4_free_inode,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	uid_t,	uid			)
 		__field(	gid_t,	gid			)
 		__field(	__u64, blocks			)
@@ -190,9 +190,9 @@ TRACE_EVENT(ext4_free_inode,
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o uid %u gid %u blocks %llu",
+	TP_printk("dev %d,%d ino %llu mode 0%o uid %u gid %u blocks %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->mode,
+		  __entry->ino, __entry->mode,
 		  __entry->uid, __entry->gid, __entry->blocks)
 );
 
@@ -203,7 +203,7 @@ TRACE_EVENT(ext4_request_inode,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	dir			)
+		__field(	u64,	dir			)
 		__field(	__u16, mode			)
 	),
 
@@ -213,9 +213,9 @@ TRACE_EVENT(ext4_request_inode,
 		__entry->mode	= mode;
 	),
 
-	TP_printk("dev %d,%d dir %lu mode 0%o",
+	TP_printk("dev %d,%d dir %llu mode 0%o",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->dir, __entry->mode)
+		  __entry->dir, __entry->mode)
 );
 
 TRACE_EVENT(ext4_allocate_inode,
@@ -225,8 +225,8 @@ TRACE_EVENT(ext4_allocate_inode,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
-		__field(	ino_t,	dir			)
+		__field(	u64,	ino			)
+		__field(	u64,	dir			)
 		__field(	__u16,	mode			)
 	),
 
@@ -237,10 +237,10 @@ TRACE_EVENT(ext4_allocate_inode,
 		__entry->mode	= mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu dir %lu mode 0%o",
+	TP_printk("dev %d,%d ino %llu dir %llu mode 0%o",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
-		  (unsigned long) __entry->dir, __entry->mode)
+		  __entry->ino,
+		  __entry->dir, __entry->mode)
 );
 
 TRACE_EVENT(ext4_evict_inode,
@@ -250,7 +250,7 @@ TRACE_EVENT(ext4_evict_inode,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	int,	nlink			)
 	),
 
@@ -260,9 +260,9 @@ TRACE_EVENT(ext4_evict_inode,
 		__entry->nlink	= inode->i_nlink;
 	),
 
-	TP_printk("dev %d,%d ino %lu nlink %d",
+	TP_printk("dev %d,%d ino %llu nlink %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->nlink)
+		  __entry->ino, __entry->nlink)
 );
 
 TRACE_EVENT(ext4_drop_inode,
@@ -272,7 +272,7 @@ TRACE_EVENT(ext4_drop_inode,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	int,	drop			)
 	),
 
@@ -282,9 +282,9 @@ TRACE_EVENT(ext4_drop_inode,
 		__entry->drop	= drop;
 	),
 
-	TP_printk("dev %d,%d ino %lu drop %d",
+	TP_printk("dev %d,%d ino %llu drop %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->drop)
+		  __entry->ino, __entry->drop)
 );
 
 TRACE_EVENT(ext4_nfs_commit_metadata,
@@ -294,7 +294,7 @@ TRACE_EVENT(ext4_nfs_commit_metadata,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 	),
 
 	TP_fast_assign(
@@ -302,9 +302,9 @@ TRACE_EVENT(ext4_nfs_commit_metadata,
 		__entry->ino	= inode->i_ino;
 	),
 
-	TP_printk("dev %d,%d ino %lu",
+	TP_printk("dev %d,%d ino %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino)
+		  __entry->ino)
 );
 
 TRACE_EVENT(ext4_mark_inode_dirty,
@@ -314,7 +314,7 @@ TRACE_EVENT(ext4_mark_inode_dirty,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(unsigned long,	ip			)
 	),
 
@@ -324,9 +324,9 @@ TRACE_EVENT(ext4_mark_inode_dirty,
 		__entry->ip	= IP;
 	),
 
-	TP_printk("dev %d,%d ino %lu caller %pS",
+	TP_printk("dev %d,%d ino %llu caller %pS",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, (void *)__entry->ip)
+		  __entry->ino, (void *)__entry->ip)
 );
 
 TRACE_EVENT(ext4_begin_ordered_truncate,
@@ -336,7 +336,7 @@ TRACE_EVENT(ext4_begin_ordered_truncate,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	loff_t,	new_size		)
 	),
 
@@ -346,9 +346,9 @@ TRACE_EVENT(ext4_begin_ordered_truncate,
 		__entry->new_size	= new_size;
 	),
 
-	TP_printk("dev %d,%d ino %lu new_size %lld",
+	TP_printk("dev %d,%d ino %llu new_size %lld",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->new_size)
 );
 
@@ -360,7 +360,7 @@ DECLARE_EVENT_CLASS(ext4__write_begin,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	loff_t,	pos			)
 		__field(	unsigned int, len		)
 	),
@@ -372,9 +372,9 @@ DECLARE_EVENT_CLASS(ext4__write_begin,
 		__entry->len	= len;
 	),
 
-	TP_printk("dev %d,%d ino %lu pos %lld len %u",
+	TP_printk("dev %d,%d ino %llu pos %lld len %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->pos, __entry->len)
 );
 
@@ -400,7 +400,7 @@ DECLARE_EVENT_CLASS(ext4__write_end,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	loff_t,	pos			)
 		__field(	unsigned int, len		)
 		__field(	unsigned int, copied		)
@@ -414,9 +414,9 @@ DECLARE_EVENT_CLASS(ext4__write_end,
 		__entry->copied	= copied;
 	),
 
-	TP_printk("dev %d,%d ino %lu pos %lld len %u copied %u",
+	TP_printk("dev %d,%d ino %llu pos %lld len %u copied %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->pos, __entry->len, __entry->copied)
 );
 
@@ -451,7 +451,7 @@ TRACE_EVENT(ext4_writepages,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	long,	nr_to_write		)
 		__field(	long,	pages_skipped		)
 		__field(	loff_t,	range_start		)
@@ -475,11 +475,11 @@ TRACE_EVENT(ext4_writepages,
 		__entry->range_cyclic	= wbc->range_cyclic;
 	),
 
-	TP_printk("dev %d,%d ino %lu nr_to_write %ld pages_skipped %ld "
+	TP_printk("dev %d,%d ino %llu nr_to_write %ld pages_skipped %ld "
 		  "range_start %lld range_end %lld sync_mode %d "
 		  "for_kupdate %d range_cyclic %d writeback_index %lu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->nr_to_write,
+		  __entry->ino, __entry->nr_to_write,
 		  __entry->pages_skipped, __entry->range_start,
 		  __entry->range_end, __entry->sync_mode,
 		  __entry->for_kupdate, __entry->range_cyclic,
@@ -494,7 +494,7 @@ TRACE_EVENT(ext4_da_write_folios_start,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(       loff_t,	start_pos		)
 		__field(       loff_t,	next_pos		)
 		__field(	 long,	nr_to_write		)
@@ -510,9 +510,9 @@ TRACE_EVENT(ext4_da_write_folios_start,
 		__entry->sync_mode	= wbc->sync_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu start_pos 0x%llx next_pos 0x%llx nr_to_write %ld sync_mode %d",
+	TP_printk("dev %d,%d ino %llu start_pos 0x%llx next_pos 0x%llx nr_to_write %ld sync_mode %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->start_pos, __entry->next_pos,
+		  __entry->ino, __entry->start_pos, __entry->next_pos,
 		  __entry->nr_to_write, __entry->sync_mode)
 );
 
@@ -524,7 +524,7 @@ TRACE_EVENT(ext4_da_write_folios_end,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(       loff_t,	start_pos		)
 		__field(       loff_t,	next_pos		)
 		__field(	 long,	nr_to_write		)
@@ -540,9 +540,9 @@ TRACE_EVENT(ext4_da_write_folios_end,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev %d,%d ino %lu start_pos 0x%llx next_pos 0x%llx nr_to_write %ld ret %d",
+	TP_printk("dev %d,%d ino %llu start_pos 0x%llx next_pos 0x%llx nr_to_write %ld ret %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->start_pos, __entry->next_pos,
+		  __entry->ino, __entry->start_pos, __entry->next_pos,
 		  __entry->nr_to_write, __entry->ret)
 );
 
@@ -553,7 +553,7 @@ TRACE_EVENT(ext4_da_write_pages_extent,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u64,	lblk			)
 		__field(	__u32,	len			)
 		__field(	__u32,	flags			)
@@ -567,9 +567,9 @@ TRACE_EVENT(ext4_da_write_pages_extent,
 		__entry->flags		= map->m_flags;
 	),
 
-	TP_printk("dev %d,%d ino %lu lblk %llu len %u flags %s",
+	TP_printk("dev %d,%d ino %llu lblk %llu len %u flags %s",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->lblk, __entry->len,
+		  __entry->ino, __entry->lblk, __entry->len,
 		  show_mflags(__entry->flags))
 );
 
@@ -581,7 +581,7 @@ TRACE_EVENT(ext4_writepages_result,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	int,	ret			)
 		__field(	int,	pages_written		)
 		__field(	long,	pages_skipped		)
@@ -599,10 +599,10 @@ TRACE_EVENT(ext4_writepages_result,
 		__entry->sync_mode	= wbc->sync_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu ret %d pages_written %d pages_skipped %ld "
+	TP_printk("dev %d,%d ino %llu ret %d pages_written %d pages_skipped %ld "
 		  "sync_mode %d writeback_index %lu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->ret,
+		  __entry->ino, __entry->ret,
 		  __entry->pages_written, __entry->pages_skipped,
 		  __entry->sync_mode,
 		  (unsigned long) __entry->writeback_index)
@@ -615,7 +615,7 @@ DECLARE_EVENT_CLASS(ext4__folio_op,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	pgoff_t, index			)
 
 	),
@@ -626,9 +626,9 @@ DECLARE_EVENT_CLASS(ext4__folio_op,
 		__entry->index	= folio->index;
 	),
 
-	TP_printk("dev %d,%d ino %lu folio_index %lu",
+	TP_printk("dev %d,%d ino %llu folio_index %lu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  (unsigned long) __entry->index)
 );
 
@@ -653,7 +653,7 @@ DECLARE_EVENT_CLASS(ext4_invalidate_folio_op,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	pgoff_t, index			)
 		__field(	size_t, offset			)
 		__field(	size_t, length			)
@@ -667,9 +667,9 @@ DECLARE_EVENT_CLASS(ext4_invalidate_folio_op,
 		__entry->length	= length;
 	),
 
-	TP_printk("dev %d,%d ino %lu folio_index %lu offset %zu length %zu",
+	TP_printk("dev %d,%d ino %llu folio_index %lu offset %zu length %zu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  (unsigned long) __entry->index,
 		  __entry->offset, __entry->length)
 );
@@ -718,7 +718,7 @@ DECLARE_EVENT_CLASS(ext4__mb_new_pa,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u64,	pa_pstart		)
 		__field(	__u64,	pa_lstart		)
 		__field(	__u32,	pa_len			)
@@ -733,9 +733,9 @@ DECLARE_EVENT_CLASS(ext4__mb_new_pa,
 		__entry->pa_len		= pa->pa_len;
 	),
 
-	TP_printk("dev %d,%d ino %lu pstart %llu len %u lstart %llu",
+	TP_printk("dev %d,%d ino %llu pstart %llu len %u lstart %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->pa_pstart, __entry->pa_len, __entry->pa_lstart)
 );
 
@@ -763,7 +763,7 @@ TRACE_EVENT(ext4_mb_release_inode_pa,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u64,	block			)
 		__field(	__u32,	count			)
 
@@ -776,9 +776,9 @@ TRACE_EVENT(ext4_mb_release_inode_pa,
 		__entry->count		= count;
 	),
 
-	TP_printk("dev %d,%d ino %lu block %llu count %u",
+	TP_printk("dev %d,%d ino %llu block %llu count %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->block, __entry->count)
 );
 
@@ -812,7 +812,7 @@ TRACE_EVENT(ext4_discard_preallocations,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	unsigned int,	len		)
 
 	),
@@ -823,9 +823,9 @@ TRACE_EVENT(ext4_discard_preallocations,
 		__entry->len	= len;
 	),
 
-	TP_printk("dev %d,%d ino %lu len: %u",
+	TP_printk("dev %d,%d ino %llu len: %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->len)
+		  __entry->ino, __entry->len)
 );
 
 TRACE_EVENT(ext4_mb_discard_preallocations,
@@ -856,7 +856,7 @@ TRACE_EVENT(ext4_request_blocks,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	unsigned int, len		)
 		__field(	__u32,  logical			)
 		__field(	__u32,	lleft			)
@@ -880,10 +880,10 @@ TRACE_EVENT(ext4_request_blocks,
 		__entry->flags	= ar->flags;
 	),
 
-	TP_printk("dev %d,%d ino %lu flags %s len %u lblk %u goal %llu "
+	TP_printk("dev %d,%d ino %llu flags %s len %u lblk %u goal %llu "
 		  "lleft %u lright %u pleft %llu pright %llu ",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, show_mballoc_flags(__entry->flags),
+		  __entry->ino, show_mballoc_flags(__entry->flags),
 		  __entry->len, __entry->logical, __entry->goal,
 		  __entry->lleft, __entry->lright, __entry->pleft,
 		  __entry->pright)
@@ -896,7 +896,7 @@ TRACE_EVENT(ext4_allocate_blocks,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u64,	block			)
 		__field(	unsigned int, len		)
 		__field(	__u32,  logical			)
@@ -922,10 +922,10 @@ TRACE_EVENT(ext4_allocate_blocks,
 		__entry->flags	= ar->flags;
 	),
 
-	TP_printk("dev %d,%d ino %lu flags %s len %u block %llu lblk %u "
+	TP_printk("dev %d,%d ino %llu flags %s len %u block %llu lblk %u "
 		  "goal %llu lleft %u lright %u pleft %llu pright %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, show_mballoc_flags(__entry->flags),
+		  __entry->ino, show_mballoc_flags(__entry->flags),
 		  __entry->len, __entry->block, __entry->logical,
 		  __entry->goal,  __entry->lleft, __entry->lright,
 		  __entry->pleft, __entry->pright)
@@ -939,7 +939,7 @@ TRACE_EVENT(ext4_free_blocks,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u64,	block			)
 		__field(	unsigned long,	count		)
 		__field(	int,	flags			)
@@ -955,9 +955,9 @@ TRACE_EVENT(ext4_free_blocks,
 		__entry->mode		= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o block %llu count %lu flags %s",
+	TP_printk("dev %d,%d ino %llu mode 0%o block %llu count %lu flags %s",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->mode, __entry->block, __entry->count,
 		  show_free_flags(__entry->flags))
 );
@@ -969,8 +969,8 @@ TRACE_EVENT(ext4_sync_file_enter,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
-		__field(	ino_t,	parent			)
+		__field(	u64,	ino			)
+		__field(	u64,	parent			)
 		__field(	int,	datasync		)
 	),
 
@@ -983,10 +983,10 @@ TRACE_EVENT(ext4_sync_file_enter,
 		__entry->parent		= d_inode(dentry->d_parent)->i_ino;
 	),
 
-	TP_printk("dev %d,%d ino %lu parent %lu datasync %d ",
+	TP_printk("dev %d,%d ino %llu parent %llu datasync %d ",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
-		  (unsigned long) __entry->parent, __entry->datasync)
+		  __entry->ino,
+		  __entry->parent, __entry->datasync)
 );
 
 TRACE_EVENT(ext4_sync_file_exit,
@@ -996,7 +996,7 @@ TRACE_EVENT(ext4_sync_file_exit,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	int,	ret			)
 	),
 
@@ -1006,9 +1006,9 @@ TRACE_EVENT(ext4_sync_file_exit,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev %d,%d ino %lu ret %d",
+	TP_printk("dev %d,%d ino %llu ret %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->ret)
 );
 
@@ -1040,7 +1040,7 @@ TRACE_EVENT(ext4_alloc_da_blocks,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field( unsigned int,	data_blocks		)
 	),
 
@@ -1050,9 +1050,9 @@ TRACE_EVENT(ext4_alloc_da_blocks,
 		__entry->data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 	),
 
-	TP_printk("dev %d,%d ino %lu reserved_data_blocks %u",
+	TP_printk("dev %d,%d ino %llu reserved_data_blocks %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->data_blocks)
 );
 
@@ -1063,7 +1063,7 @@ TRACE_EVENT(ext4_mballoc_alloc,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u32, 	orig_logical		)
 		__field(	  int,	orig_start		)
 		__field(	__u32, 	orig_group		)
@@ -1107,11 +1107,11 @@ TRACE_EVENT(ext4_mballoc_alloc,
 		__entry->cr		= ac->ac_criteria;
 	),
 
-	TP_printk("dev %d,%d inode %lu orig %u/%d/%u@%u goal %u/%d/%u@%u "
+	TP_printk("dev %d,%d inode %llu orig %u/%d/%u@%u goal %u/%d/%u@%u "
 		  "result %u/%d/%u@%u blks %u grps %u cr %s flags %s "
 		  "tail %u broken %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->orig_group, __entry->orig_start,
 		  __entry->orig_len, __entry->orig_logical,
 		  __entry->goal_group, __entry->goal_start,
@@ -1130,7 +1130,7 @@ TRACE_EVENT(ext4_mballoc_prealloc,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u32, 	orig_logical		)
 		__field(	  int,	orig_start		)
 		__field(	__u32, 	orig_group		)
@@ -1154,9 +1154,9 @@ TRACE_EVENT(ext4_mballoc_prealloc,
 		__entry->result_len	= ac->ac_b_ex.fe_len;
 	),
 
-	TP_printk("dev %d,%d inode %lu orig %u/%d/%u@%u result %u/%d/%u@%u",
+	TP_printk("dev %d,%d inode %llu orig %u/%d/%u@%u result %u/%d/%u@%u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->orig_group, __entry->orig_start,
 		  __entry->orig_len, __entry->orig_logical,
 		  __entry->result_group, __entry->result_start,
@@ -1174,7 +1174,7 @@ DECLARE_EVENT_CLASS(ext4__mballoc,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	  int,	result_start		)
 		__field(	__u32, 	result_group		)
 		__field(	  int,	result_len		)
@@ -1188,9 +1188,9 @@ DECLARE_EVENT_CLASS(ext4__mballoc,
 		__entry->result_len	= len;
 	),
 
-	TP_printk("dev %d,%d inode %lu extent %u/%d/%d ",
+	TP_printk("dev %d,%d inode %llu extent %u/%d/%d ",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->result_group, __entry->result_start,
 		  __entry->result_len)
 );
@@ -1224,7 +1224,7 @@ TRACE_EVENT(ext4_forget,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u64,	block			)
 		__field(	int,	is_metadata		)
 		__field(	__u16,	mode			)
@@ -1238,9 +1238,9 @@ TRACE_EVENT(ext4_forget,
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o is_metadata %d block %llu",
+	TP_printk("dev %d,%d ino %llu mode 0%o is_metadata %d block %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->mode, __entry->is_metadata, __entry->block)
 );
 
@@ -1251,7 +1251,7 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u64,	i_blocks		)
 		__field(	int,	used_blocks		)
 		__field(	int,	reserved_data_blocks	)
@@ -1270,10 +1270,10 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu used_blocks %d "
+	TP_printk("dev %d,%d ino %llu mode 0%o i_blocks %llu used_blocks %d "
 		  "reserved_data_blocks %d quota_claim %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->mode, __entry->i_blocks,
 		  __entry->used_blocks, __entry->reserved_data_blocks,
 		  __entry->quota_claim)
@@ -1286,7 +1286,7 @@ TRACE_EVENT(ext4_da_reserve_space,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u64,	i_blocks		)
 		__field(	int,	reserve_blocks		)
 		__field(	int,	reserved_data_blocks	)
@@ -1302,10 +1302,10 @@ TRACE_EVENT(ext4_da_reserve_space,
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu reserve_blocks %d"
+	TP_printk("dev %d,%d ino %llu mode 0%o i_blocks %llu reserve_blocks %d"
 		  "reserved_data_blocks %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->mode, __entry->i_blocks,
 		  __entry->reserve_blocks, __entry->reserved_data_blocks)
 );
@@ -1317,7 +1317,7 @@ TRACE_EVENT(ext4_da_release_space,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	__u64,	i_blocks		)
 		__field(	int,	freed_blocks		)
 		__field(	int,	reserved_data_blocks	)
@@ -1333,10 +1333,10 @@ TRACE_EVENT(ext4_da_release_space,
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu freed_blocks %d "
+	TP_printk("dev %d,%d ino %llu mode 0%o i_blocks %llu freed_blocks %d "
 		  "reserved_data_blocks %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->mode, __entry->i_blocks,
 		  __entry->freed_blocks, __entry->reserved_data_blocks)
 );
@@ -1413,7 +1413,7 @@ DECLARE_EVENT_CLASS(ext4__fallocate_mode,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	loff_t,	offset			)
 		__field(	loff_t, len			)
 		__field(	int,	mode			)
@@ -1427,9 +1427,9 @@ DECLARE_EVENT_CLASS(ext4__fallocate_mode,
 		__entry->mode	= mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu offset %lld len %lld mode %s",
+	TP_printk("dev %d,%d ino %llu offset %lld len %lld mode %s",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->offset, __entry->len,
 		  show_falloc_mode(__entry->mode))
 );
@@ -1463,7 +1463,7 @@ TRACE_EVENT(ext4_fallocate_exit,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	loff_t,	pos			)
 		__field(	unsigned int,	blocks		)
 		__field(	int, 	ret			)
@@ -1477,9 +1477,9 @@ TRACE_EVENT(ext4_fallocate_exit,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev %d,%d ino %lu pos %lld blocks %u ret %d",
+	TP_printk("dev %d,%d ino %llu pos %lld blocks %u ret %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->pos, __entry->blocks,
 		  __entry->ret)
 );
@@ -1491,8 +1491,8 @@ TRACE_EVENT(ext4_unlink_enter,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
-		__field(	ino_t,	parent			)
+		__field(	u64,	ino			)
+		__field(	u64,	parent			)
 		__field(	loff_t,	size			)
 	),
 
@@ -1503,10 +1503,10 @@ TRACE_EVENT(ext4_unlink_enter,
 		__entry->size		= d_inode(dentry)->i_size;
 	),
 
-	TP_printk("dev %d,%d ino %lu size %lld parent %lu",
+	TP_printk("dev %d,%d ino %llu size %lld parent %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->size,
-		  (unsigned long) __entry->parent)
+		  __entry->ino, __entry->size,
+		  __entry->parent)
 );
 
 TRACE_EVENT(ext4_unlink_exit,
@@ -1516,7 +1516,7 @@ TRACE_EVENT(ext4_unlink_exit,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	int,	ret			)
 	),
 
@@ -1526,9 +1526,9 @@ TRACE_EVENT(ext4_unlink_exit,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev %d,%d ino %lu ret %d",
+	TP_printk("dev %d,%d ino %llu ret %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->ret)
 );
 
@@ -1539,7 +1539,7 @@ DECLARE_EVENT_CLASS(ext4__truncate,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	__u64,		blocks		)
 	),
 
@@ -1549,9 +1549,9 @@ DECLARE_EVENT_CLASS(ext4__truncate,
 		__entry->blocks	= inode->i_blocks;
 	),
 
-	TP_printk("dev %d,%d ino %lu blocks %llu",
+	TP_printk("dev %d,%d ino %llu blocks %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->blocks)
+		  __entry->ino, __entry->blocks)
 );
 
 DEFINE_EVENT(ext4__truncate, ext4_truncate_enter,
@@ -1577,7 +1577,7 @@ TRACE_EVENT(ext4_ext_convert_to_initialized_enter,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
+		__field(	u64,		ino	)
 		__field(	ext4_lblk_t,	m_lblk	)
 		__field(	unsigned,	m_len	)
 		__field(	ext4_lblk_t,	u_lblk	)
@@ -1595,10 +1595,10 @@ TRACE_EVENT(ext4_ext_convert_to_initialized_enter,
 		__entry->u_pblk		= ext4_ext_pblock(ux);
 	),
 
-	TP_printk("dev %d,%d ino %lu m_lblk %u m_len %u u_lblk %u u_len %u "
+	TP_printk("dev %d,%d ino %llu m_lblk %u m_len %u u_lblk %u u_len %u "
 		  "u_pblk %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->m_lblk, __entry->m_len,
 		  __entry->u_lblk, __entry->u_len, __entry->u_pblk)
 );
@@ -1615,7 +1615,7 @@ TRACE_EVENT(ext4_ext_convert_to_initialized_fastpath,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
+		__field(	u64,		ino	)
 		__field(	ext4_lblk_t,	m_lblk	)
 		__field(	unsigned,	m_len	)
 		__field(	ext4_lblk_t,	u_lblk	)
@@ -1639,11 +1639,11 @@ TRACE_EVENT(ext4_ext_convert_to_initialized_fastpath,
 		__entry->i_pblk		= ext4_ext_pblock(ix);
 	),
 
-	TP_printk("dev %d,%d ino %lu m_lblk %u m_len %u "
+	TP_printk("dev %d,%d ino %llu m_lblk %u m_len %u "
 		  "u_lblk %u u_len %u u_pblk %llu "
 		  "i_lblk %u i_len %u i_pblk %llu ",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->m_lblk, __entry->m_len,
 		  __entry->u_lblk, __entry->u_len, __entry->u_pblk,
 		  __entry->i_lblk, __entry->i_len, __entry->i_pblk)
@@ -1657,7 +1657,7 @@ DECLARE_EVENT_CLASS(ext4__map_blocks_enter,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	ext4_lblk_t,	lblk		)
 		__field(	unsigned int,	len		)
 		__field(	unsigned int,	flags		)
@@ -1671,9 +1671,9 @@ DECLARE_EVENT_CLASS(ext4__map_blocks_enter,
 		__entry->flags	= flags;
 	),
 
-	TP_printk("dev %d,%d ino %lu lblk %u len %u flags %s",
+	TP_printk("dev %d,%d ino %llu lblk %u len %u flags %s",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->lblk, __entry->len, show_map_flags(__entry->flags))
 );
 
@@ -1699,7 +1699,7 @@ DECLARE_EVENT_CLASS(ext4__map_blocks_exit,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	unsigned int,	flags		)
 		__field(	ext4_fsblk_t,	pblk		)
 		__field(	ext4_lblk_t,	lblk		)
@@ -1719,10 +1719,10 @@ DECLARE_EVENT_CLASS(ext4__map_blocks_exit,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev %d,%d ino %lu flags %s lblk %u pblk %llu len %u "
+	TP_printk("dev %d,%d ino %llu flags %s lblk %u pblk %llu len %u "
 		  "mflags %s ret %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  show_map_flags(__entry->flags), __entry->lblk, __entry->pblk,
 		  __entry->len, show_mflags(__entry->mflags), __entry->ret)
 );
@@ -1748,7 +1748,7 @@ TRACE_EVENT(ext4_ext_load_extent,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	ext4_fsblk_t,	pblk		)
 		__field(	ext4_lblk_t,	lblk		)
 	),
@@ -1760,9 +1760,9 @@ TRACE_EVENT(ext4_ext_load_extent,
 		__entry->lblk	= lblk;
 	),
 
-	TP_printk("dev %d,%d ino %lu lblk %u pblk %llu",
+	TP_printk("dev %d,%d ino %llu lblk %u pblk %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->lblk, __entry->pblk)
 );
 
@@ -1773,7 +1773,7 @@ TRACE_EVENT(ext4_load_inode,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev		)
-		__field(	ino_t,	ino		)
+		__field(	u64,	ino		)
 	),
 
 	TP_fast_assign(
@@ -1781,9 +1781,9 @@ TRACE_EVENT(ext4_load_inode,
 		__entry->ino		= ino;
 	),
 
-	TP_printk("dev %d,%d ino %ld",
+	TP_printk("dev %d,%d ino %lld",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino)
+		  __entry->ino)
 );
 
 TRACE_EVENT(ext4_journal_start_sb,
@@ -1823,7 +1823,7 @@ TRACE_EVENT(ext4_journal_start_inode,
 	TP_ARGS(inode, blocks, rsv_blocks, revoke_creds, type, IP),
 
 	TP_STRUCT__entry(
-		__field(	unsigned long,	ino		)
+		__field(	u64,		ino		)
 		__field(	dev_t,		dev		)
 		__field(	unsigned long,	ip		)
 		__field(	int,		blocks		)
@@ -1843,9 +1843,10 @@ TRACE_EVENT(ext4_journal_start_inode,
 	),
 
 	TP_printk("dev %d,%d blocks %d, rsv_blocks %d, revoke_creds %d,"
-		  " type %d, ino %lu, caller %pS", MAJOR(__entry->dev),
+		  " type %d, ino %llu, caller %pS", MAJOR(__entry->dev),
 		  MINOR(__entry->dev), __entry->blocks, __entry->rsv_blocks,
-		  __entry->revoke_creds, __entry->type, __entry->ino,
+		  __entry->revoke_creds, __entry->type,
+		  (unsigned long long) __entry->ino,
 		  (void *)__entry->ip)
 );
 
@@ -1928,7 +1929,7 @@ TRACE_EVENT(ext4_ext_handle_unwritten_extents,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	int,		flags		)
 		__field(	ext4_lblk_t,	lblk		)
 		__field(	ext4_fsblk_t,	pblk		)
@@ -1948,10 +1949,10 @@ TRACE_EVENT(ext4_ext_handle_unwritten_extents,
 		__entry->newblk		= newblock;
 	),
 
-	TP_printk("dev %d,%d ino %lu m_lblk %u m_pblk %llu m_len %u flags %s "
+	TP_printk("dev %d,%d ino %llu m_lblk %u m_pblk %llu m_len %u flags %s "
 		  "allocated %d newblock %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  (unsigned) __entry->lblk, (unsigned long long) __entry->pblk,
 		  __entry->len, show_map_flags(__entry->flags),
 		  (unsigned int) __entry->allocated,
@@ -1995,7 +1996,7 @@ TRACE_EVENT(ext4_ext_show_extent,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
+		__field(	u64,		ino	)
 		__field(	ext4_fsblk_t,	pblk	)
 		__field(	ext4_lblk_t,	lblk	)
 		__field(	unsigned short,	len	)
@@ -2009,9 +2010,9 @@ TRACE_EVENT(ext4_ext_show_extent,
 		__entry->len	= len;
 	),
 
-	TP_printk("dev %d,%d ino %lu lblk %u pblk %llu len %u",
+	TP_printk("dev %d,%d ino %llu lblk %u pblk %llu len %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  (unsigned) __entry->lblk,
 		  (unsigned long long) __entry->pblk,
 		  (unsigned short) __entry->len)
@@ -2026,7 +2027,7 @@ TRACE_EVENT(ext4_remove_blocks,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
+		__field(	u64,		ino	)
 		__field(	ext4_lblk_t,	from	)
 		__field(	ext4_lblk_t,	to	)
 		__field(	ext4_fsblk_t,	ee_pblk	)
@@ -2050,10 +2051,10 @@ TRACE_EVENT(ext4_remove_blocks,
 		__entry->pc_state	= pc->state;
 	),
 
-	TP_printk("dev %d,%d ino %lu extent [%u(%llu), %u]"
+	TP_printk("dev %d,%d ino %llu extent [%u(%llu), %u]"
 		  "from %u to %u partial [pclu %lld lblk %u state %d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  (unsigned) __entry->ee_lblk,
 		  (unsigned long long) __entry->ee_pblk,
 		  (unsigned short) __entry->ee_len,
@@ -2073,7 +2074,7 @@ TRACE_EVENT(ext4_ext_rm_leaf,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
+		__field(	u64,		ino	)
 		__field(	ext4_lblk_t,	start	)
 		__field(	ext4_lblk_t,	ee_lblk	)
 		__field(	ext4_fsblk_t,	ee_pblk	)
@@ -2095,10 +2096,10 @@ TRACE_EVENT(ext4_ext_rm_leaf,
 		__entry->pc_state	= pc->state;
 	),
 
-	TP_printk("dev %d,%d ino %lu start_lblk %u last_extent [%u(%llu), %u]"
+	TP_printk("dev %d,%d ino %llu start_lblk %u last_extent [%u(%llu), %u]"
 		  "partial [pclu %lld lblk %u state %d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  (unsigned) __entry->start,
 		  (unsigned) __entry->ee_lblk,
 		  (unsigned long long) __entry->ee_pblk,
@@ -2115,7 +2116,7 @@ TRACE_EVENT(ext4_ext_rm_idx,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
+		__field(	u64,		ino	)
 		__field(	ext4_fsblk_t,	pblk	)
 	),
 
@@ -2125,9 +2126,9 @@ TRACE_EVENT(ext4_ext_rm_idx,
 		__entry->pblk	= pblk;
 	),
 
-	TP_printk("dev %d,%d ino %lu index_pblk %llu",
+	TP_printk("dev %d,%d ino %llu index_pblk %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  (unsigned long long) __entry->pblk)
 );
 
@@ -2139,7 +2140,7 @@ TRACE_EVENT(ext4_ext_remove_space,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
+		__field(	u64,		ino	)
 		__field(	ext4_lblk_t,	start	)
 		__field(	ext4_lblk_t,	end	)
 		__field(	int,		depth	)
@@ -2153,9 +2154,9 @@ TRACE_EVENT(ext4_ext_remove_space,
 		__entry->depth	= depth;
 	),
 
-	TP_printk("dev %d,%d ino %lu since %u end %u depth %d",
+	TP_printk("dev %d,%d ino %llu since %u end %u depth %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  (unsigned) __entry->start,
 		  (unsigned) __entry->end,
 		  __entry->depth)
@@ -2169,7 +2170,7 @@ TRACE_EVENT(ext4_ext_remove_space_done,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	ext4_lblk_t,	start		)
 		__field(	ext4_lblk_t,	end		)
 		__field(	int,		depth		)
@@ -2191,11 +2192,11 @@ TRACE_EVENT(ext4_ext_remove_space_done,
 		__entry->eh_entries	= le16_to_cpu(eh_entries);
 	),
 
-	TP_printk("dev %d,%d ino %lu since %u end %u depth %d "
+	TP_printk("dev %d,%d ino %llu since %u end %u depth %d "
 		  "partial [pclu %lld lblk %u state %d] "
 		  "remaining_entries %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  (unsigned) __entry->start,
 		  (unsigned) __entry->end,
 		  __entry->depth,
@@ -2212,7 +2213,7 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	ext4_lblk_t,	lblk		)
 		__field(	ext4_lblk_t,	len		)
 		__field(	ext4_fsblk_t,	pblk		)
@@ -2230,9 +2231,9 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 		__entry->seq	= EXT4_I(inode)->i_es_seq;
 	),
 
-	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s seq %llu",
+	TP_printk("dev %d,%d ino %llu es [%u/%u) mapped %llu status %s seq %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->lblk, __entry->len,
 		  __entry->pblk, show_extent_status(__entry->status),
 		  __entry->seq)
@@ -2257,7 +2258,7 @@ TRACE_EVENT(ext4_es_remove_extent,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	u64,	ino			)
 		__field(	loff_t,	lblk			)
 		__field(	loff_t,	len			)
 		__field(	u64,	seq			)
@@ -2271,9 +2272,9 @@ TRACE_EVENT(ext4_es_remove_extent,
 		__entry->seq	= EXT4_I(inode)->i_es_seq;
 	),
 
-	TP_printk("dev %d,%d ino %lu es [%lld/%lld) seq %llu",
+	TP_printk("dev %d,%d ino %llu es [%lld/%lld) seq %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->lblk, __entry->len, __entry->seq)
 );
 
@@ -2284,7 +2285,7 @@ TRACE_EVENT(ext4_es_find_extent_range_enter,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	ext4_lblk_t,	lblk		)
 	),
 
@@ -2294,9 +2295,9 @@ TRACE_EVENT(ext4_es_find_extent_range_enter,
 		__entry->lblk	= lblk;
 	),
 
-	TP_printk("dev %d,%d ino %lu lblk %u",
+	TP_printk("dev %d,%d ino %llu lblk %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->lblk)
+		  __entry->ino, __entry->lblk)
 );
 
 TRACE_EVENT(ext4_es_find_extent_range_exit,
@@ -2306,7 +2307,7 @@ TRACE_EVENT(ext4_es_find_extent_range_exit,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	ext4_lblk_t,	lblk		)
 		__field(	ext4_lblk_t,	len		)
 		__field(	ext4_fsblk_t,	pblk		)
@@ -2322,9 +2323,9 @@ TRACE_EVENT(ext4_es_find_extent_range_exit,
 		__entry->status	= ext4_es_status(es);
 	),
 
-	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s",
+	TP_printk("dev %d,%d ino %llu es [%u/%u) mapped %llu status %s",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->lblk, __entry->len,
 		  __entry->pblk, show_extent_status(__entry->status))
 );
@@ -2336,7 +2337,7 @@ TRACE_EVENT(ext4_es_lookup_extent_enter,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	ext4_lblk_t,	lblk		)
 	),
 
@@ -2346,9 +2347,9 @@ TRACE_EVENT(ext4_es_lookup_extent_enter,
 		__entry->lblk	= lblk;
 	),
 
-	TP_printk("dev %d,%d ino %lu lblk %u",
+	TP_printk("dev %d,%d ino %llu lblk %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->lblk)
+		  __entry->ino, __entry->lblk)
 );
 
 TRACE_EVENT(ext4_es_lookup_extent_exit,
@@ -2359,7 +2360,7 @@ TRACE_EVENT(ext4_es_lookup_extent_exit,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	ext4_lblk_t,	lblk		)
 		__field(	ext4_lblk_t,	len		)
 		__field(	ext4_fsblk_t,	pblk		)
@@ -2377,9 +2378,9 @@ TRACE_EVENT(ext4_es_lookup_extent_exit,
 		__entry->found	= found;
 	),
 
-	TP_printk("dev %d,%d ino %lu found %d [%u/%u) %llu %s",
+	TP_printk("dev %d,%d ino %llu found %d [%u/%u) %llu %s",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->found,
+		  __entry->ino, __entry->found,
 		  __entry->lblk, __entry->len,
 		  __entry->found ? __entry->pblk : 0,
 		  show_extent_status(__entry->found ? __entry->status : 0))
@@ -2448,7 +2449,7 @@ TRACE_EVENT(ext4_collapse_range,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	offset)
 		__field(loff_t, len)
 	),
@@ -2460,9 +2461,9 @@ TRACE_EVENT(ext4_collapse_range,
 		__entry->len	= len;
 	),
 
-	TP_printk("dev %d,%d ino %lu offset %lld len %lld",
+	TP_printk("dev %d,%d ino %llu offset %lld len %lld",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->offset, __entry->len)
 );
 
@@ -2473,7 +2474,7 @@ TRACE_EVENT(ext4_insert_range,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	offset)
 		__field(loff_t, len)
 	),
@@ -2485,9 +2486,9 @@ TRACE_EVENT(ext4_insert_range,
 		__entry->len	= len;
 	),
 
-	TP_printk("dev %d,%d ino %lu offset %lld len %lld",
+	TP_printk("dev %d,%d ino %llu offset %lld len %lld",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->offset, __entry->len)
 );
 
@@ -2527,7 +2528,7 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
+		__field(	u64,		ino		)
 		__field(	ext4_lblk_t,	lblk		)
 		__field(	ext4_lblk_t,	len		)
 		__field(	ext4_fsblk_t,	pblk		)
@@ -2549,9 +2550,9 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
 		__entry->seq		= EXT4_I(inode)->i_es_seq;
 	),
 
-	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s allocated %d %d seq %llu",
+	TP_printk("dev %d,%d ino %llu es [%u/%u) mapped %llu status %s allocated %d %d seq %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
+		  __entry->ino,
 		  __entry->lblk, __entry->len,
 		  __entry->pblk, show_extent_status(__entry->status),
 		  __entry->lclu_allocated, __entry->end_allocated,
@@ -2877,7 +2878,7 @@ DECLARE_EVENT_CLASS(ext4_fc_track_dentry,
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(tid_t, t_tid)
-		__field(ino_t, i_ino)
+		__field(u64, i_ino)
 		__field(tid_t, i_sync_tid)
 		__field(int, error)
 	),
@@ -2892,7 +2893,7 @@ DECLARE_EVENT_CLASS(ext4_fc_track_dentry,
 		__entry->error = ret;
 	),
 
-	TP_printk("dev %d,%d, t_tid %u, ino %lu, i_sync_tid %u, error %d",
+	TP_printk("dev %d,%d, t_tid %u, ino %llu, i_sync_tid %u, error %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->t_tid, __entry->i_ino, __entry->i_sync_tid,
 		  __entry->error
@@ -2918,7 +2919,7 @@ TRACE_EVENT(ext4_fc_track_inode,
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(tid_t, t_tid)
-		__field(ino_t, i_ino)
+		__field(u64, i_ino)
 		__field(tid_t, i_sync_tid)
 		__field(int, error)
 	),
@@ -2933,7 +2934,7 @@ TRACE_EVENT(ext4_fc_track_inode,
 		__entry->error = ret;
 	),
 
-	TP_printk("dev %d:%d, t_tid %u, inode %lu, i_sync_tid %u, error %d",
+	TP_printk("dev %d:%d, t_tid %u, inode %llu, i_sync_tid %u, error %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->t_tid, __entry->i_ino, __entry->i_sync_tid,
 		  __entry->error)
@@ -2948,7 +2949,7 @@ TRACE_EVENT(ext4_fc_track_range,
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(tid_t, t_tid)
-		__field(ino_t, i_ino)
+		__field(u64, i_ino)
 		__field(tid_t, i_sync_tid)
 		__field(long, start)
 		__field(long, end)
@@ -2967,7 +2968,7 @@ TRACE_EVENT(ext4_fc_track_range,
 		__entry->error = ret;
 	),
 
-	TP_printk("dev %d:%d, t_tid %u, inode %lu, i_sync_tid %u, error %d, start %ld, end %ld",
+	TP_printk("dev %d:%d, t_tid %u, inode %llu, i_sync_tid %u, error %d, start %ld, end %ld",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->t_tid, __entry->i_ino, __entry->i_sync_tid,
 		  __entry->error, __entry->start, __entry->end)
@@ -3030,10 +3031,10 @@ TRACE_EVENT(ext4_move_extent_enter,
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
-		__field(ino_t, orig_ino)
+		__field(u64, orig_ino)
 		__field(ext4_lblk_t, orig_lblk)
 		__field(unsigned int, orig_flags)
-		__field(ino_t, donor_ino)
+		__field(u64, donor_ino)
 		__field(ext4_lblk_t, donor_lblk)
 		__field(unsigned int, len)
 	),
@@ -3048,11 +3049,11 @@ TRACE_EVENT(ext4_move_extent_enter,
 		__entry->len		= orig_map->m_len;
 	),
 
-	TP_printk("dev %d,%d origin ino %lu lblk %u flags %s donor ino %lu lblk %u len %u",
+	TP_printk("dev %d,%d origin ino %llu lblk %u flags %s donor ino %llu lblk %u len %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->orig_ino,  __entry->orig_lblk,
+		  __entry->orig_ino,  __entry->orig_lblk,
 		  show_mflags(__entry->orig_flags),
-		  (unsigned long) __entry->donor_ino,  __entry->donor_lblk,
+		  __entry->donor_ino,  __entry->donor_lblk,
 		  __entry->len)
 );
 
@@ -3066,9 +3067,9 @@ TRACE_EVENT(ext4_move_extent_exit,
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
-		__field(ino_t, orig_ino)
+		__field(u64, orig_ino)
 		__field(ext4_lblk_t, orig_lblk)
-		__field(ino_t, donor_ino)
+		__field(u64, donor_ino)
 		__field(ext4_lblk_t, donor_lblk)
 		__field(unsigned int, m_len)
 		__field(u64, move_len)
@@ -3088,10 +3089,10 @@ TRACE_EVENT(ext4_move_extent_exit,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev %d,%d origin ino %lu lblk %u donor ino %lu lblk %u m_len %u, move_len %llu type %d ret %d",
+	TP_printk("dev %d,%d origin ino %llu lblk %u donor ino %llu lblk %u m_len %u, move_len %llu type %d ret %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->orig_ino,  __entry->orig_lblk,
-		  (unsigned long) __entry->donor_ino,  __entry->donor_lblk,
+		  __entry->orig_ino,  __entry->orig_lblk,
+		  __entry->donor_ino,  __entry->donor_lblk,
 		  __entry->m_len, __entry->move_len, __entry->move_type,
 		  __entry->ret)
 );

-- 
2.53.0


