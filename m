Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42961560CDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 00:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiF2W5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 18:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiF2W4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:56:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF674091E;
        Wed, 29 Jun 2022 15:55:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4MbT001283;
        Wed, 29 Jun 2022 22:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=iDqTod27kjnFQwMReGoWxNIy9TEDVJAT+EvrAmpvCyE=;
 b=SZn4QQu7xMC8Pv8cMtXLy4izWCfCqihlMX3fWg1859i4hnTTXoVjayyydS55DJKCWuz1
 0i9yA8FDCMKiGcoIHbL84b/DEeCiABA4U3Tr7WDcpWGyEGV3Y1YNo8jEI0/z6mYgt9mm
 DXTJtCjfezXp2FlvfLINhsgFxczxrpdHbXOC00ctgIdMUCEf7ybhzkHISkaTjhYQ0ZmK
 uMHH9R32tra5f1S+zMagTOS+xoAFaoQqUxJGI2AO9LYfivx8SHUz50V3m11VIP50d92m
 PFQidgB9LDfmRPIuYfv5tqUGGRpQBojbfF/oyzhH7a95U/9wRS6bu2I4NfgALlVB5jaq /Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwt8a2axb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMeuBf028108;
        Wed, 29 Jun 2022 22:54:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3py5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPvhnDWwIZHOosOovpazPVVTT2ZKZG7PBwGXyH0rGqHbUOy2pLf2lRj1eRuCE7sJxQY4ORM3n5FKxJbwWRXM3E51mtZpKMF/7NYowI1nud/qcbvLevSpo9iEN43sfrj556AHsQOsoXX4Tp1IxgevDUq3vbO9AKtt6Ss8B+Isqg63TMxL2YiJcSs15ZaGRqXASZyiXuskJ5ckhspfwpyrKKQ5mg+p3rFBWEZUpH0usSu4TGPld9z59Uwwgoh5z8+Wl0hZOXfkGLIdTEsLIfZTL62f7wRo/xz38z1c0PT7pVbnAvYS7/9aAXId291bhr+5zObNWbVZDDEdHPQ/Ts5TAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDqTod27kjnFQwMReGoWxNIy9TEDVJAT+EvrAmpvCyE=;
 b=Xuqp/xKEdUUaD0BwK0ggiiyN8qfddyql+WY6w0DJZ9ODRjEAU9ERI+Nx4Pl9rJRydwYDGH24HfJTR8Tk4g+g9Y6+vUr0Gx82othOTNoMgpkZOYRiCMKn33J/j4cNqfKRi/fP6ygJ+BiNvaVXbivI/IUGyTHduwAZZS+V1KaRPB61Rg2NjIqkmuNpKh3eBsSvXJZSzBdWmdBQOGpFG+kV8SE5wJwVBK1saHFL+a5CFuZUfCg7H+fgsXspmveGR5FldAQWULZce2+OKfJV97LO3a+TDUkASoV4fMV3yYGbqSPhYzZBmVtKfT/IRkXSf5z42f6/d8mcswBAaFRU8uCn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDqTod27kjnFQwMReGoWxNIy9TEDVJAT+EvrAmpvCyE=;
 b=CzocYIgCzjGzmejZkWzUd/MFncxEsWApjfRQH3npEqV4Md4NS04unMnxUc3R6ErGqjjOK+FLUZQq+nxjJpwxFGiUnX+6sR3Z1FfJOuj6eL0c8WCIl4P8B5VZEb9yaTn3K020JyXf0OV2tFpTTh3RFjqRhQERp28P2OXW8lb9ZqM=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1834.namprd10.prod.outlook.com (2603:10b6:3:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:54:35 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:54:35 +0000
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
Subject: [PATCH v2 9/9] mm/mshare: Enable mshare region mapping across processes
Date:   Wed, 29 Jun 2022 16:54:00 -0600
Message-Id: <9dc1848f0fcbe3abe3d22584e339f2dfee60cb32.1656531090.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1aa6f337-fd81-4d58-ced2-08da5a22565a
X-MS-TrafficTypeDiagnostic: DM5PR10MB1834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FopgIBV/O9vXMppSwNSx6XJudeR/JDFTvv8LezUyRtcpVQgwbGlL+N+iNYeEyIK+OyMFT4xfQp5pHcRfMeVH3jTHGwZnO/AWxVxeX4mDP4Wz3ssBb4cuABVeD8KnlfpL5bre8AeZClqUSeyx8mSn1hGPw4A8KcTTkzXKtG9f5BtqhAPahzVNBOduOIs+3ewVsIbhOpLa8RxmPKLQwxd3sxwh+r6iQFCxm197aNyZm9GYL5YDNF7OyMzXMkPeRP+h3Ao2+efVYmRS78Z9lm3ZFngGGYP+wkuP0jwCQaXH3rRN/IyB257rNs5VdnTKIYkvwKYneL4JIqmzwRL72M3qbu3WhuMRRuf9S2g6xGF2CvFmpE/dF/Ej4vfG5GES2SCujyAMeiFc0THNrXlhTNxV2H+8y6Xg/0RyTGnpAzkxhaojvpUbYqNq6NNYMa3SUp+7nEziD8zpRcm3utH9CjzJkEhovUTFaGoSlWoiP2IPYZePXMnkKwp2ztWlBdK5lvb1bLe3BsgKpjU1oc0xaLYY12dDcGiNMpCBldjOUKHixsiPkLJOlYOL9LQ7u0WBP8UGOwesqOCgK6bL/myFF9afdWUNObPQSso49BICzbOZnlrLMT93OpwZeMvkmCNm82SIs1JTA44KYawSjsRqEE3h86m7fk8p7+nFBoAjs2ofcx6mlGacohMq0BPcUMBBzO6jewJbkntv+kVgUHzEvEXifKWnnTtGKwWqFl1ay+ip9Z0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(52116002)(41300700001)(186003)(6506007)(8676002)(66556008)(2616005)(6512007)(66476007)(38100700002)(83380400001)(44832011)(7416002)(8936002)(316002)(36756003)(2906002)(86362001)(66946007)(6486002)(5660300002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U+GYyPb7zBAeyJNm0XQbCVA7ZOWT85thOyUC7FGJQ8AftYrG+BQgasTkCmV5?=
 =?us-ascii?Q?V36u6e6OnmAqO3RSi8wQtm78B+Fymtrp5uhw6hZYkZC0/qIJZKdmITxSe/LG?=
 =?us-ascii?Q?sGbUC2ffg9MBR2TYuPBmjm8gDDd7NhyM0rQnmMGMm9O2uky9kcrbWUiB/rfK?=
 =?us-ascii?Q?JL1dCGe4OiMI5QAxaXskENrakYn8WVoZGIbPdszAco2g+pVon+cVT8YqtyFB?=
 =?us-ascii?Q?L6fA2+AaLTbuwUN3R6VgHZfoTRFF9+UNCa2Y+Bc8bJj7k8wyug4z+mWb4Pil?=
 =?us-ascii?Q?Op7QZtQQesDiCip/PGRllKzPPUxHSRed+UYERlnqKvh3OzIgBkNLL3sm9lT+?=
 =?us-ascii?Q?ojrXKHXmjAVGmPfSye9Dns6P3/wtp1ld4p6HHU90NeD7LoQfWbEi1M2C9i3J?=
 =?us-ascii?Q?xdxXqH68q9v+353W+o6rwhnvXiUQwNbOhZvOFFrthGq+lZBmSYzEyRceaph6?=
 =?us-ascii?Q?6JyNkNhA7+dMQ7Xg8B6PSApppqFYtG2c0NKzITJawXSxFs2P1uDyxmyTRLMZ?=
 =?us-ascii?Q?Sck7nYISzIJXWy1bq60p43Her58dkwnRigTakd39dwS53KjrYftxm3t8w5fS?=
 =?us-ascii?Q?mThTMyVDia8Vtnx4M2paVyb9yBCMvAKtZ1pFeEX3BR3/pJugwJhoEQ0Wso2f?=
 =?us-ascii?Q?SF1szyjOjhRnAbatg1OomF1yxy2eVgUBo4ApeM4n4MecVnwrOvuAd1Q3M5j3?=
 =?us-ascii?Q?bjydt+S6vZi48SLOXJJUyKe9Uu5VCYHaICTMPA/aLpB6KblB/AlC81+wCeqh?=
 =?us-ascii?Q?HGZYZW8ZmfwnVmX5d6qUwDhH7hRZjPccYCZuZfpeS+uI3c0Q8zBqNtTQs+KP?=
 =?us-ascii?Q?7vXrZ2Vuaxh8VvmXp/aTe9H/MifFt474qvF2NmkFIvobz7FdUUuDG9eqjnQZ?=
 =?us-ascii?Q?8dDnaGCiKytqCEJ9LHBU1jBN+00ibJFO4+Vx67LTAknSCq8B3MhrxrnlFJ17?=
 =?us-ascii?Q?xg1CFD/1ZwlVGxuO0htJup7CdIwQvduEDa9v3Xael8fwXpVXQExY8Ws9iRBX?=
 =?us-ascii?Q?7PIwgt0xAgWXtXT/tDWv8qBH0iUZVrt4i32QFNzwAWZ7OrmZC9YEl7FbbGpC?=
 =?us-ascii?Q?Wyg5UxsVqlHnnV/0aNQgt4vPPRObMUkplvkl1GKNYeH76NaaR5crAvTlyond?=
 =?us-ascii?Q?IeZjvmD+sII4OzXgYL+02sNdoljC8tC3ewg2M1UCDPuntK+H7iDQWj7+xk+I?=
 =?us-ascii?Q?Vr47RrIeCbz2Cghv4PdBlwru3k4LyqgPrCrWrDeoapnFhvxEJWd0AQC2y9rY?=
 =?us-ascii?Q?Wo6UzgmMUAIQNbWu6slKvTdcCGDqds+RFNCLnqBrVpSquz+hY5FJp6iH9tOw?=
 =?us-ascii?Q?hTKx12NbdVdxlkKQcbUhO+8xA7zyyzEA0V/zbW6kzqUWMaLSH/9J53wYti+v?=
 =?us-ascii?Q?SKeafIKkd2mdnMNgJIgeSfPoU73Sjt830SwbX7X91SUomWEwpR9caIT2WPgD?=
 =?us-ascii?Q?XAsqC0fR0Xd9MICFTVLmJv8mavECTN6ox6VEdPVyXpHYDt29hiUPhQCWksJP?=
 =?us-ascii?Q?AYIkV7Vx4+7gKiqqTKXWWMYzhB+H2fQhBc43kPgTSJUnNObE9KR14nEWz14A?=
 =?us-ascii?Q?hUMyA+qV/OugJICqSetz7/m1Fnn07NkMGkpJdtGKMSmaOsrmFHXRpfmbqwoU?=
 =?us-ascii?Q?H/RQlo5Zx3owoboBit7MLNFNzjIM+kyPnvyNSCaoCL71Q6bwSUg53NDrS8A6?=
 =?us-ascii?Q?FoEQMw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa6f337-fd81-4d58-ced2-08da5a22565a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:54:35.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAGbDXGuSQ2v0KsxXD7hFWYHs71twdZPiR8nVAt7xjTbU5nVkbtUV9n20mAwpNEX4XhEogJr91cFB22zC56nZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=731 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290078
X-Proofpoint-ORIG-GUID: Cwo8LPbtBA-pHs-aNfxIi8uquXbeWUuY
X-Proofpoint-GUID: Cwo8LPbtBA-pHs-aNfxIi8uquXbeWUuY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch enables propcesses that did not create the mshare region
to map the region using mmap().

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index 2ec0e56ffd69..455b10ca0cdf 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -144,7 +144,21 @@ msharefs_mmap(struct file *file, struct vm_area_struct *vma)
 	 * page table sharing
 	 */
 	if (new_mm->mmap_base != 0) {
-		return -EINVAL;
+		/*
+		 * Any mappings of mshare region must use exact same
+		 * virtual addresses
+		 */
+		if ((vma->vm_start != new_mm->mmap_base) ||
+			(new_mm->task_size != (vma->vm_end - vma->vm_start)))
+			return -EINVAL;
+
+		vma->vm_private_data = info;
+		/*
+		 * mshare pages are shared pages that also share page table
+		 */
+		vma->vm_flags |= (VM_SHARED_PT|VM_SHARED);
+		vma->vm_ops = &msharefs_vm_ops;
+		refcount_inc(&info->refcnt);
 	} else {
 		struct mm_struct *old_mm;
 		struct vm_area_struct *new_vma;
-- 
2.32.0

