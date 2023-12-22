Return-Path: <linux-fsdevel+bounces-6775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D581C5A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8ACD284B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A5C20B33;
	Fri, 22 Dec 2023 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aFFNXEWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4EC1EB50
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231222073216epoutp02362cb8aad8697a2966f1e8ecb973264b~jFvdspIol1675316753epoutp02C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231222073216epoutp02362cb8aad8697a2966f1e8ecb973264b~jFvdspIol1675316753epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230336;
	bh=WyEZwCEcMZEgd+uPDvb2WQHlAKDzDTA2b4v6jEJOw5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFFNXEWcDSD08Jt4soITZ4CqvtFquJiYPLx0JiGHGyIuKL+tH5o9yZKacBbvZ7Xhv
	 PrUqQ07BqhP1aOUJ7RAM0MbQO44oIDoqpipf5559/APFr+SAQWTyYAsfmfsIKF1JcH
	 heaUv64PVHtIzO+3iUTb9CURktKTFXKaXl5vVvvg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231222073215epcas5p3d382a2a311619cd6cbaeddbeb22c4db8~jFvdKbJmw0585105851epcas5p31;
	Fri, 22 Dec 2023 07:32:15 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SxJsT44Cmz4x9Q1; Fri, 22 Dec
	2023 07:32:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.54.08567.D7B35856; Fri, 22 Dec 2023 16:32:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231222062136epcas5p18f39a4dea2e66c56c652f29c0dc85a15~jExxKy2F72292622926epcas5p1C;
	Fri, 22 Dec 2023 06:21:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231222062136epsmtrp2e00b9a0c775dac9476ac12096c995dc0~jExxJ2QAp1637116371epsmtrp2K;
	Fri, 22 Dec 2023 06:21:36 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-7e-65853b7d75e0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.3D.07368.0FA25856; Fri, 22 Dec 2023 15:21:36 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062132epsmtip2ec4c90b353e75c0a4e1c894584ccc4c5~jExtyQ-Ok0362303623epsmtip2U;
	Fri, 22 Dec 2023 06:21:32 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v19 05/12] fs/read_write: Enable copy_file_range for block
 device.
