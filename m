Return-Path: <linux-fsdevel+bounces-6866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ABC81D8D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 12:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CE81C20C8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 11:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D3D23CD;
	Sun, 24 Dec 2023 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="GFa8MA/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64B23A8
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169]) by mx-outbound8-113.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 24 Dec 2023 11:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCoeLnK5Bv/fnTiqJvJBf3cq33HxfZfwIf9nJCxb46w6t9/gcR30I0VzxD89VH99PAm0BaleNU9OKLNuKREYXxvKXukBPT1SAZrmEXxXx2U8qCLeDlBpsm+KLp6On3UaPENg+odgBfxQtUqxFQh2DjU83mV/ZERvIsAdopmZjwB16jSZPKiH5LsvurIBflLijzOxvEraXNam0HkvzLBykz3FYVJNCMfPl0bpdDOiwgcmaXNAP7Y/LbctR9SvOTu5NBFXyKZ8x49kO47nnatYD3N+IBLnxwKYCxV8c7qa3zo0FkYxPPWf65H5GxePX2H+eqHoz36yf+/fwBhMx/C5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRIsNDIS7VV+4mxJ/eLurBoiVaBypvLK+Cu89jZBzzM=;
 b=XsYKTZPezL3xgkpHqqF/hQwH1apRwOB76U2xzpGQfl5STki+eXvEVwPaCgnIBa98fuPWWAd45yEytOf+J79aVYwmFRLlLPTp1+ddby9RDa1wed6xaQOBm5qLkGWV+HipXuOTbeusyMI3NaEObaTW8z/ayIeKLrcrWae5MRGcysE2wrjbVCZiRGzOdyrvpiuzBpchJVXGcIXrRugKbQaPEuFRoZefP2SwIXHgxlqMwk0BKvdY5DstWYv0GoYaJqaG53P/jIopLNHBrpZpGJAMqwkBCh1E3yGBwIn2dVzduBiMKepR9lpLznbRnAR+nh7nOyTJ05zuZL50TSxAaqN5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRIsNDIS7VV+4mxJ/eLurBoiVaBypvLK+Cu89jZBzzM=;
 b=GFa8MA/9vlEvaoO6BAMFmIjrbpV0AKF5dPw2b2R8ry+cGsJqwmQqWF//2NRnpRTDND7mQCEU0XIwKSya9J8tfMpIh6+iKmzufm2mJm6N9JRc8COdEmvAb3Sy1ROIQr2j9T2Bx9VmKjUZhiRmoGt0hDDD5e1JMkqvZ1xWz9qHjqc=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by IA0PR19MB7728.namprd19.prod.outlook.com (2603:10b6:208:40c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 10:49:48 +0000
Received: from MW2NAM04FT062.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::98) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24 via Frontend
 Transport; Sun, 24 Dec 2023 10:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT062.mail.protection.outlook.com (10.13.31.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Sun, 24 Dec 2023 10:49:47 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 6B01520C684C;
	Sun, 24 Dec 2023 03:50:49 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	amir73il@gmail.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 4/4] fuse: introduce inode io modes
