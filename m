Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C222234F310
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhC3V1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49766 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhC3V0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOrrd130897;
        Tue, 30 Mar 2021 21:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=8LARW2khMGLrdTOnD9jJjXqihyUkWdkeHGpsKP/eAiY=;
 b=xP6hmp6RhrpHZ6/Fw2fUfIkhDD4VWBi7IqyyNUFVUlWspsLltlsfioAgmZ6xVmEC2ZDa
 ee2dD1D1t9jeraEix2dIqz2U3KAFZ9H5piq26npTDVOgCe6GXerQfC/ZiEBJRR+1faA2
 jq8NUJHWRwKKkO2XzIgx6OwJvccHNumenQLWcapqu5BnTb5trAt5KnEZnNnY2GpjOMNk
 u4D30kuU49q8Ai88goUsNDcBl8fenfF8lHWHxBqxddMwNWKcH9elxLwVXg3ui4k0caaR
 Gb/vpASOhJkz6tBw8xgxfJqRgQP1hsxMMSJiNKBHnWdNJUk6d8CljeWEiFByJ2ZJRFjw cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37mabqr8nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPSoe105808;
        Tue, 30 Mar 2021 21:25:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 37mabkbc4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxuM+i28qYu0lNC13truAhC/2Qha4JHQuNzftYRWia2m7DC0s8Sx9lNAV7lkLDiVecH/HmQPezLXaNmaSfZZWsG/XW9+Qq2xGKh5Pn6wljCiZUZMbwdYXV3279zBsyhWIgTdCDBusITd/zK7SNcCCxemYTy/ftSvK5ynXLYcdIeaQqzRtC45DL3UOC0qHIxubjgS6ksUEt1b9Gc86yamSiAdGVFKcv0G8nH9PZskLKXvrs+U67ZMiqgmbYg6v1IEcKlsV2vMbRkRcJ708Xso2W1DaYi/IxGfssFx0gHsg7W2pMkM4dtIAucmePl6N9ru0qRpdWtNC0z+9URR8p9/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LARW2khMGLrdTOnD9jJjXqihyUkWdkeHGpsKP/eAiY=;
 b=IDy5E3XQo4hGcen0In+smA3eQECinW5Z/OT3givZyQJRb0M+p97NNBB8T4w6dCznls0AZRps80/RWvM++XoM2quKgeOibro45pPKumlOScCv4m3zSS3SWBcaep/Q1FBxD1KTyL2ULp7FevLm5kfZASns/fY4nOEy4fe/IHOlKCkPYAt1xh+LybkttudeBnpdPd1OtXIYKXhqsMGnaeIiSSbAnTSKKDjfRGWXzE+kzr8KQVq2NT+viDb9NfiWQNw35N9T/Tw+8+IiAmlw+JDAewExh3Xa/fBZGhqbo6IUOaVjpiRiSjuyq4kO5Tq+nwWEFlQWXIDCs/b4i0AAlPEirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LARW2khMGLrdTOnD9jJjXqihyUkWdkeHGpsKP/eAiY=;
 b=aI5RWvYOjlCWyj3tiAiARTrKTx/0DbCu3KC4dZ1hly5yyziz9GvQwzovd+puwQE3z1SdfF6cNiEghe1xS48+eXSmg43di3s1gjLYjxZNOBEgTL4kTdUGdO3mPkYSMtbe2DvhXgvKp8ZrGTjRpddp0rrQCwvciOn789ClxvoXBbI=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:25:52 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:52 +0000
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
Subject: [RFC v2 12/43] mm: PKRAM: reserve preserved memory at boot
Date:   Tue, 30 Mar 2021 14:35:47 -0700
Message-Id: <1617140178-8773-13-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4175c792-06fa-40e4-7b68-08d8f3c26503
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3613A3EE8847ECECCBB93399EC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLhUmqWbA7mp1AiI4HKY/AJeK+7xXN9d+sIBOEvgztsvgrbgzKMORpFbEAkjXdbKbvOCHtfzExztUrtU0YXThKp/opRU9fdxos11ORrJd4x/B8OcnuIZTGJ6Sam6BSCA8SFREyoTim9AKQGw0nHRZQGtqhc6cPNGgu6zd2z8ZaZ9SoBubyWWxUZC3w6DMaUHxWOHGDjn/v0moCV8gflt+uWc4p0EgnapLe96T3Aav3p2i/T3NrsUhCox8kQMON6td3bbtUAe7CeO4jcireheod3smG0cXOaF/TmzBg6dtNP5SXyunD5DQ8IDiVKImsB9LH0Ze7lPPE1sJGQYZtNWr38ZhRx4WP8d+iIfg7O+dDumkaMEq+JpI2/Uxw1Lwv2O8PF3FmLS678vFICo6baLGqCMhDGZgpa5DrnY6/Lf8dctmMJUzLZYBxca2v5llv67mfvXP0pEff+OVraE7gmLfDwrQS+MOxzZdih8pGPjDmQZ9DO2wtn+vFOcez55zxDG5++lfcu4IlJP40ekMG7Wf5agd3nfjqXhSkBY69y01DPIaoNfatQdJDiws9MIDIqVKK77O+U78cbm4FFNBmSluOPeoafDTBT1uIJa6qazyfF4R3wPznoedrfKUbvbByxcYoHemtmNOFnsO47YG8rs2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(66556008)(316002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CcnFwkkKQulQ3VBc4ngTXXRwG2fWco7C/jWX4v3c/bDt9XMjSDZ/8svRebb9?=
 =?us-ascii?Q?bRSeBcAXdnCRSFl6qK881oOAvW5DYvUOqGLzAStF8xLeVpOGF2Czbsayhc5K?=
 =?us-ascii?Q?UhFYWMewraV3gffT46mi7lajG+xNevnTLEeKqpwGMG+ztMg0ZNhZuSqwMUc4?=
 =?us-ascii?Q?BTS6b02en/OaEoJBtPr1+nzl+3F+OAaIAE4ZJ+d2/t4ZpDMqrTp8nnmuk21q?=
 =?us-ascii?Q?nZO3C5IfDouelQXRXjTHvJQSBSC/c1idSpDAABvV6dFiKYCrYztKSk+7vTNs?=
 =?us-ascii?Q?bL1gwTXGusQPjWrS7WLo9tqqO8D9Mgqpc9j8Wf7ea06fxzGUeGcdiXZwWao1?=
 =?us-ascii?Q?15+ODOXTtk4puABr7eHkUjlyVYoZ7d+bxWCsjEGpUAfq40lPYqjrCAe0IZ+W?=
 =?us-ascii?Q?2s8df3mFAdZfk5IZoI7rVKjpZ1AwgWspYYiX0jfBrpsUeZSLdQB1YMABkPo/?=
 =?us-ascii?Q?nB/V/LENuZS35WIoc8E6agZmcHv2hn9/mEqoMQWp5W7JPKydDYfLCy8E+KVa?=
 =?us-ascii?Q?/Z4pXxht120KPZCw/2sWdl6y2wz3JOa/UZjKYXmgelD/7gpan8sCwl5MiXQ/?=
 =?us-ascii?Q?aFfE8cc4U3Ymv7zZ5Xhp4a/97ICoXVKjwbdS7wLliKtS6Rss3c4a/GeCABCM?=
 =?us-ascii?Q?8iM0qokRP3WcYi7lH9UwrkkRNQsNSPSNr0Pt2xsfXB7WaS0NMq/RdruBnAiE?=
 =?us-ascii?Q?wYQyRMtKYTJr/fxzQrfetOBRwSuOMoalNp2m1IPy1P4lKB4FDefTAWH7etYI?=
 =?us-ascii?Q?F7qrCX9VFgrvKcvO9cCX9+9U+R5OuCANM+fbyhpgPsXeNemmdT14QwJVc5tw?=
 =?us-ascii?Q?nuiXK6zY52VckX9pIUumtGfTqi3ibKxfKuVRNhCqVT07teEHPcDPKJO4cv2A?=
 =?us-ascii?Q?bWzK+jBxXLdyG/IpRNRgqtKGAUKeGqWLHFah5SGEcFGiTLpWllzOGKDyIlUG?=
 =?us-ascii?Q?v0TN1rXCTdz6a37lPnH6UEcK1WJvxeUfBPlD2yh2uAynr27zVOCitCPth2w9?=
 =?us-ascii?Q?IktJElmqi/K162WbuKyknrq0BP4LiizjftH5cBv1zns3znIj9UeNBhwWa6oK?=
 =?us-ascii?Q?xfYazMlvlG/PfeyqS83aYCFZx9/3RCOD2XFKzrg+i2dBo9JmyMfokfHolga5?=
 =?us-ascii?Q?8ji3Wg+ZRAtt8qfRY0jUWP043cR4EOwoxmot+92e9d1L1pKOJz2vgZq9RQ11?=
 =?us-ascii?Q?jpYpssQvuf+LL1ZxDc8SAZf9il4ld4mdemC52LklTCchy+Vz/eTBAGxNJ+Mz?=
 =?us-ascii?Q?XQV03D/Rgjs0mDduTWUajUuI2zAus6MmTJ3wqB0QL7R9o6NDxUriLEH4B8Ww?=
 =?us-ascii?Q?IWnlBlPcEXlnUBXqsyvZEkNR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4175c792-06fa-40e4-7b68-08d8f3c26503
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:51.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKIO5g6PcEdfDdL/jA1B20nLeNenRtaBpW4PrsefM1b4Fn+HK0ltPylv0BzFHe3GZSQP1G+c66gW0Z4aHPIdR6pdxGFtracTOFLa0mik1gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: LuvO8YRODka0zaFDEapQ0Ff8V0Jyr2VW
X-Proofpoint-GUID: LuvO8YRODka0zaFDEapQ0Ff8V0Jyr2VW
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keep preserved pages from being recycled during boot by adding them
to the memblock reserved list during early boot. If memory reservation
fails (e.g. a region has already been reserved), all preserved pages
are dropped.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/kernel/setup.c |  3 ++
 arch/x86/mm/init_64.c   |  2 ++
 include/linux/pkram.h   |  8 ++++++
 mm/pkram.c              | 76 +++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176ef2ce..fbd85964719d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -15,6 +15,7 @@
 #include <linux/iscsi_ibft.h>
 #include <linux/memblock.h>
 #include <linux/pci.h>
+#include <linux/pkram.h>
 #include <linux/root_dev.h>
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
@@ -1146,6 +1147,8 @@ void __init setup_arch(char **cmdline_p)
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
+	pkram_reserve();
+
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b5a3fa4033d3..8efb2fb2a88b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -33,6 +33,7 @@
 #include <linux/nmi.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
+#include <linux/pkram.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1293,6 +1294,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
+	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
 	 * might set fields in deferred struct pages that have not yet been
diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 4f95d4fb5339..8d3d780d9fe1 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -99,4 +99,12 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count);
 size_t pkram_read(struct pkram_access *pa, void *buf, size_t count);
 
