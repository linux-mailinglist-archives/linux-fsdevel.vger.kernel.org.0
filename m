Return-Path: <linux-fsdevel+bounces-77265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOcZAgjIkmm6xgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 08:32:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE7E14143E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 08:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8CF300EA8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7825B2E54BD;
	Mon, 16 Feb 2026 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jHcD9C5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06151213254;
	Mon, 16 Feb 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771227135; cv=none; b=l4mUdTdUGGtFGy5FF6cOpdaSFiUye3yxg0FBsavxU//sL5806InOFniBS7DeJYmIMaYt0Pws5NtWbcb+Co92qTSv19Tjhw1EmiaOI+z9LNopPgdXfFyMRY3DsAxE5fsMPscgZxMSZeZVpzpeonzZmrBtVl+xVdjpfY9BMr9Zo1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771227135; c=relaxed/simple;
	bh=EAjHU58MXJuzrKhOZslbQIagDeUiwYTe2iDUwTSOAUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CMXWfmKiTGG+K7qCQFiF5viQR+gMsZGkjMf8EW8zgzUDKzkTz2kI8Gquax0gJ/GW80TArVzGlZECojewk4103+OOTsnPuqSY2kj1SxsPiTLQYvbZ9H+pFIogThGXeihAYjTWTKpczshQGQTK12QP2tiwhT+kFJO7U/7aM0f2ZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jHcD9C5A; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771227134; x=1802763134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oOGk+bLnbrzwrcMZo9H3IiF/hDqikNWw7hoqgVeYD2A=;
  b=jHcD9C5ApGh4IjJ+STmuz/EpPCAUSFg99XiiDtizKHu/sRJSHge/KRiv
   phNNiroB6/fWX45UwiHZA63NZQQj0EsVt7OUhppEkKy7M4bT1ChF4Oi0W
   os3GstAoD46xkdGzIXtD6rKYSKNnI7I7+hCzqIF3nfr9RaOqBBe7hQbB/
   Wss/2JUdoq3Mk//EbyhCNNEoOjjXE6p6A9mGmNkJTsAkrB1mmLFABs5jG
   mPwqNa1qYSfpfXxR2odc7x0w9+0hPiIYk0T9wFKRg6KTOs16QQeyrLlWa
   HS24Kt8Ky0OEGZIqv/jymPNb1LuPWE7IIfEKGywyzfjXS42VLqxf6PFv6
   Q==;
X-CSE-ConnectionGUID: GgGy+jAVSSm1ijfmcV5TNQ==
X-CSE-MsgGUID: /c86fSIXQrmFhziPLK9qSw==
X-IronPort-AV: E=Sophos;i="6.21,293,1763424000"; 
   d="scan'208";a="12939639"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 07:32:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:13197]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.217:2525] with esmtp (Farcaster)
 id e522bb7e-e91c-4abc-bd1d-3a573fb7f48c; Mon, 16 Feb 2026 07:32:10 +0000 (UTC)
X-Farcaster-Flow-ID: e522bb7e-e91c-4abc-bd1d-3a573fb7f48c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 16 Feb 2026 07:32:10 +0000
Received: from c889f3b07a0a.amazon.com (10.106.83.9) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 16 Feb 2026 07:32:08 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
CC: <virtualization@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yuto Ohnuki <ytohnuki@amazon.com>
Subject: [PATCH] virtiofs: add FUSE protocol validation
Date: Mon, 16 Feb 2026 07:31:58 +0000
Message-ID: <20260216073158.75151-1-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77265-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5BE7E14143E
X-Rspamd-Action: no action

Add virtio_fs_verify_response() to validate that the server properly
follows the FUSE protocol by checking:

- Response length is at least sizeof(struct fuse_out_header).
- oh.len matches the actual response length.
- oh.unique matches the request's unique identifier.

On validation failure, set error to -EIO and normalize oh.len to prevent
underflow in copy_args_from_argbuf().

Addresses the TODO comment in virtio_fs_request_complete().

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 fs/fuse/virtio_fs.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b2f6486fe1d5..8847d083ce57 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -758,6 +758,27 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	req->argbuf = NULL;
 }
 
+/* Verify that the server properly follows the FUSE protocol */
+static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
+{
+	struct fuse_out_header *oh = &req->out.h;
+
+	if (len < sizeof(*oh)) {
+		pr_warn("virtio-fs: response too short (%u)\n", len);
+		return false;
+	}
+	if (oh->len != len) {
+		pr_warn("virtio-fs: oh.len mismatch (%u != %u)\n", oh->len, len);
+		return false;
+	}
+	if (oh->unique != req->in.h.unique) {
+		pr_warn("virtio-fs: oh.unique mismatch (%llu != %llu)\n",
+			oh->unique, req->in.h.unique);
+		return false;
+	}
+	return true;
+}
+
 /* Work function for request completion */
 static void virtio_fs_request_complete(struct fuse_req *req,
 				       struct virtio_fs_vq *fsvq)
@@ -767,10 +788,6 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	unsigned int len, i, thislen;
 	struct folio *folio;
 
-	/*
-	 * TODO verify that server properly follows FUSE protocol
-	 * (oh.uniq, oh.len)
-	 */
 	args = req->args;
 	copy_args_from_argbuf(args, req);
 
@@ -824,6 +841,10 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		virtqueue_disable_cb(vq);
 
 		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
+			if (!virtio_fs_verify_response(req, len)) {
+				req->out.h.error = -EIO;
+				req->out.h.len = sizeof(struct fuse_out_header);
+			}
 			spin_lock(&fpq->lock);
 			list_move_tail(&req->list, &reqs);
 			spin_unlock(&fpq->lock);
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




