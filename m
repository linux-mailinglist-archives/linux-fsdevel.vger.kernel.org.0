Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF34FC1D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348448AbiDKQKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348396AbiDKQKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BDC17A88;
        Mon, 11 Apr 2022 09:07:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFxoBF032238;
        Mon, 11 Apr 2022 16:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=cZ1qr4X6tFMeVv1Mz56twvprFe2XP1f++flf8dat6MU=;
 b=HwRpVn3ZovskAFx9CC9M0WvWwEEmELU1blqHuc8xAJQxeMp1xyVdGgSR9sxix06ADUQf
 He5oaF0CMJYgZWLwZqKBuD0fRtXdjMPUO7EE+dr1BEPiUkv07zLXWhDtuMfb7aLpfClC
 vALmYvnIFgniF+pzR3cz4NMkdeQLd2/P894/oThPNLHmkkJNT8u5NBU+6B6NfXPuus+f
 VZs4/iQ+ahFAaSm9kxfyCgbW3gzBi3hXJib60RULAd21oSaZ2vZ7ItUeDkSVhs7d3Lu+
 DsIzX0rhRAMVFPbfbqK6ksppQUyosUt4/UEFmXhhX7cvn0Dtd5NCuEnrgBSkZ8mlZZkA Ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd43yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG1fwk009897;
        Mon, 11 Apr 2022 16:06:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k2057y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:06:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJgo6xsagR/wznqt48/QrGJB5fC0U3Au1HiSzLWuxa2x6qBEVL/33p1Ulf7JCrjvL3NGzrok/2KdwKvxpPluZwX5Z/1zN16Q9wJEY+oVkya9uHd4y+AY4ASmXgWB2urmiAjGjf9J7WKXRvEQILGAJwf+iWNu0mqq6IlLWGw0tD/vWTtYxOZUpOKW+7yNpDgPMgM9wezUP0BQcC7xgOejBdUj0Wc2X8loKHGYBU02dcwJ0U2c/kTxiF2yfw9sO5QxR8nxN0XfgO9CiduK4tjcdy+iinnB5Bywvv9XHN7uBjYlqExnLW9+MZtp0Emvpm/XglQN2DNNQb1zao2XSFijUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ1qr4X6tFMeVv1Mz56twvprFe2XP1f++flf8dat6MU=;
 b=gS6qtyVldv7lrt9X14lNxZrBuLDCneaFOrbDvCQZP1CNP93e5yTa+bmLche1CHRl5OdqBZ5FK0aZphDLECjDqALIiCTX/nBOm0U/9lZbfWWUD9j4vEUYHgJJQV6AhEssg1Qd/JXdR82vbhkoEV1fGuyu0pW8JxemIXY3n+7ildGVPyAZQyAaijXICs0XQrzzo0n9WvQOuCWoeoMjv+8uJ1BOgED55SLdaQ0dC32HbMiYV8X2qJbZ2ReNn99hvDnrJofNZRB5yoR5BaHxaOrBsSmHX8swMzwgPzHFC5wpvutBPER5y/b84QALd5OGL97eDG+MxYlWPtp6h8hbAMMehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ1qr4X6tFMeVv1Mz56twvprFe2XP1f++flf8dat6MU=;
 b=G1ZWd1HNadf/3kJrMheRkhC50zxxazXB52gRa231eMh0S5tPzs/MMYF8DXZiGNAsHTYZHQ2mclillcRNHDEn5A1GBtZhzcSwFWNUHj1kr2uSXF68CKkqvqIJYNL5yyZwAcAM26H2oFvmfxUzdzwcQuVqjylDwExSl6Ckb1mTSos=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:06:50 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:06:49 +0000
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
Subject: [PATCH v1 03/14] mm/mshare: Add read for msharefs
Date:   Mon, 11 Apr 2022 10:05:47 -0600
Message-Id: <4978f8cd6e566e531af457d46d00e5a7f3b2d8df.1649370874.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d1590be-639b-4853-c05e-08da1bd54921
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45641544F40161971AE6D19E86EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yozN/gTqZW5mvg46Gfo+OZNnFYlaz0t/ok7I3ltW+qM1iJhTLvX9bBi9+s0+JfmXYJ3E7CoIYtmWy/YcGu0/RlD7BHEAMwUIDT1PkFTvQR5hiQ0IS4ownnfJbxQHpbeGK4sS3UF/9fO5we6K9hi2uehkwFCJJ6TfzewPgU/maziKyFY7hbqXu3Nzf/X8whqB9VeTZWr+43NH5Ad26oyuRaO/JnoYCxDvAfvIzZFP//QiVnANHLElv+Oj1UdojNNmRtSb75oJTRkSfhD2tSlFI6fXcwRCrBr0o0YPo282iovPF40XW2uxk78aqctOUbNGFZkDRPLpkun0lWv/ODjoypBUcB9udj3NIrnDhbpfXuAZxA9wbzuPn+cimaGyU7siFGpNYTx27Rfii2eQN620bCBOPCNjo1oPvNourkFYrDFz7bzhqcKQL7mNzS1FCzHPpNjJqfEHFdvC/NB3N96KFCNHDnLYZnZgNNRSH0qkTEYWi2uFqL9mzAmDT6U8t6AwTuT3ZgTT/42uoGz054YNZJal6JLXXxnWBdtRTx4vrg9KJB0ES8LOaJSnpbGOwJjuLtwwyYzUw48EzZP4Ooq8+uPIKeeKPViVLrpk1yJ+3wzNOy04zbyAy1saxmCIApbPPYiVxY8yOFl7V71ozbZDPEvVEXqX+kCrbmPIlGBjvzGr4EQ7HbKYw14LnonhMZTv2ISpy9TMC8iKNUpsmA9ssg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(6506007)(44832011)(7416002)(4326008)(8676002)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(83380400001)(2906002)(6512007)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cdjSvSytdjAt3NRdXhoer+e8kgVyDaNB1o/hDcSUyNX6e/NU2vEn85klIWPZ?=
 =?us-ascii?Q?t2OxVUay1bIHNxo10VvkWxWZ0UOytXOUSr1Lp5rPwSndaLX8X4M2f/Sv+C1o?=
 =?us-ascii?Q?8Y6/rDXafQ8CsohxhD3iD8SNKBbUcGzp18wb1i6uuWHVJX6dyYYzzLYIoxOi?=
 =?us-ascii?Q?Y83Jg64NgTfi6j/RIrmA5GHUCHBeSLzB6mvXzcOsLB5tIdqU8Yrj+MQyGkon?=
 =?us-ascii?Q?PKkeQHrw68s8v7J0IR2PgJoVAe3Y+DIJ2+tBGLkFZ5n1GMysdx8PhH/WFR51?=
 =?us-ascii?Q?Y16Fdjo0U2ap+aQu4+BpV4uB1ZTOCzlu6Y+conNWaKAlkX7Wi4TDhqEyN0Bn?=
 =?us-ascii?Q?1iT3RMcKCZgVSUURvqI+7k0tXPaOei8VNYCcP1ZEbwRCDS5/RnjztINW/s+g?=
 =?us-ascii?Q?iSOY6bNaB48ThkKRPJdAddsdHOwp3oIJBhsx6bn+Is3QuCXW2/5n73EVtVIj?=
 =?us-ascii?Q?36TCDIxByr9At3wj+SnylLfSrR4edpX0dHN9eYm68jdUjLf/mqyNET32HqdD?=
 =?us-ascii?Q?ft0xY+0ONCqkPcb4X9qK5BoRQfXMSgAijC3KY0UIAF9HHd+Z2/XD5G3jVyl3?=
 =?us-ascii?Q?bKWfH6QFA89BPuxOQVCXDUJc3AbhCtbuqPmSlqX33khxoRdwM0m2ehERz0d4?=
 =?us-ascii?Q?EWJNJMsUV9EgPntqxT5gPomajLYtQrcPb0/fF5HcQGGBFgKroYHt/9dFPuoM?=
 =?us-ascii?Q?QA9+5oJU4mpIofOLKpB8Uao95bnf/HqRUj2iMAtzDRYYMxA9vgjDd76q0nDv?=
 =?us-ascii?Q?de7GpF7f6p0nHyXMa7WI5kPkI+bkGK9OECIxjWv+D0R4MXiUeF08jnwW9PkZ?=
 =?us-ascii?Q?7ZoF0+7/DTgXRrg1KsEtJhPQdWmbvIzoOfYAHuRDLplKsCkl7LaYjmOn6bAE?=
 =?us-ascii?Q?ZAKgNn2L9AW4KLhj9am73v07dVzIxTsn4HPItYYbufMDMEs1aEv5yvWbxWys?=
 =?us-ascii?Q?XN4zoY9R4FO0NIkihzT09ujhS0+72QPewLnVxU2HCyIfHuP72DA0LUqzv3gY?=
 =?us-ascii?Q?+0HCi7EAX/EUad9bwyTEWS/Xlk0cH2eBFVUlld4GQUOy6/7uSZ+ie2uDzzX3?=
 =?us-ascii?Q?2Q0QGqGLcl6ScuJFRlcHz7vu4Ej1Xk78NH3EfDrewV1GCw/WTkWKJZ2YHo9Q?=
 =?us-ascii?Q?179K4QGHvJnEQMMu3OowPCiTGGlFV2IrTxoD2I2+/ZvUN0fwrrj3MSwBYh+Z?=
 =?us-ascii?Q?Aei5/DMpdz8UmMW4elnqQkvjFWMbj4RjLhSIxtWKRV7e7vv2zxxMDjFpVf2b?=
 =?us-ascii?Q?sl9kj+++89InQ0gKr48RagnYEmXSdQJukipM0kcrF2CZzYlYWpMA+klGzfUp?=
 =?us-ascii?Q?ZjMpGNEXXUYUhscXACE+/UHgvr570Lv0RyzLZPGhvErjePu/XfKTDqgEepfO?=
 =?us-ascii?Q?xBIhSQgUCOk2WQ8vSzsDro1mcdG7tihU6jDD23jUZRnho3c53fzOyiLhlFWh?=
 =?us-ascii?Q?r600wjCdZjP5PUOvxnGAWioUz0G3V6nD+QrgJuOrqTbzKTlIOZciLcavpYui?=
 =?us-ascii?Q?0nucuPK/1jrlEn2F4sDIiQ3Wy88LvgxC7V5rxGCOAS7w6Zt0EDGEccoCFhe1?=
 =?us-ascii?Q?XSL0JLRot9bVU8JbA36SXeWgd4L6Al2FGrd8M3nJNDqrC87OFgCkrH76R1EN?=
 =?us-ascii?Q?eAL8rAiuS1IqLMNuOOe9PwKXbKdaCnNo58DG5Jd093MeQmDH8pzrNxnuwbch?=
 =?us-ascii?Q?szsIN6V+sPcC50ytqIXwqnK9SflLYPRL0VUX3nuHmVRoMc52E5q974/AU3IZ?=
 =?us-ascii?Q?hPAmLb+F9Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1590be-639b-4853-c05e-08da1bd54921
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:06:49.8091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8dWzItDQepCVpipYYsIMI2Z6TbjLOPc1/RAjp7X9uTSAIh0KKYvugbR/ZF+PQCXjKpeKV/YhY+y63B5P5AxqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=871 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: TaSlDG3ONARtjeJdh-WKfUkOAf4FsFMU
X-Proofpoint-GUID: TaSlDG3ONARtjeJdh-WKfUkOAf4FsFMU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allocate a new mm to store shared page table. Add a read operation to
file created by mshare syscall to return the starting address and
size of region shared by the corresponding range. This information
is returned as struct mshare_info defined in include/uapi/linux/mman.h

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
v1:
	- Read returns struct instead of two unsigned long (suggested
	  by Mike Rapoport)

 include/uapi/linux/mman.h |  5 +++
 mm/mshare.c               | 68 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index f55bc680b5b0..56fe446e24b1 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -41,4 +41,9 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