+#ifdef CONFIG_PKRAM
+extern unsigned long pkram_reserved_pages;
+void pkram_reserve(void);
+#else
+#define pkram_reserved_pages 0UL
+static inline void pkram_reserve(void) { }
+#endif
+
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index b4a14837946a..03731bb6af26 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -135,6 +135,8 @@ struct pkram_super_block {
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
+unsigned long __initdata pkram_reserved_pages;
+
 /*
  * The PKRAM super block pfn, see above.
  */
@@ -144,6 +146,59 @@ static int __init parse_pkram_sb_pfn(char *arg)
 }
 early_param("pkram", parse_pkram_sb_pfn);
 
+static void * __init pkram_map_meta(unsigned long pfn)
+{
+	if (pfn >= max_low_pfn)
+		return ERR_PTR(-EINVAL);
+	return pfn_to_kaddr(pfn);
+}
+
+int pkram_merge_with_reserved(void);
+/*
+ * Reserve pages that belong to preserved memory.
+ *
+ * This function should be called at boot time as early as possible to prevent
+ * preserved memory from being recycled.
+ */
+void __init pkram_reserve(void)
+{
+	int err = 0;
+
+	if (!pkram_sb_pfn)
+		return;
+
+	pr_info("PKRAM: Examining preserved memory...\n");
+
+	/* Verify that nothing else has reserved the pkram_sb page */
+	if (memblock_is_region_reserved(PFN_PHYS(pkram_sb_pfn), PAGE_SIZE)) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	pkram_sb = pkram_map_meta(pkram_sb_pfn);
+	if (IS_ERR(pkram_sb)) {
+		err = PTR_ERR(pkram_sb);
+		goto out;
+	}
+	/* An empty pkram_sb is not an error */
+	if (!pkram_sb->node_pfn) {
+		pkram_sb = NULL;
+		goto done;
+	}
+
+	err = pkram_merge_with_reserved();
+out:
+	if (err) {
+		pr_err("PKRAM: Reservation failed: %d\n", err);
+		WARN_ON(pkram_reserved_pages > 0);
+		pkram_sb = NULL;
+		return;
+	}
+
+done:
+	pr_info("PKRAM: %lu pages reserved\n", pkram_reserved_pages);
+}
+
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
 	struct page *page;
