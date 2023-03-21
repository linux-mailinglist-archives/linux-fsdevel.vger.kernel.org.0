Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9326C2716
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCUBNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCUBNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:13:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BC914EBB
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiGU0BqEV0BCRgTvJ/QijpJLEG/SsOubz5JiFRuM3NmY23ZRFP/gVWecFjoClRM/FZy1ZMFTSDqG5zY/UX3iTxCE/CJDXXtTvw06GrABLv3A0d403sX9nYhe1nyfjo57TzdLeBspPeebpXADMCFt7D/R30chLSjnMIvwowRDMaWAFFClcNYp6/FkRXdZUImDUVO+Z8rR8Z5D3USZs+K2vqkGmmhf3V2Rhr0LcF2sxvioHGgusTR0G2Q6yW42qXjRJbRgNfI+9sG6mLlcPS1HjDq7kMts3SVcAheQZkIcpALi4ZXgdE027rsqaERMcZUZE/GlRyJY2T1aqX9uPriNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns8Hd7qurI7naPB5cAK2WsBplAWNxBhqnsmAexFR9Ps=;
 b=JvPjI2mW8V1ov+GnWQUY1mAYpc66N5BG6g2GvW6MUtvV/Pmuo2rCGVO8SY/zXhMdE8fGQWvwjq69yDA9WfMj8Vop4AphQHc0/iKOv34Qx7/Lo73k4VsMf/bmr+WelLE+nUhFzHxLszxFmC5OCTIqjgu/1lEERI4Q/1cW/BREhHKrhlTsPYxtlan2dCe7uc2cq3ebmUYb3PQ9xslNkS7OBMRVreXg95DwbwHa+CX/ruS6ScqnJqcJiIu0r1tYt8WpvW8jxi9Hrsg60JRBjbiemdRN2CM8KRfd2ZaZWco6q13luRSXTVoCEjMdD9FhBx8fS/uWyrOGEB8c+ttw03h1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns8Hd7qurI7naPB5cAK2WsBplAWNxBhqnsmAexFR9Ps=;
 b=icUX8bz7QviHBzs3hZp1DMxBrGdAX2BSOCqwuHd2ro8PsSOA5Tg7EkqGhhjDZFqRRU/Xr4OamqaeruS/4uDqVcWRh6D5S7Kd2zdyUB0o671fn8xE/gMgj/y6ONrP2D4zoB9ur6UUb5vY4NM1VI0/QFIwPXsB69aL3b1J74K9CIc=
Received: from BN9PR03CA0537.namprd03.prod.outlook.com (2603:10b6:408:131::32)
 by BY1PR19MB7749.namprd19.prod.outlook.com (2603:10b6:a03:533::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 21 Mar
 2023 01:11:25 +0000
Received: from BN8NAM04FT034.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::36) by BN9PR03CA0537.outlook.office365.com
 (2603:10b6:408:131::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT034.mail.protection.outlook.com (10.13.160.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 01:11:24 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 55AC620C6862;
        Mon, 20 Mar 2023 19:12:32 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 10/13] fuse: Handle SQEs - register commands
Date:   Tue, 21 Mar 2023 02:10:44 +0100
Message-Id: <20230321011047.3425786-11-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT034:EE_|BY1PR19MB7749:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e2f32bbb-1f98-4bfb-d2db-08db29a930f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fpPHdcCVg04GPYvd233FjuXqwTT17KTSgKLEyzbBcAdLZgKzeT2QvaPueSAMJNyJFulDf6w+pCQFQOTw/JFBeN2RvoiqyB+wDWPvwWgoEPK9gQnSgtXSePEPYyV9LNmcswAVQ0X4Qfbva+G/6kY0/SwbkWjfs54tErZFd8LGAIwJrmOjNi4PCh4ncB8BvYgXXxnk+h1n9iKDlLEiI0SFjrjQE+elCcrfOsbUCr4jFTIak9yh1uecawXjZPiI8gu2zx7ByRAbVE3A7v8IG6JQhfFRVfoCDO3I29RNeGk6fJRiErKbMrd55k/iDqvS7I1jjN6TTFByS5E2ddYOpzLWktWWH9Su+J9JW+2uaGpi17jGpY6GQr5vdzTS7wDTxE0DcZIfcKj+yKEzAlBfVP1OpiA6ZjV6OmKKv9dx9LwAHFXM6YRzosQoM2woM+fAkyoSdPMD0mf5bn/SjUkp9yeu0P8QzpbsH+efie8e16xj95/bLzRIBJbXLafjBg8mbx7/x9SpQ5fKFz950OnaFQYrSjKk9rRXKCzxrOgZ13a7X+i7fFNtZRhtYjaPv3tEjGsy1I3DE+MO/twPkmFFClsQl3q97qAhd1tfc4ikO0GynYdlb6TAZpkAVldpgJmDX/ZQVe8ppHYEePji+oGBQzOSBDD495BcHcvY86tLUe7EyenEAAmD341ydl5iI9pVLn0MCLy+irfgSjgtjMBURtWitloN+cz3ovwWQTeo8RXsIE=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39850400004)(346002)(136003)(376002)(451199018)(36840700001)(46966006)(478600001)(8936002)(5660300002)(336012)(40480700001)(81166007)(4326008)(8676002)(70206006)(6266002)(1076003)(6666004)(2616005)(54906003)(82740400003)(186003)(26005)(2906002)(36860700001)(70586007)(6916009)(36756003)(47076005)(86362001)(356005)(82310400005)(316002)(41300700001)(83380400001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:24.9148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f32bbb-1f98-4bfb-d2db-08db29a930f3
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT034.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR19MB7749
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds basic support for ring SQEs (with opcode=IORING_OP_URING_CMD).
For now only FUSE_URING_REQ_FETCH is handled to register queue entries.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/dev_uring.c | 240 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e19c652e7071..744a38064131 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -81,6 +81,44 @@ void fuse_uring_end_requests(struct fuse_conn *fc)
 	}
 }
 
