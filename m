Return-Path: <linux-fsdevel+bounces-953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01697D3F3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0D91C20AF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6F21A09;
	Mon, 23 Oct 2023 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="zZiIJIqt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E62219F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:31:05 +0000 (UTC)
Received: from outbound-ip179a.ess.barracuda.com (outbound-ip179a.ess.barracuda.com [209.222.82.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD28100
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:30:59 -0700 (PDT)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41]) by mx-outbound47-12.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Oct 2023 18:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRj995sMZulNT64zkuGT7xAkhc0FxX1humEZOiuXhODMAEGyHG+iIXzHl7CMiUg2QYk3+eLjWB6ESp5lW7mhAob4J1rgMhzvdpv9TgnNVUOrdnWqEdB0j8UwWUEfpGxuFR7OmVlPfTHvYiMBHY4zbqmI5FSzes5vTgqv5ze5JllEIgAwE1h6lkPIrq0S1zzythcXulVqKRzH2+1HpCVsyv7So6m6ubOp55Qv/P297j6L/+nX+O21335OzeVuFfolcaCP7tcNftII/sDdG8F4Fd/ernlkMh0nUhWThLiE1V2qWJ9rCiROwwNaGJ5OHoAZKyFmkjIdY6W6THjCloMAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC8HcmX/NlF7J1DEGtJ7Fl7q/p5K7KFOWCXDW4M5qDI=;
 b=EEszzpRpp1xRF0wkHzpvZbUBxB1HTnqkp38SM98WPtJrEmyjWU0GFHzmD9UyUsE9kobOrxCOAebRnMLmS5Xvm2agtoYR4oxf+6zkcxgwczjwYIJsAm/ip7krCjWD1iUM69xqCmGE0t0Y5n0CX4ztdQ9h/HDOjLF8X5foL1AKz/Pp72+iuKkMFISR9VCt75+x9PWureK1hMGnuS2TuQKFBeD1LUBRwXrUlgyW1K2zgLTRIFu13liyfUK7/uoy42o7PbwmxCmvzEmxCLff07t2B+bjfLSTEV82Uoc8lTB28t8Y08u+R8IvF9IthYXlMv9nZEhoo6qMogzHcY9q9OINDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC8HcmX/NlF7J1DEGtJ7Fl7q/p5K7KFOWCXDW4M5qDI=;
 b=zZiIJIqtb+35QBRGVAOFOg3wqDMzU/y8DtZdYZlyEk01t098yZCQ5Zuemajk/nXS7VlrOO5ya81ioAh8+aMZpCg9iKCksaM/bnXLmVLIX1diD89ZsxoOb8A5PlgiNcudd2E6jNIbVaD37smjzesuHkJs2Rrk7oaq53n1fy82AII=
