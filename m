Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A2E5F38C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJCWWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJCWV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:21:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20719.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::719])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B47A52E70;
        Mon,  3 Oct 2022 15:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNEzxy7sq+zjY4yi63fDIpq8ydIV31lv6JXsbI1TrcMa6EOFj+77pOpihJFuwZ/aW1/dY61TtRm2PSY7hO9y2X67aUVK5xbXG+q6CywIYRloJ/+Aeic3N8E2UiC59KT6Etq7By7E8amjHXMxA9knlOfbshBgFQOvDSfQS8Dj0hIBZtePlgzIwh1JJcz4IAvU/DOEq5Sb/iD0z5Zd+ZsPyAiQ1cXfFyjGfeFriUNeZEj4+0anFxiCADgLABd9vt2J6sOGH3uTbaqUV24k7To6q9h4J3ebudJfoXgTfgy1sEoOJytz3M1oLQVsORVxGpdlsb3uu80dBSxwQqxEs32OmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X86Otev7IKDx9hRxK3rxtQT27APXJBerS/h/03ZrOs0=;
 b=e++yf0wwSz+zElwUT5YfD/SglcNuokwI//jKLKCXKt7Uy1w4AxmdOd8+t1pY+iRGX8iKRugWxvDgZODLQEeHjtxe6MITxHS3MUy4k2IMJ7uaeOT/AImmbliKOaM/yj1MxeREy7gDJEJkqZHbR0vwFPXONG1U/vpu3GFpHQtfy8iz0JBWUwFg8mmKvll4pPHzzAIIi6mRyK3eLnwed/miHPulVO8Z0O+dIlFDJVYj9ru4zZi8gOMcAfi/2xBEop1YAGLNPF3vl5sYR7fJwQIMlv54JKvDegIGAYyTyim4+hjeYK3MP6MR/8xgbqjnYf9+BTsj+T7PyTFpZ8Oke10PVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X86Otev7IKDx9hRxK3rxtQT27APXJBerS/h/03ZrOs0=;
 b=acifDe/t7CV9cSfuf/FWt9XeWFrsc+RXqlS8gFD34tpQAxOWMPnILsyt7oLxAc+vCKyr/dAByi0e+G3VhcDeLpvD+dFvViOhwWKDWb/MjMuf1jxWB+glMHHRz/YAA0YSIKTAF0VrdpeYulLnTaAJ8sM71p5TwqOj6MwCmvXTL5chVyioxZiFoBGB4i3bWyL2uX6EPY1rZJW2TmTIlIb2KoZ7Q/AXlpyxWmDMXc8xemyigQrXJEE4sF4Xth7BsCngrM5nGlTsbq3aQcLRklU5nmfBeI+T77i13cAuPfc/hbXe355eGq9rVk1INqnhCRFXGext453fbs+4z3u2vucrrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by MN2PR03MB4928.namprd03.prod.outlook.com (2603:10b6:208:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 22:21:55 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 22:21:55 +0000
From:   Ali Raza <aliraza@bu.edu>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        pbonzini@redhat.com, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu, Ali Raza <aliraza@bu.edu>
Subject: [RFC UKL 01/10] kbuild: Add sections and symbols to linker script for UKL support
Date:   Mon,  3 Oct 2022 18:21:24 -0400
Message-Id: <20221003222133.20948-2-aliraza@bu.edu>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003222133.20948-1-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|MN2PR03MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a490dc-2c22-4f67-10fe-08daa58dad75
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1IoOnRZ8XQ77dLzJtm8QOxLQIIOErDPb/P07yoyHNVrv3XEJ3mp8TJe7LbEyz+qg9Sp7JgI6w6otVRYJF8fK26gcCoFFiNPXNfc7G0uYGKpLZNUgoc9LhLL0Nal1G7O6T/Yxj5Bb87bWSPsqnj7fLGNo62C0s+t1PK55giFBMvFcpylHKWV9FYocAvnYSwL7d50+fhNLSgYcYPR7GQgZK3oxW3aLyJHWFT93XnBPkF439qTyhrwKrp9Q5Q+00flDAX8cIq6zfGsy/zk85oJeewzwjFikrWzcvBG2EO2z6sMSNYJHbhbMI8spNydwWNU5QU3tWu+33QMVX5GOJeImEpks5OTl5lRfPVnCp74y1ujN+Hu0zthuEo8fHYZ4CG0v17/V0sGcVjBmHf+LFzD9942cmYPKb2Q9F8Vr2/miga8nC2FYlEYIdBR5PcofLdLiXMUQ6DEYUpP8F4SQwo1CgA+vRRDvUTdltUm9UxOfeAO4icxgYQx1E2D73nmq9uaZlvOJie7nQ0cJZkFIWhYw7K0DdgcaEP8BoY8JqaqLu2FDZVeAl6hmp+Gwll25jrpW0QoFsmDU8bvkkzyfAQZKe0QtcTuLLM8CHlNoKZgHAK38NvNH34RMI/K7KhRN2QUwKG8fWnhTPLsTE8S4uzTHwuo+gsDxVXOFD4zpxFLNaPMWFBr80y/RuCTidEpa9GfKw6asseNjrXl/TB2k4MHYw1i8/+wL9uZY5Q18IKibtioNQoONfYqMTAWQasATXJ7e+2TGl4CtARYNmjBs4q6qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(8936002)(7406005)(41300700001)(6666004)(38350700002)(75432002)(66556008)(66476007)(4326008)(8676002)(1076003)(186003)(6512007)(2906002)(2616005)(66946007)(83380400001)(52116002)(6506007)(36756003)(5660300002)(7416002)(26005)(86362001)(41320700001)(6916009)(38100700002)(316002)(6486002)(478600001)(786003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJ9IXYJ1CYeov+FeZdjJHVboMY7rxHIY4leO37J5IZ9zaDl/yAn1OpAZSvTq?=
 =?us-ascii?Q?VPu70snnddy2TtUvq2VeNNArUdWdqqY5HUTyYEpr26hyxYhoA/82camQOypb?=
 =?us-ascii?Q?Xt9PRiUjEQMvMDL+cVwmpZNDZc04r8pv9tlZkxc1WCKo2xsN52bBgZ1Il/lB?=
 =?us-ascii?Q?gsmM2ryCEW/z0Uoaq2JEGXepCOD5+8GzpMOWaWMchfOj1vJ0zgJemHjoAsKH?=
 =?us-ascii?Q?9HFVRKKwYOToe3uq5ghc3BpgRFP4PvdAVFRZNUJDXSsndVTZwIpBUPoafHyp?=
 =?us-ascii?Q?aKwDytO37kBzcKDyVsS0xZCOG9DM4G16tJiPDhxhb1C0XqBYcMW9HeDxwr3N?=
 =?us-ascii?Q?Bfjp6o9FwaXH7Y5fwKEBo5B/L2o+sCYkoR/wCLqJt3IOwvQRy7fyi40n9g8Y?=
 =?us-ascii?Q?a62/h67Z4+LZqSrABjoxQvVzha7TQ0BqX1bfsdu7QuuNUaRF2f7SV0sR540N?=
 =?us-ascii?Q?zzbN4gtzOxpoCpNRnPMhNRWsvgwuehgeBjCcXQlCbYSldPy2waAE7bO/O2OR?=
 =?us-ascii?Q?y5k0vYTE5Y3sjr/NSaDcYZvRxWHL26KEwzmnQB6SLIlNldeGIvAyRMb1SZqR?=
 =?us-ascii?Q?xrYpeJsuJfi7xFgcKsY+snq6V2o8D2TsqRKZnHqlu8GjknWjVrDiYLnnFsqx?=
 =?us-ascii?Q?FuB7Tf5+VaO9CAgzra2NJPZfb7fMETpawJb5fhssrPBA4Xieds/dGocrFk12?=
 =?us-ascii?Q?TRHvtOhfeFshESw/rRLQ7l175oaV36yTAQblH7NaYfL0/vPvFwOi78s9y47X?=
 =?us-ascii?Q?YnavfVI4ILJVvSTUfr5nqjqZ46wH2oVDD+lPN/V3z/jMCaAANnPJ9qlGafOc?=
 =?us-ascii?Q?vFDLc9tOLzNGH1fvtcQh2u7zw6uzi7ex/WRwsQ8Ah89CLcNVMierxWEgEZqi?=
 =?us-ascii?Q?vk5EX7ZLbj2c1B0DXW5fNm9PAR6GG9yheCmFIf4pevCkAqbQ2os1Xazimmqa?=
 =?us-ascii?Q?e9H/uaDWORxlNVy6Cn7ukn5YiDxyBjOSAUX+Kt1tOVuy3bPx0gGN7fKDJH0h?=
 =?us-ascii?Q?nHQkvNQUf2N8cm/wyT1PLvgdgca5z4ziESycyZxdiF9EsHmtT1j3wUNPEw8A?=
 =?us-ascii?Q?McKXRcoOpoi/fOGdGNh0hlVzUuED/SS49iBz5dG2n0tcUFqoeuO5XEqTFP4t?=
 =?us-ascii?Q?7uTM6I9TlVWHILRgntR6adYJZ7tF5P1rCnHs7mCKICwIr13BV4rumplYzgM9?=
 =?us-ascii?Q?LIFN40eh3vOZ4Phg5R6bZgge2e1x6sTUGXXBcHDiR/X90s2iJAFhO3mLxqFI?=
 =?us-ascii?Q?Ho5PFZZj+SZKx/AQEsSaCgLmhQNd1zaNDAeBSWPZOE9dGlRRuR3RkdYAPnWj?=
 =?us-ascii?Q?uZGFZA/PsYc8n5M/NsqreLQ9eo0thOIJh7c3egOUcZsVpGRBqOHu9edHR6zE?=
 =?us-ascii?Q?EXCPKQdzawVn4p7OOYOMd6P5naHczlo9Tb/Zin4HjwU+KG4tltYNtzvbB7n3?=
 =?us-ascii?Q?nXoN17Jg0aAyfe9k94RyJi1nvLDaV7mkjtnKjtiIeob7sRNax81ZWk99D6ii?=
 =?us-ascii?Q?WlxiK/pgERHdFsm/wQ6RvjK+zkGH42bcqpd0wJ8PRMWYC6k84xz8RZEQwvB4?=
 =?us-ascii?Q?4nT2sNIEZJ2vcA6+LHVQn928lscW1+usyqp7+S9D?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a490dc-2c22-4f67-10fe-08daa58dad75
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 22:21:54.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oMxxwibxHRrDb64aFrGlIGckWcpGmEMjFpr5G+FQ+vvc+P8z2V9y4aoxwN7m1Jy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4928
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to link a user space executable we will need access to a few
section that are not normally used when linking the kernel.  Add these
sections when we have selected CONFIG_UNIKERNEL_LINUX.

Add case to not throw warnings for COMMON symbols from application code.

Make the KBUILD_VMLINUX_OBJS contain the application library when UKL is
enabled.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>

Co-developed-by: Thomas Unger <tommyu@bu.edu>
Signed-off-by: Thomas Unger <tommyu@bu.edu>
Co-developed-by: Matthew Boyd <mboydmcse@gmail.com>
Signed-off-by: Matthew Boyd <mboydmcse@gmail.com>
Co-developed-by: Eric B Munson <munsoner@bu.edu>
Signed-off-by: Eric B Munson <munsoner@bu.edu>
Co-developed-by: Ali Raza <aliraza@bu.edu>
Signed-off-by: Ali Raza <aliraza@bu.edu>
---
 Makefile                          |  4 ++
 arch/x86/kernel/vmlinux.lds.S     | 98 +++++++++++++++++++++++++++++++
 include/asm-generic/sections.h    |  4 ++
 include/asm-generic/vmlinux.lds.h | 32 +++++++++-
 scripts/mod/modpost.c             |  4 ++
 5 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8478e13e9424..d072a52ed856 100644
--- a/Makefile
+++ b/Makefile
@@ -1129,6 +1129,10 @@ KBUILD_VMLINUX_LIBS := $(patsubst %/,%/lib.a, $(libs-y))
 endif
 KBUILD_VMLINUX_OBJS += $(patsubst %/,%/built-in.a, $(drivers-y))
 
+ifdef CONFIG_UNIKERNEL_LINUX
+KBUILD_VMLINUX_OBJS += $(CONFIG_UKL_ARCHIVE_PATH)
+endif
+
 export KBUILD_VMLINUX_OBJS KBUILD_VMLINUX_LIBS
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
 # used by scripts/Makefile.package
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 15f29053cec4..cb8b33955969 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -101,6 +101,9 @@ jiffies = jiffies_64;
 
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
+#if defined(CONFIG_UNIKERNEL_LINUX) && defined(CONFIG_UKL_TLS)
+	tls PT_TLS FLAGS(6);            /* RW_ */
+#endif
 	data PT_LOAD FLAGS(6);          /* RW_ */
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_SMP
@@ -146,6 +149,71 @@ SECTIONS
 #endif
 	} :text =0xcccc
 
+#ifdef CONFIG_UNIKERNEL_LINUX
+	/* Added to preserve page alignment */
+	. = ALIGN(PAGE_SIZE);
+
+	/*  */
+	.rela.plt	:
+	{
+		*(.rela.plt)
+		PROVIDE_HIDDEN (__rela_iplt_start = .);
+		*(.rela.iplt)
+		PROVIDE_HIDDEN (__rela_iplt_end = .);
+	} :text =0xcccc
+	.preinit_array	:
+	{
+		PROVIDE_HIDDEN (__preinit_array_start = .);
+		KEEP (*(.preinit_array))
+		PROVIDE_HIDDEN (__preinit_array_end = .);
+	} :text =0xcccc
+	.init_array	:
+	{
+		PROVIDE_HIDDEN (__init_array_start = .);
+		KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
+		KEEP (*(.init_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o
+			*crtend.o *crtend?.o ) .ctors))
+		PROVIDE_HIDDEN (__init_array_end = .);
+	} :text =0xcccc
+	.fini_array	:
+	{
+		PROVIDE_HIDDEN (__fini_array_start = .);
+		KEEP (*(SORT_BY_INIT_PRIORITY(.fini_array.*) SORT_BY_INIT_PRIORITY(.dtors.*)))
+		KEEP (*(.fini_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o
+			*crtend.o *crtend?.o ) .dtors))
+		PROVIDE_HIDDEN (__fini_array_end = .);
+	} :text =0xcccc
+	.ctors		:
+	{
+		/* gcc uses crtbegin.o to find the start of
+		   the constructors, so we make sure it is
+		   first.  Because this is a wildcard, it
+		   doesn't matter if the user does not
+		   actually link against crtbegin.o; the
+		   linker won't look for a file to match a
+		   wildcard.  The wildcard also means that it
+		   doesn't matter which directory crtbegin.o
+		   is in.  */
+		KEEP (*crtbegin.o(.ctors))
+		KEEP (*crtbegin?.o(.ctors))
+		/* We don't want to include the .ctor section from
+		   the crtend.o file until after the sorted ctors.
+		   The .ctor section from the crtend file contains the
+		   end of ctors marker and it must be last */
+		KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .ctors))
+		KEEP (*(SORT(.ctors.*)))
+		KEEP (*(.ctors))
+	} :text =0xcccc
+	.dtors		:
+	{
+		KEEP (*crtbegin.o(.dtors))
+		KEEP (*crtbegin?.o(.dtors))
+		KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .dtors))
+		KEEP (*(SORT(.dtors.*)))
+		KEEP (*(.dtors))
+	} :text =0xcccc
+#endif
+
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
@@ -208,6 +276,29 @@ SECTIONS
 
 	. = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
 
