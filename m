Return-Path: <linux-fsdevel+bounces-961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A39A7D3F7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39D1280FBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832F921372;
	Mon, 23 Oct 2023 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="NCGcdBo1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6D20317
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:47:41 +0000 (UTC)
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E0AFD
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:47:36 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by mx-outbound15-60.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Oct 2023 18:47:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVKwmWNauCP/0rROKfbb1ni3FBAxbV/HtSScT/2ZQuRshodOhrlHb756AG/UoDxC6AfGcqmq0qYkeTls2o1+3dHAFECs3VQuAM57LCE1zq6ntK1OSGw2cDWzEmxFev1FEHBhSpbSrc4ukA6hHIrok2QIHpC27hGF/0e8JL2yvC/tPcEnLky7x/smTQCCwMlqIWiVjvi+YuIrMZBEX4UTMkaG2AhEv6GwWcMyUmFlm+nK6HACy6kGxr8a8f+4FF51t6jsR3y3j2bOQx/2hQzpwf3SGXX3N5+C8E6CNPNTfsS0nNLfvhD+w85s1RISv0L37hDAI8vp44+6Bh5n6tvo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh+synC6VLzWfIKQ6ZXk/Qnn2ifiTB3v3Hpf+rMVn80=;
 b=DeQBo3hUuyUGD2+d5ZttsDxzwDwh2k1doGyIk/edZlolpvzmnucn3LD9425XBCSMY/XL9/XcM8FUcj3oQ3LR090ysOnybzUKGpHUT+nLBaDF9FIUw6B1UqS66a1B0YMt4yurgmzKulink8AyJgMkYOwMJKRbkS8sLaY0HG24d3wYkSNIWOa8GriVuOVvdFH4njXZMTlfHKycy60DMWI95q6lBAD/oHAU2bhB8mc2OcAXJQu0xKyn501FpBvwQicmjg+WSRcyuvUHrmtYSttX/8RKmUEusVf0srvzzKVWE2+CVeNDhc0rQBU519bKFZHWcMRiURDgn00MFZ65dfNvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh+synC6VLzWfIKQ6ZXk/Qnn2ifiTB3v3Hpf+rMVn80=;
 b=NCGcdBo19zEAQK+ym4V58gj+FFwWGnbdB2+YMN5/nBlXOvhj/NZAaGd1isD25RenPKw29qy6XXRHpfCql6N6LGrFiIQe/4Yf6d62w+ewZ2Tpg9PaX5ciYndqdZbwqqjGZlWOK5zDsFMiuoIyGNo4uNBDBfez2pkr8xA01HzgNc4=
