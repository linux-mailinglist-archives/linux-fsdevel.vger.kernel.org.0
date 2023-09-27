Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046747B0617
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjI0OEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjI0OEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:04:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B5C10A;
        Wed, 27 Sep 2023 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I92rNNx5TqEbey9j1hFMnq7mlmwNIJKGHIEaPtAbF4=;
 b=H8Hg7w6AF7OPMaH+VaipT3jPK1K42vvXg9JCuSTzC5i+dlyDofwHIRXQ1MY6ps6b4izIMs4y2glSN78wCOJ2usso3fI3pSxP5BSghuSEHnAcA/aCriehlgQxZoHVEEX9Ic/he40x7j/rjE7ltloJZR2dBBofJ21TkuScg6CXr8Y=
Received: from AM0PR07CA0022.eurprd07.prod.outlook.com (2603:10a6:208:ac::35)
 by AS8PR08MB6056.eurprd08.prod.outlook.com (2603:10a6:20b:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 14:04:09 +0000
Received: from AM7EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:ac:cafe::4) by AM0PR07CA0022.outlook.office365.com
 (2603:10a6:208:ac::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT048.mail.protection.outlook.com (100.127.140.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 14:04:09 +0000
Received: ("Tessian outbound ab4fc72d2cd4:v211"); Wed, 27 Sep 2023 14:04:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ce9f6ca37187b3a7
X-CR-MTA-TID: 64aa7808
Received: from d2cae1e84635.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 50FED27A-8C4C-4666-BC8E-587532D495E0.1;
        Wed, 27 Sep 2023 14:01:55 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d2cae1e84635.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zlto4wgR4Gv99odT4ptsR25bqtIAAHTsGfkPBPz/Vq/ol1fvZCogvFu3ZWrIetRB8EaT8x7efpLPf3FGjaiUnqoAfbph5JFQkSaLGLpWCrdDy3l7YZ/livp/OdinHah6S8SwrcvF0JP3jz0dpWHNp9VIIGAO6uh/PKgx+sNYVMyRzs/Uu+eUX0X+b1uZTN6MXo4hfTx4KdUFboUuhAdiQdc9GKuXs33hsGhdfcIWAypVSuz11Vyq+JosrmNYE3V8PyFznnc3kkzg0Bc6erjMXA0NNZ2P8YtJ5gDTC6fXLz2XErYsqqZcv8Yb8ocD3uqOb0iCC8T/OO6gMFkjTgJG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/I92rNNx5TqEbey9j1hFMnq7mlmwNIJKGHIEaPtAbF4=;
 b=kKnmc4iLPZiDuKpVpni2AQsHMrku8mIkP2dmhqCM6veHpjeIMCU/bcq1I73BMqj3MGrJce+y2W7Zdt4HVVoc3Ah3Gmu2ljqLXEkmKG0ASz4IYIAB7tJrRYmUyL8JB1pNHQo1lQrv1OKbXlF6yNafOCzwqlA1x66wE1YeWkHGLf9IF7xguVztMGPmynJ8xyLLO7P31QhjJHO6SO/STlH1BmPz/QEFGI6j19KUGT+4rGnkWdN7V93uW17gKwFi1/w8eDxrsozqtEFf5GO8hzrAt2XwldP1kPWpyGItUzyPpbnNyFxJS/CarRsSiTcUSTE0Kv2APbrt2XvmQIEXhm2GkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I92rNNx5TqEbey9j1hFMnq7mlmwNIJKGHIEaPtAbF4=;
 b=H8Hg7w6AF7OPMaH+VaipT3jPK1K42vvXg9JCuSTzC5i+dlyDofwHIRXQ1MY6ps6b4izIMs4y2glSN78wCOJ2usso3fI3pSxP5BSghuSEHnAcA/aCriehlgQxZoHVEEX9Ic/he40x7j/rjE7ltloJZR2dBBofJ21TkuScg6CXr8Y=
Received: from AS9P194CA0026.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::34)
 by DU0PR08MB7785.eurprd08.prod.outlook.com (2603:10a6:10:3ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:01:52 +0000
Received: from AM7EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46d:cafe::6) by AS9P194CA0026.outlook.office365.com
 (2603:10a6:20b:46d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT013.mail.protection.outlook.com (100.127.140.191) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:01:51 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:39 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:39 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <nd@arm.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <catalin.marinas@arm.com>,
        <dave.hansen@linux.intel.com>, <joey.gouly@arm.com>,
        <maz@kernel.org>, <oliver.upton@linux.dev>, <shuah@kernel.org>,
        <will@kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 11/20] arm64: enable ARCH_HAS_PKEYS on arm64
Date:   Wed, 27 Sep 2023 15:01:14 +0100
Message-ID: <20230927140123.5283-12-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT013:EE_|DU0PR08MB7785:EE_|AM7EUR03FT048:EE_|AS8PR08MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e619ef3-ab72-4e73-1009-08dbbf629eff
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xYCsGDyUPN/PmUgZAqlashireo/7GWtX1/tR36YaVmBBuyikWn0RalufWOFYAfSi6zBDNAh8SLBOFC4505P0mRwC/bazQdkMceBPoxPjWWt+CTd6K99zYUnaq4PSyGIBybXLaIDZknhNRs+iR6MdI5kVVZ7SVZf3bx3bGmEd91ohTv6LLFNR76+nALNftxEZt9bQKSeP9tDtN/hIdszi10QBJZY489+pYF0UM7cfLX7r7A65W/1xenmMqQ8nGEGVCoQZ/C8ZkAuwb9yRUWjyDrirU6xjR+aHQXVLUgcdcwWvYQfJg6uttSo/82BKOgxVEvkykhEguazauSZtm7pqFz+8rNclvAuqBZXG83ac4pybtMnQbK2PCTwhuOQ8d67+bbVOcWp+jAi+S2NCU0dq49Ba+hGby5FQ3i6JkL9KLaaoSCrRyaJIh8BC1TfFJYPTYT9el8cpi0AVOEJ0jRIwb7lasFgUC7W/u/6IbiFjbKSKRG2aM0qmzlup5Fid/hzNTYFA1eUV5R+Ad15qECO4KIvfAHRXvhkkD2C9i1tfouPnV1tWB0fC0HCM9C2DnGgPZ3/zttm7XaOFG1p7GCAamXTiwIOZHgpY5SqaC47rVrtER7hQa9a2JtExf0q7Db2h0Hqby2Hm0at5nDkdcIaaJwi3YoDllwSss0JhQUM+kN7tujUR+Wi2QlEi99A48q0ifwM4m9j+wy9jiAAxIyrub8sbssd6PYD7eSuSgBWOtlyJ0B1Kaci+2rZv6PnSt7tfEMTHhvYxMxrQbnJ4/UN66g==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(26005)(6666004)(40460700003)(478600001)(1076003)(2616005)(336012)(426003)(36756003)(82740400003)(81166007)(83380400001)(86362001)(356005)(47076005)(36860700001)(5660300002)(7696005)(40480700001)(8676002)(4326008)(2906002)(8936002)(41300700001)(54906003)(316002)(6916009)(7416002)(70586007)(70206006)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7785
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 11a7d343-b7db-4e37-6fe1-08dbbf624cc6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jT7RXe+bSrfAOMxMlHhKZCVCYvDH1Cj2G4JlUk6BMRwHnyd/yJ08+LzlsQkQiP/Ex54GhYZZTx5tOylxEIqTOONOR5UqQcgdaFr2JQGYJzMhPf0zUUTQiVIBdPQOZm3dfTUBPAvBhrdt/gRlUyHXckNRz9slWGu/VXXrD0W3/64IaL7y5Q2BGZqhCIsdu6/usKqD37DXOXQvPpZRK5ayWcYWNkuUNIxa/sRRIFUyYXzwA7J/4qpjGhAMkdfsMSsWu+2gZULhrBEB+uIxY7g/el/Vwnq7TV9KTCL40b8vFwYf9Z+QRZx7XuoCvrb6r+N0c2WI6A94cIR0c/dyIEHEeictCwp8a8TS6NRob8QODDqaSs7TM+nYYz3bcCwZaHxcdj2W13K1l0dlPd8OQMJVunKnOOq1Fq/x/gPIg36NTkGbRTGC6SWkzbBYBFSn0VanPDhkVGewmmOc2csjeF8PvfpJuFfJpV40+Al2zBwJsx1gDPMbblsJ3ij+B/vwYnZjUESng3lqts/Xnv+AbF6AMf5P4PGuRYzD0rd7lxzsQJjmAjIT8LIWlfGY1FgZfLowHef8rMB6IG55+IvboQZK88gkxGglqdt7CfjHcydoEFDkBWMFn9hE4NK1qutyr/HGHRWVRpZm9xuEfZ5b2etDeCalAWg05oiP20V8ff8ur53S61/LYJUQBnxym4zaMMYUsxzUzD8upwaS4cQfFnyfC4hCMAAN4PBZ5HejdPJ6oEIgs1WucMMQDIewC9/DHvE+
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(86362001)(26005)(81166007)(478600001)(7696005)(6666004)(47076005)(336012)(1076003)(83380400001)(426003)(36860700001)(36756003)(2616005)(82740400003)(70586007)(70206006)(316002)(6862004)(4326008)(54906003)(40480700001)(2906002)(8676002)(8936002)(450100002)(40460700003)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:04:09.7492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e619ef3-ab72-4e73-1009-08dbbf629eff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6056
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable the ARCH_HAS_PKEYS config, but provide dummy
functions for the entire interface.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig             |  1 +
 arch/arm64/include/asm/pkeys.h | 54 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c            |  5 ++++
 3 files changed, 60 insertions(+)
 create mode 100644 arch/arm64/include/asm/pkeys.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b10515c0200b..c941259e0117 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -34,6 +34,7 @@ config ARM64
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	select ARCH_HAS_PKEYS
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SETUP_DMA_OPS
diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
new file mode 100644
index 000000000000..5761fb48fd53
--- /dev/null
+++ b/arch/arm64/include/asm/pkeys.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Arm Ltd.
+ *
+ * Based on arch/x86/include/asm/pkeys.h
+*/
+
+#ifndef _ASM_ARM64_PKEYS_H
+#define _ASM_ARM64_PKEYS_H
+
+#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2)
+
+#define arch_max_pkey() 0
+
+int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+		unsigned long init_val);
+
+static inline bool arch_pkeys_enabled(void)
+{
+	return false;
+}
+
+static inline int vma_pkey(struct vm_area_struct *vma)
+{
+	return -1;
+}
+
+static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
+		int prot, int pkey)
+{
+	return -1;
+}
+
+static inline int execute_only_pkey(struct mm_struct *mm)
+{
+	return -1;
+}
+
+static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
+{
+	return false;
+}
+
+static inline int mm_pkey_alloc(struct mm_struct *mm)
+{
+	return -1;
+}
+
+static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
+{
+	return -EINVAL;
+}
+
+#endif /* _ASM_ARM64_PKEYS_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 47781bec6171..3b7f354a3ec3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1487,3 +1487,8 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte
 {
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
+
+int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
+{
+	return -ENOSPC;
+}
-- 
2.25.1

