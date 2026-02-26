Return-Path: <linux-fsdevel+bounces-78548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNj8I3F7oGmMkAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:57:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0125A1AB6EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DF463300148
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03BE426D16;
	Thu, 26 Feb 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivmk1v7V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975F4266AF;
	Thu, 26 Feb 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121679; cv=none; b=osp64N8X/yuTjh/W7eTIvYJ03RiyKFxX5oumahLKVifO3WzgEqK6ZnMdntFsAvXiolRB65DeqY5g9xGXI1TSCG58tC4z1hjOQ1Ofx73VYQkK2+dlkKO+ZMWy85EqPpOGyi5PY1d13Re9Vv9QzPMIOjrc9XY1lwTLHIBqbHOLzJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121679; c=relaxed/simple;
	bh=MwavyxIYlS9bWn9ErxsqoDmGcaV0lMqgZ3OvxFOJWq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NdFjfpPeDZSIwCqbpf1CXkZRlR6rXp6RB9f1C6yQiLGLF6l9vwIW0xlwEtCsiDqu1u1gkKmbnqQ63Gnuq/ZYvKcp1xh3xa18rXtJ15MK6jTQA7kczNN4iOhWroCST8N3h2Jt9Wdq1/0oOujQadSfqRh226agahIPqCJZJIm9kyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivmk1v7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AE2C2BCB4;
	Thu, 26 Feb 2026 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121679;
	bh=MwavyxIYlS9bWn9ErxsqoDmGcaV0lMqgZ3OvxFOJWq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ivmk1v7V3CJiICUlcp+XecxQ8lV8EsvWNHo7eR+YxOQbmYtedtALPPtlvxelp6hjh
	 en8jABiMzMb/OrtCHXYcM4ik86k8b/NdKS6iQNsceskhDSrUAGrthU+Mluo9Y3k5OY
	 hLGGzCNMcAx+HcJMRHPgHxCwW6zWxH6VTPO2mshnW9Ta5etwpt94k3KwJKKWDvu9ZO
	 wzvN5qcZ0hcx3Fb9eoFa+y7vAEMv+EMzEtIsC5mu61EwaXjr9g30suDQA0zhULrwLi
	 r1tYEXKRj5sFs5LaOuPmEij4Gg2A3MbYdnp+GKNGqW6icNTxudYs2jchlG7ZcVlSJW
	 TlOBjKksVvQ6A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:26 -0500
