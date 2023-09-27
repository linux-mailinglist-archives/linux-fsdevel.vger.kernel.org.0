Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE37B060D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjI0ODx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjI0ODv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:03:51 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6278710A;
        Wed, 27 Sep 2023 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP0hZBQLW0r5LPMNDw9vkQWBkTgVKFZIvfc9QkLlChM=;
 b=Yrx8MYtKqgv9lvFMg6MENe9rLixHTzZ+HgyngQg4Xu3XO/KXDeB/We1+Z9727+I3RgXDmySuAoquSk8F/fk7MC8hbGS0YLS5LiQs9vYzaUdB+3nklBpY/N1DFOD6PmZPizrtUjSF99GFTUBzNS0Mg18hb8R5/ccQvnyUJvIZcA4=
Received: from DU2PR04CA0152.eurprd04.prod.outlook.com (2603:10a6:10:2b0::7)
 by AM0PR08MB5457.eurprd08.prod.outlook.com (2603:10a6:208:180::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 14:03:47 +0000
Received: from DBAEUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b0:cafe::a6) by DU2PR04CA0152.outlook.office365.com
 (2603:10a6:10:2b0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT003.mail.protection.outlook.com (100.127.142.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:03:46 +0000
Received: ("Tessian outbound 0ae75d4034ba:v211"); Wed, 27 Sep 2023 14:03:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ae231f9e02a9b0cb
X-CR-MTA-TID: 64aa7808
Received: from 42361384454a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7EDF8468-9F69-4C21-BA86-2E1A1B912054.1;
        Wed, 27 Sep 2023 14:01:51 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 42361384454a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPJCUUrZNNyO177ukqeVhbgMpCT3DoTiFQBkauYBSbcsjLQnQgayICGsdIlQh9CKb+DKgkWgpwZwIt0yLDOXkppkkLJQx/iofqdAhPR1AZ//EGi+9Wg/gKpNKJe9KF7eUTVLPWiTPh1xIfussZyc/1q1UlNlaUX2U+PI3IfBysPIEHlorOHNSYqHxBYdqEIjvqM8zuCJXbBU8nlnqtYWZXn0cPetWvL7dnqnYluVAZltr3QcclojYTFcLMn6CN4w3MRAxTN0T9vauLSr/+lowiJJEJMxHSIOjeAkvk9svzXtpdLDt7ILiA1mFTX5ckPpq3Ux0dy9uVIEmrqAC8Q6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP0hZBQLW0r5LPMNDw9vkQWBkTgVKFZIvfc9QkLlChM=;
 b=N3ZJcDjUd1sbw5LgCA5Ljo9fzFb9wQPxto2aWnel/ldP6MGDO3bPDqAeeWWeq8ZgSDNO1B+bhbwuqz3T5W73VU1JS4OqH/0KgmsC2GI6cjRNAqdtVA/WvZwppwDZPsX8F5DMFtdZZHpOiWssvW3shHI+RDIBrWaiclzYGKfSTvliUCGXrrdNJOFy2PiHS2Sq5KADEEb4+/tsIi2mlYUW+fhBqdG3Dierm+FLAzv//R/Pjuatwb6NNRwSNZaHnMwHSDKcWICNC5t2NHHPhhgCQNdXzVHG0y80o73y04wTFCcxVFrXijvics2EqJbaROiVU095TzAgXVGu9GxJ/tUt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP0hZBQLW0r5LPMNDw9vkQWBkTgVKFZIvfc9QkLlChM=;
 b=Yrx8MYtKqgv9lvFMg6MENe9rLixHTzZ+HgyngQg4Xu3XO/KXDeB/We1+Z9727+I3RgXDmySuAoquSk8F/fk7MC8hbGS0YLS5LiQs9vYzaUdB+3nklBpY/N1DFOD6PmZPizrtUjSF99GFTUBzNS0Mg18hb8R5/ccQvnyUJvIZcA4=
Received: from DB9PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:10:1da::14)
 by AS4PR08MB7653.eurprd08.prod.outlook.com (2603:10a6:20b:4cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:01:49 +0000
Received: from DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1da:cafe::a3) by DB9PR05CA0009.outlook.office365.com
 (2603:10a6:10:1da::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT051.mail.protection.outlook.com (100.127.142.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:01:49 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:40 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:40 +0000
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
Subject: [PATCH v1 13/20] arm64: stop using generic mm_hooks.h
Date:   Wed, 27 Sep 2023 15:01:16 +0100
Message-ID: <20230927140123.5283-14-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT051:EE_|AS4PR08MB7653:EE_|DBAEUR03FT003:EE_|AM0PR08MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: 343aca99-b31a-49b6-61b1-08dbbf62915d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: du8ahLLIPeC9aWNg18cDj6DAuuvBKq7TIOCwkSO9W6bRQvyJ8x1dUN2enprZH2zUd1C6a5buJDsOSePUj+WJXweB4a+8l7RXJnCGukKSaRGTAhM9QGJSdEOF45cn5vIgmN5UhD08LlZb/jK6gbd+5rAkJv7zwxT/bfHKS3AQwgM1IelX0ckDQPKKQkwKgZ6gL7mmL6E/nv4AMvsbJ+t4zIB8UGfhqF6YWaBP0iNaT6JCPnjHA4EEtkI7WBlU54DrXZI+GgtA6dqLbeOHVrWlrFLjEcuTukEN2i9CCYWQ+3IJzEDEZinhMf+OPXUjXOpueiqW0elFhUfyoGHffJAotL0bzrcyYwvqtH6A0d44dICctd/tlBGe6bQLqTM8c6BO/kspiTD+UKjG4EQHKVckTlUKg6/43vbcnPrtI4AB4kkCbJGUa12I+Zhydz+2fPisjREOABuf9jLhUI2e7peT8BbJBsBk2FfBGUPJVaoeXby+Th/81Z5sQQ0OgW4uiVzkVEJlvLs4h4z3uzDIltD5EMUeogK0/J9/dBz+ufGGCWmvyBvh829lohATA2mJbJjCMDO8+WS2QlgRbWzJbzE0L+w/Dk3Syg7JJe/aSnluf6p1HSf1kwFuS3qWgmO69NT6rZxEeN7sExHW0Jdzo2auSviK9iar04gcpB5OZ1x8Z2sEMDsQ8s3nwiT8T5Q3uCYpThqF5rO/rrU21o+/k7BvUjTCTSU4Tm1+DoX5GTx45V6kfWNxAkvwxmz/oaS4Nly9fK59ysQAr/c5PwqlIYa1aeaiOwoG9Rmv2E8BARRPuHs=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(54906003)(316002)(70206006)(70586007)(6916009)(7416002)(40480700001)(8676002)(4326008)(41300700001)(8936002)(2906002)(44832011)(478600001)(40460700003)(26005)(6666004)(36860700001)(47076005)(83380400001)(5660300002)(7696005)(81166007)(426003)(2616005)(336012)(36756003)(1076003)(86362001)(82740400003)(356005)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7653
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: dce59fe5-efad-4c43-be7a-08dbbf624b62
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+QeMTAfsWdBQhC2N1CHm2OBekb8UK2fZ5k8QygNI8Ks8L+9tF4HJXf1CbSdrTou5Ps/A1B/SpZphwn5gKzN5ze445uodR+RAN/8SQx0OQlu1QQlkklCoYSOvw+L4PEOe0KMFF4RNnmh3L4dYJE5t13CicHZFASiYAZximSG9d+C+Sh32xeG0PPDbaS543vN/G9ncudxEGvzt1YY/AtEThLxs07onRTEL8xQcL1veTLN+ShasqFmmxJ8W/xvahxpxVB3k8uDTBAPol5xyM7Y4cjtOjFA2jffgsDBrBGv5cqk7IU4GPPLrFMDQEkeKDRmLP67Z+BS07z8MDLLSaDeU2jkJQyydpNwsvgDdmIygeSu2MBLOOgKrK5VO1sgDbashYAM/jg146MzWzjto0rb2PtHxV3xRCiWHeessye2zjouMzfJVXly2xK86x2YfzVXqEIfe6Wi1RjHj9+rZv84zMSxO7sZhOYOnMfQ6B5q7LGxB2IwHVi9VrOmbXzBzO7C3mw1xAsAzYwtHH4EoulF97O7gANhoPrKYHTtFOMDWmrzHtEmua8a3OxrUv5UYuQyI+L1EOgVeBenMa69PyagSrHpLUKY7Jrq8F5PKcKbr1jU6ppaQiLNVrBqYsrJ2a8XhzPdL92or3Bldi62Tewqj/sxkHppBDG5QD36iKVs/UzRBheXlygglZpf3I1PgYOfD7Qp0DJccrgXcJfYAD473L6eQHjmq7/GNxkakfeUtGZiU8zZ9jZozogjGKh1GF55rJyvcMPNtpug8vJRGk29wQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(44832011)(450100002)(83380400001)(2906002)(4326008)(47076005)(6862004)(8936002)(8676002)(36860700001)(6666004)(7696005)(40480700001)(316002)(86362001)(70206006)(54906003)(336012)(26005)(41300700001)(2616005)(426003)(82740400003)(1076003)(478600001)(40460700003)(5660300002)(70586007)(81166007)(36756003)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:03:46.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 343aca99-b31a-49b6-61b1-08dbbf62915d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5457
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These functions will be extended to support pkeys.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index a6fb325424e7..c0eeed54225e 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -20,7 +20,6 @@
 #include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/proc-fns.h>
-#include <asm-generic/mm_hooks.h>
 #include <asm/cputype.h>
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
@@ -209,6 +208,20 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
+static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void arch_exit_mmap(struct mm_struct *mm)
+{
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+			unsigned long start, unsigned long end)
+{
+}
+
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 static inline void update_saved_ttbr0(struct task_struct *tsk,
 				      struct mm_struct *mm)
@@ -298,6 +311,12 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
 	return -1UL >> 8;
 }
 
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool execute, bool foreign)
+{
+	return true;
+}
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* !__ASSEMBLY__ */
-- 
2.25.1

