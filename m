Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B8490870
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 13:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiAQMM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 07:12:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239690AbiAQMMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:12:19 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HB7Rec004490;
        Mon, 17 Jan 2022 12:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rpL+GBywbexK5msApOLS5dMDW6ObgpCA97uLf0iYFkY=;
 b=jrj7X866Plsde7uIMn97/ktkO05tzQuxnj6MaxlaISBeiW7nNXBfirQ0JnzmZFjVtgdO
 YOXW768klnKs2xO0qVe2ZBZOxW/sptvHTOz9wdcqnBVjhmjG1XSnlgW23QQsjCb1HB0z
 T9dRa6GRMY+h60mosUHQC+JIq8qU6avYhbrpJ7Wb8RHFVdNEsDDE1TuMOsvEa1BBFpOq
 u2nTz5o2mQZJMtV4yKrDUHnw8+hZyFEpTMSrQ00tQXtQc0wrvinzaM0hxaiyclLYkIm+
 8jI/Bp0qKlAr39RkaDhT2vmGmQfLxcLC6KdgdPxtB1Lz9lSyYcsIwRa6xQ9DKS4W0fAd VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dn4ysmmwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:10 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20HC9eGA007470;
        Mon, 17 Jan 2022 12:12:10 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dn4ysmmvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20HC73v0000374;
        Mon, 17 Jan 2022 12:12:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhj3sky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20HCC5l143188650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 12:12:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9648DA4055;
        Mon, 17 Jan 2022 12:12:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33BF3A404D;
        Mon, 17 Jan 2022 12:12:05 +0000 (GMT)
Received: from localhost (unknown [9.43.45.117])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jan 2022 12:12:04 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: [PATCHv2 4/5] jbd2: Cleanup unused functions declarations from jbd2.h
Date:   Mon, 17 Jan 2022 17:41:50 +0530
Message-Id: <30d1fc327becda197a4136cf9cdc73d9baa3b7b9.1642416995.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642416995.git.riteshh@linux.ibm.com>
References: <cover.1642416995.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KDgxB9t2_Vtr70c8bWtdFWv2P_gA9hRB
X-Proofpoint-ORIG-GUID: PguP-RKU7oE4zgIo02pqyBETxqvmiz8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_05,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=452 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201170077
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During code review found no references of few of these below function
declarations. This patch cleans those up from jbd2.h

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/jbd2.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index fd933c45281a..f76598265896 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1419,9 +1419,7 @@ extern void jbd2_journal_unfile_buffer(journal_t *, struct journal_head *);
 extern bool __jbd2_journal_refile_buffer(struct journal_head *);
 extern void jbd2_journal_refile_buffer(journal_t *, struct journal_head *);
 extern void __jbd2_journal_file_buffer(struct journal_head *, transaction_t *, int);
-extern void __journal_free_buffer(struct journal_head *bh);
 extern void jbd2_journal_file_buffer(struct journal_head *, transaction_t *, int);
-extern void __journal_clean_data_list(transaction_t *transaction);
 static inline void jbd2_file_log_bh(struct list_head *head, struct buffer_head *bh)
 {
 	list_add_tail(&bh->b_assoc_buffers, head);
@@ -1486,9 +1484,6 @@ extern int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 					      struct buffer_head **bh_out,
 					      sector_t blocknr);
 
-/* Transaction locking */
-extern void		__wait_on_journal (journal_t *);
-
 /* Transaction cache support */
 extern void jbd2_journal_destroy_transaction_cache(void);
 extern int __init jbd2_journal_init_transaction_cache(void);
@@ -1774,8 +1769,6 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
 #define BJ_Reserved	4	/* Buffer is reserved for access by journal */
 #define BJ_Types	5
 
-extern int jbd_blocks_per_page(struct inode *inode);
-
 /* JBD uses a CRC32 checksum */
 #define JBD_MAX_CHECKSUM_SIZE 4
 
-- 
2.31.1

