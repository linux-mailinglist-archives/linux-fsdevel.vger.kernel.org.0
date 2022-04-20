Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96C8507E8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358833AbiDTCIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358821AbiDTCIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:08:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2913FFD2F;
        Tue, 19 Apr 2022 19:05:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JLMjcm013493;
        Wed, 20 Apr 2022 02:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=uvWeK48wP2Py79jR00WKj7o5KWBwj4JlN/oMfz5t8Yk=;
 b=Vqt1tq6Iiji0H+S/iu2Db5q03hVPzPk1oIRQdhysCtIRt7dQ3UiHx8P6X+w/j3UZ6X2Y
 GkEA5Su9hmJNDTE0eKcBuykaYl7RHQNMFPpi21uMZifMTi27vnZ2KevtVhxt6gu4HwGT
 qqivX3hfty6IDIbKJHWJWVTgBLOnR4/tOZeNousK5/omO4fe50B0Xsuu9rLD9Tt7qNIb
 dkOfEItjz8IJKSksa3j1ez4IJzB8JXw0O1SytWZL6JY5F73EzQGtompOjO2nxqgVuVzc
 Bmp1eimnO9o2zkGUUNjHut2lb/lStcWPODgGETkgGFBJlrwULVNN83wSix0zbrWHdfZa Kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndtfngm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K20WES038043;
        Wed, 20 Apr 2022 02:05:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88mv78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0HKN1fBmoC2DWUPhpnznPp9Q62+VSunjAsZsO/tZSyHDWyqgTDjNx8LTi5YkVyQLl/nCja5HcsYL/6YtXFbV145eADgvDYSBtEV+5IZh2lykB9W9qoo+SZL6EjAlfU66hO5bwnvVDVy+ubznKPDsS9tYKefNe/pIzVAaTlIzzypBNVN2u8GJkRwo3SDLRUk0/fovCZsvwWFideU8wofGPjJ/o/f6jOWBYv5noi29Xgv5lrw+eMDq1xxTA3de3vWXY73EOYApPN+xvBBBNhOMziZLqgjB9Nny+P5+TCWgIoFXbcHuEEOJxVCQPa5rwwe3pmBUkApaQAlVMFUZfVMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvWeK48wP2Py79jR00WKj7o5KWBwj4JlN/oMfz5t8Yk=;
 b=fmVZEcY26wG/s9IEE9cIzDkP1J3fsKZ7W3dRRf8wDN2i35EM7d7Iog/zfbo/M/PMjC2JMb1gF6qj3HdtrUwjbbDq2b7cG8AgVHuer3C6yfFq8ffHZpI4AC3lAzHg7rzTKzjMFh6owQUPBupdijxS3IgaMMJ4UGulUsK2cTdlTlceMCIxQujYx3RW4iBZfXnrkERliTvHv6eWdSGVxr6gLLM+XhRywdvKRX7v467NfQPEZ6g9V6y0QE0g3BsfGafc8i5pkiU+OSAFXyedBFZpV7fGnrY66MLqxwB5RpjnT0kKL/ZnrPI5WJoxtGZuNEr3eFsVkJL8tWXtdIV67mZ5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvWeK48wP2Py79jR00WKj7o5KWBwj4JlN/oMfz5t8Yk=;
 b=DKr+pGUyxtyPEZNZTKs8+cN9I8Mp53YVhcVKUhwzrYA7TNUiu/3sLCSszKpRhhUM6VrSLGB4uuOdAWZPSAzskuDrL0Y1wU+nxVvMeUTB/PVd5V6NLsK6lwmo8ryu9qFpGILna7fVarx73vgipbV4JTJJsjNc4K6Mg25+dBYKLfA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 02:05:03 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 02:05:03 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v8 2/7] x86/mce: relocate set{clear}_mce_nospec() functions
