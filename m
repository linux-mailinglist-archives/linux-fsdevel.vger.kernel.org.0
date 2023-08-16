Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7A77E3AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbjHPOd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343656AbjHPOdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:33:54 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC5E268F
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 07:33:51 -0700 (PDT)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100]) by mx-outbound41-168.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 16 Aug 2023 14:33:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQrLI77GyTel6/UYFUC69XL+bk2M+VEzkGHFjNvInb8iDzUjhRWEDgm4oGkSfal34iQ9OuPTrXNYwC4tB3dn1dGt7TCl5/BoAHHLPZb2IwHPyVxaRFQkRxh0TmPdbtsn0QFwp3KTuy13HkR3PtX0SVNsSjFFuSLcoLeAE+DIBhXg6KdtfLJc/JRbOohgCZiyfIPIz5bM9CqQ7IOR2W07+k/UOBp54X5wpQU6y/nH6NSz9deUoEYmbNPeT9wHug/DKpBAsls9LhuRzP34AJ6FZtqca6277jPK8dHlkXjHvspb95wAcxgt+QgPCUtEdxPiNAD4Gl2ADN4FvhI5NGaTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1PvKXaoLLzu0ch8xYAiNWO8488RBn4vXZ2rlru6maQ=;
 b=TV3MHVEflNdZPwioUAxEnL5XPislRL7v09Xz0VdqQ8RMAlsZ+DixESOHELXSUyADtv948qspvRALwBT3Likyezy6KNHaCS9quc04ICyhCnsU/B2M1jR4olAATjMPmcHRUnq+tlVAY9KEIyDOYhP/1nLznJobEWRWpTwkin/s2AecNACw0bWuyGRBV34RwpVA4Mg6MJZqoUSJZwywfMcA+KHqnEzCbEbGJGhUefmXqSVivhK4VnEWK4wOvgGv7mM5tWpECgwYIhp8DnMp838vGE0jRxdzsW85al0/5mvbqKfEs5ide3V0sh5iknBewrx26u6wt30IblgEwqhG1yX6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1PvKXaoLLzu0ch8xYAiNWO8488RBn4vXZ2rlru6maQ=;
 b=X6hqkyTpsN/pfGrTVEb/KJuadrVULWUH9iBO6dH/U9exxwNRofQnwPcNjPOJebtnf4LNjxcC2kTyIFY33gY+lRTkS0gWEY7/EikEHXIvRSJiJbBqHj2/ywMdpOmRpxLj1f9w2RrMF+yDQ5r4XIiEU2+AMLMAu8xcD3FkpHcJhxk=
Received: from BN9PR03CA0108.namprd03.prod.outlook.com (2603:10b6:408:fd::23)
 by MW3PR19MB4185.namprd19.prod.outlook.com (2603:10b6:303:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 14:33:35 +0000
Received: from BN8NAM04FT024.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::38) by BN9PR03CA0108.outlook.office365.com
 (2603:10b6:408:fd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 14:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT024.mail.protection.outlook.com (10.13.160.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 14:33:34 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 3227620C684D;
        Wed, 16 Aug 2023 08:34:40 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH 6/6] fuse: Avoid code duplication in atomic open
Date:   Wed, 16 Aug 2023 16:33:13 +0200
Message-Id: <20230816143313.2591328-7-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143313.2591328-1-bschubert@ddn.com>
References: <20230816143313.2591328-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT024:EE_|MW3PR19MB4185:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f64ec496-d676-442c-c143-08db9e65c58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rbNSVM4TBw8luo2tzLeO2Ej/nwKlkkci1ljYR1ii1nASIc7KSHVLUop07KvAvz4UKg4U4gKEzi/1FnlE2KoOdQMVdYlvD88An+pFWm1oKQvHu+SimVb15h8mSmnO95SZmsITc0XDL4hmBbr1g8cQ4pTEbBgTWEtmliHpkkJ3QyyDow/QEcEM76tPCG11be2/Ebmu7sB42dccYOKYIlZKyuHcyFayVq7iRJr7UIvzHUQ626WHF56A+ByEHJ0wZv7t4PbMwA280jBZZ+sNC/rjNhGj7L7i9Ye4ubsDdv+YIewM9V/sbnp3V3GPimwF1nSdGWjGWKep5x3WFZwrjVepXLtAq6CLGmy9cylCyFpibu1wZunpw3XTjFV3/OeCmNqAg/4tLDf64Y8vVS58gcBT/sHDZJOJcRkxsNQRA4rMA7XPKvvH332EbQseu0/fQas9GbQM7693jsNDcMYtsxiGV7VblQfxKIUb2sI+z6hHLHp2IQlG5EXaPvXATkuBYNLSxe1h2sJhBx/pEseJUefbKyuisKrZPRcDxRSMKCa423pOGRi0CpH0Rj2+X3DKslzH0x43j1GT69kLdRw10U7lo7Lj0hYUd6fDwEoyjtmxHC7fApP5kbzL574RvB4889niYt3gt2iHndah4Hud+qDp6UTz3PmswxNCqSKi3KkX/umxW+mYF4EcnAsV1RCuS1KslUqRK5RoACxgmjCMmz7vA62Ekasf4HTv2hmtqtH8MqCBWHCqIPVOeSHQPTj+QaZZlKP/4Vx/tp02qHX4M/dfA==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39850400004)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(316002)(54906003)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(40480700001)(478600001)(336012)(6266002)(86362001)(36756003)(6666004)(1076003)(2616005)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: szakY/JTCa6BERv2d9kKRyTlybBUGXq4hwnLnDIHCT40Awk9GuDahAtMhVsVICvzeV1rHy0griwzx/SRc8MZmOLeE3T2QvLoCE56Qlrl9z8Q1UP83RMIPlXvoS2JtmDjFysf9xETET6FuvP4aObUI5E3t3qluR5lzwlna66c5ZnQbk0lt6jkG5UkCOjrNyVD/1/dxNRti/iziOvMzZ7vMQlYMNieFsNxsGU4klGERIROVuy83wp0cSOWcF7bd54Tm9c9qk6lI0ocQUlf3iMX2l3age0ahzkJ1MCMj+DoBE3ToiyDPL11WI3jklPb8IA7QBYspEhYwrDOgj/26kTbk1RcbCLp8QPfVOxMcJqqqvF2L7D1f5B56NozSsh4MtIgDSQPW9FlYpAt2bVp6XxmnCI2AptcbS66RV1YX8r4+C7pF8LraEFYGJDkI6RJ6T5xinCwK1OwQxsPFGoQpUNi9kB/5qCjgQ+Q4U1/IEJ0BRyczwZ+kFBNX7Y+pDmuWqurxv1bn+/T3oTiXChhOzZ8WL6V9cjeEjtcEdyz3ukNrPEQn8qNNRkXlCv/Omxux22gWwcg8bgzbgubTrjz9/kOWISjxFkOPndCUMXfTUZ/GE2TW8ci4hPioQetAed7NGSj5AJmE2IbrQlTmfQiVb7hyhpnoLzmEUND73YtuhpxdWyk8H90pVazntsqTp3CIg3cngWIzgxbtW7UMFezL6lFRHolrOY1SqrKT3f112NQrCYEjfe9ekY09negOoU17y8m0RMu+s+k+ueR4gS3A7VgcHffEBakrTsQALVZPRVL1Orrty1NUGvY6YW53fDMF3yVjkecd945edVEa63UBgB8jT/NEdfDyWTJ7SPJ6j7JUVjY5DqvpSMZKI7e8sotN8XeuZXATYO51prF3iFc9fy1b52u/Fovnlc1ghfL0bk4ZV8=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:33:34.4781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f64ec496-d676-442c-c143-08db9e65c58d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT024.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4185
X-BESS-ID: 1692196418-110664-12321-11894-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.55.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbmxiZAVgZQ0NjEzDw12cjM3C
        DRIDU50TzZwsIsNSnJ2CjZKNkwOTVFqTYWABeFzRtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250184 [from 
        cloudscan19-178.us-east-2b.ess.aws.cudaops.com]
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

