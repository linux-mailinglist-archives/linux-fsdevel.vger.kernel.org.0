Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB2D34F351
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhC3V21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhC3V1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPGju145350;
        Tue, 30 Mar 2021 21:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=YqvghoD5svYRKsQeQ1oYy1SsBLqv8CMnuVd9yKWpWRs=;
 b=pMr0nHEfZI0+bqUiZeOGBhnFYDRLv+ZCrkgctsYWCThM+fDfwxxaiCD2zMzhyswPHJCU
 vrg5StC5N6mcKH5baQae5P3GTS2h8eoH9qoTxIExjfkW4HjZFJAG8TWCupkndNYjzdr+
 h1CRhJROvFmWQXDA7FIzhOd3NKcWZFfxRxidfD/wJgEfwDBssXf/ZM2Bcyj2mrb1zEHn
 bzm9qZ6b0M6Vxamn+MBiQWi2G8U7aBM8LWJsWA8nFuMVZ+jioXitgZDNUUHwzOo8TVNY
 LobnZye19NwmiAS5TGwf7zZkBeAjxw91gqRomzxuKNUhx1mu1W4v2/PTfQH/LMcqwY5V gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37mad9r8ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOmI5184039;
        Tue, 30 Mar 2021 21:25:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3020.oracle.com with ESMTP id 37mac7u47e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFhufleDNH8PQPoyUSVwjzwx4bS/bRr7OUaIz6XFloo5zhoMnB2quT3VUV8GADoZnkqSD3eGAUbYW8htOjv9fYd48N3XyFF2UIrK8nfFk3d9p4I/uBhbIpBEOvJchNSA4Geb5LLbutFYaSkgyemEA4jZkEt/h1femlxJPVOKaH9BlOR/T7C9o3UELPBwhDKHjmsX9y91h2PQCBv2wLapk4vXl/Ej1vD5eO6vTIh94t6sZ4D0FBslKnokYswJJPPEiF5A7Pd1q5CFy5F6qbLv0eTfBxOQSfOBmnHKlF6slY4nUAkMFAoDd5WuDG3yUqiDXMbL4g79A1PtVzTQihyrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqvghoD5svYRKsQeQ1oYy1SsBLqv8CMnuVd9yKWpWRs=;
 b=co39iqGaS2XuNGvTkFN8Qf7zFQSNwmQlk8l8wkEvwlUuwoji0Bg+lk7Nz5Z7K/PxB3vphpCaHX1i1Eor/UCnaeADfZzshVMl6KO/e6uOL3+MnJaS9oIODmvg5cUx+LsXw2//VDV39v27xeiSZC6UkuOnD1lAMtzVBrdbwy2HxP1o9grHp7DPVNXPZqPMVIuF87chWwuBHZI+diMLvFvz61rDrrknT2FYLPfiM37ioINw46ayuQULdp3rKBdQmVqPto/UvYRoeJr/PBdLNmuJ6eT75CmEC7xZnoN+pskT/9t5Wlw3px49JzxeecQzH1mehEZcJWPX/wLhPNNIblvXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqvghoD5svYRKsQeQ1oYy1SsBLqv8CMnuVd9yKWpWRs=;
 b=Q+acBETG24T18065kDDQZkSHYF/xidUcs/LfYyFxgwM8mVU+drJgswg3S/YLwSzznj/+5sQmgKrMibCqoSJ9OMwNCJ6IYTLfk4eyO5X19wgoPyOb3thtDqGQVCdp4/mA5Jareq+R88rXUvvUv6d8Jyx/FaTCOaWBHpGr/2Gft5s=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:25:47 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:47 +0000
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
Subject: [RFC v2 11/43] PKRAM: prepare for adding preserved ranges to memblock reserved
Date:   Tue, 30 Mar 2021 14:35:46 -0700
Message-Id: <1617140178-8773-12-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fa27c22-6c96-4f6c-54b3-08d8f3c26249
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3613F3DD953AB5660403E7E2EC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cem83xutk/D6Annw7qyahQcZxzM78bunpmZ38SyZ4urHvAZtE7lprNTNJAH1wusVYCGQIvNifg+p0cY6x22YXy1AeS+v05NM4X42EQLtC1DLEsdPu82ue+yBvirExkSK6hksVaMT2iGJGelIH8x1cFXGsOwZCDlNNmr8PhvFxchj4YY2+VY3DS03YudGoENAn0uHcjOe4NHWFLVecoQVTp75fyPAoqtL4LSm/T1+EUjtSKdDkRs+/mM2pQmXVAywLFdnkpZtZaZpWCsTl68cQ32zHU+iMMTMTe6QxWYBvuMek8zp6xSFUKCn3xwi1xfwFnlHU2rHpzeeH44mf9aO24mCuGU6g7/GCI3YBJUanEOOjrVefmNoJQ7M4lD5hONh3ZGbtuIhnQRauuu6Tf7SErjKDNmntNKhV6woHGnZ2dQ3A0mnxrd7LagRFxvqRG7Q7Gzkl6kQMu+3pFhkhFUAGFKcjCVyAHWPr5coX3nOOEQxvEVndOKUPvLaTD5dpayXKKEh3N/51gVR9THdj2O33kelmTGfxlcdTceh3vr09AcFHnPh9QTLgB4ertIlf3u8BQJECWk6JyXQ3HoH2cspVDtKEUHqgk4PyHlFreFcTs5xyUgfohgEmUXUVqIZ271BX91j7uA5BS4tji71+pxhlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(66556008)(316002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mwg0cQ0j0FDEZw1mVtAmOf5kKZxy4BYWpY+DAoeeLBo/4jkr/dvLQthUJJ9C?=
 =?us-ascii?Q?x1FqAT76vmCmmosWkraxEVQEX6yllY2HVUAUfJkLB4pWGm773UgEBymft3Co?=
 =?us-ascii?Q?OI01RYKvKTolUAw2P9VfpqqZOuV92S1PUqBJUsN7VkjdsaZornf6Dd7ZMKfw?=
 =?us-ascii?Q?0PFuMj8933kib6tsu4YlyQWqIQJyDQVNqHIjJ2XNCxPY+SrHko4B2MCvk7vQ?=
 =?us-ascii?Q?aZDziq9m7/tiMw0MiXssG4UDh2IikaZjGRWh/yx3Y1A9MCKGOb8M6rqMRjKB?=
 =?us-ascii?Q?Y/DFKJRfXRotjVt1mG5/VnhjW+TSOGZzv6MytdDhmf6MOcfaodELkejUdeuj?=
 =?us-ascii?Q?LArNSW6VsB6sG5chtT2ZODC5mIr2qGrhnVSvxr2F1iGyocumKMX0vSUG/e8c?=
 =?us-ascii?Q?mHHC4JMxsnHQZ3Z9dsbbEQKimPBm4SrPmVEQvkZc3zyYz6ZkGy5WeEALyw2i?=
 =?us-ascii?Q?KsEL5LeGeEzSJjC9Y6jj8IM+DONPZNl+ISRYP9uXXYlxN2IiJp8uDMmeAI+K?=
 =?us-ascii?Q?A/8spwU1Dzj8cuXUiiWvlNXJw/kTxz7nYnCPLV23J90JJQm2Cv82L/MO2Na9?=
 =?us-ascii?Q?0EIp985WVFMG9xvztJQopHXCiMSEHmOJqLX7t+Zaq0vrLePABoPBGGblYA+4?=
 =?us-ascii?Q?AsDRbZoJs8PwZxDRga9YQoDXXgAvw7/myu8EbPmGubWQm9D7b32BcB8ENJZI?=
 =?us-ascii?Q?HPgzjO92k/PkGKBeeFDgxFe5EJKyrVnp1vaoI3Du3KrWqpmHQW4ATkoE21WG?=
 =?us-ascii?Q?8jOFz3itHDq90bwizOW7t+nP3NJ8TdC0nrT7vL+qISRLHAF0o55yeU/eb9pO?=
 =?us-ascii?Q?0b66M8IXE8tnfB0xsCQW4S7BysB4zd/9vNk6IkQoGYo6zCjLH3jh9WsFjiL8?=
 =?us-ascii?Q?vbi7FTPZL2D1Su0y0UYsDe4z66kMZti6pSHq+TzV7GVBY07rj0kD66hYjYoH?=
 =?us-ascii?Q?wCcH6AJUKgOONUvCBIYCQ/Jwtsy4uXbXP9CcaRHlAlBsiJ0F53aJsSThgRUt?=
 =?us-ascii?Q?Yd9+4ZKTELPoBBDg/OeYcCPVEuYp3qOANdt5tx/noqDy/S7fAKS5w25H0O1I?=
 =?us-ascii?Q?X6CA0Nx6qNOMLLAK8cK6wyFHoJMy72j2/KBnF3rTde8TgfftDYeHASbvIPO0?=
 =?us-ascii?Q?1hzfbr4bzibPfYwoGMK4C+yAdP7EZtpGlVn8v5QgT/eKL/hAJa2s8oL9VHH6?=
 =?us-ascii?Q?AAq59H+EMpLQs+XtICFMD1Uv294J2MBnFtfGmGduEAw1LaoBCtY6pmeF+Ac6?=
 =?us-ascii?Q?Sxs/6ROfcNoa4LfpHhRwH3I7omHjlDrxctmD+p9eaXDCs8Zd8XMe4l3rGW05?=
 =?us-ascii?Q?UBEldLQtNyCeSKpFhKvgfaYO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa27c22-6c96-4f6c-54b3-08d8f3c26249
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:47.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVhVVJ18svfI3t83mVZD/eEZ2H1L3XcV/xkpEOLK7G1bxZ4usQInAEqtHrYCUtftJpGCuMVG7MThC+wumHt9meX4eW4GI9qSgZjBrWk9xMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: zFz7AVL2HY6fF-orVHxIb7fjRV8vBO6M
X-Proofpoint-GUID: zFz7AVL2HY6fF-orVHxIb7fjRV8vBO6M
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Calling memblock_reserve() repeatedly to add preserved ranges is
inefficient and risks clobbering preserved memory if the memblock
reserved regions array must be resized.  Instead, calculate the size
needed to accomodate the preserved ranges, find a suitable range for
a new reserved regions array that does not overlap any preserved range,
and populate it with a new, merged regions array.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 241 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index 4cfa236a4126..b4a14837946a 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -1121,3 +1122,243 @@ static unsigned long pkram_populate_regions_list(void)
 
 	return priv.nr_regions;
 }