+#ifdef CONFIG_UNIKERNEL_LINUX
+#ifdef CONFIG_UKL_TLS
+	/* Thread Local Storage sections */
+	. = ALIGN(PAGE_SIZE);
+	.tdata : ALIGN(0x200000){
+		__tls_data_start = .;
+		*(.tdata .tdata.* .gnu.linkonce.td.*)
+		__tls_data_end = .;
+	} :tls
+	.tbss : {
+		__tls_bss_start = .;
+		*(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon)
+		__tls_bss_end = .;
+	} :tls
+#else
+	. = ALIGN(PAGE_SIZE);
+	__tls_data_start = .;
+	__tls_data_end = .;
+	__tls_bss_start = .;
+	__tls_bss_end = .;
+#endif
+#endif
+
 	/* Init code and data - will be freed after init */
 	. = ALIGN(PAGE_SIZE);
 	.init.begin : AT(ADDR(.init.begin) - LOAD_OFFSET) {
@@ -380,8 +471,13 @@ SECTIONS
 		*(BSS_MAIN)
 		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
+#ifdef CONFIG_UNIKERNEL_LINUX
+	}
+	__bss_stop = .;
+#else
 		__bss_stop = .;
 	}
+#endif
 
 	/*
 	 * The memory occupied from _text to here, __end_of_kernel_reserve, is
@@ -446,6 +542,7 @@ SECTIONS
 #endif
 	       "Unexpected GOT/PLT entries detected!")
 
+#ifndef CONFIG_UNIKERNEL_LINUX
 	/*
 	 * Sections that should stay zero sized, which is safer to
 	 * explicitly check instead of blindly discarding.
@@ -469,6 +566,7 @@ SECTIONS
 		*(.rela.*) *(.rela_*)
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
+#endif
 }
 
 /*
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index db13bb620f52..42ebf251903c 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -35,6 +35,10 @@
 extern char _text[], _stext[], _etext[];
 extern char _data[], _sdata[], _edata[];
 extern char __bss_start[], __bss_stop[];
+#ifdef CONFIG_UNIKERNEL_LINUX
+extern char __tls_data_start[], __tls_data_end[];
+extern char __tls_bss_start[], __tls_bss_end[];
+#endif
 extern char __init_begin[], __init_end[];
 extern char _sinittext[], _einittext[];
 extern char __start_ro_after_init[], __end_ro_after_init[];
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7c90b1ab3e00..4b0e4f3d4c39 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -568,6 +568,24 @@
  * code elimination is enabled, so these sections should be converted
  * to use ".." first.
  */