The same code was used in fuse_atomic_open_revalidate()
_fuse_atomic_open().

(If preferred, this could be merged into the main fuse atomic
revalidate patch). Or adding the function could be moved up
in the series.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1e5e2d46df8a..e69dafc89222 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -807,6 +807,25 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return finish_no_open(file, res);
 }
 
+static struct dentry *fuse_atomic_open_alloc_dentry(struct dentry *entry,
+						    wait_queue_head_t *wq)
+{
+	struct dentry *new;
+
+	d_drop(entry);
+	new = d_alloc_parallel(entry->d_parent, &entry->d_name,
+			       wq);
+	if (IS_ERR(new))
+		return new;
+
+	/* XXX Can this happen at all and there a way to handle it? */
+	if (unlikely(!d_in_lookup(new))) {
+		dput(new);
+		new = ERR_PTR(-EIO);
+	}
+	return new;
+}
+
 /**
  * Revalidate inode hooked into dentry against freshly acquired
  * attributes. If inode is stale then allocate new dentry and
@@ -835,17 +854,9 @@ fuse_atomic_open_revalidate(struct fuse_conn *fc, struct dentry *entry,
 		struct dentry *new = NULL;
 
 		if (!switched && !d_in_lookup(entry)) {
-			d_drop(entry);
-			new = d_alloc_parallel(entry->d_parent, &entry->d_name,
-					       wq);
+			new = fuse_atomic_open_alloc_dentry(entry, wq);
 			if (IS_ERR(new))
 				return new;
-
-			if (unlikely(!d_in_lookup(new))) {
-				dput(new);
-				new = ERR_PTR(-EIO);
-				return new;
-			}
 		}
 
 		fuse_invalidate_entry(entry);
@@ -999,26 +1010,13 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
 	/* prevent racing/parallel lookup */
 	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
-		d_drop(entry);
-		switched_entry = d_alloc_parallel(entry->d_parent,
-						   &entry->d_name, &wq);
+		switched_entry = fuse_atomic_open_alloc_dentry(entry, &wq);
 		if (IS_ERR(switched_entry)) {
-			err = PTR_ERR(switched_entry);
-			goto out_free_ff;
-		}
-
-		if (unlikely(!d_in_lookup(switched_entry))) {
-			/* fall back */
-			dput(switched_entry);
-			switched_entry = NULL;
-
 			if (!inode) {
 				goto free_and_fallback;
 			} else {
-				/* XXX can this happen at all and is there a
-				 * better way to handle it?
-				 */
-				err = -EIO;
+				/* XXX Is there a better way to handle it? */
+				err = PTR_ERR(switched_entry);
 				goto out_free_ff;
 			}
 		}
-- 
2.37.2

