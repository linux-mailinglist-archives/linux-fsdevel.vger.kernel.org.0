Return-Path: <linux-fsdevel+bounces-952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085C97D3F3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1737281446
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA521A01;
	Mon, 23 Oct 2023 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="DBh37n3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D0219FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:30:57 +0000 (UTC)
Received: from outbound-ip201a.ess.barracuda.com (outbound-ip201a.ess.barracuda.com [209.222.82.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F6CB7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:30:53 -0700 (PDT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168]) by mx-outbound9-90.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Oct 2023 18:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPWM6guhdrVIQUulLMdDXI5ZhOWGg/FtyvMTGiiCORfSlJBH89j/F4gC2hf8U9YGbCdg9slNik/+7nn1GVCyRZV/HOv9/ZiVGDohiSSwMv3l/pFzaE5Le31Ngo8bRJFBFSXzxFAY/blRZh66D7SUjxosL+Nj8FB182lSrfDa+7juhlrWH+LXmHCJksoyFqLSEWxq0euOBcivt41IOsrqn5VViy83/eU9ToCiQSuTseR0nq4ABfByGwGiivfFfB8wmGfZBv47I8uv3ek6bgpuin/YVP9WuFrzzs5Ysox5UCURhAn5kftZ0iNMIq+bhH2bMFDa2TffWlSoA0itTPYUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WWczKfaRQhshgqOcBZ665ss0z+UHAPvodp3cbFjRNE=;
 b=O9L+VAY5fxaLbZM2fQOMQZSAwofQF/8UG6JsxTFIisML/Qn5dYF3UvwfcJ/VzojBTFxUNra0bLzMGeTLy5gQDiOwwO1416+BmOiGEOl6V8KcjczJt94ZSDVvuwFpoNwW5CecgULRG16LEAIhvq6VRV5gJjKQv+fJrISFl301Xq6CnVSWVtuBVXlB3f8Qw22F1I8NOTDFTZ7WbS8XF0Rd5l7jRZSpUv029CF3skSDddAKT8sg7jqCg0evd1joBHJXlixhl2cy3YMyot/OaEnZIVzhlIRjB1+0q7Nv7/AHBowfpFz/jzyJ5hLtSSFSmt8JY6aC7Z6TofGRRC0WKOaWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WWczKfaRQhshgqOcBZ665ss0z+UHAPvodp3cbFjRNE=;
 b=DBh37n3ilA4Q4EfHTbzWUL39GvKCWY4zlFN4Z06Al6ZdnbNLHkNq9ZOT6j1qkWk+rL3KED9PuCOujs7cMq3f7kWFkKJvon7kaom8kt1b6Z/5G9rrc9K7AqV7NWNfS5MKOpNQk99n8eYGWcOz3YHh/M1ooY0Pe8AmDsqmSQH+KM0=
Received: from BN9PR03CA0495.namprd03.prod.outlook.com (2603:10b6:408:130::20)
 by MW4PR19MB6983.namprd19.prod.outlook.com (2603:10b6:303:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Mon, 23 Oct
 2023 18:30:45 +0000
Received: from BN8NAM04FT028.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::32) by BN9PR03CA0495.outlook.office365.com
 (2603:10b6:408:130::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT028.mail.protection.outlook.com (10.13.160.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.16 via Frontend Transport; Mon, 23 Oct 2023 18:30:44 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 6A95A20C684B;
	Mon, 23 Oct 2023 12:31:48 -0600 (MDT)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH v10 6/8] fuse: Return D_REVALIDATE_ATOMIC for cached dentries
Date: Mon, 23 Oct 2023 20:30:33 +0200
Message-Id: <20231023183035.11035-7-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023183035.11035-1-bschubert@ddn.com>
References: <20231023183035.11035-1-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT028:EE_|MW4PR19MB6983:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 12a4c581-e4d0-45dc-0093-08dbd3f62b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PscQ1QkpkjsiSx4pXJKkEHwJt83f+uGacsFKDL6eYpoeX4LdUjwAN8EEG03G/ospXBkBkODb14meET1hgwx+FqBzBJ4Sngw2nXzuo6BQdhoYs2kQb/fNKhwIKJauQADXZS1mTh/b79TEzzLwtBcrtbryL4vaNiqi/UXodViq8p1SYu+/pppwlL+W1GutSxRd0rhu9KOsasgIVRntx7OTBUXm3GUZ9IsdZBwv9h2ayj2EQxSO4XQFc3aWKdcpYb9NguZ+33gqKDO/IKw+e7tcB7URHJ6QWvNxXgVksGXuqv058mOWihsgSMqvL45dZcUG4DyMorz1SWAZDkIF/r+pvX4gwXaKD3IQsVcQjaui73QPRobwlvdGMbQweaSvAw3BJaxx50OLlTJtuIqjFCJ3KtmvOFnZnN0CY2q73Crkli2wJ/zXDwDfGvqewGr/PPE6qXPmDOo7QcwHvkjhOtShs/xA/CV/Qj78bfb2JOFf3QFJX+fYGMeFMcPfaTK9beUhIOmJ0VY+M3jj6eITw+2aqVv1km9TrDNE6wIXjhZQA6AIrFmmoHfejrFYrqDGnN9x25jhx1JU7x5TKmnuzpTIdFaK9EDESO111XHSzOO6n8Hcvzqwnvm3zzy9R55RiVioOczkIFpAMIhHFBF6yc/DdVKJYX1IB3BC6wnjhrS3nVnFFXIyG2OW/Udcqo7z6PBGuJS1waGkC8amklv3z5nBPRqRFdkoQFmQn8gwyDEZbYk=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39850400004)(396003)(136003)(346002)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(46966006)(36840700001)(83380400001)(41300700001)(40480700001)(2616005)(36756003)(81166007)(70206006)(86362001)(316002)(6916009)(4326008)(1076003)(70586007)(5660300002)(8676002)(2906002)(6666004)(478600001)(8936002)(54906003)(336012)(6266002)(82740400003)(356005)(26005)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BuhMOqOfx1/ebfyScJtchf6VS8Aw2YPmaRzKXp+VvY70rBOKJXNKWe+7HVI/rfFVS7HrxOPmpggE0m2pFglBDOT3tc9W9xJoE7rvoCsaajLTxZHpoUwDgQ2QKHsTU1hdvtIF7I2oeDK0g7x0+1znOobO1PE0LFj3MTtBtA1PQmQUXj76vm2apYdSSsbXiAHX8Y09k0j4IR1vYeXrve3GksycUcmM4MQlPJxneCVSWOsVGzn2pedmGvX+9tftzOoxRiCB0d9UyIswKyHL7s7K31J50VKvL5qdgSJ2L/pyQkyt6HFDoX6HL5Ore5UaP//guDWcUCXXBrFYVKbZ6gmMgeWFn9MdNf3C1hKWyD6FjoNw29E/3F2H4o9maCwTx1YFyEuBlz27KFEfpUHRYVs897dVvBvhGcM7t5kI8ocsk7o37A6OzbO70fNnetP3UvexC7mkNA6gJMKUzkhLIUh5VXhOF9rgAvu6DO8a1X06fselcU+3zHnPXeXGJc2z2iT0uJIFu8RBdTpcyRz2biinzAtb7ZZSDYuTttlHUgJTX44SROla/+V1ltb4ZLery5/Adv4CLuI4mioqrt75Vbl1sv4OMPAlsl7VjNE4Bta8O2vhdWQfcAgHE/PmI5Qk1ZOY5Zh6t/0LzkqfRK8sOxll42Ce+ewCzHCP0YBhj2WxBEs6zDxgFNurDMo/L+fBYkjqsfXb48JuLYUci38akyfLHFCNVUMq2tmPakcAd3NTi+aX39uebV9AOSNVt5b2z183vQ26OLMoQjjJSLnmdujQIMXqH8adLpsF1ZnwD1T2avQZ4PzdqVQeD/MTahJXsZ6BCpeMmjMltv8gpl11ubf5vG9HVQXunLCNmtwaxBUxAdg=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:30:44.4884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a4c581-e4d0-45dc-0093-08dbd3f62b64
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM04FT028.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6983
X-BESS-ID: 1698085849-102394-31907-2236-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.73.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaWxpZAVgZQ0NzI3MwizTjZyD
	LVwMzYMDXZKNXCzDwt2cLU1NzAwsJIqTYWAOQoa2pBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251639 [from 
	cloudscan18-208.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Cached dentries do not get revalidate, but open would still result in
open + getattr, instead of one atomic_open call only.

libfuse logs (passthrough_hp):

Unpatched:
----------
unique: 22, opcode: OPEN (14), nodeid: 140698229673544, insize: 48, pid: 3434
   unique: 22, success, outsize: 32
unique: 24, opcode: GETATTR (3), nodeid: 140698229673544, insize: 56, pid: 3434
   unique: 24, success, outsize: 120
unique: 26, opcode: FLUSH (25), nodeid: 140698229673544, insize: 64, pid: 3434
   unique: 26, success, outsize: 16
unique: 28, opcode: RELEASE (18), nodeid: 140698229673544, insize: 64, pid: 0
   unique: 28, success, outsize: 16

Patched:
----------
unique: 20, opcode: OPEN_ATOMIC (52), nodeid: 1, insize: 63, pid: 3397
   unique: 20, success, outsize: 160
unique: 22, opcode: FLUSH (25), nodeid: 140024188243528, insize: 64, pid: 3397
   unique: 22, success, outsize: 16
unique: 24, opcode: RELEASE (18), nodeid: 140024188243528, insize: 64, pid: 0
   unique: 24, success, outsize: 16

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 17ae788776db..a770c0a6e022 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -183,6 +183,22 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->out_args[0].value = outarg;
 }
 
+/*
+ * If open atomic is supported by FUSE then use this opportunity
+ * to avoid this lookup and combine lookup + open into a single call.
+ */
+static int fuse_dentry_do_atomic_revalidate(struct dentry *entry,
+					     unsigned int flags,
+					     struct fuse_conn *fc)
+{
+	int ret = 0;
+
+	if (flags & LOOKUP_OPEN && fc->has_open_atomic)
+		ret = D_REVALIDATE_ATOMIC;
+
+	return ret;
+}
+
 /*
  * Check whether the dentry is still valid
  *
@@ -220,19 +236,10 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		fm = get_fuse_mount(inode);
 
-		/* If open atomic is supported by FUSE then use this opportunity
-		 * to avoid this lookup and combine lookup + open into a single call.
-		 *
-		 * Note: Fuse detects open atomic implementation automatically.
-		 * Therefore first few call would go into open atomic code path
-		 * , detects that open atomic is implemented or not by setting
-		 * fc->no_open_atomic. In case open atomic is not implemented,
-		 * calls fall back to non-atomic open.
-		 */
-		if (fm->fc->has_open_atomic && flags & LOOKUP_OPEN) {
-			ret = D_REVALIDATE_ATOMIC;
+		ret = fuse_dentry_do_atomic_revalidate(entry, flags, fm->fc);
+		if (ret)
 			goto out;
-		}
+
 		forget = fuse_alloc_forget();
 		ret = -ENOMEM;
 		if (!forget)
@@ -275,6 +282,16 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	} else if (inode) {
 		fi = get_fuse_inode(inode);
 		if (flags & LOOKUP_RCU) {
+			fm = get_fuse_mount(inode);
+			if (fm->fc->has_open_atomic) {
+				/* Atomic open is preferred, as it does entry
+				 * revalidate and attribute refresh, but
+				 * DCACHE_ATOMIC_OPEN cannot be set in RCU mode
+				 */
+				if (flags & LOOKUP_OPEN)
+					return -ECHILD;
+			}
+
 			if (test_bit(FUSE_I_INIT_RDPLUS, &fi->state))
 				return -ECHILD;
 		} else if (test_and_clear_bit(FUSE_I_INIT_RDPLUS, &fi->state)) {
@@ -282,6 +299,14 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			fuse_advise_use_readdirplus(d_inode(parent));
 			dput(parent);
 		}
+
+		/* revalidate is skipped, but we still want atomic open to
+		 * update attributes during open
+		 */
+		fm = get_fuse_mount(inode);
+		ret = fuse_dentry_do_atomic_revalidate(entry, flags, fm->fc);
+		if (ret)
+			goto out;
 	}
 	ret = D_REVALIDATE_VALID;
 out:
-- 
2.39.2


