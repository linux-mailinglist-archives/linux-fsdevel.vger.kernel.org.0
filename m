Return-Path: <linux-fsdevel+bounces-954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FC17D3F3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82A71C20A59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A1A21A15;
	Mon, 23 Oct 2023 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="cOSAuUbf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B434C6F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:31:06 +0000 (UTC)
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D6EB7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:30:59 -0700 (PDT)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41]) by mx-outbound41-169.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Oct 2023 18:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNptpna6jjdTi+C6GpM+VjkpAvKGU0x/H4qFWDBKrhQ5g1ZMUNEQMKaAAuzAP4xdT39bWqosVO+n2sKgT39ou9nfc0Aatgone5edl3jZF3+rpgBBdaYdq+lkfvKrguX8bHl2tTi+2VwIw5iu31xOz+xewSUNmovWsUO2Ue9WI1ABhdnD3jc+JaiceyMy5zFaTwoi9hGW5Cw5FGDu2Pr8JB2d2NUo/l7ZhRdLAzPv0fGYNmvWX8HoQZLOs3fEV9VMEWNl/y+dvhmznm8VTCP1Gm+It5JCjGrC4m/ZJbAQjaI8bcICj0n/6QlsIdVXoJmkwznhoZ0kjn4nw2k5nrSfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9lubp9IQcAala/CRAjpjNW6Bvzqq7U4KrlsYTMOS7A=;
 b=WD4QqzDKeIeGcK4tgUUI03PdppcrK9Tk3E5ZPuhsN6OFeX79+qiUV9wXS2Vh5mCAFxN0+KOmham6PeETTN9VIAMjZkrqqyTAFM44W8RUxKSZwutBz3/FEPtPaacJhURE0dfzuZBd285j53LMbDr+Exc9xtS2Q50HZNdGpc+I/OFbmvnW18I73z5NApZzV5hwcmibrzVoM3Cl1IP7vU3rvS+KUOT2rAWA1yT+fujquTJXNxrSZqKU6ajjx5fIBA/ZDrSU2obYAB/StphB7iyo78vp5Kp+eGkGz6oe0JK0yTjUcUUBqro+UL+K68ncsyARtjagq6PqhPB/TWIEftQz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9lubp9IQcAala/CRAjpjNW6Bvzqq7U4KrlsYTMOS7A=;
 b=cOSAuUbfmXL88BNN9WZ7687q/YBO+a3/VEzQKJHZuU0aZHE9+XNurntXDqDmbO7Toldtsxq5G4xJsGkRxPl+aXXvnp93gxr1qvglWLhiEoYeHCGUIUcHAUiH1VxXSSh1KlY0FA7VrDPfATz8s+z0ngf8Gx1DOKCHUpjK5guFKlY=
