Return-Path: <linux-fsdevel+bounces-958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B597D3F46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E8D281723
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BF7219FD;
	Mon, 23 Oct 2023 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="pJd9bnAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF37219FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:31:39 +0000 (UTC)
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F9E8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:31:28 -0700 (PDT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by mx-outbound10-173.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Oct 2023 18:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8sA7cs4MsZvogDWhAz+kOCMlPx3B3TBSspbP8jJDEEs0Tzw8VnHsksHi6H6BUducmBPgZ5pQ8a3I3c+CJoR6AlJwGtGQoH6mXQmhC92KaaxxkRfzSl7iLO2V4eXNQJ/plrHiI9nsRpfFhP2RwE3KJ5qCcFEYPAFFxk/PCcbBhoUygRrH6DVhB26ZnvbCsh50WMIxRkyVs+KHOtKrR2BNZLqb5fNHScKPz4ThGewMEBuMuBFUundxEII60cPPAmYjfK5OvLZygWszqcOgLIggFGQGwDzWB0dKw/R8/CcgCtEd/jduS81jyfURNhRHojH+hhBaD7dBSezAkEuJLEzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnGsrkVVMqV1KMJdP9tisj9vGiOk5M8tb+zWEZdFth0=;
 b=LAPEystHuOY7C9p19ONSfhr5xqKHBI1bdn0UTHKGb3zHS1fNO/iKJVXnClUT2Afb3c0h+0YaViKgCDV3SGeWXqmaEwj1lV9UxsQPyNnCFZL1mTEJMMSrFMsGTh7RXzJ48Mp01xyGaTS/+O2BQo1+7xEBIZfyX4V9bnOhnrQKUHKDNf/aRF2yfSFasAsuECzwZfjfJ+MTfHTzvxAvu8ozFaINAbikSJOaRbPt22PwYQugC1x/Q/szutcr/q4MXAgQM5R22ZMA6qqgD6aKsoEz5ZB8O3nXQNBIe2hCynmNgeBAVUvBZzauyCNzhS1mKKOzAIGEXG/x+B+paibF/wDVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnGsrkVVMqV1KMJdP9tisj9vGiOk5M8tb+zWEZdFth0=;
 b=pJd9bnAAWerg727xKVl8IjMpnwWJSDx6gOJahaIcMry3KhWNtMxf5Nf5+JAMOsjkbX4U5XA/kiAGgTvdfF1UPjdwdxG7VLbtMKIcMmbeKUGNFTstGJ22OPpxHD25/lDd3xMMIqmPcDzSXxAC9aZdmZZhCYYu6oJcdsH65JYPswA=
Received: from BN8PR15CA0045.namprd15.prod.outlook.com (2603:10b6:408:80::22)
 by PH7PR19MB6505.namprd19.prod.outlook.com (2603:10b6:510:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 18:30:42 +0000
Received: from BN8NAM04FT004.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::96) by BN8PR15CA0045.outlook.office365.com
 (2603:10b6:408:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT004.mail.protection.outlook.com (10.13.161.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.16 via Frontend Transport; Mon, 23 Oct 2023 18:30:42 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 778A220C684C;
	Mon, 23 Oct 2023 12:31:46 -0600 (MDT)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v10 4/8] [RFC] Allow atomic_open() on positive dentry (w/o O_CREAT)
Date: Mon, 23 Oct 2023 20:30:31 +0200
Message-Id: <20231023183035.11035-5-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM04FT004:EE_|PH7PR19MB6505:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4032c68d-5cce-403a-10fb-08dbd3f62a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ON/CzRpJdoXCVtFMF5gG4gPjLjziT49x+Fk5oa+e8MH0hYqF12gWcCSG4AtNoi9S+tzd3wdLXIzdyqkV+T0eTyFDz4sPpP95g3QQGkMiiGUhaTuySXa6hKm2ukbK9kZScZAYkrEOLANO136veqcPlELABTMiL64T9sUxwZO5vAV3K2OqDOtXkpPOyj+3a0kazXt2okVs0jHvXwf0w9njeyQVEFFcxZsVaXWZ8T+bDyrXt6CKUneZjOy3ngeovVPC4RWIsJ4AOPVBg1D5VJWNS/A4lrg6KIKNcVHBRoeB93oqfE9SsWduwNZyY5zyhmX8mqJvXy5LuO1lT36v7ETjeHt1F117taQRFyvT22XJN+PoUyhDLle2rnBT+MsqBR/XTXCoZY67H/WcheuKe3mW1n2CMelQ2j0pFFfv+8tzvrPiBh1ypWIlexAAZM6orDoTGXDaA7FulJBwrvmy2MnLd4Cc7E6rZsQ6amc+yRgr6PCDPHKcPQ2XEIZMaob/7RQE5E6vnJKaEFh2YkxcYNXAzqVl4gSe3+R+iVT90MpuWzSc5mbxP3ssOzORmRh6jGljCjwNo+5UOwvc42TruPFXBJRGXaEjaCDgEXW9f5Syd7LRoBZfsKWhV27KxpQsFp9SyN8Re0Bca+E8ysjNBCnAqU2sm6B/4MUT9/KHrkYDoR/P0SbTlyDe2A8u/wzQDfARb29y4ArBZS8PPLzgeyZlbwMSHdvmIayjSlhM7vXEYkqWljNyLU1IkwInZSJxzSHn
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39850400004)(396003)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(46966006)(36840700001)(40480700001)(41300700001)(6666004)(2906002)(86362001)(478600001)(4326008)(8936002)(8676002)(70206006)(6916009)(5660300002)(316002)(70586007)(54906003)(83380400001)(47076005)(6266002)(356005)(82740400003)(336012)(81166007)(26005)(36756003)(36860700001)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?us-ascii?Q?uf8xiSYwCW4NOgsF4do/HnV7DOv4SXRH7FMNyK0e2X75EEw6K1xg4dUvxDtv?=
 =?us-ascii?Q?cbYUEPnon0AVlGCP4916V5GbXA8a2bPbHTFlwxCiyJwaK8qAhGhXDYgytVwc?=
 =?us-ascii?Q?SY2pQO9ZZf+nPrElEk09t6fvF0HOLoobHd1EAZUNAfjNaCvDnA3vDc118q17?=
 =?us-ascii?Q?EJvxqXoS1jkWQJOaGz21KHJeJSDmko0bjba76OE082rzxB/B4fQIKVHdZ3Us?=
 =?us-ascii?Q?gVdUI0VJFwaSKRPAvUZA2AFkaP4qKq6MPfh4b4eRoaO2tGMQWyM98AtU7JbA?=
 =?us-ascii?Q?2xFrb9/Z/iJKUqy2bFr0iGzb8/Z3hmThZEV3a38Sxtq+RkaFzkQLQu7Bd7o3?=
 =?us-ascii?Q?5my9yLFO1tkWzljkNSemiYYyfaB2A/38yxAV0E7UqK5MG3vgwo2ygUCsJ5kn?=
 =?us-ascii?Q?CFc35PwyC7Dc565fS629LxNZyRU1BW9nowIhUAw4bgso+YsvjTUInzQZTEMw?=
 =?us-ascii?Q?6JFSB+HCajmphv4CkF4+4lxGBhXT+A/Rn0IlI5NoMATzR38E6g99u4KVx6y4?=
 =?us-ascii?Q?YfKMwDtu9qlZh43sD6ehSnafvCeoFznxuUMvnUU2ISHihym4SFTojTfr9mQq?=
 =?us-ascii?Q?aNNa0sp0m/oeh8mFQ6TYn7cRPk7CLOmVdf/e7imFr22TnObTz56Re0g7/+ML?=
 =?us-ascii?Q?xDv2BcQTny2cEzTP403WPpwstGfVrT064QaMSnCbooJ4iQlNUprKk1mM/sGj?=
 =?us-ascii?Q?7z3cAUQaRb6HGE61ZvxW0OED5CexvPd3J+JBnvCF5sndVMKjedxlngMiuQQP?=
 =?us-ascii?Q?+LNOXcVGG9hYHQq1tBpEh4/AvcvdvRQpBHSWBm936piqp+oc2HxvZgOuairT?=
 =?us-ascii?Q?ErFUh/XsVsp+54wtaiaovehdui+94D/hwULSGyi/fuEDMLQ1b59uXpoFacUB?=
 =?us-ascii?Q?JnKolRXn9XFoEap3g3Jzs/IN9EAshlCakta44cg566sZkA13TBoxvSXR72v5?=
 =?us-ascii?Q?DGSQ6/ftrk3dOCnmeX/zFA=3D=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:30:42.3876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4032c68d-5cce-403a-10fb-08dbd3f62a21
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM04FT004.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6505
X-BESS-ID: 1698085847-102733-30922-1853-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.66.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZmFpZAVgZQMMXSwDzRJNEsxd
	zExMjA2NgkKSXV3BjIMUhJMzRPNFaqjQUAgbqBT0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251639 [from 
	cloudscan18-205.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Previous patch allowed atomic-open on a positive dentry when
O_CREAT was set (in lookup_open). This adds in atomic-open
when O_CREAT is not set.

Code wise it would be possible to just drop the dentry in
open_last_lookups and then fall through to lookup_open.
But then this would add some overhead for dentry drop,
re-lookup and actually also call into d_revalidate.
So as suggested by Miklos, this adds a helper function
(atomic_revalidate_open) to immediately open the dentry
with atomic_open.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/namei.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ff913e6b12b4..5e2d569ffe38 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1614,10 +1614,11 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr_excl);
 
-static struct dentry *lookup_fast(struct nameidata *nd)
+static struct dentry *lookup_fast(struct nameidata *nd, bool *atomic_revalidate)
 {
 	struct dentry *dentry, *parent = nd->path.dentry;
 	int status = 1;
+	*atomic_revalidate = false;
 
 	/*
 	 * Rename seqlock is not required here because in the off chance
@@ -1659,6 +1660,10 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 		dput(dentry);
 		return ERR_PTR(status);
 	}
+
+	if (status == D_REVALIDATE_ATOMIC)
+		*atomic_revalidate = true;
+
 	return dentry;
 }
 
@@ -1984,6 +1989,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
 static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
+	bool atomic_revalidate;
 	/*
 	 * "." and ".." are special - ".." especially so because it has
 	 * to be able to know about the current root directory and
@@ -1994,7 +2000,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
 	}
-	dentry = lookup_fast(nd);
+	dentry = lookup_fast(nd, &atomic_revalidate);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 	if (unlikely(!dentry)) {
@@ -2002,6 +2008,9 @@ static const char *walk_component(struct nameidata *nd, int flags)
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 	}
+
+	WARN_ON_ONCE(atomic_revalidate);
+
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
 	return step_into(nd, flags, dentry);
@@ -3383,6 +3392,42 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 	return dentry;
 }
 
+static struct dentry *atomic_revalidate_open(struct dentry *dentry,
+					     struct nameidata *nd,
+					     struct file *file,
+					     const struct open_flags *op,
+					     bool *got_write)
+{
+	struct mnt_idmap *idmap;
+	struct dentry *dir = nd->path.dentry;
+	struct inode *dir_inode = dir->d_inode;
+	int open_flag = op->open_flag;
+	umode_t mode = op->mode;
+
+	if (unlikely(IS_DEADDIR(dir_inode)))
+		return ERR_PTR(-ENOENT);
+
+	file->f_mode &= ~FMODE_CREATED;
+
+	if (WARN_ON_ONCE(open_flag & O_CREAT))
+		return ERR_PTR(-EINVAL);
+
+	if (open_flag & (O_TRUNC | O_WRONLY | O_RDWR))
+		*got_write = !mnt_want_write(nd->path.mnt);
+	else
+		*got_write = false;
+
+	if (!*got_write)
+		open_flag &= ~O_TRUNC;
+
+	inode_lock_shared(dir->d_inode);
+	dentry = atomic_open(nd, dentry, file, open_flag, mode);
+	inode_unlock_shared(dir->d_inode);
+
+	return dentry;
+
+}
+
 /*
  * Look up and maybe create and open the last component.
  *
@@ -3527,12 +3572,26 @@ static const char *open_last_lookups(struct nameidata *nd,
 	}
 
 	if (!(open_flag & O_CREAT)) {
+		bool atomic_revalidate;
+
 		if (nd->last.name[nd->last.len])
 			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 		/* we _can_ be in RCU mode here */
-		dentry = lookup_fast(nd);
+		dentry = lookup_fast(nd, &atomic_revalidate);
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
+		if (dentry && unlikely(atomic_revalidate)) {
+			/* The file system shall not claim to support atomic
+			 * revalidate in RCU mode
+			 */
+			if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU)) {
+				dput(dentry);
+				return ERR_PTR(-ECHILD);
+			}
+			dentry = atomic_revalidate_open(dentry, nd, file, op,
+							&got_write);
+			goto drop_write;
+		}
 		if (likely(dentry))
 			goto finish_lookup;
 
@@ -3569,6 +3628,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	else
 		inode_unlock_shared(dir->d_inode);
 
+drop_write:
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
 
-- 
2.39.2