Date: Sun, 24 Dec 2023 11:49:14 +0100
Message-Id: <20231224104914.49316-5-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224104914.49316-1-bschubert@ddn.com>
References: <20231224104914.49316-1-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT062:EE_|IA0PR19MB7728:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cfd00f4a-c414-4445-623b-08dc046e0c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sEnoP74ULssvoXE4rb3wusE05GMKXuveA42RxUM+68i1/DNBvCZz+QYvunoZN+D7qrGbNVBr/ldGliDWWt2tP8s3OA4W5bY4mX9AWnwEK11LkAp/DpDU0zj/jO3r4pNh8YdcCYRM204pvNUd3ENkOzUMXuC6V8s32eFj4285UjyR16SKHgNnSPPcm1RJydML240w42fEHYyxwjpMg7iuu83FlkRuyq1TTSOgPsgtabjvjYFGZmBFw3Ex/ZZCe7OauZ/hywPU6fzKhRWDEPYixMn+5Tq9fLs4jem4DgcFn0C/kCy6yf425YAw24L5MMjndmTVkbMC/uYGL1PBYkyBW+ncOeaIguLRT08TExYhcjTda6iHN3Cas0FVVCNu4QaQs7JSrohu7i+LhYRwjXwm9GDVGpM4h+r+WEgh9l86T06u3aU6CHAKqaPcgn4APTUK4P3EYTAoQSc94//zKu9K9d4z+jsuFR1L6c1zE7C14BgH+gOa8H64/6JfALLHo5twWN0UQn2y6eEPUKkXspt7rgHmzraKPSN+oWuneR0Va1ebGDX54e1ACd+Jl1cmT+VyiYXtdg/dEDvZNdcJGPnaSVolMcUR+DWsVyH/G3ujnFKRpKFuvGdVsv72lkenc7ZRSSmC44rLyhkFec74b13bRZuqzlBIpml9als/fHATLKAvIN7TWbHYqSKweEe+1YQc2PRkf4rlCVsRLN+2ziafR5e9e5WBCSDAQpehtQe9TEWeBxN6+q9lp5xWuu/7cKMz
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39840400004)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(36840700001)(8936002)(86362001)(316002)(6916009)(70206006)(8676002)(70586007)(478600001)(6666004)(30864003)(5660300002)(2906002)(4326008)(41300700001)(1076003)(26005)(40480700001)(83380400001)(36860700001)(336012)(36756003)(6266002)(47076005)(81166007)(356005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lTDNGNDZuCNl0m9rlNNsVgVp185eRS83qvkEqrpVJ5277jW9SuxzhxUqfhNw2ttKiE00X5f+H+sfkcjLiRm6esIwYSFlab3jfgndcdtiuNIEBW/x+Hm/tBwl80uowa4iiZE6QTjXPROKx7ZRWafB8hj6jRyRXmQFRdoXNLXb3bHbBFiJFVjqCB45KuY3h+CaIO/XyuB/jsLzso9KhUte6xjm53TyGzzjDJtwnwlVwjihY3A2PkU9gu+lYFu2yVz7vrOQNv2dVFa/4S8q3oPK2Wq7TOVS3c3FJkA7pHBab4WBTWm96sSddYK6JcdVs0nFharjYNnENkDXYZeLXjDnRTDCrBBFsy9IHWxlumzCG3c3ZAP/pzKuzSzXhR+RCYgrHEBdqRlBrZCupdKeTrN/CO3vam4sEpQQNgPl4hEfsoGvDiOLcso0uiqZ4h5Wwv/glQu2VnwGJOr2itB9juJdey8v6qCS/gT3j5Y7/8aehjGJy64fCQj01EymVRKvaO46W6yKf4NMMXJu3vVO4qoL3ty7AKbijF3opSETPPNQbhDELc3E5MCZ4kKY7cMFXSWFcD83m+P+Ppbn+niSHHr+UoroDVRgdYn1G/KqBvxmCBBPyfdyw3kfFNu9yiRSdnqpa/j3SkP9ky09eA4BNYy04g==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 10:49:47.7355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd00f4a-c414-4445-623b-08dc046e0c41
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2NAM04FT062.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR19MB7728
X-OriginatorOrg: ddn.com
X-BESS-ID: 1703416933-102161-17024-10994-1
X-BESS-VER: 2019.1_20231221.2126
X-BESS-Apparent-Source-IP: 104.47.59.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGBoaWQGYGUNQ4JdEsNcnQ3C
	zNLDnNLCk5JTHRwsQ4Jc3AxDzVPMnUXKk2FgA+yUcIQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253034 [from 
	cloudscan23-100.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Amir Goldstein <amir73il@gmail.com>

The fuse inode io mode is determined by the mode of its open files/mmaps
and parallel dio.

- caching io mode - files open in caching mode or mmap on direct_io file
- direct io mode - no files open in caching mode and no files mmaped
- parallel dio mode - direct io mode with parallel dio in progress

We use a new FOPEN_CACHE_IO flag to explicitly mark a file that was open
in caching mode.

direct_io mmap uses page cache, so first mmap will mark the file as
FOPEN_DIRECT_IO|FOPEN_CACHE_IO (i.e. mixed mode) and inode will enter
the caching io mode.

If the server opens the file with flags FOPEN_DIRECT_IO|FOPEN_CACHE_IO,
the inode enters caching io mode already on open.

This allows executing parallel dio when inode is not in caching mode
even if shared mmap is allowed, but no mmaps have been performed on
the inode in question.

An mmap on direct_io file now waits for in-progress parallel dio writes,
so FOPEN_PARALLEL_DIRECT_WRITES is enabled again by this commit.

Open in caching mode falls back to direct io mode if parallel dio is
in progress.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c            | 160 ++++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h          |  76 +++++++++++++++++-
 include/uapi/linux/fuse.h |   2 +
 3 files changed, 230 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index abc93415ec7e3..fb0b571daaf55 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -104,10 +104,100 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 	kfree(ra);
 }
 
+static bool fuse_file_is_direct_io(struct file *file)
+{
+	struct fuse_file *ff = file->private_data;
+
+	return ff->open_flags & FOPEN_DIRECT_IO || file->f_flags & O_DIRECT;
+}
+
+/* Request access to submit new io to inode via open file */
+static bool fuse_file_io_open(struct file *file, struct inode *inode)
+{
+	struct fuse_file *ff = file->private_data;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	bool ok = true;
+
+	if (!S_ISREG(inode->i_mode) || FUSE_IS_DAX(inode))
+		return true;
+
+	/* Set explicit FOPEN_CACHE_IO flag for file open in caching mode */
+	if (!fuse_file_is_direct_io(file))
+		ff->open_flags |= FOPEN_CACHE_IO;
+
+	spin_lock(&fi->lock);
+	/* First caching file open enters caching inode io mode */
+	if (ff->open_flags & FOPEN_CACHE_IO) {
+		ok = fuse_inode_get_io_cache(fi);
+		if (!ok) {
+			/* fallback to open in direct io mode */
+			pr_debug("failed to open file in caching mode; falling back to direct io mode.\n");
+			ff->open_flags &= ~FOPEN_CACHE_IO;
+			ff->open_flags |= FOPEN_DIRECT_IO;
+		}
+	}
+	spin_unlock(&fi->lock);
+
+	return ok;
+}
+
+/* Request access to submit new io to inode via mmap */
+static int fuse_file_io_mmap(struct fuse_file *ff, struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (WARN_ON(!S_ISREG(inode->i_mode) || FUSE_IS_DAX(inode)))
+		return -ENODEV;
+
+	spin_lock(&fi->lock);
+	/*
+	 * First mmap of direct_io file enters caching inode io mode, blocks
+	 * new parallel dio writes and waits for the in-progress parallel dio
+	 * writes to complete.
+	 */
+	if (!(ff->open_flags & FOPEN_CACHE_IO)) {
+		while (!fuse_inode_get_io_cache(fi)) {
+			/*
+			 * Setting the bit advises new direct-io writes
+			 * to use an exclusive lock - without it the wait below
+			 * might be forever.
+			 */
+			set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+			spin_unlock(&fi->lock);
+			wait_event_interruptible(fi->direct_io_waitq,
+						 fuse_is_io_cache_allowed(fi));
+			spin_lock(&fi->lock);
+		}
+		ff->open_flags |= FOPEN_CACHE_IO;
+	}
+	spin_unlock(&fi->lock);
+
+	return 0;
+}
+
+/* No more pending io and no new io possible to inode via open/mmapped file */
+static void fuse_file_io_release(struct fuse_file *ff, struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (!S_ISREG(inode->i_mode) || FUSE_IS_DAX(inode))
+		return;
+
+	spin_lock(&fi->lock);
+	/* Last caching file close exits caching inode io mode */
+	if (ff->open_flags & FOPEN_CACHE_IO)
+		fuse_inode_put_io_cache(fi);
+	spin_unlock(&fi->lock);
+}
+
 static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 {
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_args *args = &ff->release_args->args;
+		struct inode *inode = ff->release_args->inode;
+
+		if (inode)
+			fuse_file_io_release(ff, inode);
 
 		if (isdir ? ff->fm->fc->no_opendir : ff->fm->fc->no_open) {
 			/* Do nothing when client does not implement 'open' */
@@ -199,6 +289,9 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
+	/* The file open mode determines the inode io mode */
+	fuse_file_io_open(file, inode);
+
 	if (ff->open_flags & FOPEN_STREAM)
 		stream_open(inode, file);
 	else if (ff->open_flags & FOPEN_NONSEEKABLE)
@@ -1305,6 +1398,37 @@ static bool fuse_io_past_eof(struct kiocb *iocb, struct iov_iter *iter)
 	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
 }
 
+/*
+ * New parallal dio allowed only if inode is not in caching mode and
+ * denies new opens in caching mode.
+ */
+static bool fuse_file_shared_dio_start(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	bool ok;
+
+	if (WARN_ON(!S_ISREG(inode->i_mode) || FUSE_IS_DAX(inode)))
+		return false;
+
+	spin_lock(&fi->lock);
+	ok = fuse_inode_deny_io_cache(fi);
+	spin_unlock(&fi->lock);
+	return ok;
+}
+
+/* Allow new opens in caching mode after last parallel dio end */
+static void fuse_file_shared_dio_end(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	bool allow_cached_io;
+
+	spin_lock(&fi->lock);
+	allow_cached_io = fuse_inode_allow_io_cache(fi);
+	spin_unlock(&fi->lock);
+	if (allow_cached_io)
+		wake_up(&fi->direct_io_waitq);
+}
+
 /*
  * @return true if an exclusive lock for direct IO writes is needed
  */
@@ -1313,6 +1437,7 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* server side has to advise that it supports parallel dio writes */
 	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
@@ -1324,11 +1449,9 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	if (iocb->ki_flags & IOCB_APPEND)
 		return true;
 
-	/* combination opf page access and direct-io difficult, shared
-	 * locks actually introduce a conflict.
-	 */
-	if (get_fuse_conn(inode)->direct_io_allow_mmap)
-		return true;
+	/* shared locks are not allowed with parallel page cache IO */
+	if (test_bit(FUSE_I_CACHE_IO_MODE, &fi->state))
+		return false;
 
 	/* parallel dio beyond eof is at least for now not supported */
 	if (fuse_io_past_eof(iocb, from))
@@ -1349,9 +1472,11 @@ static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
 		inode_lock_shared(inode);
 		/*
 		 * Previous check was without inode lock and might have raced,
-		 * check again.
+		 * check again. fuse_file_shared_dio_start() should be performed
+		 * only after taking shared inode lock.
 		 */
-		if (fuse_io_past_eof(iocb, from)) {
+		if (fuse_io_past_eof(iocb, from) ||
+		    !fuse_file_shared_dio_start(inode)) {
 			inode_unlock_shared(inode);
 			inode_lock(inode);
 			*exclusive = true;
@@ -1364,6 +1489,7 @@ static void fuse_dio_unlock(struct inode *inode, bool exclusive)
 	if (exclusive) {
 		inode_unlock(inode);
 	} else {
+		fuse_file_shared_dio_end(inode);
 		inode_unlock_shared(inode);
 	}
 }
@@ -2493,11 +2619,16 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
+	int rc;
 
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
+	/*
+	 * FOPEN_DIRECT_IO handling is special compared to O_DIRECT,
+	 * as does not allow MAP_SHARED mmap without FUSE_DIRECT_IO_ALLOW_MMAP.
+	 */
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/*
 		 * Can't provide the coherency needed for MAP_SHARED
@@ -2508,10 +2639,23 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 		invalidate_inode_pages2(file->f_mapping);
 
+		/*
+		 * First mmap of direct_io file enters caching inode io mode.
+		 * Also waits for parallel dio writers to go into serial mode
+		 * (exclusive instead of shared lock).
+		 */
+		rc = fuse_file_io_mmap(ff, file_inode(file));
+		if (rc)
+			return rc;
+
 		if (!(vma->vm_flags & VM_MAYSHARE)) {
 			/* MAP_PRIVATE */
 			return generic_file_mmap(file, vma);
 		}
+	} else if (file->f_flags & O_DIRECT) {
+		rc = fuse_file_io_mmap(ff, file_inode(file));
+		if (rc)
+			return rc;
 	}
 
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
@@ -3280,7 +3424,9 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
 	fi->writectr = 0;
+	fi->iocachectr = 0;
 	init_waitqueue_head(&fi->page_waitq);
+	init_waitqueue_head(&fi->direct_io_waitq);
 	fi->writepages = RB_ROOT;
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda927..5774585f6de3e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -111,7 +111,7 @@ struct fuse_inode {
 	u64 attr_version;
 
 	union {
-		/* Write related fields (regular file only) */
+		/* read/write io cache (regular file only) */
 		struct {
 			/* Files usable in writepage.  Protected by fi->lock */
 			struct list_head write_files;
@@ -123,9 +123,15 @@ struct fuse_inode {
 			 * (FUSE_NOWRITE) means more writes are blocked */
 			int writectr;
 
+			/** Number of files/maps using page cache */
+			int iocachectr;
+
 			/* Waitq for writepage completion */
 			wait_queue_head_t page_waitq;
 
+			/* waitq for direct-io completion */
+			wait_queue_head_t direct_io_waitq;
+
 			/* List of writepage requestst (pending or sent) */
 			struct rb_root writepages;
 		};
@@ -187,6 +193,8 @@ enum {
 	FUSE_I_BAD,
 	/* Has btime */
 	FUSE_I_BTIME,
+	/* Wants or already has page cache IO */
+	FUSE_I_CACHE_IO_MODE,
 };
 
 struct fuse_conn;
@@ -1349,6 +1357,72 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa);
 
 /* file.c */
+/*
+ * Request an open in caching mode.
+ * Return true if in caching mode.
+ */
+static inline bool fuse_inode_get_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (fi->iocachectr < 0)
+		return false;
+	fi->iocachectr++;
+	if (fi->iocachectr == 1)
+		set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+
+	return true;
+}
+
+/*
+ * Release an open in caching mode.
+ * Return true if no more files open in caching mode.
+ */
+static inline bool fuse_inode_put_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (WARN_ON(fi->iocachectr <= 0))
+		return false;
+
+	if (--fi->iocachectr == 0) {
+		clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Requets to deny new opens in caching mode.
+ * Return true if denying new opens in caching mode.
+ */
+static inline bool fuse_inode_deny_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (fi->iocachectr > 0)
+		return false;
+	fi->iocachectr--;
+	return true;
+}
+
+/*
+ * Release a request to deny open in caching mode.
+ * Return true if allowing new opens in caching mode.
+ */
+static inline bool fuse_inode_allow_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (WARN_ON(fi->iocachectr >= 0))
+		return false;
+	return ++(fi->iocachectr) == 0;
+}
+
+/*
+ * Return true if allowing new opens in caching mode.
+ */
+static inline bool fuse_is_io_cache_allowed(struct fuse_inode *fi)
+{
+	return READ_ONCE(fi->iocachectr) >= 0;
+}
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 				 unsigned int open_flags, bool isdir);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e7418d15fe390..66a4bd8d767d4 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -353,6 +353,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ * FOPEN_CACHE_IO: using cache for this open file (incl. mmap on direct_io)
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -361,6 +362,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+#define FOPEN_CACHE_IO		(1 << 7)
 
 /**
  * INIT request/reply flags
-- 
2.40.1


