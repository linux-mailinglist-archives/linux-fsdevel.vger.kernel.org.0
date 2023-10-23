Return-Path: <linux-fsdevel+bounces-959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF77D3F47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2587EB20FC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EFA219EE;
	Mon, 23 Oct 2023 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="06SUQ9aW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7CC219FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:31:53 +0000 (UTC)
Received: from outbound-ip179b.ess.barracuda.com (outbound-ip179b.ess.barracuda.com [209.222.82.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB628E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:31:42 -0700 (PDT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by mx-outbound16-95.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Oct 2023 18:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVIdVGMh8ANZXIHC37XOtAFZXPiIz2TYN7GCxxJjl3hS8bpbVTcPgfDMHkRu5oXWSmSsxtUD95a0FvuhvDuUn8TruMTRMHZSElIUHBy7i9KrTixYI8psBERV5RVaFQuPm7NOwGfXdt6JCfZr+JqZLBSBa8GI8P57OCzDMpjfRNT1cj2XlyIo5e/iU3sLJMBUKBhLgO7FZdwZ9ZGH8mFmR0EroN5Xztqdi4+9Z9ZiDlqSVBes6kMZzhyCwY1MQZCM+nNyBOeQcPKwg7HnWswn4uMzp8HLc/DlJd+kGfaXjA7QP5I0hj325HVzjqqOWjm68bIjhvVrFu3fWPl2qrB4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipuKun7AIUFJAX/g3UZKKugchS/1PCdFI2z3kNT3oRM=;
 b=hCH1OqbUOECPaQzwXsy5yaS+cbhk28FGbdcgL7jazFasZDumvTBLZNoYPeLNTBZrbpZP4HtTNSGluZU++KWUG4h8hDu+LmfXp9gkgx8/W4LWfwC1yF32unJ+tPFpMh7XWuef+f7ABuZqFjQUyMOQVG8MaBaizeObxFiYmCsAdKx25oxEXvN751Uo+mAbM/CC4rkH2D59XrzjAfq5IgoJKuOyV+jF/x1wgNPEamQ78K0o66eswyWYWFwq+96HsixZVNQY9UO1U8VPRhwMKu9jDBeGP+1ubAE4Z93EztKuFQ9tJFcEKHbtjZLsZAykgeuEdxTYhW4DeNY5YuKtTzz0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipuKun7AIUFJAX/g3UZKKugchS/1PCdFI2z3kNT3oRM=;
 b=06SUQ9aWUQnejPD2LsdZRs1l0yvDsxFHXdiguM7vPg+sCD2J34Sy/rD9NXANflt4/oOej1Q9SIyzS56MLBsNlS2Q0fpbDU484RotsivX2Eunsk51UV6MkKOZyarFsb5UD6wK4gXviugXvofhbdnUGtkzVg+1Yq9PH/5uq+ZmwDs=
Received: from MW4PR02CA0021.namprd02.prod.outlook.com (2603:10b6:303:16d::31)
 by SJ0PR19MB6900.namprd19.prod.outlook.com (2603:10b6:a03:4ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 18:30:46 +0000
Received: from MW2NAM04FT028.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::5b) by MW4PR02CA0021.outlook.office365.com
 (2603:10b6:303:16d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT028.mail.protection.outlook.com (10.13.31.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Mon, 23 Oct 2023 18:30:46 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 61AF320C684D;
	Mon, 23 Oct 2023 12:31:50 -0600 (MDT)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH v10 8/8] fuse atomic open: No fallback for symlinks, just call finish_no_open
Date: Mon, 23 Oct 2023 20:30:35 +0200
Message-Id: <20231023183035.11035-9-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: MW2NAM04FT028:EE_|SJ0PR19MB6900:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bc89b397-98bf-4e69-8772-08dbd3f62c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TRhEZ+ZR+eNuN82XBxesXI1YMAGXBMXO/JBAyQrVmuu4wPHljPcttPnVtOd8tLn6Qw7D/NZIIhNQtrhUAAO3jTFsYBo+kipBs9sYPVuv8D2otnj/l1pLKwIm5DfFvfAGZqVYXQEJyGDa/TzvB8SRZH1zUnio77ViGYuykA4MJZ91Q84Z0TJ55LlqaJtk3Ft2Wn1qBnC+XdD4pg9h5Jh4WNyCzC4JH8+6roLkHvQ/UkyxAHQGsG4sqr5HwgPaI4yWizwCX8miny+5RL4TmZ1SdLS2s/c0a3Q61vuOkb1SLsEGq6HeWMx5Fx7LErfbLDLkac8afRxwTo1tkZl7BQCl/mz0fmvLEVRKfsuIYSkHyfiemLNtp0rqGl5cHsjg1rHlqEfKvhzrUqq2jDNZPKUY3lg8aJauVtly3i7ZXVZEcsa3Q9sHJkY3/bPa/WWduqo+aqWQv34dEbpcKmHSoFGfpQo2a2FGaNB3obDXxzAC2mP8JBoG8ACIIDPaqG4vHxBTYVNi3Xx1lwm6rX275w95H5wzPMCglxb1D0d6AmL4IO3aJ0HDDZTL1yd2B0jjdsHQ+RxK9MiQhL/VjOz9w96t3OTuKGdHsqudpIZ8g3xsmKkjQe1fqIzTexZdCZAqx90Z52JFgvSUKgUO0Jgprrxh+kIt2MFXav+b7SLD0+1J28xfZoEqn179vd/wbbappSBtsw5DU6WfwjBRNkWVMpHN5PG8Ai7iPa0TgDROwVxx/AqC9l+iv3Wtux+09dlSRVYFtVIY2uo8VAoRGRSE1EATny2mFXvN+jcMB7MsagujU2I=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(46966006)(36840700001)(40480700001)(36756003)(8936002)(8676002)(5660300002)(2906002)(66899024)(86362001)(6666004)(41300700001)(26005)(336012)(478600001)(6266002)(81166007)(1076003)(2616005)(82740400003)(356005)(4326008)(36860700001)(83380400001)(47076005)(70206006)(70586007)(54906003)(316002)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PDHz22V8gp+/XKgsrt0+FSu/y4Ri8kv21zhh1jcst6i2ZWbJTLQZaleBGh+s+XZ/ye6OEgjo58UeljxzfqRloQvdIBLiMk/EGk9nM8pNR+RJn0aekR1ozE/9nHyVLG4QtceeGgech6BnZBcz7rOR0i8XN6IjdF77kzR1zvj4WzbEm2mZJPh0sYGwTaPdvEzSXWl8gASBKuFvvfkWDVeFnkckHbAddEwlIoXvEbX0vH3qsBpoPyuRNOtwC0R4d0zR4AyiZsIGwHZN7kWwDVRmmY9rxpUSCduyTJmGDVrhy5S6014T1tKh/l4DgJObgcVisVTi5Mk7OahvucmsIGB4r7mKSMQk+rko7zQg32dZF8jPM4pPsHIJUiWPzpGg2NRJlBLinRAJN9GmIGHwzed7wnuntoldA/CuNR7Nw4HfYZoctoO6W2St665Ygf8YaMveUBADSDc6t01WHF2ROa4SGH6/1i4312An3zeSyYuJEs0/mpbwTxTVl9hoN4s+MW1sFkc9mgPInrA1EfyNw5b4MyApkWsXMeOJeRpl5YAmzCdlH+TlQvRJhwyuPmsUcMD0yTs+yMq5bxpCgJD7USuXZrMeBYdtW/K1k0JLvNpe9tOIfHcCm8EfLk5kClHaeTuhLSnLzDh7qYhKZM/+ktQ4bnVDqD9xSPwwB3N4vM24Oggi9hfsV+QZ4zGpfAEhMHbYsr1yVh+UoJuRi3S59/avdUOKCQZW8r5ZhFb5ysYbIWJf1GLOWg1yy12Bpc7AUgCYITaWXWV5qKENjmfbsBKL44nL+7Xl9Qgx+D50lPQmnQDU/TeIMX9KoivR+lHXNakRG/ESH3A5hz4KBVKMKU0aRD+OQCac9bG6z7NQRDKiFbA=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:30:46.1887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc89b397-98bf-4e69-8772-08dbd3f62c5b
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2NAM04FT028.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6900
X-BESS-ID: 1698085850-104191-32505-327-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.66.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYmBoZAVgZQ0DzNwjIxOTEt0d
	LCMMnU3MggOdXU1CzRzCzV2NIoxcRUqTYWACcUPJhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251639 [from 
	cloudscan-ea17-231.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Symlinks must not be opened as it would result in ELOOP,
but fallback to fuse_create_open is also
not ideal, as it would result in atomic-open + lookup for symlinks.
Atomic-open already carries all information lookup provides, so
just use that and then call finish_no_open instead of finish_open.

Codewise, as finish_no_open consumes a reference, compared to
finish_open, dput(alias) must not be called for symlinks.
Obviously, if we don't have an additional alias reference yet,
we need to get one for symlinks.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: linux-fsdevel@vger.kernel.org

---
(If preferred, this could be merged into the main fuse atomic
revalidate patch). Or adding the function could be moved up
in the series.
---
 fs/fuse/dir.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c4564831af3c..e8cc33a8b3a2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -978,9 +978,6 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 				goto out_free_ff;
 			}
 			goto free_and_fallback;
-		} else if (err == -ELOOP) {
-			/* likely a symlink */
-			goto free_and_fallback;
 		} else {
 			if (d_really_is_positive(entry)) {
 				if (err != -EINTR && err != -ENOMEM)
@@ -1090,15 +1087,23 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 		}
 	}
 
-	if (S_ISDIR(mode))
+	if (S_ISDIR(mode) || S_ISDIR(outentry.attr.mode))
 		ff->open_flags &= ~FOPEN_DIRECT_IO;
-	err = finish_open(file, entry, generic_file_open);
-	if (err) {
-		fi = get_fuse_inode(inode);
-		fuse_sync_release(fi, ff, flags);
-	} else {
-		file->private_data = ff;
-		fuse_finish_open(inode, file);
+
+	if (S_ISLNK(outentry.attr.mode)) {
+		err = finish_no_open(file, entry);
+		if (!alias)
+			dget(entry);
+	} else  {
+		err = finish_open(file, entry, generic_file_open);
+		if (err) {
+			fi = get_fuse_inode(inode);
+			fuse_sync_release(fi, ff, flags);
+		} else {
+			file->private_data = ff;
+			fuse_finish_open(inode, file);
+		}
+		dput(alias);
 	}
 
 	kfree(forget);
@@ -1108,8 +1113,6 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 		dput(switched_entry);
 	}
 
-	dput(alias);
-
 	return err;
 
 out_free_ff:
-- 
2.39.2