+struct mshare_info {
+	unsigned long start;
+	unsigned long size;
+};
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/mm/mshare.c b/mm/mshare.c
index ad695288d4bb..59e5d294e562 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -16,14 +16,39 @@
 #include <linux/uaccess.h>
 #include <linux/pseudo_fs.h>
 #include <linux/fileattr.h>
+#include <linux/refcount.h>
+#include <linux/sched/mm.h>
 #include <uapi/linux/magic.h>
 #include <uapi/linux/limits.h>
+#include <uapi/linux/mman.h>
+
+struct mshare_data {
+	struct mm_struct *mm;
+	refcount_t refcnt;
+};
 
 static struct super_block *msharefs_sb;
 
+static ssize_t
+mshare_read(struct kiocb *iocb, struct iov_iter *iov)
+{
+	struct mshare_data *info = iocb->ki_filp->private_data;
+	struct mm_struct *mm = info->mm;
+	size_t ret;
+	struct mshare_info m_info;
+
+	m_info.start = mm->mmap_base;
+	m_info.size = mm->task_size - mm->mmap_base;
+	ret = copy_to_iter(&m_info, sizeof(m_info), iov);
+	if (!ret)
+		return -EFAULT;
+	return ret;
+}
+
 static const struct file_operations msharefs_file_operations = {
-	.open	= simple_open,
-	.llseek	= no_llseek,
+	.open		= simple_open,
+	.read_iter	= mshare_read,
+	.llseek		= no_llseek,
 };
 
 static int
