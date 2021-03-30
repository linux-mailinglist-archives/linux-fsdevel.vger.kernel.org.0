Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8213834F316
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhC3V1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49758 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhC3V0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULNsLD130340;
        Tue, 30 Mar 2021 21:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=UUYO3z/elouuXXsWyOd9Gmz3+wWbtLHinkjbPkMqato=;
 b=MaFtLmlRz6ddxkE1+hJpM4l5EM4wVNEDbkBG+ngVA+H/8bL7FSAcVcNibavEh56/MmEp
 emP+t5Vri7uwWORBH8J/SWirOd3NM+UnioUabJ5ACDrqCZFn67Jzw/WqqtwG38teBACM
 YCHDzlcGRFCFwZntI1kyTBG8pAIrSEq6FQgya0nj6RqFIiTCCqv2KlEKwFjuF5SSt7e1
 6/phio8p0T8Fe47jSCj+wp5CH1Acolbg3EhMzBGkLVxeqnjCluKbi4yo1KPKue5dq+tx
 xXJmsvMqLsYPk0DMbSDvBA/rnBLGLV3VfjnCsVlj2tv0UYGdnKLhiMS6QH+ZQrd3PR4p ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37mabqr8ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOax3149709;
        Tue, 30 Mar 2021 21:25:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3020.oracle.com with ESMTP id 37mac4kchx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjs7DI4/tSUXc09pV92PK6eeXc7/N1IQj2iQ5rw/s/frR5Nppg7Aw38OqM8ifBPnN68xhShtGFtmkn029N7UZbWIGHwyyipp6pz0pvkjoaEAsF6SICWEZP6rnjWZg4wjK56mj2eZvaDvKmlPWc+n2OsZ+kHwhJKqXgzgHaUmJdCAWwHzk/7hiu8PB7omi5C2ekAjwh5ipeAfy1pN5yU21SMo1UfkqpWWZ7z+SoINZzePwwlm8jPj9Z2psOlQmQ3Ny7myheJFAMS/X4ecSd7EiW41eL8jGlvdKzip+IRSaDFXLBstVoJUgd02nvsrSlYqwXWTieZyw+y53YlaREJODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUYO3z/elouuXXsWyOd9Gmz3+wWbtLHinkjbPkMqato=;
 b=kx0rl6MW6X3hK9JExicb517RMM9r6zcA4L7OXBkD/46YyUMXyMy9VmZj8QYERkIVWS7wBvj2pLgAeFNG05/JwD6iZQhsqwGnGkIxBS5yrnnPujndNwyyBzvWtAEgNylBPCpmL8cPhov5d30f1QE5WVSUf29db2NyeViGBsE7o64JktNBy5cG3FtoPD34Z+hpmCtfTHcKx7ZsMWJJaxhadIqpVIGlkVrbnhynXx2Xfvzg6Y/0m/z8xcrJp3KNmQJV809TwBvR/B14cHoGaf0Mz8r/E3HWidIV8fEUi7go6uecfoeXGnmwpuSIRPuuin5sttVpvgvwuLQPvkoHs102cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUYO3z/elouuXXsWyOd9Gmz3+wWbtLHinkjbPkMqato=;
 b=PQ6d/gD6OoRalBUrrqq8IlKVik86JoJyxCnEYcW8R9vfGAHqKIxOKvunoDJ4mQRhTZOxi/GAevXwFflp7AZiRIuPT2tntENty+HhMr9U0ooM11mHD/Udn5SBH5xeHWhVkqlUk0VyRp2uGTgdyHw3H0b9flCCqQbUZ3NVZmjWDbY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3357.namprd10.prod.outlook.com (2603:10b6:208:12e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:25:25 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:25 +0000
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
Subject: [RFC v2 06/43] mm: PKRAM: implement byte stream operations
Date:   Tue, 30 Mar 2021 14:35:41 -0700
Message-Id: <1617140178-8773-7-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a23616cd-b4f3-4d86-2787-08d8f3c25559
X-MS-TrafficTypeDiagnostic: MN2PR10MB3357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3357CC909828ADB1D87FEF86EC7D9@MN2PR10MB3357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4nlL9xoE6KNeGmLZMvvWXj7Hccq6ZZqa43WpKoZuGSWGt/orQTvblAEcnddUg16q0+GZQYAYmq9QflJZ7FJfIowDJrzfD/L3c0mJIhXdDfQrb41h9BsO3rq0o14ahVyg+AUC8Jr94a3iwmBjkF/8MXOsK0bJlvICXwlSDzsdXofi3dfzgYEhNHlsDl8usfDwfK8Wz9AeUmeOYfRTzCY0c6xByCWV6a1wlEF0LAZrBKwzQFTPfqQ94fzP9GWOiTM8gbX8je9aXA1JI62AEFqK44/e8P0qRYxwrUreCtpol5v20iJotA8+bk95FgDXCiqHCTT98LbBSR0xrs2MZXUpKazI4wdNYYePdkuPJx7QC2pLMhFZqzg7co8cxXnQTGlCHSRA0sgMYQmhLbjOy0HR+rVMHq2IuO831xZmEFAQBQ56phQGCipoI4EC3Gbv6bzG0wAVDoy5o56Az+QjcR5c36CX6kxoPTdlBEYKwQaRm7ibjT9oDw6LwLVPFjyJT6j/asuD3kjrF5SLtglAAhqi+AG9xiYh91MyFnz3OT0t8Ki38rps9cpzWtCopGeali3Lkq2s7D4m3Iptk+Ojd7N0PLKcpseWSruCe1HanyKQP6j6jjJ55atiw6KBQdE8LTTAlMQd9V/zre2EGFJBJlSBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(2616005)(5660300002)(956004)(6666004)(4326008)(16526019)(66946007)(186003)(44832011)(86362001)(478600001)(7406005)(26005)(38100700001)(8936002)(52116002)(83380400001)(8676002)(7696005)(2906002)(66476007)(66556008)(36756003)(6486002)(316002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iouGMKabyhkA65Od1i9GabpQj+LeKT4THNDuW7SnADXVyrMN2Q+DhoFn3d+i?=
 =?us-ascii?Q?z7XdcVLKbFM7LtndxvLpjC0xIjgoDC9thC5bDE6L3S2kSA73rTXhjbhvEAxC?=
 =?us-ascii?Q?tDBA2X8XjluUkf9e7XxxCzfujLU/58lo2DyzlGOjUc+bW54Psw07iH+anlcW?=
 =?us-ascii?Q?HWu5/r0bUFUCTnEZPLfzmWgCmaOCqbX3a7E+wyDPyuwlHXn75XOwEPaBrR7s?=
 =?us-ascii?Q?2rrdigFM5nL6Y/xB60G68NxH6FVRXep+zwe6SiEY+p7xRIcb8HjIH0xttsI7?=
 =?us-ascii?Q?oJiHMe9+CK7IqZ6gdg/B+c8PwZlY1sWSFMeMXgdyOcxkwdNtjT/0EM4OG7Uj?=
 =?us-ascii?Q?/I6KDRkVxSXqDauaBxdanpVWWoiwSMb3JASNep4locdibasrJyJNThrpMxvo?=
 =?us-ascii?Q?btBkykPdAaBROHKMgCyoXtHVeI9o9BddvRIEMfo+5cekASYhLOLM8Uc7X7Ef?=
 =?us-ascii?Q?oGHilqYdEkWBZizz/wOQCIW81NjQqmV0RNWKlYBA8Z7RjA5jBDPQm1KYRXdm?=
 =?us-ascii?Q?+suefMGTjkpb3eoFqBc/rLl6hbCYi2YpHSGwE4KWDMHCZWthqiERBKuMcLvb?=
 =?us-ascii?Q?JlTAuAdkUzXHorr4m+8kmckZIbEnbtFY24AnPgXDfLhKgw/lcIAl0SWTI6nQ?=
 =?us-ascii?Q?Ne+c+R26bK/isf57+MD4od981g95v5wgnwGJkZgnjsCgquHffN+jOMUlBwlu?=
 =?us-ascii?Q?vkz0S3rNetilzBQQZOy7z69WLAfcbR3EGMRh3wcz3HxjiaUBTxVVkE/ZIVkA?=
 =?us-ascii?Q?sq+ytwr56QWQzklsc2gqG70T9hvATNV+45uxYVDskX3wkpFTKcCwxhHeeu6Z?=
 =?us-ascii?Q?QDzw4Z4Uwiz52TwfHRl99k0nvcIsNqCuxrGskkf6RFy/rzkxEWV7p/tGwUXn?=
 =?us-ascii?Q?S277hLyTitm7nup3EfKsnIynty/SMiKUx9u62qwOttEsD8LdIXdZCJ2lFOnu?=
 =?us-ascii?Q?2IJXk+Dduk1YWqMmyzwoZa605FXUHh8ZY5bBkMlilf2MYlTk8Q6V4henJrDq?=
 =?us-ascii?Q?uJvP0JyDmXgfY5w2pDiImezSPTDPyqDet1x+xgOl2Z8kh52/m/k08Xgy6W40?=
 =?us-ascii?Q?8Zv7gdfsp9Bu5qMsG+iYsZt+WodlEG5zi0O4/kvdGhjZ9jOOkRm26My+tewk?=
 =?us-ascii?Q?Q9qZZKStblRzKF1iJyYMA0d7riDcA5Shx7MOX47Po7g+Vp1oCicvke71E1Ff?=
 =?us-ascii?Q?p8Pgmq6+oLdOOKHdqpHomcjyuaAsYTkN/emYR2RoUOR6U+VTykBN/Rn0wex3?=
 =?us-ascii?Q?XiNM0CsRPP1uHO2aCpaWGinptQFfimKAOg6J/+0cjNQGfn34W4X1gi2654im?=
 =?us-ascii?Q?bSpBqghOvXMjTBo4s5mWOAHi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23616cd-b4f3-4d86-2787-08d8f3c25559
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:25.5945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzl7k54IevJzuMMPUt6dUN9L6ASuUKM5w9sN5vJFJ7X+QoavisAtMhPvc70WZN2fGgxNO3ga50R2UFI5bx9Z/I1rMTFL7E7Abiur2Hp9VBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3357
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: rpdJ9_KxTJgStd7Go_TTy_GHTW9ym2jb
X-Proofpoint-GUID: rpdJ9_KxTJgStd7Go_TTy_GHTW9ym2jb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds the ability to save an arbitrary byte streams to a
a PKRAM object using pkram_write() to be restored later using pkram_read().

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  11 +++++
 mm/pkram.c            | 123 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 9d8a6fd96dd9..4f95d4fb5339 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -14,10 +14,12 @@
  * enum pkram_data_flags - definition of data types contained in a pkram obj
  * @PKRAM_DATA_none: No data types configured
  * @PKRAM_DATA_pages: obj contains file page data
+ * @PKRAM_DATA_bytes: obj contains byte data
  */
 enum pkram_data_flags {
 	PKRAM_DATA_none		= 0x0,	/* No data types configured */
 	PKRAM_DATA_pages	= 0x1,	/* Contains file page data */
+	PKRAM_DATA_bytes	= 0x2,	/* Contains byte data */
 };
 
 struct pkram_data_stream {
@@ -36,18 +38,27 @@ struct pkram_stream {
 
 	__u64 *pages_head_link_pfnp;
 	__u64 *pages_tail_link_pfnp;
+
+	__u64 *bytes_head_link_pfnp;
+	__u64 *bytes_tail_link_pfnp;
 };
 
 struct pkram_pages_access {
 	unsigned long next_index;
 };
 
+struct pkram_bytes_access {
+	struct page *data_page;		/* current page */
+	unsigned int data_offset;	/* offset into current page */
+};
+
 struct pkram_access {
 	enum pkram_data_flags dtype;
 	struct pkram_stream *ps;
 	struct pkram_data_stream pds;
 
 	struct pkram_pages_access pages;
+	struct pkram_bytes_access bytes;
 };
 
 #define PKRAM_NAME_MAX		256	/* including nul */
diff --git a/mm/pkram.c b/mm/pkram.c
index da44a6060c5f..d81af26c9a66 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
 #include <linux/gfp.h>
+#include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -46,6 +47,9 @@ struct pkram_link {
 struct pkram_obj {
 	__u64	pages_head_link_pfn;	/* the first pages link of the object */
 	__u64	pages_tail_link_pfn;	/* the last pages link of the object */
+	__u64	bytes_head_link_pfn;	/* the first bytes link of the object */
+	__u64	bytes_tail_link_pfn;	/* the last bytes link of the object */
+	__u64	data_len;	/* byte data size */
 	__u64	obj_pfn;	/* points to the next object in the list */
 };
 
@@ -140,6 +144,11 @@ static void pkram_truncate_obj(struct pkram_obj *obj)
 	pkram_truncate_links(obj->pages_head_link_pfn);
 	obj->pages_head_link_pfn = 0;
 	obj->pages_tail_link_pfn = 0;
+
+	pkram_truncate_links(obj->bytes_head_link_pfn);
+	obj->bytes_head_link_pfn = 0;
+	obj->bytes_tail_link_pfn = 0;
+	obj->data_len = 0;
 }
 
 static void pkram_truncate_node(struct pkram_node *node)
@@ -315,7 +324,7 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
-	if (flags & ~PKRAM_DATA_pages)
+	if (flags & ~(PKRAM_DATA_pages | PKRAM_DATA_bytes))
 		return -EINVAL;
 
 	page = pkram_alloc_page(ps->gfp_mask | __GFP_ZERO);
@@ -331,6 +340,10 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 		ps->pages_head_link_pfnp = &obj->pages_head_link_pfn;
 		ps->pages_tail_link_pfnp = &obj->pages_tail_link_pfn;
 	}
+	if (flags & PKRAM_DATA_bytes) {
+		ps->bytes_head_link_pfnp = &obj->bytes_head_link_pfn;
+		ps->bytes_tail_link_pfnp = &obj->bytes_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -438,7 +451,7 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 		return -ENODATA;
 
 	obj = pfn_to_kaddr(node->obj_pfn);
-	if (!obj->pages_head_link_pfn) {
+	if (!obj->pages_head_link_pfn && !obj->bytes_head_link_pfn) {
 		WARN_ON(1);
 		return -EINVAL;
 	}
@@ -449,6 +462,10 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 		ps->pages_head_link_pfnp = &obj->pages_head_link_pfn;
 		ps->pages_tail_link_pfnp = &obj->pages_tail_link_pfn;
 	}
+	if (obj->bytes_head_link_pfn) {
+		ps->bytes_head_link_pfnp = &obj->bytes_head_link_pfn;
+		ps->bytes_tail_link_pfnp = &obj->bytes_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -499,6 +516,9 @@ void pkram_finish_access(struct pkram_access *pa, bool status_ok)
 
 	if (pa->pds.link)
 		pkram_truncate_link(pa->pds.link);
+
+	if ((pa->dtype == PKRAM_DATA_bytes) && (pa->bytes.data_page))
+		pkram_free_page(page_address(pa->bytes.data_page));
 }
 
 /*
@@ -552,6 +572,22 @@ int pkram_save_file_page(struct pkram_access *pa, struct page *page)
 	return __pkram_save_page(pa, page, page->index);
 }
 
+static int __pkram_bytes_save_page(struct pkram_access *pa, struct page *page)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link = pds->link;
+
+	if (!link || pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX) {
+		link = pkram_new_link(pds, pa->ps->gfp_mask);
+		if (!link)
+			return -ENOMEM;
+	}
+
+	pkram_add_link_entry(pds, page);
+
+	return 0;
+}
+
 static struct page *__pkram_prep_load_page(pkram_entry_t p)
 {
 	struct page *page;
@@ -646,10 +682,53 @@ struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index)
  *
  * On success, returns the number of bytes written, which is always equal to
  * @count. On failure, -errno is returned.
+ *
+ * Error values:
+ *    %ENOMEM: insufficient amount of memory available
  */
 ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count)
 {
-	return -ENOSYS;
+	struct pkram_node *node = pa->ps->node;
+	struct pkram_obj *obj = pa->ps->obj;
+	size_t copy_count, write_count = 0;
+	void *addr;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	while (count > 0) {
+		if (!pa->bytes.data_page) {
+			gfp_t gfp_mask = pa->ps->gfp_mask;
+			struct page *page;
+			int err;
+
+			page = pkram_alloc_page((gfp_mask & GFP_RECLAIM_MASK) |
+					       __GFP_HIGHMEM | __GFP_ZERO);
+			if (!page)
+				return -ENOMEM;
+			err = __pkram_bytes_save_page(pa, page);
+			if (err) {
+				pkram_free_page(page_address(page));
+				return err;
+			}
+			pa->bytes.data_page = page;
+			pa->bytes.data_offset = 0;
+		}
+
+		copy_count = min_t(size_t, count, PAGE_SIZE - pa->bytes.data_offset);
+		addr = kmap_atomic(pa->bytes.data_page);
+		memcpy(addr + pa->bytes.data_offset, buf, copy_count);
+		kunmap_atomic(addr);
+
+		buf += copy_count;
+		obj->data_len += copy_count;
+		pa->bytes.data_offset += copy_count;
+		if (pa->bytes.data_offset >= PAGE_SIZE)
+			pa->bytes.data_page = NULL;
+
+		write_count += copy_count;
+		count -= copy_count;
+	}
+	return write_count;
 }
 
 /**
@@ -663,5 +742,41 @@ ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count)
  */
 size_t pkram_read(struct pkram_access *pa, void *buf, size_t count)
 {
-	return 0;
+	struct pkram_node *node = pa->ps->node;
+	struct pkram_obj *obj = pa->ps->obj;
+	size_t copy_count, read_count = 0;
+	char *addr;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	while (count > 0 && obj->data_len > 0) {
+		if (!pa->bytes.data_page) {
+			struct page *page;
+
+			page = __pkram_load_page(pa, NULL);
+			if (!page)
+				break;
+			pa->bytes.data_page = page;
+			pa->bytes.data_offset = 0;
+		}
+
+		copy_count = min_t(size_t, count, PAGE_SIZE - pa->bytes.data_offset);
+		if (copy_count > obj->data_len)
+			copy_count = obj->data_len;
+		addr = kmap_atomic(pa->bytes.data_page);
+		memcpy(buf, addr + pa->bytes.data_offset, copy_count);
+		kunmap_atomic(addr);
+
+		buf += copy_count;
+		obj->data_len -= copy_count;
+		pa->bytes.data_offset += copy_count;
+		if (pa->bytes.data_offset >= PAGE_SIZE || !obj->data_len) {
+			put_page(pa->bytes.data_page);
+			pa->bytes.data_page = NULL;
+		}
+
+		read_count += copy_count;
+		count -= copy_count;
+	}
+	return read_count;
 }
-- 
1.8.3.1

