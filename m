Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D9948D0E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 04:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiAMD0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 22:26:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231983AbiAMD0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:26:45 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D2PUeu008922;
        Thu, 13 Jan 2022 03:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=v78yGgeDZFl5IT6BvF4m4QZiJgGeCfcZrZNKYT09JYc=;
 b=G2+SQEhSo7neb20hY6ee5JdRSrTVudmdPKk+FSM1H4LTPJHPURphE6rPQ06XVUxWOa2l
 cH+c8G5W7cC8MTV6rJtZmrMfxmckr+RO3OY59cFUd5nEeBGCMe8UvMm092kwmClDbYan
 m7WkXw/XRE2MhgkuhC/Otzy1mLyqzNp0H8BAh7EVWnHPDmlxTjItwOwxKt3tTKX+612z
 DXAqpKVp3p6iTS/ctCbJMnrR1iVsQEk4RdJHOgk+AijDW7oEv5LEJpX8On1GaCXS/x+6
 6UP+L/o06VE88AyZVKdoH8oX06i9q5YBgCc46kLBkqJNRTDOSCPJrln1I4Wl4EHXRRNT UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dj79pvgff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:38 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20D3Fnxc025792;
        Thu, 13 Jan 2022 03:26:38 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dj79pvgf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:38 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20D3D19h032232;
        Thu, 13 Jan 2022 03:26:36 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3df289prba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20D3QXBv39321980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 03:26:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8315A405E;
        Thu, 13 Jan 2022 03:26:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57E3EA4053;
        Thu, 13 Jan 2022 03:26:33 +0000 (GMT)
Received: from localhost (unknown [9.43.54.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 03:26:33 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 0/6] ext4/jbd2: inline_data fixes and some cleanups
Date:   Thu, 13 Jan 2022 08:56:23 +0530
Message-Id: <cover.1642044249.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OUiwFAEpHtx9vm1RPxXf2QLgpI1xRwT1
X-Proofpoint-GUID: AS_53x8ubC0iSzGfxZtRZMv5-c1Pqgde
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_01,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=486 impostorscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130013
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hellos,

Patch[1]: fixes BUG_ON with inline_data which was reported [1] with generic/475.

Patch[2]: is mostly cleanup found during code review of inline_data code.

Patch[3]: is a possible memory corruption fix in case of krealloc failure.

Patch[4-5]: Cleanups.

Patch[6]: Needs careful review. As it gets rid of t_handle_lock spinlock
in jbd2_journal_wait_updates(). From the code review I found it to be not
required. But let me know if I missed anything here.

[1]: https://lore.kernel.org/linux-ext4/20210527192418.GA2633@localhost.localdomain/

Ritesh Harjani (6):
  ext4: Fix error handling in ext4_restore_inline_data()
  ext4: Remove redundant max inline_size check in ext4_da_write_inline_data_begin()
  ext4: Fix error handling in ext4_fc_record_modified_inode()
  jbd2: Cleanup unused functions declarations from jbd2.h
  jbd2: Refactor wait logic for transaction updates into a common function
  jbd2: No need to use t_handle_lock in jbd2_journal_wait_updates

 fs/ext4/fast_commit.c | 64 ++++++++++++++++++++-----------------------
 fs/ext4/inline.c      | 23 +++++++++-------
 fs/jbd2/commit.c      | 19 ++-----------
 fs/jbd2/transaction.c | 24 ++--------------
 include/linux/jbd2.h  | 34 +++++++++++++++++------
 5 files changed, 74 insertions(+), 90 deletions(-)

--
2.31.1

