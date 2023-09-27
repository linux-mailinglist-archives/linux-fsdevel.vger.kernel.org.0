Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379507B0620
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjI0OEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjI0OEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:04:38 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67055121;
        Wed, 27 Sep 2023 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFEjo2t9rOVduPNAJeqfskeri2ER5SQruQHq8BWJZ6w=;
 b=YBszuH0cAsq/i9GkKK54G7LGt1+ciPk18NcE440w5s1rYJpuFMbQQ2Dhx0rHR2HPilO8YaNatJjQBFtbOdIYDd0IKzASdGHZc/DoZ4Xz/9GGL/f61kvGNgShP81TOB1b6baAjiFB9eJhAxl++moX4LeaT7tIJUcNeTAB9mRkBr8=
Received: from DU6P191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::7) by
 DBBPR08MB6234.eurprd08.prod.outlook.com (2603:10a6:10:202::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22; Wed, 27 Sep 2023 14:04:34 +0000
Received: from DBAEUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:53e:cafe::2b) by DU6P191CA0051.outlook.office365.com
 (2603:10a6:10:53e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 14:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT045.mail.protection.outlook.com (100.127.142.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:04:33 +0000
Received: ("Tessian outbound d219f9a4f5c9:v211"); Wed, 27 Sep 2023 14:04:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 115ef5d33959daa6
X-CR-MTA-TID: 64aa7808
Received: from b618c45c74c0.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E6CA58FB-CBCF-4860-9E12-600891D4B576.1;
        Wed, 27 Sep 2023 14:01:59 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b618c45c74c0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlJSBRrQd9zuF0qGFRfJXE4x5iSynws/+DTgoCGPghUf8zA7MlKixoJEJ07jGEREcJkbJSE7RHmk5SX7Jps8YWbsTMPGZY1mwmRcqkwUIWChzuKxeT1bBrC9VK68F4XxJkHaFaW7w/U38FpFLneLB4W0slmFLWP8JrV/LjumirReC4nXs8SgwH7nSvqEhtzKCtIT3elIwtJtpA8W3+EYznoWElI4axybEC88eQuaOMlkpDAyODdW7/7Q0YMpkg//+3TeWqAYuh6C8Cc59Uk/tzmUPIfwpwo4+Gbl7JJHE1MYHXFA9iPoP28w6C3GE4RXxL8kAgjYJchlbv6p36pXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFEjo2t9rOVduPNAJeqfskeri2ER5SQruQHq8BWJZ6w=;
 b=HuR9MoBSG4WO5/udbccZNmcDRuRPj1tLaYXCGmHfDzjmH4q7LkUYtJjHXBeYLOb2Bg+z3vb2KtG6Tgftbm7f49e5DIVRNr/UqGf/xAg8nJlraURiOJJAxuc69dDDfdiBkOecKxJi63afVqRRHNJsbrn8qOyZfbDqUwX6y7P5SNUOMcDsdpIMEjFOJzaOlweAC58EQj3q6LAswAzTibdGhTXtxfA96mtC4WfZzqrsWPKYptKNZW/Gm1r5ujwbujs5V0vgPPwPn9pLnTXJyS+uwQHytCb0onWiSePYEbJ4gg4n5Yb+QEsCNRtSYiXN0IEknWcBPbYxBHm+zH2kr4pe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFEjo2t9rOVduPNAJeqfskeri2ER5SQruQHq8BWJZ6w=;
 b=YBszuH0cAsq/i9GkKK54G7LGt1+ciPk18NcE440w5s1rYJpuFMbQQ2Dhx0rHR2HPilO8YaNatJjQBFtbOdIYDd0IKzASdGHZc/DoZ4Xz/9GGL/f61kvGNgShP81TOB1b6baAjiFB9eJhAxl++moX4LeaT7tIJUcNeTAB9mRkBr8=
Received: from AS9P194CA0005.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::13)
 by AS8PR08MB8275.eurprd08.prod.outlook.com (2603:10a6:20b:56f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 27 Sep
 2023 14:01:56 +0000
Received: from AM7EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46d:cafe::7d) by AS9P194CA0005.outlook.office365.com
 (2603:10a6:20b:46d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT013.mail.protection.outlook.com (100.127.140.191) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:01:56 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:43 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:42 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:42 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <nd@arm.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <catalin.marinas@arm.com>,
        <dave.hansen@linux.intel.com>, <joey.gouly@arm.com>,
        <maz@kernel.org>, <oliver.upton@linux.dev>, <shuah@kernel.org>,
        <will@kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 18/20] kselftest/arm64: move get_header()
Date:   Wed, 27 Sep 2023 15:01:21 +0100
Message-ID: <20230927140123.5283-19-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT013:EE_|AS8PR08MB8275:EE_|DBAEUR03FT045:EE_|DBBPR08MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e63ccc8-f74f-49c4-66a3-08dbbf62ad67
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jFDFJ73sw6DGXXsVRdE2jbsvQ66GIiN8BVTv6KPgRx9n5Y4Ecgj9LeeXkb7MeFfka5D6mnTreBUIMhXKa48S2FxVXe5dY0ETh5dAay10vRMCqGVPtN42CBovbNCxOqlGL8rDv9jRPz/TFBMZTShLoxZzq7XZRY2PwztUh7uoIfn7d2hE7wLahlFt2fm3PW30ZDznxAO2+/vXtlHmCT9cpIww9gEBwYJ8uGAN/i9c3TQDjIiN0TPuI2RVLMrpGK8HjacTlNkuJhNdrGyDbLC3f9Vh2nNHYNJs6H5hw5zbC7D0DbEg+isl99hODMo3CgGqKjdi9oRsiR9AfOru9zLKqBHJsrSiGPRYob6iDJUdg2N2NH2+7nVj7Wf6uIapwkQdXxPj7P9Pwrk9qYD6rcOQsTgOSMESi0nVa2PhX4o3E2rSEBLYzPVy5lkT2Cga7nCh+xbbCQ2bOOfT+wsdz/HlsjLdL3mjPPEgv39m/DeVZkepT/JK+FJjwutP61NUOovuZhUBMYtM94sIP6/MiStoVz75RoG9cKDPI5DP6Ct1DmUq0+WpX2QC6KZxRRPlR+MX7n8SlfkWhXg8bI7eQwuHQLuAkZF365ldtJ46sb5Budc7kwxrrEyUBLgeyCHI8H9ct6fMq869vY+gYxtqBwBcKadVES3vm/kC2eHW0msTN8/kvHqeeoqbTaDuEFFtVnJ0fmBS4TCEa1O6dFAFSKjpUtiWBsstWOO4wZoz1e8J8g1sU/hQV7ZVZHYcW7ksHGkBAzNidN4H6OJ/eUYAAtbDZA==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(6666004)(40460700003)(36860700001)(36756003)(7696005)(82740400003)(356005)(83380400001)(86362001)(81166007)(47076005)(2616005)(426003)(6916009)(316002)(26005)(1076003)(54906003)(70206006)(40480700001)(7416002)(41300700001)(2906002)(70586007)(8936002)(5660300002)(44832011)(8676002)(4326008)(336012)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8275
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e400a40d-5a52-4a00-a7c2-08dbbf624f53
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrF8+W/NVer5UTqzG8qqitWHvUimpulaNQJwobXGqhk5WUa5pIyUFRIXpdFfXv2iLMA2MMUQaz3g1xQn5lZxzPaCofs724/HnLqvdIXwdAWyvy97zeVvAjsmamnybQ9MrDEzfNnRmzKN1OxCr7VvBadakLBjGBDDmH89i1cZ7ZvoyNyd1gBrVzKn2M3VddRj6P98xuNmz+Mnj9QhZKJJxJZPGDl4ziUQWoF/je7Iqs3p4W+vxvPDz/NLH2pWG6wjdeA5Wtiw9djwGnCrbKiIM4gPNXZqWcjYPoYVAPUNbZhqbN93AJT947A+bCqAJLAT2R/DVaQoyAS3j0jI5D8bTAFm+h2VMPD7b3AItnCQGSLgJTwbzVxrpphXqRdoTQdHOlXyMpyCTrl+YOkVOcYw4NvXRNEJUZWrS0OokTVuYrn4a97lSo2nxjF45ABTMgTZggTwkQK2aiMSVgp2NcobNtfjDflp0Ct2W9OlIBKBqWT2Etix0Fm9sC1VcJlTCvfQoKRwfLnLZlDFSBoQMSAD5NDQpHlkCDVOahPd8eqcBSrGJAiBEVvz4lw9BigUlY91nwoQwwieTHmB2Lqr1tPwdV1JhKZf3k3SorG44XjtCt6GDt9K0CBjEpcA0GXh8/TWCPx9Et06/L8mvQ0t2Hys5Gt2k77y310rWEXiWTyVuMrBzueta9n701bsrNP3IiBRKVxGlJ6/qbI8h2l+BQL9qNyg8bDMQ21FJf5fM2d43PE1kcx5QWME1hcaSr6ge0OE
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(478600001)(2616005)(36756003)(1076003)(426003)(26005)(336012)(82740400003)(81166007)(86362001)(47076005)(83380400001)(36860700001)(40480700001)(6666004)(7696005)(316002)(70586007)(70206006)(54906003)(450100002)(41300700001)(44832011)(5660300002)(8936002)(8676002)(6862004)(4326008)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:04:33.9523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e63ccc8-f74f-49c4-66a3-08dbbf62ad67
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6234
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Put this function in the header so that it can be used by other tests, without
needing to link to testcases.c.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 .../arm64/signal/testcases/testcases.c        | 23 -------------------
 .../arm64/signal/testcases/testcases.h        | 23 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 9f580b55b388..fe950b6bca6b 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -6,29 +6,6 @@
 
 #include "testcases.h"
 
-struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
-				size_t resv_sz, size_t *offset)
-{
-	size_t offs = 0;
-	struct _aarch64_ctx *found = NULL;
-
-	if (!head || resv_sz < HDR_SZ)
-		return found;
-
-	while (offs <= resv_sz - HDR_SZ &&
-	       head->magic != magic && head->magic) {
-		offs += head->size;
-		head = GET_RESV_NEXT_HEAD(head);
-	}
-	if (head->magic == magic) {
-		found = head;
-		if (offset)
-			*offset = offs;
-	}
-
-	return found;
-}
-
 bool validate_extra_context(struct extra_context *extra, char **err,
 			    void **extra_data, size_t *extra_size)
 {
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index a08ab0d6207a..c9bd18e7c538 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -88,7 +88,28 @@ struct fake_sigframe {
 bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err);
 
 struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
-				size_t resv_sz, size_t *offset);
+				size_t resv_sz, size_t *offset)
+{
+	size_t offs = 0;
+	struct _aarch64_ctx *found = NULL;
+
+	if (!head || resv_sz < HDR_SZ)
+		return found;
+
+	while (offs <= resv_sz - HDR_SZ &&
+	       head->magic != magic && head->magic) {
+		offs += head->size;
+		head = GET_RESV_NEXT_HEAD(head);
+	}
+	if (head->magic == magic) {
+		found = head;
+		if (offset)
+			*offset = offs;
+	}
+
+	return found;
+}
+
 
 static inline struct _aarch64_ctx *get_terminator(struct _aarch64_ctx *head,
 						  size_t resv_sz,
-- 
2.25.1

