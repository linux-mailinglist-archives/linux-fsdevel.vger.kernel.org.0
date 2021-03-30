Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E1334F363
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhC3V3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:29:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52128 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhC3V2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPew9145444;
        Tue, 30 Mar 2021 21:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=CHORIdLfCPoGUB2QPADa32PvM2G6NHIFWdfQ0TveQQU=;
 b=lSzAch0n0ovKymIV7ic0Vd6nZDPP1vU+Ez6xEGdDGaZDO9dpgkxerbbuXQgjGXqF/Fmi
 BS3bpVpZssTDiwuJ7F983Zas68PckA/khAAKFF5uKtm2u8oWe4OXp72U1zZL7WEwD3cS
 J3NKKbWDQexYRRblKmhGlZhdTc4EOH5lIo2+eIWwN+awf3lz4WY39la5wwDdSG4FZIB5
 c/UWK/z1aoo3FcZOMmGXUlHdcRNc9WBFJ85pAvKbb4LamdYltQN1dKmT2B/bf6Rx99RK
 nt6gBX0uzvh2Idv1N0/G0k5m6vQMkowz6fXmE/rXLjVp7QSBINHx7Gx0PK3WEBvkoPQ7 JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37mad9r8j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULObuU149800;
        Tue, 30 Mar 2021 21:27:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
        by userp3020.oracle.com with ESMTP id 37mac4kg81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPohtHxgUcDHU88dSFhhLqp38HB8+3/ho925GgYBwWXTPCDV3f8T6e7kPJELJNJ5eztlc3gVcfsJhund/7jbpTbeiED8bosJJUDUQaH698UcdvDV1I93KlhJg5NAY4+q6eqdoqA0IGVLZjpTQl6o8gEU/I4t2dyW1J6/D/tlLVW7D+f8T/uUbKWSgD9ybZtS9rMWDtTTYvTYKpqffkbQQME08dDFDttwrefqkcPIz0KUZ92kJ99VQHKqjNjyUwIIrlS/kL85rIHlNxpL139Co5IU36/Xr7/1nNQ453raWQxVCoe8TgUs2Isds2vrRT4srUX4P8T/Y0WYLTS1bxCMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHORIdLfCPoGUB2QPADa32PvM2G6NHIFWdfQ0TveQQU=;
 b=DL9JmLA/AMiBUuCkPYkjU51818/8SbAvlPU3QfLwI5TGnAWLtWWWyiBtN73DD7uhfUj46plgjhN+lW0EK3eRul7vsE4jDh3SW6exTB1mYTD/6KtSZigz+OIeW4PokNxNpdofAu2oMETXlh8aUh+pyslkrRYkioEWFIFLTHvWOMIVThX+rMriao1DtfM+p4AJc/ucLMZYVIrnMpBwQGdq/FuynE0DlIMXM7FjBJLWCIuZxSzMmJw9VA7NmJlE9FlR4FKi/2UyphlgWfyGfvMPNHTZPRqYtlnaSeQu7S0aWFgO4BIUizPPfLFSfveEuRROnIz7ua0kIybT287QbHmbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHORIdLfCPoGUB2QPADa32PvM2G6NHIFWdfQ0TveQQU=;
 b=L0OkgYkcoqo5Dy5w7C6osyBLFgJDph3/IpLou1AHaiinzI/7QoYPiLWQoi9q1r1sY/MqFKWXfcRoLRwx2BXTmWGeO9HsnMYg2cFb7tuIu24AN7BuEUBaB1xyHybRd6Ew5zo7CbmqFVd99B+7t+aVbAHWYqAe7wRG9lY1FK5NlCQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3679.namprd10.prod.outlook.com (2603:10b6:208:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:32 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:32 +0000
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
Subject: [RFC v2 35/43] shmem: introduce shmem_insert_pages()
Date:   Tue, 30 Mar 2021 14:36:10 -0700
Message-Id: <1617140178-8773-36-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ab9694c-bc9e-4cba-42ec-08d8f3c2a0e3
X-MS-TrafficTypeDiagnostic: MN2PR10MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3679F03FE8E70B4DCE662D3FEC7D9@MN2PR10MB3679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7UGSXgsaxIpkzunGXORvTr8msLifmhlziAVogyIUAlcIlB+b0+UZuIWWytkcKQQqBs0hdq+olErry6EmnDMFcFREVx0FeIiS6/qXM1WfOHIaEkpU2ERda4hroX8PtCZnHYb1u2JB7LJFS5E2a5hvkecHiNxmg//o7Lm49D9hTejVp7rYxeoQozuK286ljGAHctRWrsiVqjb4fpBLflwT/tzkSuQI6djCs5duuhxGxEAPh/Vy6h5OG1hWFW20KzNNd14ATc36JB4/6IX2XS72lMgzrBrK0tPkQit/8PvBa02jymjrc0yvzl5mzbcj5feCUK8vWoZrixgOmyaCBu1qE9+IoM3Py1NFxya1jmmW1bDuVNkl12GsphiWY0WQ6ec69dWfdp1xXYRSmAL96P2njR/6HjALdAhtOC+scJKehaFJfVCF4j9IS5ddEsO37bg5dtSKTeVkrYRZzlxlESnSKbtaAQ569vQf9LUlw/0Aooza0ZvoZi3090BBP6EMBFL2G+EsCaVEZxMVuPGLuUpB3NVlfT38hX+jW6YZi/DX1LSQc0sJYR7zGvcFjoh93EdB/x0Q0MGJRuVNz39FYCGwjIFkJdX0R6Ohylbu+5bpezoRpyuvjVz5mt8Zura+8IubCFAjPSXgOR8m2hklUIFJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6666004)(4326008)(86362001)(52116002)(186003)(478600001)(36756003)(5660300002)(7416002)(26005)(66946007)(66556008)(7696005)(2616005)(16526019)(8676002)(316002)(2906002)(66476007)(956004)(38100700001)(6486002)(7406005)(8936002)(44832011)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aZ/K7nJa8xSiKyNs1QgNNg17qBVLr5UX9+D6qOxU5z5tyN2Xm3ln6+7KE1gD?=
 =?us-ascii?Q?TlbO01TeNksMcmtx48I1ZfU1gTb0XSO6ycGqBhEVt9uksM3vK71VgT6zEpTn?=
 =?us-ascii?Q?kjFEcxlCMIaEV9W87BVd0meUG+wmREj0gzO2EP+55KKQw5mKu3i4qO2PIqZg?=
 =?us-ascii?Q?Fpnm5dEGlZPkoH6JsZoiiqB5rAD3UHZ64RszMyPm43ZhNJUSXyjVtqASCkwG?=
 =?us-ascii?Q?ZzBeoomJZbSqC8Da/nvpR3eTiF4GfZ3nFw2GrrlsuLz9iDGppzwpqWnQG9UJ?=
 =?us-ascii?Q?0ZAB5Rv5AGMYRJxlQ4+wV6ZokY8GG30JNln8VXJaNZfQtITiOfNiNsVzD6oz?=
 =?us-ascii?Q?3FVg2VOumRTlT3mwOhO6DiUJoYiBVODVUWOh2pmmlVoQV60Ylx/9Gr4x49wK?=
 =?us-ascii?Q?u7QfYOea0JTTQHQn4TxcCeynlJhtje2oehjAoFdiJRsACHGkC/HLfuGYlmPM?=
 =?us-ascii?Q?/yUriOG/oz021Nk/mIpzRq2mLIgig7VO3CbtdfcozYvTo6L7EIeDG/nkIJWT?=
 =?us-ascii?Q?Q3ykuaYvzZaN0+67H2OGYCJpNyCyiFkPRbIe8KZcHcDmQzdCZ3sq/Cd3UBCr?=
 =?us-ascii?Q?674OWcXPgipr6hkofDyys+YAXElQmXWOnzA3zpeXk5uOgtXThWMeitS94uD4?=
 =?us-ascii?Q?W338YjqS4hOTN3XPY1DtyTCirL38SH1eXz5VRVudcvd5HzbIaIRQYfcPg9zm?=
 =?us-ascii?Q?6ZO4EGUVtHvVhqwwG9Owx9rpBfnfHrSxg0SDwfBHYz0kVmE2KvcqNo0YoxCj?=
 =?us-ascii?Q?pbomn638CX5MbNzIdBSNCHYj/KVWR9nciQUKUJGR2xM9PLo/sMt3u6MGB3we?=
 =?us-ascii?Q?AlBUfxxHwwiLWM4pRed008fUkc1g+Eo60+wo9EHf6P7ydhhHTHhKpqWqP5ya?=
 =?us-ascii?Q?5vBqEtExSf5VXoIDjhEOqFIRD12AfdnvIxuNmmvQN+ewtwrvWf1fHO2Qkdrd?=
 =?us-ascii?Q?U7d5zrgAiudgkwz9imCnnBwppY7nEVdkUlMwiOh+o4oQ/fpEa21m4EBQAt0z?=
 =?us-ascii?Q?+fSweXP5MiuFnEo+1Qb5vV/7VckbUpvORohU5a5WeyfGXuPa8kd8MXoKWl/r?=
 =?us-ascii?Q?PfjdFZcOtHUaOJIjm07e1GbfdfeN/IyxgnzDPZfRlW/dHAujtyAGl4TLtNZ9?=
 =?us-ascii?Q?sSQHsVqn6FnZH2/qxmsV++ed6RR29QPmyJsNyb6HgniVcFAEfatroVrKDTYK?=
 =?us-ascii?Q?JzkAsPeN1UXMCsjQZo8+1mljxTr1t5DAwEhyVU2yXfW7xDXlR4DcZVCpvZqS?=
 =?us-ascii?Q?fpbZ7h/NSeEbI0dLI74uGOtL17XkPsRjyQRyZEAPeaFGJ88bLFNu60gDJrP4?=
 =?us-ascii?Q?J5dEB+lJuLM5e/6kKTMxuGfm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab9694c-bc9e-4cba-42ec-08d8f3c2a0e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:32.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IicIbPPRW4J+EmIrw5PGQGBzx/rKTQg0CsKyP0IRP7fho1gi4KorWwcI2iQqtxFiijw5LJs5MOguVHmOThc4+wfqRSiD9mW1bXaaJBcWCoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3679
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: WphkaB2C82bsjcrfB4h-jP-eI1MzZSTG
X-Proofpoint-GUID: WphkaB2C82bsjcrfB4h-jP-eI1MzZSTG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Calling shmem_insert_page() to insert one page at a time does
not scale well when multiple threads are inserting pages into
the same shmem segment.  This is primarily due to the locking needed
when adding to the pagecache and LRU but also due to contention
on the shmem_inode_info lock. To address the shmem_inode_info lock
and prepare for future optimizations, introduce shmem_insert_pages()
which allows a caller to pass an array of pages to be inserted into a
shmem segment.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/shmem_fs.h |  3 +-
 mm/shmem.c               | 93 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 78149d702a62..bc116c4fe145 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -112,7 +112,8 @@ extern int shmem_getpage(struct inode *inode, pgoff_t index,
 
 extern int shmem_insert_page(struct mm_struct *mm, struct inode *inode,
 		pgoff_t index, struct page *page);
-
+extern int shmem_insert_pages(struct mm_struct *mm, struct inode *inode,
+			      pgoff_t index, struct page *pages[], int npages);
 #ifdef CONFIG_PKRAM
 extern int shmem_parse_pkram(const char *str, struct shmem_pkram_info **pkram);
 extern void shmem_show_pkram(struct seq_file *seq, struct shmem_pkram_info *pkram,
diff --git a/mm/shmem.c b/mm/shmem.c
index 44cc158ab34d..c3fa72061d8a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -838,6 +838,99 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	return err;
 }
 
+int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
+		       pgoff_t index, struct page *pages[], int npages)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	gfp_t gfp = mapping_gfp_mask(mapping);
+	int i, err;
+	int nr = 0;
+
+	for (i = 0; i < npages; i++)
+		nr += thp_nr_pages(pages[i]);
+
+	if (index + nr - 1 > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
+		return -EFBIG;
+
+retry:
+	err = 0;
+	if (!shmem_inode_acct_block(inode, nr))
+		err = -ENOSPC;
+	if (err) {
+		int retry = 5;
+
+		/*
+		 * Try to reclaim some space by splitting a huge page
+		 * beyond i_size on the filesystem.
+		 */
+		while (retry--) {
+			int ret;
+
+			ret = shmem_unused_huge_shrink(sbinfo, NULL, 1);
+			if (ret == SHRINK_STOP)
+				break;
+			if (ret)
+				goto retry;
+		}
+		goto failed;
+	}
+
+	for (i = 0; i < npages; i++) {
+		if (!PageLRU(pages[i])) {
+			__SetPageLocked(pages[i]);
+			__SetPageSwapBacked(pages[i]);
+		} else {
+			lock_page(pages[i]);
+		}
+
+		__SetPageReferenced(pages[i]);
+	}
+
+	for (i = 0; i < npages; i++) {
+		bool ischarged = page_memcg(pages[i]) ? true : false;
+
+		err = shmem_add_to_page_cache(pages[i], mapping, index,
+					NULL, gfp & GFP_RECLAIM_MASK,
+					charge_mm, ischarged);
+		if (err)
+			goto out_release;
+
+		index += thp_nr_pages(pages[i]);
+	}
+
+	spin_lock(&info->lock);
+	info->alloced += nr;
+	inode->i_blocks += BLOCKS_PER_PAGE * nr;
+	shmem_recalc_inode(inode);
+	spin_unlock(&info->lock);
+
+	for (i = 0; i < npages; i++) {
+		if (!PageLRU(pages[i]))
+			lru_cache_add(pages[i]);
+
+		flush_dcache_page(pages[i]);
+		SetPageUptodate(pages[i]);
+		set_page_dirty(pages[i]);
+
+		unlock_page(pages[i]);
+	}
+
+	return 0;
+
+out_release:
+	while (--i >= 0)
+		delete_from_page_cache(pages[i]);
+
+	for (i = 0; i < npages; i++)
+		unlock_page(pages[i]);
+
+	shmem_inode_unacct_blocks(inode, nr);
+failed:
+	return err;
+}
+
 /*
  * Remove swap entry from page cache, free the swap and its page cache.
  */
-- 
1.8.3.1