Received: from BN0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:408:e6::10)
 by LV8PR19MB8520.namprd19.prod.outlook.com (2603:10b6:408:1ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 18:47:27 +0000
Received: from BN8NAM04FT037.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::3a) by BN0PR03CA0005.outlook.office365.com
 (2603:10b6:408:e6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT037.mail.protection.outlook.com (10.13.160.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.16 via Frontend Transport; Mon, 23 Oct 2023 18:47:27 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 9694520C684C;
	Mon, 23 Oct 2023 12:48:31 -0600 (MDT)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	Bernd Schubert <bschubert@ddn.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>,
	Dharmendra Singh <dsingh@ddn.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH] [RFC] vfs: Convert BUG_ON to WARN_ON_ONCE in open_last_lookups
Date: Mon, 23 Oct 2023 20:47:18 +0200
Message-Id: <20231023184718.11143-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT037:EE_|LV8PR19MB8520:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ba9d60a5-872a-4de5-beef-08dbd3f8814c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GsOh2jqffR2kMseAUvILal+DsQn2oGqGMssYeiMR6AQCqA4iA9fFzVBHTmAAmaHBHPfY1o8E7qZy76gR7rEy5092vKoj37w3NkLsNZISz3Ej8N/HzSBFdeNxKEZHWXRk/oGzGaF8QTG75lBUVXvj96GPYDEEboNCJMWniXL6Kw6K6LSb9AVcrZUMGLzQjOUSIKFjWeUv+xDQjAQwBTAhZAUIpwh7f3PK2Qns2M3QasmsEMcnQjsgNlmcjLxup6hDa2i/d7nvWpdwvSVtA3IobCL3QLdq2mr5rm/UQwlgoOQyBhZ9DXXIS2XRT/yhByEGOirVNhfmmgmsu5cu1yjNZoLn3fatjkc+11UB5vHTPG3Wc/iyCJNBi0ViUDhru15gb/PYnRb+ypUN+LFnNszaG1b5EjwrEIxSADadB0cwOod2Ko2kgiTd+Q4cbESyj8ssUtMFng5ljww5pLnX5TKsRfnFQ55A3FmPsUkXArgII5VXpBAnKLKG6MGuY3Xao4g1uUxawa2v+rNrVz8kgxlwxzRc7vDO76QeR5R7RuwXzzuwl6z2a1zYnVOmWrBAcO+TCDlP5p5FHGc7nVapdMw2C5V2dUuqnysSiMCjN30tlteVhVRawsP+nidTMvJA78BsGkp7YO565sHXy0ccEaPrNQ7GoujuI/ZpyVZ+ZAPSUC291Y0RLYKgKDeSu1A5P4VRQs3SZZFyZwz07vc2z7h+Ep5fKGt1rBkyJHHaMxXCUJoK5pKAd9soqKbQNibPacX8
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39850400004)(376002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(83380400001)(40480700001)(36860700001)(2906002)(8936002)(36756003)(4326008)(8676002)(81166007)(82740400003)(47076005)(1076003)(356005)(336012)(2616005)(6266002)(26005)(6916009)(6666004)(316002)(5660300002)(478600001)(70586007)(86362001)(41300700001)(54906003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?us-ascii?Q?4oO18SN0VLesbEOMFtK+kwoMaeiZsjM6fkFjBe2cW9t+FNGHJQEmlcyvr05P?=
 =?us-ascii?Q?HobZ1wEeUDIGTcg1nmw4fGf42a4yy1LrmsdsdkbiBaf5Bz5hl003GvErRhLC?=
 =?us-ascii?Q?1YpmyNxYXG1VM7pRvDONTJu4q9a1dRGwaFN0X4Lh0T8AlFzz0b0Ozj5VZvS5?=
 =?us-ascii?Q?s9WiSXHIcc2aEuMtBbniPXlZModEmdeyxIUgIyaLvCkq1Srit9h5XazvPiww?=
 =?us-ascii?Q?habnS0/YQcgqbqXjNx2qmYfMX6f0OfdH2NLx0/KMRIuhNLa4l17urNboHgv6?=
 =?us-ascii?Q?Wten3JjNBx/O4AzRKoD2GT4DNgc46Ub7BmogGatrUxlPmHUCK1auL+9pNFlB?=
 =?us-ascii?Q?tzVhkPxLaHLE5q4zduL7S58KWMsr+PW5HqRhQ7efco94AvxJC+2/Jw7XuhL4?=
 =?us-ascii?Q?ZTnhakttZ3OFt7FtiPAz8KkYFLh1QSWYr943fpXQR6EjqcrXPtMbKlJujmEz?=
 =?us-ascii?Q?fiuLM1SKON8GLUH4M53xhuuCCLuJctVEBr2a1n3MEBu7RxU41yU9+ctNZ0ep?=
 =?us-ascii?Q?DBtv1yMKyc5H+OAjR8DdAVgImqH3uo7x2BYFEMXyjkm+KMomYn2CUxCqu4st?=
 =?us-ascii?Q?CsbSjv5BMWWoMbeyXHb/nM+8ZTE4USKYrrvQ2gN0p7y0YyPM6NUXfKIzVSld?=
 =?us-ascii?Q?RdDAFwctjYlFkIfr6wH9BcGdAfbKUuNFVo03cDxQrRHIMOx1z2MAV6YOQ82H?=
 =?us-ascii?Q?21eHEcaUiWhsWMa7Q4nTDFz3HJUxR5pqAanHfQuoAtnRlusw4EBvp104l1H4?=
 =?us-ascii?Q?a/776HSm5MihDkFjrqjUzRRMaaCMFYtleVvWv7+ffn8IW8kQd1cPcIOa57hT?=
 =?us-ascii?Q?236A9LYjcWeU/y9u3V4i2E9dGQ5rcx131mpf/rlCpx4BjnkrYGX7N89qxgBA?=
 =?us-ascii?Q?IcxrPsbOhSeTncjk+bYk+MfXbFYQok7mqhVIAN5vnSAt6D0AI+TY56q9yWad?=
 =?us-ascii?Q?2o0qZZ59WDq8XoLl30JTWg=3D=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:47:27.5979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9d60a5-872a-4de5-beef-08dbd3f8814c
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM04FT037.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8520
X-BESS-ID: 1698086850-103900-4807-567-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZAAGRlAAWTDZKNTcwsDUwS0x
	KNU5PTLE0MzM1STFJSLE1TUgxNTZRqYwFdGgJYQQAAAA==
X-BESS-Outbound-Spam-Score: 0.20
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251639 [from 
	cloudscan16-104.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.20 BSF_SC7_SA298e         META: Custom Rule SA298e 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.20 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC7_SA298e, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The calling code actually handles -ECHILD, so this BUG_ON
can be converted to WARN_ON_ONCE.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org

---
This relates to the fuse atomic open patches and their vfs revalidate
part. Amir had annotated that these patches had a BUG_ON, which I had
only taken as a few lines below the there was the BUG_ON replaced in
this patch.
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 94565bd7e73f..9ff8590ea0a7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3536,7 +3536,8 @@ static const char *open_last_lookups(struct nameidata *nd,
 		if (likely(dentry))
 			goto finish_lookup;
 
-		BUG_ON(nd->flags & LOOKUP_RCU);
+		if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU))
+			return ERR_PTR(-ECHILD);
 	} else {
 		/* create side of things */
 		if (nd->flags & LOOKUP_RCU) {
-- 
2.39.2


