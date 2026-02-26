Return-Path: <linux-fsdevel+bounces-78575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHTHB1t/oGnWkQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:14:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 329441ABFC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FDC5312C020
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC794D8DAD;
	Thu, 26 Feb 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1fg6RLY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDB4D2EDE;
	Thu, 26 Feb 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122017; cv=none; b=dy2x1BRqj2uVZ60oCVQCf7Yk5/Sz/sol1mrtulfdsl8Ra8vxpHSHMtZz57yTsZzFFj8of6IJc6slY55ueLPD2nlqQx50cuOk6RqbBef+gwq7XttCm9KAOzHvfdZCvKS3m9+wO5OG1nUYxsZ//ZJx28Qdu9WUhBNjTgnQfnOnl4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122017; c=relaxed/simple;
	bh=FmPBc0NhfLgyYBRek3UGiwF5KRQmM91KdK9CMwNeb7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GamsHQXXryc1KDMSlm5G9sXcUkxFOUQcUaLU2fB16KzY/bJl3ETmMhXi1UCt68GviOombUm5d0gpt3RhiYuChyhO5+pLVsW4aeM0oXw7j24A6eor5hE0+36qNX5Zzxk6VznOzmA3sca1TAtTuc4xQipXrcdvuT4Ojyhd8MCU+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1fg6RLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EE8C19424;
	Thu, 26 Feb 2026 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122016;
	bh=FmPBc0NhfLgyYBRek3UGiwF5KRQmM91KdK9CMwNeb7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P1fg6RLYZtOqeaPyYCSbcWnLY0bPAHJhLVTkuiLTNpt81BXrMXLx7a90piiz4kVDN
	 ZwEVP9yzroCTdwrjOyqkuQb1AygqTWpE4gSuCRmV+2JH97xaHBkhG2SGgwl49NKbzV
	 WVbG+Y9GnPqQlyVbwVwGRjXFzNLih5FQCDNkt6W3J15NYBkeyYiOTdvhexWLzISbG2
	 3++3CE5I1Xq6GZic+my5GsrMK3uWBn0DQ/+aH2W6VhBfDrbLrsZnN4BJAoa0M3BVGG
	 eLSHGwn5gRXb9om3wP9dM99al/tcw4wxsP+jK1HoKsOyT3DKn944Re8Y40lRLwUPZD
	 AbEOCA/YNbN9w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:53 -0500
Subject: [PATCH 51/61] security: update audit format strings for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-51-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8060; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FmPBc0NhfLgyYBRek3UGiwF5KRQmM91KdK9CMwNeb7A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0RIkOUwB5FdByxBC3LRrIg3ty7KbK+nLDoh
 QFlxOd+DmqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtEQAKCRAADmhBGVaC
 Fd2qD/4sHrpKWPPkClKVMZa1IK2OiuALVNOenyP1HzN7a81bq2lSU/lTmH19YwylEeGJd6mAly/
 Nlth2m2Wd1orRPqEGRyW5PLu20EtAstZ79tv44qr4Yiez5kOyntZhwtUM7asrWWJbBbgqqCM2ae
 x+nr/CqLoQ0oxfSBX0IKn1P3095P5SUTv6jJM0baKx7pXP5fDHolobpbmfBIfvgPO6sVU/HptjR
 hQayS2OjlhcNKyJK9yYP8sXDb1iEqUKEBILryQCfUeYOMZp2Tt5RwEt9zgYmkF4OoreIZ5NyVMP
 ckk9U4Zy/iT2+/hvxSLlJ3FpQwMY8ezs8k1RB5Eb+QZprStMacIRl+QYeIphbQgCnN7iptIKxuk
 X3BjKUXXUkLr9QkmpGjkLzLjObwxSNJOmhd+JuxDwVwkd16XM/3qhyeOSJTozf7mxwKK8BdJApJ
 IgNRvWFB3pDfZTNYObJOeY5srE7RepL0u8IGsTSON8gQQ1wyZz8mudCi8FmSe1QV3YP1HAZ73/h
 5Jp33Gj41Y54Rc4i4+c1uCzQLaeVrZPZqye37ol/uMIfcRGl0BXbOpF1ByHps1s5H0A6VdYtMbE
 B9iom5OtSG5rz9aEC58EdWdw+UPdz67cqbD4y4A/6xHMEv82aVmTMZuFFsEbg6NIJ5uQMfz41Au
 sZrWk4IjaZWH7jQ==
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
	TAGGED_FROM(0.00)[bounces-78575-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 329441ABFC0
X-Rspamd-Action: no action

Update %lu/%ld to %llu/%lld in security audit logging functions that
print inode->i_ino, since i_ino is now u64.

Files updated: apparmor/apparmorfs.c, integrity/integrity_audit.c,
ipe/audit.c, lsm_audit.c.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/apparmor/apparmorfs.c       |  4 ++--
 security/integrity/integrity_audit.c |  2 +-
 security/ipe/audit.c                 |  2 +-
 security/lsm_audit.c                 | 10 +++++-----
 security/selinux/hooks.c             |  4 ++--
 security/smack/smack_lsm.c           | 12 ++++++------
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 2f84bd23edb69e7e69cb097e554091df0132816d..7b645f40e71c956f216fa6a7d69c3ecd4e2a5ff4 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -149,7 +149,7 @@ static int aafs_count;
 
 static int aafs_show_path(struct seq_file *seq, struct dentry *dentry)
 {
-	seq_printf(seq, "%s:[%lu]", AAFS_NAME, d_inode(dentry)->i_ino);
+	seq_printf(seq, "%s:[%llu]", AAFS_NAME, d_inode(dentry)->i_ino);
 	return 0;
 }
 
@@ -2644,7 +2644,7 @@ static int policy_readlink(struct dentry *dentry, char __user *buffer,
 	char name[32];
 	int res;
 
-	res = snprintf(name, sizeof(name), "%s:[%lu]", AAFS_NAME,
+	res = snprintf(name, sizeof(name), "%s:[%llu]", AAFS_NAME,
 		       d_inode(dentry)->i_ino);
 	if (res > 0 && res < sizeof(name))
 		res = readlink_copy(buffer, buflen, name, strlen(name));
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 0ec5e4c22cb2a1066c2b897776ead6d3db72635c..d8d9e5ff1cd22b091f462d1e83d28d2d6bd983e9 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -62,7 +62,7 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
 	if (inode) {
 		audit_log_format(ab, " dev=");
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
-		audit_log_format(ab, " ino=%lu", inode->i_ino);
+		audit_log_format(ab, " ino=%llu", inode->i_ino);
 	}
 	audit_log_format(ab, " res=%d errno=%d", !result, errno);
 	audit_log_end(ab);
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index 3f0deeb54912730d9acf5e021a4a0cb29a34e982..93fb59fbddd60b56c0b22be2a38b809ef9e18b76 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -153,7 +153,7 @@ void ipe_audit_match(const struct ipe_eval_ctx *const ctx,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode->i_ino);
 		} else {
 			audit_log_format(ab, " dev=? ino=?");
 		}
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 7d623b00495c14b079e10e963c21a9f949c11f07..737f5a263a8f79416133315edf363ece3d79c722 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -202,7 +202,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode->i_ino);
 		}
 		break;
 	}
