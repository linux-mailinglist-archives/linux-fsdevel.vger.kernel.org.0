Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2324B818C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiBPH2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:28:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiBPH2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:28:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E01215A32;
        Tue, 15 Feb 2022 23:28:32 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G6CxUi012974;
        Wed, 16 Feb 2022 07:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=j2vv7zVutDpVpmewSeDfg/m0oj+u/BkEkjga7tkasRU=;
 b=ijx7UphFa+me0vV3rgd8h1jEJ93t1oK5x2kdii73YuxqclnblZze6dCNJi+GPjlFD1fV
 2RYSTLk99RyygbttM4VqoBjOLoCfOegrqtphNVPF3HVkb1nHiA01hAozmyF7tG/TDOvV
 3u5h0AuK6L6WrDrr/J4/sbaqIlKu78hZqs3hPNC9+08rTf/0dnlANZHH4gGdZAroZAls
 hMt+1bQTUahPB0a9cKUG5BdnvwGvlZPGXSBTVrswvvFjGLe2uQubgLZOxEruGPrEGn1t
 LCYJJJLYnFkrCGtKQ9EDZKq75gU8mjk5VEw3G5m+w399SPaVaY7tkfNk1s31ZCbrcXpn 4A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8spgb5e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:00:57 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21G6q7kE022070;
        Wed, 16 Feb 2022 07:00:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3e64h9ky9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:00:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21G6oSxg43188530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 06:50:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 564F95204E;
        Wed, 16 Feb 2022 07:00:51 +0000 (GMT)
Received: from localhost (unknown [9.43.85.173])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E574852063;
        Wed, 16 Feb 2022 07:00:50 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 REBASED 2/2] jbd2: Remove CONFIG_JBD2_DEBUG to update t_max_wait
Date:   Wed, 16 Feb 2022 12:30:36 +0530
Message-Id: <ad7319a601fd501079310747ce87d908e0944763.1644992076.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644992076.git.riteshh@linux.ibm.com>
References: <cover.1644992076.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LqmwldJ2SPCHkJIkwvTIriLQ38uEDIl6
X-Proofpoint-ORIG-GUID: LqmwldJ2SPCHkJIkwvTIriLQ38uEDIl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_02,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=631
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 83801a8be078..73ed02f061e1 100644
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

