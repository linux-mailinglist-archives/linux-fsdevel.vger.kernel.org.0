Return-Path: <linux-fsdevel+bounces-78572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB9ZGKp+oGlgkQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:11:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC111ABDCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0168322BB16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425914C6EE8;
	Thu, 26 Feb 2026 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+nkvjU5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5F4C8FEB;
	Thu, 26 Feb 2026 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121979; cv=none; b=EOJiVw4i50jJgqJUrlvnX9biWlk3HpCNupGy6TucTbjRkYh3QwmKlRAo+2oNYqHlj9wyG4BUcJ83PDJPyEyIki0AIm5h4Ry1ZmiISkPU30acyfmGluh/oyoK6fp3U3YXG633PqjqR7jTYxOhwpmCin4jczmvGWnKEzLCVNrV/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121979; c=relaxed/simple;
	bh=iU6e4zeAj5z40Ah35aY1Jl4/4X7n705dfCUksW8kFiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLH3OCQRtR6gEnwR/L6zPv/i1nhgD0fJGzDXtObZ215TypAo0zYecoJvHrPSQZgS/oluSr8BCHPhtuXPyRAtejTvftHt2RZS1nFI94SeA5dz7SpoquoX7UWn7iC5Ub7ByzHSsxEI9G2E8W+Bzo6qYD8wUM5otPefKJ9rRhTElR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+nkvjU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79300C19424;
	Thu, 26 Feb 2026 16:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121978;
	bh=iU6e4zeAj5z40Ah35aY1Jl4/4X7n705dfCUksW8kFiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q+nkvjU5PH9beX1sDz7TCsGU59b7gNRW0L4FVkS1TxbYVf2dxcTYZJCdahq16kk8H
	 KhaF7luPDMrHsoDLihiy3XRwGzOhdOHklTnXTFqiUNpk9xbeIbuZAXIZiVyQMJUHSs
	 0thfIptMhvoCgjCV8rtksyKLzyK8Qzl8TlINr01NDAKGOnLMWvK4vMPzhZ9cZiOZWE
	 EEYxRFbvgEkMHUz7/plm1zhg2LD/iDkTpgEDUXEFFyYjaOR485LQ5gBJhchKq9Q8II
	 0xuI2i6blS7+c1UFIt43sTJQyGkoA4wxF3SzrVEbxy7kPXrqL0o+2XnZfs2mSyR2Ph
	 K/arfLmyIBGmA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:50 -0500