Date: Fri, 22 Dec 2023 11:42:59 +0530
Message-Id: <20231222061313.12260-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUZRTvu3f3smALFyT7XIZiNmkQXGCL3T5UhFG0O8VMBGiN0wzcYa/A
	ALvbPjJsQhCQR8oCYhNL8hKpBUaUl8tjzUDeKRnyLEpHIHINB8ggGZdYLpT//c7vnN/vfOd8
	c3i4U7GNgBcn1zAqOZ0gJOw4zZ07PUWf78lgfOtWBKiuvxtH809WOOhU3jMc1UzqCGTuXABo
	6kYmQGUVFzho/EYLhtorCjBkqOnCUEHHCEDTw3oMmSa8UPnpSg5qN/Vx0FDr1wQqrZq2QV+M
	Ggn0TY8FQ2N50wDlZw1jyDiVClDzSimOLpsfc1DvhAsafNbDDRJQLfpJG2rw16scauiWlqqv
	ziaohsqT1GxDEaDaxlMI6mLuOS51Nm2OoOanJzjU4+vDBJXbWA2ohoHPqMX6V6j6qT+xUIej
	8XtjGVrGqNwYebRCFiePCRC+Gx55IFIi9RWLxP7oLaGbnE5kAoTBIaGiQ3EJaysRun1CJ2jX
	qFBarRb67NurUmg1jFusQq0JEDJKWYLST+mtphPVWnmMt5zR7Bb7+r4hWSuMio9dTZ3hKuf4
	n85137dJAT9uyQG2PEj6QXO9GbNiJ7INwNv36Rxgt4YXADQ8+oHLBn8DOFb8BN9UFKSVYGzC
	BGB6toXDBhkYPJ/5D5EDeDyC9IIDqzyrwJmsxWHLVbG1BidLcDizWgasia1kBHxwqZ9jxRzS
	HVaduUJYMZ/cDR8uTK77QNIH6n5ztNK25B74+9OLXLbEEfYVTa1LcfJVmNZUjFv9IXnNFj7I
	a9rQBsOKAgX76K3wYU+jDYsFcHHORLD4ODQUfkuw2nQA9aN6wCYCYUa/Drf64OROWNfqw9Ku
	8Hz/ZYztaw/PrkxhLM+HxpJN/BqsrSvb8N8OR5ZSNzAFh7//CbC7ygXw56FWmzzgpn9uHv1z
	8+j/b10G8GqwnVGqE2OYaIlSLGeO//fJ0YrEerB+JZ7BRjBWavHuABgPdADIw4XOfMWudMaJ
	L6OTTjAqRaRKm8CoO4Bkbd/5uOClaMXamck1kWI/f18/qVTq5/+mVCx8mW/OuCBzImNoDRPP
	MEpGtanDeLaCFMw1/mnbtagjFLfFFGcoDKgcLcsqad4W5kHMv3j0sHnZW+u4avyoTXTA9x3K
	w3hPcmjgbmaI69zyHY3IIki+bbmUuU/od8/OvqtkNmz1XD9aDHo7NqwHK9iVd8ekfsG5u9Z+
	i+rUtGRwadm9XDQb+uHrqvnIaYFra7m9Z0YSlnwiqT7k/blbomNZhqqanizGfOb6oMohyGV/
	9v7Fbe6NdwexqEDXX8hA90ceEe+RV/yr8otOw84ol+qvRO3SssMWOj9Zd3JJNxMeXqjs+YD7
	3aKo1yT00q0ea3dylPUe8T8oc4wo71J/qaV3ZIxg464eTTtuZkZ8/NfNBQfeH6OReX0GIUcd
	S4s9cZWa/hfUNTGLrgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RezBUYRjG+845exxbW8dm6otK7ZRKRSZTn+4zmul0G7rMFLrtcEbG2t3O
	0n3KtoUkl9VUVlEKsbrZGBJp2YSWZlgilGGTmohGM4VVVs303zPP73l//7wULqwnHKhgaRjL
	ScUSEcknCspFTku/uVxgl2k7BOhh9Usc9Q8OEehcwgiOtG3xJPpSPgBQV1kUQLfSbxKouawI
	Q8/S1RjK1howpNY3AmQ2aTBU0rIY3Y68S6BnJVUEqn96g0RpmWYbdKmpkERZlRYMvU0wA5QY
	bcJQYZcSoIKhNBw9+NJHoFctjqhupJK3wYEp0rTZMHXtjwmm3hjO5OVcJBnd3bPMJ10yYIqb
	I0jmTlwSj7ms6iWZfnMLwfSVmkgm7kkOYHQ1p5jvebOZvK6vmM8UP/6aQFYSfJTl3NYd4h8e
	VX7kyXsFx3tfdthEgDcTY4AtBWkPqFalYjGATwnpYgD7Rn8Q42AGzBypwMfzVJht6bYZH6kw
	OJz6mIwBFEXSi2HNKDXW29OFOPx5X2U14XQuDhtMyeTY9VR6J1R+zbdaCXo+zIx9ZO0F9Cr4
	eaDNKoK0G4x/bzdW29KrYfevO7yxLPwzqerW/Z3bwarkLqsGp52gKj8FTwC05j+k+Q/dAlgO
	mMHKFaFBoQHucncpe8xVIQ5VhEuDXANkoXnA+neXhYWgPc3iqgcYBfQAUrjIXiBbcp4VCgLF
	J06ynOwgFy5hFXrgSBGi6QL36ymBQjpIHMaGsKyc5f5RjLJ1iMD2eBVrf1aXRGaXukQZL/kU
	7zIeSKhavqnTL2Rlu2/GhmHzlQABX+ok+Bjrf9lw9gp5sGJOpykEE7V6vGhodZ77euKZnu07
	yvfWaNWDPM98vclB+anH+2jtHENR0izLcb6/94P+k9NaPb+5JQ7YymupSV7O33nG8n2OK/wH
	Ugd9worClySZ9mddXZvbEMJxk9bbR9xs2t2zNQ75Nsos+YsMhvQ1ubl+Rh/UH7B53QkUyW0M
	njl5dsOB6OlK/VVZ56pfBu0HybYY3DIvujrlGmZfyx2J7T3j6ZVY6f2uY4V5o+uCQfWj7VKJ
	7t6EpurSgkqZUpmBRwXPf45ltZ7eQp7TiAjFYbG7C84pxL8BvynQ1GYDAAA=
X-CMS-MailID: 20231222062136epcas5p18f39a4dea2e66c56c652f29c0dc85a15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062136epcas5p18f39a4dea2e66c56c652f29c0dc85a15
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062136epcas5p18f39a4dea2e66c56c652f29c0dc85a15@epcas5p1.samsung.com>

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


