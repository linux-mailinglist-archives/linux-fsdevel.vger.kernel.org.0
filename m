Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5DC49738D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jan 2022 18:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiAWRYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jan 2022 12:24:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38326 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239251AbiAWRX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:23:57 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20NGfXn0009075;
        Sun, 23 Jan 2022 17:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VPXKgDc+/o6IEC6okWKklSyz1nt6Ay9Hu0WpikTlCgY=;
 b=aCPR3dKKbefPSus+HIzs6DJn5jNQa2XCjpa2hvJU+Em5T7UKBm84i9a55UXOb2BlgmbI
 bpjNvA362S2LLVt9fh8KBf52O7KbX8g24vy9fIVjm0ZGI5yY6pa1EYC6rUUQz+jXGvFU
 8X8BP8KauxCNjX+sknjsaZRou9uv3r0XQFr8bJmRHYczBkws7V6cGePFZzv6Yymn69Ef
 LBnggZczrdhMLr9RgbziaVqJ4FWd39Jy4sa/YPZVNgvofRkuEhf549E2ypmOdbsp+IOb
 8GDn+809ZLHLGDEiA8cy8Dc2E46rY7YJNwdaZGdO4GWcKD4URfuiBcbHZV48M3h8l/Qt JQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dsarqre6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jan 2022 17:23:52 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20NHD2er023675;
        Sun, 23 Jan 2022 17:23:50 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3dr9j8ppve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jan 2022 17:23:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20NHNmAN37945738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jan 2022 17:23:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EB484C046;
        Sun, 23 Jan 2022 17:23:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19E554C040;
        Sun, 23 Jan 2022 17:23:46 +0000 (GMT)
Received: from localhost (unknown [9.43.59.179])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 23 Jan 2022 17:23:45 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 2/2] jbd2: Remove CONFIG_JBD2_DEBUG to update t_max_wait
Date:   Sun, 23 Jan 2022 22:53:28 +0530
Message-Id: <c1424ac2e6f6f5a21bcf2fb7679203df865c8a60.1642953021.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642953021.git.riteshh@linux.ibm.com>
References: <cover.1642953021.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DHCJZvCUwtFXrW94og8llrKT-W8fpKpT
X-Proofpoint-ORIG-GUID: DHCJZvCUwtFXrW94og8llrKT-W8fpKpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-23_05,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxlogscore=738 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201230132
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CONFIG_JBD2_DEBUG and jbd2_journal_enable_debug knobs were added in
update_t_max_wait(), since earlier it used to take a spinlock for updating
t_max_wait, which could cause a bottleneck while starting a txn
(start_this_handle()).
Since in previous patch, we have killed t_handle_lock completely, we
could get rid of this debug config and knob to let t_max_wait be updated
by default again.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/jbd2/transaction.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 68dd7de49aff..77634e2e118e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -141,20 +141,19 @@ static void jbd2_get_transaction(journal_t *journal,
  * t_max_wait is carefully updated here with use of atomic compare exchange.
  * Note that there could be multiplre threads trying to do this simultaneously
  * hence using cmpxchg to avoid any use of locks in this case.
+ * With this t_max_wait can be updated w/o enabling jbd2_journal_enable_debug.
  */
 static inline void update_t_max_wait(transaction_t *transaction,
 				     unsigned long ts)
 {
-#ifdef CONFIG_JBD2_DEBUG
 	unsigned long oldts, newts;
-	if (jbd2_journal_enable_debug &&
-	    time_after(transaction->t_start, ts)) {
+
+	if (time_after(transaction->t_start, ts)) {
 		newts = jbd2_time_diff(ts, transaction->t_start);
 		oldts = READ_ONCE(transaction->t_max_wait);
 		while (oldts < newts)
 			oldts = cmpxchg(&transaction->t_max_wait, oldts, newts);
 	}
-#endif
 }

 /*
--
2.31.1

