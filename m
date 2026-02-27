Return-Path: <linux-fsdevel+bounces-78691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMK6NXNToWkfsAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:18:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E061B4651
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C1EE30C8D35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA538BF7B;
	Fri, 27 Feb 2026 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="ks/1el1+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e3i670.smtp2go.com (e3i670.smtp2go.com [158.120.86.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90A389E1F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180172; cv=none; b=n1NZ6mOQbN43UwRO0GVQOaszN6sffAU97pJvcD0uNiI791GtZbMsBGEcPiK7HtXvyQF8DfwyuC1/S5zrOBjPjcPJqhJzD9SVz5Fv4JxxJ7EHHi2ZDAYkfhvr5Ue7JgouruHmiNLJzVix2bjPeYKJylgY0tkxaXBQXNskk+J/TBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180172; c=relaxed/simple;
	bh=vKp8DyJrHHJRXEBHOkpTrRuYv6aTj9ijM38Jy/cJo84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prS0kQy/zt/Hwjyq7S8PDDdqlhqQfsvmrSHLeS1HZ3ir3HR71sWUHiI90rkCWNtnoCQvgVbuZbd40JI1DwTQq5etu7hCKvGMQiSSlIVgyV+yOjTTGzCZ3dsbe1oxZpWIhnkOFkE1xE1/VvkFpKrIFrpx6lYlf/RmB9o0E4OBrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=ks/1el1+; arc=none smtp.client-ip=158.120.86.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1772180163; h=from : subject
 : to : message-id : date;
 bh=Jwh53lsG+eoctpp0EtTJ1ZXN/F98xvDBeJr90Gtu2ZY=;
 b=ks/1el1+0GgBZwZpsu94IyaDBfdUOMVJYGWdYPhJaeyBxJ9Qc8Oc23miCcjHhuP6+Lbvt
 nrR4t4nkBCrcPHeTcfJM9P0rgmhUxhP1m5W/VuYaHX9jYyKIJj9a584ZoZSpA/RJrHtj1iz
 BbWyLFVOqE3i7hmS866SBETikbAt7U1TrNAFUHZcTog/T7nSgDyczORooSIPwvQnZDKkPaD
 Af4l0LKJYDPdeprsY3kKKQpOyV944mtlSbhAC/QWB+5r/faCuFGW0BUhKE9CFGDcYaG7t12
 6LqqS8EvKTEx4UB0Rh/M5Qo6Yj+dXsTgM/j63OOiDdx8f/pKNstTfae8ACcA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vvt0v-4o5NDgrhS5C-nmn4;
	Fri, 27 Feb 2026 08:15:57 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 2/4] 9p: Add mount option for negative dentry cache retention
Date: Fri, 27 Feb 2026 08:56:53 +0100
Message-ID: <7c2a5ba3e229b4e820f0fcd565ca38ab3ca5493f.1772178819.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772178819.git.repk@triplefau.lt>
References: <cover.1772178819.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sm_Iw7YcyN
X-smtpcorp-track: JFli4t0tqpwR.Bzbsal7bpMqg.FAkNfAKLML9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78691-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 52E061B4651
X-Rspamd-Action: no action

Introduce a new mount option, ndentrycache, for v9fs that allows users
to specify how long negative dentries are retained in the cache. The
retention time can be set in milliseconds (e.g. ndentrycache=10000 for
a 10secs retention time), or negative entries can be kept until the
buffer cache management removes them by using the option without a
value (i.e. ndentrycache).

