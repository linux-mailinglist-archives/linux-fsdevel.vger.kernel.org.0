Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5308C786371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 00:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbjHWWeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 18:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbjHWWeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:34:04 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3999810D9
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 15:34:00 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100]) by mx-outbound23-119.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 23 Aug 2023 22:33:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k807rtbUrzQowQQQGJza63XUGKqN6Kfz2D7aMqMGgIRxA1GQ+AwhUpscC+uV6y/hCyRV3mcvayr6d9XNup/WQzyNIsWoHHsIpypd+bv3BwsB1DDEBXUMFX+OxAKPvEvJt3/j4lKq8LleQkJ/dm4Hy8CnVKpmpfds7gYBC6eHDRCXrIK4Nacx2PdWynqKpDYb2XHRbcqxXjXb78hMVE5+31Uz8hPzuDoMLd52mbK0jV/+GcJuvbDv5mfztDxRwN3zPARg6BOS6lj21Lqyt1EyMungXPE11a6Vtxbom8zdIUYGmrozHBo6/un2bjuAvYFin4yVowDryYujv391li4L0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnHe4eJHj4U0S27q0W1D+cV6oM5zxcmtAJOj/noGFIc=;
 b=MIhKWEgSzjb7dgm41mSWb6FOn2Tdn5+rQ3HDWV4x77vnIJeGaswVNpUc9Z8F3bNA5CyXcE71jeSsH8euJJbN+7G/tagCj7PO1rAzcK9CuG3psLl52mHjod0YlpGu+nPNmvTVD8DpqiRxoXCB9ktEX30zSxk9GOTCWSYYIhQcf5nWSFzI5EkhpbKjfjzLari7YkvCYNIQbOP4HlHkFElbJn7INULmBEG3Lw70GSSGvSUQJX6HjQvEu86GQd+EVUIvexFnCvtuXASKBVFPNLCn9gnp/78zRJE1kHgOIggU1nQKcD7mVJyY9OLIZJYrFB5JSdow4Qcv9eKnQrdUi8/i5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnHe4eJHj4U0S27q0W1D+cV6oM5zxcmtAJOj/noGFIc=;
 b=cvbrFup8FLeBBcVp/2coq40hhclOalRgEaGpfVleOzirIsMe45UJmC/uwJcDA1azbrClYwBuFFI3dLE76GJEl+kObcAeJt4kP5l9fDJmmeoMkNrdnswV2+/IQnb62c3m1M+mH+7U4mNP8zhOfOeA+kQ1Zg9EZJ/opt+8YyKQoqw=
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by DS0PR19MB6504.namprd19.prod.outlook.com (2603:10b6:8:c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 22:33:53 +0000
Received: from MW2NAM04FT047.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::72) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 22:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT047.mail.protection.outlook.com (10.13.31.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.17 via Frontend Transport; Wed, 23 Aug 2023 22:33:53 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 0C6BC20C684B;
        Wed, 23 Aug 2023 16:34:58 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH] [-next] fuse: Conditionally fill kstat in fuse_do_statx
