Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234257B0619
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjI0OEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjI0OET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:04:19 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2075.outbound.protection.outlook.com [40.107.15.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EEDFC;
        Wed, 27 Sep 2023 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VQGAj4qR6U+8jKxuVwzh/GHnDbH08pkNQ+bUlJJPsc=;
 b=9TPs09nxcTm4craLfXoIPoOcRy9TnmGcC8xPd9DmsxMZKeKCYMgInNCerhij8b9rJ4YMEm7H3Bx+GQqhORA2RlS4QAvfB8a8VQlmA51RrJL70uREkm8wbEj2uIqLUQGZK048UZcZoLq4xPMFVIU703ym2YSyNZ8bs+MRQUv4fOQ=
Received: from DB9PR02CA0023.eurprd02.prod.outlook.com (2603:10a6:10:1d9::28)
 by AS4PR08MB8046.eurprd08.prod.outlook.com (2603:10a6:20b:586::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:04:15 +0000
Received: from DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::bc) by DB9PR02CA0023.outlook.office365.com
 (2603:10a6:10:1d9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT049.mail.protection.outlook.com (100.127.142.192) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:04:15 +0000
Received: ("Tessian outbound fdf44c93bd44:v211"); Wed, 27 Sep 2023 14:04:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 42ac1b4d537efab2
X-CR-MTA-TID: 64aa7808
Received: from 5eaaccc83e9e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B86F6B30-FE61-45D1-8200-D8AA3A5C2D2A.1;
        Wed, 27 Sep 2023 14:01:57 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5eaaccc83e9e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKBgjOtP6+7X55OKYedk6tljzxBdZ8lqy1KG3lwNkp0+jiHHsTOH2tlfkE6gikz1dcKgmIuQXhihwtDVDyYny8jeTxmasz/Tza78CJhPjJuIoASretrGRmD2dIsjziCRqOeM1YxNpFKpzgkeqvpE6LpAEyyhHbUw1N+HDgFJFUl8xGEdiBx/Dvv20lJx0VZY61J1mfRJMwTN3mFJ7yB7JP6hC6uNzwRAl+tdzSSRRS3jIhEdCUXp8D3S3o4r1+15wYEg1MrEN56oGe0J2kDzEfZOQoLXAuWPcsvG4Cg377qsfYfaumXfqR476nf72uIAJ+B5OSDRWm0oh7nSKxsTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VQGAj4qR6U+8jKxuVwzh/GHnDbH08pkNQ+bUlJJPsc=;
 b=ZDa9W3PwsVV/9VRtwl/VjBrwqsQkVMB8aNg0+WrXtxr44JAXd2YpMbg/mjJxu8Pual3oll9rfmqe1cZshz9jpUFLtoWfK1kMsdy4jpRL7NkaEGx+AytZeUW7K14a5RWphu7vDMs4+rU6+dfyP8fanh42jOY+gN25srKwv7qFuDaEKMsscPN5SaBDFhnkGYvHeWxPCyxuTdF/2FBPmr3MsHBwkbAhyXAMBpnE61estRdNuSavcpzn0q6NEU07PKtdz+cHquFF8wmhvVjBbJOMqlmj+6hGM0Cc3zMNcLvNjONzvtToMa3LcWtIhWVVBh/XZh+rwttMYWb3deXAvWwAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VQGAj4qR6U+8jKxuVwzh/GHnDbH08pkNQ+bUlJJPsc=;
 b=9TPs09nxcTm4craLfXoIPoOcRy9TnmGcC8xPd9DmsxMZKeKCYMgInNCerhij8b9rJ4YMEm7H3Bx+GQqhORA2RlS4QAvfB8a8VQlmA51RrJL70uREkm8wbEj2uIqLUQGZK048UZcZoLq4xPMFVIU703ym2YSyNZ8bs+MRQUv4fOQ=
Received: from DB7PR02CA0027.eurprd02.prod.outlook.com (2603:10a6:10:52::40)
 by AM0PR08MB5441.eurprd08.prod.outlook.com (2603:10a6:208:17d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 14:01:54 +0000
Received: from DBAEUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::f0) by DB7PR02CA0027.outlook.office365.com
 (2603:10a6:10:52::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT015.mail.protection.outlook.com (100.127.142.112) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 14:01:53 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:42 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:41 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:41 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <nd@arm.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <catalin.marinas@arm.com>,
        <dave.hansen@linux.intel.com>, <joey.gouly@arm.com>,
        <maz@kernel.org>, <oliver.upton@linux.dev>, <shuah@kernel.org>,
        <will@kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 16/20] arm64: enable PKEY support for CPUs with S1POE
Date:   Wed, 27 Sep 2023 15:01:19 +0100
Message-ID: <20230927140123.5283-17-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT015:EE_|AM0PR08MB5441:EE_|DBAEUR03FT049:EE_|AS4PR08MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: f771a1fb-5843-40da-dec7-08dbbf62a23d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9QotwCpk5z2/3NXGxqu7I5UPz1xcD4RFUXShxnoZySw2z6V9qP5OGfAgD/Zb2w+TawdOGFMSd2NtzyfmhwYuPyS0c3YhXfnK9p5aIIKQVB2g/Tp/2IfNFNpn3/I2s45gY7aBgVkqPmLsjNcmwnN2zG9k7bCTAafPM3h036IsoOOeH6KzT+16SdNANZMAMrDP+UT7CUYgTN4YM6oIlwLl4k+ifNAwswZpjuTzjZvnGw7gWxLgoogpuldYP1aLYDqhjBCTS4ZxvgcraJ87M3/6umcAVFA2wWO+OSG9FfK2kg2NNRht7jg1ODmAIeLTeDsVCL1m9U2ds7hpBkPlOOATpvQzYonxzGZhpr0BKsj+2rNbil85SDji64eRPBtoPjXOR6Y35kpkpzOmtfF/URsLtYa7LEJVg8ZIQF5yp++N3Hh3U6/Q701RKo7Sm3u0VS6pBoCZnfCim8u+O512D9EGLy6YD/ooyMboKHH3r5TIwGL4HVdiPhVo2YVvlv5wsNIrGuiP+RBOpyBWQxkSek4oG+3pkbkOOrNX2b2mcnmDSxMp6Y4DFYmOaEXFln2tIDMXLhwuvL/Stw2MU6On3DPeevfDvvA128hz0023hRoZStWNSg05RGLfb9UTVOd3u/33xYxADNbZS6R3bSeje/icv7XfpkRlO8I6a6a8xvFeDzfWZusVx9gY/az40b+ggHBXYQX4eVLyUhSFWRe6CjmrBQawpkl6abPZ7CJszxW1azyWjLnMijrB5Di4XroLmxI4KjBFZae8yOt+iCV9tBjVErbrWOWVLbVzMdXe9Ey2c7Q=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(41300700001)(5660300002)(44832011)(26005)(426003)(336012)(2906002)(4744005)(316002)(54906003)(7416002)(6916009)(8936002)(8676002)(4326008)(7696005)(478600001)(6666004)(1076003)(2616005)(47076005)(83380400001)(70206006)(70586007)(36860700001)(81166007)(356005)(82740400003)(36756003)(86362001)(40460700003)(40480700001)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5441
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 528f1ca5-8a08-4ffd-c9c0-08dbbf624dec
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qs22hj1mER5M16iIKeWoMKKtbnCMqKhtk4eQDOBGcuuSMNSyuxKd00IEt8kPExUpmkzKMH2kIttfglOIGFnWMFkUrr/SYrakSKAGAg5oXDW13jWbxlGuKXBxB+eT82OdKn4KepP41SSyx2p5JmVeME7jsOvE4zLNNcIgPCh0qAX0cxuPL5E4LoUcGbRVuHvBADv/8itr12WfYbg9ksV5NGRlABt6kzsl/zwOwdchXw4BuhSIwxdcAJ1dlL3LDCWgCYUObOvLqCu/4WTwEBzsR1tJPh2t9Fu6eNVnfrgr4rgkY4qgSxyfa0/APO23u6GdbTVIz9OuGwwOhokUq4DEEJwmMP7Kpfkjz8zLmgcwFdyb+HEoNsZV5Rad4Qw6pAxU9dA7wesfy3mbVOAOtE1OSGI0rKD3eILI9lRDKVhhf421YEjNG5JtT3Xp8SaM1sq6/rqzCvsU0aS+16kDWt3Ip2h+v6F+QjsNX57OWmCIc7oe1X02X/WA5aNif5H7EmZ5OIZijSVB9/EWIacfl8NFL28OivbUHFwqKKm16y6SIRNOacGWiGdkGm+23xgqzxgEqjkIpV8EBvetTipl2IVgHa9Yp8rR3nFg8z2DY2FqGWigKdibXUUf3RPGm7jPdi36k4ZhiZXDeup2IYB3A9aqZ/ZV6t0gk7zisxtJY4VYQj36bdMlTEeExgruyzU48EX9QhO24hP+Zv9USC/np/UPmYLnO1NZhDLsb/PyA2lySaHMqMsSwQERbKmDHHGc20kIkkAw7JRM/OKtySas5YwuFg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(26005)(40460700003)(6666004)(478600001)(1076003)(2616005)(36756003)(426003)(336012)(82740400003)(83380400001)(81166007)(86362001)(47076005)(36860700001)(5660300002)(7696005)(40480700001)(6862004)(4326008)(8676002)(8936002)(41300700001)(2906002)(54906003)(316002)(70586007)(70206006)(4744005)(450100002)(44832011)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:04:15.1939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f771a1fb-5843-40da-dec7-08dbbf62a23d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8046
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that PKEYs support has been implemented, enable it for CPUs that
support S1POE.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pkeys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
index a80c654da93d..9946de35035d 100644
--- a/arch/arm64/include/asm/pkeys.h
+++ b/arch/arm64/include/asm/pkeys.h
@@ -17,7 +17,7 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 
 static inline bool arch_pkeys_enabled(void)
 {
-	return false;
+	return cpus_have_final_cap(ARM64_HAS_S1POE);
 }
 
 static inline int vma_pkey(struct vm_area_struct *vma)
-- 
2.25.1

