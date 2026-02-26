Return-Path: <linux-fsdevel+bounces-78581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGh9C0iEoGkakgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:35:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD231AC883
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C08E331C6271
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0144F7988;
	Thu, 26 Feb 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/iU9fkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C135C44A708;
	Thu, 26 Feb 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122092; cv=none; b=DqFcuQM6a5D1YU0tzA1qtQ/S8n2nP/cs0mgMVmgV9KBbr7VefhamZQ6LKGUdL/46D7RVrTTiZ1tEaXAQE6szPT81Do2nu5zWptR/B8EnQDmxJLxLzzzIv/HeglNhKuF9eKG8yXDI7o/OTmM4q3lmHT3YtcpPa1J22VGzGEa9xhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122092; c=relaxed/simple;
	bh=QVP/A0Wr2Abx3BWIf3M/CTqVpPmV8SXmSE5S4tBQdB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQNUMUdsJVrKC5w4nf7TxSTvrn2NJ+dSXj1Amyv+KaPd0Wx2uvUQXFMb/CysYccgz5BjA6qXjcLuJDglO4k9OEM+SIoeZsLT307g+8bA1Sc4q6Ef/IUqpeqv6MP89QREqc0vZIUqwY2aI6aNKwr6qbB0VcYmBwKAXqxStWbRxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/iU9fkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC59C19423;
	Thu, 26 Feb 2026 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122091;
	bh=QVP/A0Wr2Abx3BWIf3M/CTqVpPmV8SXmSE5S4tBQdB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N/iU9fkY7C+X0gBA8Fi8wI+B9cgJ3ZSt6kN4EuqYE+eP8vng3qyDWNfsyIhvtKLdH
	 b+b4Aulfg3FxrO0Nm/YcWTCOcXO8KCjAYbQRgQ7mVqFUqT4sm4WDf0eBVloGkV76Qr
	 nzuEqM5tBQz8ltYFpBlQxn9/JiVP72na6rLnacqYsI4nNdpxGTgdAMyZLHYRXq/4hX
	 iUesVZMqUqLc1V+1j2OQrGrDnS19dzjRGvGlWMVyWmletccEF567lF82pATRt0e1O/
	 TjpBPU5Ieg1IbZKo5hjqzncuK/qa9dvo9N2Li7BzU0aNxcuEYodPJfkpyZdtWwQ3zU
	 M4VIYqh/JOBMg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:59 -0500
Subject: [PATCH 57/61] fscrypt: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-57-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QVP/A0Wr2Abx3BWIf3M/CTqVpPmV8SXmSE5S4tBQdB8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0Sq+j7M9feeeWsEEfnIcsU2CbAxEDqyZD2b
 80+R1w14vOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtEgAKCRAADmhBGVaC
 FVKJEAC5sid11Go6fuJI7CWXgk/4O9Urmq5+faYtXDswS3e3Xney5z3y6yARF5s8jF6mfhgzQla
 vQ5vaTZ4z5mXQy/RAzR9sUFhWtITbMTuDCT5t/OkYsBp8k7TwPqeEVypA51Ep4SVoYatBJBiLQf
 2fat2kabGqKEdxfCFhYZ/T/0dQV3iRAt9D43qR/WxIm6MSoTlo9YHWCG91yTvgD0CJW04McaD9e
 nABf28Ev6HbF1zoK9hLfjRiwAC29acMvnrI3Im5gXXzJ3e46OOwusoMZtJhXXd2agPTunLgXcRl
 +/ycDsR+Tty6dLu6VAPvTR3bnQezZb781kcYoTcQIWu/ddCkKz0VN6tP3bv0JkLuXRGp5oMuJvs
 FLd0RNjIJ8Ld9Cxg6Okd724968ObOXOBed5IGmMNSiyI1onguOK2GPh5Y4UcuvhDl3Hb9B3YLPv
 GQoEkhHN0x/lNXU8GCxcaTPkOHjEdaymP6yleBH4f2aw30WmtBhphVmnABJ3EIHcDVimT+dukC3
 7UJg7jQn/8YGDHpTw5kC/uLPLgLMuwHYtsmRsnrvs61gYC+3Qtk3Y7gYe4FIJx76xaByCFyzY87
 rBIQo95KFdLZQVVKUfEH8H44JnZ0KGwlz9muKgqItA3T9f5veP4BQOKpi5i+iTywd4a4kYDOPcK
 EQzZuVxQyu+fRsA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78581-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 7DD231AC883
X-Rspamd-Action: no action

Update format strings from %lu to %llu for inode->i_ino now that
i_ino is u64 instead of unsigned long.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/crypto.c   | 2 +-
 fs/crypto/hooks.c    | 2 +-
 fs/crypto/keysetup.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 07f9cbfe3ea4115b8fcc881ae5154b3c3e898c04..570a2231c945a6c649cf8dc3b457f0b55657e0c3 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -365,7 +365,7 @@ void fscrypt_msg(const struct inode *inode, const char *level,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	if (inode && inode->i_ino)
-		printk("%sfscrypt (%s, inode %lu): %pV\n",
+		printk("%sfscrypt (%s, inode %llu): %pV\n",
 		       level, inode->i_sb->s_id, inode->i_ino, &vaf);
 	else if (inode)
 		printk("%sfscrypt (%s): %pV\n", level, inode->i_sb->s_id, &vaf);
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index b97de0d1430fd6ec764f4a758dffe00263496118..a7a8a3f581a0460537f5ff955bc8b5d30573a033 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -62,7 +62,7 @@ int fscrypt_file_open(struct inode *inode, struct file *filp)
 	dentry_parent = dget_parent(dentry);
 	if (!fscrypt_has_permitted_context(d_inode(dentry_parent), inode)) {
 		fscrypt_warn(inode,
-			     "Inconsistent encryption context (parent directory: %lu)",
+			     "Inconsistent encryption context (parent directory: %llu)",
 			     d_inode(dentry_parent)->i_ino);
 		err = -EPERM;
 	}
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 40fa05688d3a1d4aa33d29e9508441faf4bca933..df58ca4a5e3cb1df94e2f08e3f3b093c33368993 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -91,7 +91,7 @@ select_encryption_mode(const union fscrypt_policy *policy,
 	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
 		return &fscrypt_modes[fscrypt_policy_fnames_mode(policy)];
 
-	WARN_ONCE(1, "fscrypt: filesystem tried to load encryption info for inode %lu, which is not encryptable (file type %d)\n",
+	WARN_ONCE(1, "fscrypt: filesystem tried to load encryption info for inode %llu, which is not encryptable (file type %d)\n",
 		  inode->i_ino, (inode->i_mode & S_IFMT));
 	return ERR_PTR(-EINVAL);
 }

-- 
2.53.0