+/*
+ * Release a ring request, it is no longer needed and can handle new data
+ *
+ */
+static void fuse_uring_ent_release(struct fuse_ring_ent *ring_ent,
+					   struct fuse_ring_queue *queue,
+					   bool bg)
+__must_hold(&queue->lock)
+{
+	struct fuse_conn *fc = queue->fc;
+
+	/* unsets all previous flags - basically resets */
+	pr_devel("%s fc=%p qid=%d tag=%d state=%llu bg=%d\n",
+		__func__, fc, ring_ent->queue->qid, ring_ent->tag,
+		ring_ent->state, bg);
+
+	if (ring_ent->state & FRRS_USERSPACE) {
+		pr_warn("%s qid=%d tag=%d state=%llu is_bg=%d\n",
+			__func__, ring_ent->queue->qid, ring_ent->tag,
+			ring_ent->state, bg);
+		WARN_ON(1);
+		return;
+	}
+
+	fuse_uring_bit_set(ring_ent, bg, __func__);
+
+	/* Check if this is call through shutdown/release task and already and
+	 * the request is about to be released - the state must not be reset
+	 * then, as state FRRS_FUSE_WAIT would introduce a double
+	 * io_uring_cmd_done
+	 */
+	if (ring_ent->state & FRRS_FREEING)
+		return;
+
+	/* Note: the bit in req->flag got already cleared in fuse_request_end */
+	ring_ent->rreq->flags = 0;
+	ring_ent->state = FRRS_FUSE_WAIT;
+}
 /**
  * Simplified ring-entry release function, for shutdown only
  */
@@ -592,3 +630,205 @@ int fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	return ret;
 }
