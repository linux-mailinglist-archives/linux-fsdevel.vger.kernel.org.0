Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC648D0EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 04:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiAMD1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 22:27:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232099AbiAMD06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:26:58 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D2wa9j017497;
        Thu, 13 Jan 2022 03:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ww2jh4d+fdt9LEZUsFmss7RosoPwGKnkRb9wtuX1Egg=;
 b=ckSr75zOC++ttRQzRCuWfIHBXyw5kwjAcxqbjV2oUOjAjbmuLtv0qWxmoU6aDFgKO9XF
 xn8Uqg0Yp9suTM23aMh/D6Q5B3d37jGjnhXrjoXbOdgy8BAbNXU3ewnn5dG4NvVX+DC0
 Hq5095CcBpe8r3qeDkUO+e2OfaLUqUq5S40QE5BoYwNk5SwLoEvQlsfSH2o0hxntfYM2
 hQ9M7oDc7xNU1dMRccIEJyJLAwKhJE8LD+FVQTQVKchkJZJACqfzsiZIIInnAgFHky9h
 DjBGr3EUC9MTQTvk9ko93znMt13sFTVsDLaGWhm4y6I6tkJNrKfycTJUggePiDpt1rPn ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djbs5rc62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:51 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20D3MOeo025411;
        Thu, 13 Jan 2022 03:26:50 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djbs5rc5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:50 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20D3D19l032232;
        Thu, 13 Jan 2022 03:26:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3df289prby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20D3QkQL44106162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 03:26:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 163F4A405C;
        Thu, 13 Jan 2022 03:26:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E3E2A4054;
        Thu, 13 Jan 2022 03:26:45 +0000 (GMT)
Received: from localhost (unknown [9.43.54.234])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 03:26:45 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 5/6] jbd2: Refactor wait logic for transaction updates into a common function
Date:   Thu, 13 Jan 2022 08:56:28 +0530
Message-Id: <95fa94cbeb4bb0275430a6721a588bd738d5a9aa.1642044249.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642044249.git.riteshh@linux.ibm.com>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: anh63y-uxqlYk8v1vubB4TnmAtu3xVm1
X-Proofpoint-GUID: tE5esPJINrJ8pHeZRLi0WwBQAaVrpga0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_01,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=814 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130013
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No functionality change as such in this patch. This only refactors the
common piece of code which waits for t_updates to finish into a common
function named as jbd2_journal_wait_updates(journal_t *)

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/jbd2/commit.c      | 19 +++----------------
 fs/jbd2/transaction.c | 24 +++---------------------
 include/linux/jbd2.h  | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 3cc4ab2ba7f4..428364f107be 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -484,22 +484,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	stats.run.rs_running = jbd2_time_diff(commit_transaction->t_start,
 					      stats.run.rs_locked);
 
-	spin_lock(&commit_transaction->t_handle_lock);
-	while (atomic_read(&commit_transaction->t_updates)) {
-		DEFINE_WAIT(wait);
+	// waits for any t_updates to finish
+	jbd2_journal_wait_updates(journal);
 
-		prepare_to_wait(&journal->j_wait_updates, &wait,
-					TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&commit_transaction->t_updates)) {
-			spin_unlock(&commit_transaction->t_handle_lock);
-			write_unlock(&journal->j_state_lock);
-			schedule();
-			write_lock(&journal->j_state_lock);
-			spin_lock(&commit_transaction->t_handle_lock);
-		}
-		finish_wait(&journal->j_wait_updates, &wait);
-	}
-	spin_unlock(&commit_transaction->t_handle_lock);
 	commit_transaction->t_state = T_SWITCH;
 	write_unlock(&journal->j_state_lock);
 
@@ -817,7 +804,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	commit_transaction->t_state = T_COMMIT_DFLUSH;
 	write_unlock(&journal->j_state_lock);
 
-	/* 
+	/*
 	 * If the journal is not located on the file system device,
 	 * then we must flush the file system device before we issue
 	 * the commit record
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 6a3caedd2285..89a955ab1557 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -449,7 +449,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	}
 
 	/* OK, account for the buffers that this operation expects to
-	 * use and add the handle to the running transaction. 
+	 * use and add the handle to the running transaction.
 	 */
 	update_t_max_wait(transaction, ts);
 	handle->h_transaction = transaction;
@@ -863,27 +863,9 @@ void jbd2_journal_lock_updates(journal_t *journal)
 		write_lock(&journal->j_state_lock);
 	}
 
-	/* Wait until there are no running updates */
-	while (1) {
-		transaction_t *transaction = journal->j_running_transaction;
+	/* Wait until there are no running t_updates */
+	jbd2_journal_wait_updates(journal);
 
-		if (!transaction)
-			break;
-
-		spin_lock(&transaction->t_handle_lock);
-		prepare_to_wait(&journal->j_wait_updates, &wait,
-				TASK_UNINTERRUPTIBLE);
-		if (!atomic_read(&transaction->t_updates)) {
-			spin_unlock(&transaction->t_handle_lock);
-			finish_wait(&journal->j_wait_updates, &wait);
-			break;
-		}
-		spin_unlock(&transaction->t_handle_lock);
-		write_unlock(&journal->j_state_lock);
-		schedule();
-		finish_wait(&journal->j_wait_updates, &wait);
-		write_lock(&journal->j_state_lock);
-	}
 	write_unlock(&journal->j_state_lock);
 
 	/*
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f76598265896..34b051aa9009 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -594,7 +594,7 @@ struct transaction_s
 	 */
 	unsigned long		t_log_start;
 
-	/* 
+	/*
 	 * Number of buffers on the t_buffers list [j_list_lock, no locks
 	 * needed for jbd2 thread]
 	 */
@@ -1757,6 +1757,35 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
 	return max_t(long, free, 0);
 }
 
+/*
+ * Waits for any outstanding t_updates to finish.
+ * This is called with write j_state_lock held.
+ */
+static inline void jbd2_journal_wait_updates(journal_t *journal)
+{
+	transaction_t *commit_transaction = journal->j_running_transaction;
+
+	if (!commit_transaction)
+		return;
+
+	spin_lock(&commit_transaction->t_handle_lock);
+	while (atomic_read(&commit_transaction->t_updates)) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&journal->j_wait_updates, &wait,
+					TASK_UNINTERRUPTIBLE);
+		if (atomic_read(&commit_transaction->t_updates)) {
+			spin_unlock(&commit_transaction->t_handle_lock);
+			write_unlock(&journal->j_state_lock);
+			schedule();
+			write_lock(&journal->j_state_lock);
+			spin_lock(&commit_transaction->t_handle_lock);
+		}
+		finish_wait(&journal->j_wait_updates, &wait);
+	}
+	spin_unlock(&commit_transaction->t_handle_lock);
+}
+
 /*
  * Definitions which augment the buffer_head layer
  */
-- 
2.31.1

