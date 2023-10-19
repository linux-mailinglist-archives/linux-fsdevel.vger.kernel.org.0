Return-Path: <linux-fsdevel+bounces-746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38FF7CF823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0349A1C20F92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783ED225B5;
	Thu, 19 Oct 2023 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l9kXyZA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F2225A2
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:58 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D51737
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:33 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231019120412epoutp01d785fbb760aef2d0edc8d9faf56b078f~PgKomRzeQ2592825928epoutp01v
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231019120412epoutp01d785fbb760aef2d0edc8d9faf56b078f~PgKomRzeQ2592825928epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717052;
	bh=WRb5UebBvbY1xsMYZIZvAmNJpBcvY4g9cTSXPzDv7NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9kXyZA01NEQvEoLklbSfUIHi58bUKSEbX0gp+bGFNT+eUfW7xwQmEfYDQd1aaFaT
	 gPJi/vnX/aoyyhxbEt+NsIejN4FzgRAp3Ed0i/lCBDBfqvPWZQByedk6Is8KM2QuGk
	 +K2MrMtCMpMxmNymAOqSSonPYm0rdJKOciCLx2oU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231019120411epcas5p22ef9512956a82b118280209dff7c334c~PgKn1cIU20651406514epcas5p2x;
	Thu, 19 Oct 2023 12:04:11 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SB5wp34jmz4x9Ps; Thu, 19 Oct
	2023 12:04:10 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	23.88.10009.A3B11356; Thu, 19 Oct 2023 21:04:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231019110914epcas5p2ce15c70c6f443895bb458dfbdcc50e3b~PfaoryLJd0518805188epcas5p24;
	Thu, 19 Oct 2023 11:09:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231019110914epsmtrp15aa5ab9511ae4a9c05a6e2716dbfecb7~PfaopVnvm2693626936epsmtrp1E;
	Thu, 19 Oct 2023 11:09:14 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-2d-65311b3a36a3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.C9.08755.A5E01356; Thu, 19 Oct 2023 20:09:14 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110910epsmtip1f1eb25b3163831303f673e11c1294f9e~PfalPVO2s2856028560epsmtip1M;
	Thu, 19 Oct 2023 11:09:10 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Date: Thu, 19 Oct 2023 16:31:34 +0530