+
+/*
+ * fuse_uring_req_fetch command handling
+ */
+static int fuse_uring_fetch(struct fuse_ring_ent *ring_ent,
+			    struct io_uring_cmd *cmd)
+{
+	struct fuse_ring_queue *queue = ring_ent->queue;
+	struct fuse_conn *fc = queue->fc;
+	int ret;
+	bool is_bg = false;
+	int nr_queue_init = 0;
+
+	spin_lock(&queue->lock);
+
+	/* register requests for foreground requests first, then backgrounds */
+	if (queue->req_fg >= fc->ring.max_fg)
+		is_bg = true;
+	fuse_uring_ent_release(ring_ent, queue, is_bg);
+
+	/* daemon side registered all requests, this queue is complete */
+	if (queue->req_fg + queue->req_bg == fc->ring.queue_depth)
+		nr_queue_init =
+			atomic_inc_return(&fc->ring.nr_queues_cmd_init);
+
+	ret = 0;
+	if (queue->req_fg + queue->req_bg > fc->ring.queue_depth) {
+		/* should be caught by ring state before and queue depth
+		 * check before
+		 */
+		WARN_ON(1);
+		pr_info("qid=%d tag=%d req cnt (fg=%d bg=%d exceeds depth=%zu",
+			queue->qid, ring_ent->tag, queue->req_fg,
+			queue->req_bg, fc->ring.queue_depth);
+		ret = -ERANGE;
+
+		/* avoid completion through fuse_req_end, as there is no
+		 * fuse req assigned yet
+		 */
+		ring_ent->state = FRRS_INIT;
+	}
+
+	pr_devel("%s:%d qid=%d tag=%d nr-fg=%d nr-bg=%d nr_queue_init=%d\n",
+		__func__, __LINE__,
+		queue->qid, ring_ent->tag, queue->req_fg, queue->req_bg,
+		nr_queue_init);
+
+	spin_unlock(&queue->lock);
+	if (ret)
+		goto out; /* erange */
+
+	WRITE_ONCE(ring_ent->cmd, cmd);
+
+	if (nr_queue_init == fc->ring.nr_queues)
+		fc->ring.ready = 1;
+
+out:
+	return ret;
+}
+
+struct fuse_ring_queue *
+fuse_uring_get_verify_queue(struct fuse_conn *fc,
+			 const struct fuse_uring_cmd_req *cmd_req,
+			 unsigned int issue_flags)
+{
+	struct fuse_ring_queue *queue;
+	int ret;
+
+	if (!(issue_flags & IO_URING_F_SQE128)) {
+		pr_info("qid=%d tag=%d SQE128 not set\n",
+			cmd_req->qid, cmd_req->tag);
+		ret =  -EINVAL;
+		goto err;
+	}
+
+	if (unlikely(fc->ring.stop_requested)) {
+		ret = -ENOTCONN;
+		goto err;
+	}
+
+	if (unlikely(!fc->ring.configured)) {
+		pr_info("command for a conection that is not ring configure\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	if (unlikely(cmd_req->qid >= fc->ring.nr_queues)) {
+		pr_devel("qid=%u >= nr-queues=%zu\n",
+			cmd_req->qid, fc->ring.nr_queues);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	queue = fuse_uring_get_queue(fc, cmd_req->qid);
+	if (unlikely(queue == NULL)) {
+		pr_info("Got NULL queue for qid=%d\n", cmd_req->qid);
+		ret = -EIO;
+		goto err;
+	}
+
+	if (unlikely(!fc->ring.configured || !queue->configured ||
+		     queue->aborted)) {
+		pr_info("Ring or queue (qid=%u) not ready.\n", cmd_req->qid);
+		ret = -ENOTCONN;
+		goto err;
+	}
+
+	if (cmd_req->tag > fc->ring.queue_depth) {
+		pr_info("tag=%u > queue-depth=%zu\n",
+			cmd_req->tag, fc->ring.queue_depth);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	return queue;
+
+err:
+	return ERR_PTR(ret);
+}
+
+/**
+ * Entry function from io_uring to handle the given passthrough command
+ * (op cocde IORING_OP_URING_CMD)
+ */
+int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
+{
+	const struct fuse_uring_cmd_req *cmd_req =
+		(struct fuse_uring_cmd_req *)cmd->cmd;
+	struct fuse_dev *fud = fuse_get_dev(cmd->file);
+	struct fuse_conn *fc = fud->fc;
+	struct fuse_ring_queue *queue;
+	struct fuse_ring_ent *ring_ent = NULL;
+	u32 cmd_op = cmd->cmd_op;
+	u64 prev_state;
+	int ret = 0;
+
+	queue = fuse_uring_get_verify_queue(fc, cmd_req, issue_flags);
+	if (IS_ERR(queue)) {
+		ret = PTR_ERR(queue);
+		goto out;
+	}
+
+	ring_ent = &queue->ring_ent[cmd_req->tag];
+
+	pr_devel("%s:%d received: cmd op %d qid %d (%p) tag %d  (%p)\n",
+		 __func__, __LINE__,
+		 cmd_op, cmd_req->qid, queue, cmd_req->tag, ring_ent);
+
+	spin_lock(&queue->lock);
+	if (unlikely(queue->aborted)) {
+		/* XXX how to ensure queue still exists? Add
+		 * an rw fc->ring.stop lock? And take that at the beginning
+		 * of this function? Better would be to advise uring
+		 * not to call this function at all? Or free the queue memory
+		 * only, on daemon PF_EXITING?
+		 */
+		ret = -ENOTCONN;
+		spin_unlock(&queue->lock);
+		goto out;
+	}
+
+	prev_state = ring_ent->state;
+	ring_ent->state |= FRRS_FUSE_FETCH_COMMIT;
+	ring_ent->state &= ~FRRS_USERSPACE;
+	ring_ent->need_cmd_done = 1;
+	spin_unlock(&queue->lock);
+
+	switch (cmd_op) {
+	case FUSE_URING_REQ_FETCH:
+		if (prev_state != FRRS_INIT) {
+			pr_info_ratelimited("register req state %llu expected %d",
+					    prev_state, FRRS_INIT);
+			ret = -EINVAL;
+			goto out;
+
+			/* XXX error injection or test with malicious daemon */
+		}
+
+		ret = fuse_uring_fetch(ring_ent, cmd);
+		break;
+	default:
+		ret = -EINVAL;
+		pr_devel("Unknown uring command %d", cmd_op);
+		goto out;
+	}
+
+out:
+	pr_devel("uring cmd op=%d, qid=%d tag=%d ret=%d\n",
+		 cmd_op, cmd_req->qid, cmd_req->tag, ret);
+
+	if (ret < 0) {
+		if (ring_ent != NULL) {
+			spin_lock(&queue->lock);
+			ring_ent->state |= (FRRS_CMD_ERR | FRRS_USERSPACE);
+			ring_ent->need_cmd_done = 0;
+			spin_unlock(&queue->lock);
+		}
+		io_uring_cmd_done(cmd, ret, 0);
+	}
+
+	return -EIOCBQUEUED;
+}
-- 
2.37.2