Received: from BN0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:408:e5::16)
 by LV2PR19MB5696.namprd19.prod.outlook.com (2603:10b6:408:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 18:30:40 +0000
Received: from BN8NAM04FT039.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::19) by BN0PR02CA0041.outlook.office365.com
 (2603:10b6:408:e5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT039.mail.protection.outlook.com (10.13.160.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Mon, 23 Oct 2023 18:30:40 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 855CE20C684D;
	Mon, 23 Oct 2023 12:31:44 -0600 (MDT)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v10 2/8] fuse: introduce atomic open
Date: Mon, 23 Oct 2023 20:30:29 +0200
Message-Id: <20231023183035.11035-3-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM04FT039:EE_|LV2PR19MB5696:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 39fa6378-a09a-4bfd-f992-08dbd3f62903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a1/zKtic9Sujd7wfp9VaO7g70tKQHMsmswXFxTPtqydvApwm1i+iHa2qAWozzpqGu4pX6BFWuYCSIZXdqIxFj5J/O1XQn7o5i5JF/IJyAu+1yAsy9Z6CLMoZPiyg5sBdK6w1bdBvqZOEE8w9oXalr6LnZVV6o8gNpFPNOADsLoku4RzZtrZC3XDqtB2TwEsduNMPMIrl8FoRG8+eGZrvopCwTeoqqne+JZjFcIMssf7Vjc44h3qcZsqU8YdGhNngaBmenVRpGLbTr9UReeNW8R1VC/57vGRlN9kAHnfX5gfMYo+MtiO51eH9h2E0Bd3iDRXdXzEf+/0pgFN+NgSbLKCahUujG0ZE+YU29FWDv3ltMBMDJWId0T9x4Ekkaddi9EqRg9nIEhdsYkXWqdr0PxM+XmrYFMFDQ0N7Wa9Su5/5We6LdfWtF5psqPZhyQP5Bk+IbvpG1Iw66ID/zY2O8hUlogK5ulwjqaR6mtY3uNP9z9n11NzcEPfVcg28fBzMpUxfNjGAUOOc6XH64hk+xdmaQgzTMAvsAvQxJJmiCd0aT0JDazKc6Qn+FSeUZnJgfBWyV3+8f0O2TXuo+/lBkmT5KbtYBSkE4El/TJrIaaLa6GK61ZWWuxchE7PdGai+hhY63feEjin0cbCDIJ2dja32CP9pvIoHwmobkWeQo13rc2Q8ZhOvhhKbi4sYpGNA60UD9urOYTQkdxEZGJUetBKVEc7eBBnGfsuflkMZv4YwH5aQFKjs9Bc6LYmyGaUv
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(36840700001)(46966006)(478600001)(36756003)(6666004)(86362001)(81166007)(5660300002)(336012)(2906002)(6266002)(83380400001)(2616005)(6916009)(47076005)(1076003)(41300700001)(316002)(70586007)(70206006)(54906003)(36860700001)(4326008)(8676002)(8936002)(40480700001)(356005)(26005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?us-ascii?Q?9hb4RLPOxqreYmqAyVEbBFIGiblLrvrncFbjlHf939Y1YcDNR+CqR0A8d9+e?=
 =?us-ascii?Q?sKcT63L2ZyX1W9fa+1dJSIwBhkKAmtk65yjS55kWZhoj5MZK2I9lIPGnHdP3?=
 =?us-ascii?Q?vyvvBEQ0Gz/xMTqojXQTHCCz251UW5yI36iHLn0zyN374p1+anYTFqjtmIss?=
 =?us-ascii?Q?mQIi0aPZULrR0Gi7hezVAyTej9WCK+C3sk8z4NVwzY4R3aPaRiV2gneVm2ei?=
 =?us-ascii?Q?almiSlAtOHPPrsjOOauen8U91u9QC1Ohh44Vu/4vlVl/MoM1kR4gPPIaDqUJ?=
 =?us-ascii?Q?eh4PHHNO6jZx30gks8wNTdRr/SCbK2A7Sc2PkWJbCLukK80pZb7sUk7UCV91?=
 =?us-ascii?Q?Sy/N3RViN7F3c8cJzmX0/ZboURYXKl2wpSfNSCdt0erd0rd/+BHt9x/JYeBj?=
 =?us-ascii?Q?lO/d6ru4rqUy1cXJ/SlPk7Nv+T1nnqE4eo2sdsB4qHpqkgFoNWGE+fK5JPKi?=
 =?us-ascii?Q?ZockPQpz47jPKlTqeLxQyKxAqsMtdTA9UYtWl8COy2G2hx1GSt+IC1ZjYl8p?=
 =?us-ascii?Q?WeoPjnTiYH2yz+RgeqEdbkaoBK+luspAqTujuKaQAzrFJODZdtv6KPoZ2nLk?=
 =?us-ascii?Q?Ed8IcPzT0PhmrAz/Az07wp4JTiNxxe4KNSbId/yNaE6A78Kg1UHWALzS5ZVY?=
 =?us-ascii?Q?mfRNuzUGPChBJe9nt6cVMFaHFiqNr2L69ERvIi1uU1kq4+k48z/eWtycfwt6?=
 =?us-ascii?Q?AgTYAlmZWAfIhD9Wht38l+BEnXlwdiv3Q4YCf16a1vEhDVBnm/Us2/V+q2w5?=
 =?us-ascii?Q?7llz9mUcJ+ZlJTa4aahNQjRQTpFfjk335wYTm323MhuG0DzR5UMDQbHYejca?=
 =?us-ascii?Q?XpEUCUznK8RHk6j9WpSyv4fQD8S3xl06rx5DN45yx3VwDq1XHJ5wWMNx6z3u?=
 =?us-ascii?Q?wkMhFDAVj2wqTee6kMTnpen6oZlna89OryjMk5HlcjPQp5AdAvEgbb4XpiHt?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:30:40.4411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fa6378-a09a-4bfd-f992-08dbd3f62903
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM04FT039.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5696
X-BESS-ID: 1698085843-110665-12446-697-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.73.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZGxuZAVgZQ0CDNxMw0xdgi2S
	wx2djCLNnMPNHM2CAl2SDZ3MTMJNVEqTYWAKuB0ApBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251639 [from 
	cloudscan17-102.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Dharmendra Singh <dsingh@ddn.com>

This adds full atomic open support, to avoid lookup before open/create.
If the implementation (fuse server/daemon) does not support atomic open
it falls back to non-atomic open.

Co-developed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c             | 214 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |   3 +
 include/uapi/linux/fuse.h |   3 +
 3 files changed, 219 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e1095852601c..61cdb8e5f68e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -716,7 +716,7 @@ static int _fuse_create_open(struct inode *dir, struct dentry *entry,
 
 static int fuse_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
-static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
+static int fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned flags,
 			    umode_t mode)
 {
@@ -763,6 +763,218 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return finish_no_open(file, res);
 }
 
+static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
+			     struct file *file, unsigned int flags,
+			     umode_t mode)
+{
+	int err;
+	struct inode *inode;
+	FUSE_ARGS(args);
+	struct fuse_mount *fm = get_fuse_mount(dir);
+	struct fuse_conn *fc = fm->fc;
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
+	if (err == -ENOSYS || err == -ELOOP) {
+		if (unlikely(err == -ENOSYS))
+			fc->no_open_atomic = 1;
+		goto free_and_fallback;
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
+			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0);
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
+			switched_entry = NULL;
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
index bf0b85d0b95c..af69578763ef 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -677,6 +677,9 @@ struct fuse_conn {
 	/** Is open/release not implemented by fs? */
 	unsigned no_open:1;
 
+	/** Is open atomic not implemented by fs? */
+	unsigned no_open_atomic:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index db92a7202b34..1508afbd9446 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -353,6 +353,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ * FOPEN_FILE_CREATED: the file was indeed created
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -361,6 +362,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+#define FOPEN_FILE_CREATED	(1 << 7)
 
 /**
  * INIT request/reply flags
@@ -617,6 +619,7 @@ enum fuse_opcode {
 	FUSE_SYNCFS		= 50,
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
+	FUSE_OPEN_ATOMIC	= 53,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
-- 
2.39.2


