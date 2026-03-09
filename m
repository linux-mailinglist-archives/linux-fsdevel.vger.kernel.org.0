Return-Path: <linux-fsdevel+bounces-79823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFiILD8Fr2knLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:37:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658523DB80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CB50306308F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A43D667C;
	Mon,  9 Mar 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hTUCIqxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB12F2917;
	Mon,  9 Mar 2026 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077713; cv=none; b=kRvwUaa5RudYFMlHeFY/6VIGPl5ImWJq23SpXu/X5Eihg86zKjEN5tLAkDzfeACOJvdZlDcZhm7efkROtVRRehH4GGvuwVutK8kAHFMuLwpELZ63v5V8vyHd04LRJR6q1XgmI9jUcUH66Ntw1P7e+syQKNSqjAE6hFKPm8dXMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077713; c=relaxed/simple;
	bh=j4sUcbsuYJwStlmhgY/x3BZTwAfypn5EVOk16d5gtg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrUurCA2eLIdgPONczq7tK8kO9aoi4s/CmWpeerxN3xDwooXhvOL+pLXzPM+qJUTjYMGTo6uhXTgqgg0jAAFb89/VYbb/MXxxzpK+3kEKWEdTvK1Z/4jGIRgStKT4LEpb68Lo7RIn2m2BpwnxoGTrlf+mfq603Vh5F9mhXdCHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hTUCIqxR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629GNkiE1714112;
	Mon, 9 Mar 2026 17:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4Gdi+HnarVxQdZjQc
	JA+IRAfj/HaWPzRwJfOlnge+Eo=; b=hTUCIqxRFXhkX0Sf0WobyZIgsFBzgRlHu
	R+vfYrqcX/KNWD1C7cnbFks/jcwBoipgnDo0kpRH3Wwwq55BGK4WD63xatFB4RW0
	maUiJliXYWX86rzjiU5GvxkS1OlX2sHLfguQSQZveZLQjW9YHSQ0FoHLY7nTVQmi
	AR5MxV+QSTs3MhbJKEFpvcvg1ip1kFmYUJiHTdArygQbSbFVOmgM9NwH4AbqhrMN
	d8ock+66E1DSpCquwYTFXgAgItXE3PSvgaPaBTvfzjW9xVcKdpOq7Vc6w2vlAP4s
	yfLhQM6N+knJmAC9kdtre420BAjf60m+W4WlKWwbsQAL+7cjprbDg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun7fw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 17:34:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629DNmoN021181;
	Mon, 9 Mar 2026 17:34:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsp2wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 17:34:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629HYlPf23069128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 17:34:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4050520043;
	Mon,  9 Mar 2026 17:34:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3899420040;
	Mon,  9 Mar 2026 17:34:44 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.68])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 17:34:44 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz,
        Luis Chamberlain <mcgrof@kernel.org>, dgc@kernel.org, tytso@mit.edu,
        p.raghav@samsung.com, andres@anarazel.de, linux-kernel@vger.kernel.org
Subject: [RFC 3/3] xfs: Add RWF_WRITETHROUGH support to xfs
Date: Mon,  9 Mar 2026 23:04:33 +0530
Message-ID: <d290d3adb151e7b52f8806cb2e8e4a49c296b66c.1773076216.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773076216.git.ojaswin@linux.ibm.com>
References: <cover.1773076216.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UIBwevUa3z-Q6wxrL-ksuBCMPc2vHXht
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69af04ba cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=dL4gkamcldjQg1gMlL4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1OCBTYWx0ZWRfXxvJ+V31YIYAZ
 Z4y1rid42DxdKafmrWbW1T6SRMJGtUQS9k4afyokZ50ggt+C9f+Q4DrisxqYWCSH2BDR+t5uDJE
 pvDbSypF3VZatyb3usL+Obu+Xm+5//inTE6zFtmzfIufWg1N1u/AoUl5Jqn4s255scId7v9qBKv
 cEkCN2cfuiNgpAXn09MbLjtvkyfNJXmkI+06K5HRnMBxec06xwsxbx6NFQ+HYLcIIBB67F+sivY
 ughD+U0zN4qOZVMsLmgTxX1u2cncn044lKWUxJjUaBctTav+rlpJ3kzALC0iJPYr1L1QD4RpbFT
 PKXeqrsS0rYMJjHxV1iMxxEakgQLORFUlyaYC1uFWbrgTUIMnfvG76WvWuVltOR2R2jt79QLur9
 mve1e821iINPjYejo2AP9nMRbORjI5yQoGl2hzTClwmVkgAoxlItTuNuNQDYxNELBRZNF9H4umG
 C54kaeGVoq/9p71Vuxw==
