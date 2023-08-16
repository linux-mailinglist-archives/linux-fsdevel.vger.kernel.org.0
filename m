Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE97677E3B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 16:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbjHPOeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 10:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343697AbjHPOeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:34:23 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC5268F
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 07:33:55 -0700 (PDT)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40]) by mx-outbound9-97.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 16 Aug 2023 14:33:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcsWE20DtXGZCxjOaxRK1hUtrxPYmIyxGmTy8SfvF7xUsWSubLUECNXrv11FJOT8nMFZmdSMP/8axdPGuNp276r/r6wTZNeuKyGR+xEJzbyUL+XlxERN6yIKnjpoXb+GWBf2deEK3fM4l3/eY4XCUAriRV3Sb/aRx88XEWV/owTbPSPnMQPvaOcJZ/Rq5N13tdw6I8pKrfNuCoi8WU/U25S+L002nlSfrNGkmygZSrpTdqFzN1hyoYo/FRu1tra2eFw7b2IcZ2x1AuFUygbgJdSADOCgw7rjzQ+sKh5mTaerfpOJu56E38X/SknOn+05B9X1anPmL2MOVjdOtau3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkcdZm7FcRAp6BhZPL25pKiwNBnwJedyk4R7xzK96LI=;
 b=mJ91Th76jXmZG9u1Zc5bYOccELSFeFmVe1P7bNuW0G8ZIFVw5JGzfdJNExIJ+bym7FRpb8xumM63lXcfjeCC3ZGAMM1MbuxU+0hh4Eqj5qEv0zvAvqI+ekrKXmEC2Y4vNAF/TGpNQVUJ2DxMfJpBjNTxgeDZpHx4y7JpacgDUzS4s6MdOJDzYsC7IRKVbcRfn5zlKrZYd2LD4LmHo4cAhwb4tgshgyGbzSEmPItHVt7dgqNCJ+MyAvRgHxFv/a9bLmB9mGYzPnx1Lp0dlP8k0GAM++ELsK97wcYsHakLUVNpvM9N93vvQXUBKStaWH3cMOD5SSQg47xMVF1KXGH3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkcdZm7FcRAp6BhZPL25pKiwNBnwJedyk4R7xzK96LI=;
 b=Adi1yvTNug3NUQIn93LBPMHyeJHY2jaAOC1Yjd4vapyKF8+fROl4kOA+BMtC7y4MqVB8xsbwSOKAtBp4vYOIWZAwvxsWxNn07v5d9pb8lfIBmLAPXn3pcG9uoPwQKwrGBB5GQJXvEsIKgHfaYK3Gc+zkY38Et9CVWxqE/Zp3BT0=
