Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAAD560CD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 00:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiF2W4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 18:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiF2Wz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:55:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDB12E9FB;
        Wed, 29 Jun 2022 15:55:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4TJN028210;
        Wed, 29 Jun 2022 22:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=tzNjiQC2Kh52nvj/IA2iScjKaJFJxuA0Ek6TWDJoEic=;
 b=MnXcqcHeRPmrklSmn4b6Tw1yLeQE3DfesgjobBPP32PylIFZcFhXt27XP55wVh9Dq4bz
 E5c3Uv7qMN+YLD4335sWjT6JfyzLx/hOM27DKMYQBXickrUG0zKxeEMWkX7ohHkPHYyN
 BMVFb6HoaJkc1WxxP9Psa0uCVTgqIPSMPjusA/ZquWxlyycUmSlIuHN5dD1vfGSmyCZu
 dEytKyodMGlIPa7osoOaJphoeLE4fNCVPThEb8hatKFthB11wqoA0nvLlQc6BD+79pJg
 K198oMHZtUQkqc/XAuq0FyFDEI+Al3hGDtY1Dw4Mh6MdJZyFAHc9YZiViGdcCxIlXA2v 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwuan8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMf7FN003521;
        Wed, 29 Jun 2022 22:54:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt98nsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi+Plaey2aej9NovQwIvPYcm7g4RcGBntXQM660NqGy2snbD6aGWt8MmPX/AhDwLNNgyM3VeOFd/MherHdUrTLw9y0NxN0UMzxvRce0CjM31XFNqt43DHLuzijHbQqSCAKlbmOSS6eoHJ3nD70gNEEf/qA4xsoBXt7h7o5UsmIbc2RYxBOMspKNYR26N4tMnlq2YUa8mTqJ2DgIgwxkw0E6uzUQsa22xAWlamP7rbvka8YjRoJJ24yRKND0cBXkLELeazzIufvFTaJsAguZ3eaULQ4CGVwH+HSzqGs/SOhwoears2qwPuu+ulW/ryj1SxFB8bBw0jtbV/TPx79ldaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzNjiQC2Kh52nvj/IA2iScjKaJFJxuA0Ek6TWDJoEic=;
 b=lmSyXeqBgu376wf2/spOaZjaQ3/l2NF4+n5wuKriSFpkENDVjKFSCDzavyOE2opss0vkh9JqOQld75tT7wpuVf2VAoL7s+0uq73pHHgMXga2SZDn/eodBE1b3BMJdF0En4YcpsRUliQR/0yl7flC0b3fIw0N8hK6dzwRcAOMpvni18nyQMQ3Goo2U41jJrv46tMjIPi+4R45n6dkq3R0o3w3ustGbXO/8Fvw/0zHDX/fsaqDexz0gvId/goeZEIeT88H6hML68yemKXNsjAOY+jSbd9BDDVAmKh5gx+jONFX22VsdsiYpdGBLLsur9W2KUFBsFQgJ+HVOOak4zjBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzNjiQC2Kh52nvj/IA2iScjKaJFJxuA0Ek6TWDJoEic=;
 b=aSUFzGe2R4kf4101qX5OL2raEJNt/HsHd4BEDyNVcVD07kmneVXO0M23MzutpHOzw1dYX5Y0/2+CvEfdSVbfX16XzaZlTlu15V7KuCtCX4mtHWPEkRxtYkrsjYGsL0heBkXe3qIeF3GwJY5bmnhswTgDh5bpmtUcT2APHH2xvCI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1834.namprd10.prod.outlook.com (2603:10b6:3:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:54:27 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:54:26 +0000
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
Subject: [PATCH v2 5/9] mm/mshare: Add vm flag for shared PTE
Date:   Wed, 29 Jun 2022 16:53:56 -0600
Message-Id: <e7606a8ea6360c253b32d14a2dbde9f7818b7eaf.1656531090.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: a01ffffb-3980-401c-1e81-08da5a225145
X-MS-TrafficTypeDiagnostic: DM5PR10MB1834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sc3Dkh6y2hKGYCpWl7SmwH6f1L+MMe3G+cUAQeaF4+fprG4oWrApLz0UNkH65d26TWj5u51hX2nnEKAMRKpvPKrRlIYoQXgXqb5MMJvUUdnMNTEeHMJ5wIl4f+IphizrDswswJ83DWYvzgP3MQ+JXGl7VUHDdWIGE9mZw81pZG9Kq7vlhf7PWqSWmef1Q+dsCFsi95dgZelHNR2/WPgmx5TKY1s1Z5+Z7ff+M2JMhPge7dUWd4SVEeA20ueELSFiHBYULPdcftcAwtIRqfhb7Ytq6KCbk4RTCQUKINEnbXDb1zBmf9Un+ukXRUprzW0KV2BPUP0kWlnFAyRxHCc/BvstgZGI5lzluRV6ekdFlLXGqV7NlaKfH9K8rYXCjAyUAV1hi7vc38y5P6UI4N+OSmIlx8OoEK0Sv7kWpRxWLFBzdYTpYUaX0s1Bf04F7dEYrzTS/mn+SDUnsOJiPa7eE4W5xCJfoD84jmIrFgGQRkHZ6xEur0Edg+roIHZ3subUAp9SthRhEmp4RVMYLc3EM/6YUDM5QRV17xb3rbljEnHkfs557RAHvlbSoge+uPZkkBJa07tjuhGtiCEhPnOAnFzBmZEBfBVABV7qubMX8HN+d8oIaHBGxwAnB/9/SxpxS8eH3vP3u2dTUUfYoHr8WPznWRR5qcmR+13Q0QddaMQg+LhtoMNV0IqqkcA50Ks9EYvkavSR5vkWBTeNA4CcsmKn8h0jpEj8FtibpY4de+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(52116002)(41300700001)(186003)(6506007)(8676002)(66556008)(2616005)(6512007)(66476007)(38100700002)(83380400001)(44832011)(7416002)(8936002)(316002)(36756003)(2906002)(86362001)(66946007)(6486002)(5660300002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g2NajX0XLhaneVk90fQiYu9p4fP2AXDVcw85PZEBTuJZPl85zhEpxh+jlLAS?=
 =?us-ascii?Q?etx8aPDPYGUFxQj2w/xGWlMyFgjcSXUDen5prlPeljxyBuO9X/LLNC0pRe3F?=
 =?us-ascii?Q?6ValBuk+W2RAyL6E+5lB4inOGxN+4Ww1ts7Aaeu2BPEfeTNbOp3wVNf+/vD6?=
 =?us-ascii?Q?UTcBchnd/bOloLfoPG5WTJX+fuHWoEmn2KZrsxKYONAybYyb9Ko7pfAblFD2?=
 =?us-ascii?Q?AeRmdkdDLggahVJyJ9Rkq5gF2plX7N0x7xVNxTecu5meIeiYzoIdL8GQcJ7v?=
 =?us-ascii?Q?3KbWgNmrNhgrRseLDAXY9pRTSB6Z2s7UgaKaha5ICsYAs66zvEN3JVLSiqJO?=
 =?us-ascii?Q?qW+QN847tMLbeGLkG0VHjaoKtHCEKanNkbL/RUQQ3AibU7s1NNwkGBoP/Ru2?=
 =?us-ascii?Q?jDmA3GMU7Zal+VdBCc66MJB/5KvEntDBTOvde8ejD+hj9F2U7swKFyfEukOt?=
 =?us-ascii?Q?rxdG0UloeIofobKFvkAEoVMjzujbA1Bf6l0fp+l/N5HAvF/j7VfDzq6CWf3b?=
 =?us-ascii?Q?g2hsFIe+OU6BfwWVpoLQK3tdRbzJERpsHcXg+cK1t+CsMLyhzOZHfzA4yeVD?=
 =?us-ascii?Q?f6w8g/szTAFEiMKX/e85b8BrRdEHSXhlheDr1kWbzFUoX9mXXKuWN6lYkK46?=
 =?us-ascii?Q?VMIMs4kMY1WI40rEhKawM1/abhBm/m8fESftSlgqJS9XOKmGG94DRTT8KZUt?=
 =?us-ascii?Q?YDhW0xpZkOKtHmubeAP4gB8NA+lncgJ2S6mE6P9Td1oOqui3LiyLSGJk3+MY?=
 =?us-ascii?Q?TK8p6RfRtOXGnzImNTBfto+UfA9qNMu4yMlKqAa+wL1smoRYAQ3kphzH/Jze?=
 =?us-ascii?Q?qXAlCSt4OJ/iDYNou/qdGxbSf/qydhjz49ecYDEH07PYvbh6draYIETvviXL?=
 =?us-ascii?Q?RE/kx95HgPbetIR6RGWZrmbVtE92yVww66mV8d80e360rDkLc8sZG2hMVVS4?=
 =?us-ascii?Q?LgbnfyCpYgfyIcsE4W5kyHZeqHr8P7aw1KiBVyJW7qyJUnHkIC0S87RwuPAL?=
 =?us-ascii?Q?C8OtQp6ewoJQ6YG8dNpgqVk4LMq+auWGptnV/ulCCXlxynlIj3FTyPcgPkFX?=
 =?us-ascii?Q?L0UWI1bWVrRjn7H/zCZSguNETU1fE2Jv6rsZ0a2tflDmmyvXTL0MuJzkYhLr?=
 =?us-ascii?Q?+LyieoxAM/H+SeUL23478ch9bTJhV2sBrcYNmHjdWqCvLTSjKGMoYXVWaf3C?=
 =?us-ascii?Q?EQdaJWSeGRJgGpJV9srBUU6axjCxn/BRekmBxaT1pUKfC/tMEZYMeRRxnt4N?=
 =?us-ascii?Q?iKyrCsyt7j7t+PJZ/aP5z7RDe9pAy+hCSOm5Pc1Ez2oqPSAL5ktqM+TZWWf4?=
 =?us-ascii?Q?0i+O50uS1499HI0OB8hSlxdIrZnxmugYoJE70XZoKOrWZEbIPWq5z5odHVAG?=
 =?us-ascii?Q?x1de6/ApduRVbR6A/FihWoJ/p3abfPNgBoTUmIY2i018h4krMjjkERWFaS8F?=
 =?us-ascii?Q?/DQzPCfmC7QzX4fniMBE48feqIgkdLfvjndmRBRkHEf7ClGnreQ+grl3iOE/?=
 =?us-ascii?Q?vxlREoaKasnWkJivOGchNBGzt3eiwW1TjWxpihBSmFeYRpCTtCzvOPuL5v72?=
 =?us-ascii?Q?6VaigliwxgJ5Jt6UobZgUB/CBXDh6CAxoVgMoCYVi+l0xGRCHr5F0cidSszv?=
 =?us-ascii?Q?5qHhmKOMOaUrWAhXHUeXsUP139PGkLnf7xtFtvXEWVBp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01ffffb-3980-401c-1e81-08da5a225145
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:54:26.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlfB2JDheNzkkPXSqMARO5T/f0KhYBxWmhF25O6W1MtiIugY+bsp1uGgYHKtjodWFf7uPb/xU6g9gHhmq7prow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=818 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290078
X-Proofpoint-ORIG-GUID: Tvn0GXuCGQxZ835g2ncrOWdWyViEjZQ_
X-Proofpoint-GUID: Tvn0GXuCGQxZ835g2ncrOWdWyViEjZQ_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
a function to determine if a vma shares PTE by checking this flag.
This is to be used to find the shared page table entries on page fault
for vmas sharing PTE.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h             | 8 ++++++++
 include/trace/events/mmflags.h | 3 ++-
 mm/internal.h                  | 5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..0ddc3057f73b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -310,11 +310,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -356,6 +358,12 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MTE_ALLOWED	VM_NONE
 #endif
 
+#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
+#define VM_SHARED_PT	VM_HIGH_ARCH_5
+#else
+#define VM_SHARED_PT	0
+#endif
+
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index e87cb2b80ed3..30e56cbac99b 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -194,7 +194,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
-	{VM_MERGEABLE,			"mergeable"	}		\
+	{VM_MERGEABLE,			"mergeable"	},		\
+	{VM_SHARED_PT,			"sharedpt"	}		\
 
 #define show_vma_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/internal.h b/mm/internal.h
index c0f8fbe0445b..3f2790aea918 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -861,4 +861,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
 
 DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
+static inline bool vma_is_shared(const struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_SHARED_PT;
+}
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.32.0

