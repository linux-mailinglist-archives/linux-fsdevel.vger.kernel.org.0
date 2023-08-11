Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26721779723
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHKSio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjHKSin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:38:43 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD16630E5
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:38:40 -0700 (PDT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171]) by mx-outbound41-67.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 11 Aug 2023 18:38:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJcqX4g4rHAvJgLol5nxTj3zuggsOTkHXyO0G2AOxu6yxqZ24rfwwaeKeu5rjTWJf/Zb2fFF4C5KvYCAZZGOBGgkHRwiRjuWz7TsTBVkdWCHRG542C+PvOVN3uwa7bYjh9M9Us1mbPGnjmxyimuXwBIYnlmYrpCjxr7AYJe4wLhiwi79UbpK9s3yC1W2P6O5mxwuRWq6FYb+NsuMAXeAoL80nRdkRX3NxXHv/yvpJLk/j/F7pXHI63hQoT58pl4kbTQuxpI0KO58y8nWXYl/BVHYKNPDswidwb9Y19nlnpu3EAhthn+WH5j/xsFUoIDgGBkQfNxby0Qeh3gMLIvlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbUdR33arxc2Sp/fkeK4Lwp/Ej2JA2nuRcPsROJXg6s=;
 b=Ec5vu3oV8ESfH5ilG1Yhe16fa0enbXgYPFHNXiirlAzhcS6H3NuGcZ2XHtAF/Nw5yeycLzqyIl7IsvYo4QOFIUi7GsPgDlc8VCcFrwtzPYmnj4hYI/BS2DWFxysqas7dCNVMzjmPsvqQ2B6Jo3OsrHjx6OCOpb3z9zW5dKmK5btBEtgBZS1xCxuqC793Yc9eFocOwWNxv+SjIhG94jp2cvbJKIKpCfunlDa7pqV0XmM/nOeUuMJaEzCpElMah5S69SFit2szeGPqwUYQEJ/G9LbNrc7OvXHSNyl6zVXvhPGikioJzUTKs3/7Tdn3+iDz1V659gj1HNy1wUoNvi3TrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbUdR33arxc2Sp/fkeK4Lwp/Ej2JA2nuRcPsROJXg6s=;
 b=YnJWtIY3V1dp+M9hbLOHy0r3n5p9Vfbk8MEbPMef7hWR9L7aJN0DCPGk2puPXpn1JfWyln0qD2ViNlO2uY2gsKntvz61lwXVblzr5Tc+V6oWeruONQa49cci1DBm8ZlSm3oFhqroIZXXnMurI9L7whPeLS1Y6gARNC3opUx4vWg=
