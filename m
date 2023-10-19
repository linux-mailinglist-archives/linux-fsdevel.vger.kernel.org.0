Return-Path: <linux-fsdevel+bounces-743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710527CF81D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D512B21826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8259225BC;
	Thu, 19 Oct 2023 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dpB5VAyL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0E225B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:38 +0000 (UTC)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B1B193
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:10 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231019120408epoutp03f51a0badf3535ac0bd5e4904ac0abc10~PgKkjNbpN2780227802epoutp03f
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231019120408epoutp03f51a0badf3535ac0bd5e4904ac0abc10~PgKkjNbpN2780227802epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717048;
	bh=WyEZwCEcMZEgd+uPDvb2WQHlAKDzDTA2b4v6jEJOw5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpB5VAyLh2w6dyA/2YUmJl/6JWe52S3MiUwSIq8sHPoL9b3r/gxrSIza+bBTzVTeY
	 Fc2pwcxdcVnsSlT2pBXDOLwTlOAxojfv5GUFoP3p88Uf2VY5MiP2mNmg2njJVWh74k
	 yM1iZdxyuwN8zC2YAcY9vI64ThnymqaQUHdFERUI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231019120407epcas5p2f1c529c296e63180f5848cbe11a535ea~PgKkB9THD0651406514epcas5p2n;
	Thu, 19 Oct 2023 12:04:07 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SB5wk18s5z4x9Px; Thu, 19 Oct
	2023 12:04:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3A.73.08567.63B11356; Thu, 19 Oct 2023 21:04:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231019110904epcas5p4028e52ae5c6cefbb73a63f36d7f225e5~PfafYtRX22423124231epcas5p4H;
	Thu, 19 Oct 2023 11:09:04 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019110904epsmtrp2989081c25c3dde0f27403aeba46f8ea3~PfafV-tTY1629616296epsmtrp2V;
	Thu, 19 Oct 2023 11:09:04 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-33-65311b36bb14
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.67.07368.05E01356; Thu, 19 Oct 2023 20:09:04 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110900epsmtip19922c5e976f68e719c2e85f492299e40~PfacF3Tkv2963429634epsmtip15;
	Thu, 19 Oct 2023 11:09:00 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 05/12] fs/read_write: Enable copy_file_range for block
 device.