@@ -215,7 +215,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode->i_ino);
 		}
 		break;
 	}
@@ -228,7 +228,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode->i_ino);
 		}
 
 		audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
@@ -246,7 +246,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode->i_ino);
 		}
 		break;
 	}
@@ -265,7 +265,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 		}
 		audit_log_format(ab, " dev=");
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
-		audit_log_format(ab, " ino=%lu", inode->i_ino);
+		audit_log_format(ab, " ino=%llu", inode->i_ino);
 		rcu_read_unlock();
 		break;
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d8224ea113d1ac273aac1fb52324f00b3301ae75..150ea86ebc1f7c7f8391af4109a3da82b12d00d2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1400,7 +1400,7 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 	if (rc < 0) {
 		kfree(context);
 		if (rc != -ENODATA) {
-			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%ld\n",
+			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%lld\n",
 				__func__, -rc, inode->i_sb->s_id, inode->i_ino);
 			return rc;
 		}
@@ -3477,7 +3477,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 					   &newsid);
 	if (rc) {
 		pr_err("SELinux:  unable to map context to SID"
-		       "for (%s, %lu), rc=%d\n",
+		       "for (%s, %llu), rc=%d\n",
 		       inode->i_sb->s_id, inode->i_ino, -rc);
 		return;
 	}
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 98af9d7b943469d0ddd344fc78c0b87ca40c16c4..7e2f54c17a5d5c70740bbfa92ba4d4f1aca2cf22 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -182,7 +182,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
-		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
+		pr_info("Smack Unconfined Corruption: inode=(%s %lld) %s\n",
 			inode->i_sb->s_id, inode->i_ino, current->comm);
 
 	if (rc <= 0)
@@ -195,7 +195,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
 
 	smk_bu_mode(mode, acc);
 
-	pr_info("Smack %s: (%s %s %s) inode=(%s %ld) %s\n", smk_bu_mess[rc],
+	pr_info("Smack %s: (%s %s %s) inode=(%s %lld) %s\n", smk_bu_mess[rc],
 		tsp->smk_task->smk_known, isp->smk_inode->smk_known, acc,
 		inode->i_sb->s_id, inode->i_ino, current->comm);
 	return 0;
@@ -214,7 +214,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
-		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
+		pr_info("Smack Unconfined Corruption: inode=(%s %lld) %s\n",
 			inode->i_sb->s_id, inode->i_ino, current->comm);
 
 	if (rc <= 0)
@@ -223,7 +223,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 		rc = 0;
 
 	smk_bu_mode(mode, acc);
-	pr_info("Smack %s: (%s %s %s) file=(%s %ld %pD) %s\n", smk_bu_mess[rc],
+	pr_info("Smack %s: (%s %s %s) file=(%s %lld %pD) %s\n", smk_bu_mess[rc],
 		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
 		inode->i_sb->s_id, inode->i_ino, file,
 		current->comm);
@@ -244,7 +244,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
-		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
+		pr_info("Smack Unconfined Corruption: inode=(%s %lld) %s\n",
 			inode->i_sb->s_id, inode->i_ino, current->comm);
 
 	if (rc <= 0)
@@ -253,7 +253,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 		rc = 0;
 
 	smk_bu_mode(mode, acc);
-	pr_info("Smack %s: (%s %s %s) file=(%s %ld %pD) %s\n", smk_bu_mess[rc],
+	pr_info("Smack %s: (%s %s %s) file=(%s %lld %pD) %s\n", smk_bu_mess[rc],
 		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
 		inode->i_sb->s_id, inode->i_ino, file,
 		current->comm);

-- 
2.53.0