Received: from BYAPR06CA0066.namprd06.prod.outlook.com (2603:10b6:a03:14b::43)
 by SN7PR19MB7844.namprd19.prod.outlook.com (2603:10b6:806:2e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 18:38:24 +0000
Received: from DM6NAM04FT029.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:14b:cafe::45) by BYAPR06CA0066.outlook.office365.com
 (2603:10b6:a03:14b::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Fri, 11 Aug 2023 18:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT029.mail.protection.outlook.com (10.13.158.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.19 via Frontend Transport; Fri, 11 Aug 2023 18:38:24 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id AF87C20C684B;
        Fri, 11 Aug 2023 12:39:29 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH 1/6] fuse: rename fuse_create_open
Date:   Fri, 11 Aug 2023 20:37:47 +0200
Message-Id: <20230811183752.2506418-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811183752.2506418-1-bschubert@ddn.com>
References: <20230811183752.2506418-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT029:EE_|SN7PR19MB7844:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0f353a76-8dae-4b14-db7b-08db9a9a2583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYTR0aV7/GArTVzkZlFZv9D6ZDsfPJOwMKAVTg3XvaXinezP8F/HjALcvCnK+a8dymeXhrE/XLpM5mjGen+69hMPuVPqZgmGhYJHtY552uq/sHjBXZ52bh8TZtFatFroQr+qlj7sMSWbeQ41j9ALtE/2SH/KAQvcqtRfv/9ADUlOkUyTgsA9tV5x0U3RBqop6b73YHrGPbYwhSu0pvf4k7/F7MRB4Q0Wa8HzIbwEdmbMR4eQzpkCckhZ+3+6T80gWxPvjCloJLIfCj7Ae/ZtVfiz3cTulwPVw4UYc7uCIv6HQHYKVATK/rmSETAiD81YR3xo2hQ17o9j5Je+Ha0ciB9/qdcFjkBTApFr3TUq8LBue1iLY3QS1ZYZo9pM68vBtkpWLVm2C2bHuuN1DoLk+A/FLpnldUvkTdxuYwc8zc21BcITOPAXWxA5MKp/wWs1NNs4+Wt43wSrxKb30d2z3OmraEMPBHypbrc+BcOfvk/Wc6rlPvciYQjGlHBDZuZJ1iyCjqg+yUrOMidqxTV3bf23+3CLyQ8UghhWiP1bDdJagbOke49Tt9VpXUzlr5NsVJw6l9ADqaDtvCUKqU2FE8aPgA0XMs4o20b1QWxmZylLVuVzUg3ylbZcLcTpCxDwX5YE19H3dJBuIJGQrcASAUWhqAKVsgpsuXN1c6r7x1RWk8JP7LULsBYVMS1DfMmKyDJoOMJaZ7s+4Gz08CS+4X0+xqeUtAzapnKQnoRqw/aM5dQoGreA8qvdoBR6v4hS
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39850400004)(451199021)(1800799006)(186006)(82310400008)(36840700001)(46966006)(2906002)(83380400001)(2616005)(41300700001)(36756003)(6666004)(86362001)(54906003)(316002)(6916009)(4326008)(70206006)(82740400003)(70586007)(81166007)(356005)(36860700001)(40480700001)(47076005)(5660300002)(336012)(6266002)(478600001)(8676002)(8936002)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XWiQLMMozoQBHpDTbE6BhWevsVoBC8kszyWJWY16TmMkw3ZF5nkJ2b8MwcQnNYJobt4QEGkj6uFp+VVe+5Ra0qkPLZK4cIPvqLSPdsRnoVOSVC0uQ6i5oLgMv3as21LM1yiG/D7vFeYCQenQhwAIpzvxLEJrNuGpJ37I4ZlxrRlBDdjXghYEi5hD5PgNiPkjI7boDxJCwXWlqF02+pC6nKb9PSsMhJbO+NAqT6Sk0wh+DuLESDNUVmqPTTl53O/YdHsy8pn67OvovVxuzdAXGY0gTL07vBi08DBoZLBu5yTDnW/U9MPKefRE6zhO1CzB+Ef5AXD1B7h38xQcr8cDO44XNk+m0ZGaXno7zIWDNoD0HbIsJ33W9aHfn0Unnb9GvLBX+iv+gyHp5u76AZyU3FqbC+pFdJV+j9qSxIaWxl0gBbEY3TuXZPRlzeWMczG10/s/9pnE30hEgJlMCRqEoZu8wsEIHWNY+9tDLPiDOsPPK/eIC0UTsSTf2tqsqU+y2F9nSAdxawCmb4hpiA2gmAhhrkUQz7WNytoMG/9ISlMvxyWeESNN0H73PujAgGgKzS9wDGV7Bmy/3smLYgpOiqMdJsz4L+o20hCS9e6g/lXbEvTw9BXJKFWhKP4nTSci/u7gLVaBmwkDDXEMalLzm+JKlUGrpJTbBeViFuYygeSKcJKjuXyBtjN97NshY/4hPBgFtZ6lhY2X5NEWc2K5oBcWEL4k8m2kZZWgfeE9kORLILKoFJoRB+l4J1fHE3SlCG8wCu0y27RgaRFU579hPxKuhayrWP/tW9FQwf/tTuYceeF8HSFJ6IMnt6Ebas+2UPgeAXhc7FxpEU7PZiqZyOBDjVugftbeY5efLBGwqIQZXt3GAucGwExMB5olT+dIgOPwLRdRBeWYu9Dy9S0gZeiYyJgQ257r8eTDr0zwdvI=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:38:24.7315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f353a76-8dae-4b14-db7b-08db9a9a2583
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT029.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7844
X-BESS-ID: 1691779106-110563-12432-5431-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.73.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamFsZAVgZQ0NjILNkiLTXNIt
        HU2NIsJcXSyDTRNNkkOc0QyDYzNlKqjQUADsiY/0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250079 [from 
        cloudscan17-118.us-east-2b.ess.aws.cudaops.com]
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

Just preparation work for atomic open.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: linux-fsdevel@vger.kernel.org

---
 fs/fuse/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 35bc174f9ba2..6ffc573de470 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -613,7 +613,7 @@ static void free_ext_value(struct fuse_args *args)
  * If the filesystem doesn't support this, then fall back to separate
  * 'mknod' + 'open' requests.
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
+static int _fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned int flags,
 			    umode_t mode, u32 opcode)
 {
@@ -753,7 +753,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
+	err = _fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -879,7 +879,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (fc->no_tmpfile)
 		return -EOPNOTSUPP;
 
-	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	err = _fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
 		fc->no_tmpfile = 1;
 		err = -EOPNOTSUPP;
-- 
2.34.1