Received: from MW4PR03CA0312.namprd03.prod.outlook.com (2603:10b6:303:dd::17)
 by SA1PR19MB4880.namprd19.prod.outlook.com (2603:10b6:806:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 18:30:43 +0000
Received: from MW2NAM04FT024.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::7b) by MW4PR03CA0312.outlook.office365.com
 (2603:10b6:303:dd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT024.mail.protection.outlook.com (10.13.30.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Mon, 23 Oct 2023 18:30:42 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7E6D020C684B;
	Mon, 23 Oct 2023 12:31:45 -0600 (MDT)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v10 3/8] [RFC] Allow atomic_open() on positive dentry (O_CREAT)
Date: Mon, 23 Oct 2023 20:30:30 +0200
Message-Id: <20231023183035.11035-4-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: MW2NAM04FT024:EE_|SA1PR19MB4880:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 26a59001-2d36-4617-0692-08dbd3f62a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zoVWP2WfZnx3JDIM153e02P5NEmQNFCPyvieVW+vvXHprX8kq9lLw7CX/iJaWIzAHd8m/X0/BdKhhVxZgse+IaY+koX9gzFAI0sC0KpI5HceZynJV/OGOt5ybO7nXfyHHqWIA6HAYFglumkQUkCBBLcXokzsQEIBbqV684GSZhoglqAP+OF6I1e1tUcWs3pbHaINrGZ/QHGIQTNQ9z8BKlYuhmYq3/Zvo3YDOQiogphm6zDUDIqzuwbnA1jeM3RTfm1BJEMN/qacNVnDL5vjX2HeFRMy6SA/VzG9lM5izAOdyoLPKQalNcLpVwxYFCO57MGsjDsVEkr5E8JQNpNINLDKDpl8X3zTGztgZzuG/7ogGa7zYpNl4AgP85G5hz6EHvrjzJPM8x86KzyQexs121uVHF+VhJT1SZikRRGjqZ34hYiGRAs0bJZn++IoCYysqjZbp9lfnjeI2gmJGe3Dgw8XhOg54I9dZMgg8HHyhjhmuy7uEFVR/XKy7u22/bmqtdkZc6nFw9cSDxYchr55oPmOiRLuWo3/N4HQLGHpcsId1dBJieks7Sxgu06YtxXWCMqp8z58HmPibeIYSLEjvdcXg1uHPFVJIPRKk6Xa7FA8NOcVxga+kf+Lv4gtaoQxwAoTTWorIjMo8aE24Z7uKuIvoPkO1SizXTLxtfXxCbtnLSC2wMnD+kiHLYDlbxRp/Ql2HPXzxMnWlaMFURZb/tizV4Ubhzr/vqi/3haC1mv41EHEQlkiZjwjjPxykrzj
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39850400004)(346002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(46966006)(81166007)(356005)(82740400003)(86362001)(40480700001)(36756003)(316002)(54906003)(6916009)(70586007)(2616005)(70206006)(478600001)(1076003)(6666004)(8676002)(8936002)(4326008)(41300700001)(5660300002)(26005)(2906002)(47076005)(36860700001)(6266002)(336012)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?us-ascii?Q?Yfyk5pP++P++3tutR0707tDjmSi3pMJtIIZ2jhykWfcnt/UgfevST9Q/YoIR?=
 =?us-ascii?Q?QgE8cVzhX7DeVYigwLB406V9Tf7/MgQNzSPOCzJDR6rI8mEK4An3C9GNzxwp?=
 =?us-ascii?Q?1yVRnzyHrBO6pLBZa1ckCf8vzJIVUyITgrod0XT4Jf9wks6po9Z5jfwjGCWl?=
 =?us-ascii?Q?BNhYQc6Jty6MS+KGtwCIkrFAkpP3KkOseACdGCdRSr0hdbreQJBBWIifjK6p?=
 =?us-ascii?Q?0Y9L+kTewmveJs2+xQNDJ03luLR+5u+SikudXgeWEVd2eXXSV0bTjrVg8S2q?=
 =?us-ascii?Q?33WNIBLEXa7skuiv4HTmDMkOPW7FGxAx9fn3aXIRUtgbog1hbFTAr2Xf4Ffo?=
 =?us-ascii?Q?uny9zqYIOk4X6z0dgcDKUF20rhFXNAEwpzvG9I41oMKkdSUEFAgUcxkS5Fdg?=
 =?us-ascii?Q?dr/xRhxk1910S4+0A4mypn/AG2FKSR06Id2Y33RfDMXkelPmiHLkkCZpSiuC?=
 =?us-ascii?Q?zXkZd/s2rxowHpQbECi6NJLVSoYqeVvPlijeAWMius3yB8j0YkntmIxLtx2l?=
 =?us-ascii?Q?VZzIPF2NNmEDPlU+OFbdjl9gQ70sQCPZ3KQStTl4tiJl7ZJBc63RMQvZ4FTD?=
 =?us-ascii?Q?aWyQPEIVDPCleLEBsxQhYCZZF5lDOFY9oql4Fj2P3p135fCOfZY8bg8gCRx9?=
 =?us-ascii?Q?UAu6jzylLYvRdXFxIQatSYFr6s/ikT3li1eqjUvLIxV/FQkBiPtHA8rGj0Ra?=
 =?us-ascii?Q?2XSg9pPtJqu1MUEdBvX5gn1zmrYFlJ0CWvEen+z7/HIGLqFr7QaAQ8sJBxhq?=
 =?us-ascii?Q?d91c2kc6z2UhtGwwOEECO+4ezPmzWkSgQme+E/N/27wJpP0UfCGaGEp6Rbfm?=
 =?us-ascii?Q?sVqw9RJMdMVZYAck8GZxsGK74f0L6JuQe2gynnEbz1FWgYV01pGAq6ld0DXQ?=
 =?us-ascii?Q?o1qk4a6clzPk+VHe3kAI5Yfh5qKRMk1wRU3d/XgLQ1Di8j8AbRvohaRBNGhW?=
 =?us-ascii?Q?NlAsra2LYLwd4H2PoxpKVw=3D=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:30:42.3425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a59001-2d36-4617-0692-08dbd3f62a13
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2NAM04FT024.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4880
X-BESS-ID: 1698085846-112044-12599-1009-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.74.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGZmZAVgZQ0NwsMSk1MdHU0D
	wxxcTI3MzMzCQtJcUkNdkk0cLC0sJIqTYWAA8jtT5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251639 [from 
	cloudscan18-214.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Miklos Szeredi <miklos@szeredi.hu>

atomic_open() will do an open-by-name or create-and-open
depending on the flags.

If file was created, then the old positive dentry is obviously
stale, so it will be invalidated and a new one will be allocated.

If not created, then check whether it's the same inode (same as in
->d_revalidate()) and if not, invalidate & allocate new dentry.

This only works with O_CREAT, without O_CREAT open_last_lookups
will call into lookup_fast and then return the dentry via
finish_lookup - lookup_open is never called.
This is going to be addressed in the next commit.

Another included change is the introduction of an enum as
d_revalidate return code.

Co-developed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/namei.c            | 11 ++++++-----
 include/linux/namei.h |  7 +++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..ff913e6b12b4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -860,7 +860,7 @@ static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
 	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
 		return dentry->d_op->d_revalidate(dentry, flags);
 	else
-		return 1;
+		return D_REVALIDATE_VALID;
 }
 
 /**
@@ -3330,8 +3330,9 @@ static int may_o_create(struct mnt_idmap *idmap,
 }
 
 /*
- * Attempt to atomically look up, create and open a file from a negative
- * dentry.
+ * Attempt to atomically look up, create and open a file from a
+ * dentry. Unless the file system returns D_REVALIDATE_ATOMIC in ->d_revalidate,
+ * the dentry is always negative.
  *
  * Returns 0 if successful.  The file will have been created and attached to
  * @file by the filesystem calling finish_open().
@@ -3406,7 +3407,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct inode *dir_inode = dir->d_inode;
 	int open_flag = op->open_flag;
 	struct dentry *dentry;
-	int error, create_error = 0;
+	int error = 0, create_error = 0;
 	umode_t mode = op->mode;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
@@ -3433,7 +3434,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dput(dentry);
 		dentry = NULL;
 	}
-	if (dentry->d_inode) {
+	if (dentry->d_inode && error != D_REVALIDATE_ATOMIC) {
 		/* Cached positive dentry: will open in f_op->open */
 		return dentry;
 	}
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 1463cbda4888..a70e87d2b2a9 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -47,6 +47,13 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
+/* ->d_revalidate return codes */
+enum {
+	D_REVALIDATE_INVALID = 0, /* invalid dentry */
+	D_REVALIDATE_VALID   = 1, /* valid dentry */
+	D_REVALIDATE_ATOMIC =  2, /* atomic_open will revalidate */
+};
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
-- 
2.39.2


