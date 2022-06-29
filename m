Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CF3560CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 00:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiF2W4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiF2Wzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:55:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DA40E79;
        Wed, 29 Jun 2022 15:55:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4BP3014778;
        Wed, 29 Jun 2022 22:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=JN30TwFDewr2QAMMiNpOmoO5DRJLIhD0oG0NfTQac2M=;
 b=xiGIYd9f/xMCs857XSbx8dCz5b+Vws1vO6yQuZsYbPgjDVbC0Qyji5o8yui2IdtV/g6O
 2+tYZwvuE6rezXusIXumyEyn2vusLBlG6Tdghe0gPZ0QsVxtYDU8pqTlknZRHHr/EEVZ
 k3xcTIr0NRPizkaGj88D3NvAPJgN3uPFUm4GL39kcj/+cUAKMV8f4edohxv1xQ0IDUet
 pB+3OiR3s3PkAAKzF6VkvqfJpJFADOpu2JoLj4QS70wlw84Mh1wzltwfmZK1TdtPkba+
 9mHZUrUk61BGf1bhNCDabJwdWb9DLCzQ5PDW/wsuOPmDzvmmda6nfm5wS/T1xFzmSfYp lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscjfdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMexTD033601;
        Wed, 29 Jun 2022 22:54:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3wyx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxqPys6XKCVxMmJox4iFmWF9QVLBovqYrvkkmYc3Fa+eLvkXPBFGEnU8+8SJk085+tGJlKaMD7zEM1DuSVc7ekRS8kTY9hZ3u7Aa4tz/OIR0ywfdyr8UVxa0xDclLBju1k+m8BNhBMatHbW3lgd/RaItaPv3XMMRc46B418QE/wW3dEEkiVGU2QKMDTHDsCPMdZgtU8GFEpL2AD/rc261MFY4NhOnJvnbSHYIkCCQJ6Q4pgPH97MJY4QkhWuYSJF7WBHORktF9zwjWvQ+lDcrz4qffAw06lElaGlwjG1dr0Prj8agJeA3UYWie9JMtG16wwdn81HkJ6SFdoXuIyOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN30TwFDewr2QAMMiNpOmoO5DRJLIhD0oG0NfTQac2M=;
 b=GVGx2jmBQizH6ryje/CWBXM+k3qdddt9RSv0cO0BnvRUpudZb3hI4kPmuCWWCb0Fq4eHjB7ZXjbioY7UtvKBTqg9pjb0Lf0zEN37hfApVd2G5yHQB0XE65P+N+482RGZ/nI/YzP5e4kz9Rtx90C3S8ftiXSFxUMJ1c9Y1KPw6nVlzqf36a50TyUt3SvsjoRgXCmbXeO6HCK949uinfXTWOX4dINqcvM46f2Gq6m3ilV2jZlsNt8yoxmqX0QQy6JiZLhC/sUruogb8zAXn4EnpZ2swgAKNlR/XtqCZA+DM/aRfQ3ezLgsGCMicBD5DXPdDXuDq9p+VLb5Msfv9iHj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN30TwFDewr2QAMMiNpOmoO5DRJLIhD0oG0NfTQac2M=;
 b=y9ni/9qg4P9YfPCtz/x+B1laUaMR57EdQbrUqh9y4NY5CgUWc6qGAs8eZM7loDdqtdVNLPb/OQDxgnQsqPstQ/bMcdODK++fO80qF+oQ4viq3VCFqqsaCd/j3L5aze5bBl/ikhmpQlPuoVkFZuR7ZwX++wJNACgfMspIntj3sEI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1834.namprd10.prod.outlook.com (2603:10b6:3:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:54:22 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:54:22 +0000
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
Subject: [PATCH v2 3/9] mm/mshare: make msharefs writable and support directories
Date:   Wed, 29 Jun 2022 16:53:54 -0600
Message-Id: <397ad80630444b90877625a1e94dd81392fc678e.1656531090.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1656531090.git.khalid.aziz@oracle.com>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::6) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89f1ae8c-776c-42ab-6d3e-08da5a224ec1
X-MS-TrafficTypeDiagnostic: DM5PR10MB1834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TvOMdoY9lU2Z3Vt5i+ht6x2LKUG5MUaV6G5akCXAtdMBxbXrHL+Z54ol1Qr1g9cnP5eeDRnzFh45kJu/bj73G39d/GV8XAlmPV2JKwT2caKjLtZblblRRaO7uCheTnf8Dz7ne/14Gyn+TNJiPsmR4lFATAJDYQhBilTpKPVUeK1PFY3BW3GikBXfDozNq4ofMciBwSIMjXTNstBV5rj7eFeZBUrq1QbTGRnr/j8mK44lihEDRTVc8zv+C04lKApt5X9Un8TwKGVw8eritl3A9Cn8bfXRMl0b+HZhItxYvhmCJmKJLAbf9NVNecl8zGmWZ284NP+U67ZssmqpEF4p9ImaDNTC16R7a/xkXoSF+8wATb6vCncCvA2QWmjlNXg74nPB5xMqgjkayilb1i0gWBi0Mq3u5a5/odtbKBTUgWFJsIPItTfuUiuuj89EurRiyDl+l7Xz1eqXL53wRcrs35sbicXphZfskYyj5+KJiBgnQlNd9GaafHVf+mnAuIz/xXnODwDr07+enmFwjUZXgCvsoLaTTsik/MaqW1q3GRjVZuRoxawZGOYsZ1DOrAI7J235XYqXDIu2tzjBki4M6/+P89C4W2aXrRXlq0CaysRYWhlM0vEYO2KUaA0puu/0hEfjbvRnao8uUfJKiXvXkTc9zRmKQZthe9Q/d+47fERUpofs9GHozc+hBkOBGiaku/3Y7nXtp+1ub4KEaCFyhO9KhSrQruLAYfPmDMlbb/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(52116002)(41300700001)(186003)(6506007)(8676002)(66556008)(2616005)(6512007)(66476007)(38100700002)(83380400001)(44832011)(7416002)(8936002)(316002)(36756003)(2906002)(86362001)(66946007)(6486002)(5660300002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5LOwC7whcotThAtb98K2b0DZ1yWE2VQcudoZffMdPnBHSzMC+XXNj45ai+pD?=
 =?us-ascii?Q?Fsapu6QJPJiWuUDzN5biiMxsX9XvQra97QUPoAkFiftpJZOjIrRjFckmwbhG?=
 =?us-ascii?Q?y8sbpfXI/+GFTmBcUETc00r+qxqFKh3IDvsnJXX+SJxEKDp2PJxwoaZWiC+R?=
 =?us-ascii?Q?WjyctgMO7ERwJeM+ZYrd4aNDh66sViPZAV583KNYFLjSKq/zwVAdv440TfaM?=
 =?us-ascii?Q?dI8LAEIDCR7tuDYG6UDP1XhtRWG1psiRs+LSzniHE5ZaAXfDZcopEV9bZd01?=
 =?us-ascii?Q?TxHQ12T0/XmCNXHUNyzA+HCDFCD4Gr2OMgRLZ3gfAtc0IeW/ie38f8QOUia8?=
 =?us-ascii?Q?kQPLKNnlVDVVrPghbd1noItf3D1Ql/RadzfP3CU5/+N9MQayJVWP/b9o0jLt?=
 =?us-ascii?Q?aJcm2sARgpjxp2MKRh9m8K9fdtJPdf0x0JFQHdtoEF8RjCw9vQfPb0pdrLDJ?=
 =?us-ascii?Q?Fdcf4v7h9tmHkBlzTz877UUEXKfKHydNg/pKPXOjmIeww3eUEpDOR06KJvEf?=
 =?us-ascii?Q?kIY4Wh+RRmj2VkaMFdFCRJIpX7NglTdxF8rvpnL246jJb2BuRe2+d5HYYUkQ?=
 =?us-ascii?Q?elcmcD/GhNUTflkagxsFjAo3vVR2+C8nhKvbeftpIPbSk9jBaT2/zKYHlvPc?=
 =?us-ascii?Q?t19nTsHOVZAhrJ6xWs0wsjmYr3vrNPF8lSFl0IVa6MOhosxoYisUx35xGAM/?=
 =?us-ascii?Q?SSSa0MMeraYbfTm3RbtOZQKWGoD5JL/kMMLAGHh9k4lW8yxH3TTK/YZY148s?=
 =?us-ascii?Q?JWBhndGybxbaPZd8r/mKKPd9cH2R//wch5VLBdZmbf+eeZDvzCIYsphm0trH?=
 =?us-ascii?Q?FNX2jeWpv0wOeF4YruFqfw5645VkdaYeRzet00mf0Ewwx20jVEIN0LtxjkAP?=
 =?us-ascii?Q?Yi/MgIiKYK5vDWiC9sPlUfgCpWt1ryb+aBj5KDYWvpzWLoMVuU7cQeUrk9li?=
 =?us-ascii?Q?68MJEWFntZMeoE+z9wZ+daM1Dyu2z94ZPCVJck0LbZh7e1xiQWsyRiWdt5K1?=
 =?us-ascii?Q?mA4K97nRbZGDIqYgwmMfIhfXH7eUmQ66P4pu4qrQaewpPmkFMp0Wiw6cOvcu?=
 =?us-ascii?Q?DzHZkX9nY3KxO2nqi1EgQfqhSiA3OcwBcPi81L+oH3I6nz/1awyr9EheC8jh?=
 =?us-ascii?Q?BMVlprIPRs5fEkSX2aAsN+Qy1wxvOmcYZc9m//XZjrUl7LvWo9EE08jLjCr0?=
 =?us-ascii?Q?snrKkcxY99/q+dgYto6do/3E9fCLvU0MhKWLitAH2tDjHlm79X0O/KNpcBhw?=
 =?us-ascii?Q?BvhcJjvn5j/m9wP8XpVVARMUlz3NIW2SUcpfJvI+LuDgxTvOX+wS9ACnCiXE?=
 =?us-ascii?Q?/gq+IFk/i2LRSwbuflBg36//PgBx6P/onNkib18CuJtOPkqALVuwUxkrGOW2?=
 =?us-ascii?Q?WNjTUYd7ahKMk70njMTOQN0I2rL6DeaaBPLLMAcrR3VKdF4y3ZG4pmPLVPPP?=
 =?us-ascii?Q?Foa7Jt3gZieQkY3PhPIGhePSEk1KZzUMLMgdHWENuG8BCcO2ZArAXZjQ8dEe?=
 =?us-ascii?Q?cSt030/gC9ZxirBdt/iJN0TmqhpjamPM7kNMgk30zcJdqHvq0Kp3Rbp+yn4E?=
 =?us-ascii?Q?yWqad5dcciCmaEW1j3QhG2a3k8gbGIN7dgcUYHBTsuqcg85hTcu9JBCdfJyz?=
 =?us-ascii?Q?o/0pj+vj2u5wY2Ie+o3WlX6aKQ/aqBPgduEDJeLMhGiv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f1ae8c-776c-42ab-6d3e-08da5a224ec1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:54:22.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPzZC3+RaheVNwclfPK7IFrZrq1zwAGHEuPc1KQG3y6jlw4+XdrWHq246lVOmec19E543aO1RpBWfePmuUmhQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=807 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290078
X-Proofpoint-ORIG-GUID: cttYVK8PRrb9YnjQKWbem_T-if2Bz2V9
X-Proofpoint-GUID: cttYVK8PRrb9YnjQKWbem_T-if2Bz2V9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make msharefs filesystem writable and allow creating directories
to support better access control to mshare'd regions defined in
msharefs.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 195 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 186 insertions(+), 9 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index 3e448e11c742..2d5924d39221 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -21,11 +21,21 @@
 #include <linux/fileattr.h>
 #include <uapi/linux/magic.h>
 #include <uapi/linux/limits.h>
+#include <uapi/linux/mman.h>
 
 static struct super_block *msharefs_sb;
 
+static const struct inode_operations msharefs_dir_inode_ops;
+static const struct inode_operations msharefs_file_inode_ops;
+
+static int
+msharefs_open(struct inode *inode, struct file *file)
+{
+	return simple_open(inode, file);
+}
+
 static const struct file_operations msharefs_file_operations = {
-	.open		= simple_open,
+	.open		= msharefs_open,
 	.llseek		= no_llseek,
 };
 
@@ -42,6 +52,113 @@ msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
 	return 0;
 }
 