Date:   Tue, 19 Apr 2022 20:04:30 -0600
Message-Id: <20220420020435.90326-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220420020435.90326-1-jane.chu@oracle.com>
References: <20220420020435.90326-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0112.namprd12.prod.outlook.com
 (2603:10b6:802:21::47) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c35109b9-24fc-4c12-cede-08da22722ebf
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4557:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45579A556DCD6B8D71E10E47F3F59@SJ0PR10MB4557.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Khabm9zfxzhsrZxP0wWbEZPUv7wX2yK1H+4CI8dEeUs0mTTSl5m2Ipyiur8+OnThwDx3Br/0v9pqCkEtZDTPwe9AjPxyT1KvjI2uae04vrH6e4rY+hv7xiLAX8+Z3pCj3gihrxA4f5m3sq1+walVJztKmM6bc57HPKr1c5zYvQZS6nSVupVegFoOGSxSRg0F7JCAegQG+EnY0utGgt4irnkx5HAFPO6RPqPA3noaAaH15BfBlxsWYh9JfscQZbBnwiX8E8ZWGMocxZZXvC5GOJtWD8Xn/1pob17CyZBd+d7PFs1TNZG68yxNADD/CQwvuonGgFWDUBb5WaCWxQFPgsmogptfwa8WTpGxBLw1N5tVy3wub0LKt5HZpeTH70ZfIabkM/cWIGZj+kNkpEKBnQtynENt0TUs3ysffapxZ7E5n16Xzf3xyh/HzKUoLD2ZHRnqNsoCppEfzOZvKEcTdpDjnIqTS/wyuJJ/YdI/kaTmEbJaOow9JTXKCjywBmPRmOEJvnpgBjWgCx7vR1AP7hptlJT2OMQ7Lo/Quf3S2SEYjm3Hd46+HH+PiUHr0vhuf7yT1WHLbQefxxN2jQvA56nBRyfV18Mrce1VuQyGAC541Bqu+7Rzs3PWci3RVt8T0KxPE655vn81NSjR7znctPMytYbyFM8Xqmo1Zc2Ql96mJn5L/FgfhEEs2VsrXPDI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(5660300002)(83380400001)(86362001)(4326008)(66556008)(316002)(2906002)(508600001)(1076003)(36756003)(66946007)(186003)(44832011)(6486002)(6512007)(8676002)(2616005)(921005)(7416002)(6666004)(52116002)(38100700002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ec2qLoa3nh5oO6dIlwVBIF+Pn+ZVq38kQy9dGMCEzNLpBYq65ahnLNNU2n2k?=
 =?us-ascii?Q?95Lsh0ujFd1B4yt9/CVeK6r9LoWJvURMqaQt7EOWu8ydE1JG5qf0OLALFEd+?=
 =?us-ascii?Q?67nQWfKFXiiuVVRg5lz8nLSNYCtIbfUAxWpw4NNpls5/o6a1LBK6HtwmEAaz?=
 =?us-ascii?Q?ZXDsQp2HwqkVHVROcLv+lmGi+KE4kcnQxxrrHHBjVoGK38kBotjGMyj5o1x9?=
 =?us-ascii?Q?vcS4BMHXEovHnwrIFZuhVm2lUjbOZ57oERHb6CmBKlMzh7ao3AtsGtPltsaC?=
 =?us-ascii?Q?ycJHfEpI1VgVsA20OPNVMGAFd9mYbgsYlUh0G7ysUEgoFRQsWhERJeOsFxs8?=
 =?us-ascii?Q?Wn0K+icdy+4tJwYDCMUKGWMtwHcPfOjVoYzNFZkU9uv9O2ILwnuxxzWoZstx?=
 =?us-ascii?Q?TopbOapbPROQdT57fv12BnX8eMxb7ilupfDqpQbdWS8dkTKUJeHXoPz/g4hw?=
 =?us-ascii?Q?Vs2/MFXkA7Wy5XYH2rY44RsJWW5N+mEy/ly2+/77bcFH5sKTzhmBz/cfE1dM?=
 =?us-ascii?Q?CXVFvOMpd+hnlVL5/jfIe6JJrMgzqGZljlasuTjC02/huD/9PSRzlFZvNtN3?=
 =?us-ascii?Q?QbLfwuzp/VMhmZ4sZ9VuHdVHVnNss+Errx7zkLbFL6batQT5yphvzh79kl9z?=
 =?us-ascii?Q?VmwaJC5eQAwPcBoUznRXuyLogbyqOLw9eo66X/9qJ9sNQ6FqDavOdm+b0adl?=
 =?us-ascii?Q?43JPQYDSq9HqQzYUYM42g+7z5HWfZ9mUYoVxnPUx0rmDjQgWPj0jChDn2Fiq?=
 =?us-ascii?Q?zxCxt1AHeIJ2XjGtVz263rHxZjbrleD8EMHp7k12Dypw9EHL0Zlk3twXHFjl?=
 =?us-ascii?Q?b93AFVVBIWpbHkM25xV6njHKSBl9MIz3mDZxxjiQMPMzyip/R3hoBwlR3hPi?=
 =?us-ascii?Q?/oekJ+HwE86+jWSPHyZhKjiPD7tgbWcVjceuUT80IkNumfufoNRw8keqMObC?=
 =?us-ascii?Q?7t5JF46abmjSa/nfBLy98LFzW073ZcLFwxWLNLdUlxEHt9i0p4oAgoHgJhRw?=
 =?us-ascii?Q?r3L6uO0NaMK75Yjf7hwHTw2y5uMg1b17cTBNM0sifky8mSr+cVqNC3TyEPD9?=
 =?us-ascii?Q?kfPKZ3RQuL6RXO3Ef4BQDPAgEldFAxtJGHk8SLNh3iHkItnpZ1qqG1Xfb6Uo?=
 =?us-ascii?Q?6NRODC/8Q5Rl1xzicBZfWe9Kj802QbrRwyp4YdPbNkCjuMAoKYdiZcbx+4m6?=
 =?us-ascii?Q?n3yiQCIi3KDl2/cy/t/UOvmQSEtUi+WWa1uCsuPmkzMkNHjhf2jc8naFd8Rv?=
 =?us-ascii?Q?1jYINnUQfgQSFx115Y4fNq5+SbSumjw8bQp4RUF46cZ3a3kTY10ymUmfeCoP?=
 =?us-ascii?Q?Kdf5ST6gywMsNdkcoh/PLv3TNZ4Lg5FTY7P1AQbKQM89AbawZSMiqFv6aSDF?=
 =?us-ascii?Q?Qf055kAhS7KmdqMEzHE06OT34PLzlbpfybR3XFeISiLQCgarYdrF5KSme5Vb?=
 =?us-ascii?Q?Po67fC01YWkNvQCjdUBaDpJ7wTjUPy7MVfhiKjktf2EA5lUL8wchY+tFlvxC?=
 =?us-ascii?Q?DRuKIGVZSaROmSRRfKvQOXpaEET+KXqtJeXuKZQ75AjB7SenL5R5cIdz16cx?=
 =?us-ascii?Q?NEsWEe/oeWyzgE/dr68Z2Q2l9q3/W+qR09DcHjVRonTVo6jaO+ibeE5JRlYf?=
 =?us-ascii?Q?ztt5T2Z3JPMfV7EiTdr96EZntjlAz1h3GjMD6lMUkDizy+KtW1tIuD1Uvjyd?=
 =?us-ascii?Q?R3SYzLrYk4uf+GGx1Gp4jdZQtDrIUBsqCDs9OyB0W5qbg4mqU5Hfg3AIBjgy?=
 =?us-ascii?Q?yATZmGJG31hv/KAYUXzNsh1s4g82I8c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35109b9-24fc-4c12-cede-08da22722ebf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 02:05:03.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nmmu2CdaOp6F16dqXwSgs1SUwn/klqH7Gi93Igy7ulw3O3L6ZTBq2Y6WqHhk4x8x6a0dVhSftU7PYFPKDi5ySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200008
X-Proofpoint-ORIG-GUID: SqkTtmP0CkU-oOj4EJHVR0SwW3M3uKGv
X-Proofpoint-GUID: SqkTtmP0CkU-oOj4EJHVR0SwW3M3uKGv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Relocate the twin mce functions to arch/x86/mm/pat/set_memory.c
file where they belong.

While at it, fixup a function name in a comment.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/include/asm/set_memory.h | 52 -------------------------------
 arch/x86/mm/pat/set_memory.c      | 49 ++++++++++++++++++++++++++++-
 include/linux/set_memory.h        |  8 ++---
 3 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 78ca53512486..b45c4d27fd46 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -86,56 +86,4 @@ bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
 
-#ifdef CONFIG_X86_64
-/*
- * Prevent speculative access to the page by either unmapping
- * it (if we do not require access to any part of the page) or
- * marking it uncacheable (if we want to try to retrieve data
- * from non-poisoned lines in the page).
- */
-static inline int set_mce_nospec(unsigned long pfn, bool unmap)
-{
-	unsigned long decoy_addr;
-	int rc;
-
-	/* SGX pages are not in the 1:1 map */
-	if (arch_is_platform_page(pfn << PAGE_SHIFT))
-		return 0;
-	/*
-	 * We would like to just call:
-	 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
-	 * but doing that would radically increase the odds of a
-	 * speculative access to the poison page because we'd have
-	 * the virtual address of the kernel 1:1 mapping sitting
-	 * around in registers.
-	 * Instead we get tricky.  We create a non-canonical address
-	 * that looks just like the one we want, but has bit 63 flipped.
-	 * This relies on set_memory_XX() properly sanitizing any __pa()
-	 * results with __PHYSICAL_MASK or PTE_PFN_MASK.
-	 */
-	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
-
-	if (unmap)
-		rc = set_memory_np(decoy_addr, 1);
-	else
-		rc = set_memory_uc(decoy_addr, 1);
-	if (rc)
-		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
-	return rc;
-}
-#define set_mce_nospec set_mce_nospec
-
-/* Restore full speculative operation to the pfn. */
-static inline int clear_mce_nospec(unsigned long pfn)
-{
-	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
-}
-#define clear_mce_nospec clear_mce_nospec
-#else
-/*
- * Few people would run a 32-bit kernel on a machine that supports
- * recoverable errors because they have too much memory to boot 32-bit.
- */
-#endif
-
 #endif /* _ASM_X86_SET_MEMORY_H */
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index abf5ed76e4b7..978cf5bd2ab6 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1816,7 +1816,7 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 }
 
 /*
- * _set_memory_prot is an internal helper for callers that have been passed
+ * __set_memory_prot is an internal helper for callers that have been passed
  * a pgprot_t value from upper layers and a reservation has already been taken.
  * If you want to set the pgprot to a specific page protocol, use the
  * set_memory_xx() functions.
@@ -1925,6 +1925,53 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
 
+/*
+ * Prevent speculative access to the page by either unmapping
+ * it (if we do not require access to any part of the page) or
+ * marking it uncacheable (if we want to try to retrieve data
+ * from non-poisoned lines in the page).
+ */
+int set_mce_nospec(unsigned long pfn, bool unmap)
+{
+	unsigned long decoy_addr;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_64BIT))
+		return 0;
+
+	/* SGX pages are not in the 1:1 map */
+	if (arch_is_platform_page(pfn << PAGE_SHIFT))
+		return 0;
+	/*
+	 * We would like to just call:
+	 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
+	 * but doing that would radically increase the odds of a
+	 * speculative access to the poison page because we'd have
+	 * the virtual address of the kernel 1:1 mapping sitting
+	 * around in registers.
+	 * Instead we get tricky.  We create a non-canonical address
+	 * that looks just like the one we want, but has bit 63 flipped.
+	 * This relies on set_memory_XX() properly sanitizing any __pa()
+	 * results with __PHYSICAL_MASK or PTE_PFN_MASK.
+	 */
+	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
+
+	if (unmap)
+		rc = set_memory_np(decoy_addr, 1);
+	else
+		rc = set_memory_uc(decoy_addr, 1);
+	if (rc)
+		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
+	return rc;
+}
+
+/* Restore full speculative operation to the pfn. */
+int clear_mce_nospec(unsigned long pfn)
+{
+	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
+}
+EXPORT_SYMBOL_GPL(clear_mce_nospec);
+
 int set_memory_x(unsigned long addr, int numpages)
 {
 	if (!(__supported_pte_mask & _PAGE_NX))
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index f36be5166c19..683a6c3f7179 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -42,14 +42,14 @@ static inline bool can_set_direct_map(void)
 #endif
 #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 
-#ifndef set_mce_nospec
+#ifdef CONFIG_X86_64
+int set_mce_nospec(unsigned long pfn, bool unmap);
+int clear_mce_nospec(unsigned long pfn);
+#else
 static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 {
 	return 0;
 }
-#endif
-
-#ifndef clear_mce_nospec
 static inline int clear_mce_nospec(unsigned long pfn)
 {
 	return 0;
-- 
2.18.4

