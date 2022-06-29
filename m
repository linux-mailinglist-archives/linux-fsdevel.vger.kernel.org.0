Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901AF560CD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 00:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiF2W4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 18:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiF2Wz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:55:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D265841325;
        Wed, 29 Jun 2022 15:55:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4ain000903;
        Wed, 29 Jun 2022 22:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=w05FYHNlKNrWph18aS5RLxPDQ90bMPDdwIo7huXc+tk=;
 b=ICDvyNIiYYntUWkd3FULW3fwML0R8tgjmyJYREDpRhHOAPoF2jVipNvGeMBh3FJwOdWn
 csGdXCp/xitEQecxBOpIBO96E9D6l1MyH3JIeQcVMV/vHi7lvW1/Iz6rD9cqXSrkmFIu
 rr7y2GkI5BxfA8E5dH/cneHVY9rc0ycPVR/7yjqz7qAEoKjlz4c/CVrkyLlTzNUpkuXy
 1xbQZcbnHcqcMeAWd8t8Oda1bqcbCDMk13gAhDLS1QuNPop/flgPksigkjluYhAgVgOI
 /ef+HnVDlLroE31salhXTKu6+GhfCd4BP+8XPyEK8db02VPAfyX0iV0rFHs0X6Cmap6N pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0jnk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMeS2v031827;
        Wed, 29 Jun 2022 22:54:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt3h9rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWpL9iTGpVXwMVZLNEWdxiJkfmlwO3Aqv6lkI6JK/zvXmIkjK/5aReCTg2StcLGemPZrpr74uyxy21wR+thO2sFNkAgvJBPg+vHJPKXXwXFg4EY+mA6Zgj1qGiqTrTmqqa0zBfaxKIh79VzZ25ro2r0NQwpYwjdpjlPiD5zhycpXH1Z1sEvwbz59OJRywq24DR++mNnZ3EmxW2Cc5v1lXA+g1DtdsPhOMvo6KcdCknyDr8RjRjbAu2UgJwPPuJxkci12IDAicVjB10rJv/GYqDiLyhd0lQK7SA5YPMWhgJf9Klp/RiSOpPOVqMWWVdY3v1sDYEHZc7L01BOUz954UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w05FYHNlKNrWph18aS5RLxPDQ90bMPDdwIo7huXc+tk=;
 b=AXuLY4BxwSvxt1vrT2QLpuu+MLKSd8rsZ0Fet+98lWOGkYUXwMKoEfFPoNSRkcCcHnn6djCaowwjc6ZwhqQ2uVzUFrIx3TjrWGUF+ziy2bmBi0cs8Cwa7BZyL99aOgw6mLlf/U2Q2/Th2roW3X9g35ouS1pinbOsgQkub7oJL8h2Y3as153exWeSeUVpbtM76tC/UbfwtYZOVTS07gf6dt3s7LbPTkNM0ZffEZphaWxE5pNmHGtf9ueCacoAcRIiF8PPIP58XfmTYg1LQ9TK9qDNlJDDebzEtR/OFy09+lpK3ril6ijh807pGb8lcJpLqDzU5OMN3TtSfR1nuO8ENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w05FYHNlKNrWph18aS5RLxPDQ90bMPDdwIo7huXc+tk=;
 b=qL7sX2FnZEd9Vj1t3bqXVO3ghN+G4GbjYqu4r1y7Fvms9HicY7TsS2KD5Ze4SZIlnhZqkTQtuLnfcULxN2dIlssLJSz8TKq6yCszbxZ7FV2TUUfhQB4huomvaR/BCfigcckQKM4pdisyT4EUtI50xwVMrJ2bMHrCZxrtZxMVv5Y=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1834.namprd10.prod.outlook.com (2603:10b6:3:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:54:18 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:54:17 +0000
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
Subject: [PATCH v2 1/9] mm: Add msharefs filesystem
Date:   Wed, 29 Jun 2022 16:53:52 -0600
Message-Id: <de5566e71e038d95342d00364c6760c7078cb091.1656531090.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ae2a4b2-e0f2-4184-8652-08da5a224be5
X-MS-TrafficTypeDiagnostic: DM5PR10MB1834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxfIi/GrdJHnGL5Tdd9eQA6PNu0MHMk+Cl9HcA1H9MY0YJOoeZkQHJM1XJU/+VP+snIKaH7sH5NI8cZk4nfZB1c34ryLY1DRWzjV4Y0d/jQMr8aTqoorHaw5zFuv99RO1r4+iCugEiV1g/4wwCLwyFqQzGvGrLf6c5ybZQEyyOZEE0E0ok/cW5lNA3Z9c2mzd2GoazKOKvRmUUgjJ6G8RC8zvrcOy3OC55SmCY+o0OR5yAQXWFWGDamRJiQjYr6aPsHIot2YjN/Bfu2W/821Bcw3F3fDwuqhPUQHSO83cvbTXQGLHu1eBmrJzNQsnpsr4Rp1MIuZBCfFWEDfxUt1ivlNFzxRcJpKrLfGyGC8rdsPQZ6nZNC2M6OYAS45YGmcsRAbAdaKIMIrU/EEV9jbwSpDT1qiT5B7SwYbwPKpuNkdO+5luTV+8diRvbXiG5dJQg7odAJDk7RulkvWBetwNrxZ2TPDlCqppDb48w7by8QXkWDWZ1/a6VCf8EkinQAC9hrpNtV9+JryZesWfOa26u+Mfu52KIxjIPO1pST0+qGck2PeNP6WwuzivNhFTnF7ALjX4rI8iiKZafKxhTi1uEozsoSDbS04SKg/jyN9iP7uC/WU4nEHE1J9Nq4yjxmo0hHGSYgHFmDcYktNRvJiNytBTXvmiv523aXKSnrHPWZTUrsQAjHbpxDJ4xMuGZpMs8bIR/E1gLG9PSO8qVtNUHQhir2cpFQHSuvItNY+2yM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(52116002)(41300700001)(186003)(6506007)(8676002)(66556008)(2616005)(6512007)(66476007)(38100700002)(83380400001)(44832011)(7416002)(8936002)(316002)(36756003)(2906002)(86362001)(66946007)(6486002)(5660300002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XsklGQ1jNXpnPtWr9IIVIHKgLe8vjWVSaB6AnB+hl6BeRrTtwMo3x6z14/70?=
 =?us-ascii?Q?ck/MTLXCsMqLuowarkgTd963Bj/3+DuhcLHxYyWDab+CkIbHydG8PxOQkLTC?=
 =?us-ascii?Q?fBoWmEONmqgy8Byiv6etm1Do1lq0iGK5qdBHQh/bFnulT2ohxZMsh2sqPWzQ?=
 =?us-ascii?Q?lbdQISQ/zdvlcT7gQiy/J0xMC1xBWsPF+QgzJxukRrauKm1TeSepmazdTkuk?=
 =?us-ascii?Q?EgGezLs4qWzF2MfDmoMVFG5DEVV6fkYgcKeOpGCLUYyLahgrZ3QLgYTChdov?=
 =?us-ascii?Q?FhEHetzJ/ztTKQiL796y5oLmuC9LD5Tjd+KtteD1OkCM9/2LLDq1gCt67Hnc?=
 =?us-ascii?Q?mZtI+DHT751NvFV/PPR+6a9xDZEQ6Zgr9fwy2bTIZA4sA/2r+ujRQJYYAuqw?=
 =?us-ascii?Q?ZP78RlmYAd13VrKfK8+B6Ujiloj92QqgwhsJCEqc9xZ+88nbWxgCRhOOL4Ez?=
 =?us-ascii?Q?Rg7gepDgCwSdkBjPqeOcrCTR19B/t5B72eZVSjnuDFr/2UiB/cynYN8b4eg2?=
 =?us-ascii?Q?Lh9eWsnGyI/3Bi2OPjPON/EsLrT81FJZzYQk4zgGj9wByot7nxclxbaB0kDG?=
 =?us-ascii?Q?wraUvJlLCTzSeQ9dIzXxQkOK1kYANSeqbJ042goY0WE4IAwBod8RBsI4S9ua?=
 =?us-ascii?Q?uOSlc0vU4qkgqV9q+ew/sgw2xrOKxgLEdYUdDhWvd+jeHPhbbl+ISqg+VXGK?=
 =?us-ascii?Q?XXKekHwHIXtGybgSKT/j5oTPdyyxPRe2Etw8Tu6TSOwWtxbn4xQ4ArIk8C7N?=
 =?us-ascii?Q?XapAxNwlu988iBqWwduFk66bEaMQVDO3RcWI+9qsMeNLMMNSk19rKAA8i5an?=
 =?us-ascii?Q?mOae/ZJGipfwOcn38gzQrM431qYGkpLrVh0H7/+43+Y2szSxUzJb5UAgph6M?=
 =?us-ascii?Q?nUVm2RYRk0o2/DmAoQPQnYl2WbLvKwBbqcuwgCAk1Lvhye7qEys/djSz01TY?=
 =?us-ascii?Q?NPTS0GfI+M1sdvqhPMpp673/oGehBWY9e8kT9BX+WMLHyjpr8PyrBAZh2JOt?=
 =?us-ascii?Q?rvld4FaTifCijASgCgvNNKOLtPivwSvk6Kpqsz/wuIKbJoEqauiZQYaccfr5?=
 =?us-ascii?Q?g5rQqnilBkG6AqQGq6zDEFoDb7kWkNhnpI9izaGpXvBkz9UQ+14sPSxOVBJn?=
 =?us-ascii?Q?UqR6ZKYGRVGAPGQHnvgstQx047NZdHs6iSSeIfmK0tBaQ9GK/eqKNytLLS4j?=
 =?us-ascii?Q?gqKZelfrm32PclHxdREWuKhcU1HznyAFvTIDM3dK73GZ6J7eDVRLq+80+3Z9?=
 =?us-ascii?Q?tuNmPntDVrD72NCJMNbKUHRk/DAlHI0ajfaNkkdaERLx65hcrYBtkGtuyFYC?=
 =?us-ascii?Q?qGrLdheRj4VMUbmvHLEtkrj2cR4L2wBxgF6LLPm50BmIgVrplvFwgBDCsIdU?=
 =?us-ascii?Q?emaQMNWzuTOlOob5Z16QZrPkqs/OxHjAwp2Vz3IbTSFEhtrL73cTr1M5QnnX?=
 =?us-ascii?Q?NY6wJGxxR9pt2IFsVAnQhfKWApVD/6U9w5v/T5QIHIaFgbmQOvxO6iJZQI5o?=
 =?us-ascii?Q?XOqm/4B/b9YvJ+CUdDpVmmWjYuIr/diwFEXVDUtqwGTvpkFTv3pPXIBJVPMp?=
 =?us-ascii?Q?daG5nSie+wCL035Fbu6v5PW1DSRrT3f3ruL/+avf67iIqhJZbiU5vWCW33oC?=
 =?us-ascii?Q?xBqzeIPpWGO+oerH5H5WGx/o0pfveBmNSMHATtKKMH6j?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae2a4b2-e0f2-4184-8652-08da5a224be5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:54:17.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWM58AzVeAoYEqqjkWEuLcfIu8AgbOtsDxTK4QvHDgINi/Fak1FnIudqrMPQrjgqrXuqFDJM/2PlqvJ2nr8lvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290078
X-Proofpoint-GUID: U_44Uyr39N6VLmhZKqP5bc78xPmdhb6r
X-Proofpoint-ORIG-GUID: U_44Uyr39N6VLmhZKqP5bc78xPmdhb6r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a ram-based filesystem that contains page table sharing
information and files that enables processes to share page tables.
This patch adds the basic filesystem that can be mounted.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 Documentation/filesystems/msharefs.rst |  19 +++++
 include/uapi/linux/magic.h             |   1 +
 mm/Makefile                            |   2 +-
 mm/mshare.c                            | 103 +++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 mm/mshare.c

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
diff --git a/mm/Makefile b/mm/Makefile
index 6f9ffa968a1a..51a2ab9080d9 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -37,7 +37,7 @@ CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
 CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
 
 mmu-y			:= nommu.o
-mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
+mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o mshare.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
 			   pgtable-generic.o rmap.o vmalloc.o
diff --git a/mm/mshare.c b/mm/mshare.c
new file mode 100644
index 000000000000..c8fab3869bab
--- /dev/null
+++ b/mm/mshare.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Enable copperating processes to share page table between
+ * them to reduce the extra memory consumed by multiple copies
+ * of page tables.
+ *
+ * This code adds an in-memory filesystem - msharefs.
+ * msharefs is used to manage page table sharing
+ *
+ *
+ * Copyright (C) 2022 Oracle Corp. All rights reserved.
+ * Author:	Khalid Aziz <khalid.aziz@oracle.com>
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+#include <linux/pseudo_fs.h>
+#include <linux/fileattr.h>
+#include <uapi/linux/magic.h>
+#include <uapi/linux/limits.h>
+
+static struct super_block *msharefs_sb;
+
+static const struct file_operations msharefs_file_operations = {
+	.open	= simple_open,
+	.llseek	= no_llseek,
+};
+
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
+	return 0;
+}
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

