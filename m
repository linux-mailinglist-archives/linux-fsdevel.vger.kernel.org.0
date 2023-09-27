Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC05D7B0614
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjI0OEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjI0OEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:04:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2C211D;
        Wed, 27 Sep 2023 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtQhUKKAeciLMz8eOcAzcWfX0r2cwo1XnqJpJwevaOw=;
 b=C3G5pwolId6E0/SNrrLGnc5x3R1MZyvrL8fUc//Aucc+Rp0cbtgWoO1K5JSvnE0gSgs8TUA6iLfslmrqm3K/UMw2ULdd8blsEcq93AxrzIUxSBETZH0fAiuBMhnSnTwNE4ly2I15D3fyE3naBrvVP0r/KwjmOtEw+zbbgMao6AA=
Received: from AM0PR10CA0120.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::37)
 by DB3PR08MB10336.eurprd08.prod.outlook.com (2603:10a6:10:43b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:04:01 +0000
Received: from AM7EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:e6:cafe::bd) by AM0PR10CA0120.outlook.office365.com
 (2603:10a6:208:e6::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 14:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT010.mail.protection.outlook.com (100.127.141.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:03:59 +0000
Received: ("Tessian outbound 0ae75d4034ba:v211"); Wed, 27 Sep 2023 14:03:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8c0c49c206008a61
X-CR-MTA-TID: 64aa7808
Received: from e06e0c146651.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 705B4AD0-0930-4F3A-A271-0479D60E97DC.1;
        Wed, 27 Sep 2023 14:01:54 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e06e0c146651.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTgipIyIGLUaqx8CnxNrhipBpXF/SlrTYhzx+lH3ilrA1+fF0PQmV+dG+MuIuVXfkobWhfBqy1LhokCWi6HOyUjX9a+TkB4qGNQz9lDmyeTlBtAqEQNwVVawk1RdrWNP4cwftkiefK9xaQ+dDmShdj3mdZ/8RTNNGb667Tf8kfezTjGYnHr76peXYeG5+hN2q+UL+IVqj8Pyx3KxjFAZsx3TLeD9qKRBdRwCR56l94es7tudaEt9n0CF+adVncu6ptJalZKKxDbyZFoiFiUhZ/j1JlPOIbIp/WCdyDK5jJXg9jMEQ0dJpxuOc2tQEGzOLmf/9+n/qfgha3idczB79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtQhUKKAeciLMz8eOcAzcWfX0r2cwo1XnqJpJwevaOw=;
 b=VKAOf1uaRWHTU7wrOMiDdqGz9B8/CKRUVV77bPVlDM/zZZV4/4RRDeUCJfLDzOKmqwBuyPKLR3ZVvksBkIx3a1ojM/zcFyURIWRZ67JyyBeqKllZmAq9Yc5zdt6s8+SNHTZgGplOkY+5j0TBR+GJOXBJg3w36F88JLbTSaPZjmS865rVtRoDkDjnYKmATneYozMd+1WU6VIbs050S03jlleqbK6M+95WkFQC9rtXvL+oYC/dyxdqZRuAp/vi+hjCfCMQ3Xu4IK1iB65EyGzZG9ijFUuSvuuMOFBoQ25krnwwo4zPSNHwOyioyLUhFzZNBtJpav1PYSevnqjC+NUWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtQhUKKAeciLMz8eOcAzcWfX0r2cwo1XnqJpJwevaOw=;
 b=C3G5pwolId6E0/SNrrLGnc5x3R1MZyvrL8fUc//Aucc+Rp0cbtgWoO1K5JSvnE0gSgs8TUA6iLfslmrqm3K/UMw2ULdd8blsEcq93AxrzIUxSBETZH0fAiuBMhnSnTwNE4ly2I15D3fyE3naBrvVP0r/KwjmOtEw+zbbgMao6AA=
Received: from AS9PR05CA0256.eurprd05.prod.outlook.com (2603:10a6:20b:493::23)
 by PA4PR08MB7595.eurprd08.prod.outlook.com (2603:10a6:102:271::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:01:52 +0000
Received: from AM7EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:493:cafe::a2) by AS9PR05CA0256.outlook.office365.com
 (2603:10a6:20b:493::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT046.mail.protection.outlook.com (100.127.140.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 14:01:52 +0000
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
Subject: [PATCH v1 12/20] arm64: handle PKEY/POE faults
Date:   Wed, 27 Sep 2023 15:01:15 +0100
Message-ID: <20230927140123.5283-13-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT046:EE_|PA4PR08MB7595:EE_|AM7EUR03FT010:EE_|DB3PR08MB10336:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4df554-8f9d-463c-cade-08dbbf6298c1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: AzNW/jfyN/py6pQnyO+mnLYMGlf7+Ka8Zv3VNpmpyhalAKo+iPntU4LF5pPlWJHLVa+H9foC/UAzAZekswYuh9DhOMQvNLtCNTd7pqvjWlQWpfVLvEUR1IbBBdrLH4vAhADdmadNdn8OIjNPwrDyJRwQgkdFRs4MSrf6rYt7Ilk6rZZZf7XyGHV3x8ZGmG4rFqlQ+4TkyWppjFU2Vw2TH5qwHM2GdRrfzfXudmGP6nCVLYmBq+W0m2bKEQrzDE+xs1LEWYfmh3ytpTHYs6ubNZUM+356zQc7b+LYbN6fQVYCm+9UZsSpIiCXKxSnoLwOc3qGPIOo3izhCE3MmHmeB6ZFY+Scl9Ayjo2N48+xoIlRHM5LsY+EVj/NSWweZ3mGPcOYwH4KQrS90v4XRF1TPYVucrOabF8ZkipQ/e7gGvuTQU8bhaoMNrO07c7dFGDGnKP4oncbJJRE0upySoaUxybRCB3iwGLdOMDf2OXBxeNxNbrit8dL7xJlhtlGU1ISug/ut0Ub5u2+MgSM0iigG0HnFB1LL382f7sFPvHF5tgJ+YuMNCrY6UafBt6duiEx+jW7s047dxAftF4qB+AVWihAWljEkAYa4xoDpu+EGbz1rjLMp5owpcCQQe8SbJEOo9Ux2aj2txihbg1RZWABNL+hDio4QpIqbJg86Q7hLx61kkN7iNWlGsg+La/1BZOfPGbXvSl4NzAABNmHMzblgepjqSpRL0taZZIz9YlBd97NJ8mCRpelrZLKX4cpybGVvyb98KlL8DIo0H3ILHTfig==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(36756003)(86362001)(40480700001)(5660300002)(44832011)(26005)(70206006)(54906003)(70586007)(2616005)(336012)(316002)(1076003)(426003)(41300700001)(6916009)(478600001)(7696005)(8676002)(4326008)(8936002)(47076005)(40460700003)(82740400003)(356005)(6666004)(36860700001)(81166007)(83380400001)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7595
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4725d3bd-55f8-4bd3-0ad8-08dbbf624d42
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdNe05r38aQCz2WtmnmkXPl3beeToRCdkxNT0Q3e8d+ti637z5CKQjkFC3NfQIXmutx2LOMID4T/pbQkOgPxQmyFSMcEqVl9eJ6JPSfaACBXExLcDMoH4Kkoy7k8N5+2gtM5SFDi8TjowlWdR1GOBltnkn5wKHnWSf4rHmw9rZH4QTjQBRg4Pb5Jwq88Z6lJTwq+GTUhxtmnStiPF4WuhIwZsbr/9W25fC+XUWsjx++J95bO1soBSD7VJrzlEuK5LjD+KK0G7QPFX9clDR3GJVXeDohz64tEljntJgpZ9ttTc2alos0PiTXFh+e/ffWUILYQ13MhqEw6eNcdS0DculnhJ+nfhuI2fT+EYoLkKJX4aCzylT0TtAcMmWjidlKeiobnsANJEgTWkaww3/yV8K6MZnTcJ1pl5Fu0QlkGtWzjXv+gez0NAtA0X0/qg3BNcXtZ6elpUIBqKx9PlZRCtUeuNSMOEP/UeKFV/gISjwdpYMd/54QCjDZ/KfB3UsAcd9PQv4J61wgNyn7ZvyFX+cCAw5LlwulTuE67L9huqr4yrPNynSjmVkRBB+Rzc/0dJrEcJdr0nTpbIoGJ0Cdmb1B/klGcL0x+7lJxnzI3JUWdS6ZsaXGw2QHp3zm/9KbJ7XETR5FcprXWwP4R7IBm394ALmFmDAHaLy/XrzJRMk9tBRP1s1WyMe5SceK+0VkFNIcWblv0kEKLYI3NWjaup7EYj5/YKV+sv0GNvkUw0+jMYP4b+rlN3FF8sy/e+Xvs
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(36756003)(86362001)(40480700001)(5660300002)(44832011)(26005)(70206006)(54906003)(70586007)(2616005)(336012)(450100002)(6862004)(316002)(1076003)(426003)(41300700001)(478600001)(7696005)(8676002)(4326008)(8936002)(47076005)(40460700003)(82740400003)(6666004)(36860700001)(81166007)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:03:59.2813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4df554-8f9d-463c-cade-08dbbf6298c1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB10336
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a memory fault occurs that is due to an overlay/pkey fault, report that to
userspace with a SEGV_PKUERR.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/traps.h |  1 +
 arch/arm64/kernel/traps.c      | 12 ++++++++--
 arch/arm64/mm/fault.c          | 44 +++++++++++++++++++++++++++++++---
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index d66dfb3a72dd..dae51eccfc19 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -26,6 +26,7 @@ try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn)
 void force_signal_inject(int signal, int code, unsigned long address, unsigned long err);
 void arm64_notify_segfault(unsigned long addr);
 void arm64_force_sig_fault(int signo, int code, unsigned long far, const char *str);
+void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far, const char *str, int pkey);
 void arm64_force_sig_mceerr(int code, unsigned long far, short lsb, const char *str);
 void arm64_force_sig_ptrace_errno_trap(int errno, unsigned long far, const char *str);
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8b70759cdbb9..b68682c284a2 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -263,16 +263,24 @@ static void arm64_show_signal(int signo, const char *str)
 	__show_regs(regs);
 }
 
-void arm64_force_sig_fault(int signo, int code, unsigned long far,
-			   const char *str)
+void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far,
+			   const char *str, int pkey)
 {
 	arm64_show_signal(signo, str);
 	if (signo == SIGKILL)
 		force_sig(SIGKILL);
+	else if (code == SEGV_PKUERR)
+		force_sig_pkuerr((void __user *)far, pkey);
 	else
 		force_sig_fault(signo, code, (void __user *)far);
 }
 
