Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285D53C874F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbhGNP2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 11:28:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:57032 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232367AbhGNP2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:28:08 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EFCahl005438;
        Wed, 14 Jul 2021 08:24:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=BlTF14H8YFjaP+3EW8we+OQtjW6UGNXPZIA9JS7TCPc=;
 b=f+HMhynYUPFLWgtQJjXfmrp9JgDN5KG4jFSFImPX93qw8IKzPLpSX30pu/nI6oqeqFYk
 Zs74JfRYHevDuaYIXOybppeq5ZDBSwW2v8BXnDZvcVC2Lna1Jgxx6ZIsmg4VeapH1Xht
 +4iamOiKBfbc2Qm0mJxyOxX0T7lp5oodlxOS8i5pV3RsErHzV/7Xd+a0HRYU+BmePo2h
 a7Q1ZmgPBcnr4Mr9qgxd8gYAvLz9r5ma96k324cW1aTL+eDa6udLeS9BjCtXBBCXHnKo
 w1JUTZ2xOY6+oKQZS74UzPmMQZ48hySHxCmsybzLLihF+L+/GDG5WrJbFEaa7yZRpPIy MQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0b-002c1b01.pphosted.com with ESMTP id 39sff5j4sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 08:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWm1JJAidbOwGDGmiBgPjQrlySIwgZRc9YVPDjLSLYq6RMNhFOLZ0RB99gn6CvFUZb2sp48ROdSNaw/6M03H5ezNd8vszpvIr5/Y6sLCxJbhNgtBAXUGR6/mTkYHZ/3p0rRePAxbN+Wpz64mNeRTZ4BW5ILj+ThTDfryCpjzvNhlU5f2XLon11aMtn2y+eA1qif5N6rYBiIove36LhVIxPZF+Jvu0xWif4msq7qxMnSk/6Ef8Xy1LVH07mhcxdJNg560RZo2hVDqc6r4Y8Dmj2tnmZOlKxCacdyLQaaONl5Pyd2GGVxstPK6h/XFdL2CJ56QbPLzaS9OQ6lv0zG4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlTF14H8YFjaP+3EW8we+OQtjW6UGNXPZIA9JS7TCPc=;
 b=gqIY9NRLxNI2SYdm2kj1rock7KJpJDLv7KuihLn1NqT8oW1HmBVa6D5td71j50UFnswj48e8E2m5Q8Yqaudsxg+geVA9jkkV1GjU8rOx/ihIFVA1ZDaTIvSzx+gz2Fvwlaa/V/e6oDPPsxVW2P1iXPokLClvDtijeh831bNDdl6QN7ZAKPHG5YDc6Ppi/iHwd35AcAdDmoQpozn9slRPfvrKpdNS1gA+9wo908hbj53yA0Li+MPtAiPLGcgHX3jWTo0Ix5vzXnQmNTA3ZVMYyLJv1FwAKHDxfpLzDBi0nR2q1jTwXss+GwrYYaQ05qyuGi+u6zG7DmMWhN6Inrcqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nutanix.com;
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM5PR02MB2217.namprd02.prod.outlook.com (2603:10b6:3:52::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.27; Wed, 14 Jul 2021 15:24:53 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8%6]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 15:24:53 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     akpm@linux-foundation.org, peterx@redhat.com,
        catalin.marinas@arm.com, peterz@infradead.org,
        chinwen.chang@mediatek.com, linmiaohe@huawei.com, jannh@google.com,
        apopple@nvidia.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com, adobriyan@gmail.com,
        songmuchun@bytedance.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     ivan.teterevkov@nutanix.com, florian.schmidt@nutanix.com,
        carl.waldspurger@nutanix.com,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Subject: [RFC PATCH 1/1] pagemap: report swap location for shared pages
