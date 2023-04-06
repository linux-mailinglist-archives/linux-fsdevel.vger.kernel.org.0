Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D319A6D92BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjDFJb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjDFJbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:31:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CE476A8;
        Thu,  6 Apr 2023 02:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQKq+Mx6Sut3+d3f9C3nCm82dNBsnY3dgo411jPS9hY/SihNY386LWQ99oFudKjmP6njdERzuiPdteSQuUGAarkw6+baUyx/YcgQNGTjLEWTmDZsEQzn402Gy8UhTA3uQiJl8ToAXLcBRCVxbxx84V97+3Y+7hElqJqlwuiwYj/p2u6MecX6PrbKc2mqrET5x2rkcCC40YzMcntjpukkUxEnsIaqfJHvL5pgaZkqVeX8xoY06IGZNM6MHmoqBHsu/d5auNASI+bXZfn689T0gK8qSXjQ7sMqMh2bnbNstSqXXRGyzzlpKb6ydt7Cnetg+gYcZ9hd70aeCDsufMgM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxFWt74cFA6U7xiEQPD3j3AhIO/HZzzekr8xd1KIoPM=;
 b=cUl0q6beqYnqamBXhT5H7mT/xZdKdgTQcbWXDxn2m5QCk4bzlaiILD2p82EJ01lIHi0D58CLJdALm4m8OgFKq1tafLbumK+kpxb95YfJnH8kRaIVac8NHDjZg4EFYycuTUWk0h/VgdwgWWXNYcel6mGzwG3AFAIyW6FTo/obGVHOIKHRPq0x+0ZZTgxmQ3fErdp2Sk+vq50vpVC6Zja+joV7/HnFP4DkgUOjeL30ycdfNTQtf00B/yU0gD2Q2loIe297VWDMp3zOQ1nrRT4VVjvD6Dgri3BY2v/ccmEJnjRek0Pu8RzFUTOOO0s6vhXFMbhUdVhmC4cXaubqiEXMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxFWt74cFA6U7xiEQPD3j3AhIO/HZzzekr8xd1KIoPM=;
 b=cDv1Gdbh2s3AOWCOyBdL96C1SpAhDfABo1IWK3qbMBJskfdPOggh3DmXLYzgTPFDXo0tlPHLSHwoOVLllfqMtKCJcYkKTOAhjE8r2Id1PZJptK+3am4o1aPSNs0X0261cRxg4FdN44WxAnuoajjYOjEhB60Wpqa0UEtQaZc4tiChd0e3PZJZjIHNmemB9Mrkco5g8mkJp7S9yCl+1yFNwb02VGZ75toxFS0ODun61+O2sEBs3R7fIf0Vl9ZVF5x3RRcI14tPV6uYZCIV7DFPFPHAiocypvxknhFZMmGIzpxOaVQenYZKoSZ1geI7Uh1/emSNpIkLYz0Bll5W6i1rlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by PUZPR06MB5772.apcprd06.prod.outlook.com (2603:1096:301:f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 09:31:15 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::16db:8a6e:6861:4bb]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::16db:8a6e:6861:4bb%5]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 09:31:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, damien.lemoal@opensource.wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Date:   Thu,  6 Apr 2023 17:30:56 +0800
