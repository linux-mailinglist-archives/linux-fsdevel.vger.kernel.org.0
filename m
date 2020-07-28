Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FE82314EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 23:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgG1VhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 17:37:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47402 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgG1Vgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:36:31 -0400
Received: from dede-linux-virt.corp.microsoft.com (unknown [131.107.160.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id B738F20B491A;
        Tue, 28 Jul 2020 14:36:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B738F20B491A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595972189;
        bh=BO1cenWUnGNayuyBmKqbXIIbsqyXRIWwZdTmlpXz42M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EwLsMt2Gl0vLtrkeueHcRW+yvC6erjEIL+ShXG7u8Rgui7HO6pcVWh7MT/gKYI4W1
         ofEouC72hqfzbke2OC5gkGFEVodrhKqD9KD7AVBbiI2Fu8/+xX6H3SuNDMlVcvz/hS
         zCPDiv/lMq0gEOFlQHiy1sVyHSIM9pV7bD1+9UJI=
From:   Deven Bowers <deven.desai@linux.microsoft.com>
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, eparis@redhat.com,
        jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com
Cc:     tyhicks@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: [RFC PATCH v5 11/11] cleanup: uapi/linux/audit.h
Date:   Tue, 28 Jul 2020 14:36:12 -0700
Message-Id: <20200728213614.586312-13-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove trailing whitespaces and align the integrity #defines in
linux/uapi/audit.h

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 include/uapi/linux/audit.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 5a634cca1d42..609b4a5e8a80 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -48,7 +48,7 @@
  * 2500 - 2999 future user space (maybe integrity labels and related events)
  *
  * Messages from 1000-1199 are bi-directional. 1200-1299 & 2100 - 2999 are
- * exclusively user space. 1300-2099 is kernel --> user space 
+ * exclusively user space. 1300-2099 is kernel --> user space
  * communication.
  */
 #define AUDIT_GET		1000	/* Get status */
@@ -78,7 +78,7 @@
 #define AUDIT_LAST_USER_MSG	1199
 #define AUDIT_FIRST_USER_MSG2	2100	/* More user space messages */
 #define AUDIT_LAST_USER_MSG2	2999
- 
+
 #define AUDIT_DAEMON_START      1200    /* Daemon startup record */
 #define AUDIT_DAEMON_END        1201    /* Daemon normal stop record */
 #define AUDIT_DAEMON_ABORT      1202    /* Daemon error stop record */
@@ -140,20 +140,20 @@
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
 
-#define AUDIT_FIRST_KERN_ANOM_MSG   1700
-#define AUDIT_LAST_KERN_ANOM_MSG    1799
-#define AUDIT_ANOM_PROMISCUOUS      1700 /* Device changed promiscuous mode */
-#define AUDIT_ANOM_ABEND            1701 /* Process ended abnormally */
-#define AUDIT_ANOM_LINK		    1702 /* Suspicious use of file links */
-#define AUDIT_ANOM_CREAT	    1703 /* Suspicious file creation */
-#define AUDIT_INTEGRITY_DATA	    1800 /* Data integrity verification */
-#define AUDIT_INTEGRITY_METADATA    1801 /* Metadata integrity verification */
-#define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
-#define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
-#define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
-#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
-#define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
-#define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
+#define AUDIT_FIRST_KERN_ANOM_MSG	1700
+#define AUDIT_LAST_KERN_ANOM_MSG	1799
+#define AUDIT_ANOM_PROMISCUOUS		1700 /* Device changed promiscuous mode */
+#define AUDIT_ANOM_ABEND		1701 /* Process ended abnormally */
+#define AUDIT_ANOM_LINK			1702 /* Suspicious use of file links */
+#define AUDIT_ANOM_CREAT		1703 /* Suspicious file creation */
+#define AUDIT_INTEGRITY_DATA		1800 /* Data integrity verification */
+#define AUDIT_INTEGRITY_METADATA	1801 /* Metadata integrity verification */
+#define AUDIT_INTEGRITY_STATUS		1802 /* Integrity enable status */
+#define AUDIT_INTEGRITY_HASH		1803 /* Integrity HASH type */
+#define AUDIT_INTEGRITY_PCR		1804 /* PCR invalidation msgs */
+#define AUDIT_INTEGRITY_RULE		1805 /* policy rule */
+#define AUDIT_INTEGRITY_EVM_XATTR	1806 /* New EVM-covered xattr */
+#define AUDIT_INTEGRITY_POLICY_RULE	1807 /* IMA policy rules */
 #define AUDIT_INTEGRITY_POLICY_LOAD	1808 /* IPE Policy Load */
 #define AUDIT_INTEGRITY_POLICY_ACTIVATE	1809 /* IPE Policy Activation */
 #define AUDIT_INTEGRITY_EVENT		1810 /* IPE Evaluation Event */
-- 
2.27.0

