Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79407B060A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjI0OD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjI0ODY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:03:24 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17B511D;
        Wed, 27 Sep 2023 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jeZoJNj3DCve0zLnDradealBpu4fQiYUevBJ8HVNHI=;
 b=7ZtNi6modLeQ+Yr/N4wT/5W6lAcz1UtNtX6xJMPFl+rKelt9CGXY7fgMesOofLcL8aVJjFADB3JtdxitEGyzOIXxxfnhIPdctQuzmcRx3uzO3DtUrWy5IuQpzt2+NU9b6LM8MmrSJC5xGqR1v1IWqIir6H+eYVXQ7hJiSDZlp+Y=
Received: from AS9PR04CA0096.eurprd04.prod.outlook.com (2603:10a6:20b:50e::26)
 by AM8PR08MB6610.eurprd08.prod.outlook.com (2603:10a6:20b:36a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 14:03:16 +0000
Received: from AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:50e:cafe::7e) by AS9PR04CA0096.outlook.office365.com
 (2603:10a6:20b:50e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT036.mail.protection.outlook.com (100.127.140.93) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 14:03:14 +0000
Received: ("Tessian outbound ab4fc72d2cd4:v211"); Wed, 27 Sep 2023 14:03:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f324b05c154a856d
X-CR-MTA-TID: 64aa7808
Received: from a10bfef047fc.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B8ADBD8E-3C9F-4822-B815-164669FEEACB.1;
        Wed, 27 Sep 2023 14:01:51 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a10bfef047fc.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZ1NghPCNkDzOWaMD3uX+tWFNV/JnAt8Hj4bN513bF52EiVdR8qjHXSPMaQaXvX6bCvueUqj7lsx9bhmG6uMDKQum0Q3HFk4d6QgnYwbQ8FA+Og7aSR0aikJ5PNjtFVUUJ6jUGgnc0KasqlququR5vYQLTf0ugSKm2s5jRph+0iUGoOADQj5B1/ICaj3g0yoH+uAYKR6wcrYJxPqwKyZEvd41rzI0PBdwtQ4HjOTDrkrZDDj1bRVZsrVNkOh1YeJmoz+aY2C9BWGV0IfvyMyxo3XIEY4zhJzKmHi+J3HC7vy5l1NrXpnZO281HdEHztv1RbyuCxpGDsxtxgw2zjPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jeZoJNj3DCve0zLnDradealBpu4fQiYUevBJ8HVNHI=;
 b=TD2sV0q0KmZggk7gig/OAqX7zOD/fvAGIGl4uzNrkdee20Wi1o5xHI4dI90kWw4CJ/Chl5z2daiJmkEXHTatOWNhjSkfKz/MIgZdjXuxDK5TT5hJkcU7OBpnRuPQ1fBGLIigfRk02s/3k7fn4qMcw4TR3GOdM+4pmJRfFeHncAfB/5jFiq7zpbux3p0PUmrrHlGlOWrpv0mlESK4/j6DrkAz7qZ6awxhnLBLtsfg23uRXWiP1Sk9ZCEus12BdHtYRr8uiR46+jZYX5YL2TabS1WJ/37W422Qy/kR55ZKMasqxA8UB0Hu3IDxTzhDLXuBGwSZh9XYjB60wTjdnJ8YPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jeZoJNj3DCve0zLnDradealBpu4fQiYUevBJ8HVNHI=;
 b=7ZtNi6modLeQ+Yr/N4wT/5W6lAcz1UtNtX6xJMPFl+rKelt9CGXY7fgMesOofLcL8aVJjFADB3JtdxitEGyzOIXxxfnhIPdctQuzmcRx3uzO3DtUrWy5IuQpzt2+NU9b6LM8MmrSJC5xGqR1v1IWqIir6H+eYVXQ7hJiSDZlp+Y=
Received: from AM7PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:20b:100::15)
 by AM8PR08MB5666.eurprd08.prod.outlook.com (2603:10a6:20b:1de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 14:01:48 +0000
Received: from AM7EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:100:cafe::4d) by AM7PR02CA0005.outlook.office365.com
 (2603:10a6:20b:100::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT030.mail.protection.outlook.com (100.127.140.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Wed, 27 Sep 2023 14:01:48 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:38 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:38 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <nd@arm.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <catalin.marinas@arm.com>,
        <dave.hansen@linux.intel.com>, <joey.gouly@arm.com>,
        <maz@kernel.org>, <oliver.upton@linux.dev>, <shuah@kernel.org>,
        <will@kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 09/20] arm64: define VM_PKEY_BIT* for arm64
Date:   Wed, 27 Sep 2023 15:01:12 +0100
Message-ID: <20230927140123.5283-10-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT030:EE_|AM8PR08MB5666:EE_|AM7EUR03FT036:EE_|AM8PR08MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a7c984-aca1-461f-356e-08dbbf627e12
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jsMJfLYrUQXbs1koVzHyY3RDkn7JQaMLZIogET6oAFR/U69G8LlYE3PkEST/+o8jd7oN1KRQXsGGWOAQIMxTtB66Bq7EJSos1FI3cyQEq0wunYUK2L5j4u3c+szUJCC4BgFp1FzfuOQ9pGqWu/VCyL9AaK1s3GGOkSLrqR9g9dyhLy1O9gGOUOIz/ugxU8qblMTlBn3gxRHxiTS8JRToUUrU4ryjTvH+WXhP3wTSCfMJ0Z0QbfyvgP20iIB9knjpCabfcYo3y8dXdgWOanvNiY+CCR/8AxeHw0lfQm/JGQLzD2Am5wpc/LPiXJVb96iniWKw8o9aVE/Hpy8P8Ceu76DXENoCFevRbXPoP/ol2u0Dd/4VOoCVHyEvZXXCW8Z5UgtM0I6CkXmlj7nzOF1XAlGuu8jv//1X2DjgGAdP+HeHl8h6gPvLSIe7SteZMrsc1xIu5itjI200viv1PYb/tx6SzmxvwyQdBD78f5pBpH7ErcRH2/v2KIYwaQcRCb+2FEGJi+YSBrrXJ3JviSGTuteqmxzaLUhGY+rwbXYVllZXGMRV2bCw+qMujzWvhxx92U1mAKecdl/XjxURElgsiF4M+kkgCZtZkb/HCRNRVUDJB3tMRAROGqgZERXBtHatlzd6gAnUkaq2WNpy6TiBEU13JPx/2j70CBhq4tV7qXsFloZzhobSwCX0kM+D1Kg67F9bUhFAqy6ZScCoWliFrPwfJUVnOUnzq62hKnnBPT4hm4FM94ssiKPFafRoat7gXZ0tb8agreaPoc4fj8qKEw==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(7696005)(6666004)(478600001)(2906002)(83380400001)(336012)(426003)(1076003)(2616005)(7416002)(316002)(40480700001)(8676002)(6916009)(70206006)(8936002)(70586007)(41300700001)(44832011)(54906003)(5660300002)(4326008)(36756003)(47076005)(36860700001)(82740400003)(81166007)(356005)(86362001)(26005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5666
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8bab5f68-6dfa-4da5-0cbd-08dbbf624abc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lYLdt3dK++8rlpr5lIgNLmrNpqwcssY26WJHhTSHUyKNVc7gE80qJmpOFuR5k2E4EGayE/rnsfRwQB18W0ToIpyu+2e43piHpB3mZ5eRPSw7oObXBVz6aNe8B2AGpPXj6TxQ96Ed0YTD3wFgjnBguvkrjUdD857ZrBkkTR+BMn5RSKIZAjzCRliob80a2/8dIesiCpuRlhFPx7KIRi9IoGQ+Dopxjc1lqaqHaq/iYXGQK08m7yudCRaoCstNmMes3l0lDnhrOHHfZUa1PCcIWJO0glkEa199ExJgxqexstHV+et0tmgur66S/Y+kEDZShmpEXfQwxHd6hyhR3qQlyJ7uKFfLZnX84RMx/+L8jXdIHpNgK1kron9cdKG1VUi4JITDDJtRYomZX0xWTT30KmOXRSsdm7iIP6XcJMr9hsICmvRNYewI0DvDwNMArfqJGCGbcKek/YQzJgBnwYpAl4cyTCruyCYqR5Bv1v55BLta6GIMRlPRcP/NR/LmHC9z18ER7RYIMlLfxCaeTFRXOJjnhe5Dd0FrcXxdmX34y9wext9Ht7Bjg88kgBcK5A60FDiKVmUK25LLNEL8x1oGI9Rmbi1krtMp2F3oFujPRF8rAfz88obrGfkQspF83h96CIWClruqYiW8ojnqWv2z2A2+lqLg0YydqXvQmiFQ4xtTFsJ362H6JaN7jhq8imuj1gZSBuQO1/1WKbn9YTW5OF6NCsx38zgDQbt+ay+6XQkPEP+CwKpodlF7WhztyUG
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(26005)(426003)(2616005)(1076003)(44832011)(8936002)(5660300002)(6862004)(4326008)(8676002)(450100002)(82740400003)(81166007)(36860700001)(7696005)(47076005)(478600001)(6666004)(336012)(41300700001)(316002)(54906003)(70206006)(40480700001)(70586007)(86362001)(2906002)(40460700003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:03:14.4942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a7c984-aca1-461f-356e-08dbbf627e12
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6610
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define the VM_PKEY_BIT* values for arm64, and convert them into the arm64
specific pgprot values.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mman.h |  6 +++++-
 arch/arm64/mm/mmap.c          |  7 +++++++
 fs/proc/task_mmu.c            |  2 ++
 include/linux/mm.h            | 11 ++++++++++-
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..22de55518913 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -7,7 +7,7 @@
 #include <uapi/asm/mman.h>
 
 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
-	unsigned long pkey __always_unused)
+	unsigned long pkey)
 {
 	unsigned long ret = 0;
 
@@ -17,6 +17,10 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 	if (system_supports_mte() && (prot & PROT_MTE))
 		ret |= VM_MTE;
 
+	ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
+	ret |= pkey & 0x2 ? VM_PKEY_BIT1 : 0;
+	ret |= pkey & 0x4 ? VM_PKEY_BIT2 : 0;
+
 	return ret;
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 8f5b7ce857ed..ef75b04f9d02 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -98,6 +98,13 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)
 	if (vm_flags & VM_MTE)
 		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
 
