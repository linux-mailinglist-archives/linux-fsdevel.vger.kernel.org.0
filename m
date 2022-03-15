Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1974D9A8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 12:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347993AbiCOLqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 07:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbiCOLqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:46:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027B150056;
        Tue, 15 Mar 2022 04:45:07 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FAKaaC010365;
        Tue, 15 Mar 2022 11:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=v3ezUP1MC6dhsuxXAGQ7c2Quz35iCiyGYZNMPQSWZ8g=;
 b=mBez7gqx+IKMuATuYCD1bWlYkHEIHwsgBxiFz6ZoJ7xvxlZDoE4DHigZaF1xc7xoLfY+
 l7najYfVlm7KCFJwPGj33bKdK+lJpaUyBM/e+y5PAb2Nwf7XWeLx8DxBgcYAwpMO7RE2
 o0DYG0ArptPLGCTFEQkCSx0B9TWLBIVR98KjYKNcfqRSIRC96CReCgPeOBUS65ewEx27
 f4bFM0Z/2/nqgAM7LpzPzBQ7w/hdYhYUodqAmpKMm3mZgC0Z3FkutOErBN3FNASVgftu
 6IsX6fFf8coYsblNeDUZcXioG3zvpo5S/H0oXtNUwmnQOh/K+oiEzHWyjepv25wE3s8K 6A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3etryc1kg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 11:45:04 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FBb7uv013182;
        Tue, 15 Mar 2022 11:45:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3erk58nhns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 11:45:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22FBj0bn47907252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 11:45:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B10711C04A;
        Tue, 15 Mar 2022 11:45:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B90B11C052;
        Tue, 15 Mar 2022 11:44:58 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.50.106])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Mar 2022 11:44:57 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Get rid of unused DEFAULT_MB_OPTIMIZE_SCAN
Date:   Tue, 15 Mar 2022 17:14:54 +0530
Message-Id: <20220315114454.104182-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WzxipNqd-Ap8UMfSC9JLxN5927h6tC5K
X-Proofpoint-ORIG-GUID: WzxipNqd-Ap8UMfSC9JLxN5927h6tC5K
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_01,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After recent changes to the mb_optimize_scan mount option
the DEFAULT_MB_OPTIMIZE_SCAN is no longer needed so get
rid of it.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---

This patch should be applied after the following:
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=27b38686a3bb601db48901dbc4e2fc5d77ffa2c1

 fs/ext4/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cd0547fabd79..550db5226b4f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1862,7 +1862,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 };
 
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
-#define DEFAULT_MB_OPTIMIZE_SCAN	(-1)
 
 static const char deprecated_msg[] =
 	"Mount option \"%s\" will be removed by %s\n"
-- 
2.27.0

