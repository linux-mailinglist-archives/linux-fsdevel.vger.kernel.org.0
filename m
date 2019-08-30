Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810DAA338D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 11:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfH3JSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 05:18:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727675AbfH3JSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:18:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7U97ZUr195402
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 05:18:02 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2upy8w4eaw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 05:18:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 30 Aug 2019 10:17:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Aug 2019 10:17:56 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7U9Ht3t15597728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 09:17:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E92FF11C058;
        Fri, 30 Aug 2019 09:17:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DED311C04A;
        Fri, 30 Aug 2019 09:17:54 +0000 (GMT)
Received: from dhcp-9-199-158-229.in.ibm.com (unknown [9.124.31.57])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 09:17:54 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Subject: [RFC 1/2] direct-io: Change is_async member of struct dio from int to bool
Date:   Fri, 30 Aug 2019 14:47:50 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830091751.10284-1-riteshh@linux.ibm.com>
References: <20190830091751.10284-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19083009-0020-0000-0000-000003659622
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083009-0021-0000-0000-000021BAF207
Message-Id: <20190830091751.10284-2-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=458 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300099
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change is_async member of struct dio from int to bool.
Found this during code review.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index ae196784f487..b139876653ef 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -128,7 +128,7 @@ struct dio {
 	/* BIO completion state */
 	spinlock_t bio_lock;		/* protects BIO fields below */
 	int page_errors;		/* errno from get_user_pages() */
-	int is_async;			/* is IO async ? */
+	bool is_async;			/* is IO async ? */
 	bool defer_completion;		/* defer AIO completion to workqueue? */
 	bool should_dirty;		/* if pages should be dirtied */
 	int io_error;			/* IO error in completion path */
-- 
2.21.0