+static struct dentry
+*msharefs_alloc_dentry(struct dentry *parent, const char *name)
+{
+	struct dentry *d;
+	struct qstr q;
+	int err;
+
+	q.name = name;
+	q.len = strlen(name);
+
+	err = msharefs_d_hash(parent, &q);
+	if (err)
+		return ERR_PTR(err);
+
+	d = d_alloc(parent, &q);
+	if (d)
+		return d;
+
+	return ERR_PTR(-ENOMEM);
+}
+
+static struct inode
+*msharefs_get_inode(struct super_block *sb, const struct inode *dir,
+			umode_t mode)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_ino = get_next_ino();
+		inode_init_owner(&init_user_ns, inode, dir, mode);
+
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+
+		switch (mode & S_IFMT) {
+		case S_IFREG:
+			inode->i_op = &msharefs_file_inode_ops;
+			inode->i_fop = &msharefs_file_operations;
+			break;
+		case S_IFDIR:
+			inode->i_op = &msharefs_dir_inode_ops;
+			inode->i_fop = &simple_dir_operations;
+			inc_nlink(inode);
+			break;
+		case S_IFLNK:
+			inode->i_op = &page_symlink_inode_operations;
+			break;
+		default:
+			discard_new_inode(inode);
+			inode = NULL;
+			break;
+		}
+	}
+
+	return inode;
+}
+
+static int
+msharefs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		struct dentry *dentry, umode_t mode, dev_t dev)
+{
+	struct inode *inode;
+	int err = 0;
+
+	inode = msharefs_get_inode(dir->i_sb, dir, mode);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	dir->i_mtime = dir->i_ctime = current_time(dir);
+
+	return err;
+}
+
+static int
+msharefs_create(struct user_namespace *mnt_userns, struct inode *dir,
+		struct dentry *dentry, umode_t mode, bool excl)
+{
+	return msharefs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
+}
+
+static int
+msharefs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		struct dentry *dentry, umode_t mode)
+{
+	int ret = msharefs_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
+
+	if (!ret)
+		inc_nlink(dir);
+	return ret;
+}
+
+static const struct inode_operations msharefs_file_inode_ops = {
+	.setattr	= simple_setattr,
+	.getattr	= simple_getattr,
+};
+static const struct inode_operations msharefs_dir_inode_ops = {
+	.create		= msharefs_create,
+	.lookup		= simple_lookup,
+	.link		= simple_link,
+	.unlink		= simple_unlink,
+	.mkdir		= msharefs_mkdir,
+	.rmdir		= simple_rmdir,
+	.mknod		= msharefs_mknod,
+	.rename		= simple_rename,
+};
+
 static void
 mshare_evict_inode(struct inode *inode)
 {
@@ -58,7 +175,7 @@ mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
 {
 	char s[80];
 
-	sprintf(s, "%ld", PGDIR_SIZE);
+	sprintf(s, "%ld\n", PGDIR_SIZE);
 	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
 }
 
@@ -72,6 +189,38 @@ static const struct super_operations mshare_s_ops = {
 	.evict_inode = mshare_evict_inode,
 };
 
+static int
+prepopulate_files(struct super_block *s, struct inode *dir,
+			struct dentry *root, const struct tree_descr *files)
+{
+	int i;
+	struct inode *inode;
+	struct dentry *dentry;
+
+	for (i = 0; !files->name || files->name[0]; i++, files++) {
+		if (!files->name)
+			continue;
+
+		dentry = msharefs_alloc_dentry(root, files->name);
+		if (!dentry)
+			return -ENOMEM;
+
+		inode = msharefs_get_inode(s, dir, S_IFREG | files->mode);
+		if (!inode) {
+			dput(dentry);
+			return -ENOMEM;
+		}
+		inode->i_mode = S_IFREG | files->mode;
+		inode->i_atime = inode->i_mtime = inode->i_ctime
+			= current_time(inode);
+		inode->i_fop = files->ops;
+		inode->i_ino = i;
+		d_add(dentry, inode);
+	}
+
+	return 0;
+}
+
 static int
 msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
@@ -79,21 +228,49 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 		[2] = { "mshare_info", &mshare_info_ops, 0444},
 		{""},
 	};
