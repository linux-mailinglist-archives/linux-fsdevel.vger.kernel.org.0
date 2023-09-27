Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF3C7B0622
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjI0OEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjI0OEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:04:38 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B8FFC;
        Wed, 27 Sep 2023 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od0l8mHSmhLv4umuTQwuKNu3i05N7Ly/I3FztsMYFC0=;
 b=akfdtKzCRWyPyTnfUzlVFcILOoFs/X+BHxOoZO36rgkqEmPBKOl3rU06ptwftgMd2MekPOCX/PrevjniHKaVSZAG0w6sT2wl89mmyyEQAdVDtgeYvwqMyFWVvj3VUd0N9N7iIJxHZnKi/5uoztbxae6m77NvYLJHa/hdnIJlx5I=
Received: from DU2PR04CA0323.eurprd04.prod.outlook.com (2603:10a6:10:2b5::28)
 by AS8PR08MB6232.eurprd08.prod.outlook.com (2603:10a6:20b:296::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 14:04:21 +0000
Received: from DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b5:cafe::c) by DU2PR04CA0323.outlook.office365.com
 (2603:10a6:10:2b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 14:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT020.mail.protection.outlook.com (100.127.143.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19 via Frontend Transport; Wed, 27 Sep 2023 14:04:21 +0000
Received: ("Tessian outbound ee9c7f88acf7:v211"); Wed, 27 Sep 2023 14:04:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d5b120ad5dc25d2d
X-CR-MTA-TID: 64aa7808
Received: from 1113c25b9f7b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 662B7813-5865-44DF-9FBF-61CA59EFE735.1;
        Wed, 27 Sep 2023 14:01:57 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1113c25b9f7b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwBz08+uKQozklGnMLpdumFZr9TmwJghIDx5KPf4hXo7Nyg3INiY8jTSbotAJ5sCBtZaaqj9jgDrEz6K5wzTaa7tkr5vw+Nyhj0wLtnRa5/bsnOLCOmC7qYOibkIpusDPgJvBv4J9ANedevZ61URtm1cye1hGIjMtnHJgx+rIGms60I8Emz5kjCzDo8fMVE+50fC6RjTMz5jgveN3CArpdgiQQZFqUQJ7uhO/dkWWYNvRSWlqlfQhfncecOe9R5R2ctGUKS5NyK0LE52j1+IZDl4hRysbgwCBd15VIPzXzhIfz0AzNyswAs0hJCdaKeckIAYT0riZPPErz2A46CUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Od0l8mHSmhLv4umuTQwuKNu3i05N7Ly/I3FztsMYFC0=;
 b=OAE5WIxeYHStQfoi555s3AWdBaSRg+fjFR7Lnt86po+DdknQNQyopbwwHxYCoH8h5aHUip6irDwi2PvsPsV0tPnrHj+ccfrHz3laDkI0X6mKwPmpL+cfbZxsndAyEAtl5aFbOmNbM3eVfjscVWkE8k5isfZHeuYbBN0eKBxuriQuZ16yJhoK0HrIMh939H9CdRChvsgxVFyH6j106+Crm8OCEsiEt7j/0awRcD08+zMScK2GgJZYdC/Evm47vp4CADcxXccIDsSUvU5Z0qvYoT4IjcHRcpMYtIXF36U9nnma2B8uyM29fkhy/70Qs565tSU12BYW+Xfjv9n+z6ixHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od0l8mHSmhLv4umuTQwuKNu3i05N7Ly/I3FztsMYFC0=;
 b=akfdtKzCRWyPyTnfUzlVFcILOoFs/X+BHxOoZO36rgkqEmPBKOl3rU06ptwftgMd2MekPOCX/PrevjniHKaVSZAG0w6sT2wl89mmyyEQAdVDtgeYvwqMyFWVvj3VUd0N9N7iIJxHZnKi/5uoztbxae6m77NvYLJHa/hdnIJlx5I=
Received: from AS9P194CA0010.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::10)
 by DBAPR08MB5797.eurprd08.prod.outlook.com (2603:10a6:10:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 14:01:54 +0000
Received: from AM7EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46d:cafe::3c) by AS9P194CA0010.outlook.office365.com
 (2603:10a6:20b:46d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT013.mail.protection.outlook.com (100.127.140.191) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:01:54 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:41 +0000
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
Subject: [PATCH v1 15/20] arm64: add POE signal support
Date:   Wed, 27 Sep 2023 15:01:18 +0100
Message-ID: <20230927140123.5283-16-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT013:EE_|DBAPR08MB5797:EE_|DBAEUR03FT020:EE_|AS8PR08MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 087db9f8-7896-48c3-5ace-08dbbf62a611
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CQdD+2jBTYY2KgNKgi4Az6yHoQoUULetqFrzsQQjO+TmKnj64pXs5WPZrcMdNLtmJ8+60fQsHcn1z5G1JbrOWqVuL6wJZL8Rln8x8p/wGP4fryTcEoKu4BVFAGKI15XS1WlRXcC10TQzjtq+Dv5J1lnwt8iBhCfe5npM+HKhLhME+fZS6IV3z23JJYSHGA8nMevbc606N7z4Ads0D856TBIIQh12WO1RObr8F3ZSJjhfYkeX+fdL6Hoy+4iShbQtTkJBdIZhY2lsBwBqPsdJpm+3mL1A4TpI9nLaPTeL2NjavNLtwcmUMvWWNgp25/rX/0DtYLGKKHx8fcBAzcX2QWivi/+DiUQPFWEjZOr2s+R+hLnjIYTWpjonQiljVYEHMkpjkdbKF3XK7hLIQ/KlZVVKpjW5CYju9+soVUUPIakwAYp6k2keiC0bn9JWRFcsSwK3w/mhnjxerTaTOmf6EgwvYPL/W126YVagWxybSM7U97DkyJhdaXEEidYBeaZ028dYn8Lsx8Gq4hLuEHUl2AA2LTh+WFia8SJU6jsJEJfqLUWD1tg+8TEKi2xQsOaY0CJ7ZDe6UY2U+/K+VkpmrzVeoLSiFpopQ1DOLyCErUoVLODPZ5UGPojQ8ABeh3Yt2vDSgMLugTgyJK0txHv4mflz0LGIisYLEwcCrCXBaTy09R4EEoy+DvGyhIWl1zQPIgKUgsLmoRaCEpE1O+pIb9iXnUogzu5Tw0nUP63qZbkbZtSoL2VzJHl1z9VHpV9x
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(86362001)(356005)(81166007)(5660300002)(41300700001)(8676002)(44832011)(8936002)(4326008)(40480700001)(7416002)(82740400003)(2906002)(7696005)(6666004)(478600001)(47076005)(83380400001)(1076003)(2616005)(426003)(336012)(36756003)(26005)(54906003)(316002)(6916009)(70206006)(70586007)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5797
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0abdeaf9-fd23-49d2-2eb6-08dbbf624e52
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvJpdosxbv6JypBOAva1Al/SM6peISc1LFL20Fqxl4Xn5hWryMCohNWGJzWrbTPDyaNJIqEjDnjJRxplP9Ls93/DC9eGGVYvdkDg/4ygkTnjK12BYodg3yZn/SJZglcc5C9w05j0GGEHpte02XtsuFlPrJkfmhSIaGbUeB8pmwXaEbd4eX7n8ijWLP+kB60cX7lzkBGXNEfR5J7qy1iXjfj7zfkoreIKYxqHe1x7i/7yA66/o2t8dtZ0QndfuM93CZbGPqBTHPVIhDaY5iqhbuh5yIQc8E5W9aAahvpUk1ie5uTmMBc7MeUtrQJOrpkqjo0txOsy5TUiFQ90Te0hbUvReY4hcZNukeJ3B+5ulrex6u98Ot47UjqVBFNKP5wsL9eesJ49VfCIv/VZpCHGrVheWrcbbYk5uEBd2qzggIWEZ9t1KVIr3yyNO04gPy3xTUaG8p2xNHoWt3Sm0pCHTX5rfgLD67oNHIkxKSsrhDR6Atp+xXhMtyeZa9UNBrMBV4Vuk+rbEc9DQI7j1Qli4PoDc2hVnwwfTQn93EjBSaYi7ibk5fSCXX4ZRwc4u5snXVAjqWdKUwG7dI5QJcWh8sixUdIIenbdgh2mVIWqEVVmBD28s/WyejNq3Pl+TbgJwL5Kd1fi+qt43vmqd+ZlYHCNNChr1JZ4E9CxejNYD1u31fQY63Mo6qBd+NYOLp5BEB7l5PYhuHOpS/WLe9AeWYFTWjHSwUrB57naJYVEwAf07ExvZJ96/e5zdm4bNU0I
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(6666004)(7696005)(83380400001)(2906002)(478600001)(450100002)(70206006)(8936002)(6862004)(8676002)(44832011)(426003)(336012)(5660300002)(1076003)(26005)(4326008)(70586007)(36860700001)(47076005)(54906003)(41300700001)(2616005)(316002)(82740400003)(81166007)(86362001)(36756003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:04:21.6443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087db9f8-7896-48c3-5ace-08dbbf62a611
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6232
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++
 arch/arm64/kernel/signal.c               | 51 ++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index f23c1dc3f002..cef85eeaf541 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -98,6 +98,13 @@ struct esr_context {
 	__u64 esr;
 };
 
+#define POE_MAGIC	0x504f4530
+
+struct poe_context {
+	struct _aarch64_ctx head;
+	__u64 por_el0;
+};
+
 /*
  * extra_context: describes extra space in the signal frame for
  * additional structures that don't fit in sigcontext.__reserved[].
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0e8beb3349ea..3517271ae0dc 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -62,6 +62,7 @@ struct rt_sigframe_user_layout {
 	unsigned long zt_offset;
 	unsigned long extra_offset;
 	unsigned long end_offset;
+	unsigned long poe_offset;
 };
 
 #define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
@@ -182,6 +183,8 @@ struct user_ctxs {
 	u32 za_size;
 	struct zt_context __user *zt;
 	u32 zt_size;
+	struct poe_context __user *poe;
+	u32 poe_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -227,6 +230,20 @@ static int restore_fpsimd_context(struct user_ctxs *user)
 	return err ? -EFAULT : 0;
 }
 
+static int restore_poe_context(struct user_ctxs *user)
+{
+	u64 por_el0;
+	int err = 0;
+
+	if (user->poe_size != sizeof(*user->poe))
+		return -EINVAL;
+
+	__get_user_error(por_el0, &(user->poe->por_el0), err);
+	if (!err)
+		write_sysreg_s(por_el0, SYS_POR_EL0);
+
+	return err;
+}
 
 #ifdef CONFIG_ARM64_SVE
 
@@ -590,6 +607,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->tpidr2 = NULL;
 	user->za = NULL;
 	user->zt = NULL;
+	user->poe = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -640,6 +658,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			/* ignore */
 			break;
 
+		case POE_MAGIC:
+			if (!cpus_have_final_cap(ARM64_HAS_S1POE))
+				goto invalid;
+
+			if (user->poe)
+				goto invalid;
+
+			user->poe = (struct poe_context __user *)head;
+			user->poe_size = size;
+			break;
+
 		case SVE_MAGIC:
 			if (!system_supports_sve() && !system_supports_sme())
 				goto invalid;
@@ -812,6 +841,9 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0 && system_supports_sme2() && user.zt)
 		err = restore_zt_context(&user);
 
+	if (err == 0 && cpus_have_final_cap(ARM64_HAS_S1POE) && user.poe)
+		err = restore_poe_context(&user);
+
 	return err;
 }
 
@@ -928,6 +960,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 		}
 	}
 
+	if (cpus_have_const_cap(ARM64_HAS_S1POE)) {
+		err = sigframe_alloc(user, &user->poe_offset,
+				     sizeof(struct poe_context));
+		if (err)
+			return err;
+	}
+
 	return sigframe_alloc_end(user);
 }
 
@@ -968,6 +1007,15 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
 	}
 
+	if (cpus_have_final_cap(ARM64_HAS_S1POE) && err == 0 && user->poe_offset) {
+		struct poe_context __user *poe_ctx =
+			apply_user_offset(user, user->poe_offset);
+
+		__put_user_error(POE_MAGIC, &poe_ctx->head.magic, err);
+		__put_user_error(sizeof(*poe_ctx), &poe_ctx->head.size, err);
+		__put_user_error(read_sysreg_s(SYS_POR_EL0), &poe_ctx->por_el0, err);
+	}
+
 	/* Scalable Vector Extension state (including streaming), if present */
 	if ((system_supports_sve() || system_supports_sme()) &&
 	    err == 0 && user->sve_offset) {
@@ -1119,6 +1167,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		sme_smstop();
 	}
 
+	if (cpus_have_final_cap(ARM64_HAS_S1POE))
+		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
+
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
 	else
-- 
2.25.1

