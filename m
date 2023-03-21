Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36DC6C272B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCUBPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjCUBP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:15:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2872712F2B
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1SN7vmQ/2NcK2NCaEtt00yu4NeliIOPcR9G0GBq4WYfEFX0rH6duX9qSR93+7UNK1+uPBInA4grXo8BGCWqnR7lqsdvq8vPxlZZrFUlIVJEXHXBErjQgHdcZ7xmKg0ypyhE9jy/mcKQ0ig3p80IageWAXuesupYzJiHEQnWeQn9LRN7fjIvlgn5+/ksxUnEQmBi98FoJXBhRBOobCH9QG9Hqc0WfD4Txa0jzl8I34u2n2KYepUH9hy447yQNcCqM56p1llW3sNcDbx1oYum5thDrC8vQf0xFsXXjjpLSlU78ok39p8dB/BDBcIbELGVeSrm9TehCMdkIzg6ksphlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2o3UqP2Y64f/TGEZMileyQJjZ+6IniJC9vrXwFLYUc=;
 b=kv87whBEz7ZwQLS/Tb7f2Vci+PUnP6mQ0koMyPblj9TNqYuuRSDYMxZ9jCenhYrEHEV9jar9zxpCGZkX0r0C6JKN3zLKcJuodt4HMj2t9L4VOOO8mFYFKWEQtstxqYcK9RB4yNLL0Ef3hjoJqUf3kGxzsjrWneYV3fnAbR5/wgJ0EKZzvB8OdJsr4vhu5t42kt06fUv9dwO9p2LbaNFPoC/ZFp1o7C4UWKpfMt1UgLZb8tfCDeyfCBMOTZ9PEuBDaWAFYQ9DUy+wxWUdk6Y+VcpKejawbxRdPWpC+Dka8GCmn3goGfHZBuhXq8v6PuVIRu2qrQzOrjeh9DT8kX5z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2o3UqP2Y64f/TGEZMileyQJjZ+6IniJC9vrXwFLYUc=;
 b=xjnj2Bw7lZfRZZqJK/djBbL8bjkefAfsUrUj4+ZD6nu+dF7BWWq27dwj1Md60wHEBAscZTVyqw5i0PiNrU/Wj1BDd4WdHhkv2Vcn8VLvbiO/R4tY2WgSfgps2tPQzQ+lMdZulN7PbrEYZ4DK788H2Y+kUeP6kyc7Vg65jGry1UE=
Received: from MW4PR04CA0241.namprd04.prod.outlook.com (2603:10b6:303:88::6)
 by SA3PR19MB7542.namprd19.prod.outlook.com (2603:10b6:806:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 21 Mar
 2023 01:11:27 +0000
Received: from MW2NAM04FT050.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::d1) by MW4PR04CA0241.outlook.office365.com
 (2603:10b6:303:88::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT050.mail.protection.outlook.com (10.13.30.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 01:11:26 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 44C992073545;
        Mon, 20 Mar 2023 19:12:34 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 12/13] fuse: Add uring sqe commit and fetch support
Date:   Tue, 21 Mar 2023 02:10:46 +0100
Message-Id: <20230321011047.3425786-13-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT050:EE_|SA3PR19MB7542:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 11638eec-3211-45fb-7165-08db29a93202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwKo6RIPp3DRki4yfD8wDbf3jgUyubG3V4TyusC5hAruu01HuD+wEM+yTRRs61mbCDzVVto/1GRBfDq5LZ1FRcVVPaDidiLm9CszmVfiKEQuqPS7Hs2c+NGc+NwEZCOgL06H/u9VdqL+eO0ursi5jj2RJ5QfRIyJLdc6hyUnxxE1hoASfuCbrr6/1hGIJHurC8fg4TL3cJodmZiRxwlBBTcd3e7i4JJ3davEZqpNl6rCHDch1wgyF22A27MITgHuR6nVQVsIlFxGnjBPVAs9v9Fz4P8krbB65J8Jib+6WUSYFvoThAaD4a6qqGZNLM8nih19YOOwcODob1t4pkG3V7Wl6G2IJ4p8j4hJbcBdifvlLnLu36qEizJYkQXaQiZSqND/W2tVfvP/UZ2VFSRiX7suurpg1SyytfREMLCuldULiUSnBDgxz6/0VHkegTNpgFKmiyz5lvtVwTbgMlJgOwRqzlkjvojhf0xXjALhso0PSGY1AUAGM2rpL6SCCatk2AjgBnrE9YKvNqtzQApCtzsqrChMjawe9ccEIoWVczFii6TKP7mvlbSf9SZ9mYKS2VyDuBxGOKybuuDYsChgTW7CIE1UhMRM2YNV7DI6BcKltX5DvmVPDeZUTGzmeCm+/8E2UmMYQlrbSDqq7yECwzXXM/IbhHQFFkIoVL8NPkWYQ0KPHK3sdgrqBruHGOwlaBSb7vWihhcDzIkZCo87o7Dvzglx943KhFuVp/KUObY=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39850400004)(376002)(451199018)(36840700001)(46966006)(1076003)(5660300002)(41300700001)(478600001)(8676002)(36756003)(356005)(86362001)(4326008)(81166007)(82740400003)(70206006)(36860700001)(8936002)(6666004)(2906002)(47076005)(30864003)(316002)(70586007)(186003)(6916009)(26005)(2616005)(82310400005)(40480700001)(336012)(6266002)(83380400001)(54906003)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:26.7352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11638eec-3211-45fb-7165-08db29a93202
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT050.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7542
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support for fuse request completion through ring SQEs
(FUSE_URING_REQ_COMMIT_AND_FETCH handling). After committing
the ring entry it becomes available for new fuse requests.
Handling of requests through the ring (SQE/CQE handling)
is complete now.