+	if (vm_flags & VM_PKEY_BIT0)
+		prot |= PTE_PO_IDX_0;
+	if (vm_flags & VM_PKEY_BIT1)
+		prot |= PTE_PO_IDX_1;
+	if (vm_flags & VM_PKEY_BIT2)
+		prot |= PTE_PO_IDX_2;
+
 	return __pgprot(prot);
 }
 EXPORT_SYMBOL(vm_get_page_prot);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3dd5be96691b..fcd94a39bb30 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -689,7 +689,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT0)]	= "",
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
+#if VM_PKEY_BIT3
 		[ilog2(VM_PKEY_BIT3)]	= "",
+#endif
 #if VM_PKEY_BIT4
 		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..43d96c925b9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -328,7 +328,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
-#ifdef CONFIG_ARCH_HAS_PKEYS
+#if defined(CONFIG_ARCH_HAS_PKEYS) && !defined(CONFIG_ARM64)
 # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
 # define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
@@ -341,6 +341,15 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
+#if defined(CONFIG_ARM64)
+# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_2
+# define VM_PKEY_BIT0	VM_HIGH_ARCH_2	/* A protection key is a 3-bit value on arm64 */
+# define VM_PKEY_BIT1	VM_HIGH_ARCH_3
+# define VM_PKEY_BIT2	VM_HIGH_ARCH_4
+# define VM_PKEY_BIT3	0
+# define VM_PKEY_BIT4	0
+#endif
+
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 /*
  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
-- 
2.25.1