Date: Thu, 19 Oct 2023 16:31:33 +0530
Message-Id: <20231019110147.31672-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxj2O+dwemBhHAvED8g2UuccGi5F6D4cINmIOXGYsUk2M63YlZNC
	gLbpBTeBjCq3gRREx0IHchkOAbkMEAG5uKpcp6AEsITLCIVN2SDIxnBEGKVl89/zPN/7Pu/l
	y0vh3HyOMxUlVbEKqSiGR9oQTXfc9roLXPis14ObBKrt68LR0l9rBDqX8wJHVRPZJJq/8wwg
	4+00gIpLCwlkuN2CobbSXAxVVN3DUK5+BKDZYR2G2sf2o5LUMgK1tfcSaKi1gERFP8xyUOZo
	M4nKu9cx9DhnFqBmowagprUiHNXMLxKoZ8wFDbzotgpyYlp0ExxmYPJHghm6r2bqK78mmYay
	r5jfGvIBc8uQRDLfay9ZMVnnF0hmaXaMYBY7hklG21gJmIb+eGa5/nWm3vgHFmr3WbR/JCuK
	YBWurFQsi4iSSgJ4HxwLfz/cV+DFd+f7oXd4rlJRLBvACw4JdT8cFbO5DZ5rnChGvSmFipRK
	nmegv0KmVrGukTKlKoDHyiNi5D5yD6UoVqmWSjykrOog38vL23cz8HR05IZmzkq+YPvFQtc0
	JwkMvpIBrClI+8D+vktWGcCG4tK3ACxPfsIxk2cAap4uW8gKgDOXH4HtlMmCHstDO4BTORuk
	maRgMPkXzWYURZH0fti/QZl0BzoFh53jvwMTwekrOJzbKN6ysqfD4MA/PYQJE/QeuJq3sYVt
	6YNwYsbAMRlB2hNmT+00ydb0u7AusxQ3h+yEvfnGrXCcfgOev/EdbvKHdIM1HP35IWZuNRim
	LqWTZmwPn3Y3cszYGS4vtFv0M7Di8jXSnJwMoG5UZ5nzEEzpy8ZNTeC0G6xt9TTLr8Fv+mow
	c+FXYdaa0VLLFjZf2ca74fXaYou/Exz5W2PBDKy+brCsTgtgY2EpJwe46l4aSPfSQLr/SxcD
	vBI4sXJlrIQV+8r5UvbMf/8slsXWg60b2RfcDB4XrXvoAUYBPYAUznOw3cN4sVzbCNGXZ1mF
	LFyhjmGVeuC7ufCLuLOjWLZ5ZFJVON/Hz8tHIBD4+B0Q8Hm7bOdTCiO4tESkYqNZVs4qtvMw
	yto5CSMTKsbShTfj0tr0u20W16kbZxOm/Ts6Z5rCrj483GKYqcQ6j9iVXPs2bmg6t7BBNBT3
	Zu0BXQ6VHMiELVfrqneECIJWdgm1R8sKqjXC5+XJ6R7yvB0nuKTqXmKtDhpia8R+dp8Lh2Pf
	K/JNJ+7H6/3ZqrdWuUJJXUFg3ZPjDs7ejqM2b8cfT76bpdZ2Sz/9STB6KskxoDg16JTxtPUF
	e88HLtPcjAvkyKBEPP7xVGDe87I/jecy42VXB+3cLs5rJ1HHaqnw6K8nV/TK8Y9SMvaeTJ+b
	6WsLKfnkWOp6WvddXxet96HWjZrRE7mLa13lg4N52eSjXvuMhAryw0RqRpHII5SRIv4+XKEU
	/QtMTKkLrAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSnG4An2GqQetKAYv1p44xW3z8+pvF
	omnCX2aL1Xf72SxeH/7EaPHkQDujxYJFc1ksbh7YyWSxZ9EkJouVq48yWUw6dI3R4unVWUwW
	e29pWyxsW8JisWfvSRaLy7vmsFnMX/aU3aL7+g42i+XH/zFZ3JjwlNFix5NGRottv+czW6x7
	/Z7F4sQtaYvzf4+zOkh67Jx1l93j/L2NLB6Xz5Z6bFrVyeaxeUm9x4vNMxk9dt9sYPNY3DeZ
	1aO3+R2bx8ent1g83u+7yubRt2UVo8fm09UenzfJeWx68pYpgD+KyyYlNSezLLVI3y6BK+N/
	4zPWgne8Fe+OPWRvYLzA3cXIySEhYCJxb84J9i5GLg4hgd2MEk/7P7JBJCQllv09wgxhC0us
	/PccqqiZSeLmumagIg4ONgFtidP/OUDiIgL9zBLv/k5nAnGYBdYwS1y5OhOsSFggSKLxcTTI
	IBYBVYkf0/6zgNi8AlYSdx/fZAcpkRDQl+i/LwgS5hSwltjQvQhsrxBQyYMFj9khygUlTs58
	AtbKLCAv0bx1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc9NNiwwzEst1ytOzC0uzUvXS87P3cQI
	jnEtjR2M9+b/0zvEyMTBeIhRgoNZSYRX1cMgVYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZ
	KUIC6YklqdmpqQWpRTBZJg5OqQYmpSu/VuloSHa4LjSXTuP/u6l21TbeOalH3ymez+blNZ3A
	fKrvTGGb9Mo7sx1MgvrmzVf5yKqT2MV+v4dxYdb2BNdEqTK5FqPFXs8+VcwofrpebWJF1pfn
	d//YJQkvfnDzwC67kwHVLJekSyNft1jfKQw/cMbzxwyRSkbB0xU6vNf+Jjce7Erf90L/nvUJ
	n4cKKt9D+KQeH3gt8/NMd0LGFb7fHlt/tF0UcX4851C2eoOWyY5s64U/2H/9TQg+Zf1O98D6
	61t6eQ6z5V9eyNN9Mj+Pb+2SBV9viDW/uS64cmr9siel3gEzNP+sKmZ1nrUr7O3hdQmz/X2C
	LyQmthYIvDhb8yzX6vXrFyfaZUveKrEUZyQaajEXFScCAHuzOrxgAwAA
X-CMS-MailID: 20231019110904epcas5p4028e52ae5c6cefbb73a63f36d7f225e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110904epcas5p4028e52ae5c6cefbb73a63f36d7f225e5
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019110904epcas5p4028e52ae5c6cefbb73a63f36d7f225e5@epcas5p4.samsung.com>

From: Anuj Gupta <anuj20.g@samsung.com>

This is a prep patch. Allow copy_file_range to work for block devices.
Relaxing generic_copy_file_checks allows us to reuse the existing infra,
instead of adding a new user interface for block copy offload.
Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
and inode_out. Allow block device in generic_file_rw_checks.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/read_write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 4771701c896b..f0f52bf48f57 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1405,8 +1405,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    size_t *req_count, unsigned int flags)
 {
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
+	struct inode *inode_in = file_in->f_mapping->host;
+	struct inode *inode_out = file_out->f_mapping->host;
 	uint64_t count = *req_count;
 	loff_t size_in;
 	int ret;
@@ -1708,7 +1708,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	/* Don't copy dirs, pipes, sockets... */
 	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
 		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+	if (!S_ISREG(inode_in->i_mode) && !S_ISBLK(inode_in->i_mode))
+		return -EINVAL;
+	if ((inode_in->i_mode & S_IFMT) != (inode_out->i_mode & S_IFMT))
 		return -EINVAL;
 
 	if (!(file_in->f_mode & FMODE_READ) ||
-- 
2.35.1.500.gb896f729e2


