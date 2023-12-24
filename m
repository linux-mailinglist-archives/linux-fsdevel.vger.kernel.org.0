Return-Path: <linux-fsdevel+bounces-6863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B60781D8C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 11:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D6228246D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB8211A;
	Sun, 24 Dec 2023 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="WUFlNtP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455020FA;
	Sun, 24 Dec 2023 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169]) by mx-outbound22-58.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 24 Dec 2023 10:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KngvBWb+PmbuF1XkqH4w2y3FZePt4KkvJYro2ed4qO3BliOMWx2OjZeSvUarKgfITIJKJL/ZWrcGUjDhxnBKPSvxhoAAvP7Xm5DBEtzANYKz188aZ1X4M5OQCmMQzngW1H+QWOcgsK6cMjw96WT279nzJOZsV7ifV3NXBc5XfgtbliiDYAPcX52fCbWm5/bYUZ4DuomkAlNmDXijwlXHjbZgm0YvZw0qrl4Z25hbmm1hf23GLCath72KAL+tkVB1FQwhxXlSnIVTmkKsn1/ZDWfyW0RdA+tncQPYZOx91GZoNm6Yse5wkWlBAXbHp/7WdpAlBixQTe8Q0dNJtZ4OLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFmWOcQ5bLEZvSGFgGcd1Y7BisfNVQzPPuC+ciLqEuA=;
 b=TVMO+O6vsNQzVx9uZm9jpPBu8C5QBNOnu0GzFS8lXAHq87ervCYHFsWsoev8kA6K8ayPRml+s9u3261VydiMFUTp9hm423ygQmRigPnx6NkoBM9SLQP1RU3yTvQ84OnVkzSJlswy7LqBlABQeC3iDpgSm+ya3IYkPguMwtCvgZimKqA/Wib2HJ3D6a5LGiY0eKIEW+xePEWMYs3lxVIJEtZ5gWtJmCx4adEgUpOmxMvzqspg2jXQFs0NHwt7I0MeVee4ZuFoX56MB843A6ihK9JheDjJHXmU7PDHD2lKwoTAtx7Fbs+4CHOaxgdLa94U6N63OG3j5VAr7hETYph2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFmWOcQ5bLEZvSGFgGcd1Y7BisfNVQzPPuC+ciLqEuA=;
 b=WUFlNtP8yjpBBULbd+JKa8TgWFFFMXQQlznAoQ2NSZKwGcw0cyQY8ANOHRMUnnzzUFxaP3y7xglkjdhpAqrsz2NNiGPSnNhqKECXkEEVs7tT2W11gShKJlsDlKI1TXAcTW9qqksgCY6EDmg+0HVu7X3VZb4b+o+p2xoE62SJdig=