Fuse request data are copied through the mmaped ring buffer,
there is no support for any zero copy yet.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/dev.c         |   1 +
 fs/fuse/dev_uring.c   | 408 +++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/dev_uring_i.h |   1 +
 3 files changed, 401 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index de9193f66c8b..cce55eaed8a3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2330,6 +2330,7 @@ const struct file_operations fuse_dev_operations = {
 	.unlocked_ioctl = fuse_dev_ioctl,
 	.compat_ioctl   = compat_ptr_ioctl,
 	.mmap		= fuse_uring_mmap,
+	.uring_cmd	= fuse_uring_cmd,
 };
 EXPORT_SYMBOL_GPL(fuse_dev_operations);
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 744a38064131..5c41f9f71410 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -34,6 +34,9 @@ module_param(enable_uring, bool, 0644);
 MODULE_PARM_DESC(enable_uring,
 	"Enable uring userspace communication through uring.");
 
+static bool fuse_uring_ent_release_and_fetch(struct fuse_ring_ent *ring_ent);
+static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent);
+
 static struct fuse_ring_queue *
 fuse_uring_get_queue(struct fuse_conn *fc, int qid)
 {
@@ -47,15 +50,6 @@ fuse_uring_get_queue(struct fuse_conn *fc, int qid)
 	return (struct fuse_ring_queue *)(ptr + qid * fc->ring.queue_size);
 }
 
-/* dummy function will be replaced in later commits */
-static void fuse_uring_bit_set(struct fuse_ring_ent *ent, bool is_bg,
-			       const char *str)
-{
-	(void)ent;
-	(void)is_bg;
-	(void)str;
-}
-
 /* Abort all list queued request on the given ring queue */
 static void fuse_uring_end_queue_requests(struct fuse_ring_queue *queue)
 {
@@ -81,6 +75,363 @@ void fuse_uring_end_requests(struct fuse_conn *fc)
 	}
 }
 
