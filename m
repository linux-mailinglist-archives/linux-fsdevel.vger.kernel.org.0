Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB9F3DBCDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhG3QJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 12:09:41 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:51914 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbhG3QJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:09:41 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UG8GcM032354;
        Fri, 30 Jul 2021 09:09:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=vFCC9D8cujbd6t8U3OjZtMGvNX4+BZjC3uJdDhuk8h8=;
 b=Mwe9IM66fnoCkdytF6KQVFWcLaA6x5dVOA0Jp66xDU0594FrZC98bY5auozKfMLrEsDY
 jj/F8ctlxFHo7wRs8/spb8ysjxaxpm1OW4ZM9aL4emywsKOvwrMO/xnEsziYyBx5z9al
 oImzCzIoTabxmj6sSiNBkjN5wjyjKomQuRZdpj66KP6j6T01/cpyM3fMa9fsYZZIdTVp
 i1eXzj79iR/nt3T7uWd1voK2rp+cwevJJ1zdv93H8uhEBAbY5IyL3f2L159EJa8tExc0
 EV3AHjW8WSk317g99phY7QEiyneonD00ujOLNJg40sYgYKxAdsGLxFnAqBEJyrWX6ajM Ow== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3a4cs98ykc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 09:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoY1nml6vlvaCzgemoDnTf374jXFFjI4iDX3SmIURsXTYjX9VSkUJGeT6Xay9vosUN4OIpnMUvbvaWTkdH3txOboNmyidZKXPOwsgUsvVb4iM9ksCvGjORhCdhcwtjEFItH9+7z4ESFYntdz5hb1JQYdJ83IS1pebG4ASFCkdgJKhAxQ9ZysJOAY0/Lx9qiqTh14uHKS5Su4GTWJqDGSyLvXkzfgpkiAwn/UrIuAzs8GvSM1nOKt0Wwn+M2hatqWVBntzovwVLIK0+JU/6bj4FOHc/J+cLGbybN4FZjBy59Kd6+BNTYI8wG5R49Ji+lrYxq52iaYUEPKDLYNx0VzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFCC9D8cujbd6t8U3OjZtMGvNX4+BZjC3uJdDhuk8h8=;
 b=NkcYE2qCaeUE74MbvxtA7m8Yr9KSfvi7xDe8ahkmxiz5HjBlWS2pqoWJhgM+ryW+msoFNAnrePTYwtdps3VEsk3LlMRclXbFP4iYjpV68G/C6hqqtJpT6tSAIaC4H7rea5DN1tpRER7ZYgedKqOxxKjdK37qJbxatQc2PEsE+iE3c4UB0DOTtadrEcJWdfamWGOWKQOL1YOobEa2e76vwJU2tlS9tbjvDpx8fAXXvIU+YdpzyAw3OcLME/7m8HnaGfRJJ3mqJabfZhQF+ZjL0r3ZfXRp0yDms/9Oo4LWFuP0Vwj3RYzaMaqdhFgw+B2ndG+AtZVrIqiOuRdmZfvVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nutanix.com;
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM8PR02MB8262.namprd02.prod.outlook.com (2603:10b6:8:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Fri, 30 Jul 2021 16:09:13 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8%6]) with mapi id 15.20.4373.022; Fri, 30 Jul 2021
 16:09:13 +0000
From:   Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        peterx@redhat.com, david@redhat.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com, adobriyan@gmail.com,
        songmuchun@bytedance.com, axboe@kernel.dk,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     ivan.teterevkov@nutanix.com, florian.schmidt@nutanix.com,
        carl.waldspurger@nutanix.com, jonathan.davies@nutanix.com,
        Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Subject: [PATCH 1/1] pagemap: report swap location for shared pages
