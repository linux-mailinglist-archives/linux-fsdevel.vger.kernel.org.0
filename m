Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CBD34F32E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhC3V1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51210 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhC3V1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULP4EA145279;
        Tue, 30 Mar 2021 21:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=5gs3kt58j9UHE+if8NBT4rT44pX3k6PV7VfaMeNhiWw=;
 b=cqvkyZE4IhinoTwc7pt0xiI1K0bYprXLSttf7cvCemG9SzXQlWtuAF+QWCvTICBZd4iX
 JG95kTeVZg7LRR+WBNYlaSAzs5NCGKmOrPHuiDmpF7pPS246cShX/00+MSypHWzL9bmL
 Iuq3nCiu0pmHuEWOD33YhmikiMHOcTFO3VeIyoMVjRGCiSGJoSsrlW2XBcxR/MkqsGCe
 u2IZ4RAVnrUGTahinKNRegXw58HDN0NmumclCWgKMDrWqKkv7YvNG7PKe/05mTXlX6th
 TA0Dx2avnI75DdCmVKi0KLKZCBiv53cYtDBsWslDL8I89s3NRwpB+RdUjGbMJifMkyPX Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37mad9r8g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOmHt183931;
        Tue, 30 Mar 2021 21:26:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 37mac7u4nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHuCN3PChu9hQWew/mcj3ugwv2uZ0BdGqa7NinqLrfJZn/6X7w2oH/l0MmAkn5AoRlOEzWyC/nZe/IG+sIc+kDnxrhwoZ7U9aQUcHvw4XrU1gv/THGBlw3mAU5K4aEVAMfzA01cdkkSV2UEjWfNfPhDTRPgqjtrpl9+U4QX5SWcEfZ2LVMenYguGcSPn6vLS9nqP4/aBfIYRPTiRbnfNXt5FXbvmewT/9b76/VZuUhVWSJaVWGbzigtP0Uj02Cuq0KcC0oBZRZJoKlI6UCHvEn8ND2VCesMygmv4GNE5alxh2gZetv1NdYXlBfjJ/3fZVhVLo8WPwLtBMYBUu+cvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gs3kt58j9UHE+if8NBT4rT44pX3k6PV7VfaMeNhiWw=;
 b=XKp2mCpw8nLcOfBsKpw97N3TcdgJL+Sho3DGKT7MgU6o96xlRU5WRDnIfhIc6etfsZ83p3IUYUqC+U+lGyrP08MyyDPfaioRL3UPOdOk4PeQhNT6T1fs0mJoQOOm1qPSkzmvBXPXwxQ+H0AvtyEObXCNdHyUt4JHOQJTimaoRKKfiadMUMryFZ7oX4IeQGIYjX4Q8XHYCx1tWMYGUqI7wrGD8cKciJumwNXbfyWgjooV7DHKLpB7P4mMYYF68X1juaSJh+AIp4ScAnRJcMexQyeJU3IuG+t6194FKkXiD15ylUx05xUGCwQohyx98x9P65H1NWPstBgWSwtHM0glNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gs3kt58j9UHE+if8NBT4rT44pX3k6PV7VfaMeNhiWw=;
 b=NXEEMxPP4G5vT9nsmqj+S+m0SNYcQARtOhuaEaNGLAhraSDG64py2TGpMyBqD9lTOAKmXDZOtyN1Dhx++ONdvfMv9P9wDJTYtngV1md/bTsLUJ7wXETakhsqq1oiF8fjGeMveVN2Hhc52k6wSBBtwnNV+Zh+hI2xKQy11+K3/tQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3600.namprd10.prod.outlook.com (2603:10b6:208:114::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:26:30 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:30 +0000
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
Subject: [RFC v2 21/43] x86/KASLR: PKRAM: support physical kaslr
Date:   Tue, 30 Mar 2021 14:35:56 -0700
Message-Id: <1617140178-8773-22-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ca0fedb-bfa2-42e4-4f3b-08d8f3c27c31
X-MS-TrafficTypeDiagnostic: MN2PR10MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB360027D0AA616F245017FC63EC7D9@MN2PR10MB3600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HZHZeizw7fGjde36AqABFq5MkOakfXE1/Uvg6KbBOk3M8TEJNhdFucyJ2YB72ecLeJHD1em2xoRVztOhITSVN6mnLAmjCHSM553GWgP89v2Y+u56IpMvOU2sAmvCFB+7SGOqi7tZBSehMdyHHpVAKJ8GhwGSq55AHESs7BjZ+LetNl80bmbdRfa+CNc3N1u1KHfto6LxlaXUUDG7m3HBOQDg4UZIu45z8JE+vtDKSG1CZ/gYglmBsECc/0I3LuhdsDfrNA3/yVKjpBSN0MD2kE61nJIfW7L/1RlpFREd6VaWRALkkQYsnrqMBu0zoH9XJahbfyxr0TP3gd3aV27uyh7QV8JoN12n0Y1QwN/b/4yad7xRSunDy6kPw3SKl0huXzhKlM8P1bE8rhxyvzog9+l1qos8uBuKkrtAbe2sWw2LPCt7DQodh5ou5anRhNNpP0dG+2uKeN0hMCowoWjz+oEsW+wziGyb2OwhI53rjJ4a2XpsQTHZnVspQqunfq3xWKjiZ7WB9Aid/Vrb/2aKck1Tt3akMl71C70VSG42YTVnXoJl+fFFKkxLgLbwVAGVYzEUMBDH6K7cK9zoCJQ+Ym0upnUFLmHeZRk5UQf2SnlXFuwBjZdBq6JlaN1r46EMxPaL05K78W+8XCzkD7c/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(6666004)(7696005)(316002)(36756003)(44832011)(8936002)(2616005)(956004)(5660300002)(16526019)(186003)(4326008)(6486002)(86362001)(38100700001)(83380400001)(26005)(66476007)(7406005)(7416002)(66556008)(8676002)(478600001)(52116002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xkgSBQsdp+OWdaNLjlR0zWKuROZQzqHjAK4ETlGY72ojit/WtQS/8bruVXEm?=
 =?us-ascii?Q?66BF+mPsE0u/gtmBSNvt8HTZ20NR4H5bPZmQ9L8w4UBykfTrtUhoQk73juxn?=
 =?us-ascii?Q?Z9uWQl+Idi2SWjt+4upXHiPtB0ZQDKboyEIAeJRw+u0SBomKXcmV9HCs7+4u?=
 =?us-ascii?Q?sP8IM8nx1PnVm6y6Dlq/eKN/IRoNabP3bCMz1si8yGNZsUlRXiG3vlT3ugyX?=
 =?us-ascii?Q?QGC70nyqYM7xh1sO+4+DRysePNSLo5wwgOUIe8wCh2A6kfdHL2uWuNo12+vw?=
 =?us-ascii?Q?gdH2OENv9aqg1JE0SdWdGMw9bIr56n5vMBLju8oxRpK7iYbdoU43Q+udcnye?=
 =?us-ascii?Q?KAq5NkzBxF4CHsgAcwpQ7lWzpFRe5kOcbU5VJ3J6DINJjmaCaQdfgKNnhbi+?=
 =?us-ascii?Q?NQzXJKZ2DxNORJi0SmnPo0fdnF7s/hNJEBs0QWNbUJaZiKidg1p+IxZK+9Ej?=
 =?us-ascii?Q?zOnFsy3MOerQIOvwZMQrBVn8J2pxxtE+MiD07og723/k124UDOaERq9RGgGP?=
 =?us-ascii?Q?QmiJxG2tSy0NSl09awhuvinQS3OPZV5fxu5GgVeP/SIuY0nePURxHR/4cg7I?=
 =?us-ascii?Q?z/DrArsBVdGFDmBlSyWFL3uMiKEh7TyP/vIZ+LyW1b83umFgyaptwUxGKmY1?=
 =?us-ascii?Q?KPyuemWpxmfbdRzKDijB+ArmnUfO9WHQSWOSFZUFjOdt5E+nL80Ea8Dqf4Dg?=
 =?us-ascii?Q?+HWFU0kGshhwmn5mE1tfQeDnHLv9kzBTqyg5joL0zgAcLvXL6gomBh2INumG?=
 =?us-ascii?Q?kDu7VOBxcXv8be9+okZr5jiZTHD2lCcob1QpjYue45hFKIErCXzT7zwDiyYb?=
 =?us-ascii?Q?ReZXabXDjv5dVPR6nzAlRHOPzxVN8L0qqcRZm49VHAWGP9n37KO8GEEMs/i6?=
 =?us-ascii?Q?K8IjYagVQNCEcLBCnnKWL3SsCWF7IGT45DX2mVhucfBbVNGVI2zDoY7pTY5M?=
 =?us-ascii?Q?Bn3DixRzLFeU9dI09PCYarAkWqIz4rVc/1PbWQfW82YDc9eib/auEff/Ry0K?=
 =?us-ascii?Q?IDKX9vKoGUy5PC+cdZyoNizDkohK6Lk+gLnfGzpOMFyYyHFY1g5WO6+akPwl?=
 =?us-ascii?Q?8b6Qy7KjRJtsrdMqyS/tOGLgcVBMmSrvyqcI94vId4C6qosFtcbu749t3fIZ?=
 =?us-ascii?Q?DRARfP8w/+LFuXI6u4RNl7Vvdp3ayHCgOTOUMWoPTaiWesU8xi9xHZG01fmC?=
 =?us-ascii?Q?2qOgRBlodBaW5kNBhs3tMVf5WRwoWXbpf8J1/csDtvlIR+4cSPoS6wsiAKFE?=
 =?us-ascii?Q?6wycYT0f3fHWY415wtrl53X3Di0k4ES78Osida/pqfm+6jH+1pBBxjWD/lJc?=
 =?us-ascii?Q?lzhdtOJqzT8S9fwENoEqylS5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca0fedb-bfa2-42e4-4f3b-08d8f3c27c31
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:30.7415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDashneOTBdN/vrdiqbxGCCf25XO7nrV7Yt0WLm3Hdj3f8fM2NS2cXB59kRiDkJx9cMAyxJP1le68Fy2ko5/PbkmsFbHQ63vHTDxzsqXDFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3600
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: B8bb_ymWzzcEVCO5qZuiU-DZA_fkOWZ_
X-Proofpoint-GUID: B8bb_ymWzzcEVCO5qZuiU-DZA_fkOWZ_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid regions of memory that contain preserved pages when computing
slots used to select where to put the decompressed kernel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/boot/compressed/Makefile |   3 ++
 arch/x86/boot/compressed/kaslr.c  |  10 +++-
 arch/x86/boot/compressed/misc.h   |  10 ++++
 arch/x86/boot/compressed/pkram.c  | 109 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/boot/compressed/pkram.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e0bc3988c3fa..ef27d411b641 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -93,6 +93,9 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev-es.o
+ifdef CONFIG_RANDOMIZE_BASE
+	vmlinux-objs-$(CONFIG_PKRAM) += $(obj)/pkram.o
+endif
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b92fffbe761f..a007363a7698 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -440,6 +440,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 	struct setup_data *ptr;
 	u64 earliest = img->start + img->size;
 	bool is_overlapping = false;
+	struct mem_vector avoid;
 
 	for (i = 0; i < MEM_AVOID_MAX; i++) {
 		if (mem_overlaps(img, &mem_avoid[i]) &&
@@ -453,8 +454,6 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 	/* Avoid all entries in the setup_data linked list. */
 	ptr = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
 	while (ptr) {
-		struct mem_vector avoid;
-
 		avoid.start = (unsigned long)ptr;
 		avoid.size = sizeof(*ptr) + ptr->len;
 
@@ -479,6 +478,12 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 		ptr = (struct setup_data *)(unsigned long)ptr->next;
 	}
 
+	if (pkram_has_overlap(img, &avoid) && (avoid.start < earliest)) {
+		*overlap = avoid;
+		earliest = overlap->start;
+		is_overlapping = true;
+	}
+
 	return is_overlapping;
 }
 
@@ -840,6 +845,7 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
+	pkram_init();
 	boot_params->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 901ea5ebec22..f8232ffd8141 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -116,6 +116,16 @@ static inline void console_init(void)
 { }
 #endif
 
+#ifdef CONFIG_PKRAM
+void pkram_init(void);
+int pkram_has_overlap(struct mem_vector *entry, struct mem_vector *overlap);
+#else
+static inline void pkram_init(void) { }
+static inline int pkram_has_overlap(struct mem_vector *entry,
+				    struct mem_vector *overlap);
+{ return 0; }
+#endif
+
 void set_sev_encryption_mask(void);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/boot/compressed/pkram.c b/arch/x86/boot/compressed/pkram.c
new file mode 100644
index 000000000000..60380f074c3f
--- /dev/null
+++ b/arch/x86/boot/compressed/pkram.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "misc.h"
+
+#define PKRAM_MAGIC		0x706B726D
+
+struct pkram_super_block {
+	__u32	magic;
+
+	__u64	node_pfn;
+	__u64	region_list_pfn;
+	__u64	nr_regions;
+};
+
+struct pkram_region {
+	phys_addr_t base;
+	phys_addr_t size;
+};
+
+struct pkram_region_list {
+	__u64	prev_pfn;
+	__u64	next_pfn;
+
+	struct pkram_region regions[0];
+};
+
+#define PKRAM_REGIONS_LIST_MAX \
+	((PAGE_SIZE-sizeof(struct pkram_region_list))/sizeof(struct pkram_region))
+
+static u64 pkram_sb_pfn;
+static struct pkram_super_block *pkram_sb;
+
+void pkram_init(void)
+{
+	struct pkram_super_block *sb;
+	char arg[32];
+
+	if (cmdline_find_option("pkram", arg, sizeof(arg)) > 0) {
+		if (kstrtoull(arg, 16, &pkram_sb_pfn) != 0)
+			return;
+	} else
+		return;
+
+	sb = (struct pkram_super_block *)(pkram_sb_pfn << PAGE_SHIFT);
+	if (sb->magic != PKRAM_MAGIC) {
+		debug_putstr("PKRAM: invalid super block\n");
+		return;
+	}
+
+	pkram_sb = sb;
+}
+
+static struct pkram_region *pkram_first_region(struct pkram_super_block *sb, struct pkram_region_list **rlp, int *idx)
+{
+	if (!sb || !sb->region_list_pfn)
+		return NULL;
+
+	*rlp = (struct pkram_region_list *)(sb->region_list_pfn << PAGE_SHIFT);
+	*idx = 0;
+
+	return &(*rlp)->regions[0];
+}
+
+static struct pkram_region *pkram_next_region(struct pkram_region_list **rlp, int *idx)
+{
+	struct pkram_region_list *rl = *rlp;
+	int i = *idx;
+
+	i++;
+	if (i >= PKRAM_REGIONS_LIST_MAX) {
+		if (!rl->next_pfn) {
+			debug_putstr("PKRAM: no more pkram_region_list pages\n");
+			return NULL;
+		}
+		rl = (struct pkram_region_list *)(rl->next_pfn << PAGE_SHIFT);
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
+int pkram_has_overlap(struct mem_vector *entry, struct mem_vector *overlap)
+{
+	struct pkram_region_list *rl;
+	struct pkram_region *r;
+	int idx;
+
+	r = pkram_first_region(pkram_sb, &rl, &idx);
+
+	while (r) {
+		if (r->base + r->size <= entry->start) {
+			r = pkram_next_region(&rl, &idx);
+			continue;
+		}
+		if (r->base >= entry->start + entry->size)
+			return 0;
+
+		overlap->start = r->base;
+		overlap->size = r->size;
+		return 1;
+	}
+
+	return 0;
+}
-- 
1.8.3.1

