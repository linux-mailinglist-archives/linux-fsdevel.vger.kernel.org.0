Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62A04FC1CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiDKQKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbiDKQKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7822B16581;
        Mon, 11 Apr 2022 09:07:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFweRK028178;
        Mon, 11 Apr 2022 16:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ns/tAb54zwtHaXDOwJwVLMPuANUuMaTEmmT1t7WcQ0s=;
 b=NsEXOxeKiyr86sL6ScHYSeahKtyHLwPBzgmg9Y3SFiG/MkyRvH+Z6YkfAsCk44YrbgLU
 WAnU668xEMF4NXndiGdh/wgxsNayKsS4Xsk8KlSEqz7mik7cxAsnQyGS/Of20a5iNVNZ
 w0x2LSIQJQO8g30MSP0SJJeYL3t6Sc8LIdqbDVGGIJZbdwN/Rzpb1JDFSRUioR3+Nm2Q
 HSwKqdmbvAgOIRaUJ3/2z1FlWRWn3gsZ+gU7lvcdiUGq7Sfl/nR02+c/XJ1y12Z/bQ2i
 vpuHG5NxmihlqoOklRSN/VJizm7Sz38PIVwY2Ic1gua2CfT+9tgzPyDpwERWw1bKqlO4 vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb219v1g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG29o0022489;
        Mon, 11 Apr 2022 16:07:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9gdx0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5YpHM/T27WNmBLiWhBRA15XlGwF+OfzX1CPS1anZIz2n7sTtHOKNnb0//7bKOAWlcmtKFFIpYbhY1tQsKMjRP0gVBh1nflb9zjLUcSWQVyEixfb4DRG1fQ4JwUcsYniT2bKTIZ1BRAGnQSbXVRPLna5r0aCNqvFXmbtDSVd2RM6ZXIjhp4rx7xIKymcztfEvn1MO3fymJUILXMhbiERwEYaNPCRL2H/VuwdS2Z6SxW6HnN/rq4t8XiNN1arAd3AGPEjoM3pASinVpfgWa3dw10Z04axDfpYmW7g9VJkvg62+izfx3UQhieMf1lsbEe4qubhBnju5Rz+xgGpge1RUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns/tAb54zwtHaXDOwJwVLMPuANUuMaTEmmT1t7WcQ0s=;
 b=abD8w/wbP3AiZlQp2ATZWSFCnvLdK42DgOwpMGScAM4dFbdNvtxKd2znjmJanumnN8ULvGd+LlvwqOXcP+jVodR9jpnI6NBumEwoDbomHQLchR3SEdxZGG/80OgJGw3RjLnb7ZEmvujq7EeiHTAB5gPggeFievnhfuWeTUsBNa5y1GWwZDPFBE0J06FVP1tA5l7+Xq0EBjbGgpWzSx5/K7CaZJSC7QlP1WaCQZJWP8xoIv6h4E/5yJ4kN8sXcj9gPDbVBjFJqZZRO0vtfEEagOl0iMj9xIP9ZeeDMjJQSaoEB5hy6FaZ5PqrxnGB60/Qb2tWTiClAdGuckhqsA4uuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns/tAb54zwtHaXDOwJwVLMPuANUuMaTEmmT1t7WcQ0s=;
 b=MbWMF2YRD61XTRfaFgXPgY8/A8ST1gNSFDNPTSm3hZg3nHZNewCpp0vKR/MaePqYUjF10JCRCJEGX/Z8AaJqSzO9mkX7/DgWH1gwMY21JuyGUQPu48b5HEqsmsANihx0WdizrrVS6/0LR1Qf4sF7uJhETgL5VGToseYlVByfCcQ=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:07:00 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:07:00 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: [PATCH v1 05/14] mm/mshare: Add locking to msharefs syscalls