Date:   Fri, 30 Jul 2021 16:08:26 +0000
Message-Id: <20210730160826.63785-2-tiberiu.georgescu@nutanix.com>
X-Mailer: git-send-email 2.32.0.380.geb27b338a3
In-Reply-To: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To DM6PR02MB5578.namprd02.prod.outlook.com
 (2603:10b6:5:79::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tiberiu-georgescu.ubvm.nutanix.com (192.146.154.243) by SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Fri, 30 Jul 2021 16:09:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f32a64-6b6e-4e20-7409-08d953745f75
X-MS-TrafficTypeDiagnostic: DM8PR02MB8262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR02MB8262BFD20B56A87B4A655189E6EC9@DM8PR02MB8262.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saueC8c/AOeiGizlfcBoOwhLokE8VNOr7vKYQwnfyjlOy1eT137+eu33epxaIPdroZXmzaldoCjTC2JWEEZGRXoSSPznnrLkG/TAaVvgMe08XgmRC1DRLb93zp5+wIChfIE41nFgeUuVjvo9x793Fsg0thSv9hkz6BMo7AkaOyk35XLi8JRd20Dri8D+BXp/OP48yTJkQlWfg+8ZUeGni4ZcPZhof1Cw/EE34001mBN2ikJWOWfFPhr1cACYEVCw8oXxW9j/R2mylNhiLuD20E5tIrtwB20j3R3QU0778rD7GWKrYHOgxUlKil9VvfeO5p7blkb4x4uWhYsSQk433ggUFvk+xXg6T52TJJRdXsKY+6tkfUhCwtcUDi31yafQ4EzY0o0QJ+D1O8TOxhoficBm4tu5+y4rQejKorHeX6+zPsvlYAdSjp4WPAvvDNx8vYWORLOVSK5Zvqg3tVqmIX9S9SqXMRmpLdLb9i2Tx+ITuYAeS7AFp0LrabUx8r26uztF3BkiVKLPE3S60CIlxoqcgvvVQ/nk2DKpQeWflaEi5gvQYoWGc1lcCytns5SsLf733ANlKXXL6lsygRqsQUs0mftCMsN2v1eE07bcKVjvDMcv+EH24J3QcWuzCQQw5WEZPFEkadCziDnoo5DyQR9acfrPUdYtrMoO+uTzBROwi6IOIID0ftlpFL0lmM4qysQH2ecbdWPEh1Li9Kpgv/m4GrD+loCV4tro6zzRjyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(39860400002)(366004)(8936002)(6486002)(26005)(66946007)(8676002)(66476007)(316002)(2616005)(956004)(1076003)(2906002)(66556008)(107886003)(6666004)(86362001)(921005)(5660300002)(4326008)(36756003)(52116002)(186003)(38350700002)(478600001)(7696005)(38100700002)(83380400001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/SUayyx3hKnjB6So7tOo0oUX1eVAiZ1gHhUTsEJeOQLECSL0xZa5ZsJSQYk?=
 =?us-ascii?Q?PE45wIrj+YmZL5OwpTr6cMo1NIQvqbQ/FtEjx5H15W5oym8ZnjqApuRCDciC?=
 =?us-ascii?Q?5eAJgyi5vSnK5RzHa3iO1KWZGIr3Lmp3KX17OdfKbJTSlRDfn2/WWC6+NBc9?=
 =?us-ascii?Q?/G8I4zTixErMKoAb3VU+NYTPci5nkmL6X420CwY4OR57uc5ZBH3d02fCYnvg?=
 =?us-ascii?Q?XnZjdynaJRzy+AKJ9E1U91xVua1xkOOZywTTfQAyuTqfmXJ5UeSLozpX8IwF?=
 =?us-ascii?Q?k0Cz8wElCkC/zVk+hbkGqfAThRThKb2BN91qyFW7zcE52TGgRBDOY8cq1kyS?=
 =?us-ascii?Q?15gddXZZDU8W2Rwhi9m1tpCUXycnl6egG6uU7ZNWoxzV9906QncFIBTbOTVI?=
 =?us-ascii?Q?FeaXLktLM+vvCGAgupqFRlQ4zh3eY1U0YqlPDypyENEFTqatll5gUTnaGzTl?=
 =?us-ascii?Q?wctjWf6A0d6734f2dmOuU7b98vQex3SeBUZdsG4jyqQ5pRijfpcI4WAj6A1t?=
 =?us-ascii?Q?QQ4wfh84gmTTk5KjtUmqlELdoyRfipKBP/UVvT06/8kL4CGIJc4MSjjCfQrJ?=
 =?us-ascii?Q?fK8v82Ge2X2xeOFsr/fKZ0jAJ9lGoPq/JRfLkqzr2dQYOak1L+IsVPBfwW8L?=
 =?us-ascii?Q?il3rMCA+njjWFIN2pW41R1XWJwYmddy5D5jwfTx4elxAUwi52Lfvb8Y5EoVY?=
 =?us-ascii?Q?8lbpWonRDA+0AguoC4G/IGrjcPdiddDySU42GwrxiRp8l+g/12bovZQpkSbq?=
 =?us-ascii?Q?yj2lHTWshjkzjeyCXrkJSilKvMCW1pk+8IrZoZljjTc3rHslxaz4yAn+tiYO?=
 =?us-ascii?Q?aK3/WuJMliGIbY8B6k4sANpKjy4QIJxR0MwfDkw2+CZp1km3I0DIWPfTSi/i?=
 =?us-ascii?Q?Ylb3NV0ELOixyfXBD2JJvHi07Lk2DC32ajYII0aVjE3WTj5LXMOw9KJoyYgd?=
 =?us-ascii?Q?RBI7UlkDTNh2r41uvW5KqQSBjdRLOLbLh9msn6XeqDUGsBcqnmKuscO7s1t4?=
 =?us-ascii?Q?e5TUH+sf1UY/jiPMpvZV7uhwVLxLlyTcerfJJTW/T3p7eI9U1bhU6v4TEYQ6?=
 =?us-ascii?Q?cXeXXdoObGdGuHTiBg9IQw89ZJrVIDkz8DcOsv3MoayutOal5k/MJQSLgWz6?=
 =?us-ascii?Q?Sv4/IW095XFOZEaIUkmJK2JOOiuiQOdOQO7OWcIJEt/YZsEyuWsoq1G6/szI?=
 =?us-ascii?Q?/T9LZ4YLTiX984FD6fmyrCn28usZSz/ON4oHGKMyQvXpYpWsuHL28ULtaqHT?=
 =?us-ascii?Q?d99ae8Dx6Tl01ae+a5+WoNRyyqGpHQEHdCn+IwmXY68dmX3GJj/aSp04dNUC?=
 =?us-ascii?Q?2h0TqHevAubquaUgrnT/y/zV?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f32a64-6b6e-4e20-7409-08d953745f75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 16:09:13.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhmomSkzRbsfs187YqVWVl0YXYC3BgCqfdxdfQmM3nw17+kXtqyo/YyMhYLleT935sxazUy11iUbH1Wq5uVwkR9XaXFP5jEoiFG6v0lahp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8262
X-Proofpoint-GUID: MPyWNya3w6HgikbzgnYYFGt8qGPD58-n
X-Proofpoint-ORIG-GUID: MPyWNya3w6HgikbzgnYYFGt8qGPD58-n
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
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

Signed-off-by: Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Reviewed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Reviewed-by: Florian Schmidt <florian.schmidt@nutanix.com>
Reviewed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>
---
 fs/proc/task_mmu.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index eb97468dfe4c..894148f800be 100644
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
@@ -1374,13 +1387,23 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			flags |= PM_SOFT_DIRTY;
 		if (pte_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
-	} else if (is_swap_pte(pte)) {
+	} else { /* Could be in swap */
 		swp_entry_t entry;
-		if (pte_swp_soft_dirty(pte))
-			flags |= PM_SOFT_DIRTY;
-		if (pte_swp_uffd_wp(pte))
-			flags |= PM_UFFD_WP;
-		entry = pte_to_swp_entry(pte);
+		if (is_swap_pte(pte)) {
+			if (pte_swp_soft_dirty(pte))
+				flags |= PM_SOFT_DIRTY;
+			if (pte_swp_uffd_wp(pte))
+				flags |= PM_UFFD_WP;
+			entry = pte_to_swp_entry(pte);
+		} else if (shmem_file(vma->vm_file)) {
+			void *xa_entry = get_xa_entry_at_vma_addr(vma, addr);
+
+			if (!xa_is_value(xa_entry)) /* Not a swap offset */
+				goto out;
+			entry = radix_to_swp_entry(xa_entry);
+		} else {
+			goto out;
+		}
 		if (pm->show_pfn)
 			frame = swp_type(entry) |
 				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
@@ -1393,9 +1416,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_FILE;
 	if (page && page_mapcount(page) == 1)
 		flags |= PM_MMAP_EXCLUSIVE;
-	if (vma->vm_flags & VM_SOFTDIRTY)
-		flags |= PM_SOFT_DIRTY;
 
+out:
 	return make_pme(frame, flags);
 }
 
-- 
2.32.0.380.geb27b338a3

