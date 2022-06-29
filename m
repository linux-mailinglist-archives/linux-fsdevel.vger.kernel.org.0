Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D58560CCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 00:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiF2W4k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 18:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiF2Wz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:55:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC5741327;
        Wed, 29 Jun 2022 15:55:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4bsA000913;
        Wed, 29 Jun 2022 22:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=i4VgjLtjq9jjVTPpB14Hukd5jRRaep/rnkhxQlDqB0E=;
 b=jkdbdPHIG2tjtJup0SY4Cfw6sr6k0QUwqfDSRi0JOyO6wjqXZMQdBRyVZuMtZvufpAg3
 ZUQ9lmzSgIzK3FtZrGpp02RyOhuuIY3Eu4A70A79/D53xCpsmeHuYKdoCqxwmvZ6NzC7
 bukYNJcr9Gj48UMcH2EI9NDqUBcRjznEoecYcrsN2C3UsLQEuCWCy9EAuPfVg1CpWqEG
 5R2pm+LtmTA6sojAA+trPtqInd5qMTYUItPmoSXRx+1jCJzer43R548PTHsjr6hbPZQ4
 FilbiWkgQTzjeOmr5yrI12KSwG3jG72qfgqOEzbgpro+pxALCrToxxnnC/jeV3CuZRYU fA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0jnkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMflb9004850;
        Wed, 29 Jun 2022 22:54:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt37q8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+PsQ+vf7uVzBMmUED9DjViimY9YR/GSc2/f0YcbyNqNKXrM/6gUD/nO6241AuCN+v6I0kujwBK2qp01/8To7mKyZCW3647PBncj+eKRfm+LJy/T6pZE6pG9DiYwE3bEBGfE20Uc1ELwk3zA//rhSFsd1Fb2k5VGZpkIc7nA3DdCbQONm504jZDf+XV1KThd/DPykcZqglwnG9AiNxG+Wyw0NTZlOxTRzHRRNe27N31qkNDPm1Axw0ynJ6k/v9rg5Y1nL9dPlFzCrzTkRWBc1SbuStTfmX+iUD1zhuibP/NTwCytZEB599zkmII4zLK63ktpqfuSUCUeMGC4/zy7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4VgjLtjq9jjVTPpB14Hukd5jRRaep/rnkhxQlDqB0E=;
 b=XY40N8WkBsBoTtgH0jQPk+Z7RG+YjkQPpVMCZZO36euuJIldATV8nfhqhaBWavmIv23RbMuCE6jymRFc58jo0AYgE8scibWT4TawnU4B4dVztlWhu7/omzGykz2VHEOZiS5thrT++TRziaSLSf2s74JjIX+AGlRFcXEpb20GX7DXAQ9zNZEug3skLzxbcSIDdFRlK9KEq3jRp49XT0+39fgrfiFxKUpYw1QAwNOH7xOJhUnPQ5aEK4U/AeJWWMcawLhUH15dMaFlQ0YUmVgvYC5EeTuGh0G/iIhUsP+5wtn3Uplp+DlHOseQkXvc/WbdlJWQa4mlqYFiv+c7sRnIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4VgjLtjq9jjVTPpB14Hukd5jRRaep/rnkhxQlDqB0E=;
 b=YVZbgp20ZvlfSBKb039Kh0dksfNnPDHYGKuH95G/UL23fsY9gV/xfbYEehkMWeHkJ7AIhEbdUfSYUTZ1R28O/fhTQfjoE2Zm43yoxbtQ3H0XIS8IcczE3nqRE/S+3J6kMpbsrtDmYvxw/LeBdtG7oTf1ihGkKYlnHGu0bIus2SE=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1834.namprd10.prod.outlook.com (2603:10b6:3:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:54:33 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:54:33 +0000
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
Subject: [PATCH v2 8/9] mm/mshare: Add basic page table sharing support
Date:   Wed, 29 Jun 2022 16:53:59 -0600
Message-Id: <7b768f38ad8a8be3aa35ac1e6316e556b121e866.1656531090.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: f0ab85f9-6383-4c8e-5878-08da5a22551b
X-MS-TrafficTypeDiagnostic: DM5PR10MB1834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYsRLBHZv8qovgyO5Q+/7l9NsrXYn6P0W6akpKohUeLOlub8/pAjdSE0/F1x+tCfJBHcHZZDClfexzVfhRemZq70h4XVhBXu5j7eE4d7SajDbKDh8Qar6xe69DbA5H0/bT3pYReVrHOWhKHJIhyn/rISmNdzpctJAI6Og8xYHA7taQgj/N+6GPBqfIzXgd49we4rKwOzydzX4Tc82ZCZvxLKRa1uxbLPGhEKJoFrrYMk1uajuovKptb7HNGEBODV79ADcFyzn4FuttlFP5UUeUojsqDRrmcK/eOytseIIcoGNvC+9kRK3ml8TuhSO3tJAGALmaoE6QgkRWDqVR+QBKcvKbki4TYAwxYiUDLVHpUsuEreUtAZDbiCLbFPiNxo7ES1qyQItl2+Z6JEjGgB3CYyWf67jS29n7fca8AeeiAmaP0bMua1CZ8HYeun3y/YlDC1Prf4a3J0OZcgAXQ7UYNxMYBjrIslQrgkJVqispbSpV5slsVywq9Dn0PORfmgnnybDRaY04I1xnz4yQKtNmE1PzHnRZvbAwMMjT731jk+0/kgBESuQEcjWTYX33/MXt3jHI9giYEps48+6uHG7bQotdniebsaQdOC+fz4wxZZH8qff0K5byeDR7xX/Hxeq771CGMHlK02ykW6J4vKgEpuyj6dr86d+e8jt+450kyDQ406vjofl9adStegXaZ8QpNsyy6hnnRRFqfVzojZN6sYu5aP8O+DxHamaku2LaIZjRxds7azn++mhbA8CxFmUXCMSiJyMVykwKsxGZ8koLtSJwVlIhqdnR81OxbgGWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(52116002)(41300700001)(186003)(6506007)(8676002)(66556008)(2616005)(6512007)(66476007)(38100700002)(83380400001)(44832011)(7416002)(8936002)(316002)(30864003)(36756003)(2906002)(86362001)(66946007)(6486002)(5660300002)(478600001)(4326008)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ug5KJhjdqaIqVtHaMKnCdbCMPqyqDvtZgE6IQshbGVJQJKvScdmOgK61xNbI?=
 =?us-ascii?Q?5ut++V9fiGhvqs9CwaXnh8x02b0nvc2FtaXzVKSQy8Xp22vgttUJsxsalDQ7?=
 =?us-ascii?Q?xm8XD62Mi9KV1etetCMx9KDwG7PhHoerGv6O26d+43/V0Eu6/ZFyAhQmg5t4?=
 =?us-ascii?Q?tN6+K6GvKokhYJxUf9mRCeNdQtflLJA/yN5AJK/wJ0aGnpDTbe38vdXvKiDv?=
 =?us-ascii?Q?uhpfcOlzNJzkEj49wtpC4hGHREXjZyQOowp5NplB/B6lU4SkVdS8If7iRVRN?=
 =?us-ascii?Q?kWbiwrkIv2tF+G6rRwHwgjbcvyQM1jSlrYqBo9N4Cb7Pb+rPsZE1i7MdJli+?=
 =?us-ascii?Q?dWmwifPufOx3/bTNd+smZqRBDsSXDkacyBIOtt2tRnGyFxytnNDjN+A1FBax?=
 =?us-ascii?Q?sAB5R8u4zLcGdBZii+XeDXptRkSWhE+nmbDBjpsD2ZUnzAdENeok/daKz/LF?=
 =?us-ascii?Q?cQTpBUavmqJg/O91swk1PJwk9s/5McQmzbWmd2XjEZdn+qDzokNyyDNuF/lU?=
 =?us-ascii?Q?twyQJZwF6eDtXGgm6CcKjgtZVfc8prXw53eHA3UbYilO42mmXIG/tXAoLnn6?=
 =?us-ascii?Q?fU1FgxZxLMXtxRhUX90wb2MKrt41YQF74gLCncJo/fj4hBSErfY49A8V8cDW?=
 =?us-ascii?Q?UQr+EYLsU17eQhbH2fwayWhTSh9+SIaqc0/5O7DAiE0tBfgMWjIzNsAfMAhj?=
 =?us-ascii?Q?AVgAn/O3esZqZ/8FkZtK/z/k4CwMMrpTIGAr0ReQbyrGXRXlJl4qew6NAAk4?=
 =?us-ascii?Q?fpz0qqLyHFFXJnSvJehIaavdof5GDrq32KxYRMUOPGoz0yfzP9iguCN9Rhhw?=
 =?us-ascii?Q?j3UaxUaVsoCLtlr9kzmLhje6mvhfbqZ20xo4dUGqhVu+O7vNv3JCQySN2bKC?=
 =?us-ascii?Q?UkhXBOcxmSrMqFXhge5RE/jkf9iCYJIFva8qlrdRqNYSEMBALnB7sPx6afAL?=
 =?us-ascii?Q?6+jKn1DlD2rLv6I5hJWcy+5p+EG/Zogsy9KEf0OUtwCLUcleoFN1f8ROvtoO?=
 =?us-ascii?Q?MpBLBEqXSiXyZp20PO80017QFaOvYOmtUmDE4mRCGKveV3FsWJ+demC5Co8/?=
 =?us-ascii?Q?Jsse5nR8ZCrynq11Lbh4d2KaiJ3+GT5/aQeP70Exkj0s6gsXt3GYSHTQN39p?=
 =?us-ascii?Q?tHTbwXgWYmukzfMrSC2kP8b5L9FPRuvL2NrHVy27ReGCIxo3d9Y6wKr//sba?=
 =?us-ascii?Q?b4ZsuImRYphGwn6BSqsyes75GzJEb4jn4KCK+IbSWqIa4dewm1lcgCpaq+51?=
 =?us-ascii?Q?ElD7RFRCLGTZvQ1qy4Nu9Q1f5fNe8NfKDNyrC+qanKVN5/FpRt0lORtGZcQX?=
 =?us-ascii?Q?vQejkMI0qFAlRDApT1vuoWAxI5XDIT3zTtHELGOzc9a1UEORI+2FFzSResDg?=
 =?us-ascii?Q?8wTWKVRK72Vh2ycoM5QJNtOiGesHf6frnwl9gxVKlXFcxnmskWcUcDvPCrLA?=
 =?us-ascii?Q?M+Q/bLbpfDCvKpXCXyGHfI1w+AQx8qJoAFb0etvpmTclmfBpse3DQaGQb9JT?=
 =?us-ascii?Q?Q4QE6GweGynouphlKbyRTQNFDa2mHIErctG/8Cf8e/bfH3YRR8BQmBiqT6qd?=
 =?us-ascii?Q?q2IbCMbesHpAP2WfxjynxLhlD8lkcIaU6Z3O5TVdE9RI8PAw7ENBE9QAiduW?=
 =?us-ascii?Q?zFI0oYuh1VLH3DJPW5poSr3wWlamHVdtZ22gmaHK5KDs9O/THukNRxcwa+7P?=
 =?us-ascii?Q?qCXBag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ab85f9-6383-4c8e-5878-08da5a22551b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:54:33.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWEk1ENf/kmoVatfXz9xf0quCs1bl8xEiGRmvEpNcLemTosCRELptAEzxwxAIemjBMzPOwRN+Wsge1taFCpKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290078
X-Proofpoint-GUID: R_b32MokIkcEaiBl6LgM0eyVQaxbj8W9
X-Proofpoint-ORIG-GUID: R_b32MokIkcEaiBl6LgM0eyVQaxbj8W9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for creating a new set of shared page tables in a new
mm_struct upon mmap of an mshare region. Add page fault handling in
this now mshare'd region. Modify exit_mmap path to make sure page
tables in the mshare'd regions are kept intact when a process using
mshare'd region exits. Clean up mshare mm_struct when the mshare
region is deleted. This support is for the process creating mshare
region only. Subsequent patches will add support for other processes
to be able to map the mshare region.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h |   2 +
 mm/internal.h      |   2 +
 mm/memory.c        | 101 +++++++++++++++++++++++++++++-
 mm/mshare.c        | 149 ++++++++++++++++++++++++++++++++++++---------
 4 files changed, 222 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ddc3057f73b..63887f06b37b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1859,6 +1859,8 @@ void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
+int
+mshare_copy_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
 int follow_pte(struct mm_struct *mm, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp);
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
diff --git a/mm/internal.h b/mm/internal.h
index 3f2790aea918..6ae7063ac10d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -861,6 +861,8 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
 
 DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
+extern vm_fault_t find_shared_vma(struct vm_area_struct **vma,
+					unsigned long *addrp);
 static inline bool vma_is_shared(const struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_SHARED_PT;
diff --git a/mm/memory.c b/mm/memory.c
index 7a089145cad4..2a8d5b8928f5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -416,15 +416,20 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		unlink_anon_vmas(vma);
 		unlink_file_vma(vma);
 
+		/*
+		 * There is no page table to be freed for vmas that
+		 * are mapped in mshare regions
+		 */
 		if (is_vm_hugetlb_page(vma)) {
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
-		} else {
+		} else if (!vma_is_shared(vma)) {
 			/*
 			 * Optimization: gather nearby vmas into one call down
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			       && !is_vm_hugetlb_page(next)) {
+			       && !is_vm_hugetlb_page(next)
+			       && !vma_is_shared(next)) {
 				vma = next;
 				next = vma->vm_next;
 				unlink_anon_vmas(vma);
@@ -1260,6 +1265,54 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	return false;
 }
 
+/*
+ * Copy PTEs for mshare'd pages.
+ * This code is based upon copy_page_range()
+ */
+int
+mshare_copy_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
+{
+	pgd_t *src_pgd, *dst_pgd;
+	unsigned long next;
+	unsigned long addr = src_vma->vm_start;
+	unsigned long end = src_vma->vm_end;
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
+	struct mmu_notifier_range range;
+	int ret = 0;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
+				0, src_vma, src_mm, addr, end);
+	mmu_notifier_invalidate_range_start(&range);
+	/*
+	 * Disabling preemption is not needed for the write side, as
+	 * the read side doesn't spin, but goes to the mmap_lock.
+	 *
+	 * Use the raw variant of the seqcount_t write API to avoid
+	 * lockdep complaining about preemptibility.
+	 */
+	mmap_assert_write_locked(src_mm);
+	raw_write_seqcount_begin(&src_mm->write_protect_seq);
+
+	dst_pgd = pgd_offset(dst_mm, addr);
+	src_pgd = pgd_offset(src_mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(src_pgd))
+			continue;
+		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
+					    addr, next))) {
+			ret = -ENOMEM;
+			break;
+		}
+	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
+
+	raw_write_seqcount_end(&src_mm->write_protect_seq);
+	mmu_notifier_invalidate_range_end(&range);
+
+	return ret;
+}
+
 int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