Message-Id: <20231019110147.31672-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1DTZRzH7/l+v3wZHOQXlHiAIlpRhwZsMsYDiRYQfQ/JozjupK5ba3xv
	EGPb7Ye/OGskg4L4kSLlEuRXJSBMQHT8Ug4OECiX4RAQlGhUxgLFUytC2tgo/3s97+f9fH49
	92Hhnl86+7IypCpGIRVK2KQrcb4/6MXgKD8uw8kZ8UL6kUEc3b2/QqCPS1dx1DhTQqKF/mWA
	zL35AFXVVBBosrcDQ901RzFU3ziAoaN94wDNm3QY6pnahqrz6gjU3TNMoLHOkyQ69c28Myq8
	biDRt0OPMDRROg+QwZwD0PmVUzhqXlgi0OUpP2RcHXJ6xYfu0M0408abLQQ99r2abm34lKTb
	6j6if2s7AeiuSQ1J1xYfc6KLjiyS9N35KYJeumgi6eJzDYBuG82m77X6063mP7CkTW9n7khn
	hGmMIoCRimRpGVJxNHt3siBWEM7ncIO5kSiCHSAVZjHR7LjEpOD4DIl1GuyAfUKJ2iolCZVK
	dujOHQqZWsUEpMuUqmg2I0+TyHnyEKUwS6mWikOkjCqKy+FsD7ca38tM79CXEvKuTQfG+yec
	NGDIrQC4sCDFg7MtuaAAuLI8qS4ANYYBzH5YBrC1vNFx8wBAY3GT88aTqa9LHK4eq6t+wuHS
	YrBurcCpALBYJLUNjq6xbPoWSovDS9OWdRNOVeKwbW4Is4XaTAngvbnadSaoQHj56jhuY3cq
	Cl57aCZtgSAVCktuedhkF+pleLawxmHxgMMnzISNceoZeKT9K9xend4Flk+52zkOrhqPk3be
	DH8fOufowBfeLslz8H5YX3aatNUGqVwAddd1wH6xC2pHSnBbDTgVBPWdoXb5aXh8pBmz530C
	Fq2YMbvuDg2VG/wcPKOvcuT1geMPcxxMw/zuWtw+rGIAqyt+dCoFAbrH+tE91o/u/9RVAG8A
	PoxcmSVmlOHy7VJm/3/fLJJltYL1FdmaYAA/zd4J6QMYC/QByMLZW9wDaQ7j6Z4mPHiIUcgE
	CrWEUfaBcOu8P8d9vUQy645JVQIuL5LD4/P5vMgwPpft7b6grUjzpMRCFZPJMHJGsfEOY7n4
	arDA+wq/l3im1JQ/E7Wu7YpiZWZ+P2HInTi0WzOWGfbPjZUEy8+E5P2K9Gn1a4NxM+bUFBn/
	+SZvPPuNZJk68DOT56x3UPThH67yjW5k+YctB/19nuL9agram31peizwwgeFu8QxX9Qslp9+
	fbLmTm/UDRD1i9xkaXoQvT9OoP/EjI1yJpdl1c/GJ1fs3JNS5t+8p/dVkQb6BlfclKfGuzat
	RqyFXbl1MvH2cNSZ2PIn+zhBktQX/l4pU3U3Dx6WLl57dzHmkXhfzlmvY5YDosV3EpKuRFiM
	xMBFUV/LtPjNTh/GQwR7aFGMUIH2trtJ5zrGv5uojC3S/rWUx3kr74JlpoZNKNOF3K24Qin8
	F0tvCoSrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzHfZ/nueee4vR0Ud9kzOGPfrvV1ndqYWP7zkz+YCw/T/f0Y666
	3an8mo4sXHQpOneVcgkdI3c5/VD6gVIahlMtMV2JViQUdsV1s/Xfe+/X6/P+58OQwg5qAZOQ
	tJ9TJElkItqVsjSLFgVGzxVzK/pKBeh222MSjf74Q6HjOXYS3XirodFQ8zeAbA0nASoxFFGo
	q6GaQPcNuQQqv/GIQLlNVoD6X+sJVNftjy5nXqHQ/bonFHpZU0ij4qv9fJT1popG11omCdSZ
	0w9Qle0YQJY/xSS6NfSFQq3dPuiZvYW32htX69/y8bPeOxR+2ZGCTcbTNDZfSceDZh3AtV0q
	Gpdm5/Hw2YwRGo/2d1P4S/1rGmdXGgE2tx/GY6ZF2GQbJja5RbtGSDlZQiqnCI7c4xpffTuH
	kte6HbA2d/JUoGWOGrgwkA2F3WUaQg1cGSFbC+DP5jLCCbzhVftD0pk9YPnkR75TyiBgQ/kr
	Sg0Yhmb9YfsU4+jnsRoSjti108cke5OElUUCR/Zgd0KtTk87MsUuh60vrNOjAnYlfDVuox07
	kA2GmnfujtqFDYcVWYZpRfhPeV/Sx3fq7vCJzkY55xfDjLsFZA5g9TOQfgYqAYQReHNyZWJc
	olIsFydxaUFKSaIyJSkuKCY50QSmP+7nWwXuGb8GNQGCAU0AMqRonmA5XsEJBVLJwUOcInm3
	IkXGKZuAD0OJvAReg2elQjZOsp/bx3FyTvGfEozLAhXhNuI1NejzaX4NSzTamJDUcfGP0dKb
	wQb+0EDMwajaUE+eprBodo1w9oFrq7OnNvd9t2SZQ3SPCqKLZe6B9b5hPbzWM1FHOn1jFqdd
	Prr3xZ6QwPW9po7Y4g3Lkj/4fmoHlp6e86q1wgo7E65VrGLurnsw4RkwFpL5OW/8QSTlucYD
	k5Fbon5fP9VaCEXb3KwXWe1zz7S8tfk/F3ZIpem/s0+MqFPFlnMXvubPN3g3cuqA6qW/rBvb
	XM5N+OsEk70V28K045mz8hsrP8/dWmD3T9hQEGEuO2luM3/bnb5lSay8bGBX0NPJdONA5PPH
	YadllyRLJ4ZptH2H34l420fVXhGljJeI/UiFUvIXeN3BjGADAAA=
X-CMS-MailID: 20231019110914epcas5p2ce15c70c6f443895bb458dfbdcc50e3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110914epcas5p2ce15c70c6f443895bb458dfbdcc50e3b
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019110914epcas5p2ce15c70c6f443895bb458dfbdcc50e3b@epcas5p2.samsung.com>

For direct block device opened with O_DIRECT, use copy_file_range to
issue device copy offload, or use generic_copy_file_range in case
device copy offload capability is absent or the device files are not open
with O_DIRECT.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/fops.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 73e42742543f..662d36a251a3 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -735,6 +735,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
+				      struct file *file_out, loff_t pos_out,
+				      size_t len, unsigned int flags)
+{
+	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
+	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
+	ssize_t copied = 0;
+
+	if ((in_bdev == out_bdev) && bdev_max_copy_sectors(in_bdev) &&
+	    (file_in->f_iocb_flags & IOCB_DIRECT) &&
+	    (file_out->f_iocb_flags & IOCB_DIRECT)) {
+		copied = blkdev_copy_offload(in_bdev, pos_in, pos_out, len,
+					     NULL, NULL, GFP_KERNEL);
+		if (copied < 0)
+			copied = 0;
+	} else {
+		copied = generic_copy_file_range(file_in, pos_in + copied,
+						 file_out, pos_out + copied,
+						 len - copied, flags);
+	}
+
+	return copied;
+}
+
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
@@ -839,6 +863,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.copy_file_range = blkdev_copy_file_range,
 };
 
 static __init int blkdev_init(void)
-- 
2.35.1.500.gb896f729e2