-	int err;
+	struct inode *inode;
+	struct dentry *root;
+	int err = 0;
 
-	err = simple_fill_super(sb, MSHARE_MAGIC, mshare_files);
-	if (!err) {
-		msharefs_sb = sb;
-		sb->s_d_op = &msharefs_d_ops;
-		sb->s_op = &mshare_s_ops;
+	sb->s_blocksize		= PAGE_SIZE;
+	sb->s_blocksize_bits	= PAGE_SHIFT;
+	sb->s_magic		= MSHARE_MAGIC;
+	sb->s_op		= &mshare_s_ops;
+	sb->s_d_op		= &msharefs_d_ops;
+	sb->s_time_gran		= 1;
+
+	inode = msharefs_get_inode(sb, NULL, S_IFDIR | 0777);
+	if (!inode) {
+		err = -ENOMEM;
+		goto out;
 	}
+	inode->i_ino = 1;
+	root = d_make_root(inode);
+	if (!root) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = prepopulate_files(sb, inode, root, mshare_files);
+	if (err < 0)
+		goto clean_root;
+
+	sb->s_root = root;
+	msharefs_sb = sb;
+	return err;
+
+clean_root:
+	d_genocide(root);
+	shrink_dcache_parent(root);
+	dput(root);
+out:
 	return err;
 }
 
 static int
 msharefs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, msharefs_fill_super);
+	return get_tree_nodev(fc, msharefs_fill_super);
 }
 
 static const struct fs_context_operations msharefs_context_ops = {
-- 
2.32.0