X-Proofpoint-ORIG-GUID: I7FX4cEY2_lZVKb2vZf5GmPjDv9sM842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090158
X-Rspamd-Queue-Id: 3658523DB80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,infradead.org,lst.de,gmail.com,suse.cz,mit.edu,samsung.com,anarazel.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79823-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Add the boilerplate needed to start supporting RWF_WRITETHROUGH in XFS.
We use the direct wirte ->iomap_begin() functions to ensure the range
under write back always has a real non-delalloc extent. We reuse the
xfs dio's end IO function to perform extent conversion and i_size handling
for us.

*Note on EOF edge case*

Buffered writethrough IO uses dio path but allows non block aligned
writes. The IO we submit is later rounded to block size boundary.
However, for end io processing, we must pass the original range to
xfs_dio_write_end_io(). This is important for non block-aligned EOF
writes because otherwise XFS might update the i_size to more than what
the user originally wrote, exposing stale data.

Hence, add a wrapper over xfs_dio_write_end_io() to modify iocb->ki_pos
and the size of IO to correspond to the original range, so that our
extent conversion and i_size updates are correct.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/xfs/xfs_file.c | 68 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 6246f34df9fd..3eb868a2ba63 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -657,6 +657,55 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
 	.end_io		= xfs_dio_write_end_io,
 };
 
+/*
+ * *Note on EOF edge case*
+ *
+ * Buffered writethrough IO uses dio path but allows non block aligned
+ * writes. The IO we submit is later rounded to block size boundary.
+ * However, for end io processing, we must pass the original range to
+ * xfs_dio_write_end_io(). This is important for non block-aligned EOF
+ * writes because otherwise XFS might update the i_size to more than what
+ * the user originally wrote, exposing stale data.
+ *
+ * Hence, modify iocb->ki_pos and the size of IO to correspond to the original
+ * range, so that our extent conversion and i_size updates are correct.
+ */
+static int
+xfs_writethrough_end_io(
+	struct kiocb		*iocb,
+	ssize_t			size,
+	int			error,
+	unsigned		flags)
+{
+	struct iomap_writethrough_ctx *wt_ctx =
+		container_of(iocb, struct iomap_writethrough_ctx, iocb);
+	loff_t len = wt_ctx->orig_len;
+	loff_t end  = iocb->ki_pos + size;
+	loff_t orig_end  = wt_ctx->orig_pos + wt_ctx->orig_len;
+
+	/*
+	 * We have a short write that didn't even cover the original range.
+	 * Nothing to do
+	 */
+	if (end <= wt_ctx->orig_pos)
+		return 0;
+
+	/*
+	 * Short write partially covers original range. Trim the range to short
+	 * write's end.
+	 */
+	if (end < orig_end)
+		len = end - wt_ctx->orig_pos;
+
+	iocb->ki_pos = wt_ctx->orig_pos;
+
+	return xfs_dio_write_end_io(iocb, len, error, flags);
+}
+
+static const struct iomap_dio_ops xfs_dio_writethrough_ops = {
+	.end_io		= xfs_writethrough_end_io,
+};
+
 static void
 xfs_dio_zoned_submit_io(
 	const struct iomap_iter	*iter,
@@ -988,6 +1037,13 @@ xfs_file_dax_write(
 	return ret;
 }
 
+const struct iomap_writethrough_ops xfs_writethrough_ops = {
+	.ops			= &xfs_direct_write_iomap_ops,
+	.write_ops		= &xfs_iomap_write_ops,
+	.dio_ops		= &xfs_dio_writethrough_ops,
+};
+
+
 STATIC ssize_t
 xfs_file_buffered_write(
 	struct kiocb		*iocb,
@@ -1010,9 +1066,13 @@ xfs_file_buffered_write(
 		goto out;
 
 	trace_xfs_file_buffered_write(iocb, from);
-	ret = iomap_file_buffered_write(iocb, from,
-			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
-			NULL);
+	if (iocb->ki_flags & IOCB_WRITETHROUGH) {
+		ret = iomap_file_writethrough_write(iocb, from,
+						    &xfs_writethrough_ops, NULL);
+	} else
+		ret = iomap_file_buffered_write(iocb, from,
+						&xfs_buffered_write_iomap_ops,
+						&xfs_iomap_write_ops, NULL);
 
 	/*
 	 * If we hit a space limit, try to free up some lingering preallocated
@@ -2042,7 +2102,7 @@ const struct file_operations xfs_file_operations = {
 	.remap_file_range = xfs_file_remap_range,
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
 			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE |
-			  FOP_DONTCACHE,
+			  FOP_DONTCACHE | FOP_WRITETHROUGH,
 	.setlease	= generic_setlease,
 };
 
-- 
2.52.0


