Return-Path: <linux-fsdevel+bounces-78357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDI9IhXdnmkTXgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:29:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2FD1967D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A52930AC299
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A906395267;
	Wed, 25 Feb 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GInl6byK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074BA3939B1;
	Wed, 25 Feb 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018721; cv=none; b=myLd/smQbzAacBb8qHTs8eeOamrglnme5TAQyUpaxNrelhkqG13HVEHXVF3MV+kkUPcGXNWul0SdibKQYQymJX4+tbv0Ab+7upVPl1+TuwPOIg9WS5FAa2w1muORby+688Ri9WcOmQkESvWdUQoTH/iSUWcCvhq79Or1gQu+Aig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018721; c=relaxed/simple;
	bh=d4CAhtgSioguYg2upsew64NwHgPmgU2XvI3EYTdSKr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4C9fl17ac0Fj+ipbhQay30jCG9NtoDrv8N/CHcopHBLOjrnHlORYfKQyLjjOxnPQ8RWMcPJFQCiyVPSznTHD5MaknI5v6Ge1cL5fyZjwUjMgfwE046g1Rdiojv5WV/oXSFXo3vxE4dytl3k7GNxiTrguBg1HxQ4/PXWyFErgMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GInl6byK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DXtMVtmrxddzuhbM1DC/GuIOIXfI5qn7KhrEBeX/Thc=; b=GInl6byKesFpK516vUUaA3eLQK
	OEZEqSj05AXyLcHd1iLvYT1siMAxjOG+M0Hnv9CLMiCiCQR0Kkde+pxwbI7GhTVtUs2oeijYR3YHZ
	gRv+6YiL8TUbce0Kt3WbzHyQG8UYUXfC/iIHUUmiJ90ZgI0ycxD1BShNAip9HPL4x82FOmC25XhJL
	ovDiYwrQHImNfGeo63Rmi2gXOXmc/EqAf68DZechQb+F9VzUGJSLFCafyPT2S6Jq8pFCJ4qrtWyza
	4W/0Hi/1kL+L2frsAErAJ70V+gw5gHW+WZ8z3qyPIfbYQ19/Dd2Z2XV4iXvcV333M1Y8GnOT+Kj8s
	LAWLdvPA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvD0p-005Cma-IG; Wed, 25 Feb 2026 12:25:03 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kevin Chen <kchen@ddn.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v3 5/8] fuse: extract helper functions from fuse_do_statx()
Date: Wed, 25 Feb 2026 11:24:36 +0000
Message-ID: <20260225112439.27276-6-luis@igalia.com>
In-Reply-To: <20260225112439.27276-1-luis@igalia.com>
References: <20260225112439.27276-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78357-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: 0B2FD1967D3
X-Rspamd-Action: no action

Split function fuse_do_statx(), so that we get two helper functions: one
to initialise the arguments and another to update the attributes and
statistics.  This will allow compound operations to re-use these two helpers.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c | 88 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 92c9ebfb4985..5c0f1364c392 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1406,43 +1406,37 @@ static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
 	attr->blksize = sx->blksize;
 }
 
-static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
-			 struct file *file, struct kstat *stat)
+static void fuse_statx_init(struct fuse_args *args, struct fuse_statx_in *inarg,
+			    u64 nodeid, struct fuse_file *ff,
+			    struct fuse_statx_out *outarg)
 {
-	int err;
-	struct fuse_attr attr;
-	struct fuse_statx *sx;
-	struct fuse_statx_in inarg;
-	struct fuse_statx_out outarg;
-	struct fuse_mount *fm = get_fuse_mount(inode);
-	u64 attr_version = fuse_get_attr_version(fm->fc);
-	FUSE_ARGS(args);
-
-	memset(&inarg, 0, sizeof(inarg));
-	memset(&outarg, 0, sizeof(outarg));
-	/* Directories have separate file-handle space */
-	if (file && S_ISREG(inode->i_mode)) {
-		struct fuse_file *ff = file->private_data;
+	memset(inarg, 0, sizeof(*inarg));
+	memset(outarg, 0, sizeof(*outarg));
 
-		inarg.getattr_flags |= FUSE_GETATTR_FH;
-		inarg.fh = ff->fh;
+	if (ff) {
+		inarg->getattr_flags |= FUSE_GETATTR_FH;
+		inarg->fh = ff->fh;
 	}
 	/* For now leave sync hints as the default, request all stats. */
-	inarg.sx_flags = 0;
-	inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
-	args.opcode = FUSE_STATX;
-	args.nodeid = get_node_id(inode);
-	args.in_numargs = 1;
-	args.in_args[0].size = sizeof(inarg);
-	args.in_args[0].value = &inarg;
-	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(outarg);
-	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
-	if (err)
-		return err;
+	inarg->sx_flags = 0;
+	inarg->sx_mask = STATX_BASIC_STATS | STATX_BTIME;
+	args->opcode = FUSE_STATX;
+	args->nodeid = nodeid;
+	args->in_numargs = 1;
+	args->in_args[0].size = sizeof(*inarg);
+	args->in_args[0].value = inarg;
+	args->out_numargs = 1;
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
+}
+
+static int fuse_statx_update(struct mnt_idmap *idmap,
+			     struct fuse_statx_out *outarg, struct inode *inode,
+			     u64 attr_version, struct kstat *stat)
+{
+	struct fuse_statx *sx = &outarg->stat;
+	struct fuse_attr attr;
 
-	sx = &outarg.stat;
 	if (((sx->mask & STATX_SIZE) && !fuse_valid_size(sx->size)) ||
 	    ((sx->mask & STATX_TYPE) && (!fuse_valid_type(sx->mode) ||
 					 inode_wrong_type(inode, sx->mode)))) {
@@ -1450,10 +1444,10 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 		return -EIO;
 	}
 
-	fuse_statx_to_attr(&outarg.stat, &attr);
+	fuse_statx_to_attr(sx, &attr);
 	if ((sx->mask & STATX_BASIC_STATS) == STATX_BASIC_STATS) {
-		fuse_change_attributes(inode, &attr, &outarg.stat,
-				       ATTR_TIMEOUT(&outarg), attr_version);
+		fuse_change_attributes(inode, &attr, sx,
+				       ATTR_TIMEOUT(outarg), attr_version);
 	}
 
 	if (stat) {
@@ -1467,6 +1461,30 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	return 0;
 }
 
+static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
+			 struct file *file, struct kstat *stat)
+{
+	int err;
+	struct fuse_statx_in inarg;
+	struct fuse_statx_out outarg;
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_file *ff = NULL;
+	u64 attr_version = fuse_get_attr_version(fm->fc);
+	FUSE_ARGS(args);
+
+	/* Directories have separate file-handle space */
+	if (file && S_ISREG(inode->i_mode))
+		ff = file->private_data;
+
+	fuse_statx_init(&args, &inarg, get_node_id(inode), ff, &outarg);
+
+	err = fuse_simple_request(fm, &args);
+	if (err)
+		return err;
+
+	return fuse_statx_update(idmap, &outarg, inode, attr_version, stat);
+}
+
 /*
  * Helper function to initialize fuse_args for GETATTR operations
  */