@@ -163,6 +218,11 @@ static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 
 static inline void pkram_free_page(void *addr)
 {
+	/*
+	 * The page may have the reserved bit set since preserved pages
+	 * are reserved early in boot.
+	 */
+	ClearPageReserved(virt_to_page(addr));
 	pkram_remove_identity_map(virt_to_page(addr));
 	free_page((unsigned long)addr);
 }
@@ -201,6 +261,11 @@ static void pkram_truncate_link(struct pkram_link *link)
 		if (!p)
 			continue;
 		page = pfn_to_page(PHYS_PFN(p));
+		/*
+		 * The page may have the reserved bit set since preserved pages
+		 * are reserved early in boot.
+		 */
+		ClearPageReserved(page);
 		pkram_remove_identity_map(page);
 		put_page(page);
 	}
@@ -684,14 +749,20 @@ static int __pkram_bytes_save_page(struct pkram_access *pa, struct page *page)
 static struct page *__pkram_prep_load_page(pkram_entry_t p)
 {
 	struct page *page;
-	int order;
+	int i, order;
 	short flags;
 
 	flags = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
+	order = p & PKRAM_ENTRY_ORDER_MASK;
 	page = pfn_to_page(PHYS_PFN(p));
 
+	for (i = 0; i < (1 << order); i++) {
+		struct page *pg = page + i;
+
+		ClearPageReserved(pg);
+	}
+
 	if (flags & PKRAM_PAGE_TRANS_HUGE) {
-		order = p & PKRAM_ENTRY_ORDER_MASK;
 		prep_compound_page(page, order);
 		prep_transhuge_page(page);
 	}
@@ -1311,6 +1382,7 @@ int __init pkram_create_merged_reserved(struct memblock_type *new)
 	}
 
 	WARN_ON(cnt_a + cnt_b != k);
+	pkram_reserved_pages = nr_preserved;
 	new->cnt = cnt_a + cnt_b;
 	new->total_size = total_size;
 
-- 
1.8.3.1