@@ -1628,6 +1681,13 @@ void unmap_page_range(struct mmu_gather *tlb,
 	pgd_t *pgd;
 	unsigned long next;
 
+	/*
+	 * No need to unmap vmas that share page table through
+	 * mshare region
+	 */
+	if (vma_is_shared(vma))
+		return;
+
 	BUG_ON(addr >= end);
 	tlb_start_vma(tlb, vma);
 	pgd = pgd_offset(vma->vm_mm, addr);
@@ -5113,6 +5173,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
 {
 	vm_fault_t ret;
+	bool shared = false;
+	struct mm_struct *orig_mm;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -5122,6 +5184,16 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	/* do counter updates before entering really critical section. */
 	check_sync_rss_stat(current);
 
+	orig_mm = vma->vm_mm;
+	if (unlikely(vma_is_shared(vma))) {
+		ret = find_shared_vma(&vma, &address);
+		if (ret)
+			return ret;
+		if (!vma)
+			return VM_FAULT_SIGSEGV;
+		shared = true;
+	}
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
@@ -5139,6 +5211,31 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	else
 		ret = __handle_mm_fault(vma, address, flags);
 
+	/*
+	 * Release the read lock on shared VMA's parent mm unless
+	 * __handle_mm_fault released the lock already.
+	 * __handle_mm_fault sets VM_FAULT_RETRY in return value if
+	 * it released mmap lock. If lock was released, that implies
+	 * the lock would have been released on task's original mm if
+	 * this were not a shared PTE vma. To keep lock state consistent,
+	 * make sure to release the lock on task's original mm
+	 */
+	if (shared) {
+		int release_mmlock = 1;
+
+		if (!(ret & VM_FAULT_RETRY)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		} else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
+			(flags & FAULT_FLAG_RETRY_NOWAIT)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		}
+
+		if (release_mmlock)
+			mmap_read_unlock(orig_mm);
+	}
+
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
 		/*
diff --git a/mm/mshare.c b/mm/mshare.c
index 90ce0564a138..2ec0e56ffd69 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -15,7 +15,7 @@
  */
 
 #include <linux/fs.h>
-#include <linux/mount.h>
+#include <linux/mm.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/pseudo_fs.h>
@@ -24,6 +24,7 @@
 #include <uapi/linux/limits.h>
 #include <uapi/linux/mman.h>
 #include <linux/sched/mm.h>
+#include <linux/mmu_context.h>
 
 static struct super_block *msharefs_sb;
 struct mshare_data {
@@ -33,6 +34,43 @@ struct mshare_data {
 	struct mshare_info *minfo;
 };
 
+/* Returns holding the host mm's lock for read.  Caller must release. */
+vm_fault_t
+find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
+{
+	struct vm_area_struct *vma, *guest = *vmap;
+	struct mshare_data *info = guest->vm_private_data;
+	struct mm_struct *host_mm = info->mm;
+	unsigned long host_addr;
+	pgd_t *pgd, *guest_pgd;
+
+	mmap_read_lock(host_mm);
+	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
+	pgd = pgd_offset(host_mm, host_addr);
+	guest_pgd = pgd_offset(guest->vm_mm, *addrp);
+	if (!pgd_same(*guest_pgd, *pgd)) {
+		set_pgd(guest_pgd, *pgd);
+		mmap_read_unlock(host_mm);
+		return VM_FAULT_NOPAGE;
+	}
+
+	*addrp = host_addr;
+	vma = find_vma(host_mm, host_addr);
+
+	/* XXX: expand stack? */
+	if (vma && vma->vm_start > host_addr)
+		vma = NULL;
+
+	*vmap = vma;
+
+	/*
+	 * release host mm lock unless a matching vma is found
+	 */
+	if (!vma)
+		mmap_read_unlock(host_mm);
+	return 0;
+}
+
 static const struct inode_operations msharefs_dir_inode_ops;
 static const struct inode_operations msharefs_file_inode_ops;
 
@@ -64,6 +102,14 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
 	return ret;
 }
 
+static void
+msharefs_delmm(struct mshare_data *info)
+{
+	mmput(info->mm);
+	kfree(info->minfo);
+	kfree(info);
+}
+
 static void
 msharefs_close(struct vm_area_struct *vma)
 {
@@ -73,9 +119,7 @@ msharefs_close(struct vm_area_struct *vma)
 		mmap_read_lock(info->mm);
 		if (info->deleted) {
 			mmap_read_unlock(info->mm);
-			mmput(info->mm);
-			kfree(info->minfo);
-			kfree(info);
+			msharefs_delmm(info);
 		} else {
 			mmap_read_unlock(info->mm);
 		}
@@ -90,31 +134,80 @@ static int
 msharefs_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct mshare_data *info = file->private_data;
-	struct mm_struct *mm = info->mm;
+	struct mm_struct *new_mm = info->mm;
+	int err = 0;
 
-	mmap_write_lock(mm);
+	mmap_write_lock(new_mm);
 	/*
-	 * If this mshare region has been set up once already, bail out
+	 * If this mshare region has not been set up, set up the
+	 * applicable address range for the region and prepare for
+	 * page table sharing
 	 */
-	if (mm->mmap_base != 0)
+	if (new_mm->mmap_base != 0) {
 		return -EINVAL;
+	} else {
+		struct mm_struct *old_mm;
+		struct vm_area_struct *new_vma;
+
+		if ((vma->vm_start | vma->vm_end) & (PGDIR_SIZE - 1))
+			return -EINVAL;
+
+		old_mm = current->mm;
+		mmap_assert_write_locked(old_mm);
+		new_mm->mmap_base = vma->vm_start;
+		new_mm->task_size = vma->vm_end - vma->vm_start;
+		if (!new_mm->task_size)
+			new_mm->task_size--;
+		info->minfo->start = new_mm->mmap_base;
+		info->minfo->size = new_mm->task_size;
+		info->deleted = 0;
+		refcount_inc(&info->refcnt);
+
+		/*
+		 * Mark current VMA as shared and copy over to mshare
+		 * mm_struct
+		 */
+		vma->vm_private_data = info;
+		new_vma = vm_area_dup(vma);
+		if (!new_vma) {
+			vma->vm_private_data = NULL;
+			mmap_write_unlock(new_mm);
+			err = -ENOMEM;
+			goto err_out;
+		}
+		vma->vm_flags |= (VM_SHARED_PT|VM_SHARED);
+		vma->vm_ops = &msharefs_vm_ops;
+
+		/*
+		 * Newly created mshare mapping is anonymous mapping
+		 */
+		new_vma->vm_mm = new_mm;
+		vma_set_anonymous(new_vma);
+		new_vma->vm_file = NULL;
+		new_vma->vm_flags &= ~VM_SHARED;
+
+		/*
+		 * Do not use THP for mshare region
+		 */
+		new_vma->vm_flags |= VM_NOHUGEPAGE;
+		err = insert_vm_struct(new_mm, new_vma);
+		if (err) {
+			mmap_write_unlock(new_mm);
+			err = -ENOMEM;
+			goto err_out;
+		}
 
-	if ((vma->vm_start | vma->vm_end) & (PGDIR_SIZE - 1))
-		return -EINVAL;
+		/*
+		 * Copy over current PTEs
+		 */
+		err = mshare_copy_ptes(new_vma, vma);
+	}
 
-	mm->mmap_base = vma->vm_start;
-	mm->task_size = vma->vm_end - vma->vm_start;
-	if (!mm->task_size)
-		mm->task_size--;
-	mmap_write_unlock(mm);
-	info->minfo->start = mm->mmap_base;
-	info->minfo->size = mm->task_size;
-	info->deleted = 0;
-	refcount_inc(&info->refcnt);
-	vma->vm_flags |= VM_SHARED_PT;
-	vma->vm_private_data = info;
-	vma->vm_ops = &msharefs_vm_ops;
-	return 0;
+	mmap_write_unlock(new_mm);
+	return err;
+
+err_out:
+	return err;
 }
 
 static const struct file_operations msharefs_file_operations = {
@@ -291,14 +384,10 @@ msharefs_unlink(struct inode *dir, struct dentry *dentry)
 	mmap_write_unlock(info->mm);
 
 	/*
-	 * Is this the last reference? If so, delete mshare region and
-	 * remove the file
+	 * Is this the last reference? If so, delete mshare region
 	 */
-	if (!refcount_dec_and_test(&info->refcnt)) {
-		mmput(info->mm);
-		kfree(info->minfo);
-		kfree(info);
-	}
+	if (refcount_dec_and_test(&info->refcnt))
+		msharefs_delmm(info);
 	return 0;
 }
 
-- 
2.32.0

