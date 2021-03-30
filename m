Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AEB34F32B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhC3V1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhC3V1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULP4tQ145269;
        Tue, 30 Mar 2021 21:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=amsaAxr5dRgEtn6kKRVtAsbBOsljUsCMyrQefSwuQPI=;
 b=M7AbEzWrp6HBBqoUDLpsC9AZh4t2bdueXly7L6J1m+YejrIOxnyiWr21U0/YKXgfsLi4
 bpjq1gHVOfqim/bDNfNYhthNKrwJ9sESRnu+aJ677B5kVodfhLErNC7v+QvnucZ4NiE0
 zoX7U5oKa7+ONf7zn5piyC7LbIybJWRGByFOtAEbPpWW+urhG6rFyZ+jj+osquQj1GHf
 LQcadYC30VSpgD7T3GSaCqabJzvUp1vRtzjWIkS7IqCdbuvX/rcZNvOn225iUwn+adMV
 S8HsBMvoAxCQeABehQrLr3DWJA5TSrwKPkvCn9LLR3zQJTXaoWfjTihCX21PWJbVf6t5 dQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37mad9r8ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPZ9k124987;
        Tue, 30 Mar 2021 21:26:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 37mabnk79b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE20CugVIxWqIMx75UOtft367YQYgQXiYgCzbDK0Qd1mDxxZdBH1B9P8qXOpv4sqXk7LTxliTNGut/kXuAQX6RYW6AecYJBTOlzRSRwcT/XsF8baiz8YqkjRfhCjyrJ29kEjVXiPbX18rfB3OJzJlQomabyPuwUmJTMYKLXFiKswe8BXSC0g5l2xIRycxxW5vnrVDvwmf3mEGnDLh121JezKAUElusjoaaR9y88yVLywGe2wtr1Rev/bsBB+ejNHeYyCgZnOVmYxHQsE92kAOu+iS6UBot4+qSnvgIA0d/4QOT02NUusXVxPguIZe6GkZD+6RDO10GYqSPmZtN8q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amsaAxr5dRgEtn6kKRVtAsbBOsljUsCMyrQefSwuQPI=;
 b=WxUEfxmozzQiSfdTteiSH68Goq52QV1Ze2nqVA3t2+lRB2m3nFtRs2Au5mYo0/3Qp7+U52Ybr0Yff1lqSzeOO3QqjYTDmcJj3tLnTdborzQ6Tx3ixZqascVVQ0ZSJXxQUNVbRcM2c2C8kbVVw/JYSyFxNbhETjAET8w6Wh/5yX+0C7Vx9m4tdFITu3d868ljbNvAWGRmU+JyZLA1JEqvx89qpcWGhHAfknKlSihGvdQA9xrzHOZb6TG5x+92Vn1qyd1Gs9ccw1h6jWRdSdragWxd25IoEJgtg4nfwXowSl7S8B8B4DRZam1x4z87Ip5iqEvc0DcI9SRiMpM+fqAFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amsaAxr5dRgEtn6kKRVtAsbBOsljUsCMyrQefSwuQPI=;
 b=a+jjZAz0RTjG2B/U+rLdzwQuLJV4nEj9mBi+jOB5ruqhZ7R502oiEwVbGALvCj6sUUBq75qphmePAQWMOz34JOH4CMPcB67UGgly9sD0pKk+/bfCLROxnzjG5Rett0+ralckLKLBWhqi+oqhrtj+OASR3k2NPIGAQOvTtK89mTQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:26:09 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:09 +0000
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
Subject: [RFC v2 16/43] kexec: PKRAM: prevent kexec clobbering preserved pages in some cases
Date:   Tue, 30 Mar 2021 14:35:51 -0700
Message-Id: <1617140178-8773-17-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8113672-aa3c-473d-c672-08d8f3c26f46
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB361370F0ADA0488E3E5DAEEBEC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YLL0W7hKvOnyCdBf8XC+KqSjjpAik+qhhOhEn10bo1iPzZdIjrxERb06h/jU2noCkeD3O3v1OSYpIMIZmLSFvMyVl1HcZxgdb7zy+rsGo36ckyPFhX8NxaGQZeL8744aKGKpR3sg+yKp3ZIGi30uIMaK/W7+/eNBFPYnktdWOthvYOqy4cOrgudSnIeRBeDFJznDN0xRCPOGMnDWN7duCqHov3c1BscVBgKWoA0dCGr6P9Sflm5myr8UJ3wgzt9CRCLE0oby+7K77vpm/PYClmQLUZEmmGL5+ev+PlrNn3/RmsPJxgp5bbvp/4C4qPUOtmDpR0oX4cZvXc2pRRr6b1NbQdbReMvuPpO2nMsKaWLIcU3GmzeQCBPqoQMOrmd734ootM3Bru+IjRsOJ37UpWQKuP8FHFto9tWIwgWS/j7ygvdiCNk6Y3xePT3h6/qfGV3APx46s+O27xehmq1q0HwlNbIHAfdWivx95GcDdj9ldZmLFLIOBKUThFLOstdjXuSRuF4QIYZv5W9ai6leAWSzxCNs1nTB/oezm2UF/uJtgm5ViLYQqh3j1K01hjckt8lJWFmRm3EabicvGdP5EFC3hdBmQWSdFOrfz0+uvuDD9AJkOI3xK9YSEU8BXqcoajNoylu1uTYhWUXkxpopg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(6666004)(66556008)(316002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MCZc88onvvCfIBPEFPgfTeWY6uShWuUv6BtQ1UPDHINtW2w0MFlMUSY8K8JK?=
 =?us-ascii?Q?F9R9XAu7kO6E4zl8J2rMagAjaf/Gw4c8hq/tTn416be+VA0jz2srxs5na2gJ?=
 =?us-ascii?Q?l96wy5faKvgmjh+fEO4zkRBJis27Cmy/pSg3Jtb0MsC9E40G9XEbQuiS6fMT?=
 =?us-ascii?Q?6EAtlAWyPH8sKBfTLASgUyiJLRVFl3LHvZ965V8qdX9FXkYW5PmFTMS+2rE3?=
 =?us-ascii?Q?oYds/5whqIh+elpMl1Ei1apmy7p4gCdENCLgqwQA8mN2NsNwDNDRlfZLsbB1?=
 =?us-ascii?Q?7RxKa7nZtXb91wQ+w4lGpZGqZVNZTddjvlsnyolOq41NslkydxT4QCuYzUf4?=
 =?us-ascii?Q?rjXEAVcKctzPUCgRKHvdXlvhwbz6J/4D/HiGnkkmqr3fyvFX5Sj089WXgPZ9?=
 =?us-ascii?Q?HwKok7qtIgB5ChMXVJQvR62TSxxx4qpPBJ/AAdEZuftrIl58/3YCi9YX5JSS?=
 =?us-ascii?Q?dC/S0gtqZ8XkjE2IcRDsoUBrkiKv0fqRSYlOjUBs79aESJ1r7QzaVZeMTb/m?=
 =?us-ascii?Q?AozZphOtodhSAsErZneLL0TyO0c51S1ITZT/poNnoMTSvPvsH31aOAaq6aTR?=
 =?us-ascii?Q?t3YPqg0Zpc+WnBLMusjxgGpsMxq9kPJR512caGedfC4EWZGcw4o/cjk6x7Ju?=
 =?us-ascii?Q?As4M/ZC0loMISNcjwGgKwVL2dkOS3dapMTqD11i8Qiqn/C+xnOP0VIekZghN?=
 =?us-ascii?Q?JAV8kJrMamkz08HI1+TMchAXQ1Q6wc30w0a28pw9f+QkAxgoIvaSBSdjpSO6?=
 =?us-ascii?Q?fLfj236dWwp+RW7ARlNkNI2sBp5V9im133wZbGRS4Sp9UxS91QJ2vq8MCZz0?=
 =?us-ascii?Q?Z7WDWUYimJ3ePpmeBu2SX50/AWSH0FLmLOm/8ud3VKZ3Gco+dkzj9laq/Q8c?=
 =?us-ascii?Q?dnyDwblhrxnRzhYfM2uUApz0/yHKKJTkiSH5h91MwGIsFmSGlu1fqL10D8K1?=
 =?us-ascii?Q?vEJ1jukp+w9z7doxNNJ9hKoUigrFbvYwbcRp5YbAn2E9Dj+mm60g6vGHznNN?=
 =?us-ascii?Q?HywZNzjT3wRUXlUc+oy3TnyartvV4Gf7J/CTE95kX14aWjesyvmx14yYwKDc?=
 =?us-ascii?Q?Io4gjyVrM2dWyOW5AnfpZS9qa9zAHE9oend/bRS883S3xXWC4uUsLlMHURV3?=
 =?us-ascii?Q?vxpGGfbn+N8Jk8pXsaUgU52f20S3Hsx9G3wfUFiWtr1Ku3+YjLmZpNtpo+NF?=
 =?us-ascii?Q?JF3J5j/EYVJcBTzAkW181y+RN6XKMQgH1nlrOHdkPX4AVSXW9wzaa72mt1Lk?=
 =?us-ascii?Q?e/M+4R063zSI8aaRXhGLIUblgs/wuPvKvfdr9fhLTI85LujhbirjVFcWNWPZ?=
 =?us-ascii?Q?pHtO2KABrBvA8znnXEKmdTlU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8113672-aa3c-473d-c672-08d8f3c26f46
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:09.0818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I07Cb8muMdtBCuk8/IVsLe8n/G7PdLB3+n9QYsZcemhW+ZpyGOq9KSpiisiSozylkEhmRsq/aqnk+OsMgS98k9tXHJBZRHQ9qanO6INTicw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: Xw1lkZmopDx25j6OqeXY_BLeqaWPte_9
X-Proofpoint-GUID: Xw1lkZmopDx25j6OqeXY_BLeqaWPte_9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When loading a kernel for kexec, dynamically update the list of physical
ranges that are not to be used for storing preserved pages with the ranges
where kexec segments will be copied to on reboot. This ensures no pages
preserved after the new kernel has been loaded will reside in these ranges
on reboot.

Not yet handled is the case where pages have been preserved before a
kexec kernel is loaded.  This will be covered by a later patch.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 kernel/kexec.c      |  9 +++++++++
 kernel/kexec_file.c | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index c82c6c06f051..826c8fb824d8 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/pkram.h>
 
 #include "kexec_internal.h"
 
@@ -163,6 +164,14 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	for (i = 0; i < nr_segments; i++) {
+		unsigned long mem = image->segment[i].mem;
+		size_t memsz = image->segment[i].memsz;
+
+		if (memsz)
+			pkram_ban_region(PFN_DOWN(mem), PFN_UP(mem + memsz) - 1);
+	}
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 5c3447cf7ad5..1ec47a3c60dd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -27,6 +27,8 @@
 #include <linux/kernel_read_file.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
+#include <linux/pkram.h>
+
 #include "kexec_internal.h"
 
 static int kexec_calculate_store_digests(struct kimage *image);
@@ -429,6 +431,14 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	if (ret)
 		goto out;
 
+	for (i = 0; i < image->nr_segments; i++) {
+		unsigned long mem = image->segment[i].mem;
+		size_t memsz = image->segment[i].memsz;
+
+		if (memsz)
+			pkram_ban_region(PFN_DOWN(mem), PFN_UP(mem + memsz) - 1);
+	}
+
 	/*
 	 * Free up any temporary buffers allocated which are not needed
 	 * after image has been loaded
-- 
1.8.3.1