Received: from DM6PR13CA0035.namprd13.prod.outlook.com (2603:10b6:5:bc::48) by
 PH7PR19MB8185.namprd19.prod.outlook.com (2603:10b6:510:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 10:49:45 +0000
Received: from DM6NAM04FT044.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::35) by DM6PR13CA0035.outlook.office365.com
 (2603:10b6:5:bc::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.12 via Frontend
 Transport; Sun, 24 Dec 2023 10:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT044.mail.protection.outlook.com (10.13.159.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Sun, 24 Dec 2023 10:49:44 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7A75620C684C;
	Sun, 24 Dec 2023 03:50:46 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	amir73il@gmail.com,
	Bernd Schubert <bschubert@ddn.com>,
	Hao Xu <howeyxu@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Date: Sun, 24 Dec 2023 11:49:11 +0100
Message-Id: <20231224104914.49316-2-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM04FT044:EE_|PH7PR19MB8185:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 388a6288-fc7f-485e-15b6-08dc046e0a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AJxU6R1+PlynnzrRI7InELZDpJJ43dw6BwNp/Zy5cObkO6K4iS+i6k8NM4X/RZgmiQxBYGJnWXyTX+nZyLNrBHxRacYfN5NJJApcfsEjK62oRVzJ44+DchDTXqKFNcGaIcSXSnz25FW1nNyuZBT4qfmi3zxV9mC0VFHGUr4F5KNm94/c1P0soGDz5I/uZb3zp3YyBZYew4hsMBFuYt4mqKA4qiunS8dv0TrEzDblhVx1RT84kt80DXjCElOIHF5J1/zr/4xj+ayEURg/4Nqiwef4GOiIFo6sAh98SszUAsUunRqBJCFwgWTQlMDOhrFpDyZfRqx4gXOLBiQikAN6T7+k3beLoCccJAdL0CpRV2n1Gg+YFrOcQYLeMf/Pot+1NndkYLxcGnh9wST7vgkixB7GCLvhW34J/WPvEDasnhZmHVs1GxfsHKSievLwePBsOUbElL7MpQehRBJIYBQ2H2DphBuAa0BisRfiY/EwClAW5ZRTaCdJvQfX2i0TaidSUdJn7ROBdeVIfzMhfUVkKkgkIzLOcS7n72pU+lLcNWQaavL0vAzwrtWcmXwzfTektDGdHZEmac6NSp5cVrGnXZHIUEc8JXkqqe3Fl+iILxT1NuBq3DyesON6GZMmZtLWC/6nPlN7VPfeSQZK0rzMoNXHK2Ets+jv2h1hy9JRY6yn7+3MoTMB98kIcM7KHppOedcvf+xdVfpWkrbskcktC0kpliQiJQotaYsKsSqiJYd+XnOpZzS7o9dtgZ0kwuR4EqNXSnXmjJVY3VuCcNdfG7+lY8KAPZWxinqWQBDLalY=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39840400004)(346002)(376002)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(36840700001)(46966006)(2906002)(6666004)(478600001)(4326008)(8936002)(8676002)(6916009)(316002)(54906003)(70586007)(70206006)(5660300002)(86362001)(47076005)(83380400001)(36860700001)(336012)(6266002)(40480700001)(81166007)(36756003)(41300700001)(356005)(2616005)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YoqzXS4kKwYAEQ8jSrUbHljJmX60VTzCtGM5ZjlYCz7JUDir7tK6LLqhRkRqzb9lQvsII2qZXyVi2ATb3YQQiDgWJqQCBTOHK7TTIBkYJCkKk4UmTfxM0zR7WNBMq1y35qAQJ/CxV2V5RFB6XsF1vgeBa44Vv50wI+ScFA0noEDMdn3Ctk62n++B7lGd/nFWuhX9/psmNpMU4Fwpdl6XoqeZWXb8n6ftNU9mFMiHdPJYc7nFcrHQa0HeydMU0UxMBdrLpYLS3aQOWDKk11C0jc5wdppFPVVORDgZUuenpH+wN7F5rVx6yRI2X2Yy+GAAG1RewX3h89X4eQmXLWRHOJ0ShUqYiWaEtf9BoRGMgUYegoHyzOXkD3/40xETmQsImkiTctDV2S1mflQ2lt0pemRSaRq1Bbfdfi1rWnVp8DDWXofKqd7245tWSufDqbbqbvA4ma6gFzn+xDmFI0KP1IZtzof+vMeVAROhf+Y1KuQe0f1rL+8KP5BIHoGg0oQjqJDv0VOHcwG0Bb2pn7O6uQO8fM/OQ/PoUvTBaOndxNaL2G4PAkkimPtSCAUhOScwx3SCGIT0Cy4oZglfiyBv6Se8o3d8SR21n123AxOx5o0GoHkUzSqaIbvO6ivpymyBBWNRjTfuwkkle8IYk5mD0g==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 10:49:44.7411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388a6288-fc7f-485e-15b6-08dc046e0a76
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM04FT044.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB8185
X-BESS-ID: 1703414989-105690-12427-18446-1
X-BESS-VER: 2019.1_20231221.2126
X-BESS-Apparent-Source-IP: 104.47.73.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamxsZAVgZQ0MIgzcww0TjZ1N
	jcwtLS2MjY0jQlJcUo0SzNxDjRyDRJqTYWAEFu/ZtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253033 [from 
	cloudscan21-10.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

There were multiple issues with direct_io_allow_mmap:
- fuse_link_write_file() was missing, resulting in warnings in
  fuse_write_file_get() and EIO from msync()
- "vma->vm_ops = &fuse_file_vm_ops" was not set, but especially
  fuse_page_mkwrite is needed.

The semantics of invalidate_inode_pages2() is so far not clearly defined
in fuse_file_mmap. It dates back to
commit 3121bfe76311 ("fuse: fix "direct_io" private mmap")
Though, as direct_io_allow_mmap is a new feature, that was for MAP_PRIVATE
only. As invalidate_inode_pages2() is calling into fuse_launder_folio()
and writes out dirty pages, it should be safe to call
invalidate_inode_pages2 for MAP_PRIVATE and MAP_SHARED as well.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: stable@vger.kernel.org
Fixes: e78662e818f9 ("fuse: add a new fuse init flag to relax restrictions in no cache mode")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a660f1f21540a..174aa16407c4b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2475,7 +2475,10 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 		invalidate_inode_pages2(file->f_mapping);
 
-		return generic_file_mmap(file, vma);
+		if (!(vma->vm_flags & VM_MAYSHARE)) {
+			/* MAP_PRIVATE */
+			return generic_file_mmap(file, vma);
+		}
 	}
 
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
-- 
2.40.1


