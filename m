Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD094FC1D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348433AbiDKQKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiDKQKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700F91B7A9;
        Mon, 11 Apr 2022 09:08:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFxoAt032238;
        Mon, 11 Apr 2022 16:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=GSmrmOIC+RpQpEBnSj5ZiND7iNP3pFdaNh8U31N0v44=;
 b=tPF+oGteSVpzZN9zthVRDT+olgjzOnV5aO3PW0s3PiVf0YQ+2C/k8y0q7Z7N0+t9k9Z6
 GLQ6AMkLc9+vZo8tLhwBYqe6To/Q3ss0lj65zc3epiP6mK+TuEE64kIuwbrbK8Ia2MoG
 cdsz1aLmPllxB5uIuCxbYibiEiRaNBV/oR3AERzbfeFeKdW4wgHp9sQoLYE8iCWDz0zs
 E5+zuQJuS33nVmxFHjJRfJOXwfkwGAlZnpU6SJa0ifKKqDnByQlJrINm81TX/qla/iBz
 aGDVJQoez5yJ1tCzSef7EZAibd2QOHRENweko19PjfMr6l7xWlb4x4PMB1kujR3uvNMG ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd43y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:06:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG0N4T016213;
        Mon, 11 Apr 2022 16:06:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck11rwrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdJZ8iOoihbnHK/Nd5hDmhvqBfJryR1zdvsGyqqbKcltYKU9JifVMao7el51nhwB4oiy5AtdbctjLchrlPfIZweBl1F8gzCQK8ChlnIukLrlOtDAsvCZloeBW06oge+ycQ58rpnnMeqxCVxskN3hDIeMM83yy3E2L3mdctoqhZwR3ufhfD5bDE4b9fGSdrwKoEMf7L466J554I55R8u1GQoVWdjKMdVhEDXqbITx5Du3jXBm323ucX4rHZ6NcFbGJ8c4cuKpRjygdjXmevGomt3wNrf7BtoBa7RFzTmz4hk7Ub39RI+2hwoSbu6QdklzNHMK/OxqvAotoG1lmTQNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSmrmOIC+RpQpEBnSj5ZiND7iNP3pFdaNh8U31N0v44=;
 b=AXroUSXhDyouIPvqz37l9iXp7NpDSXDCkbISHtbe52RZ5YX6CRTcRNAAYZqXwI2FMGGIaUbtt2ZCGhxh3iNoLwaC/R1bu5e1g/Z5c/Or7mMCERxrJ5fmYo5tUL/g3MuFbXv99wTUemHm2QyJQOUwpxzg5++AW6bBOugN/TxnHBgVCeLdzNo9hTuvXGZ2RsEk3zsKw+azpu+iCVgiT5XdOM++7IF1poOO+NEG7ab26iRRqv9EyQg92/250jArBaeFSTqywIEQZYQa3Lq9cT0bvi8ZKNSU1nQPx0JWBAyOd6JTV+X1UxIoDGQyxHXubUwG/Sa2AoWJH3m4m9/si/vcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSmrmOIC+RpQpEBnSj5ZiND7iNP3pFdaNh8U31N0v44=;
 b=SZWLL0lp3aV+uOufk+0rirC7vVE4sr/O+PNhla26+rxurEy6XMWh3IuB/qDN8Tgoo/qZWlyUYBi3izijtfItOBlsqlBER1k/Lp/I43anm/tLzXjp+3yVxkiBNRH0tyrS5tr6zRj2ZJtrO+Yp+ytZUveNAfnrtqUu/2QKTg8shnQ=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN7PR10MB2609.namprd10.prod.outlook.com (2603:10b6:406:cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:06:44 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:06:44 +0000
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
Subject: [PATCH v1 02/14] mm/mshare: Add msharefs filesystem
Date:   Mon, 11 Apr 2022 10:05:46 -0600
Message-Id: <b4ae654c76d8b5f462e9cedf444fc3eaa71ff9e5.1649370874.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0c8ef1d-5011-4a5f-f2b3-08da1bd545fb
X-MS-TrafficTypeDiagnostic: BN7PR10MB2609:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2609D91C7C860CBC0058209D86EA9@BN7PR10MB2609.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAm4x1Tv54TN+9wwWQ+uYH7x8nV68QhoX4eI8CY+/9+1s7CvEDmnnbgVVSy//vpyQcLPh+Qm+BZASoIOQCwdzJiClTkXfSgTsEyvLj56vc9qzdYNDyUS5UW8SSiKYNsyuu8fWBusz9pHW+1V67RjW0V3NJk6Na48DuaFOpuXSAU1r74svktqrIZ9E/XxAuGPpQE2cGODyQv3AQmFdo+P36fyIH9Kfvqjaq5VzbKXCF/DVkBbAuasRFbvSXLocX3iRC83CFfL+fE7ki5I1PaO2UN/xXnm/ZIpfSjPTIuS9EMxN2TvNeq70Kou67fXv8lOSZBEoDIl3nOdB0WTEe2Z5GTxc+G+MAjFAGM/2J3weM6+3D+heHSgmpYyxRGLiTnysN3B9CDePZu705vGrKBBFz207lLIrjUgmX7ZBD6qgzLJmINQpMdj17zTayUh+DcO121a3Q6WzAzPCEKcJjTy0WFdCLn3pMih05c6vzYaI+TofuTo+06txCXN49BWZ09yWOc85Evi2hzrdMPacve8TmCU0p9fTo2aqpo2W0w2asKbyxQk9JJjwQeO8QlMDnftuM3q/wrh8/4DIJy0+TvI5PO6i2WjsjpNA2Z6khAiOUvI/bFRxAha7mvXtN2Cq1vShq6CX+SZLwB6wT82vc8Ly3nQjHf5i14naqwoCYFX1zd8L9VUeR808/vXdT1ummLLgYEkz3xxttnMuObRMT/XuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(6506007)(186003)(316002)(52116002)(66556008)(6512007)(8676002)(2616005)(4326008)(86362001)(5660300002)(44832011)(83380400001)(26005)(66946007)(38100700002)(36756003)(2906002)(7416002)(38350700002)(8936002)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E5+GQ+9CD5KechZQWole/xgmLmk3R+xFgkEZ3u13U1GCY7PddoGVDGwUx0GH?=
 =?us-ascii?Q?67ZovVTcL94OIB2cEVVq4QPmCrHXblD9OmtgySYnbYA9wfG9eRN7rB/3HFEz?=
 =?us-ascii?Q?azw/OU3I/XwLpNCZRJ5aJ1xpuXjqRhlbaarZxXkg+OxAbsaWRZ6fl2UfkaR9?=
 =?us-ascii?Q?v6DvgAWyV6dYI5VB9gWPE/Vc3MHtT0MMdC7KBqG9MDPH889i8+lD96iJgMIK?=
 =?us-ascii?Q?f2lB5/j+z5HSRg8TpFan2gR2A2IUkGn5UHvgh/cq8MqZUFPa/KuuIi/eEMWZ?=
 =?us-ascii?Q?VbyEbVMGv6u6QJbApGxxviAcn3TTZ4or4pr1WC6+Ckzgiyf5iFE80hElI3Cf?=
 =?us-ascii?Q?ucY5LKkx8zEhyG0f0L8PxzPlhac9iqIZJ4oHVTJcUUVMyPHwvFzBx6Yaqlca?=
 =?us-ascii?Q?yeBujcoizmJb5DSr7YttAhaK4FFWfrAkG07h52NUf1Ddt5V0K44JJTtjaqLC?=
 =?us-ascii?Q?/trW5ErIewig4QxHu3Oyc3LtKicI+3hiLZnET+0TnVZWgHA27XgINQOgTUM9?=
 =?us-ascii?Q?vPrDzbEoYIs/bDqPVaYyON4j0+SofGiBWCNXxyDrABFTzXEhVpsnoHp0pzVg?=
 =?us-ascii?Q?pNBe8oF/sfIHr3hLeWg8RwuUBU683kGs67JPaWCDrRjWJUtxAUKo07XTKiCa?=
 =?us-ascii?Q?gfiVbHyDBAwsgS6OFtloK+R8r/aoYeuqalHW2GuKKSNP/axD638GGAefSwDB?=
 =?us-ascii?Q?nWeV+4JtHhv+2wlKwiD+GkQHtPjadpARNGfrXYNhw8VP7rNCu/ZzkUJuJn0Z?=
 =?us-ascii?Q?tXgcxoSAyL5C5BY2RJb/pEEHT+tzyXbKoaP51aeAPMnYgWhGfarckn3+GptO?=
 =?us-ascii?Q?at/R7w5sEoA5zeuvMQDdqRh90wPxGFo+uP4MZMLn+T0ZldPN1h6P43LN2O7l?=
 =?us-ascii?Q?13xF/le0KRSAbaaTJAA3oXUVQ+VNIYMm9cRkxsRwgWkCBmdiOrCcVKlQp4S6?=
 =?us-ascii?Q?BISoFAfnoNrv0DX1ENk2UokeqGudIaN7fMLeDSdczjA5udZUIM1JHxbawNIf?=
 =?us-ascii?Q?X7WMgrdKFInPORKVijirO+DVA00u972o0p10ILDky+5DCj3b0QmXNwmTJ5R3?=
 =?us-ascii?Q?OjRDHYTRI6z3b6Sq1QjgIZG3Ewow/oD9HC4SvbNfbGR0aS39DBgz+X92cvRk?=
 =?us-ascii?Q?kiZL8V5vJPZ1hNCUqtiXELMPZPrnUj7u/n+ARpUOrzKIeJpu1Ls/oymH+mlQ?=
 =?us-ascii?Q?gmB1Dmvk4r9ctGLF+xMae9UdlvqoQrrwgJkyU7ITXpjyjLh64gfIK7NNSNDm?=
 =?us-ascii?Q?VAnu5+9vdtaM0HX+7SgLQknGqGSYsNP3N3K6/NtPZ06G5DWhTJ4UCKhS2V0F?=
 =?us-ascii?Q?+GlxwE52yadJkpnYdWXaOCJJyCRb+PTc1ohk/G37zMS9houH68JvqFic8a9s?=
 =?us-ascii?Q?K3ZSPecvrItSf1W8GrQWVwszJfMp01dN35gNw2DFh4z1eWKuc2MleTpMil5c?=
 =?us-ascii?Q?zgzgXzsqx7ZFANpliGQTF3Rin60KVKjWlqseftdU/UYMPIy8aMetcsR98U2W?=
 =?us-ascii?Q?R8qN2C7jVKc4BfbREaWLvGOMiIrtnJePzUV9KFy9iq0CSIeQlrmBxuIo8t4G?=
 =?us-ascii?Q?daL6x8JpttS+DHgwOHTxhQUS8/lwQPiSf5CBUD8jcIpDhzG9vW46B+WhY8DH?=
 =?us-ascii?Q?GzBmgHrKodVfR7c29IEkVucNj4yuodGM9Uf61wW22/vHgClxTk48Lm28KMtV?=
 =?us-ascii?Q?8z6bIM0by2/ftuUOYpLhKATT9Yf4Wp5f9gjdBWYEYDariE8M0VXYpdz2Ufff?=
 =?us-ascii?Q?kJKauWgSqg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c8ef1d-5011-4a5f-f2b3-08da1bd545fb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:06:44.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKe2PlwlwwWrbbHM1DaHdQVPVPcsKDY/uri6aebSYBvFJB36iJgBgfElycH3HiWVYbc8yBp4lZlmp0kBAhCI9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2609
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: e7JMvP2STZQ37YlwwHJbHU-VCZAzGJpZ
X-Proofpoint-GUID: e7JMvP2STZQ37YlwwHJbHU-VCZAzGJpZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a ram-based filesystem that contains the files created for each
shared address range. This adds just the filesystem and creation of
files. Page table entries for these shared ranges created by mshare
syscall are still not shared.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 Documentation/filesystems/msharefs.rst |  19 +++
 include/uapi/linux/magic.h             |   1 +
 mm/mshare.c                            | 191 +++++++++++++++++++++++--
 3 files changed, 197 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/filesystems/msharefs.rst

diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
new file mode 100644
index 000000000000..fd161f67045d
--- /dev/null
+++ b/Documentation/filesystems/msharefs.rst
@@ -0,0 +1,19 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================
+msharefs - a filesystem to support shared page tables
+=====================================================
+
+msharefs is a ram-based filesystem that allows multiple processes to
+share page table entries for shared pages.
+
+msharefs is typically mounted like this::
+
+	mount -t msharefs none /sys/fs/mshare
+
+When a process calls mshare syscall with a name for the shared address
+range, a file with the same name is created under msharefs with that
+name. This file can be opened by another process, if permissions
+allow, to query the addresses shared under this range. These files are
+removed by mshare_unlink syscall and can not be deleted directly.
+Hence these files are created as immutable files.
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f724129c0425..2a57a6ec6f3e 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -105,5 +105,6 @@
 #define Z3FOLD_MAGIC		0x33
 #define PPC_CMM_MAGIC		0xc7571590
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
+#define MSHARE_MAGIC		0x4d534852	/* "MSHR" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/mm/mshare.c b/mm/mshare.c
index 436195c0e74e..ad695288d4bb 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -10,20 +10,117 @@
  *		Matthew Wilcox <willy@infradead.org>
  */
 
-#include <linux/anon_inodes.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/syscalls.h>
+#include <linux/uaccess.h>
+#include <linux/pseudo_fs.h>
+#include <linux/fileattr.h>
+#include <uapi/linux/magic.h>
+#include <uapi/linux/limits.h>
 
-static const struct file_operations mshare_fops = {
+static struct super_block *msharefs_sb;
+
+static const struct file_operations msharefs_file_operations = {
+	.open	= simple_open,
+	.llseek	= no_llseek,
 };
 
+static int
+msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
+{
+	unsigned long hash = init_name_hash(dentry);
+	const unsigned char *s = qstr->name;
+	unsigned int len = qstr->len;
+
+	while (len--)
+		hash = partial_name_hash(*s++, hash);
+	qstr->hash = end_name_hash(hash);
+	return 0;
+}
+
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
+*msharefs_get_inode(struct super_block *sb, int mode)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_ino = get_next_ino();
+		inode->i_mode = mode;
+
+		/*
+		 * msharefs are not meant to be manipulated from userspace.
+		 * Reading from the file is the only allowed operation
+		 */
+		inode->i_flags = S_IMMUTABLE;
+
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_fop = &msharefs_file_operations;
+		inode->i_size = 0;
+		inode->i_uid = current_fsuid();
+		inode->i_gid = current_fsgid();
+	}
+
+	return inode;
+}
+
+static int
+mshare_file_create(const char *name, unsigned long flags)
+{
+	struct inode *inode;
+	struct dentry *root, *dentry;
+	int err = 0;
+
+	root = msharefs_sb->s_root;
+
+	inode = msharefs_get_inode(msharefs_sb, S_IFREG | 0400);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	dentry = msharefs_alloc_dentry(root, name);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto fail_inode;
+	}
+
+	d_add(dentry, inode);
+
+	return err;
+
+fail_inode:
+	iput(inode);
+	return err;
+}
+
 /*
- * mshare syscall. Returns a file descriptor
+ * mshare syscall
  */
-SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
+SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		unsigned long, len, int, oflag, mode_t, mode)
 {
-	int fd;
+	char mshare_name[NAME_MAX];
+	int err;
 
 	/*
 	 * Address range being shared must be aligned to pgdir
@@ -32,15 +129,14 @@ SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
 	if ((addr | len) & (PGDIR_SIZE - 1))
 		return -EINVAL;
 
-	/*
-	 * Allocate a file descriptor to return
-	 *
-	 * TODO: This code ignores the object name completely. Add
-	 * support for that
-	 */
-	fd = anon_inode_getfd("mshare", &mshare_fops, NULL, O_RDWR);
+	err = copy_from_user(mshare_name, name, NAME_MAX);
+	if (err)
+		goto err_out;
 
-	return fd;
+	err = mshare_file_create(mshare_name, oflag);
+
+err_out:
+	return err;
 }
 
 /*
@@ -48,7 +144,8 @@ SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
  */
 SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 {
-	int fd;
+	char mshare_name[NAME_MAX];
+	int err;
 
 	/*
 	 * Delete the named object
@@ -56,5 +153,71 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 	 * TODO: Mark mshare'd range for deletion
 	 *
 	 */
+	err = copy_from_user(mshare_name, name, NAME_MAX);
+	if (err)
+		goto err_out;
+	return 0;
+
+err_out:
+	return err;
+}
+
+static const struct dentry_operations msharefs_d_ops = {
+	.d_hash = msharefs_d_hash,
+};
+
+static int
+msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	static const struct tree_descr empty_descr = {""};
+	int err;
+
+	sb->s_d_op = &msharefs_d_ops;
+	err = simple_fill_super(sb, MSHARE_MAGIC, &empty_descr);
+	if (err)
+		return err;
+
+	msharefs_sb = sb;
+	return 0;
+}
+
+static int
+msharefs_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, msharefs_fill_super);
+}
+
+static const struct fs_context_operations msharefs_context_ops = {
+	.get_tree	= msharefs_get_tree,
+};
+
+static int
+mshare_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &msharefs_context_ops;
 	return 0;
 }
+
+static struct file_system_type mshare_fs = {
+	.name			= "msharefs",
+	.init_fs_context	= mshare_init_fs_context,
+	.kill_sb		= kill_litter_super,
+};
+
+static int
+mshare_init(void)
+{
+	int ret = 0;
+
+	ret = sysfs_create_mount_point(fs_kobj, "mshare");
+	if (ret)
+		return ret;
+
+	ret = register_filesystem(&mshare_fs);
+	if (ret)
+		sysfs_remove_mount_point(fs_kobj, "mshare");
+
+	return ret;
+}
+
+fs_initcall(mshare_init);
-- 
2.32.0