@@ -77,7 +102,12 @@ static struct inode
 
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_fop = &msharefs_file_operations;
-		inode->i_size = 0;
+
+		/*
+		 * A read from this file will return two unsigned long
+		 */
+		inode->i_size = 2 * sizeof(unsigned long);
+
 		inode->i_uid = current_fsuid();
 		inode->i_gid = current_fsgid();
 	}
@@ -86,7 +116,8 @@ static struct inode
 }
 
 static int
-mshare_file_create(const char *name, unsigned long flags)
+mshare_file_create(const char *name, unsigned long flags,
+			struct mshare_data *info)
 {
 	struct inode *inode;
 	struct dentry *root, *dentry;
@@ -98,6 +129,8 @@ mshare_file_create(const char *name, unsigned long flags)
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
+	inode->i_private = info;
+
 	dentry = msharefs_alloc_dentry(root, name);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
@@ -120,6 +153,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		unsigned long, len, int, oflag, mode_t, mode)
 {
 	char mshare_name[NAME_MAX];
+	struct mshare_data *info;
+	struct mm_struct *mm;
 	int err;
 
 	/*
@@ -133,8 +168,31 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	if (err)
 		goto err_out;
 
-	err = mshare_file_create(mshare_name, oflag);
+	mm = mm_alloc();
+	if (!mm)
+		return -ENOMEM;
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		err = -ENOMEM;
+		goto err_relmm;
+	}
+	mm->mmap_base = addr;
+	mm->task_size = addr + len;
+	if (!mm->task_size)
+		mm->task_size--;
+	info->mm = mm;
+	refcount_set(&info->refcnt, 1);
+
+	err = mshare_file_create(mshare_name, oflag, info);
+	if (err)
+		goto err_relinfo;
+
+	return 0;
 
+err_relinfo:
+	kfree(info);
+err_relmm:
+	mmput(mm);
 err_out:
 	return err;
 }
-- 
2.32.0