+/*
+ * Finalize a fuse request, then fetch and send the next entry, if available
+ *
+ * has lock/unlock/lock to avoid holding the lock on calling fuse_request_end
+ */
+static void
+fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent, bool set_err,
+				int error)
+{
+	bool already = false;
+	struct fuse_req *req = ring_ent->fuse_req;
+	bool send;
+
+	spin_lock(&ring_ent->queue->lock);
+	if (ring_ent->state & FRRS_FUSE_REQ_END || !ring_ent->need_req_end)
+		already = true;
+	else {
+		ring_ent->state |= FRRS_FUSE_REQ_END;
+		ring_ent->need_req_end = 0;
+	}
+	spin_unlock(&ring_ent->queue->lock);
+
+	if (already) {
+		struct fuse_ring_queue *queue = ring_ent->queue;
+
+		if (!queue->aborted) {
+			pr_info("request end not needed state=%llu end-bit=%d\n",
+				ring_ent->state, ring_ent->need_req_end);
+			WARN_ON(1);
+		}
+		return;
+	}
+
+	if (set_err)
+		req->out.h.error = error;
+
+	fuse_request_end(ring_ent->fuse_req);
+	ring_ent->fuse_req = NULL;
+
+	send = fuse_uring_ent_release_and_fetch(ring_ent);
+	if (send)
+		fuse_uring_send_to_ring(ring_ent);
+}
+
+/*
+ * Copy data from the req to the ring buffer
+ */
+static int fuse_uring_copy_to_ring(struct fuse_conn *fc,
+				   struct fuse_req *req,
+				   struct fuse_ring_req *rreq)
+{
+	struct fuse_copy_state cs;
+	struct fuse_args *args = req->args;
+	int err;
+
+	fuse_copy_init(&cs, 1, NULL);
+	cs.is_uring = 1;
+	cs.ring.buf = rreq->in_out_arg;
+	cs.ring.buf_sz = fc->ring.req_arg_len;
+	cs.req = req;
+
+	pr_devel("%s:%d buf=%p len=%d args=%d\n", __func__, __LINE__,
+		 cs.ring.buf, cs.ring.buf_sz, args->out_numargs);
+
+	err = fuse_copy_args(&cs, args->in_numargs, args->in_pages,
+			     (struct fuse_arg *) args->in_args, 0);
+	rreq->in_out_arg_len = cs.ring.offset;
+
+	pr_devel("%s:%d buf=%p len=%d args=%d err=%d\n", __func__, __LINE__,
+		 cs.ring.buf, cs.ring.buf_sz, args->out_numargs, err);
+
+	return err;
+}
+
+/*
+ * Copy data from the ring buffer to the fuse request
+ */
+static int fuse_uring_copy_from_ring(struct fuse_conn *fc,
+				     struct fuse_req *req,
+				     struct fuse_ring_req *rreq)
+{
+	struct fuse_copy_state cs;
+	struct fuse_args *args = req->args;
+
+	fuse_copy_init(&cs, 0, NULL);
+	cs.is_uring = 1;
+	cs.ring.buf = rreq->in_out_arg;
+
+	if (rreq->in_out_arg_len > fc->ring.req_arg_len) {
+		pr_devel("Max ring buffer len exceeded (%u vs %zu\n",
+			 rreq->in_out_arg_len,  fc->ring.req_arg_len);
+		return -EINVAL;
+	}
+	cs.ring.buf_sz = rreq->in_out_arg_len;
+	cs.req = req;
+
+	pr_devel("%s:%d buf=%p len=%d args=%d\n", __func__, __LINE__,
+		 cs.ring.buf, cs.ring.buf_sz, args->out_numargs);
+
+	return fuse_copy_out_args(&cs, args, rreq->in_out_arg_len);
+}
+
+/**
+ * Write data to the ring buffer and send the request to userspace,
+ * userspace will read it
+ * This is comparable with classical read(/dev/fuse)
+ */
+static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent)
+{
+	struct fuse_conn *fc = ring_ent->queue->fc;
+	struct fuse_ring_req *rreq = ring_ent->rreq;
+	struct fuse_req *req = ring_ent->fuse_req;
+	int err = 0;
+
+	pr_devel("%s:%d ring-req=%p fuse_req=%p state=%llu args=%p\n", __func__,
+		 __LINE__, ring_ent, ring_ent->fuse_req, ring_ent->state, req->args);
+
+	spin_lock(&ring_ent->queue->lock);
+	if (unlikely((ring_ent->state & FRRS_USERSPACE) ||
+		     (ring_ent->state & FRRS_FREED))) {
+		pr_err("ring-req=%p buf_req=%p invalid state %llu on send\n",
+		       ring_ent, rreq, ring_ent->state);
+		WARN_ON(1);
+		err = -EIO;
+	} else
+		ring_ent->state |= FRRS_USERSPACE;
+
+	ring_ent->need_cmd_done = 0;
+	spin_unlock(&ring_ent->queue->lock);
+	if (err)
+		goto err;
+
+	err = fuse_uring_copy_to_ring(fc, req, rreq);
+	if (unlikely(err)) {
+		ring_ent->state &= ~FRRS_USERSPACE;
+		ring_ent->need_cmd_done = 1;
+		goto err;
+	}
+
+	/* ring req go directly into the shared memory buffer */
+	rreq->in = req->in.h;
+
+	pr_devel("%s qid=%d tag=%d state=%llu cmd-done op=%d unique=%llu\n",
+		__func__, ring_ent->queue->qid, ring_ent->tag, ring_ent->state,
+		rreq->in.opcode, rreq->in.unique);
+
+	io_uring_cmd_done(ring_ent->cmd, 0, 0);
+	return;
+
+err:
+	fuse_uring_req_end_and_get_next(ring_ent, true, err);
+}
+
+/**
+ * Set the given ring entry as available in the queue bitmap
+ */
+static void fuse_uring_bit_set(struct fuse_ring_ent *ring_ent, bool bg,
+			       const char *str)
+__must_hold(ring_ent->queue->lock)
+{
+	int old;
+	struct fuse_ring_queue *queue = ring_ent->queue;
+	const struct fuse_conn *fc = queue->fc;
+	int tag = ring_ent->tag;
+
+	old = test_and_set_bit(tag, queue->req_avail_map);
+	if (unlikely(old != 0)) {
+		pr_warn("%8s invalid bit value on clear for qid=%d tag=%d",
+			str, queue->qid, tag);
+		WARN_ON(1);
+	}
+	if (bg)
+		queue->req_bg++;
+	else
+		queue->req_fg++;
+
+	pr_devel("%35s bit set fc=%p is_bg=%d qid=%d tag=%d fg=%d bg=%d bgq: %d\n",
+		 str, fc, bg, queue->qid, ring_ent->tag, queue->req_fg,
+		 queue->req_bg, !list_empty(&queue->bg_queue));
+}
+
+/**
+ * Mark the ring entry as not available for other requests
+ */
+static int fuse_uring_bit_clear(struct fuse_ring_ent *ring_ent, int is_bg,
+				const char *str)
+__must_hold(ring_ent->queue->lock)
+{
+	int old;
+	struct fuse_ring_queue *queue = ring_ent->queue;
+	const struct fuse_conn *fc = queue->fc;
+	int tag = ring_ent->tag;
+	int *value = is_bg ? &queue->req_bg : &queue->req_fg;
+
+	if (unlikely(*value <= 0)) {
+		pr_warn("%s qid=%d tag=%d is_bg=%d zero req avail fg=%d bg=%d\n",
+			str, queue->qid, ring_ent->tag, is_bg,
+			queue->req_bg, queue->req_fg);
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	old = test_and_clear_bit(tag, queue->req_avail_map);
+	if (unlikely(old != 1)) {
+		pr_warn("%8s invalid bit value on clear for qid=%d tag=%d",
+			str, queue->qid, tag);
+		WARN_ON(1);
+		return -EIO;
+	}
+
+	ring_ent->rreq->flags = 0;
+
+	if (is_bg) {
+		ring_ent->rreq->flags |= FUSE_RING_REQ_FLAG_BACKGROUND;
+		queue->req_bg--;
+	} else
+		queue->req_fg--;
+
+	pr_devel("%35s ring bit clear fc=%p is_bg=%d qid=%d tag=%d fg=%d bg=%d\n",
+		 str, fc, is_bg, queue->qid, ring_ent->tag,
+		 queue->req_fg, queue->req_bg);
+
+	ring_ent->state |= FRRS_FUSE_REQ;
+
+	return 0;
+}
+
+/*
+ * Assign a fuse queue entry to the given entry
+ *
+ */
+static bool fuse_uring_assign_ring_entry(struct fuse_ring_ent *ring_ent,
+					     struct list_head *head,
+					     int is_bg)
+__must_hold(&queue.waitq.lock)
+{
+	struct fuse_req *req;
+	int res;
+
+	if (list_empty(head))
+		return false;
+
+	res = fuse_uring_bit_clear(ring_ent, is_bg, __func__);
+	if (unlikely(res))
+		return false;
+
+	req = list_first_entry(head, struct fuse_req, list);
+	list_del_init(&req->list);
+	clear_bit(FR_PENDING, &req->flags);
+	ring_ent->fuse_req = req;
+	ring_ent->need_req_end = 1;
+
+	return true;
+}
+
+/*
+ * Checks for errors and stores it into the request
+ */
+static int fuse_uring_ring_ent_has_err(struct fuse_conn *fc,
+				       struct fuse_ring_ent *ring_ent)
+{
+	struct fuse_req *req = ring_ent->fuse_req;
+	struct fuse_out_header *oh = &req->out.h;
+	int err;
+
+	if (oh->unique == 0) {
+		/* Not supportd through request based uring, this needs another
+		 * ring from user space to kernel
+		 */
+		pr_warn("Unsupported fuse-notify\n");
+		err = -EINVAL;
+		goto seterr;
+	}
+
+	if (oh->error <= -512 || oh->error > 0) {
+		err = -EINVAL;
+		goto seterr;
+	}
+
+	if (oh->error) {
+		err = oh->error;
+		pr_devel("%s:%d err=%d op=%d req-ret=%d",
+			 __func__, __LINE__, err, req->args->opcode,
+			 req->out.h.error);
+		goto err; /* error already set */
+	}
+
+	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique) {
+
+		pr_warn("Unpexted seqno mismatch, expected: %llu got %llu\n",
+			req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
+		err = -ENOENT;
+		goto seterr;
+	}
+
+	/* Is it an interrupt reply ID?	 */
+	if (oh->unique & FUSE_INT_REQ_BIT) {
+		err = 0;
+		if (oh->error == -ENOSYS)
+			fc->no_interrupt = 1;
+		else if (oh->error == -EAGAIN) {
+			/* XXX Needs to copy to the next cq and submit it */
+			// err = queue_interrupt(req);
+			pr_warn("Intrerupt EAGAIN not supported yet");
+			err = -EINVAL;
+		}
+
+		goto seterr;
+	}
+
+	return 0;
+
+seterr:
+	pr_devel("%s:%d err=%d op=%d req-ret=%d",
+		 __func__, __LINE__, err, req->args->opcode,
+		 req->out.h.error);
+	oh->error = err;
+err:
+	pr_devel("%s:%d err=%d op=%d req-ret=%d",
+		 __func__, __LINE__, err, req->args->opcode,
+		 req->out.h.error);
+	return err;
+}
+
+/**
+ * Read data from the ring buffer, which user space has written to
+ * This is comparible with handling of classical write(/dev/fuse).
+ * Also make the ring request available again for new fuse requests.
+ */
+static void fuse_uring_commit_and_release(struct fuse_dev *fud,
+					  struct fuse_ring_ent *ring_ent)
+{
+	struct fuse_ring_req *rreq = ring_ent->rreq;
+	struct fuse_req *req = ring_ent->fuse_req;
+	ssize_t err = 0;
+	bool set_err = false;
+
+	req->out.h = rreq->out;
+
+	err = fuse_uring_ring_ent_has_err(fud->fc, ring_ent);
+	if (err) {
+		/* req->out.h.error already set */
+		pr_devel("%s:%d err=%zd oh->err=%d\n",
+			 __func__, __LINE__, err, req->out.h.error);
+		goto out;
+	}
+
+	err = fuse_uring_copy_from_ring(fud->fc, req, rreq);
+	if (err)
+		set_err = true;
+
+out:
+	pr_devel("%s:%d ret=%zd op=%d req-ret=%d\n",
+		 __func__, __LINE__, err, req->args->opcode, req->out.h.error);
+	fuse_uring_req_end_and_get_next(ring_ent, set_err, err);
+}
+
 /*
  * Release a ring request, it is no longer needed and can handle new data
  *
@@ -119,6 +470,25 @@ __must_hold(&queue->lock)
 	ring_ent->rreq->flags = 0;
 	ring_ent->state = FRRS_FUSE_WAIT;
 }
+
+/*
+ * Release a uring entry and fetch the next fuse request if available
+ */
+static bool fuse_uring_ent_release_and_fetch(struct fuse_ring_ent *ring_ent)
+{
+	struct fuse_ring_queue *queue = ring_ent->queue;
+	bool is_bg = !!(ring_ent->rreq->flags & FUSE_RING_REQ_FLAG_BACKGROUND);
+	bool send = false;
+	struct list_head *head = is_bg ? &queue->bg_queue : &queue->fg_queue;
+
+	spin_lock(&ring_ent->queue->lock);
+	fuse_uring_ent_release(ring_ent, queue, is_bg);
+	send = fuse_uring_assign_ring_entry(ring_ent, head, is_bg);
+	spin_unlock(&ring_ent->queue->lock);
+
+	return send;
+}
+
 /**
  * Simplified ring-entry release function, for shutdown only
  */
@@ -810,6 +1180,26 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 
 		ret = fuse_uring_fetch(ring_ent, cmd);
 		break;
+	case FUSE_URING_REQ_COMMIT_AND_FETCH:
+		if (unlikely(!fc->ring.ready)) {
+			pr_info("commit and fetch, but the ring is not ready yet");
+			goto out;
+		}
+
+		if (!(prev_state & FRRS_USERSPACE)) {
+			pr_info("qid=%d tag=%d state %llu misses %d\n",
+				queue->qid, ring_ent->tag, ring_ent->state,
+				FRRS_USERSPACE);
+			goto out;
+		}
+
+		/* XXX Test inject error */
+
+		WRITE_ONCE(ring_ent->cmd, cmd);
+		fuse_uring_commit_and_release(fud, ring_ent);
+
+		ret = 0;
+		break;
 	default:
 		ret = -EINVAL;
 		pr_devel("Unknown uring command %d", cmd_op);
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 4032dccca8b6..b0ef36215b80 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -13,6 +13,7 @@ void fuse_uring_end_requests(struct fuse_conn *fc);
 int fuse_uring_ioctl(struct file *file, struct fuse_uring_cfg *cfg);
 void fuse_uring_ring_destruct(struct fuse_conn *fc);
 int fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma);
+int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
 #endif
 
 
-- 
2.37.2