+
+struct pkram_region *pkram_first_region(struct pkram_super_block *sb, struct pkram_region_list **rlp, int *idx)
+{
+	WARN_ON(!sb);
+	WARN_ON(!sb->region_list_pfn);
+
+	if (!sb || !sb->region_list_pfn)
+		return NULL;
+
+	*rlp = pfn_to_kaddr(sb->region_list_pfn);
+	*idx = 0;
+
+	return &(*rlp)->regions[0];
+}
+
+struct pkram_region *pkram_next_region(struct pkram_region_list **rlp, int *idx)
+{
+	struct pkram_region_list *rl = *rlp;
+	int i = *idx;
+
+	i++;
+	if (i >= PKRAM_REGIONS_LIST_MAX) {
+		if (!rl->next_pfn) {
+			pr_err("PKRAM: %s: no more pkram_region_list pages\n", __func__);
+			return NULL;
+		}
+		rl = pfn_to_kaddr(rl->next_pfn);
+		*rlp = rl;
+		i = 0;
+	}
+	*idx = i;
+
+	if (rl->regions[i].size == 0)
+		return NULL;
+
+	return &rl->regions[i];
+}
+
+struct pkram_region *pkram_first_region_topdown(struct pkram_super_block *sb, struct pkram_region_list **rlp, int *idx)
+{
+	struct pkram_region_list *rl;
+
+	WARN_ON(!sb);
+	WARN_ON(!sb->region_list_pfn);
+
+	if (!sb || !sb->region_list_pfn)
+		return NULL;
+
+	rl = pfn_to_kaddr(sb->region_list_pfn);
+	if (!rl->prev_pfn) {
+		WARN_ON(1);
+		return NULL;
+	}
+	rl = pfn_to_kaddr(rl->prev_pfn);
+
+	*rlp = rl;
+
+	*idx = (sb->nr_regions - 1) % PKRAM_REGIONS_LIST_MAX;
+
+	return &rl->regions[*idx];
+}
+
+struct pkram_region *pkram_next_region_topdown(struct pkram_region_list **rlp, int *idx)
+{
+	struct pkram_region_list *rl = *rlp;
+	int i = *idx;
+
+	if (i == 0) {
+		if (!rl->prev_pfn)
+			return NULL;
+		rl = pfn_to_kaddr(rl->prev_pfn);
+		*rlp = rl;
+		i = PKRAM_REGIONS_LIST_MAX - 1;
+	} else
+		i--;
+
+	*idx = i;
+
+	return &rl->regions[i];
+}
+
+/*
+ * Use the pkram regions list to find an available block of memory that does
+ * not overlap with preserved pages.
+ */
+phys_addr_t __init find_available_topdown(phys_addr_t size)
+{
+	phys_addr_t hole_start, hole_end, hole_size;
+	struct pkram_region_list *rl;
+	struct pkram_region *r;
+	phys_addr_t addr = 0;
+	int idx;
+
+	hole_end = memblock.current_limit;
+	r = pkram_first_region_topdown(pkram_sb, &rl, &idx);
+
+	while (r) {
+		hole_start = r->base + r->size;
+		hole_size = hole_end - hole_start;
+
+		if (hole_size >= size) {
+			addr = memblock_find_in_range(hole_start, hole_end,
+							size, PAGE_SIZE);
+			if (addr)
+				break;
+		}
+
+		hole_end = r->base;
+		r = pkram_next_region_topdown(&rl, &idx);
+	}
+
+	if (!addr)
+		addr = memblock_find_in_range(0, hole_end, size, PAGE_SIZE);
+
+	return addr;
+}
+
+int __init pkram_create_merged_reserved(struct memblock_type *new)
+{
+	unsigned long cnt_a;
+	unsigned long cnt_b;
+	long i, j, k;
+	struct memblock_region *r;
+	struct memblock_region *rgn;
+	struct pkram_region *pkr;
+	struct pkram_region_list *rl;
+	int idx;
+	unsigned long total_size = 0;
+	unsigned long nr_preserved = 0;
+
+	cnt_a = memblock.reserved.cnt;
+	cnt_b = pkram_sb->nr_regions;
+
+	i = 0;
+	j = 0;
+	k = 0;
+
+	pkr = pkram_first_region(pkram_sb, &rl, &idx);
+	if (!pkr)
+		return -EINVAL;
+	while (i < cnt_a && j < cnt_b && pkr) {
+		r = &memblock.reserved.regions[i];
+		rgn = &new->regions[k];
+
+		if (r->base + r->size <= pkr->base) {
+			*rgn = *r;
+			i++;
+		} else if (pkr->base + pkr->size <= r->base) {
+			rgn->base = pkr->base;
+			rgn->size = pkr->size;
+			memblock_set_region_node(rgn, MAX_NUMNODES);
+
+			nr_preserved +=  (rgn->size >> PAGE_SHIFT);
+			pkr = pkram_next_region(&rl, &idx);
+			j++;
+		} else {
+			pr_err("PKRAM: unexpected overlap:\n");
+			pr_err("PKRAM: reserved: base=%pa,size=%pa,flags=0x%x\n", &r->base, &r->size, (int)r->flags);
+			pr_err("PKRAM: pkram: base=%pa,size=%pa\n", &pkr->base, &pkr->size);
+			return -EBUSY;
+		}
+		total_size += rgn->size;
+		k++;
+	}
+
+	while (i < cnt_a) {
+		r = &memblock.reserved.regions[i];
+		rgn = &new->regions[k];
+
+		*rgn = *r;
+
+		total_size += rgn->size;
+		i++;
+		k++;
+	}
+	while (j < cnt_b && pkr) {
+		rgn = &new->regions[k];
+		rgn->base = pkr->base;
+		rgn->size = pkr->size;
+		memblock_set_region_node(rgn, MAX_NUMNODES);
+
+		nr_preserved += (rgn->size >> PAGE_SHIFT);
+		total_size += rgn->size;
+		pkr = pkram_next_region(&rl, &idx);
+		j++;
+		k++;
+	}
+
+	WARN_ON(cnt_a + cnt_b != k);
+	new->cnt = cnt_a + cnt_b;
+	new->total_size = total_size;
+
+	return 0;
+}
+
+/*
+ * Reserve pages that belong to preserved memory.  This is accomplished by
+ * merging the existing reserved ranges with the preserved ranges into
+ * a new, sufficiently sized memblock reserved array.
+ *
+ * This function should be called at boot time as early as possible to prevent
+ * preserved memory from being recycled.
+ */
+int __init pkram_merge_with_reserved(void)
+{
+	struct memblock_type new;
+	unsigned long new_max;
+	phys_addr_t new_size;
+	phys_addr_t addr;
+	int err;
+
+	/*
+	 * Need space to insert one more range into memblock.reserved
+	 * without memblock_double_array() being called.
+	 */
+	if (memblock.reserved.cnt == memblock.reserved.max) {
+		WARN_ONCE(1, "PKRAM: no space for new memblock list\n");
+		return -ENOMEM;
+	}
+
+	new_max = memblock.reserved.max + pkram_sb->nr_regions;
+	new_size = PAGE_ALIGN(sizeof (struct memblock_region) * new_max);
+
+	addr = find_available_topdown(new_size);
+	if (!addr || memblock_reserve(addr, new_size))
+		return -ENOMEM;
+
+	new.regions = __va(addr);
+	new.max = new_max;
+	err = pkram_create_merged_reserved(&new);
+	if (err)
+		return err;
+
+	memblock.reserved.cnt = new.cnt;
+	memblock.reserved.max = new.max;
+	memblock.reserved.total_size = new.total_size;
+	memblock.reserved.regions = new.regions;
+
+	return 0;
+}
-- 
1.8.3.1

