Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B1C34F359
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhC3V2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33406 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhC3V2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPOZp123006;
        Tue, 30 Mar 2021 21:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=VB/rLeMWS58+QfyQWQSylpbvo0MGkJg4DhLXEixjI74=;
 b=VWzwP7QHWl8aJ2vVXEbP67wt4oG6dQl8KBBBjMbae1BShJtmCFZOAtPn9T0yDKwXCk4H
 dhYjMeNYr2G07GSrJBYAv29BmmsQZblLk+jdlc6d7uCuHnvSCB5YhK0hTE1UdQYziCLA
 6k2j0qqpwcuX/5JcO6j9dRhIpuiv3dCD4+bfO2j7dt8z8Akh7IOAgCYt4KMw49swp6/S
 vd6JG6evgApq10DkTJy1CIE0BJY8HQROMoevX2XONRdj69p956ICrJJ54zlIeh6H1yN3
 EsZN0EeaWVsEzs7N1AuEk+aOMMAGQLkRK72w2MY5DZvE3g2XuCioo/pkSaZqRrjaAgt0 Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37mafv082v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPSE7105894;
        Tue, 30 Mar 2021 21:26:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 37mabkbch1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll7EMiIq71Pg29Yi9h9EGYmUOqufBeYItRi4iijhWyl/mjxpJ0O3HOToBBhN8x8uA6vsXuAC/Zir3yhPoijJ/B+7Ou/I9XA0CnGXWhbL5Ne9YpMsDg3qJWuUePSqkcfgqQAgVkBjPWoGJvu6W96LXc3ReJSbqtxeADnwL92s56bLF2veEpFHF/uYMrBAy1dKFWtcXIeaxUdxOiyylBYKxD9NEJPG2UmjLV8LLxZl6yUsYVhkLgZCiYzpz3Umz8QqYuIy/1i+QsP+2xtmv3HoGlcOntJNon4KKXxQ1qA0u9kvJmBttdfVeETVRvWsJQ7endd9CIX+W+sfrlcrhdP+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VB/rLeMWS58+QfyQWQSylpbvo0MGkJg4DhLXEixjI74=;
 b=hvF/OBct6VIQZHBC8RQNIGnY4u29MnkaTAV8OWW9lPMUD0EgOnzRzUn/T2AgkXPncD0FUA+tWD7vKWceV+JRjDAWveYqX4ssfgloCCdLaXgpddmNa1WPgZqw+PrqNgMkWpmCe0OJSglxl2uWvvRXAMhfnSSAqjxqmpFGDtQqDPuvreb4RnLGhYamdhcYJ8tHIpVGMi4wL8mHlxnvKyvJ5OYKspznkebSOpP7Td/qiCoDH34TPKtUIdIwGRN0tn+xMA1HFHTY3jGtROvAJRg8dc3ZrDyYgmVi3kbzoIQFUzqAf0+hKucQFlb0KlgZ4SBUbmhrKWee74vWtpMp5nrSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VB/rLeMWS58+QfyQWQSylpbvo0MGkJg4DhLXEixjI74=;
 b=LlA7K8vkkrVmZDSJqFsnYZwYKyNThxscjAiV95w/1mCQxs9zj2piU3cXU1by8iXIGpze2D4R6b9QtmJw6fTxL9zJ97+RtBtpfrT3EM/OBAvz9tCabhGIuzjZyBgCaOSfeMSQkN1J7OpLJiHU7rbvHbYwtlLO60A6A9YXJyj263Y=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3600.namprd10.prod.outlook.com (2603:10b6:208:114::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:26:26 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:26 +0000
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
Subject: [RFC v2 20/43] PKRAM: disable feature when running the kdump kernel
Date:   Tue, 30 Mar 2021 14:35:55 -0700
Message-Id: <1617140178-8773-21-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 694d7e04-2424-42f9-cb28-08d8f3c27997
X-MS-TrafficTypeDiagnostic: MN2PR10MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3600D130261E4F3506AC7430EC7D9@MN2PR10MB3600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cscEe9RqMCZ5Bk5eXmFWlUnzGgxgXMqA7SRpa39rNzkwKQgIzt2yozl6N3HI/q/487CHqHDzCV+goJ/hFfB14NfKAmxZOTCCeK6d22rRcZVRwg8Y9UpSilYeMBhftircYOn700OcJAUv8pnEOCcLZ8ai0Vuaq4FHjaGVmXZlhZsktrydjWexJhFBaUTMJkLRRuyW9j0sqPkRqINmyAwDhmF5iR27x+eubZDlEih6asT/fhId2Oef6RaV22ObJ1F9MDjP3w/QRLWwadrBHVjBTaPyOH7yZsZqtOCL8iFQ3jEhUIq+440pE+hZM7YLd/27/3jw6VNOIIYzVQJLxyl2jrCuBWBYVWFuaXAJsOfOG4LOKh1xZBTvXT5+hx82krXBTO0eDvBbvq5hEex2nJ8lkVtTsMaWTPdEkTVfTV51VfK8fb54CS0KD/wEwcNyc+bvfSvxN5GzK+FUBiwhtLfzguyANne4NkfBE90tFAujpH3LvXJVYraOZEmBXYA5LVoz6JlPC9JE0wxTiIZU5eTPqDNaaGIo6s4iNv/RtqH8LlJuZ271i74VEcXmoVyGTGBy/Sb0/CMsllc5jSuk+7jhkWofPlWiv/cdc4UJscViesM8tzz/Wejk/d9rA9S4VPzg/gboRnUS6+/OkVBwQ04H4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(6666004)(7696005)(316002)(36756003)(44832011)(8936002)(2616005)(956004)(5660300002)(16526019)(186003)(4326008)(6486002)(86362001)(38100700001)(83380400001)(26005)(66476007)(7406005)(7416002)(66556008)(8676002)(478600001)(52116002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?90xYl74I1NhfZOaneujZl42FoE/NCf/6pXzgSvXLQHN1XHgT2Sq6e1lteoax?=
 =?us-ascii?Q?thnZUSBCIUABWRoUjFIYl1owth0Jak11uhGFZhpsRtm6cob2dd89or3d/IH+?=
 =?us-ascii?Q?BSsXgmPndyNgrN5BQHc5ICCJOK6Q+8Iq9NVuUzS89P/nIkG/vXoKa7X1gG2F?=
 =?us-ascii?Q?38tM9+Qv4E7aW3HVk74CBoL0+H9hnwdSVtDepqnsmVF8djxhcgJVg3T3a+kx?=
 =?us-ascii?Q?74kFOpLMsPKG1TSnCp1VDZlY/35tgPV6RMbVdlNZ4wkJFkFNVyy+TJDSDH+q?=
 =?us-ascii?Q?UcBwSVbSqyVssnMtquTtuN7gIzjfAPbax0vb1h2graizSjcaWD/TLMhHXtUL?=
 =?us-ascii?Q?ty0NDj2P4R8nYDgeZ88gqHew6Nlaz8oWgiyrFPs6Db4xVX1e4b9f+2wkxxWr?=
 =?us-ascii?Q?qC6LvViGbVIZNl0DIMDoUw/veHAmwzah8xCbTNbvb1xxxTVzptTY6J7TJwws?=
 =?us-ascii?Q?V6le4Z5y/IHtAU0kJ2fp6Mj6sVYkwBMT0StHmcnq/jGGpFWYfWogkjzHkiyD?=
 =?us-ascii?Q?CnCQN/iGK6pmVQmNe17771OLorik24njRj/EbvBqqOkwJArdedmEPEmhBf/J?=
 =?us-ascii?Q?a3UYXayGBSfEqUljimwkny6G5i9cGwRD+vQ7IchMrKKeccPTmXxSbJaS8eXs?=
 =?us-ascii?Q?5flj0utSIPq1VYUo9/BEA9JBJngf0vtGsjo3tXsdPJCC8c/XH5XHqWJFeB6G?=
 =?us-ascii?Q?lG7PadUw4xJUX2CcO+KR3JYPKqRC8b6o/r6HAYHedo87JfzpFOqs3otWJm3h?=
 =?us-ascii?Q?1VJ2rJ3fnFjcPqETKuuI2yoF0TmVzcIHGawdJX9Qe0aHsQ8/Rk1jREPUJdja?=
 =?us-ascii?Q?yQGWJKdfi0wID9omAoAjuUf0B+h1UHkkMqpJzupESFwfHUd/T+JSyhIQzleR?=
 =?us-ascii?Q?nJkSAQPaY2fleFs9qWVsMdmDc/qKnSs8eyR3qqpF/nhzTRATrabp77kh1C5C?=
 =?us-ascii?Q?FzVaGMQb8eRilxd4O3WzUXREv+p/tITdbEKG+2m95hFFukH3rZQcjOuNqeo/?=
 =?us-ascii?Q?Kk4SiwSwEaLnhHlAl5U6ofyV66IyWZ0o2X0R/Op0AmYPgTP3cShqKqY/Ws/4?=
 =?us-ascii?Q?iO1qrf8fiIjW4+5Z9SH1LDB6o/LMy+F2zMko07/ukeGrNYjCHBG0/si8eo/4?=
 =?us-ascii?Q?W/Bv1liQ7MBlZBeK5/LojcdJAZ6iHXy1AQ48svuwC1b70JNQUipb0OHZtgsH?=
 =?us-ascii?Q?FzQBi2AsfqmTpUgqsef21HWg1LFfJQYc2Xo954RBtnIWnTfcPqdEIPiuBoXt?=
 =?us-ascii?Q?RjmN245VWps9kVhxMBUU7OCtavyQEgBOyTYADvZh7+PM6VHvOdUTEd8uLL45?=
 =?us-ascii?Q?Kyd1cvE0ceJGYtHlUzLy6VJF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694d7e04-2424-42f9-cb28-08d8f3c27997
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:26.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vfin1igwlWt9wiJ4v1BKopZoQBjjZduZC2nMyMxN2YZ+SpDweDKPxb+gHJwkmUpOzALThrdKmpilpRXGMbzI/S1yl24jEiW2yUD2oSRj1jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3600
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: Z_PvSgSATERsXMqEhJpVmcS7dQd3zSG3
X-Proofpoint-GUID: Z_PvSgSATERsXMqEhJpVmcS7dQd3zSG3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kdump kernel should not preserve or restore pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 8700fd77dc67..aea069cc49be 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/crash_dump.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
@@ -189,7 +190,7 @@ void __init pkram_reserve(void)
 {
 	int err = 0;
 
-	if (!pkram_sb_pfn)
+	if (!pkram_sb_pfn || is_kdump_kernel())
 		return;
 
 	pr_info("PKRAM: Examining preserved memory...\n");
@@ -286,6 +287,9 @@ static void pkram_show_banned(void)
 	int i;
 	unsigned long n, total = 0;
 
+	if (is_kdump_kernel())
+		return;
+
 	pr_info("PKRAM: banned regions:\n");
 	for (i = 0; i < nr_banned; i++) {
 		n = banned[i].end - banned[i].start + 1;
@@ -1315,7 +1319,7 @@ static int __init pkram_init_sb(void)
 
 static int __init pkram_init(void)
 {
-	if (pkram_init_sb()) {
+	if (!is_kdump_kernel() && pkram_init_sb()) {
 		register_reboot_notifier(&pkram_reboot_notifier);
 		register_shrinker(&banned_pages_shrinker);
 		sysfs_update_group(kernel_kobj, &pkram_attr_group);
-- 
1.8.3.1