Date:   Wed, 14 Jul 2021 15:24:26 +0000
Message-Id: <20210714152426.216217-2-tiberiu.georgescu@nutanix.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
References: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To DM6PR02MB5578.namprd02.prod.outlook.com
 (2603:10b6:5:79::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tiberiu-georgescu.ubvm.nutanix.com (192.146.154.243) by SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 15:24:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f76a7b3b-0025-4fe6-c9bd-08d946db875d
X-MS-TrafficTypeDiagnostic: DM5PR02MB2217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR02MB221746C0642B9196BA4A8060E6139@DM5PR02MB2217.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZ1OHNcKZ/3lZBIoQpEUY6A2WXSStEdXz7EaFbAVLpKiQqHLFlKSI+qb+AdcavsVCkVh45ZIOZ5ypyOpIAXykt6cQzwJAUuqRE2aR7G9BAcIZkf9vM1ggDd4y8hG7NYqIEM6FWpI71z3e8DOsVXCEeCr5GGFsWe8ma2VGP08ISPb/CU9TjJIhjx9uODFv0GbjSC7pMg021yO7307H4rNEqHBGQim6Bo8xObqj0u5yiQQ4NcIta+gIViiaKbKwRfp9Yq88LSuUm9C3CpgiJY0cbLeY4fEqim4ly82PgtEEfPZFqev/vZwz0ZcCyF84zKxkRyG1FZGESnIPuzXRLePhkTa8x40znJnPEKFaAsKimp1/NEvithw7gG0mww5WyBYQjDcWe3rM7k2zK3h1LppyGmCZZZKzzbpdvmfKs7ncTC3/8kDJ9FOSQh1bpJGv1KCgT9T8GW2RlLSYaW+AoDbZ4zI9H4WC7JvG2QVx67oktDnSYui32swLxPwhX4wcoHdQT7qmD56j4hOPFa7XoPWpsTXq9Cxy6rzUQR4ExwQKq5l1RcM+jPhzTn71KUKxeDJ9LGQIiHoJocoBD0/ChOTqYNd1Ccyry+1eKQFyRqZM2iOii1bc8US36SjEQq2B1ABDvwRIMhd8FBYPEXpqe/94Vm1k+pN8xUpqk0Xmda/pQbns8cujRpvXFIYPEtW/7pSXLgLSqpAb6bIcWXaz4fqEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(39860400002)(366004)(5660300002)(478600001)(921005)(38100700002)(8676002)(52116002)(83380400001)(8936002)(6666004)(36756003)(44832011)(7696005)(4326008)(86362001)(107886003)(956004)(26005)(2616005)(2906002)(1076003)(7416002)(66946007)(66476007)(316002)(186003)(66556008)(6486002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmipN5Plx3FmAXQpEvHurH4N+qCzVWr9Ram8/CJoOrmI/uAaxuZ8PG6Nm+wV?=
 =?us-ascii?Q?TtFY7tFEy4TeidmhnrzhwduHytwpGo/LI8Lmem+fMjvK9x/Sux+wo9eHYKMs?=
 =?us-ascii?Q?OSKRe0RtxxkkViaMGq+kSNk+vDy9rXJngaI1iOKM8eLzI45J5/sgtTIuPwKx?=
 =?us-ascii?Q?NALyZ4NdohlYv2NTVRxKh3/uguyMRXvIWK7duIxPwF7Ml+gBq6LhCRVo7alP?=
 =?us-ascii?Q?qcM+vzLjeHeG2zMOBfcaEqDIOC+IVpkyeUnqnLhWmgSmf/nWwYzu8/LjHjpE?=
 =?us-ascii?Q?5nwW3UNuwJJ25pRwp/amw917w0SFQ7io71qzIm0YWPTdp1pp9TQA02Kdfa4R?=
 =?us-ascii?Q?BSgMAl83PCx2pJ7oMy14kG12X8kmPYmznpx9Xfr14nK6X3VQU3ee7lMK6QM3?=
 =?us-ascii?Q?kOfTmFTe05NK7LVrJ8+yqTsvyZPxv6r+8ZmdV86Kdv12NQrDzWtmPWSu6uYc?=
 =?us-ascii?Q?8NiBTOHtxHP5DSBF/jkX6sh9ln5jzGRcd+ZCIjxippYbjIKgY+FJbLNTc59k?=
 =?us-ascii?Q?OPpucL9g4kwU6d/LxANsedtafOm1uCf8A+/KkngB8aKTh4ERj5uh/g8Xltzc?=
 =?us-ascii?Q?VjDPvOpBbDHFPIF+BuhsVpjExHk/4BONgCp20Z5vKj+O2o9gjtNk0iv+4s2e?=
 =?us-ascii?Q?UB+MbR3Z5LMYTDYn1MtlGZxe5WZ2Dgg0hfyJ9aJ9+YO2QfcFg8XVqvcZKlIr?=
 =?us-ascii?Q?Mu7TUV4976RBTmWR1Q2B1pp4Dq6OOYXv9u5xE5ILRlV01YKJSYYrPJtCT0ds?=
 =?us-ascii?Q?Qkvia88pU9mJOKdmjkx4kEbxMKIf6rYCQjvyL7Dw3l6iaeN42MXdyCietFCy?=
 =?us-ascii?Q?PzL8020vMMr6vE+e4qAMv4VxJUT4moBptwK9zoZJr5fkUrPjJm4ffW7yWN6m?=
 =?us-ascii?Q?4scnJzWQ66r1f3t4rEpYqjdWqpdoH5akYvtIiRNFVitXl46QW1NDK3C7b/15?=
 =?us-ascii?Q?5WRiTgpG2ltDyx+ADsUEK/lf/jmP6Df0bPLctqj6OGZuiLZmxeKK9qzKiJYg?=
 =?us-ascii?Q?Ff93Tin2oWQ00YPevllYC1B6kw9Dta4puHiBC+ch1RYbfRl+Xeh2K7Q3AFyE?=
 =?us-ascii?Q?QJvFLtHiq/VxtVnrSTlDsd9kdw4fuAcVEC31qoi0CC1KsJlZY2bj8Yy1bcsn?=
 =?us-ascii?Q?TCrMYNGkB03sExgZaaGRWEqK7Bxl0N+cB/f2LcFdlhGcSq8A+k2J7DCh1Eo9?=
 =?us-ascii?Q?0AyprAG7guVqvfwgiX9fKh1udDbmbLBerabawM3OST4nt172TYl0Sw1fL7t0?=
 =?us-ascii?Q?wQGzTsCZhZkhN8i7ejRr7LsXRuxK57bDm9G9HU/DZfJwZONW07elpM1p/uMs?=
 =?us-ascii?Q?vjblLiycFJXb0bVvkkyAod5K?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76a7b3b-0025-4fe6-c9bd-08d946db875d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:24:53.6596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/5vN0vHMB+xDfBNagutG1MAMGqtZWH8J5IBW2pqhL4UohzuJHtcU4XgDoMM+s6vGrJ4q6oHP2gYvcG4vJBEqKOB6gU7s5oZ6A57cdVMZ8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2217
X-Proofpoint-ORIG-GUID: IWzL6dPnnL7w0FrUPxMGsOHO4anVNxiv
X-Proofpoint-GUID: IWzL6dPnnL7w0FrUPxMGsOHO4anVNxiv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_08:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
entry is cleared. In many cases, there is no difference between swapped-out
shared pages and newly allocated, non-dirty pages in the pagemap interface.

This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
make use of the XArray associated with the virtual memory area struct
passed as an argument. The XArray contains the location of virtual pages
in the page cache, swap cache or on disk. If they are on either of the
caches, then the original implementation still works. If not, then the
missing information will be retrieved from the XArray.

Co-developed-by: Florian Schmidt <florian.schmidt@nutanix.com>
Signed-off-by: Florian Schmidt <florian.schmidt@nutanix.com>
Co-developed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
Signed-off-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
Co-developed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Signed-off-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Signed-off-by: Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
---
 fs/proc/task_mmu.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index eb97468dfe4c..b17c8aedd32e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1359,12 +1359,25 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
 	return err;
 }
 
+static void *get_xa_entry_at_vma_addr(struct vm_area_struct *vma,
+		unsigned long addr)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t offset = linear_page_index(vma, addr);
+
+	return xa_load(&mapping->i_pages, offset);
+}
+
 static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 {
 	u64 frame = 0, flags = 0;
 	struct page *page = NULL;
 
+	if (vma->vm_flags & VM_SOFTDIRTY)
+		flags |= PM_SOFT_DIRTY;
+
 	if (pte_present(pte)) {
 		if (pm->show_pfn)
 			frame = pte_pfn(pte);
@@ -1374,13 +1387,22 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			flags |= PM_SOFT_DIRTY;
 		if (pte_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
-	} else if (is_swap_pte(pte)) {
+	} else if (is_swap_pte(pte) || shmem_file(vma->vm_file)) {
 		swp_entry_t entry;
-		if (pte_swp_soft_dirty(pte))
-			flags |= PM_SOFT_DIRTY;
-		if (pte_swp_uffd_wp(pte))
-			flags |= PM_UFFD_WP;
-		entry = pte_to_swp_entry(pte);
+		if (is_swap_pte(pte)) {
+			entry = pte_to_swp_entry(pte);
+			if (pte_swp_soft_dirty(pte))
+				flags |= PM_SOFT_DIRTY;
+			if (pte_swp_uffd_wp(pte))
+				flags |= PM_UFFD_WP;
+		} else {
+			void *xa_entry = get_xa_entry_at_vma_addr(vma, addr);
+
+			if (xa_is_value(xa_entry))
+				entry = radix_to_swp_entry(xa_entry);
+			else
+				goto out;
+		}
 		if (pm->show_pfn)
 			frame = swp_type(entry) |
 				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
@@ -1393,9 +1415,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_FILE;
 	if (page && page_mapcount(page) == 1)
 		flags |= PM_MMAP_EXCLUSIVE;
-	if (vma->vm_flags & VM_SOFTDIRTY)
-		flags |= PM_SOFT_DIRTY;
 
+out:
 	return make_pme(frame, flags);
 }
 
-- 
2.32.0