+void arm64_force_sig_fault(int signo, int code, unsigned long far,
+			   const char *str)
+{
+	arm64_force_sig_fault_pkey(signo, code, far, str, 0);
+}
+
 void arm64_force_sig_mceerr(int code, unsigned long far, short lsb,
 			    const char *str)
 {
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2e5d1e238af9..a76906199479 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -37,6 +37,7 @@
 #include <asm/esr.h>
 #include <asm/kprobes.h>
 #include <asm/mte.h>
+#include <asm/pkeys.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
@@ -497,6 +498,23 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 #define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
 #define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
+static bool fault_from_pkey(unsigned long esr, struct vm_area_struct *vma,
+			unsigned int mm_flags)
+{
+	unsigned long iss2 = ESR_ELx_ISS2(esr);
+
+	if (!arch_pkeys_enabled())
+		return false;
+
+	if (iss2 & ESR_ELx_Overlay)
+		return true;
+
+	return !arch_vma_access_permitted(vma,
+			mm_flags & FAULT_FLAG_WRITE,
+			mm_flags & FAULT_FLAG_INSTRUCTION,
+			mm_flags & FAULT_FLAG_REMOTE);
+}
+
 static vm_fault_t __do_page_fault(struct mm_struct *mm,
 				  struct vm_area_struct *vma, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
@@ -688,9 +706,29 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		 * Something tried to access memory that isn't in our memory
 		 * map.
 		 */
-		arm64_force_sig_fault(SIGSEGV,
-				      fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR,
-				      far, inf->name);
+		int fault_kind;
+		/*
+		 * The pkey value that we return to userspace can be different
+		 * from the pkey that caused the fault.
+		 *
+		 * 1. T1   : mprotect_key(foo, PAGE_SIZE, pkey=4);
+		 * 2. T1   : set AMR to deny access to pkey=4, touches, page
+		 * 3. T1   : faults...
+		 * 4.    T2: mprotect_key(foo, PAGE_SIZE, pkey=5);
+		 * 5. T1   : enters fault handler, takes mmap_lock, etc...
+		 * 6. T1   : reaches here, sees vma_pkey(vma)=5, when we really
+		 *	     faulted on a pte with its pkey=4.
+		 */
+		int pkey = vma_pkey(vma);
+
+		if (fault_from_pkey(esr, vma, mm_flags))
+			fault_kind = SEGV_PKUERR;
+		else
+			fault_kind = fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR;
+
+		arm64_force_sig_fault_pkey(SIGSEGV,
+				      fault_kind,
+				      far, inf->name, pkey);
 	}
 
 	return 0;
-- 
2.25.1