For consistency reasons, this option should only be used in exclusive
or read-only mount scenarios, aligning with the cache=loose usage.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.c | 73 ++++++++++++++++++++++++++++++++--------------------
 fs/9p/v9fs.h | 23 ++++++++++-------
 2 files changed, 58 insertions(+), 38 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index c5dca81a553e..a26bd9070786 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -39,11 +39,12 @@ enum {
 	 * source if we rejected it as EINVAL */
 	Opt_source,
 	/* Options that take integer arguments */
-	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
+	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_ndentrycachetmo,
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
 	Opt_nodevmap, Opt_noxattr, Opt_directio, Opt_ignoreqv,
+	Opt_ndentrycache,
 	/* Access options */
 	Opt_access, Opt_posixacl,
 	/* Lock timeout option */
@@ -77,41 +78,43 @@ static const struct constant_table p9_versions[] = {
  * the client, and all the transports.
  */
 const struct fs_parameter_spec v9fs_param_spec[] = {
-	fsparam_string	("source",	Opt_source),
-	fsparam_u32hex	("debug",	Opt_debug),
-	fsparam_uid	("dfltuid",	Opt_dfltuid),
-	fsparam_gid	("dfltgid",	Opt_dfltgid),
-	fsparam_u32	("afid",	Opt_afid),
-	fsparam_string	("uname",	Opt_uname),
-	fsparam_string	("aname",	Opt_remotename),
-	fsparam_flag	("nodevmap",	Opt_nodevmap),
-	fsparam_flag	("noxattr",	Opt_noxattr),
-	fsparam_flag	("directio",	Opt_directio),
-	fsparam_flag	("ignoreqv",	Opt_ignoreqv),
-	fsparam_string	("cache",	Opt_cache),
-	fsparam_string	("cachetag",	Opt_cachetag),
-	fsparam_string	("access",	Opt_access),
-	fsparam_flag	("posixacl",	Opt_posixacl),
-	fsparam_u32	("locktimeout",	Opt_locktimeout),
+	fsparam_string	("source",		Opt_source),
+	fsparam_u32hex	("debug",		Opt_debug),
+	fsparam_uid	("dfltuid",		Opt_dfltuid),
+	fsparam_gid	("dfltgid",		Opt_dfltgid),
+	fsparam_u32	("afid",		Opt_afid),
+	fsparam_string	("uname",		Opt_uname),
+	fsparam_string	("aname",		Opt_remotename),
+	fsparam_flag	("nodevmap",		Opt_nodevmap),
+	fsparam_flag	("noxattr",		Opt_noxattr),
+	fsparam_flag	("directio",		Opt_directio),
+	fsparam_flag	("ignoreqv",		Opt_ignoreqv),
+	fsparam_string	("cache",		Opt_cache),
+	fsparam_string	("cachetag",		Opt_cachetag),
+	fsparam_string	("access",		Opt_access),
+	fsparam_flag	("posixacl",		Opt_posixacl),
+	fsparam_u32	("locktimeout",		Opt_locktimeout),
+	fsparam_flag	("ndentrycache",	Opt_ndentrycache),
+	fsparam_u32	("ndentrycache",	Opt_ndentrycachetmo),
 
 	/* client options */
-	fsparam_u32	("msize",	Opt_msize),
-	fsparam_flag	("noextend",	Opt_legacy),
-	fsparam_string	("trans",	Opt_trans),
-	fsparam_enum	("version",	Opt_version, p9_versions),
+	fsparam_u32	("msize",		Opt_msize),
+	fsparam_flag	("noextend",		Opt_legacy),
+	fsparam_string	("trans",		Opt_trans),
+	fsparam_enum	("version",		Opt_version, p9_versions),
 
 	/* fd transport options */
-	fsparam_u32	("rfdno",	Opt_rfdno),
-	fsparam_u32	("wfdno",	Opt_wfdno),
+	fsparam_u32	("rfdno",		Opt_rfdno),
+	fsparam_u32	("wfdno",		Opt_wfdno),
 
 	/* rdma transport options */
-	fsparam_u32	("sq",		Opt_sq_depth),
-	fsparam_u32	("rq",		Opt_rq_depth),
-	fsparam_u32	("timeout",	Opt_timeout),
+	fsparam_u32	("sq",			Opt_sq_depth),
+	fsparam_u32	("rq",			Opt_rq_depth),
+	fsparam_u32	("timeout",		Opt_timeout),
 
 	/* fd and rdma transprt options */
-	fsparam_u32	("port",	Opt_port),
-	fsparam_flag	("privport",	Opt_privport),
+	fsparam_u32	("port",		Opt_port),
+	fsparam_flag	("privport",		Opt_privport),
 	{}
 };
 
@@ -159,6 +162,10 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 			   from_kgid_munged(&init_user_ns, v9ses->dfltgid));
 	if (v9ses->afid != ~0)
 		seq_printf(m, ",afid=%u", v9ses->afid);
+	if (v9ses->ndentry_timeout_ms == NDENTRY_TMOUT_NEVER)
+		seq_printf(m, ",ndentrycache");
+	else if (v9ses->flags & V9FS_NDENTRY_TMOUT_SET)
+		seq_printf(m, ",ndentrycache=%u", v9ses->ndentry_timeout_ms);
 	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
 		seq_printf(m, ",uname=%s", v9ses->uname);
 	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
@@ -337,6 +344,16 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		session_opts->session_lock_timeout = (long)result.uint_32 * HZ;
 		break;
 
+	case Opt_ndentrycache:
+		session_opts->flags |= V9FS_NDENTRY_TMOUT_SET;
+		session_opts->ndentry_timeout_ms = NDENTRY_TMOUT_NEVER;
+		break;
+
+	case Opt_ndentrycachetmo:
+		session_opts->flags |= V9FS_NDENTRY_TMOUT_SET;
+		session_opts->ndentry_timeout_ms = result.uint_64;
+		break;
+
 	/* Options for client */
 	case Opt_msize:
 		if (result.uint_32 < 4096) {
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 8410f7883109..2e42729c6c20 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -24,6 +24,8 @@
  * @V9FS_ACCESS_ANY: use a single attach for all users
  * @V9FS_ACCESS_MASK: bit mask of different ACCESS options
  * @V9FS_POSIX_ACL: POSIX ACLs are enforced
+ * @V9FS_NDENTRY_TMOUT_SET: Has negative dentry timeout retention time been
+ *			    overriden by ndentrycache mount option
  *
  * Session flags reflect options selected by users at mount time
  */
@@ -34,16 +36,17 @@
 #define V9FS_ACL_MASK V9FS_POSIX_ACL
 
 enum p9_session_flags {
-	V9FS_PROTO_2000U    = 0x01,
-	V9FS_PROTO_2000L    = 0x02,
-	V9FS_ACCESS_SINGLE  = 0x04,
-	V9FS_ACCESS_USER    = 0x08,
-	V9FS_ACCESS_CLIENT  = 0x10,
-	V9FS_POSIX_ACL      = 0x20,
-	V9FS_NO_XATTR       = 0x40,
-	V9FS_IGNORE_QV      = 0x80, /* ignore qid.version for cache hints */
-	V9FS_DIRECT_IO      = 0x100,
-	V9FS_SYNC           = 0x200
+	V9FS_PROTO_2000U       = 0x01,
+	V9FS_PROTO_2000L       = 0x02,
+	V9FS_ACCESS_SINGLE     = 0x04,
+	V9FS_ACCESS_USER       = 0x08,
+	V9FS_ACCESS_CLIENT     = 0x10,
+	V9FS_POSIX_ACL         = 0x20,
+	V9FS_NO_XATTR          = 0x40,
+	V9FS_IGNORE_QV         = 0x80, /* ignore qid.version for cache hints */
+	V9FS_DIRECT_IO         = 0x100,
+	V9FS_SYNC              = 0x200,
+	V9FS_NDENTRY_TMOUT_SET = 0x400,
 };
 
 /**
-- 
2.52.0


