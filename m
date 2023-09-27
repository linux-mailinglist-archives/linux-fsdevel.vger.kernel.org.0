Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12F57B0624
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjI0OEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjI0OEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:04:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE43191;
        Wed, 27 Sep 2023 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDVJtt2pWINnf3TSGFuSxIJFr+mtevbHDxNk3ZClcxI=;
 b=I1NMAhMHiwGsDyWNr7QQwjDOcATrkZ3/F+1pYxo5kXwXnwjW6NfEKLSgiOrd/mwZMZrmvkWpW2cPjKj3MV79VAW9bHlJmPNpwNtNmiT9T2daKCthMDdPGnE9Qob94oh5tabXOosM4lFwxPwR88hQrsGpiROwoD4BfBsarPjxaMU=
Received: from AS9PR06CA0473.eurprd06.prod.outlook.com (2603:10a6:20b:49a::25)
 by AS4PR08MB7879.eurprd08.prod.outlook.com (2603:10a6:20b:51e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:04:28 +0000
Received: from AM7EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:49a:cafe::2a) by AS9PR06CA0473.outlook.office365.com
 (2603:10a6:20b:49a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT017.mail.protection.outlook.com (100.127.140.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:04:28 +0000
Received: ("Tessian outbound d219f9a4f5c9:v211"); Wed, 27 Sep 2023 14:04:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f108e32c4a7920f6
X-CR-MTA-TID: 64aa7808
Received: from 063041436e08.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4519EA8B-F84C-4E9D-B06A-C68E8452DCDF.1;
        Wed, 27 Sep 2023 14:01:59 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 063041436e08.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwaSpW1FQk7APf6Iop0PJQvZLJcsrOOvbGUa4sBv0fCqB12CjfHmQtjbunAHhJ8HaFnoSxrzj/FtxcMl+aGiiLdwe1k9AG84E4Q92878OGcyKkoxQ0hMR+tFHO366FBq6HCGlEEiO3Wpuu5EcdEtfnNGwwNderR9gWqaI4ob1J4NchCdyyT9abwN4XHc4AmdRV/s8Io1wQWa5UiMiG/T5klFipLYcB9j6tZLx4axe8DrNGrpSgygcwQKcIXN1tuqNORDz4GGYB+9tfCmdsafjh577lgv5sbXAXvF8LeWwmQNGO5vrTuhDy48sOBqHrPl6fodr7WsKZUXPEB4vU6gMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDVJtt2pWINnf3TSGFuSxIJFr+mtevbHDxNk3ZClcxI=;
 b=bYTfaGj+eMNZLYFDTSTQ/YOxre1Nlhc1Rzylbiqa7RwGP/ScPu/wNwT2Dzn2/kf+DwBB99hTYDyVSc1bGdqKtLAdP3XsG69QLzo6Lxes3lkT34udzG17KlbLLDiLvKE9wOC/pJ1HMhPR9MLaj4Q+yS6XNP8i4YFsAI7sHhynFzEqd8IgZkxuA8DzBEnyR7gVQTsfoh1CTMR8RFs/P21QXazu2UDFvppuURYsRAdtjA8O3SDkzbnrnbNHQjojRjRC/uDz6NjeYC6/oCDdOQbEqkZM/7kn1jZbxk8DfEyD5n7L2Wp/qdGgZNps6pTx163sOstKTSDXLjV6o/4ZCfGg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDVJtt2pWINnf3TSGFuSxIJFr+mtevbHDxNk3ZClcxI=;
 b=I1NMAhMHiwGsDyWNr7QQwjDOcATrkZ3/F+1pYxo5kXwXnwjW6NfEKLSgiOrd/mwZMZrmvkWpW2cPjKj3MV79VAW9bHlJmPNpwNtNmiT9T2daKCthMDdPGnE9Qob94oh5tabXOosM4lFwxPwR88hQrsGpiROwoD4BfBsarPjxaMU=
Received: from AS9PR05CA0270.eurprd05.prod.outlook.com (2603:10a6:20b:493::34)
 by PAWPR08MB8983.eurprd08.prod.outlook.com (2603:10a6:102:340::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:01:54 +0000
Received: from AM7EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:493:cafe::cf) by AS9PR05CA0270.outlook.office365.com
 (2603:10a6:20b:493::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT046.mail.protection.outlook.com (100.127.140.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 14:01:53 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:41 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:40 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:40 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <nd@arm.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <catalin.marinas@arm.com>,
        <dave.hansen@linux.intel.com>, <joey.gouly@arm.com>,
        <maz@kernel.org>, <oliver.upton@linux.dev>, <shuah@kernel.org>,
        <will@kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 14/20] arm64: implement PKEYS support
Date:   Wed, 27 Sep 2023 15:01:17 +0100
Message-ID: <20230927140123.5283-15-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT046:EE_|PAWPR08MB8983:EE_|AM7EUR03FT017:EE_|AS4PR08MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa2403c-3259-4ba7-000b-08dbbf62aa4f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6/cLMf3Q8iIhp3KKdbJ4BEyfE5C8NX/R7qNr1B623tyhqxaex+39uS3L+4oOA0NUWNs42H5lORZCTdudfWIW8VcZdfEcC0+i0q6vSmp5wXKfXYmf6Qd8ERgllGDwiG3jFFl6R0eoh4fjOi33GnavieAwjWaKZt3KEM0cnFpyvcYDqZDIbC+P8s2bSs1O+ZjUdaDlVM+siGLJwybwtMMRukmW3cWFZs39Npn7xmtrd/vlCAcfy1uiqkGect723TE/9X0w2dLRTwFi2en+AAc+6HNFT0xh+7DMNgS6xZH9y1EWas0ckLOepI7q82xMwhWnUDLuoo5gzQggYLSdOAkpSjqaPA50RHMALM7l37H3KBr1BWIc2Bfi5+FBZYEeFb8Xt2vxhQ7sQaxC6Lzw5f/ISK8N7U6SQwNMCiPeO0fgJA+20aWRJ+OZQLVXBqD8W+ipMZoeE8xDf1po+tnS458db3/1vElCrI2KOP9ze04IWzdqGWrk73Th4a8T8EITbdtEekaZmjQS26cqdyE5snHvJcNWYCN+nMDNnze8U47zyd2mJ3XynsGExy8+TTieel8YbMptr5IhoB/2Ipz+A0p0dPxUgIXN4HUPykxiwq7M/3B4bVrxEzEyWwI2TKE+1mdNe3h850FO08IX5fQCwJWUA0t3/EXNwMT0dLA1p/Z8MSz/WdAEHFgClSUHH1D6YXT/d6F1JZO+R0FX8dFJwmVhKqivGAhk2Bt4AFo0qRHQhFQtAfl1fJGbttse6rBrgjnRyCYlEWhRj88lfaFhZvs4CQ==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(2906002)(47076005)(356005)(36860700001)(7416002)(83380400001)(82740400003)(81166007)(70206006)(54906003)(70586007)(26005)(5660300002)(6666004)(7696005)(1076003)(336012)(478600001)(8676002)(8936002)(4326008)(316002)(44832011)(426003)(41300700001)(6916009)(2616005)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8983
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a81df06c-8b94-4092-dbe2-08dbbf624db6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +J/mSLR+a6oBbZh6of1h63vAJvR/BGlNv5N2Pr5+IgsXFdNHQ/QiUw69QWeuDwsb5pvYbAzRrQZBuXZrXUdyAznLa5xqfgCGuTm02W6z5hm/pNNWI381drgvAy1TFelYRIhuz5XPBUxunVWN60n1bS++QFFrixJaV/Salz6qeD6afDo5B9O7TCh6xsmPfvHO3WQsUax7WqD8v6Aot1U38DhAAucx8y3aIe9FLQpRHVhv8XEKUolhepiKcCQFFztLDP+Ot6qCyd4unDa8mVij90U2Z2jDQeIldcm4018DajiAbp/TBeCsTbx0eqDeoJsE1wMK2YoVbONo4Ij9s/D7aHfH8ZZWf+5voOxc+2VpRN8YPVGiF5hvAkgXFrajstTnurjFWqRMv16Ze8o/4aZfbFf0MHVdWR3BnjIHQVoFu9oSPoqQKSxdaeUKbGjJ45hoKjr3tHhKZtmTXqsSzsAblZpWnXr+4XOS6qq7ka6ijhFUZVEhoxsmNJkQ7lCaALtyzmVSN9ZcoBE3APeQdigSVATutsaMWvhYCgj1GU0EirzSiahZlSoXDaxGDXUubqfOcfOi1o3+NTlRySvrZpQgvNvX9sEhmuD0oQyg8XzjorLi7AvqGulTJtbKgoy8WlDlCRak8xLKD7bn79yzu+c8ugbYaTpB7TJdhrjxqUIwhYnJLjfNOAxEnTecwFCYcSwAHVtJNHbzxMAkjUi8ieInL7IYjtk+GlMbrGkWSPawfBA=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(5660300002)(81166007)(36860700001)(44832011)(450100002)(4326008)(8936002)(8676002)(47076005)(6862004)(82740400003)(83380400001)(41300700001)(54906003)(70206006)(70586007)(26005)(1076003)(316002)(426003)(336012)(2906002)(86362001)(40460700003)(7696005)(478600001)(6666004)(36756003)(40480700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:04:28.7124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa2403c-3259-4ba7-000b-08dbbf62aa4f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7879
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the PKEYS interface, using the Permission Overlay Extension.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mmu.h         |  2 +
 arch/arm64/include/asm/mmu_context.h | 32 ++++++++++++-
 arch/arm64/include/asm/pgtable.h     | 23 +++++++++-
 arch/arm64/include/asm/pkeys.h       | 68 +++++++++++++++++++++++++---
 arch/arm64/include/asm/por.h         | 33 ++++++++++++++
 arch/arm64/mm/mmu.c                  | 35 +++++++++++++-
 6 files changed, 184 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/por.h

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 94b68850cb9f..ed2cd66347d8 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -25,6 +25,8 @@ typedef struct {
 	refcount_t	pinned;
 	void		*vdso;
 	unsigned long	flags;
+
+	u8		pkey_allocation_map;
 } mm_context_t;
 
 /*
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c0eeed54225e..aa739b87d49b 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -15,6 +15,7 @@
 #include <linux/sched/hotplug.h>
 #include <linux/mm_types.h>
 #include <linux/pgtable.h>
+#include <linux/pkeys.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
@@ -205,11 +206,24 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	atomic64_set(&mm->context.id, 0);
 	refcount_set(&mm->context.pinned, 0);
+
+	// pkey 0 is the default, so always reserve it.
+	mm->context.pkey_allocation_map = 0x1;
+
 	return 0;
 }
 
+static inline void arch_dup_pkeys(struct mm_struct *oldmm,
+				  struct mm_struct *mm)
+{
+	/* Duplicate the oldmm pkey state in mm: */
+	mm->context.pkey_allocation_map = oldmm->context.pkey_allocation_map;
+}
+
 static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 {
+	arch_dup_pkeys(oldmm, mm);
+
 	return 0;
 }
 
@@ -311,10 +325,26 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
 	return -1UL >> 8;
 }
 
+/*
+ * We only want to enforce protection keys on the current process
+ * because we effectively have no access to POR_EL0 for other
+ * processes or any way to tell *which * POR_EL0 in a threaded
+ * process we could use.
+ *
+ * So do not enforce things if the VMA is not from the current
+ * mm, or if we are in a kernel thread.
+ */
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
-	return true;
+	if (!arch_pkeys_enabled())
+		return true;
+
+	/* allow access if the VMA is not one from this process */
+	if (foreign || vma_is_foreign(vma))
+		return true;
+
+	return por_el0_allows_pkey(vma_pkey(vma), write, execute);
 }
 
 #include <asm-generic/mmu_context.h>
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 98ccfda05716..761575bbc943 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -30,6 +30,7 @@
 
 #include <asm/cmpxchg.h>
 #include <asm/fixmap.h>
+#include <asm/por.h>
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
 #include <linux/sched.h>
@@ -143,6 +144,24 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_accessible(mm, pte)	\
 	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
 
+static inline bool por_el0_allows_pkey(u8 pkey, bool write, bool execute)
+{
+	u64 por;
+
+	if (!cpus_have_final_cap(ARM64_HAS_S1POE))
+		return true;
+
+	por = read_sysreg_s(SYS_POR_EL0);
+
+	if (write)
+		return por_elx_allows_write(por, pkey);
+
+	if (execute)
+		return por_elx_allows_exec(por, pkey);
+
+	return por_elx_allows_read(por, pkey);
+}
+
 /*
  * p??_access_permitted() is true for valid user mappings (PTE_USER
  * bit set, subject to the write permission check). For execute-only
@@ -151,7 +170,9 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
  * PTE_VALID bit set.
  */
 #define pte_access_permitted(pte, write) \
-	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && (!(write) || pte_write(pte)))
+	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && \
+	 (!(write) || pte_write(pte)) && \
+	 por_el0_allows_pkey(FIELD_GET(PTE_PO_IDX_MASK, pte_val(pte)), write, false))
 #define pmd_access_permitted(pmd, write) \
 	(pte_access_permitted(pmd_pte(pmd), (write)))
 #define pud_access_permitted(pud, write) \
diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
index 5761fb48fd53..a80c654da93d 100644
--- a/arch/arm64/include/asm/pkeys.h
+++ b/arch/arm64/include/asm/pkeys.h
@@ -10,7 +10,7 @@
 
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2)
 
-#define arch_max_pkey() 0
+#define arch_max_pkey() 7
 
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
@@ -22,33 +22,89 @@ static inline bool arch_pkeys_enabled(void)
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
-	return -1;
+	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
 }
 
 static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 		int prot, int pkey)
 {
-	return -1;
+	if (pkey != -1)
+		return pkey;
+
+	return vma_pkey(vma);
 }
 
 static inline int execute_only_pkey(struct mm_struct *mm)
 {
+	// Execute-only mappings are handled by EPAN/FEAT_PAN3.
+	WARN_ON_ONCE(!cpus_have_final_cap(ARM64_HAS_EPAN));
+
 	return -1;
 }
 
+#define mm_pkey_allocation_map(mm)	(mm->context.pkey_allocation_map)
+#define mm_set_pkey_allocated(mm, pkey) do {		\
+	mm_pkey_allocation_map(mm) |= (1U << pkey);	\
+} while (0)
+#define mm_set_pkey_free(mm, pkey) do {			\
+	mm_pkey_allocation_map(mm) &= ~(1U << pkey);	\
+} while (0)
+
 static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 {
-	return false;
+	/*
+	 * "Allocated" pkeys are those that have been returned
+	 * from pkey_alloc() or pkey 0 which is allocated
+	 * implicitly when the mm is created.
+	 */
+	if (pkey < 0)
+		return false;
+	if (pkey >= arch_max_pkey())
+		return false;
+
+	return mm_pkey_allocation_map(mm) & (1U << pkey);
 }
 
