Return-Path: <linux-fsdevel+bounces-956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8C7D3F42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA7B281127
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47471A583;
	Mon, 23 Oct 2023 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="NOOrdYoU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD3219E6
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:31:08 +0000 (UTC)
Received: from outbound-ip141a.ess.barracuda.com (outbound-ip141a.ess.barracuda.com [209.222.82.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E70F8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:31:04 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by mx-outbound11-51.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Oct 2023 18:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpKeNzswxjEpt7jIa5yr6lKpl5S3qPJe2XxUjWXrEFDvwxmvoRO7YXxtte7ovqeodeQpOGz8HihGazZVgDhoQ2BYFg7cDU8GjaV6RgtPsbqyXRQRbST/fTxjz1Cg06uGs1lYATzmqL/t5eE1Z7dJXmKDLd0dxrKNKm6/xyCbOpFgj4ymGGP/4dqMv9nDyBtVMDafcgY+FLl1VAGdFXmrxyTndwh4Ixw0J38ykzHl2rY8pq1ZGtFvRzxaiIKVgDQiF3UW1J0HsTOYUusA8RNnCZCAJvOuOAw6LepcQb8nXkrS3wrXRTkp6mFN3w8SEBrCH39vDVRbwbhXWBCBgCPvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOfzqRdxntQ8twOX2lAGKELQYMznGFdeTzTwyl29bxU=;
 b=IVD1+ZdRtLuxPjFbP25hEhs5/k7WYgA7MyfKCeuc0l5sZxc1Dv8WtBNFsdRwdMs51GAVYS+Txk1+CHshKBsyFIra/QLRZ7lGYfXkhFxiyNZ4aK/jtwWuF+psrxnykk+TMjACuQhR6CMaEeQ/aZhJBX+DnRx0b7TLH3+nXBQ7QmogNs6v7GmVGrQvVSa+NzRBNkjntSATDHskdpFlg9O7WskL/mGf9NrX5IOFzuwsnXdBGVIoYMPDQWNrIq/siEZVZZ97hHbS0+r+TZqYZaStOU6xVRk0nD+9XuEOMOwPLmyaDtp56SJhZVEF/BjBWqKLkQcs+ohiuLArZRwHyWCUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOfzqRdxntQ8twOX2lAGKELQYMznGFdeTzTwyl29bxU=;
 b=NOOrdYoUxKmTZZKN9bQS6xMKy9SvE+T3ZrqlunLbcXwwDKJJAEXBeVh5fijs2zXnHc87aWEqLkA7yM6a2p+biqoAUmn0aPhqae/La8zUxpOmdO4cqab9jEns+7VEud17wJViHQ58tunXliZiGq05VHDeKeXx/rzDn9PkUCxk8zM=
Received: from BN8PR15CA0057.namprd15.prod.outlook.com (2603:10b6:408:80::34)
 by LV2PR19MB5719.namprd19.prod.outlook.com (2603:10b6:408:17c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 18:30:39 +0000
Received: from BN8NAM04FT007.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::9b) by BN8PR15CA0057.outlook.office365.com
 (2603:10b6:408:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT007.mail.protection.outlook.com (10.13.160.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.16 via Frontend Transport; Mon, 23 Oct 2023 18:30:39 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 8B63A20C684C;
	Mon, 23 Oct 2023 12:31:43 -0600 (MDT)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v10 1/8] fuse: rename fuse_create_open
Date: Mon, 23 Oct 2023 20:30:28 +0200
Message-Id: <20231023183035.11035-2-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM04FT007:EE_|LV2PR19MB5719:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 167b2876-1173-415d-145b-08dbd3f62870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DqhBGtwP4USUfpxU9RLwJdq2ukKGaJtN2+cIXb2ugWfalaTqWQDLTYvveI97ac0X156cYk7lyf1EI9RQ+rw08IKtV0YgRpw0njPtSQCW08UrS9jvAwQ+qkm08k4DgTLxClcvsILO0YQQRzxRN7S4bJnY9xV4j1l7k8IhXakz/4KLKAVAifZUMF0N3NWbMJph1ULj3Ug8z3G6XEa8xhIkiKuvDXA8ksgjhQCzJpgEiORQ4sI3Abmhy0RzXuwjY38+bpkkEYpV4i63IVMqNoCxW/UMRitiJlZtq4fINBD1C195F2GfSLYmozwLUeJDozT2Abqvs4C9X7I4RM4KTyjRfu24qSWio6B4evvC3elQZtyszKd8cgywFc1Wj5v8FEoRxlKLtQ0bQzBXRcmqnxVQQZngUXJFe6f3EVQIMFXGsONxTr+b+4YQp5Gj/N7UOtCo0zmFlso+wUYCftURhdI9izbbhEHTYupdIhOlW2fsPvGyIeyjC2E0cM8FfgFCPIGx7ASBJJLix3o19rxswbA4ekZiwQHwjSsEoIv5hxz0IA/7dl++pYX6Eovnck1hF1/GJaz2Etli44GybKLsFMa1Nr3o65ngcFSBzE9kvJl06JGiOeFHl0ah3Ltam6bw+XFcsUfu0esFkYG3B2GhtK+gWR1BIZ7OpVEmkQqwShU+hoc6/gvOIHLBvD6wjUWsUV1vBnWuHa3qn6dgoctlF3h2XwBEh6WX46rj4T9RSOlHmDrP5BmdPiPv/p9eBg2W+G3m
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39850400004)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(36840700001)(46966006)(356005)(82740400003)(81166007)(40480700001)(86362001)(36756003)(316002)(6916009)(70586007)(2616005)(70206006)(478600001)(1076003)(6666004)(8936002)(4326008)(41300700001)(8676002)(5660300002)(26005)(36860700001)(2906002)(47076005)(336012)(6266002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FOTzGfaZlwb0bUmY/tAvq9KlMN98Ny2kKLm1fqUfCeNiaWw6FdY6V6k2da9sc/xb3SgD/aGe/exSPl29rgapVp4rIAJl/FgqXcX7Zb+EEY7XEzThU8R5LemZ9VHHpmIDm8eRMo2b61u4piaukmu4rxvDojKJRHel5NySgIdCcDfjiQCd3R5g7DHCE/syHMMnyE1CRVj2rAL2/Jupn60KW1NK6Q4PaaS1aHVbT0lYnoLJazn0HjESdZbgpORHe3uQ0Sfk91LHEjwh7jRemHOQ2HukHlkNSTlc9NF3FGZU0OSfoGloDUEIKUB4BqmhKLGaSnwqqNSbTz9ZcGYdHaNd0TxCwOQIewYz2XBil7I3la8VVD1Hu8GlOSzpY/aVya1TEMr9ulPCklpvWBnGBes3o2OfHXLnXmTw6rADsjKTutGKvhyUraROHxMAdNj6ioZPVCYWY11WqfzohIiViLrNOZX81Cf56HkFLpWpNE9cHeRq+x5jfqMK+Tp25+T0jF4adz9rJUjqnrau5t896jqHPdBuhOq/VdyhBHkBZWMb2VKkWqf5EYnBPSY7HGx2im93ddlebjKc+xUM2cZ2J3XDAR8kQH7yI6nuP8eoJq5aoM/q4TP2qPzQFASvOJVjkrn8V420vy+OgSIHQTGcxyTnX5kvNlaNkK4+PKfFHxRa96ZfAlTOenrqUlLCfuu8+XWiq7RbVLMKJTp6iFNP5K3EJDg1XESLbjRckpfpAQDXWr63Yyh/IloeUyYL8KwxA2Y5LpdmB9N0xQv0hck6Gah/gGWJkkZKpBvAo2REmW3QJBa23BrKw8BGSKYf5o9iScd1Kt+F45cCpx5EKzgADiPwpiM/1/52Ny817zXMDZEZmKw=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:30:39.5500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 167b2876-1173-415d-145b-08dbd3f62870
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM04FT007.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5719
X-BESS-ID: 1698085842-102867-32709-2475-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamxpZAVgZQMMXQ2MDAPNE4yT
	DJzNwoNSnFwNDA1DLJJM3cyMIyzTJFqTYWAClpD3VBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251639 [from 
	cloudscan21-222.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Just preparation work for atomic open.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d707e6987da9..e1095852601c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -605,7 +605,7 @@ static void free_ext_value(struct fuse_args *args)
  * If the filesystem doesn't support this, then fall back to separate
  * 'mknod' + 'open' requests.
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
+static int _fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned int flags,
 			    umode_t mode, u32 opcode)
 {
@@ -745,7 +745,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
+	err = _fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -874,7 +874,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (fc->no_tmpfile)
 		return -EOPNOTSUPP;
 
-	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	err = _fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
 		fc->no_tmpfile = 1;
 		err = -EOPNOTSUPP;
-- 
2.39.2