Subject: [PATCH 48/61] udf: update format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-48-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9281; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=iU6e4zeAj5z40Ah35aY1Jl4/4X7n705dfCUksW8kFiQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0QDnCya8A+2cJJ9pOZSFdmxegEJ3eymi5BG
 766eHMtgmuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtEAAKCRAADmhBGVaC
 FcOYD/9P5pWzfQuRUb6+cBoUCHAhFB70OfFIZwuhgN2vnyZxuw5DlmpjeZfqLSA0uIv2wWBNue2
 qADCpMu+cQZe7F/XaXtUplsygzoq1jIFrtkQypp0Z+/w4UVy73Ikr0a0FXrxLVb3/PMjGHNjM7I
 HoDBWjU1befct4Gd4Cvj20PsB7hm3cY9Qwgm8aGn9ORDjyxvTDZrYxI0snho0Bb9BwNiSFTgdu+
 IzsGRpgoRHbAGA2P9OYczBisozKER7UrMkmqSq9kEvC/zF3jQKjbu5H2xrIpXoDeIipoVF3Kq7D
 kwztabjrqa1iR6NfOF4vMbZmIH7HWtrTr92NwUqfw1E+WTuhXl5dM3EzFR/wqmq6jtVd+O1BMBK
 GRNphZPulnGgW8MdhkHr1WhB6IHdTR2g4Gudbk+Zv5UWwX22+MJfr8nc1/ZaABnU00y1beP4qsW
 zT9of6iaDj4AKxUu4o7GYQ9sPeBpdmDT0ViCr5VWGhbX0u/G8p5d8Xt0xT+zUhigfodUnB/3vuU
 zFB6gNo9T6YyGZLlImQhBNEjuv7RahinrrNVQCJGpORKjmO/Ss+Un5OBeUhaOtrQ8GgkqaZ1Fio
 X4h0O7SeOcQbTwUOeZVbbr6i8aX6UtXfQkW/WVdQRtelo3zV0z5P/4v9ET4BRLNDCFVcmVjGz73
 K6a3u+3nNCsAr9Q==
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
	TAGGED_FROM(0.00)[bounces-78572-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 6EC111ABDCE
X-Rspamd-Action: no action

Update format strings and local variable types in udf for the
i_ino type change from unsigned long to u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/udf/directory.c | 18 +++++++++---------
 fs/udf/file.c      |  2 +-
 fs/udf/inode.c     | 12 ++++++------
 fs/udf/namei.c     |  8 ++++----
 fs/udf/super.c     |  2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 632453aa38934a0b58b420717ec0674c85627ce5..f5c81e13eacb17f931d2df564ec4f2a6e9a5d7ab 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -22,7 +22,7 @@ static int udf_verify_fi(struct udf_fileident_iter *iter)
 
 	if (iter->fi.descTag.tagIdent != cpu_to_le16(TAG_IDENT_FID)) {
 		udf_err(iter->dir->i_sb,
-			"directory (ino %lu) has entry at pos %llu with incorrect tag %x\n",
+			"directory (ino %llu) has entry at pos %llu with incorrect tag %x\n",
 			iter->dir->i_ino, (unsigned long long)iter->pos,
 			le16_to_cpu(iter->fi.descTag.tagIdent));
 		return -EFSCORRUPTED;
@@ -30,7 +30,7 @@ static int udf_verify_fi(struct udf_fileident_iter *iter)
 	len = udf_dir_entry_len(&iter->fi);
 	if (le16_to_cpu(iter->fi.lengthOfImpUse) & 3) {
 		udf_err(iter->dir->i_sb,
-			"directory (ino %lu) has entry at pos %llu with unaligned length of impUse field\n",
+			"directory (ino %llu) has entry at pos %llu with unaligned length of impUse field\n",
 			iter->dir->i_ino, (unsigned long long)iter->pos);
 		return -EFSCORRUPTED;
 	}
@@ -41,20 +41,20 @@ static int udf_verify_fi(struct udf_fileident_iter *iter)
 	 */
 	if (len > 1 << iter->dir->i_blkbits) {
 		udf_err(iter->dir->i_sb,
-			"directory (ino %lu) has too big (%u) entry at pos %llu\n",
+			"directory (ino %llu) has too big (%u) entry at pos %llu\n",
 			iter->dir->i_ino, len, (unsigned long long)iter->pos);
 		return -EFSCORRUPTED;
 	}
 	if (iter->pos + len > iter->dir->i_size) {
 		udf_err(iter->dir->i_sb,
-			"directory (ino %lu) has entry past directory size at pos %llu\n",
+			"directory (ino %llu) has entry past directory size at pos %llu\n",
 			iter->dir->i_ino, (unsigned long long)iter->pos);
 		return -EFSCORRUPTED;
 	}
 	if (udf_dir_entry_len(&iter->fi) !=
 	    sizeof(struct tag) + le16_to_cpu(iter->fi.descTag.descCRCLength)) {
 		udf_err(iter->dir->i_sb,
-			"directory (ino %lu) has entry where CRC length (%u) does not match entry length (%u)\n",
+			"directory (ino %llu) has entry where CRC length (%u) does not match entry length (%u)\n",
 			iter->dir->i_ino,
 			(unsigned)le16_to_cpu(iter->fi.descTag.descCRCLength),
 			(unsigned)(udf_dir_entry_len(&iter->fi) -
@@ -78,7 +78,7 @@ static int udf_copy_fi(struct udf_fileident_iter *iter)
 	}
 	if (iter->dir->i_size < iter->pos + sizeof(struct fileIdentDesc)) {
 		udf_err(iter->dir->i_sb,
-			"directory (ino %lu) has entry straddling EOF\n",
+			"directory (ino %llu) has entry straddling EOF\n",
 			iter->dir->i_ino);
 		return -EFSCORRUPTED;
 	}
@@ -184,7 +184,7 @@ static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
 			return 0;
 		}
 		udf_err(iter->dir->i_sb,
-			"extent after position %llu not allocated in directory (ino %lu)\n",
+			"extent after position %llu not allocated in directory (ino %llu)\n",
 			(unsigned long long)iter->pos, iter->dir->i_ino);
 		return -EFSCORRUPTED;
 	}
@@ -272,7 +272,7 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 		if (pos == dir->i_size)
 			return 0;
 		udf_err(dir->i_sb,
-			"position %llu not allocated in directory (ino %lu)\n",
+			"position %llu not allocated in directory (ino %llu)\n",
 			(unsigned long long)pos, dir->i_ino);
 		err = -EFSCORRUPTED;
 		goto out;
@@ -483,7 +483,7 @@ int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
 		   &iter->loffset, &etype);
 	if (err <= 0 || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
 		udf_err(iter->dir->i_sb,
-			"block %llu not allocated in directory (ino %lu)\n",
+			"block %llu not allocated in directory (ino %llu)\n",
 			(unsigned long long)block, iter->dir->i_ino);
 		return -EFSCORRUPTED;
 	}
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 32ae7cfd72c549958b70824b449cf146f6750f44..b043fe10e5d605b62988512bbda65bd357fb649a 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -133,7 +133,7 @@ long udf_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	int result;
 
 	if (file_permission(filp, MAY_READ) != 0) {
-		udf_debug("no permission to access inode %lu\n", inode->i_ino);
+		udf_debug("no permission to access inode %llu\n", inode->i_ino);
 		return -EPERM;
 	}
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7fae8002344a0e1e7e51022e97f1e0e2424185f9..902f81729bd886a534c9da644771c7c04c067cbf 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -147,7 +147,7 @@ void udf_evict_inode(struct inode *inode)
 		if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB &&
 		    inode->i_size != iinfo->i_lenExtents) {
 			udf_warn(inode->i_sb,
-				 "Inode %lu (mode %o) has inode size %llu different from extent length %llu. Filesystem need not be standards compliant.\n",
+				 "Inode %llu (mode %o) has inode size %llu different from extent length %llu. Filesystem need not be standards compliant.\n",
 				 inode->i_ino, inode->i_mode,
 				 (unsigned long long)inode->i_size,
 				 (unsigned long long)iinfo->i_lenExtents);
@@ -1386,13 +1386,13 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	 */
 	bh = udf_read_ptagged(inode->i_sb, iloc, 0, &ident);
 	if (!bh) {
-		udf_err(inode->i_sb, "(ino %lu) failed !bh\n", inode->i_ino);
+		udf_err(inode->i_sb, "(ino %llu) failed !bh\n", inode->i_ino);
 		return -EIO;
 	}
 
 	if (ident != TAG_IDENT_FE && ident != TAG_IDENT_EFE &&
 	    ident != TAG_IDENT_USE) {
-		udf_err(inode->i_sb, "(ino %lu) failed ident=%u\n",
+		udf_err(inode->i_sb, "(ino %llu) failed ident=%u\n",
 			inode->i_ino, ident);
 		goto out;
 	}
@@ -1641,7 +1641,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		udf_debug("METADATA BITMAP FILE-----\n");
 		break;
 	default:
-		udf_err(inode->i_sb, "(ino %lu) failed unknown file type=%u\n",
+		udf_err(inode->i_sb, "(ino %llu) failed unknown file type=%u\n",
 			inode->i_ino, fe->icbTag.fileType);
 		goto out;
 	}
@@ -1942,7 +1942,7 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 	if (do_sync) {
 		sync_dirty_buffer(bh);
 		if (buffer_write_io_error(bh)) {
-			udf_warn(inode->i_sb, "IO error syncing udf inode [%08lx]\n",
+			udf_warn(inode->i_sb, "IO error syncing udf inode [%08llx]\n",
 				 inode->i_ino);
 			err = -EIO;
 		}
@@ -2224,7 +2224,7 @@ int udf_next_aext(struct inode *inode, struct extent_position *epos,
 
 		if (++indirections > UDF_MAX_INDIR_EXTS) {
 			udf_err(inode->i_sb,
-				"too many indirect extents in inode %lu\n",
+				"too many indirect extents in inode %llu\n",
 				inode->i_ino);
 			return -EFSCORRUPTED;
 		}
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 5f2e9a892bffa9579143cedf71d80efa7ad6e9fb..ccafcaa9680982decaabc180833b67ace5c92973 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -550,7 +550,7 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
 		goto end_unlink;
 
 	if (!inode->i_nlink) {
-		udf_debug("Deleting nonexistent file (%lu), %u\n",
+		udf_debug("Deleting nonexistent file (%llu), %u\n",
 			  inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
 	}
@@ -809,7 +809,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 					       &diriter);
 		if (retval == -ENOENT) {
 			udf_err(old_inode->i_sb,
-				"directory (ino %lu) has no '..' entry\n",
+				"directory (ino %llu) has no '..' entry\n",
 				old_inode->i_ino);
 			retval = -EFSCORRUPTED;
 		}
@@ -821,7 +821,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				old_dir->i_ino) {
 			retval = -EFSCORRUPTED;
 			udf_err(old_inode->i_sb,
-				"directory (ino %lu) has parent entry pointing to another inode (%lu != %u)\n",
+				"directory (ino %llu) has parent entry pointing to another inode (%llu != %u)\n",
 				old_inode->i_ino, old_dir->i_ino,
 				udf_get_lb_pblock(old_inode->i_sb, &tloc, 0));
 			goto out_oiter;
@@ -869,7 +869,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	retval = udf_fiiter_find_entry(old_dir, &old_dentry->d_name, &oiter);
 	if (retval) {
 		udf_err(old_dir->i_sb,
-			"failed to find renamed entry again in directory (ino %lu)\n",
+			"failed to find renamed entry again in directory (ino %llu)\n",
 			old_dir->i_ino);
 	} else {
 		udf_fiiter_delete_entry(&oiter);
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 27f463fd1d89e8ae4844cd70c291d737aee1589e..3a2d66c7e856383cc5c8a605180a9582396ba805 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1166,7 +1166,7 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 		}
 		map->s_uspace.s_table = inode;
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_TABLE;
-		udf_debug("unallocSpaceTable (part %d) @ %lu\n",
+		udf_debug("unallocSpaceTable (part %d) @ %llu\n",
 			  p_index, map->s_uspace.s_table->i_ino);
 	}
 

-- 
2.53.0