Date:   Mon, 11 Apr 2022 10:05:49 -0600
Message-Id: <b9f2a2c2ee33565b158a4bbe97cc2c2861881f93.1649370874.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649370874.git.khalid.aziz@oracle.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19bb8fc6-a534-4f73-e717-08da1bd54f57
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45649909636BA0017F55420586EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KctlEP6MfettZWBVS7FORNSke6GKDGO7nO1g5rcDpK09MlYC+7kqoP8KNhbbMch9baotAI6bYkn/zbTHuu1c5usNz4nGybDIVXuIhhiUc7blWGaMgl7bblM+sI0UpU0x4P20TApf1iQNJb7p8dfefxd/Sw10Lf1hOdYgneDGY5uUzZhhg8ROO1Jh5kVjjOlSYWzF4RPmGdW9zvVfN3lkX9OcvcdPmCTQ9xcfU9uTSFifuAus/uIEfBuwPVglGvQZPRe1r3ERnu6gmfEUBSP0SaMncrQQd45ZUwcVAbcUgUExUNsGyWeyLqKGAA3vm4onbhffYTnugLR1bgwV6rcmBFkINJy4hpHraw/396phKEmegtvjRA9bxmSgXrH0mr1NdqCkbh+ZccY3IOpeLm88GnrhOiim0+Y3dYQIA1+SxEPmn6lzcYjGyKnmo9hzdFx1/FH4jj3ixZ2jQGbIg8xudGHfdz9Ae9E6Uno6BuOpV/gPBXDitdiXqmuT8gKJcfn/xN2hYe04njjW99ZLajApdShT4wAGF7JwpmIKzT60TYdIWKhE7AQdeN7/5UddaYvvC7sVxE2BgOCdRrHphwWmEUczR6j8IIu8Gb1P1cthO17hTN7+82VoSFgo0rv23X7NsRDjypXgwFyEQ/N85SiPRLvJDUDAL3EV4RHcFBoo1WVocyp09WGxEOmDLrnEJW+KFmadjytj9vuv3le1XSLdMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(6506007)(44832011)(7416002)(4326008)(8676002)(6666004)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(83380400001)(2906002)(6512007)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BpEDGFtrCXmv4T5emsjofaFse7T0t0B/JkYtPsRJO8iWCdorxrAQGmdFnNH0?=
 =?us-ascii?Q?J+U+SQ9/2nP/8l9TJW4Oyay/u3mcRmsLBTJDZtX+m6euOpgIPj1uWUOZAtZz?=
 =?us-ascii?Q?IKzrgBthJ1u4FwcPRVAQEkBpR72iuqC1RISN7ylXNc2/xMv9oF//TLd0SV3c?=
 =?us-ascii?Q?zsvR9wrx1WcLQQ7FLxW+Eix0iTJm6K3Hh69vs1tFEF7RznMu7HQuhG9m8jWb?=
 =?us-ascii?Q?JGSms8aKpprIWx6M2wQlO5Rxiu5GmtMsE3FgTtYqgtxlgch0qHwws7/jPWq4?=
 =?us-ascii?Q?ha1+nR/xhWR6UwmfDO+8dHh9x43Gb6lCQT+Km2Rp2k4ogEL6IU+flapwx6y1?=
 =?us-ascii?Q?9QNRdsVO9OVgQKcMyVjC9ZDmX3bMYGaoIDFxBpWmm4jBAe6u5v/sDWJvhsOh?=
 =?us-ascii?Q?f7EyciqlA3YEfEUhcDUfsBhZ8+gSZBBr+ZsPLfvkRGwNf3luOgWYmVwwjTo6?=
 =?us-ascii?Q?0bY3ja/WIm3S2OfsL6WBqUwkhE25VBxGI6YRK53R0xNIQPKvaJCY8HRVSBWg?=
 =?us-ascii?Q?swivBYqiWX4nA2bhdk0v22vj9REXut6lNo0cblhoj5J/P9CXhryqL/RVMMtm?=
 =?us-ascii?Q?2NzIVdtClbm7vXRLBaFxozjSxQI5sf0he11asIr0NL7mFeFuSaGGaGfPXH01?=
 =?us-ascii?Q?3GvEvH71Z4q1X3yJk3gzslho+lYYSYtlCLuFsRmnGxmDT+esTygt54Jfj+tD?=
 =?us-ascii?Q?nR93Yvle9MLdG0SDNPAiF65lcnwTbyiI+bJ3O/a5GlLFgIUEz6dFAZ17JlCD?=
 =?us-ascii?Q?RygomfLEd48Hf870qjeXl+cnIAH5c3AR70CxOCpg5xGlE1ULZT0Sl6FY6cD7?=
 =?us-ascii?Q?MrhEYNyFj3j38kxFl3hLiU52muzurRWSwOFX9gJD3aA7dqpowphZY6BjnqJz?=
 =?us-ascii?Q?ZU6H9b9CZGvRC46vUaU+FJufTMRbWO8KHD42A5EB1kETB42GCYEEa4wu+atv?=
 =?us-ascii?Q?3ckje9hP8VlSNk4R3Sq73Nrx/2PWhiZYmo99LsgGfBIPFXsaYobwH2PJPI2d?=
 =?us-ascii?Q?cK/CJM7kjRfVsFDfm32K9OKmBO9RHGlh34eiWFGxAZZSEqk5G986kf7iUhZJ?=
 =?us-ascii?Q?AvtqdhL0cu8Ygc7fqJO+H1Ank6465hjh8hnVbirCd93iM8wKTf5CzGKh8lOa?=
 =?us-ascii?Q?27VDEmB+e3K3cYLrUU+HEt4US2NTTx6HNbT8ViI6+2dgR8RXmB9CXlJTe2N/?=
 =?us-ascii?Q?TLWovpozPfJRMTG2ZCi8zp+H8FN+3ySRgMUUDyNXAi0EK7PHc3Mopw+3QwnV?=
 =?us-ascii?Q?qdxf/03f9LXyVMo0WgtuNNGGWTLCCraZWuOqMnPaJFzHaL6gweaKcj6cW2Y2?=
 =?us-ascii?Q?eYaAIRNWjcFQmS13P3G2ERFdM3wrARTNw+TFZgXZS3e4gj3SDgQRNPulVj/N?=
 =?us-ascii?Q?kMlAL65xqoJzgGmS6PgLzW+d+I51nFRr6/efAcoOAAThvyxgHTZuqBPWWLUG?=
 =?us-ascii?Q?zLOuw/UH8+6um9DZVy+ur9mjfM2WMI7aI2b7+9mK/QXEemIi41WNTMWC35Qg?=
 =?us-ascii?Q?kVOp3PPOniSKNLd2TQEE0NJVGCUM7jzRMuvX9oTQJb1J3CfPHZqLjN3l6WHT?=
 =?us-ascii?Q?BkIJ1xa32VaZ3fGDMl4PE2NV0aDtTKcWCtTmYpWgfmYJyhuwvW5WIzUoOfwf?=
 =?us-ascii?Q?vRUrEc/GZ3EQoDcEYpf/L+xFXif2lNIzGLfqPYLBg4SsqLk4kOmANy+Cieq2?=
 =?us-ascii?Q?e7xfwRFGjlXBKT0CZdurl/yj4BPZAHbmTP5zsXE9G5e7Ya8TAZ99/IWUdc3G?=
 =?us-ascii?Q?ysKQvXanMg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bb8fc6-a534-4f73-e717-08da1bd54f57
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:07:00.3084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DDcCK4YF193afqhl+aeTxwEt5qYnsQvMssqqfH/vY6uPaCsQ8tWa4Ta9w9zjYD5OK+DVyk969neK1qkLGFtqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=821
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110089
X-Proofpoint-GUID: fxrT3nSFlHwtEcbmHonYjqmv2ZCA7UUZ
X-Proofpoint-ORIG-GUID: fxrT3nSFlHwtEcbmHonYjqmv2ZCA7UUZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lock the root inode for msharefs when creating a new file or
deleting an existing one to avoid races. mshare syscalls are low
frequency operations, so locking the root inode is reasonable.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index b9d7836f9bd1..85ccb7f02f33 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -195,11 +195,12 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	err = msharefs_d_hash(msharefs_sb->s_root, &namestr);
 	if (err)
 		goto err_out;
