Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B881D34F328
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhC3V1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhC3V1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULNwtB130351;
        Tue, 30 Mar 2021 21:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=eeHURyy6hU/3vomeUrsOPdCqibZVdiCRAeYgF62OlGM=;
 b=QSrWre0+MIaGCYOU7+DJTMuBtk1cCPaiJRKhxW1tqrX3bcQBF+TTbbU6t/6iOBzNDPnj
 vztSlfCHq4Txv0PJ2GZJHIYVQGir71OFWZKpbOTIh7d5YKsVQh5mOqqYWR2JxmGmEb1y
 umPXNnmXMS0kHClYO5KAsVsaTT+k+JBedfDQZaYJ9eaiUoNbWZWdtjX+nzp5l/ZOqdtD
 ReUAHbyz2lHs7Gs+euUUmgl7ViQTSQAFJd/UBIn8rPVunIG0ccbIY2Dyg+W0ri3rgF57
 YJjtXKoSRtR9a2r+IfFHDLTlRzUu14/s4NGce5RkSNwX+OOjwc7LOaVhvfTmyldrn+3g HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37mabqr8ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOabo149644;
        Tue, 30 Mar 2021 21:25:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3020.oracle.com with ESMTP id 37mac4kdf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKUSpQ+EW9A912TSdp4d10GvOF1n0NrPiThg2sVY+dbNLuwiKEWZf61yJ5CsnO/f7FgMLlyLMXzdBo3MWcN/IBBHjsBWl5X3u9hgel62nLuhoHErN6OFvHSkv+OHalzowOcogkPVzBf48V9aXT3rXBl6PfV3wSZ53ANimY971lPXu2QMAvPcnHZ8ezU3hVf9pxWHVqxmeOa6RCtehm87QO9sB/I+ZJoeY2/vViC8trW7xOTWS3AdnlIzQOdzFydvITlsiJXtu3e6U2TFET4C9sEJe3iSmOi03fWnSiuVGWAzdPdKeZJka3ShaXQ0bfxvJJwK0IpSv5MfqdrTWP5VUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeHURyy6hU/3vomeUrsOPdCqibZVdiCRAeYgF62OlGM=;
 b=MZUg1q1nmj74OSKK94hp4a8fJIkI68RqDgUy5b8qkJcWsVCP2duQT6fuIKC4G/xYggH4YZYn+OT1geQy1pcxqq5JcpoeMwyxxlbw0h6q0PWaAPahige2a1anRv9VTr9PY78GOkdxv5ZWNxEtuTKiGkcb3ilYfXgg41HLff7BpoqOywOoexmyUzkdxSbwwdF8JaG1QVCOplSgWO6fFlI4lefpKU0C9CrWCpX5ezo9X8xRcdNBhm+SxTp50nvuN4NfrlkCbLq9QNlBxtnPQwWGVeQBtdNzcEkuZJJGJRXPfB7o2nBo5QOZ+QYEN6P7oESJDR5XUzDzGX2U7zrIwyNUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeHURyy6hU/3vomeUrsOPdCqibZVdiCRAeYgF62OlGM=;
 b=F9rBjMUrlIgbbeJbR4vWmLqfFwoe7LDUAT1NvP3k9u2EaPV1xrZGQ6T8ZXNEzAVemW0U1yJiq3bQ8sF8lKz1bbKJK1eIbELHRvrN33r81Ds+j1Q8hE4ENS7VLqtwLdDf6l736aZvYKsyXG6PUaC2lga/4BAysMsjigeGVgqCuTs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:25:56 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:56 +0000
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
Subject: [RFC v2 13/43] PKRAM: free the preserved ranges list
Date:   Tue, 30 Mar 2021 14:35:48 -0700
Message-Id: <1617140178-8773-14-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23a80e4c-b305-4445-a0bb-08d8f3c26792
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3613B04F95EBDB2394090A27EC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PE7Yw5MNyJHxnEnAc5AjN82fZVNWb8BOpGZY3xByCbLkBlvYkUL41j5GH7jbsIYdNVDww039qzbXdrTHkJQ5ob5OHW1TYQ6qbvQIYiXuMwCtulC8Z7b4CNHojeypotssNnEDyu4ACWFaL9pRtPsrcGm+W20zcaAlYmluc4tiGO69qsE6erZFY4wiGQDNNWXufxMfnpjswbpdqpEprx2WwRM7HcHs2B5PxuPp67momuixcxseeFRUuD4HjuVSlNMygnftmAF1OyGeOG55ty/rzskENTt3ugy7bdbwn3Td4jiRRywJZmHbCfNhimMoggD8GLTgenkFTYdSe3ZdbyU/sXEdX0j8eqt7h0v/z+nDPNpRriHGQyl4WQdov1LSMOwO9yQJiM2JluPF38aZFE23Bg+WTjxMMbYAIsOs252WyHRdtNb5GSjebgEJrSaAm2AhSei9GH6O7zRHXBxl/NIqcQbdLNwoOB9/+5D6RnpxEVpMJFOyZ0XfAs90JD+qhtfWCYWNs8uzZmVeQ8fTv2zh8/oInyB0ru23Jx5Hl770rS1Tk9YklgLl5VoZ6uAvE4+YmLNgP69LF7TQpDEaM9ja2IGgwS7FTq5wBq3A3k/+vw2MP8QBSiD/NWxsPbA1OVtOaWF3b2YZeewDVMB+iTYAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(6666004)(66556008)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eKzezh391nQqclYQXW7aLROI7q3saKoon9xplGDNOp4OKubJkOm5uGvnUR0T?=
 =?us-ascii?Q?1y54hNKInZlK5j39AGVKq1jSyy3SEl7/CHG5cTONUB/CqTPLio27BNu+5AIH?=
 =?us-ascii?Q?aXgB86G3QfeJsJt28OmU92TcbjVFwfBm6QGFNvSIpXVCVFjiMIrQKvCMdQgN?=
 =?us-ascii?Q?cBgPiS+HvzQwokOFH3tLbZetSd/lEGW0mG01VW/s4H7+RL8ZgS1SC14eDHbl?=
 =?us-ascii?Q?a1IOCI597987ghDQI6YBsm8GBYO7jO1TPR00qEd1HM1+3x0uFW2mbaJVA43a?=
 =?us-ascii?Q?knChzVY90MIxCrsvut2gXJlNrynIK0gFOb4CKnKy0CHOl3yk5250askx8CcY?=
 =?us-ascii?Q?T1DvImBAqJLI8MRh/8wYdiobjQpIYOIXz8X4NlN0ge4DZU6rc9pGcJpuWrqh?=
 =?us-ascii?Q?Sl6v7rjCzeW9gPLIhuVyjXBbTbepESZwLI5ogblD8B9YBm5MbI6SePeu0TbN?=
 =?us-ascii?Q?ZLNbU+nk63/NlLVCo7OjLAlfjop7FaG7sl5PLiZM9P763JPMTVes/mzHk0Ad?=
 =?us-ascii?Q?6nxzHD+V6DRI2Wqy85y0HWo4XO2NQeaadPvW4FEDWyiDyKkSdxxgnPuUzAdx?=
 =?us-ascii?Q?qBIB7u1mX+ZNWv+KJx35spU6prKTdMXx/IIxtWpsWGxxnXCh7Z+ce+fQLmHA?=
 =?us-ascii?Q?gG8fMJ3w1jVSGQ6RYzNm+/H0SvWNx6hmyWZfw87QGV3t451i8u779U7oAVdO?=
 =?us-ascii?Q?RcU3/EhoMWKKzX0NAJ41JJ5TDSAp66qioZ4BRIEbP1pcRuyl++rEkcOLAYY6?=
 =?us-ascii?Q?Jg8bI+ssNisDJbPVM4a6vt8Zvpk2ik14U23NMGQc9A33jeSzPe5MJn4s9TPO?=
 =?us-ascii?Q?uJJakJauRgNAqHrlqqryrBYFb39HWhnc3dnPqQK04e9PWv4v/KmqqaxafBTp?=
 =?us-ascii?Q?N96QgnAR51GvHnG6cUDrB9j2v4Ya3GA8HBvztZSIYKjhSq1j6ZGKN8VXV7Vc?=
 =?us-ascii?Q?u/oNFw7cWAgbiv65xiILsvquP5SwLSgu6X3pwAKNLyhKSycLQ5BXW5kN+LGj?=
 =?us-ascii?Q?SZghemHg/BVo3LAhH2WDLjXthI8Aa6Wko9CzSViwgLYhoofha9A1j9LUaZKO?=
 =?us-ascii?Q?ms988wGtoUwZeakVGw3NCxBPwBx90PIdg7Y5j10AI7d9VxPpZhv5H9QrMxfx?=
 =?us-ascii?Q?qcg1KGCf58h+LhtgiEbs7VrJLwdisuf4ZIKq2bS+Rhzouu3rcXFCAJRi3VD6?=
 =?us-ascii?Q?1gscuKnVWgeNcVT9vV0M559KQfgTLvteJSn/KDmlzRBH2DnGXGOeGxoOcgAA?=
 =?us-ascii?Q?8vEH73KmmfYuLCwSCHokTwflsVuCVtqrRmdAoEpReRZmKhvDnQD+racFoNHw?=
 =?us-ascii?Q?e8kS4WVkoV1uPR0b3U/mCN90?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a80e4c-b305-4445-a0bb-08d8f3c26792
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:56.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifa1kZL4zsZfIJkd/5wl6ZsDyg18LpL0kpGle0UYcTzWwESp0KWVwxzlopp3H2ivz9BBJHpzUvgG0vDj7B22qcAeUxOcBqSYWyjEim/F8gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: Pe5kuM0osdDCsxlB-Tn1S0aXPdH9LAEe
X-Proofpoint-GUID: Pe5kuM0osdDCsxlB-Tn1S0aXPdH9LAEe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Free the pages used to pass the preserved ranges to the new boot.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/mm/init_64.c |  1 +
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8efb2fb2a88b..69bd71996b8b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1294,6 +1294,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
+	pkram_cleanup();
 	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 8d3d780d9fe1..c2099a4f2004 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -102,9 +102,11 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 #ifdef CONFIG_PKRAM
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
+void pkram_cleanup(void);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
+static inline void pkram_cleanup(void) { }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index 03731bb6af26..dab6657080bf 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1434,3 +1434,23 @@ int __init pkram_merge_with_reserved(void)
 
 	return 0;
 }
+
+void __init pkram_cleanup(void)
+{
+	struct pkram_region_list *rl;
+	unsigned long next_pfn;
+
+	if (!pkram_sb || !pkram_reserved_pages)
+		return;
+
+	next_pfn = pkram_sb->region_list_pfn;
+
+	while (next_pfn) {
+		struct page *page = pfn_to_page(next_pfn);
+
+		rl = pfn_to_kaddr(next_pfn);
+		next_pfn = rl->next_pfn;
+		__free_pages_core(page, 0);
+		pkram_reserved_pages--;
+	}
+}
-- 
1.8.3.1

