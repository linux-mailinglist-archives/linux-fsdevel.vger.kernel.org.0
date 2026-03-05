Return-Path: <linux-fsdevel+bounces-79485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MM9L9x4qWl77wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 13:36:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F43211C5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 13:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 892D6300F78A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19C39A066;
	Thu,  5 Mar 2026 12:35:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FAC382366
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714149; cv=none; b=majM8y3YEZf1aUUZo+LQIT8Fcw5L2NZQvnG4lXTUYtwCBSp2w9ZlG5poRLxMtXcryZkMtXEX0KYuZhkK6NaHdNfA0KW0qwUSSa0bRz+4baDpDt3mPjvwK7nyhNoAjRWKOt++1moQg/jloeF1xrS6KYogHPBlYFPG+ga5G5DIkRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714149; c=relaxed/simple;
	bh=YVggioqdxbVEv9xEIMNu85RaHl5JbElPN/LeEICZ2f0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RJIK9TgOyA9j2I9CzgncdpX0KALYXOn8nB1weJd4vzdolAm+YUR4voH0UBEoLySIOmYZWSxL92GkAYYwhIsi1DXpUszjATAEX+N18IStg6CxkGnN59SRoOVDJmVgteM8cXUZ+NgOJqk766gtj+9oTmW8J+zQRpLiqHBgXJp7g6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d13e1b08188f11f1a21c59e7364eecb8-20260305
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:99e2b3b0-fff3-4416-851f-c23fc9cc0945,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:40
X-CID-INFO: VERSION:1.3.11,REQID:99e2b3b0-fff3-4416-851f-c23fc9cc0945,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:89c9d04,CLOUDID:0c85256d3f1a80412744df5a653e099e,BulkI
	D:260305202935YN9QXHAX,BulkQuantity:2,Recheck:0,SF:19|66|72|78|102|127|898
	,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d13e1b08188f11f1a21c59e7364eecb8-20260305
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 328447401; Thu, 05 Mar 2026 20:35:39 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] fuse: rename confusing ring->max_payload_sz
Date: Thu,  5 Mar 2026 20:35:11 +0800
Message-Id: <20260305123511.4222-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 92F43211C5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79485-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@kylinos.cn,linux-fsdevel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Action: no action

In the fuse_uring_create_ring_ent function of dev_uring.c,
when payload_size < ring->max_payload_sz, it reports an error,
which is confusing because  ring->max_payload_sz feels like
it should represent the allowed upper limit. Therefore, rename it
to indicate the maximum possible payload size of the fuse requests.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/dev_uring.c   | 14 +++++++-------
 fs/fuse/dev_uring_i.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 3a38b61aac26..9afa0c7cf92a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -229,7 +229,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	struct fuse_ring *ring;
 	size_t nr_queues = num_possible_cpus();
 	struct fuse_ring *res = NULL;
-	size_t max_payload_size;
+	size_t max_req_payload_size;
 
 	ring = kzalloc_obj(*fc->ring, GFP_KERNEL_ACCOUNT);
 	if (!ring)
@@ -240,8 +240,8 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	if (!ring->queues)
 		goto out_err;
 
-	max_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
-	max_payload_size = max(max_payload_size, fc->max_pages * PAGE_SIZE);
+	max_req_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
+	max_req_payload_size = max(max_req_payload_size, fc->max_pages * PAGE_SIZE);
 
 	spin_lock(&fc->lock);
 	if (fc->ring) {
@@ -255,7 +255,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 
 	ring->nr_queues = nr_queues;
 	ring->fc = fc;
-	ring->max_payload_sz = max_payload_size;
+	ring->max_req_payload_sz = max_req_payload_size;
 	smp_store_release(&fc->ring, ring);
 
 	spin_unlock(&fc->lock);
@@ -590,7 +590,7 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	if (err)
 		return -EFAULT;
 
-	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
+	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_req_payload_sz,
 			  &iter);
 	if (err)
 		return err;
@@ -621,7 +621,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		.commit_id = req->in.h.unique,
 	};
 
-	err = import_ubuf(ITER_DEST, ent->payload, ring->max_payload_sz, &iter);
+	err = import_ubuf(ITER_DEST, ent->payload, ring->max_req_payload_sz, &iter);
 	if (err) {
 		pr_info_ratelimited("fuse: Import of user buffer failed\n");
 		return err;
@@ -1056,7 +1056,7 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 	}
 
 	payload_size = iov[1].iov_len;
-	if (payload_size < ring->max_payload_sz) {
+	if (payload_size < ring->max_req_payload_sz) {
 		pr_info_ratelimited("Invalid req payload len %zu\n",
 				    payload_size);
 		return ERR_PTR(err);
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce1..544f7afb3866 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -112,8 +112,8 @@ struct fuse_ring {
 	/* number of ring queues */
 	size_t nr_queues;
 
-	/* maximum payload/arg size */
-	size_t max_payload_sz;
+	/* maximum request payload/arg size */
+	size_t max_req_payload_sz;
 
 	struct fuse_ring_queue **queues;
 
-- 
2.34.1


