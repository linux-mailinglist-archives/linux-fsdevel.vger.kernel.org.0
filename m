Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B37B0633
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjI0OH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjI0OH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:07:27 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ED0F9;
        Wed, 27 Sep 2023 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke3PDuWpvvQbAnmsSjQMMQrblM23IAu41vFemH5NCao=;
 b=IQR/k0k9/DfKrJ/S4f8xeeX8A/FwNUeQ2O1MkVI8zHsEZO5Lo7Ih0Fv+LNatxsL3J7WqClCfdnHC9KvIfCuFAWmdCxYd9n3abgSdzhWp8dJ6hqqmrqTSdvvPeZUXaqoSuQBEbnPDkZrNZN5uaMzqcgFcpZEztwYVlhC4dY+4kd8=
Received: from DB9PR02CA0024.eurprd02.prod.outlook.com (2603:10a6:10:1d9::29)
 by GV2PR08MB9398.eurprd08.prod.outlook.com (2603:10a6:150:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:07:18 +0000
Received: from DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::2f) by DB9PR02CA0024.outlook.office365.com
 (2603:10a6:10:1d9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:07:18 +0000
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
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:07:18 +0000
Received: ("Tessian outbound ab4fc72d2cd4:v211"); Wed, 27 Sep 2023 14:07:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dd94921c2097e8bc
X-CR-MTA-TID: 64aa7808
Received: from 5a96958b8e32.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9A4998BD-A277-48CB-879B-989D2A77549F.1;
        Wed, 27 Sep 2023 14:01:58 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5a96958b8e32.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2CHycpAHVMZQAPmyNTllADynv1x7HnphB+dQn1qGy+h8kwRCN7G8fqM66aIPfW/k8c3kOSZzd8ktf6VC6gz4k0FGCrP4vyko/jHKGEcDJJKq68OFZXvvA6qQDawga5A979ahGbBZIa+0lbwfspwNDDjuXvS7CRFa0kzye45aqLggJ4KU032hxE41R4pmOJv/rVTv/AwsnKjzC77LvFMDc0/gszF65YQyFQtqXvbzix8DFvbrNPbks3Hnt6yzzutP+IVizGrOEBdkmKQfxo0K0r2vlH+EshwSjxCadpkEC8+W8HHVQk85if1jnwmShbiK75xNJDLrtLnNuhZ8sT9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke3PDuWpvvQbAnmsSjQMMQrblM23IAu41vFemH5NCao=;
 b=fbnAPhQsy6WG5d2IhZyWStA09sxc4lAYblSj3meiU6ChLK8zGqRDmveWJ4+4y++4MsYH16KPV7WtWoqnNGyMKRiplpNJSmisZZ/HZCqIa25pnQRxlmS8nAaVSeu7dF2pZVsjqUZlltp08V0AQB8jmWtqvmhna8KWUYBhsNkK9BS8lXWMJEnNP0uJFzPxrW0GM+240BYUSMuCpx/kjxLbhCDow68L4MhuIz3CTVXwGI1Uxkbck92X6+tRhR0Ms1s2F8BOKCB4fKP9FwEv6tK9dNoDBg/7HA3r6dALvi1OcVNCVsS6ONzTjUamEH26OncoY2/pXd/tsoyeZhwsDRUYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke3PDuWpvvQbAnmsSjQMMQrblM23IAu41vFemH5NCao=;
 b=IQR/k0k9/DfKrJ/S4f8xeeX8A/FwNUeQ2O1MkVI8zHsEZO5Lo7Ih0Fv+LNatxsL3J7WqClCfdnHC9KvIfCuFAWmdCxYd9n3abgSdzhWp8dJ6hqqmrqTSdvvPeZUXaqoSuQBEbnPDkZrNZN5uaMzqcgFcpZEztwYVlhC4dY+4kd8=
Received: from AS9P194CA0020.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::20)
 by AS8PR08MB6277.eurprd08.prod.outlook.com (2603:10a6:20b:23d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 14:01:56 +0000
Received: from AM7EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46d:cafe::fa) by AS9P194CA0020.outlook.office365.com
 (2603:10a6:20b:46d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
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
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:43 +0000
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
Subject: [PATCH v1 19/20] selftests: mm: move fpregs printing
Date:   Wed, 27 Sep 2023 15:01:22 +0100
Message-ID: <20230927140123.5283-20-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT013:EE_|AS8PR08MB6277:EE_|DBAEUR03FT049:EE_|GV2PR08MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 930212db-f516-4b05-e6cf-08dbbf630f56
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: AeFqx/mCMbHbYbnIAOiKgMsBIU86pTdcduQ8LR9MKXpW3u+PhhFEo3c+uwMEzvjWEAKKBanA4fWz9b1je4eXrxZffLemV0uxT4loJv25U9ASEj11MVxkSH01ON+OiFuKLJjVf+Qe92N5GnOLM1MgGNbGaW6X2++E5Kys89HrLLn6smDYooJvWWYqMRpiaGfyQNb0P3Gdlg3Io0CeKgebv2niQf0RpUZj7A0IWe2DjmYFFXq7TZvXs/tUnKYQE6VYrNN4YxkeMmq3Q2QtOQL3f0To8MWU0kKxQHCv5HTemb1kJVsZllshu9KiWZBZDerTMZrr0frakbr5maG/KZSoHnUGsGVC1a2p4ZtpzFi5zI2ibGzsoOtjWcMOwIoe9OFVaJ/wE717XrudXrfgD2RaDXObvWpIkqSyh+MHPFBQuHxl/v3YKLymCVa3XeACdSG0Ty2F2EdvD6daQGmokHuEnaAGcSPAp12LeJfil30Mt3SOOfXwcj5c3MOAm5vBYkM6II0FiHyhJdqJEOjiyU6i9irv3PUDkygh3+GhuYJGqbyj9MZa7WqbVbbfh4dBC4/j7qwia71ZXGtolcsPkFq+PHA2ersS5J+mvXbg4ryqJbY1SZ/kBXFjMjbe8V37LITrh2mxjgGvtxBV5otrcdyBRzIw3l9ss9jAxGFWoulHcd4slyFP4wv8v2PjMxG9LQb7496TocZ/EBsDbpgPGz2EiT4OnONpwrUba4vLu+fXBZdpyDHKioEwZwUNinZ9SlUdHmmcHop4y1Gc6joT8k+7ig==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(2906002)(316002)(7416002)(8936002)(44832011)(41300700001)(5660300002)(4326008)(6916009)(54906003)(8676002)(70206006)(70586007)(478600001)(6666004)(7696005)(2616005)(1076003)(26005)(426003)(336012)(40460700003)(83380400001)(47076005)(40480700001)(36860700001)(82740400003)(81166007)(356005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6277
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9096ecc8-2ea2-457a-dd14-08dbbf624fab
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSvPK5YbojvIABsiVQvObrpCPdIYgzwXWI3VIjTYkVpchhRr/CE/QJELX9ZKNIyH6HZm5JibHG8yiri163KZIboY3t6RvmLJT+ZqAVkkR20gEhlXNm2jcioXylU6I86oZ7QDSFRqauumlEHbDrxjQsASIHwLhaqqd7HAM0njJrH0alYoB+UTwblIAM6SxyX40vx8oVsEl/d7cySd/DcJF656ZwJoX19hIT0Kabxh/c7ENzVk6f03Vmg8cVykshXt4bkSP+NI5I442LrlVwbchZQoeKH4D0rCCuF6ZJ0US7EV/TsD1OSLXZ9/qy/NxnZLj3yVfy4zi9/Erv16isLS30/ToQbG3gnLxoRRpBiJzWyPoUF8ynKcTPSHh8Bmb7FWL10mmEZl2L1Rn/cLX/fl6zZMgIG99JxPxmvtYuKjUneO4+sXKtVYxHUcgFmGx/xfGI26VGjaqdoSS2CYRpkR55d9kJ5zFV8o0I/o1CAALoBslvtjVjZyUxH0ZDr7ZoCt5ARCJdodnsMQjeWrmGhdLKToD92u01fSEa34ZMINjiBsw0TAoOLDQAvcs5HfKnyaWEB2HBMkMjVRkFxte1biBl2x+Y4jjqm8jEGUWn8blzQNdCJsQCc2ccNrDR6F6gbEyBfajN/NNziCrXieLjAG5gPk+ctyKx6dWAdh9AgWSDVyaFs/MtLwJo4XHetxkQDgU//X/QwJM6w/T+Zd+jA0MBghCsMUSeGZMdT2DmEHdUvN+iNOOiePBE8TjLjYrB4A
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(41300700001)(316002)(54906003)(70206006)(70586007)(40480700001)(8936002)(4326008)(8676002)(6862004)(2906002)(450100002)(44832011)(478600001)(40460700003)(1076003)(6666004)(26005)(47076005)(7696005)(5660300002)(81166007)(336012)(36756003)(83380400001)(426003)(2616005)(86362001)(36860700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:07:18.2609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930212db-f516-4b05-e6cf-08dbbf630f56
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9398
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

arm64's fpregs are not at a constant offset from sigcontext. Since this is
not an important part of the test, don't print the fpregs pointer on arm64.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 tools/testing/selftests/mm/pkey-powerpc.h    | 1 +
 tools/testing/selftests/mm/pkey-x86.h        | 2 ++
 tools/testing/selftests/mm/protection_keys.c | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
index ae5df26104e5..6275d0f474b3 100644
--- a/tools/testing/selftests/mm/pkey-powerpc.h
+++ b/tools/testing/selftests/mm/pkey-powerpc.h
@@ -9,6 +9,7 @@
 #endif
 #define REG_IP_IDX		PT_NIP
 #define REG_TRAPNO		PT_TRAP
+#define MCONTEXT_FPREGS
 #define gregs			gp_regs
 #define fpregs			fp_regs
 #define si_pkey_offset		0x20
diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index 814758e109c0..b9170a26bfcb 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -15,6 +15,8 @@
 
 #endif
 
+#define MCONTEXT_FPREGS
+
 #ifndef PKEY_DISABLE_ACCESS
 # define PKEY_DISABLE_ACCESS	0x1
 #endif
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 48dc151f8fca..b3dbd76ea27c 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -314,7 +314,9 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	ucontext_t *uctxt = vucontext;
 	int trapno;
 	unsigned long ip;
+#ifdef MCONTEXT_FPREGS
 	char *fpregs;
+#endif
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 	u32 *pkey_reg_ptr;
 	int pkey_reg_offset;
@@ -330,7 +332,9 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 
 	trapno = uctxt->uc_mcontext.gregs[REG_TRAPNO];
 	ip = uctxt->uc_mcontext.gregs[REG_IP_IDX];
+#ifdef MCONTEXT_FPREGS
 	fpregs = (char *) uctxt->uc_mcontext.fpregs;
+#endif
 
 	dprintf2("%s() trapno: %d ip: 0x%016lx info->si_code: %s/%d\n",
 			__func__, trapno, ip, si_code_str(si->si_code),
@@ -359,7 +363,9 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 #endif /* arch */
 
 	dprintf1("siginfo: %p\n", si);
+#ifdef MCONTEXT_FPREGS
 	dprintf1(" fpregs: %p\n", fpregs);
+#endif
 
 	if ((si->si_code == SEGV_MAPERR) ||
 	    (si->si_code == SEGV_ACCERR) ||
-- 
2.25.1