+/*
+ * Returns a positive, 3-bit key on success, or -1 on failure.
+ */
 static inline int mm_pkey_alloc(struct mm_struct *mm)
 {
-	return -1;
+	/*
+	 * Note: this is the one and only place we make sure
+	 * that the pkey is valid as far as the hardware is
+	 * concerned.  The rest of the kernel trusts that
+	 * only good, valid pkeys come out of here.
+	 */
+	u8 all_pkeys_mask = ((1U << arch_max_pkey()) - 1);
+	int ret;
+
+	if (!arch_pkeys_enabled())
+		return -1;
+
+	/*
+	 * Are we out of pkeys?  We must handle this specially
+	 * because ffz() behavior is undefined if there are no
+	 * zeros.
+	 */
+	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
+		return -1;
+
+	ret = ffz(mm_pkey_allocation_map(mm));
+
+	mm_set_pkey_allocated(mm, ret);
+
+	return ret;
 }
 
 static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 {
-	return -EINVAL;
+	if (!mm_pkey_is_allocated(mm, pkey))
+		return -EINVAL;
+
+	mm_set_pkey_free(mm, pkey);
+
+	return 0;
 }
 
 #endif /* _ASM_ARM64_PKEYS_H */
diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
new file mode 100644
index 000000000000..90484dae9920
--- /dev/null
+++ b/arch/arm64/include/asm/por.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Arm Ltd.
+*/
+
+#ifndef _ASM_ARM64_POR_H
+#define _ASM_ARM64_POR_H
+
+#define POR_BITS_PER_PKEY		4
+#define POR_ELx_IDX(por_elx, idx)	(((por_elx) >> (idx * POR_BITS_PER_PKEY)) & 0xf)
+
+static inline bool por_elx_allows_read(u64 por, u8 pkey)
+{
+	u8 perm = POR_ELx_IDX(por, pkey);
+
+	return perm & POE_R;
+}
+
+static inline bool por_elx_allows_write(u64 por, u8 pkey)
+{
+	u8 perm = POR_ELx_IDX(por, pkey);
+
+	return perm & POE_W;
+}
+
+static inline bool por_elx_allows_exec(u64 por, u8 pkey)
+{
+	u8 perm = POR_ELx_IDX(por, pkey);
+
+	return perm & POE_X;
+}
+
+#endif /* _ASM_ARM64_POR_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3b7f354a3ec3..8241bdc365f9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -25,6 +25,7 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/kfence.h>
+#include <linux/pkeys.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -1490,5 +1491,37 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte
 
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
 {
-	return -ENOSPC;
+	u64 new_por = POE_RXW;
+	u64 old_por;
+	u64 pkey_shift;
+
+	if (!arch_pkeys_enabled())
+		return -ENOSPC;
+
+	/*
+	 * This code should only be called with valid 'pkey'
+	 * values originating from in-kernel users.  Complain
+	 * if a bad value is observed.
+	 */
+	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
+		return -EINVAL;
+
+	/* Set the bits we need in POR:  */
+	if (init_val & PKEY_DISABLE_ACCESS)
+		new_por = POE_X;
+	else if (init_val & PKEY_DISABLE_WRITE)
+		new_por = POE_RX;
+
+	/* Shift the bits in to the correct place in POR for pkey: */
+	pkey_shift = pkey * POR_BITS_PER_PKEY;
+	new_por <<= pkey_shift;
+
+	/* Get old POR and mask off any old bits in place: */
+	old_por = read_sysreg_s(SYS_POR_EL0);
+	old_por &= ~(POE_MASK << pkey_shift);
+
+	/* Write old part along with new part: */
+	write_sysreg_s(old_por | new_por, SYS_POR_EL0);
+
+	return 0;
 }
-- 
2.25.1

