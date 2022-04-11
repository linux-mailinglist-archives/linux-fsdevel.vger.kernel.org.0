Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096524FC1D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348469AbiDKQKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348400AbiDKQKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4362D167E7;
        Mon, 11 Apr 2022 09:07:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFdIAp008887;
        Mon, 11 Apr 2022 16:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=8O7VlgVnShUCDAt1+14pi5sT00uA2P8ia3lG+caIJOg=;
 b=uIBNtoKG9B9LvNJU4riSCIfTIbZHkmjT1PiTvo+B+41YzUWs0NPEzt3kqJ7MNhsdvezA
 Ryrc5mfE8T+xCQ0rlYmqAvvs8fn7suNFsWAViOW8nsbyWTPzGSodGLVnUw+RQswu25XJ
 gHpQhy5WZS6YUUuwvUt2cxXeNg6z+hDJgpCOI295813jo7osAT/qx6mBoqWSZUm7jWM2
 JRRjHUo71u9CRZ2JdtxU6cSndJmmyB8MokSnmkFfzeAgNKyqmzL8bq3a/LMx92zJZVLR
 bjsJFbW2ZNAhcJB923p7tN5UP+nAuqHtumppm2RvhzUbfbeFUjRJnC5zkpwxpRYpOlIg Nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2c71k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:06:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG1EpC031293;
        Mon, 11 Apr 2022 16:06:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k27ns6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0l18LhlITNg4e7XDbvCqldBT9Hy1klv8r/7AqSk+Xj7GEHv0zXUpfxmpxY1KHp60sILH3rFqB6srxPXFv2dnycrYToNIcO5pcRczLbFQkGriGWqvNEBQ3vGj6XrEJSyrHOwTKn34SLO3L1GzLGU+MjtEAPR8ub8+mOVndf2XNCNatyMwHWYSoWgF04dPW84skjBgRMvYDp6t/N0f7dmKFxD15XhamM3nn5XJWSXOO9XBAEzftkWB2lzFq2C3ck9BJfppu8RvKkZjoWpgN8FYPjyi5ESuzdhFdSn6WDRt11Q48J7PRIXh2Qd8+vO9j52lSKKAYA79lrQq8jlrmr/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O7VlgVnShUCDAt1+14pi5sT00uA2P8ia3lG+caIJOg=;
 b=mvwL0RgUVhWWWudT7SY1gBe7C4V/jC0Yty7DtYzJRz2LmWUfjp70lW/sTLECnu6ZmYV1hifC3XBxJwelzma8Cf1dK+XKd7tGK15r2IcDACJHTxvxwwjPgHbix+BnB5v/0bD/O17xePtghGj3W7jIuXLZObFVj8TdBIHgoRfqaWDh8bYm2HfXkucLu3tau8ZrE1IY6H/R76+y8tG8BZaD4seW7QikA/gY1XFOHwedzSQm+Nxp09Wkm1UAhz7MHBtuexYNoQsYQ5DOosPx1k0vnhe/ivw3FHB2ywEbnudVprylu/U+RA/27sjvHy0MS2laIPJ5Cia2BfkNq7m4DZ6Xaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O7VlgVnShUCDAt1+14pi5sT00uA2P8ia3lG+caIJOg=;
 b=MsJ5U+W4PKsN4VaruBZa9B+mJn1d8VIEjAdlRe01qzGswURAcayqsbVC9JlaJpiHan8QcALW084hq4expF+qsUVSkBjD8eTjOv39auadf7JDKXIKEtUkH9D3QPVTWqiXm/GAWVVXkkWBf0EGdLqyysu/TV1Pe/IbtqLRmryiyVA=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN7PR10MB2609.namprd10.prod.outlook.com (2603:10b6:406:cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:06:39 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:06:39 +0000
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
Subject: [PATCH v1 01/14] mm: Add new system calls mshare, mshare_unlink
Date:   Mon, 11 Apr 2022 10:05:45 -0600
Message-Id: <a5c3d6bcac88592fb7159186854c6fd8dd4f9c3e.1649370874.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f2da999-38b0-4d03-358d-08da1bd54308
X-MS-TrafficTypeDiagnostic: BN7PR10MB2609:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB260953DD6BF2A62A1574452786EA9@BN7PR10MB2609.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSysgN23Sd9ZXoHEu7E9Doe/CTQvNfpVd4jXdMTH7HjqgZtwupI8M23mFM0yeVjKoUgt9i2hcGKRaPBvxwATQn9rrJs7hjzkKjOnxO6cQ0FcR1MkEOO79tzsVfM1L4idGY42LDhkpIm/jVoTmfZc9qKeBfHB9LfX08xHldzS4UFd20oKZhhKOZkZvJnao9JcvP2ZlgpeDXGc390/FPmTtmIacKUoWzQrtiii1WdCGpGXoFvImNU6mHCoANmJw3OWPTVFJLO2aDCBlajMqKPIcs49bihWVVvl2Cx/Tku/6H7SjpfyBXL/PssiLL75nLjFWwMOlFkQkDKred+/S0DH4KRFG/3449BXJMd0mkMh6XJ5o22IiFYNVJVGxQsEMZHrzLqmFI3l3FLyA1FnpGMVrIXMKh2d6PriVvPzGKEUbuRyTIFG2JgZTgzZnEF0i1ufyuJuaeYmsawqZQVlBOjU5cmyE+G+byQQvrDVjGT56lv2SV39UROEIkNlExR5qcBzWpF9ch6L4rXVkpu8O8kWk5PlxWrMYO63/RErywAgor81uj0HT4Dv6hpipOrW2P6xSbHVDg7UE9YWYdw2DL0msSE980GS9EYX7HLf/Ac3Uco9r8/rxHXzFVfYHTU2A5drhWp7LTNZ1G7btA9b17URwfL6IerFynaBd7OqR/T0FunU+7vpYAdneWzbEqbqOL/Tf/+++H97ABjQVHRz2NshwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(6506007)(6666004)(186003)(316002)(52116002)(66556008)(6512007)(8676002)(2616005)(4326008)(86362001)(5660300002)(44832011)(83380400001)(26005)(66946007)(38100700002)(36756003)(2906002)(7416002)(38350700002)(8936002)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4epE0EKwuX0ahHJAphOoOgUyz0UcU7zi57ldJQLdM7BbuwXoso9TAjmGPzM?=
 =?us-ascii?Q?+E6eot2hfrgY29OgQpqUbqAVa8yOJCmIvAF8y2TXIMEKSMaZX/gfyIjSHgWN?=
 =?us-ascii?Q?GA3OZTEk5k6liGR5GgICG44UUnnb2sSNUB22xFBsVcrH2XCVM6wNcNZaTBKZ?=
 =?us-ascii?Q?NzpgZ4MWdBr5Ry8OFgZisyWndkmECkpGqxqwZlRHmFx5NXj13f2LZPrBPk2a?=
 =?us-ascii?Q?SII0R39TE+OITL2vLJwcxsdwILLuko0Ao3Wo6ugQv2CJUf+JW3l0HkokpYhM?=
 =?us-ascii?Q?JjReBuF9H6ep6Ocjqhj801GbfqBJaaHdDDdeKEaYp07MXNLbvIw0D4En5vK+?=
 =?us-ascii?Q?jZY16QH/xR/NIuVFU2B44ybbZ4BygN8sa94MCRp3SphzPSdQTL8KvgwCrixx?=
 =?us-ascii?Q?fZeAwqHcVMVILn2pKcJmF20IvAcHdW2tKleWmX7XonTlEvDqS//XN22WhKdJ?=
 =?us-ascii?Q?JJvOBqDx6KCPS0B9w/xSTJ3MU6diA6QUKuHw4++T7hwto7X7+9w546oCGb30?=
 =?us-ascii?Q?0CYSRbsc14sg/vgmlsAq4+IZBoFAubGYOymddKR2ZMqiJ58AgkZhhuY5wvLP?=
 =?us-ascii?Q?uhBku/AsUGL9JFTL6/Ouq/sRFcBmRnETHk9hbLg0Mu/EoJXVYDwyjyEtQcjc?=
 =?us-ascii?Q?G1d+a5uyFcmiun2Kcb556MphI1yNTMMiU2ECNGiXHwTrzFVc9mjSA758ZaMa?=
 =?us-ascii?Q?ZCNajE5E6cD4vkvQ0iyzCxi9BrteorGc8NCOp8BTxj8J/FCaeAV+CaGvEFDc?=
 =?us-ascii?Q?dJRzKtFmxlRup+gizJcJ+5EPGAhUDPiFqMslQruRSw1mK2HmJZhgeC38U7BT?=
 =?us-ascii?Q?G9G7Ly0jVcLl+1ZR1GMVTR8lITIqPGPhrp+3sDvNgLvJ0g4naENxoIp/pEAU?=
 =?us-ascii?Q?WtOu/YY9SEqII+M/zm3pMUImH2PJ96FpTYz9/t41zyFAFt4qZTJdOauUGBdq?=
 =?us-ascii?Q?an7gw3nGzYUXrVS9vOmyu7wn3bPdZdZk0mnp/l5nms2PDABbgeSFD7lv5Bon?=
 =?us-ascii?Q?fi+084B/PvEsZD8QBklaYYcPHucP4PbQZamvBYXQYdkwNRBwbZ4vNzMSCGqL?=
 =?us-ascii?Q?O2xM3iijw7EcB7VXE+vK02LVQJYXU4AQAiT1feO+j+2wc53SU7Jbj+Zy7Rkc?=
 =?us-ascii?Q?jMeglhSMLxKuD8o1QV9mc1AVllH8Ye3Z2x7/Qf27HSAz21ZwyrUfhzj52crh?=
 =?us-ascii?Q?eTJs98Qo2mKgZemx23qJ+DoIm7CY7WftAkdNPHgnVAxR0ZBjFkA10XRln3hM?=
 =?us-ascii?Q?U+Rr1dxm1+cE9mDOWitVOQ59h7pEN0rpruWZjMIyhjai8hNJ0po/agbtdOkw?=
 =?us-ascii?Q?QgQ+S9jA2oomAO9PjRyF0/5t9CCRDgzpTQhJ583/XcAc8XA2vLtoq4f9kVml?=
 =?us-ascii?Q?mYd51oU8igktjfjlF7fzd47YNkjBwS8mN5fC28Et1QzKtlQWKpizSFZ0BhsQ?=
 =?us-ascii?Q?0+OlgWZ8XeQMt7BiNiye2EW23XkSZv6VfGjJf7JocuJ7oEjt0vuC2d/q8Lt1?=
 =?us-ascii?Q?7f/sIMHU+mk3XHYh/YlbpaCwxop0URJcwjch2pHX1lwwpfIoH7NOCiCdg9yN?=
 =?us-ascii?Q?GCtoNFWTRumL0VletndnmYlDA/kZNLtUbi1OQ4MQCEf8UiBOLww9GbCuULVA?=
 =?us-ascii?Q?Yn5yuhgg0TiZlcTDuAprt0VQnyPkUMsrIE8X03+/kivok2ZifUZFTDrcUBdg?=
 =?us-ascii?Q?ADDuSdLyVy7sQsnz9tof7H9FxiUIALKf4YFCrXlT9mBEr3F3Brt5NcQVPwZm?=
 =?us-ascii?Q?KevO26SNyg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2da999-38b0-4d03-358d-08da1bd54308
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:06:39.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWVowhsvCgl6ME2e96iKe6Nq1wv2XtWY3WvjxbwvRhBf3dc75glJ6mTQHZ+qMCpew45/dG9yhnr0/lMdl+pk3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2609
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=921 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: qSGgYe_4RKjfqPtNaaJAXs4NY_iTb92f
X-Proofpoint-GUID: qSGgYe_4RKjfqPtNaaJAXs4NY_iTb92f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add two new system calls to support PTE sharing across processes through
explicit declarations of shared address space.There is almost no
implementation in this patch and it only wires up the system calls for
x86_64 only. mshare() returns a file descriptor which does not support
any operations yet.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  2 +
 include/uapi/asm-generic/unistd.h      |  7 ++-
 mm/Makefile                            |  2 +-
 mm/mshare.c                            | 60 ++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 mm/mshare.c

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..e6e53b85fea6 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,8 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	mshare			sys_mshare
+452	common	mshare_unlink		sys_mshare_unlink
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1c48b0ae3ba3..d546086d0661 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,13 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_mshare 451
+__SYSCALL(__NR_mshare, sys_mshare)
+#define __NR_mshare_unlink 452
+__SYSCALL(__NR_mshare_unlink, sys_mshare_unlink)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 453
 
 /*
  * 32 bit systems traditionally used different
diff --git a/mm/Makefile b/mm/Makefile
index 70d4309c9ce3..70a470b5ebe3 100644
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
index 000000000000..436195c0e74e
--- /dev/null
+++ b/mm/mshare.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * mm/mshare.c
+ *
+ * Page table sharing code
+ *
+ *
+ * Copyright (C) 2021 Oracle Corp. All rights reserved.
+ * Authors:	Khalid Aziz <khalid.aziz@oracle.com>
+ *		Matthew Wilcox <willy@infradead.org>
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/fs.h>
+#include <linux/syscalls.h>
+
+static const struct file_operations mshare_fops = {
+};
+
+/*
+ * mshare syscall. Returns a file descriptor
+ */
+SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
+		unsigned long, len, int, oflag, mode_t, mode)
+{
+	int fd;
+
+	/*
+	 * Address range being shared must be aligned to pgdir
+	 * boundary and its size must be a multiple of pgdir size
+	 */
+	if ((addr | len) & (PGDIR_SIZE - 1))
+		return -EINVAL;
+
+	/*
+	 * Allocate a file descriptor to return
+	 *
+	 * TODO: This code ignores the object name completely. Add
+	 * support for that
+	 */
+	fd = anon_inode_getfd("mshare", &mshare_fops, NULL, O_RDWR);
+
+	return fd;
+}
+
+/*
+ * mshare_unlink syscall. Close and remove the named mshare'd object
+ */
+SYSCALL_DEFINE1(mshare_unlink, const char *, name)
+{
+	int fd;
+
+	/*
+	 * Delete the named object
+	 *
+	 * TODO: Mark mshare'd range for deletion
+	 *
+	 */
+	return 0;
+}
-- 
2.32.0

