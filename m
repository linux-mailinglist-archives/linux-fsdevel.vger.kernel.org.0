Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463474C033A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 21:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiBVUgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 15:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbiBVUgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:36:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7002E148912;
        Tue, 22 Feb 2022 12:35:26 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MJ097K029905;
        Tue, 22 Feb 2022 20:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=lm7vEcf7E5kxi61dUMVie10tEqYYPxipqK7Satbd0Fc=;
 b=d/NpxNHAk05gRkT1uednuerEzYChNk4DmckJXy8Bhn0wXse0YKWovp5X5id4rV/5q7wR
 xiZQ5C7uo928mHjdqog/uArPB2WTROT1YvpiqJYLlf3+9h7Ni5zeqv1FZP8pMggYjev1
 3fXxdwdLOKXewGaN1yJvHVP+ghUTl5hqY/El59Al9LQKpjJnMExB80iwcO1d/i6Veukm
 K1QzjukwV3C0KN50FQWB+f7z61KrMUlaFKj6InUHQqDuatRUnntmueLNdHlRk5qvTwjP
 oDYfFtFuJur1ezvcvd4KaC/Y3hdlZLHQBW5Cln9d8FAVeSmOkuWjHqcPb/ZKyMvwskg4 iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed394e5k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:22 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MKX355015734;
        Tue, 22 Feb 2022 20:35:22 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed394e5jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:22 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MKJeHT007371;
        Tue, 22 Feb 2022 20:35:20 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3ear694d2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MKZIBk51511712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 20:35:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 346CEAE056;
        Tue, 22 Feb 2022 20:35:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5F6BAE045;
        Tue, 22 Feb 2022 20:35:17 +0000 (GMT)
Received: from localhost (unknown [9.43.75.136])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 20:35:17 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 9/9] ext4: fast_commit missing tracking updates to a file
Date:   Wed, 23 Feb 2022 02:04:17 +0530
Message-Id: <e91b6872860df3ec520799a5d0b65e54ccf32407.1645558375.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1645558375.git.riteshh@linux.ibm.com>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X6ARLVxneOIpM3uoRXoYEFd_oUNq3ep2
X-Proofpoint-GUID: teRPCuhaasiqS_kXSbKGW0A8RDaBRmtX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_07,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

<DO NOT MERGE THIS YET>

Testcase
==========
1. i=0; while [ $i -lt 1000 ]; do xfs_io -f -c "pwrite -S 0xaa -b 32k 0 32k" -c "fsync" /mnt/$i; i=$(($i+1)); done && sudo ./src/godown -v /mnt && sudo umount /mnt && sudo mount /dev/loop2 /mnt'
2. ls -alih /mnt/ -> In this you will observe one such file with 0 bytes (which ideally should not happen)

^^^ say if you don't see the issue because your underlying storage
device is very fast, then maybe try with commit=1 mount option.

Analysis
==========
It seems a file's updates can be a part of two transaction tid.
Below are the sequence of events which could cause this issue.

jbd2_handle_start -> (t_tid = 38)
__ext4_new_inode
ext4_fc_track_template -> __track_inode -> (i_sync_tid = 38, t_tid = 38)
<track more updates>
jbd2_start_commit -> (t_tid = 38)

jbd2_handle_start (tid = 39)
ext4_fc_track_template -> __track_inode -> (i_sync_tid = 38, t_tid 39)
    -> ext4_fc_reset_inode & ei->i_sync_tid = t_tid

ext4_fc_commit_start -> (will wait since jbd2 full commit is in progress)
jbd2_end_commit (t_tid = 38)
    -> jbd2_fc_cleanup() -> this will cleanup entries in sbi->s_fc_q[FC_Q_MAIN]
        -> And the above could result inode size as 0 as  after effect.
ext4_fc_commit_stop

You could find the logs for the above behavior for inode 979 at [1].

-> So what is happening here is since the ei->i_fc_list is not empty
(because it is already part of sb's MAIN queue), we don't add this inode
again into neither sb's MAIN or STAGING queue.
And after jbd2_fc_cleanup() is called from jbd2 full commit, we
just remove this inode from the main queue.

So as a simple fix, what I did below was to check if it is a jbd2 full commit
in ext4_fc_cleanup(), and if the ei->i_sync_tid > tid, that means we
need not remove that from MAIN queue. This is since neither jbd2 nor FC
has committed updates of those inodes for this new txn tid yet.

But below are some quick queries on this
=========================================

1. why do we call ext4_fc_reset_inode() when inode tid and
   running txn tid does not match?

2. Also is this an expected behavior from the design perspective of
   fast_commit. i.e.
   a. the inode can be part of two tids?
   b. And that while a full commit is in progress, the inode can still
   receive updates but using a new transaction tid.

Frankly speaking, since I was also working on other things, so I haven't
yet got the chance to completely analyze the situation yet.
Once I have those things sorted, I will spend more time on this, to
understand it more. Meanwhile if you already have some answers to above
queries/observations, please do share those here.

Links
=========
[1] https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/ext4/fast_commit/fc_inode_missing_updates_ino_979.txt

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/fast_commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8803ba087b07..769b584c2552 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1252,6 +1252,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
 				 i_fc_list) {
+		if (full && iter->i_sync_tid > tid)
+			continue;
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-- 
2.31.1