Message-Id: <20230406093056.33916-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230406093056.33916-1-frank.li@vivo.com>
References: <20230406093056.33916-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|PUZPR06MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 89492d96-0959-42d3-9c3d-08db3681aae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +of1lPVNrqjBhtxdLYDRlXpSUQUexuwJo5zORGUqcoTOuD3RRZdxWbfpMHxHhFWRz1n9M4zx4I+m/I1TkTtVFWHfXzlkLGlNU6zfbhHPSYZA5gtvRPf//M3xifviCbPCGxW74znuViuKPxHfxNIN8udktO3hQFlg+HVmoSZl9rOmEKTkyRh0Pu1FKEG63GBs2yyZSlS6tU9Sn0reQFdapn4yfqtc19BSZt1aL8o8XrTKC4E0Q2dNYV6xvhaM9Dp8SO8p4VIreAu7R7do1i8iMW8UdjvgQEXsHWL18muZMUY5JI4t1P+V3EVh2i6X1v9IJx/ezcMtgnfRoPFLyOm6NoKBA1GG6FUdtX8TrREjUlb2mE63GZiefGnML3khk7CQLAU8detcltOwOazudfBLkn5kppqVdQzFDtNiKtMOG19pilpDG4Fc5WwV9c2vNpLE21h0lMrx+igdLmMV2/OFDIGOiV2er8D6lZ1khialTc56c0E5eKk3dGq3PfcmJL709K5QjvGTBqwvFkum+HdltBaVhdsc9PvZE7af+0j87gevtLXw3GgrjcoGFNm09nY6q4HFkQlIN3jvY4jhOzKuJ450UNLVmJkNHpwOe6/+j3rFH65eIbf5gJkYCqt6j/dx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(86362001)(36756003)(2906002)(6666004)(2616005)(186003)(83380400001)(6486002)(6506007)(6512007)(107886003)(1076003)(26005)(8676002)(4326008)(66556008)(66946007)(66476007)(52116002)(316002)(5660300002)(38350700002)(38100700002)(41300700001)(478600001)(7416002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lMO92vDo2PiinmK+5c8YUwipt+pEEdLz1T4Orjm6Cz1yFsMx+enxLGll44nN?=
 =?us-ascii?Q?IU8s/e+eFk4tuM21297baNvI8UYNRy52wA0mzWYb6v7XkJDoJh6xXryuqx+3?=
 =?us-ascii?Q?uRBceXvcLqLEbl8W+vtazYgMvAHfl2Jt154b8/qgzn1rVADUgRDDyHByNsjy?=
 =?us-ascii?Q?Bc3k3TY2tYN1yC492mpRRv7we+oK82g4U3mA5/gI5RCcXmfdQdQWvY4DtkB1?=
 =?us-ascii?Q?5W7wyH7G7jJNV+YC8b4SwenHNKnAJBtrn9mGzistOte4fzA9D0/ddW83UEcV?=
 =?us-ascii?Q?m5xE9VDPErHuP2v5o6EzR+Oc/+ErKntEVUxq6MbB+98/zDpMUVk8jVqOXmXp?=
 =?us-ascii?Q?7JripNCJ4CHHShoBFV6QVgqVPXinf0q1dUAcd96vZpJ5/y/fvea9IbbF+ane?=
 =?us-ascii?Q?wAnfIObca9NiWPnk/kKeQbYjovFb0q3eGJHw0QdrbHRlIwXdoYjO3VAFwE/P?=
 =?us-ascii?Q?RUK8o2IR9ohEfpazqU1eswjry6C4T9T8Rh3ZpigOb+Z+wa+XC8PRoHkQ8Sc5?=
 =?us-ascii?Q?HQZMXO+yBGuo/xvxoA6sML0ofkHCn3xWuG/SV8qTofYOBu/LSSlLWFV+uXGM?=
 =?us-ascii?Q?3BmKnEjhk1Wjv7cyLMG5TUQPfuoUOYX5ncSZ8aq5/ouTybdHlg8ynCvWnY7F?=
 =?us-ascii?Q?OLtsfpfhrJeWetvBZ6DOMPN5CzwezfanwcT5gn4ly4sHD5pCz2viIlR8NOR2?=
 =?us-ascii?Q?sfkPPtUn+Jsie6AuFahjz3VqYhGzLOm1Uy53MPM6GekZ9O6enrnozCuuwEZM?=
 =?us-ascii?Q?3mKpzg3LMuohljD1oRGght0/DjHF3jcINnfiTKPHwMTXs9bIF/Qzo41j8B6I?=
 =?us-ascii?Q?poWs9KUaN1Q3l7XqpnUVmDY1825gH872CoyXiSR0jG+/YdINIe9pnQ59SwIt?=
 =?us-ascii?Q?FY1eCiCG/3NfXi54ys6kYE4Ssf/0h6y9BV2j/ItlHsmvmiryixKB5YYITjxI?=
 =?us-ascii?Q?9AO1XWJr4qYScyd8e3SQY4uPWK4tyxgss9hovQYiTHJQ2wn3N6tOfuGGc0fd?=
 =?us-ascii?Q?t0MRWS0na9cIKEpxxzV5EsGOe6cLVf9PWjfXH6ueXafakabV8IT+wlSNFrJC?=
 =?us-ascii?Q?vr3y/Dj1mYwNoIv24ierBN3Fl7V5ptR6JFNvAeTLxkE8SWgtUakNXRRzKb7j?=
 =?us-ascii?Q?GYFnszINSuWjq/AxzhVRC4g2xSTPePj4mxJoDxTSQLnn/r2x+3nYjV4u9Sr9?=
 =?us-ascii?Q?jfn07+O1hhnPQE2sWuklk7sA3qB/vCJFV905sHRsSX2uuc735FsNo70go4rf?=
 =?us-ascii?Q?vQPWoIiB9Qir5Q9Fjje7Rb/ks992UtQI/PZuFOKdPVb0z9Nh+LZoqgkASWuU?=
 =?us-ascii?Q?73gfco6esjuY+OlQS5+0qAcgc8giylsC0utynVBhEr/Y16g/Qu3AJc581m18?=
 =?us-ascii?Q?UPFM+tbfvQsxGGXPj0ZhTLooiyJvjx6Q2MTEa5VEQRlSLL3BdbN1WlTG3Xu7?=
 =?us-ascii?Q?8Qhei9BasYCwM3DrCuxpxgsbPJevuSOvbWZ5TM/dYUyYFsjk2/gP7+B1v2Xm?=
 =?us-ascii?Q?W7FdVJ/DNOUu8UGjYV1T/oJwpMtS6i2wCK74FSwk8ygOA3xsJ/DuOULUrie8?=
 =?us-ascii?Q?Vy0ZBm40z+tT80+AOK/U2tLygpqUSZv22WgzOMkW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89492d96-0959-42d3-9c3d-08db3681aae8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 09:31:15.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLclSE4et47LFAX8qAr0rbSbYogvfxKwL0Kzh41GBFK4BqXHGeTMRW0RwsDFfxdOF5OwB6LAk274bGl10hORRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5772
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use kobject_is_added() instead of local `s_sysfs_registered` variables.
BTW kill kobject_del() directly, because kobject_put() actually covers
kobject removal automatically.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/zonefs/sysfs.c  | 11 +++++------
 fs/zonefs/zonefs.h |  1 -
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
index 8ccb65c2b419..f0783bf7a25c 100644
--- a/fs/zonefs/sysfs.c
+++ b/fs/zonefs/sysfs.c
@@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
 		return ret;
 	}
 
-	sbi->s_sysfs_registered = true;
-
 	return 0;
 }
 
@@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
 {
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 
-	if (!sbi || !sbi->s_sysfs_registered)
+	if (!sbi)
 		return;
 
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
+	if (kobject_is_added(&sbi->s_kobj)) {
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
+	}
 }
 
 int __init zonefs_sysfs_init(void)
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 8175652241b5..4db0ea173220 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -238,7 +238,6 @@ struct zonefs_sb_info {
 	unsigned int		s_max_active_seq_files;
 	atomic_t		s_active_seq_files;
 
-	bool			s_sysfs_registered;
 	struct kobject		s_kobj;
 	struct completion	s_kobj_unregister;
 };
-- 
2.35.1

