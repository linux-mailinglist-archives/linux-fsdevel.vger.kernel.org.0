Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56334F349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhC3V2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33174 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhC3V1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULP0hM122922;
        Tue, 30 Mar 2021 21:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=qeWsMypjQJE5WJDxavYLccIioQ1C4MVe9l+DC4ES6oU=;
 b=ssy7RMsi/f1g4LL7Ht1jDPvcd0F+DnCfKUebZUbt+HiyRsqN2CWw6dNmsiwi/zbgE2VW
 CtGT27lzBiYTwLYd32yNBQrLADOXafeHzErzOnNFqhvtzLiqWdJ7xTWe0qRoh6HbOWWl
 WsO/ESCYSQn07sw3BYagmlAdJ5DY/AxnKQsfOuyhZxtLVNjwdlPgu/k1nmzQfp+bu/A2
 QbqdefKgtDBHeUJ2NPke/4V/06iyRw0w+PUkZkCTHFFOT9dtCehvof8Smpeh9wHk0A4p
 2jjaqiaWya+vS+NdJ3UKTj514tbliIfH8Ca1TItxbDmEfXmoZZK8IlLTeztSzwCipfD/ nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37mafv0840-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPR2R105742;
        Tue, 30 Mar 2021 21:27:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3030.oracle.com with ESMTP id 37mabkbcyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcNIihEWT5XS22I/vGYCmnTFAeSme1bNvHQGbj5z7wcfc79ouyxgNulkCIf5j+Hdq+z0ew/GbM9wuHHq+ELvozgehur5xOj5WFDiGqndLblbhXWrIVwJPpxYYIqokBNP80ebQF6n/htwLNAQ9tUg+/p9VDef8pUPrQ6oCkEwjF1+LJp3817Z1RXwmBmF1WmqmsKk45RFmxCQk3vkX8Ryn8YSwzUXQWbTzPWF6lffIOJ2sKRzU90BNVMNBylQ3uySN2pEr++7LrauON77MmtwDcCbcnoOLvoA3nhGGDOlQkABkNwTBo/5FUU7qhCY0c4H4zBuiKDdrCQezG/FaHWtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeWsMypjQJE5WJDxavYLccIioQ1C4MVe9l+DC4ES6oU=;
 b=MDiICrOrzDJiVoOoTbsGNgEaTo96RtEh81r0cetC5veJB+9todjchix4WQ/gmSCHNfMmIFDnZbSNX8kdF/CGuOo6J0fCMf49RBZY21decHy1+YHNPl5Y5Fgz7Tcqozx/rG3yETG1Cthq+A+A7IcxMzSWWxTEUNXTYSfjJGVcVaYi/QJ31Tn1sZuQN+X0hykW/sr+KJdlUMz3KX8p1u3IxfjVpgJfv2jqpMllqq0ls2e7CEp9iaTKsRyA2AmxNTP5B/xMXBklBYRwshDGDhbFWIGhF/CMIsjc9ed3yRtox4gMzxbjzrmLpclARTFYexvbWg3mqUjOm5Zwu2y++yfTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeWsMypjQJE5WJDxavYLccIioQ1C4MVe9l+DC4ES6oU=;
 b=qM/vejop5I2rVN5uJOzc0woKQGuSqC5kxt1NWE58Yo5y0dALt0Mj+/71/79POgvVegDPLuWQIfGGbKGHOal3LNJ1MQF9WsAyFCJ2/9223ALzCucSOhFK9QHYAV6+qBWem/fKeZexdr5UwAmcvaw+o8KUpru8/WaFgMst1sIObuc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3679.namprd10.prod.outlook.com (2603:10b6:208:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:05 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:05 +0000
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
Subject: [RFC v2 29/43] PKRAM: ensure memblocks with preserved pages init'd for numa
Date:   Tue, 30 Mar 2021 14:36:04 -0700
Message-Id: <1617140178-8773-30-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac83f2be-0e33-489d-86b1-08d8f3c290b8
X-MS-TrafficTypeDiagnostic: MN2PR10MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3679BFA1F30CA0A6E2B2343CEC7D9@MN2PR10MB3679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: waZvgu4QA0MAWVX6D3VkK8Dpn4dFEhzVFzHgyyL2q7HaWMsCH7XShKSMbpbwYVtmsV78m/14EsV76qqqI7oCdJvGaUhBCov10rSvSmNvI6WmU0yKHdRCNbcHFMCj0xLPe4ycpmWlEBq1wtB8hPhL7T5bjfxjnAGz1Hdnb0UFvpq0Bb6WYilldBqM/z8pvGTuFfQDD/zZmv8bMFFEYLTZv/hEgOocTPZ5cuuGsoPRLhvRW1o1pYiVZ/N8u8gVArO0dL9DIrVxpyW24zM/jJLc2T4+ZkgKn8klWp4KGOuHAq70GPsv1/IItZZHkpzOxdX+gajSFVXOWu60ZHUX97g8V4NZdXkL1l1gwhJET1dhrRiFhOniGylZUA7XyHvKU8z1AOL4/0q3KXEOdedpG3Tk1twT8VpMLyRbIZWmO/joT+/r2qTabLs8A0MBpA2pItvTxiR+zp/tls6OWYx8CE/iY+7X8nsROuQ306AlElCbf/Y00mwTzaioMKKGC+i6AwXgedE9w3mttWITbhA/SthyMP4YeVwqaggAG7fYj3o+xAlTtLcLbocOZ2jna3gC8HxbVq2NBaBkik6tH7oUWA1zmP/G5gSLqEnSZnsEeSH4wPYuKp8upU1t6sgA8hF9tDbkdH16NHrrXXaa5cvMGPyKHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(956004)(2906002)(66476007)(4744005)(16526019)(8676002)(316002)(2616005)(7406005)(8936002)(44832011)(83380400001)(38100700001)(6486002)(26005)(66946007)(66556008)(7416002)(186003)(4326008)(86362001)(52116002)(36756003)(5660300002)(478600001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ceqSPrILLk/4oVtRQcfNTngPkFrstVD0O8yeTDEJEchY3qyi7Nngey1EbqiN?=
 =?us-ascii?Q?ti2zw2hRWstBfqbH4VYd+uKFqp1E3j6c8hlusLD2/vgZsUIjTSARia2JXVHC?=
 =?us-ascii?Q?E9L2+pBQOADtYDZ+pzmX/TFIv6SKeWD309KjmssAj8HE/qv92RiVmxKAG2IN?=
 =?us-ascii?Q?CxBusVCVTc3juT6HN89p7EuQQhmR8dKlpoDj0KrUwkHn/pRmESQ401GPsp/i?=
 =?us-ascii?Q?OAXpxpDUp9LmVpOmBNRMfm9TBrzFAOvpvZRIjpGbhfEK9MWckfaP5cgQW21/?=
 =?us-ascii?Q?3A01UlJjZxwkepryJDDzBzBB6Zuo7BnuAu4CtCluyHrdIm9FDcjS7B1eXZih?=
 =?us-ascii?Q?F+ajI5EhrP49EQCiDcnQCx/xEtDp/eEpxhzY9LHQvntlO/Zl0pQmfjQ8RgLI?=
 =?us-ascii?Q?/TIMSai/GUYs91FeKTrwrLUhLvhCH7ncnDPA6R2iq0QIUmGuEogeCLxYOHYj?=
 =?us-ascii?Q?zgH2sdvexFba2NU1Zr21f+2Q4/50PFoubuk0dwxepiWeeSkJw08bn3l5i5Zm?=
 =?us-ascii?Q?9xfpp9B6nYOt1fVvEEtxwAvWRFsQh0QHl4/DL9n5sv4CH4Vi34Zx3flkxj38?=
 =?us-ascii?Q?VLajaG2NjFFZX92bjPGBAdY4oyzrwd+a8AOU4PbMZ2mi2IY61bxP3gPPUjMH?=
 =?us-ascii?Q?bYTnzQGabctVP0sQg1nmz8LzImXi2ndCnsrzS91Kp603WZs/5CdVmTfPhRVO?=
 =?us-ascii?Q?SdPNRtOka0pAsyjSNU189m7HtbkbBgtEqTZ4G9/JYG9kRpZzn+Y18yiPiCHz?=
 =?us-ascii?Q?wva83OAX0HxWVHuy0gTBEbjJSNnOcuQgUeyIqWnije6wT/RK+PuZmmOB64Ht?=
 =?us-ascii?Q?h1jS3X2kjFHTpFg7jU7tDYUtFFFzxnojkB/tJ/P+nGv9/BYAwhEtZqqCpFde?=
 =?us-ascii?Q?qLRAMXNbAhT9OawTEcHslAUjhdurGQGLTgZ4LaW789Ut65B1zLc9NgWdwumR?=
 =?us-ascii?Q?mbZohlBP6rgyvIMJd92RqTlpa+fs4dZhQOZbyjHSaDETCVbvYsWx75NAnk3D?=
 =?us-ascii?Q?3X46+riGVW3B8xcdsm304UFkwQ9o3pA6/6AuSys0rNprkNH5IG1pQVLsTNRA?=
 =?us-ascii?Q?eC6daO2filAPLtNALIEY6ZmMPvf2ruIjRhXyFfeV63wqdDPvjF5OyQUYdv80?=
 =?us-ascii?Q?ekxEWm+F3s6UJqjqHVlNPSJu2CYmSI+jvnDvg8znuL9CC1o/yorMmsWrGMhP?=
 =?us-ascii?Q?UrSGOpreokOrKkas/mnyD4CtdzeLkTeerVN8E47caqO8rB8w0vguisxM2UdX?=
 =?us-ascii?Q?mJqmQjdViOjQG0Km0aLYDUNaacKKd/Ny6+YtusFreRGPMsssSub6JIUIK09N?=
 =?us-ascii?Q?BB7+6XRUL7LROzMJHqcQeCb6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac83f2be-0e33-489d-86b1-08d8f3c290b8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:05.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9uaacnonPXPusJgIFgxG6zVg6v6rbwOvnNblZi3acnJR1ZXF3inhQ6sAdplTBsPC8aHvWo1yPTnbJoBFHT8UuLEnxKgOJUZFx/1Bak1wX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3679
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: mtrY_P5IPbIHk2O2PiRKiuAgFw6QSQ61
X-Proofpoint-GUID: mtrY_P5IPbIHk2O2PiRKiuAgFw6QSQ61
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to facilitate fast initialization of page structs for
preserved pages, memblocks with preserved pages must not cross
numa node boundaries and must have a node id assigned to them.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index aea069cc49be..b8d6b549fa6c 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -21,6 +21,7 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
+#include <asm/numa.h>
 #include "internal.h"
 
 #define PKRAM_MAGIC		0x706B726D
@@ -226,6 +227,14 @@ void __init pkram_reserve(void)
 		return;
 	}
 
+	/*
+	 * Fix up the reserved memblock list to ensure the
+	 * memblock regions are split along node boundaries
+	 * and have a node ID set.  This will allow the page
+	 * structs for the preserved pages to be initialized
+	 * more efficiently.
+	 */
+	numa_isolate_memblocks();
 done:
 	pr_info("PKRAM: %lu pages reserved\n", pkram_reserved_pages);
 }
-- 
1.8.3.1

