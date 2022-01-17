Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF1E490861
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 13:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbiAQMMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 07:12:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239566AbiAQMMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:12:12 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HAQiTl028585;
        Mon, 17 Jan 2022 12:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ePlWrfXeQSjPqPELlVtlVqdW/MNwtNzvwNj72l+xVb8=;
 b=rZzl+9Qx7C+0JTs41JowR9QdAV29RyNkVaTsrPQj1qB5qUO7CLHweYs94nkCvBTQmlPG
 KB73Tt5DQo5GkMyr0NQohAPUelnUULKlvqNUTdH8pq6C+cxP+clwlGHNw21UVQXy/ZJn
 cooOL/QPiQOTe/P7PrW4A0RBOjBB64Qg3KyNkUE9CGBbIVwrbGk4zl8J8d1yEDXWm/eb
 kdFkG7oT7kDZynytWBcZJ73311VZwAvrxhWhYnbrKVJaBm37L1Kxn4sYQRIOn9KOurM8
 d4dRzV5nwVXffcMZrxMQV6uHqSwmpymKHUe1UyZtRa4MsgO/XDXYaOUE6UP5z7lNsuUV XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dn6q7a924-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:04 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20HBdNMU007276;
        Mon, 17 Jan 2022 12:12:03 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dn6q7a91k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:03 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20HC71XK028680;
        Mon, 17 Jan 2022 12:12:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3dknw9br2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20HC2jsI42140064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 12:02:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 874BCA4059;
        Mon, 17 Jan 2022 12:11:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2397EA4040;
        Mon, 17 Jan 2022 12:11:59 +0000 (GMT)
Received: from localhost (unknown [9.43.45.117])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jan 2022 12:11:58 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 0/5] ext4/jbd2: inline_data fixes and minor cleanups
Date:   Mon, 17 Jan 2022 17:41:46 +0530
Message-Id: <cover.1642416995.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HPcCaafScTUjtW9lhc9f7NbbHDON7_WQ
X-Proofpoint-GUID: SLarXViisqWBuLXZugH_aqflRw8D8FVv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_05,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=729 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201170077
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Please find v2 of the inline_data fixes and some minor cleanups found during
code review.

I have dropped patch-6 in v2 which was removing use of t_handle_lock (spinlock)
from within jbd2_journal_wait_updates(). Based on Jan comments, I feel we can
push that as killing of t_handle_lock into a separate series (which will be on
top of this).

v1 -> v2
========
1. Added Jan's Reviewed-by tag & addressed one of his comment on no need to make
jbd2_journal_wait_updates() function inline.
2. Dropped patch-6 as described above.

Description
============
Patch[1]: fixes BUG_ON with inline_data which was reported [1] with generic/475.

Patch[2]: is mostly cleanup found during code review of inline_data code.

Patch[3]: is a possible memory corruption fix in case of krealloc failure.

Patch[4-5]: Cleanups.

[v1]: https://lore.kernel.org/linux-ext4/cover.1642044249.git.riteshh@linux.ibm.com/T/

Ritesh Harjani (5):
  ext4: Fix error handling in ext4_restore_inline_data()
  ext4: Remove redundant max inline_size check in ext4_da_write_inline_data_begin()
  ext4: Fix error handling in ext4_fc_record_modified_inode()
  jbd2: Cleanup unused functions declarations from jbd2.h
  jbd2: Refactor wait logic for transaction updates into a common function

 fs/ext4/fast_commit.c | 64 ++++++++++++++++++++-----------------------
 fs/ext4/inline.c      | 23 +++++++++-------
 fs/jbd2/commit.c      | 19 ++-----------
 fs/jbd2/transaction.c | 53 +++++++++++++++++++++--------------
 include/linux/jbd2.h  | 11 ++------
 5 files changed, 80 insertions(+), 90 deletions(-)

--
2.31.1