+	inode_lock(d_inode(msharefs_sb->s_root));
 	dentry = d_lookup(msharefs_sb->s_root, &namestr);
 	if (dentry && (oflag & (O_EXCL|O_CREAT))) {
 		err = -EEXIST;
 		dput(dentry);
-		goto err_out;
+		goto err_unlock_inode;
 	}
 
 	if (dentry) {
@@ -232,6 +233,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 			goto err_relinfo;
 	}
 
+	inode_unlock(d_inode(msharefs_sb->s_root));
 	putname(fname);
 	return 0;
 
@@ -239,6 +241,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	kfree(info);
 err_relmm:
 	mmput(mm);
+err_unlock_inode:
+	inode_unlock(d_inode(msharefs_sb->s_root));
 err_out:
 	putname(fname);
 	return err;
@@ -264,10 +268,11 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 	err = msharefs_d_hash(msharefs_sb->s_root, &namestr);
 	if (err)
 		goto err_out;
+	inode_lock(d_inode(msharefs_sb->s_root));
 	dentry = d_lookup(msharefs_sb->s_root, &namestr);
 	if (dentry == NULL) {
 		err = -EINVAL;
-		goto err_out;
+		goto err_unlock_inode;
 	}
 
 	inode = d_inode(dentry);
@@ -290,11 +295,14 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 		dput(dentry);
 	}
 
+	inode_unlock(d_inode(msharefs_sb->s_root));
 	putname(fname);
 	return 0;
 
 err_dput:
 	dput(dentry);
+err_unlock_inode:
+	inode_unlock(d_inode(msharefs_sb->s_root));
 err_out:
 	putname(fname);
 	return err;
-- 
2.32.0