Received: from BN8PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:d4::40)
 by IA1PR19MB6203.namprd19.prod.outlook.com (2603:10b6:208:3ed::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 14:33:27 +0000
Received: from BN8NAM04FT043.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::77) by BN8PR04CA0066.outlook.office365.com
 (2603:10b6:408:d4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 14:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT043.mail.protection.outlook.com (10.13.160.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 14:33:26 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id A915820C684B;
        Wed, 16 Aug 2023 08:34:32 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/6] fuse: introduce atomic open
Date:   Wed, 16 Aug 2023 16:33:09 +0200
Message-Id: <20230816143313.2591328-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143313.2591328-1-bschubert@ddn.com>
References: <20230816143313.2591328-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT043:EE_|IA1PR19MB6203:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: abc74367-cd16-4e80-f37b-08db9e65c113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvn8vqUzuI+htgUOUPsr6zyZQRMFRcK6aa9cQiOsTaUyJcHpuhZmcnmUbBQKSpf8kiFq/pQX8SHt+4z8GK3m5+gHsAMSTu39Ji0tV3ZznWUqejh0TqNBBTIfAcSgUv5niiAbycH62PUukMtc4xDCDgFWD5ynersG/iRCb8566DiPhVifPJX8NhUL8bAKoSUvrGxqlPBtqdHP4BjTkuI2PNlQJFcR6ulSZZOmMZmPQMpU6eu1x2D2Yiqc9iLDjHSelZDuIxNQfNblmg+iMdfpYS93vzrQP+VtVzr8otabzPfH+bnPKLyQVwiYD8dGbPv/0KnVZNvuuiBglPXMwqooecyNiJCQOeYQLYUQc7vJI5SEipxUyK8I2uecEaxUXlstToM1Bxr9sOUZvSph/tFhXGT5jkznZ8mA3S4XC/kxW+Swem3zclws+Nl2xNXBevVgJTqxYxNNKyMNs2NqbvfyTKngIqBchCY2xFmPwjNP8sgBmWwmdBG7aWvBMltE1TF7ghcC+OPNXl3YseAWBClWerVWwbJDO8MJHnbw8L//pAXtI6mxiRf06crFZjxcp2HXoKpLJyEVbPab9MQJUKpYowYOom13rj7dy97iIwZZou31Cl5gbXWJowFy812hfIty7v1ub1NOAHdmnS4LLRpR7SVYN+ZLB4ST2PuU7TfbJUDcW/Ei6XgKTj9iJ3/1Jg6A8aCY8owNxtRiymAGJL9VvnqUGRig2UOPVCUR7vSKhf8OXCFjlVLSTe89ajyvDtX/
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39850400004)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(316002)(54906003)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(40480700001)(478600001)(336012)(6266002)(86362001)(36756003)(6666004)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Nr7eVop94/JNEGGeQYZm4yLD3aBniE6aHDTDfkdv1SB7NHggg0lGmLfS7r4a?=
 =?us-ascii?Q?EPI9W4J8v0111D/Uqc7m0qF/PGJ0o4ssfdniXDXcqfOUvefRn8SpbnwFOh1/?=
 =?us-ascii?Q?ypUHqN47QKa2Jd0S7P9Qh5aYzQPH7TM8LQmXiKGni/v3RW/hsr0krBHHOntb?=
 =?us-ascii?Q?+cn0CUl3xPHfthsLW+rPSWgTEn8XilgPfjzitzKE2mFvqD+nKyD7YL9+fkFC?=
 =?us-ascii?Q?2y1RvuMoWVwBLmOhn1DizOdvynuPXNKS1SdAPANhIQZT0eL528eEHxUng2MK?=
 =?us-ascii?Q?rA+w6/+93PN7cA52GOuA33ix4t9rzhyU4D2JDEhOe0SROGpvc3eHc14WC5Ih?=
 =?us-ascii?Q?q4YIHrbKpiqYzCzCg400LAXmz4q8YB/v5lTrJdJifM4eDFVzVRoDAcs2/ZoX?=
 =?us-ascii?Q?8HnokUH6lJZ0Cpi0xjxRgfkQVRjTSgmxWzScJtXNJozTESMWiPQWif8Vme1p?=
 =?us-ascii?Q?DOO8hnRBxrN82HK9XJO5nTOUh/m6MCtHpIzxZOU2GVoG8RsTQ0cHS2CxQO8k?=
 =?us-ascii?Q?77/iEyTvVXNht0ajfyoGpGIE2LCEUdQqNDKvVs0H6kKfsajPjBtlSYXh1azT?=
 =?us-ascii?Q?FSGY39d6b54tVnbzld6x7j8ioHcXwveUlBoz0ejifdj86j4vsdAL3yiLjPCz?=
 =?us-ascii?Q?/PvzyRkRvtvmlOy0mg5Wj5IaFpL6V3eg4sYjRF4OKRBzbFaK/F0yakKe4kkK?=
 =?us-ascii?Q?57lbJAbcxdwTcIJRtJBFfcyvuYSbrEuqe+mLGb63PyZoaZINpXZm57vx1zPZ?=
 =?us-ascii?Q?0e0VWjLcqtP4ml/MWLIV2eXNMYAe3T0EZ3tuoWgP1h8Q9MbSWCqdJzasHUic?=
 =?us-ascii?Q?M0ioRLt5S4vBd+v9l/nAcEaj3jFYLPmFDdGpmczhyRhFC8TpRo3MDTvEO8fV?=
 =?us-ascii?Q?zTGpUZObxXoph0JMl5KFD2db1ZhniTAt+K6SndET+Z+laJ70VyuxbKIvAy/i?=
 =?us-ascii?Q?2xq21Bo8m5PK0uhFUeZL67gwcJ+SS7O3ZvK8Yx6Kwi2Vx+0KF70lUcsTgq+8?=
 =?us-ascii?Q?p3W8?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:33:26.9690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc74367-cd16-4e80-f37b-08db9e65c113
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT043.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6203
X-BESS-ID: 1692196410-102401-12607-11504-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.51.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhbmZiZAVgZQ0NzM3DLZyCwx1T
        jVNMXA2CjFyMTAOCXRPMXIzMzQ3MxQqTYWAJdaPbNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250184 [from 
        cloudscan18-236.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
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

From: Dharmendra Singh <dsingh@ddn.com>

This adds full atomic open support, to avoid lookup before open/create.
If the implementation (fuse server/daemon) does not support atomic open
it falls back to non-atomic open.

Co-developed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c             | 222 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |   3 +
 include/uapi/linux/fuse.h |   3 +
 3 files changed, 226 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 6ffc573de470..bb68d911fd80 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -380,7 +380,6 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	if (name->len > FUSE_NAME_MAX)
 		goto out;
 
-
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
 	if (!forget)
@@ -724,7 +723,7 @@ static int _fuse_create_open(struct inode *dir, struct dentry *entry,
 
 static int fuse_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
-static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
+static int fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned flags,
 			    umode_t mode)
 {
@@ -770,6 +769,225 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return finish_no_open(file, res);
 }
 
+static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
+			     struct file *file, unsigned flags,
+			     umode_t mode)
+{
+	int err;
+	struct inode *inode;
+	struct fuse_mount *fm = get_fuse_mount(dir);
+	struct fuse_conn *fc = fm->fc;
+	FUSE_ARGS(args);
+	struct fuse_forget_link *forget;
+	struct fuse_create_in inarg;
+	struct fuse_open_out outopen;
+	struct fuse_entry_out outentry;
+	struct fuse_inode *fi;
+	struct fuse_file *ff;
+	struct dentry *switched_entry = NULL, *alias = NULL;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+
+	/* Expect a negative dentry */
+	if (unlikely(d_inode(entry)))
+		goto fallback;
+
+	/* Userspace expects S_IFREG in create mode */
+	if ((flags & O_CREAT) && (mode & S_IFMT) != S_IFREG)
+		goto fallback;
+
+	forget = fuse_alloc_forget();
+	err = -ENOMEM;
+	if (!forget)
+		goto out_err;
+
+	err = -ENOMEM;
+	ff = fuse_file_alloc(fm);
+	if (!ff)
+		goto out_put_forget_req;
+
+	if (!fc->dont_mask)
+		mode &= ~current_umask();
+
+	flags &= ~O_NOCTTY;
+	memset(&inarg, 0, sizeof(inarg));
+	memset(&outentry, 0, sizeof(outentry));
+	inarg.flags = flags;
+	inarg.mode = mode;
+	inarg.umask = current_umask();
+
+	if (fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
+	    !(flags & O_EXCL) && !capable(CAP_FSETID)) {
+		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
+	}
+
+	args.opcode = FUSE_OPEN_ATOMIC;
+	args.nodeid = get_node_id(dir);
+	args.in_numargs = 2;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.in_args[1].size = entry->d_name.len + 1;
+	args.in_args[1].value = entry->d_name.name;
+	args.out_numargs = 2;
+	args.out_args[0].size = sizeof(outentry);
+	args.out_args[0].value = &outentry;
+	args.out_args[1].size = sizeof(outopen);
+	args.out_args[1].value = &outopen;
+
+	if (flags & O_CREAT) {
+		err = get_create_ext(&args, dir, entry, mode);
+		if (err)
+			goto out_free_ff;
+	}
+
+	err = fuse_simple_request(fm, &args);
+	free_ext_value(&args);
+	if (err == -ENOSYS) {
+		fc->no_open_atomic = 1;
+		fuse_file_free(ff);
+		kfree(forget);
+		goto fallback;
+	}
+
+	if (!err && !outentry.nodeid)
+		err = -ENOENT;
+
+	if (err)
+		goto out_free_ff;
+
+	err = -EIO;
+	if (invalid_nodeid(outentry.nodeid) || fuse_invalid_attr(&outentry.attr))
+		goto out_free_ff;
+
+	ff->fh = outopen.fh;
+	ff->nodeid = outentry.nodeid;
+	ff->open_flags = outopen.open_flags;
+	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
+			  &outentry.attr, entry_attr_timeout(&outentry), 0);
+	if (!inode) {
+		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
+		fuse_sync_release(NULL, ff, flags);
+		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	/* prevent racing/parallel lookup on a negative hashed */
+	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
+		d_drop(entry);
+		switched_entry = d_alloc_parallel(entry->d_parent,
+						   &entry->d_name, &wq);
+		if (IS_ERR(switched_entry)) {
+			err = PTR_ERR(switched_entry);
+			goto out_free_ff;
+		}
+
+		if (unlikely(!d_in_lookup(switched_entry))) {
+			/* fall back */
+			dput(switched_entry);
+			switched_entry = NULL;
+			goto free_and_fallback;
+		}
+
+		entry = switched_entry;
+	}
+
+	/* modified version of _nfs4_open_and_get_state - nfs does not open
+	 * dirs, fuse doe
+	 * nfs has additional d_really_is_negative condition, which does not
+	 * make sense as long as only negative dentries come into this function,
+	 * see BUG_ON above and missing revalidate patch - but needed if
+	 * we are going to handle revalidate
+	 */
+	if (d_really_is_negative(entry)) {
+		d_drop(entry);
+		alias = d_exact_alias(entry, inode);
+		if (!alias) {
+			alias = d_splice_alias(inode, entry);
+			if (IS_ERR(alias)) {
+				/*
+				 * Close the file in user space, but do not unlink it,
+				 * if it was created - with network file systems other
+				 * clients might have already accessed it.
+				 */
+				fi = get_fuse_inode(inode);
+				fuse_sync_release(fi, ff, flags);
+				fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+				err = PTR_ERR(alias);
+				goto out_err;
+			}
+		}
+
+		if (alias)
+			entry = alias;
+	}
+
+	fuse_change_entry_timeout(entry, &outentry);
+
+	/*  File was indeed created */
+	if (outopen.open_flags & FOPEN_FILE_CREATED) {
+		if (!(flags & O_CREAT)) {
+			pr_debug("Server side bug, FOPEN_FILE_CREATED set "
+				 "without O_CREAT, ignoring.");
+		} else {
+			/* This should be always set when the file is created */
+			fuse_dir_changed(dir);
+			file->f_mode |= FMODE_CREATED;
+		}
+	}
+
+	if (S_ISDIR(mode))
+		ff->open_flags &= ~FOPEN_DIRECT_IO;
+	err = finish_open(file, entry, generic_file_open);
+	if (err) {
+		fi = get_fuse_inode(inode);
+		fuse_sync_release(fi, ff, flags);
+	} else {
+		file->private_data = ff;
+		fuse_finish_open(inode, file);
+	}
+
+	kfree(forget);
+
+	if (switched_entry) {
+		d_lookup_done(switched_entry);
+		dput(switched_entry);
+	}
+
+	dput(alias);
+
+	return err;
+
+out_free_ff:
+	fuse_file_free(ff);
+out_put_forget_req:
+	kfree(forget);
+out_err:
+	if (switched_entry) {
+		d_lookup_done(switched_entry);
+		dput(switched_entry);
+	}
+
+	return err;
+
+free_and_fallback:
+	fuse_file_free(ff);
+	kfree(forget);
+fallback:
+	return fuse_create_open(dir, entry, file, flags, mode);
+}
+
+static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
+			    struct file *file, unsigned int flags,
+			    umode_t mode)
+{
+	struct fuse_conn *fc = get_fuse_conn(dir);
+
+	if (fc->no_open_atomic)
+		return fuse_create_open(dir, entry, file, flags, mode);
+	else
+		return _fuse_atomic_open(dir, entry, file, flags, mode);
+}
+
 /*
  * Code shared between mknod, mkdir, symlink and link
  */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..4e2ebcc28912 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -672,6 +672,9 @@ struct fuse_conn {
 	/** Is open/release not implemented by fs? */
 	unsigned no_open:1;
 
+	/** Is open atomic not impelmented by fs? */
+	unsigned no_open_atomic:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1b9d0dfae72d..ee36263c0f3a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -314,6 +314,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ * FOPEN_FILE_CREATED: the file was indeed created
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -322,6 +323,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+#define FOPEN_FILE_CREATED	(1 << 7)
 
 /**
  * INIT request/reply flags
@@ -572,6 +574,7 @@ enum fuse_opcode {
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
 	FUSE_TMPFILE		= 51,
+	FUSE_OPEN_ATOMIC	= 52,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
-- 
2.37.2

