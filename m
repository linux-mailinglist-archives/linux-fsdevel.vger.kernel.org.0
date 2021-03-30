Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1D834F38E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhC3Van (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:30:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52884 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbhC3V3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:29:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPewA145444;
        Tue, 30 Mar 2021 21:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=KQY8NusArg565ekWV72k5w1pkevrHjUNDXmRkiTni1c=;
 b=hBPe2WVY7LyopRfu6LZoQhKJiacygeyvwi1A5q3hZhkxO9NQTk7QyLZuctOycSoJzanE
 HtfWJiGxx/J3de2svH7/AwDpoQT2ZNai8l9e2sdLboo81VScJEoxmRir+3rvFp0o+a27
 Ah2lr+a8q3eGyI0aaeubwm6x84zTfXZb5T3oOykXj12OvqL2uf1JJ/vrhF3g15ex1/iD
 mofJpbfiWTnzD46vOY2BEemGYAnWGcsC/LP+fjpGMUicMOMoVlStiR+58j3qkPWjF7UI
 he8tlPI3/msZDQonsGTrr9Ii1151SLTy2nmOkeLZtjMNUnGvMC+yT97Zb11v/3FKx4j7 mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37mad9r8jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOnJM184071;
        Tue, 30 Mar 2021 21:27:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 37mac7u5jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYEf/aFmg6fBJCpz/vT0BVQK5hwbO+J2WffPsmWwTmNSwIejJ/E7dYGL8srjVkds6FJ4eB6LIomNc9EpMLKwiAn9aK19HenF+Yvx7hvnfsWujxAByZ0nYkBXRvS9M92RTKAxt8t3QPs3chZ7pIaBatj3O9vvvrpOzMwH7ls9ICnryB6JXOebJDZHcpVfBr6hje1khAiaWHQQWhb6KS3uAOL0SeVZSjT0nvMqw1fzZx7VItHlbYqjl4fpcvC5TTn98tr1m2WDJZ6xmrwlC0+hdh0u7FilxhfGgTOCo21+bk0L4j6Iw58J7M/cGG2e+9cEk2JuHG9EsrCIUEMlXZVHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQY8NusArg565ekWV72k5w1pkevrHjUNDXmRkiTni1c=;
 b=jTESfLSMspKFERHCfJD8irOv+LDFJmB6ifb2vYWn+89PCabrHHou6kuS7PbiToJRSfr+yEFOP3Lp0ejyiRQm/kDYjj6HkkX7KwpSqd1y5zUqlD2duNrKQtPDNGauCfpEiuP75l8N7pxBdpb0bEdyvvvlJU/lc1WjnYT3lUrViC9nd8e4u9P67nH9YSNOQwx6P4ShbctVxnGez+f3P15PQd/JYSEFzJOZIh4Lb9fopIHFX46nPUelwhpZNq+iGup06KXBCD8fBkm2g2EJQu9XYb+dmmIqWSft+eCnmpv9Z2HSiBvXLvqbBHCRMkX+eafB9kSMt+18yYgkMbnBPcYMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQY8NusArg565ekWV72k5w1pkevrHjUNDXmRkiTni1c=;
 b=Mcu3X6dKHJ+Sd5toLgfgIPNFe1CJGmSafyjofcOAXjn9PTbRovDSDSPxYoDfRM2/gvQKw8Lw9EnjvobN8Rn8aT3yjTwl4lT8OqMf7EKNvnowGUSUIx8+ZV7yJwdbYetZkE7S5mkggdyLXDuzePBtwupKGC/JebZejdu8GqGndls=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by BLAPR10MB5265.namprd10.prod.outlook.com (2603:10b6:208:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:49 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:49 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: [RFC v2 39/43] shmem: optimize adding pages to the LRU in shmem_insert_pages()
Date:   Tue, 30 Mar 2021 14:36:14 -0700
Message-Id: <1617140178-8773-40-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain
X-Originating-IP: [148.87.23.8]
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To MN2PR10MB3533.namprd10.prod.outlook.com
 (2603:10b6:208:118::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54ba4375-49ee-4901-904f-08d8f3c2ab35
X-MS-TrafficTypeDiagnostic: BLAPR10MB5265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB526503A6755D2C111E6A0F38EC7D9@BLAPR10MB5265.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLZ457ebP33KpY29CyXgVRqd5+EwwJ9SEfvlTMzNp7kOdKdglw99bSEkLM0ne0vFzm/z2WesNE44PJ2/1XF+aaKR0/nUsdDGdlTokxjT2sWMiJbiwMrfzTLMkQJwNa3aItLIP/EDVnCFCktyy61dxeXbNYpi6M66mwx81Ar9aMcC7x3qPZsRBUzgMkTwRGubmJGNqSMd9ClM41VN/EIWCwMZGPBJ49OkA4fxEP9MSySrjvIvbBGPNy+3IHiXpa9dhlBOB/UbMNMy8Topsl3yDzdPNxI7E2zzOcKpXhWFnMDuYu3QzcZZVk6RUlO4iTJL1qaPM2V64h4icJ/77lgQ6Uu3OpItmV7gwOaftBv1+Mle+wocUgrmiz6DUZvu6kOdfgEfQ15Qn+Hp/ZBLYpFDFVXZTKONapCQ9zuS6UkMVNieZUaeg1iPeceSzOzqwwmH+uKgNVeiBJjU53qnLcZesDbT7gkOk84BwhgxVQB5cXrGqSjuKzuCisWblvc45ZKhl3mATbWV5x8GITgIC4gmyj69BsySnJw7v8/IlX97+OlhfOVF4yhjr5hugL/Xe2gZsGqQSwDxdh5CFC9pKlekgIN2XYRx685K+wwcaDIlgd0PhIQmNUxDAG/3STtGf5MGjZZQuj7RTWmWcQOeiGC9Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(26005)(956004)(52116002)(186003)(38100700001)(36756003)(4326008)(8676002)(44832011)(2906002)(316002)(66476007)(2616005)(7696005)(478600001)(8936002)(86362001)(6666004)(83380400001)(7416002)(66946007)(5660300002)(16526019)(6486002)(7406005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dBnoJoljv1nhW3uHqnS94kMNn5IaPhkAa1fFnNUkr66vRLcLorN3WaoJKQ9w?=
 =?us-ascii?Q?dbWL2dOaSwOYGOsIO6JRyBGXaDmqZg7N9qEEyjK75FfaD/Pc0taq6xew5VsL?=
 =?us-ascii?Q?cLo/4hXo/tFPMOo1TnZWxW38AjMF563qHDx8WQQo2WXneF8nXrFa58Vt/93l?=
 =?us-ascii?Q?bRFGBhRnnZ0qJrSQhGAlxFFGXMUHi0DGX7X8pNNs23Rh1AXJXQdNiLrNV+1Q?=
 =?us-ascii?Q?5j+Z1zMoXOVyCoV8k/DQ7c0+C1GXmWexspUENBXTbhjKZHfbt21SOvh3yp1b?=
 =?us-ascii?Q?4+EItNXgR7h7+9jgxN4Sry5mpMDCp8Vh6vayiRaB0oAXIbf7VUSbisYq8j4q?=
 =?us-ascii?Q?3FdCY6NHHqvllDyD7dhye6O6Z/riPQV8eBdSFuDtvRv799HT+fimh5YAXS7S?=
 =?us-ascii?Q?BZJQkQWEnLK9zOKvEfREDG6wyaj685x5G4xgVCkxMSdFdarb+9FjQYd81LGd?=
 =?us-ascii?Q?3w8YwvjKptu1j1RBJz9YJ3hXqaGeAEhiDU5xTvIsL5/QRNc7CYaDnTIXBXDu?=
 =?us-ascii?Q?QQek9xvmf6vHljJSl229VbcD0l/YJsciQewXtJQX2/nWYir1I+d+QEmQ74Kg?=
 =?us-ascii?Q?u4w+MVoeONh+13/ahfdYoPC/Rq/y/rmR4Z1j81C3cwWjQE9DdvkLVXqSRgN9?=
 =?us-ascii?Q?o6Ukr0c62DI5DwzIi9KNa1OJ+2o9LkO1w8NPlbbZ4fpJOO+swAq6G2u55mME?=
 =?us-ascii?Q?uwyBhlBhGG5iIwCi9ExbafgApb/pgqce0cfpnC+WgafR13QWeo1N7g69kfxm?=
 =?us-ascii?Q?NKs8wp0G/rPXM9tKY54dfqgOILR0QPzwLhhRcIuI5PA6I9Ftlmajoa3/o9ky?=
 =?us-ascii?Q?XUmqZbXP8mMnYCHuHS6ylizE9+v9ZfhGI7ohXSH7dNFRwv4BjYnQRB9eFvED?=
 =?us-ascii?Q?wQr384wzEFft5fzRtF+i/MTIWwBNVUe/zwx4KX3QjjrtJcLlz0UM2LeGAiqG?=
 =?us-ascii?Q?0G6xarbgy2k4rVBlJsqsBGLZa8B5ZVVqOTJ5SPHf+zGyQLBMJS4/qMYX3oN7?=
 =?us-ascii?Q?XXKBcgYdO4+cbQ67QhhMiX51z4m/YqxKrMB1hM4Bs6S8UO+ty8NfqycSa2RK?=
 =?us-ascii?Q?foKyPW5gbFYJYZteVvFSLkotrZAXDjZrFRbL7c/ZQLs76QGKlbVK69j+RU71?=
 =?us-ascii?Q?3LSAhlDqfpIAcQSL/xr72sVe8CQthLZZaJRmv8LQRipDki4htv05TyXe9KRt?=
 =?us-ascii?Q?N+HcuIGMjef+dARlRZVdlJOi7Azby8CXbzwSFsJI1/RqEBIAqxC4zR8sVal2?=
 =?us-ascii?Q?u0I8q1hag4tb8Xmm8SyhjfCzvsWh8RMhlTAkWVw+B3N38UVKfSh3mTMcyGju?=
 =?us-ascii?Q?pPYcJmADh7YtyTRsl0GhqoGT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ba4375-49ee-4901-904f-08d8f3c2ab35
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:49.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnFa+B0jNgY9U2JD2js4JYdeXPQRWTvAyHPPwrj6BRrnaagNBmN0XZIp3a09TUfzIkLRz3aJ3T2l9D6O0wlNCPckpOOF3iDVb4bGTS+0674=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5265
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: E-2LpQrFvFE-HrWb5ArFHEtRigBhOqSe
X-Proofpoint-GUID: E-2LpQrFvFE-HrWb5ArFHEtRigBhOqSe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reduce LRU lock contention when inserting shmem pages by staging pages
to be added to the same LRU and adding them en masse.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c3fa72061d8a..63299da75166 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -845,6 +845,7 @@ int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	gfp_t gfp = mapping_gfp_mask(mapping);
+	LRU_SPLICE(splice);
 	int i, err;
 	int nr = 0;
 
@@ -908,7 +909,7 @@ int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
 
 	for (i = 0; i < npages; i++) {
 		if (!PageLRU(pages[i]))
-			lru_cache_add(pages[i]);
+			lru_splice_add(pages[i], &splice);
 
 		flush_dcache_page(pages[i]);
 		SetPageUptodate(pages[i]);
@@ -917,6 +918,8 @@ int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
 		unlock_page(pages[i]);
 	}
 
+	add_splice_to_lru_list(&splice);
+
 	return 0;
 
 out_release:
-- 
1.8.3.1