+#ifdef CONFIG_UNIKERNEL_LINUX
+#define TEXT_TEXT							\
+		ALIGN_FUNCTION();					\
+		*(.text.hot .text.hot.*)				\
+		*(TEXT_MAIN .text.fixup)				\
+		*(.stub .text.* .gnu.linkonce.t.*)			\
+		*(.text.unlikely .text.*_unlikely .text.unlikely.*)	\
+		*(.text.exit .text.exit.*)				\
+		*(.text.startup .text.startup.*)			\
+		*(.text.unknown .text.unknown.*)			\
+		NOINSTR_TEXT						\
+		*(.text..refcount)					\
+		*(.ref.text)						\
+		*(.text.asan.* .text.tsan.*)				\
+		TEXT_CFI_JT						\
+	MEM_KEEP(init.text*)						\
+	MEM_KEEP(exit.text*)
+#else
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.hot .text.hot.*)				\
@@ -580,7 +598,8 @@
 		*(.text.asan.* .text.tsan.*)				\
 		TEXT_CFI_JT						\
 	MEM_KEEP(init.text*)						\
-	MEM_KEEP(exit.text*)						\
+	MEM_KEEP(exit.text*)
+#endif
 
 
 /* sched.text is aling to function alignment to secure we have same
@@ -1029,12 +1048,23 @@
 	/* ld.bfd warns about .gnu.version* even when not emitted */	\
 	*(.gnu.version*)						\
 
+#ifdef CONFIG_UNIKERNEL_LINUX
+#define DISCARDS							\
+	/DISCARD/ : {							\
+	EXIT_DISCARDS							\
+	EXIT_CALL							\
+	COMMON_DISCARDS							\
+	*(.gnu.glibc-stub.*)						\
+	*(.gnu.warning.*)						\
+	}
+#else
 #define DISCARDS							\
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
 	COMMON_DISCARDS							\
 	}
+#endif
 
 /**
  * PERCPU_INPUT - the percpu input sections
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2c80da0220c3..a6023db6b630 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -626,6 +626,8 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 	case SHN_COMMON:
 		if (strstarts(symname, "__gnu_lto_")) {
 			/* Should warn here, but modpost runs before the linker */
+		} else if (strstarts(symname, "ukl_")) {
+			/* User code can have common symbols */
 		} else
 			warn("\"%s\" [%s] is COMMON symbol\n", symname, mod->name);
 		break;
@@ -774,6 +776,8 @@ static const char *const section_white_list[] =
 	".fmt_slot*",			/* EZchip */
 	".gnu.lto*",
 	".discard.*",
+	".gnu.warning.*",
+	".gnu.glibc-stub.*",
 	NULL
 };
 
-- 
2.21.3