Date:   Thu, 24 Aug 2023 00:33:45 +0200
Message-Id: <20230823223345.2775761-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT047:EE_|DS0PR19MB6504:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 381b8749-4f4a-420f-3470-08dba42907b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDjgBylbxSyWdZ5IHeWnBdHlUmCCGMvHO5+WRkN1JNJItObi9yOv2uFsqkis+56pikHl8uKs4xyLMbEplV+O6No7if4i4o5BQq8cJeoRDLuDEhafIMSu5UjK8DiINXSeUYP5q6m99yrmToHTgsaW4IkEhaG0dKYl5RUaMCDQ6cK4XAN/Qi6B15z2KhgUArGTnfo+4H9jRz/B4+SSuXcqmRxGeC6h3S3MmCGaMq+xxvaL1nTvrI12qhuZZr1F/74Q255TGO4zZBloeUH+pVSfDTIbPnCaEWU0CHImwou+AiLfFzdFiuHjI+d5LqmhFx0egqUyRvapJYf5tQ1vSvE/ifqz7xVSwL5cH69BxcCjDm+w6/zcVNVIa+9Duv0zVVdOLLXyG8y7DpudQOQ29K1xItsWQQqKndIOadLphSK3eQZ6AdiMb29fsKff2xMeBQ+FaUqHxPh2m1p+QfIMmVRbuUvn5/wZnefNuj0uQPo4yK8DqmyYCLej00Y2QLbo0uPavRZ4YsCLIKaspAOkccOnDfj2OWzTtKTQQLOSBupLr6+nCqqXBuFHFOuwjZSQpaUObZ5g4RFBgiIb6pMNefw5W/GAJdKRr42aax5qb5MHW83Lw/kXPvPY1q5puA6wYICFBaue5bSyOCVGzCOMaYiF7MbYDY16q557gBTSefV91puqVaa+EDUiCjwYD7E3YU3eTV4r/PnbaVRsPHvi/6jui8fkN+X89SV70nRugzPgUI8hT3NJcC+rWdxfRek4VVcu
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39850400004)(376002)(346002)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(41300700001)(6266002)(336012)(36756003)(26005)(83380400001)(5660300002)(2906002)(1076003)(86362001)(2616005)(82740400003)(356005)(81166007)(36860700001)(47076005)(40480700001)(8676002)(8936002)(4326008)(6666004)(70586007)(70206006)(316002)(6916009)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z4KdGvWI0PF14cDcxQtxFJYCk9gG7J1CP1DSdHwRa/gIx02jAp/u6vVh5R8SUbS/jCPNc52PYDP4+xuKo/VlVSkPhs1fajQqWC+SHrBM0UyPhP1+i+z9aqUzKZq9aOuocAqQJT5k2vGpKqkV+NJmMWJuJ38EwTTav9d1UZVJl2nn2vCN3tnoluSqqI2fhriW+spwMgyf/5m/lY1fczrM3yeYH3EUQfbpQE79mV3bCoyGAtTNLrgtykxxsatsBIAYE/Tqr773D5EwJ35X9fnqQfdpdOlf15euXxmyYNb8RdKtnKH+o1uOKyDUPdwK21wDFpKCrjsJ9L19AruQIYjCjaWZ9V5/ojrsnBm7QAJUgp3yfz0ax0p4QgkzWwM175x3yjbREH5V4kBT5fa1L2xX3JYXuDa2bRt7Wi625kfasztfzpsCApsbFLUFyUM4D0E7/PkG2oX6KAXFLIfup/OgzJUQoJE0mOC3HplaRs/zfIm5SXwDplhcQFRkKWCdiFe66ObZWUzlukZc5U/PWwPugnrAEw2I+udlRxhgulNLp8I4QvVMm6TZDJOilix32V9xUzKcDwObTN32TR3MyDD3r7fU0SSe/luVM+3AqBcASCEgjeFPIQqf2uU0pmU+3XNYofTimMcYZZaSoR2UrSQyeV3gZruRBpZ//yniZi5pZ/ED/u2nYdqnUfjPpGNUtGzLd1l9I8sp6RgxdabWhi7V4XZVEQaLhJIwD3pb3I9rB2Tz4BSsncLnCp/Ft3D87k6GzgH9UgCwr8oui6FTbGlhGCFqjNvcLV9ugEapDQTMtMkuYXr8H/jICTtpmPeCat5/y3rvw9O+LYHS6o9/t8J3dICYX3tVDGvfyBDgsJlH+S8=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 22:33:53.2271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381b8749-4f4a-420f-3470-08dba42907b6
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT047.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB6504
X-BESS-ID: 1692830037-106007-12302-20125-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.70.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoam5iZAVgZQMM08ydTYwjLZON
        ko2cIiyTg1JS0xxdLUMjXRyNI8xcRIqTYWANpurW9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250345 [from 
        cloudscan15-173.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The code path

fuse_update_attributes
    fuse_update_get_attr
        fuse_do_statx

has the risk to use a NULL pointer for struct kstat *stat,
although current callers of fuse_update_attributes
only set request_mask to values that will trigger
the call of fuse_do_getattr, which already handles the NULL
pointer. Future updates might miss that fuse_do_statx does
not handle it - it is safer to add a condition already
right now.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e190d09f220d..01e78d746338 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1219,11 +1219,15 @@ static int fuse_do_statx(struct inode *inode, struct file *file,
 		fuse_change_attributes(inode, &attr, &outarg.stat,
 				       ATTR_TIMEOUT(&outarg), attr_version);
 	}
-	stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
-	stat->btime.tv_sec = sx->btime.tv_sec;
-	stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
-	fuse_fillattr(inode, &attr, stat);
-	stat->result_mask |= STATX_TYPE;
+
+	if (stat) {
+		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
+		stat->btime.tv_sec = sx->btime.tv_sec;
+		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec,
+					    NSEC_PER_SEC - 1);
+		fuse_fillattr(inode, &attr, stat);
+		stat->result_mask |= STATX_TYPE;
+	}
 
 	return 0;
 }
-- 
2.34.1

