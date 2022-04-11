Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5396F4FC1DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348428AbiDKQKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348398AbiDKQKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E078E15A1E;
        Mon, 11 Apr 2022 09:07:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFXg43018439;
        Mon, 11 Apr 2022 16:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+WB/0fdIoEOb4SdCFczYVLlh8JUuV6zKRrLsaUXB4S8=;
 b=wGo2KM5EJGvpAa8jE5EhEBf9I0joDI1x+gZeHwclDJPFwOWo/4q8NgG0Y47tu/IA6KM5
 Z73u54MIwYXd336B7lcSb7lS8B9LKoSOqXZ+WipTj+K+0rBHYiSU05YK+iAMdpVi5F4R
 /EkOTOoOWgaEtf7RAK43/h7HiqspNHMOXRn4s8exd71H6znX05aOzkI0AkD6pBeyM/w6
 jbx7hTVbf7OL7P3VUT2/92YehuSR0tILQHGlkV910V15eiNXRymVLfonFdfrvDJzeDiX
 EwswGIdV2ag1/u5QK0qgH+qAiDPCz9DxaTrCJHB33aPHywUuUB7fRlc9Eo5RAvqO/1WP zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1c6ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG1Ebt031259;
        Mon, 11 Apr 2022 16:07:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k27p9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B870uCVh/Cqazdu0qfS2CiM4Go19odVsrixgNTqz9Y0HOimkyeKgbEw45J8FBkDN5KYdbLFgpwuugY6ic8RqNsRpJ68o3yXXCpsceKdXQZmA7g6rjecAgvE3GqPibhMC2VfbwO11hqUpZDncIqN5mTNZ1qFtwIr3gvw6PADd+ArK7HCTxdT4MzgcR49JfIcg4q4A3E04LL3R2xMdvSyq5gRonCYNJKU7yn/Wr8yyl8xejo/WsjE6haxHRyIseiU94ZutAiGYQ3cffRYm2TA5m8saceIQXBn5KfODJEpdBp93eopU75hDTZa3H/DYLBZcVMz9JudPWAhP41xotqMl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WB/0fdIoEOb4SdCFczYVLlh8JUuV6zKRrLsaUXB4S8=;
 b=h4wEyy2oKJoOBOxmKaNYIcxaohW4QMPrWsEDvW6avdPfrPbJvIhBghncORyu1bB8eLpZN/0yGAhZs6lR1UjEioT2t87CS1nxON/opwLTFQxm8Iiq/0f+ShJXAy0euWDht3jhjQeDoVi55ykPDp5ymwqcZeuK4tb+V58Q0CYsUWVXhfoofUXneuqM4t1aS3pZ1upDvoJ7uHya2N8rZ0n6wn014OS88PirPC2CRhJRGna4caTkS2woYLK+wwK0rivI8wxenbNd+inSMTsEG+w6lS8VmSd7O2YMoYsfdimhX314kweHJ2Wpdlq3lhK/bPXq/bvI9rVrKfKSeIfQMTGvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WB/0fdIoEOb4SdCFczYVLlh8JUuV6zKRrLsaUXB4S8=;
 b=xamMzkvlmvNOoMC1vWWgL6TOUs4jQMod8hlu12rSQvoXur8Sh3MXVlxiLYiN9ByH3hYluda6E1FGlh/qtnTx6gJvWAHIv15mCcZlIDEy5hfTZfBabFWjfAYp5jPVfseCOxW2V0y1b0NKaKaNJonoQvfj2qV3zaCRx1bRC1+9sLA=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:07:10 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:07:10 +0000
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
Subject: [PATCH v1 07/14] mm/mshare: Add vm flag for shared PTE
Date:   Mon, 11 Apr 2022 10:05:51 -0600
Message-Id: <4ee9ab4d46669c40ab3c42e97774ffab85db5662.1649370874.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2fb8e20a-a793-4334-ab6b-08da1bd5558b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB456435B00DEEF318DE33C32286EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivtkJ+GDEgxorCrMzT2/Eci4iYL2UJXgW9nutIUiaumttEb6uF6FhGJO9IN7AA9leWutV34ermvKxJ/QewqgtIk5dLjRoW7P4LxwmWbfb5/CnZX86FpMxjAr74pD15vtQyJyGOfEtYrvIqBMeNEX3zZbAipQrqs1Q4AMaa/0d1prXg6UdRFhoqWGFW7DTXRZt6HOHOSfoOZLfcAkVnlpPVCZt6MmEB5pIURWf4G1L7KnM3pbH1PhRBqa6+DhtCA+WWXTUwp3qCIqrCAm6Iz/+RcgSGKyMjgwkuSi11GQlsvlofh6R8GbLLUrgWoKvOJY6P+61qwuSZKdBugtIDr0Kln51DOGL15QLX10b+R/vUmD9JfQc7RmCObGzbNSL1GJWuOyNpFgM8Z2f66a+RlNyudyrp9xZrCxS5Mn1HAFkPt4j5+bJgef1fJYjdtbAFIbsMeZQYEArrdgfld0zgZKQdZEs2uI5NRmSIhZiMc2qETt2mTczlzRkHXUgiODQy2Mz6owfQkunxxc0DW9S4TuOSYCf0rLy30YNxFqM0a0Crf+NiX8wFvk3B7GPr+fF6gPvV4RpXizrBiMx3VVnptr4S79TbS60fG9e3EdPVkL9v8GzV4sgHxlfJuNE/4jnwg2kGKuza9troI6BaaCzrwPOi7sE6VbPxgG71BhFlucbKJ3zis8ekqoTf3JzIAK+fkohrglyZ8Va0brJdTNSQVQ5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(6506007)(44832011)(7416002)(4326008)(8676002)(6666004)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(83380400001)(2906002)(6512007)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?433V5aFAuqc3XUQ8SBovOU8AcOvhShSjXpmHugebIgXXSz2O74UPZAGk4t9b?=
 =?us-ascii?Q?499ov3Lu+rINYdN7oWFgwBYvHgoVkU1BzBlrYe1MmxMitfl80A5Vx1sRlQV6?=
 =?us-ascii?Q?S4w57VvwI0T41zlRnLY2mKIOIOucmKD7e2xh7b+2kg+E9I1AYFewMIdNE/gk?=
 =?us-ascii?Q?plS3Dk6mGMi+DcMw5Dj3WEukHaGf9NNxRBOLPw+QjMUlCngDtEqyRoMz+oTK?=
 =?us-ascii?Q?N+2oeR3bx9jozq2+7ug3eEth5yhKSYyeA4TiU9I5ACyY4SMubVGKEMHs37yT?=
 =?us-ascii?Q?RQtvKRq84tEPn0/qgo61w9Pw31V1Ni7RbqFyhk3p0zTpMpSq4opEXwQiNUqC?=
 =?us-ascii?Q?GhiwbLAVwjwCJlPdOF9Zf/m5HPlyP3i7wlo+0uh6Vn8aRpMIRs4497SrBVeF?=
 =?us-ascii?Q?QGJD66dOTM9yiEXEwcmw455MtMGF4WJnxR93hFbflHdC4/aD9jID937u3up6?=
 =?us-ascii?Q?i5zVm/KeeEY5NblcCCqoInHxwOoy2XqiNADbkfB+QwP465pTFeBNVhVgxVR4?=
 =?us-ascii?Q?V05/jYljMGl0IUGCJAGf76pr72inNkIyc0SvAVo1r91iXKkQhhgDonhSJrAi?=
 =?us-ascii?Q?ZWKp5T1uO2kozeF00Uv+hQ6d6g13bw8C6x7rlHerhzVHMyuUOjlv1DrIA8tx?=
 =?us-ascii?Q?l6MqOWPVHo6V8I40yN4Pa8kgHHXS6bIcMQhbjxhd6u6bZfU2cOdx/1l6TyYh?=
 =?us-ascii?Q?+jnGIUBTkdQQjnzeYLmWBm+BywTuXhkDWz/B/1vn1ouA85XKSWOLztkn632k?=
 =?us-ascii?Q?7Zq8aoIiT/FCQFwPnn8bJCEdCOcBvWyjxxJxgXAWsNSRM0NXMO1xoEIXTECQ?=
 =?us-ascii?Q?JBw/0L9SN6rziscU6nvJc2WL/o4eUVf6MQkA7p++cbISkeCuC6KZyjAJuhtk?=
 =?us-ascii?Q?rymTEBcs/W0/RLLGljhW7a5Z52SRS7mLI3AOb8BZAFT64le69MMWQZINe3nZ?=
 =?us-ascii?Q?/ydSA+Tfx6pCUDVg5CVT1UMkIE8Cojb0dwVblEyPupn1l3GjlzNWCDh+9Ukz?=
 =?us-ascii?Q?f2SPjdsPiWoOGiDmd7+hZi21EJYUI+xmyQwp0+GxkE0dLf2RLwgqXo0oFp+q?=
 =?us-ascii?Q?SmDAcfP4CWzbvuccCkjrDOmRJ2Xs9ImMGGBATeszx/T0tKlRi4GeggI+5btX?=
 =?us-ascii?Q?boHffiRoRI8GkqMch0m953ubRhged/aJoxp5X904zSDblWKInBNQDRELNzK/?=
 =?us-ascii?Q?qmG3h+JVnEJD8Al2mqdvk23C4ALPSy65+7wk5gLRRL8S9YnCzrmjuUJsw6Mq?=
 =?us-ascii?Q?Gn9BlgEl7tU7Snwpqiu9EfAy5r1OfqBZVK+PZGE3t/AXrJjlN/gyowVGv3wQ?=
 =?us-ascii?Q?XkDXw84BQbbfUR78oBREaxWrTlemThvw1bO7wtgBN2TUj+FLXtA2I6ZjIG2P?=
 =?us-ascii?Q?+u8yfv5nP8ent0HJPP3JW3FBKqSnG2p2v0dzufHBeZOQ7cGSjtvyYIeVETFd?=
 =?us-ascii?Q?F7RjWg/vKyt30e6ZiFjrAZ88rvJZP+9gqeaYwlMZn1GT7++OfGqYAZjBdCyM?=
 =?us-ascii?Q?u1u0PIjC1gnTOnNlzmVR2FbR4G70S+45bodsFAC2ZDNm0s7GO84ZfRpZRTni?=
 =?us-ascii?Q?9s1hkH/CsOKpvW991L+antATT1Rl6moh8eu3l2FSAwnXvdToI0g7OHbeRPRf?=
 =?us-ascii?Q?N4YlzuBzRF/VnaxEoVJnEeimCacMNDeBrwavZPwXY+Srp9/HjrIBgStSszmh?=
 =?us-ascii?Q?k/v0Y5mOsCg3Jsl1VxbbZt3/6C0dVQ+kVBuJIT6gA+AFTJwSUfzbLpBPLp3/?=
 =?us-ascii?Q?FGYVwvfAXA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb8e20a-a793-4334-ab6b-08da1bd5558b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:07:10.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKcLqdVMk2rNrYKz2+xEa3Gw90FGMkLcgg6Hpp5T+13uuPBz3JxYaKPyAnF5C2BqPKoEkwJyNt+ZbYdjv8+zRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=643 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110089
X-Proofpoint-GUID: Ubl1L46z2mGQYdE3yRAazbaC8cgZTqvB
X-Proofpoint-ORIG-GUID: Ubl1L46z2mGQYdE3yRAazbaC8cgZTqvB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 5744a3fc4716..821ed7ee7b41 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -308,11 +308,13 @@ extern unsigned int kobjsize(const void *objp);
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
@@ -354,6 +356,12 @@ extern unsigned int kobjsize(const void *objp);
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
index 116ed4d5d0f8..002dbf2711c5 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -184,7 +184,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
-	{VM_MERGEABLE,			"mergeable"	}		\
+	{VM_MERGEABLE,			"mergeable"	},		\
+	{VM_SHARED_PT,			"sharedpt"	}		\
 
 #define show_vma_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/internal.h b/mm/internal.h
index d80300392a19..cf50a471384e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -718,4 +718,9 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
+static inline bool vma_is_shared(const struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_SHARED_PT;
+}
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.32.0