Subject: [PATCH 24/61] cachefiles: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-24-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4391; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MwavyxIYlS9bWn9ErxsqoDmGcaV0lMqgZ3OvxFOJWq0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0KNFRsbW5kG/p9PtFPpXWeEzWzPxJtHpHVp
 a6torUfDXmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtCgAKCRAADmhBGVaC
 FbHIEACZSDMJAqAwQ0UXgiwJ0jC+ChGbMCd/Sa5yBvlpCfjSmkn4n6HEjHw/4s1+fMmd0m/LwmE
 8jH1uSEVla1iJBWmZN4Xmpo5/oGmeKxuCJiBT+T//EpjIq1eV366Wwlq7KQ+yOwNIpAewI1OK4N
 PRlmobIu63prMJmjcVGhaMWtjg/olAgXr+44X79kcORF1excabF2OOgoAE237OZrMV/pXS/EyUw
 cRh+8Bqx0o/fII34tA4kAWOou4JBmxxBQGz7pB1yGKxbzrM/hUf1apOp6sY1tIB/EHW+XUJ1135
 UimmosoXllhYTYz7gsjIEu9frAYnYwXkrfuEUag+2PAjWfNTIqHI8PxPEuTcmY6erOvzxw88LzW
 jsGnRh3iUm7XUez/cpw0Ara59XzP/RWYuRYzwSLHWaub8hRyUrvdC/6X6DMrvMmABzLvFNoXMum
 U+NXn/y/d8sMb1KpWcJZtq8Fh4VtPJi9afupJhGnOXq+JGgNjjpUhCxAd3M1JBxNo/ueFIhhIbb
 wwcyV7LsjMJhwseMYJqWooz6vpkd/aGCbLkFfbdVky/iO7E0YpZ10MzPRZpsqsOpn9pAxtkPhh+
 EucWjJg2UwqxM6ydVT7EBx2NgQD6V+NpF2Mg83BX551O6BuZMAl01ktREHrwHp3YwbqnlZsQdVI
 BaUUCgERHQ6vaqA==
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
	TAGGED_FROM(0.00)[bounces-78548-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0125A1AB6EF
X-Rspamd-Action: no action

Update format strings and local variable types in cachefiles for the
i_ino type change from unsigned long to u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cachefiles/io.c    |  6 +++---
 fs/cachefiles/namei.c | 12 ++++++------
 fs/cachefiles/xattr.c |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index eaf47851c65f4736a7a27f13c498028c7c8dd1b4..d879b80a0bedc95533ce05361ed8cb79c7ed3826 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -93,7 +93,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	object = cachefiles_cres_object(cres);
 	file = cachefiles_cres_file(cres);
 
-	_enter("%pD,%li,%llx,%zx/%llx",
+	_enter("%pD,%llu,%llx,%zx/%llx",
 	       file, file_inode(file)->i_ino, start_pos, len,
 	       i_size_read(file_inode(file)));
 
@@ -214,7 +214,7 @@ static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
 	file = cachefiles_cres_file(cres);
 	granularity = max_t(size_t, object->volume->cache->bsize, granularity);
 
-	_enter("%pD,%li,%llx,%zx/%llx",
+	_enter("%pD,%llu,%llx,%zx/%llx",
 	       file, file_inode(file)->i_ino, start, len,
 	       i_size_read(file_inode(file)));
 
@@ -294,7 +294,7 @@ int __cachefiles_write(struct cachefiles_object *object,
 	fscache_count_write();
 	cache = object->volume->cache;
 
-	_enter("%pD,%li,%llx,%zx/%llx",
+	_enter("%pD,%llu,%llx,%zx/%llx",
 	       file, file_inode(file)->i_ino, start_pos, len,
 	       i_size_read(file_inode(file)));
 
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index e5ec90dccc27f71dc19219f7632f3e48eaf51545..4fdf7687aacb8285ae38d9b5d7e5129897b3ca03 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -147,7 +147,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		}
 		ASSERT(d_backing_inode(subdir));
 
-		_debug("mkdir -> %pd{ino=%lu}",
+		_debug("mkdir -> %pd{ino=%llu}",
 		       subdir, d_backing_inode(subdir)->i_ino);
 		if (_is_new)
 			*_is_new = true;
@@ -158,7 +158,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	end_creating_keep(subdir);
 
 	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
-		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
+		pr_notice("cachefiles: Inode already in use: %pd (B=%llx)\n",
 			  subdir, d_inode(subdir)->i_ino);
 		goto mark_error;
 	}
@@ -183,7 +183,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	    !d_backing_inode(subdir)->i_op->unlink)
 		goto check_error;
 
-	_leave(" = [%lu]", d_backing_inode(subdir)->i_ino);
+	_leave(" = [%llu]", d_backing_inode(subdir)->i_ino);
 	return subdir;
 
 check_error:
@@ -529,7 +529,7 @@ static bool cachefiles_create_file(struct cachefiles_object *object)
 
 	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
 	set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
-	_debug("create -> %pD{ino=%lu}", file, file_inode(file)->i_ino);
+	_debug("create -> %pD{ino=%llu}", file, file_inode(file)->i_ino);
 	object->file = file;
 	return true;
 }
@@ -549,7 +549,7 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	_enter("%pd", dentry);
 
 	if (!cachefiles_mark_inode_in_use(object, d_inode(dentry))) {
-		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
+		pr_notice("cachefiles: Inode already in use: %pd (B=%llx)\n",
 			  dentry, d_inode(dentry)->i_ino);
 		return false;
 	}
@@ -657,7 +657,7 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 	if (!ret)
 		return false;
 
-	_leave(" = t [%lu]", file_inode(object->file)->i_ino);
+	_leave(" = t [%llu]", file_inode(object->file)->i_ino);
 	return true;
 
 new_file:
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 52383b1d0ba63d4a09413177d8c0d841b5b5b43c..f8ae78b3f7b6d368526a86b454bf0febd1ccc509 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -179,7 +179,7 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 			ret = 0;
 		else if (ret != -ENOMEM)
 			cachefiles_io_error(cache,
-					    "Can't remove xattr from %lu"
+					    "Can't remove xattr from %llu"
 					    " (error %d)",
 					    d_backing_inode(dentry)->i_ino, -ret);
 	}

-- 
2.53.0


