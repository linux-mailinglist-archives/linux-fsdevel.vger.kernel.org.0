Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053127B0611
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjI0OEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjI0OD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:03:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE57121;
        Wed, 27 Sep 2023 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgV4AndAd6/NO9/4ic2BHYdTbhCHHX5oZ2R85t/amgM=;
 b=fBi8yVJbEZXVSIWUHLBgyyGhYw9wiKu9NfRQnbJOT2y1pvRUnexrLxHfNrlyUgxBs3ibPhf4Jn88n5hvhZbc3e2JPben+LA2qjU3uUakRYbOBN/XeILt/TLD0lrwmH7YknCu8fDA4TI4y36g5MFqPHQ0t6qSDhyF9NNSQ6ccCJQ=
Received: from AS9PR05CA0024.eurprd05.prod.outlook.com (2603:10a6:20b:488::23)
 by AS8PR08MB8566.eurprd08.prod.outlook.com (2603:10a6:20b:567::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 14:03:54 +0000
Received: from AM7EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:488:cafe::34) by AS9PR05CA0024.outlook.office365.com
 (2603:10a6:20b:488::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT011.mail.protection.outlook.com (100.127.140.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:03:54 +0000
Received: ("Tessian outbound 6d14f3380669:v211"); Wed, 27 Sep 2023 14:03:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e99df280e4da48c5
X-CR-MTA-TID: 64aa7808
Received: from a4cf691621f6.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 41CA881A-83E6-4171-8877-73ABDAA70DAD.1;
        Wed, 27 Sep 2023 14:01:49 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a4cf691621f6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5w23chlw+WPzhcOxhXesqVNDAly4nIVyV6JkxWWzEUHa7+fz9zJOPrzkygwrWl/4b2FZco1fjBBprZKlym6qu7PJ9Q/WFVdUwF1xBckMNkU8X5Ht7UVEQWKlSnjbaG18fyNPNKPKRN2IcxwncEEDDp2WtlJ+s4SJ4hRIWhQF4ZNJ2ailtlG1beTn66aD7KE+lhDqBvmD3ynfLgYFoJqFodBsqp7GYIWzgqPOtn9pscewE3XuN0ftr2OyCH7WaxEUvuJg9xRS39capA46UDdO6/DUQ75Jd16DahH38qLLxyrw3Kk1rfpBZ8ncffbULMDn0EXZUyXt5mwzliP2tjbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgV4AndAd6/NO9/4ic2BHYdTbhCHHX5oZ2R85t/amgM=;
 b=HwQ93XZqnHdxMcWP2K/O8OD5y4dkfsUXuB0ETWj+9+CsMz2PwhnFtexztmE2VqZNb3oqG2xSOvILBUHTYCOQcAXadSYlLjPxcrL54uk9fRRkeJiuh+NjM1nprm8Qx/l5dv8ue1ZASBgTFiuy8KbpndB+s7uvbL3K1PgPRj4ZqLuok8aTshrfjt+DEV5HxUc2cFw4USOV7PBJzijwJtyG1vTsmftGDaMJui8hO579vqK/tB3pqc9MRrsrPEYrI0yuH9lIUIYByDKOeNE/9s2jhVLGNmIW9QyO5yKOA+f7FGx85W3JpSRf4jTZgJgI+LjmrhAbMT2Raeam/qEj1G6BBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgV4AndAd6/NO9/4ic2BHYdTbhCHHX5oZ2R85t/amgM=;
 b=fBi8yVJbEZXVSIWUHLBgyyGhYw9wiKu9NfRQnbJOT2y1pvRUnexrLxHfNrlyUgxBs3ibPhf4Jn88n5hvhZbc3e2JPben+LA2qjU3uUakRYbOBN/XeILt/TLD0lrwmH7YknCu8fDA4TI4y36g5MFqPHQ0t6qSDhyF9NNSQ6ccCJQ=
Received: from AM0PR07CA0032.eurprd07.prod.outlook.com (2603:10a6:208:ac::45)
 by DBAPR08MB5655.eurprd08.prod.outlook.com (2603:10a6:10:1ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:01:47 +0000
Received: from AM7EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:ac:cafe::ab) by AM0PR07CA0032.outlook.office365.com
 (2603:10a6:208:ac::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT048.mail.protection.outlook.com (100.127.140.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 14:01:46 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:38 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:37 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <nd@arm.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <catalin.marinas@arm.com>,
        <dave.hansen@linux.intel.com>, <joey.gouly@arm.com>,
        <maz@kernel.org>, <oliver.upton@linux.dev>, <shuah@kernel.org>,
        <will@kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 08/20] arm64: add POIndex defines
Date:   Wed, 27 Sep 2023 15:01:11 +0100
Message-ID: <20230927140123.5283-9-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT048:EE_|DBAPR08MB5655:EE_|AM7EUR03FT011:EE_|AS8PR08MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: e661b9a8-6259-4387-4e59-08dbbf6295fd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EwkC6Zia9l+fdtlOVKrIkAaWhHI9KECKsj0V4v9u+YsodeAjUz6GymS1ERL2soArq1640WpiqTZ7FPHzJDLcIcbwIEr4jakWdrTCwhs5AWterK5RKH65ll+TbLVOuQg4CvAlYelVB4L/pxDyP46hnQL50bYwo4VxAVYui1Pq+S55IEIJe/QhqiiyGew6k6ur17NV9+gq1SUimGTl7Yt+AltQbysB6PF6fgGRKcasBWwg34p3aZcdmo8H7v16TNYoMRnwxhwZykzZ8jb2KpUUCBaiFI6nE3N0Q05LAnwqRVTQviRhFzKNAc3k3GPrj5BJvKg/HvMKq3DO8IbJhQIFSR+f3ZB2S4r9TNHcaVdEssFHZwEFB04s8qup5dHpzSEZNxeTIOAhf0MRmFSd/My0UDTOG+BeWp3tnkAOgCdCpUOL1cZiA4LHU7pRMiZ5ppqHdfYKJOmiRjUNFmYd8fk1VRnq1Kari650hufAfmd7Zx/TCYxQNOTzCq7xju6D7MqeCOB3a0ofSHZtpuhUmfkj8x6XCeAvLNUjQPJw+w7x6ewwLtk2+3gswaanT+OEl+WKzCJa6kiIjx6SeTvAw+Gk/X664AZDmJmk5Gg0X51YYsoCFKlG51A+JAialu4zDkKrBwwI+LW+m9TuZfHWQtS9uG+c0E9xXDBU9kz3E8jbA5BJYA68jUQXWvCnlhq04U8rYjhDocYYRHdePpr+uLka+z3cUznYHXtoE9gi+qW8cFC/vJXnCmjJVUHUndWQ6KOl
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(36860700001)(7696005)(6666004)(82740400003)(356005)(81166007)(86362001)(47076005)(36756003)(1076003)(2616005)(40480700001)(26005)(426003)(336012)(2906002)(316002)(7416002)(41300700001)(4744005)(70586007)(54906003)(6916009)(478600001)(4326008)(8936002)(8676002)(5660300002)(70206006)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5655
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f727312f-2a1d-4f94-63f4-08dbbf6249dc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13fDweWBA8L5sL5l+cOKqCrnkziQIbN0icxyq2oV+oRR4kgpC/9IzLTWfT3jphC57HKkwMVjepW+vnU26mOvb49eVzPsFnXGuKTzx/s2PpM9IL5mXjZfCgJSag7aNgxfdjLRAmkIJNOFyaHjQzIQg5fZsic0YXlqj6ITQ5K9rb4ohNH8U9vkDC/gsk+WF30rjQR4uWHBUXWkA8SoOQzT0qf68KNlfolO77tAESWQL5xgxDl4xlWcXh8V8wgh6CC0ThBLUSFzqVW9TFVEPf7QH0AqAKuLZMurCHtLMDq05DSuTJMM4UFQ12kdLBr6AfSHoOW1kRoPHttT2iceZkS0i2qR1og0M9XobGhnCrFPbJxM4Eew9xMuNL3XDWmRsYTa4LahYOsW4us3t0wq5PDMxNwJdiDwtgtiXLVMk5UTQcPVAKi5uP39FYbW3L8E8mFjViu3N/qjzipJiHdlk8Dg3MDB3kGYqrAOTQLExjBEVwwG6E1HDedyJmLT/VpGRoDpJ/02Fe5wxkuVKu+0BrelLhVLtZDagg8hC51JIYtQx/xUT5MbpkFQllRujKGyDSwBbpalSVjoYUNrYWqNGbZ7N8rwREyut71RzGl7k8XWjKePx7U2wrMIF1ZoHfWX2krlrTWF5T450nl4kAqTYm79ZDIV9GBgSrXdOanbCUxNrqAyHvGbG8uWIzwfvHVcaMNFXPC5pVHVseR1KFOxh+gcpmVKd6P6LFHvA2FrQsDiwwTosFlYdOWvxS8YOH3FZai3
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2616005)(26005)(336012)(426003)(36756003)(1076003)(7696005)(6666004)(478600001)(47076005)(316002)(70206006)(41300700001)(70586007)(54906003)(36860700001)(5660300002)(44832011)(86362001)(4744005)(8936002)(8676002)(6862004)(4326008)(450100002)(2906002)(82740400003)(40460700003)(81166007)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:03:54.6382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e661b9a8-6259-4387-4e59-08dbbf6295fd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8566
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 3-bit POIndex is stored in the PTE at bits 60..62.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index e4944d517c99..fe270fa39110 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -178,6 +178,16 @@
 #define PTE_PI_IDX_2	53	/* PXN */
 #define PTE_PI_IDX_3	54	/* UXN */
 
+/*
+ * POIndex[2:0] encoding (Permission Overlay Extension)
+ */
+#define PTE_PO_IDX_0	(_AT(pteval_t, 1) << 60)
+#define PTE_PO_IDX_1	(_AT(pteval_t, 1) << 61)
+#define PTE_PO_IDX_2	(_AT(pteval_t, 1) << 62)
+
+#define PTE_PO_IDX_MASK		GENMASK_ULL(62, 60)
+
+
 /*
  * Memory Attribute override for Stage-2 (MemAttr[3:0])
  */
-- 
2.25.1

