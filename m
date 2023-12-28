Return-Path: <linux-fsdevel+bounces-7000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E381F837
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 13:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9BB1C21370
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 12:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60A748D;
	Thu, 28 Dec 2023 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="pppqqKGd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE576748F
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oggw17zeExrhE6tJv/RSCgUv5D7RjyIT6d2nF6ZfR+m4X8+AXjDA8lvvp3wPoNt+YU3f0cJx116WzzR2s10pms2Kh8Yu+2a9Fnts0kSfbNorkBu3m2WhUVGNSryNvYmo2NQ/aL0pyfCoKKMW8XFYZzyY2OFoRrWZvHL3KMvSmWpvVs2k357XGaHFa+PBZfa0JUT/L8ap60FDgCAFxlSPOxkfBJR+xcUz92GOeRADyardYQUAL48tjJOO0S8e86UBqV0ktdUKzVJ0V0Ov+SPrJrtd3xLAGdYC3pmSKXcqW16ItoavKpAKuQ9q3Q4dgcd7OgeGsgLRP/E7f2HcmROahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJb8MD8veX1cr8ETpfntdLVaT6yQzX9/nfYjeSlN3IA=;
 b=QyVIcfGXCXGwyorvH5VV/Tn3YiZksSy5xVlj/FbSTnEQ2o2Wp/mq0f4Mowe8yeYLhQrAQTXnypVYwhmsFKDuR0jMdfhhlvdbMu+knnq5tk/iL0MRKa3p1lAHweBmycgLvnQYuTDtO3ti/AH9nOllqgZsFsHEvJuo2tCjMLHES5hqfVhmlFbZtCgunRTGf+1j52Plzf79ZMZ4e3EYcEP2YMO+w8xznRqljT3+ft2bwj1VgNWNaN3m2Xg7HNoYWWkvWftrI/zPfIin8lccPR0vAAHk43AxbuSV3tmD2XKH2JT4WNzFzn7HbQuQ/oYsyT+fEtqzw5vMtz3MKasDYtPfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJb8MD8veX1cr8ETpfntdLVaT6yQzX9/nfYjeSlN3IA=;
 b=pppqqKGdq12pF/WiUnxW8nP1d/mvDeE0jN3+zHhzT8nEZmIRFn1tX9cusEqfmVjOdppbVvx6mdr+BYLUUrhYkU52PLUvJeJmm7WTlmIr0iL+fE9Cs91FaKyk9doALAT372HjSQKZOhU2zQ4Cpc44u/fOuw2WBpdjughjpm1O8pkJU8DfZ9yGpjYLAtaraU5NSMibDkXwMDmE/r9Bp2+VrjmyLm2eSvLyvOWQJ1PAs1M9tW7T7ihvcNYQvGQTKsylN8td3FjSa1g+un2qc2fD+oQWiNvD4txqwbMzvU2Z4e5AP+Z9+tWXAXzSHRxKRB9eHAKYqZobkjld3BbkW2ZFNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com (2603:1096:4:1ec::12)
 by SEYPR06MB6822.apcprd06.prod.outlook.com (2603:1096:101:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 12:36:21 +0000
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::ed1b:8435:e0a1:e119]) by SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::ed1b:8435:e0a1:e119%4]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 12:36:21 +0000
From: Xiaoguang Wang <lege.wang@jaguarmicro.com>
To: linux-fsdevel@vger.kernel.org
Cc: vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu,
	shawn.shao@jaguarmicro.com,
	Xiaoguang Wang <lege.wang@jaguarmicro.com>
Subject: [RFC] fuse: use page cache pages for writeback io when virtio_fs is in use
Date: Thu, 28 Dec 2023 20:35:28 +0800
Message-ID: <20231228123528.705-1-lege.wang@jaguarmicro.com>
X-Mailer: git-send-email 2.43.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::32) To SI2PR06MB5385.apcprd06.prod.outlook.com
 (2603:1096:4:1ec::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5385:EE_|SEYPR06MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e1c320-9b95-4e35-469b-08dc07a19878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	biEVL9Sjl/H5l0pop8p5JDrdWFeIzzRI6ao0VoLjtFHeMWFCID7rywWc+NPPWuRL3b5mQHzRaBBieFuDfAbxyX+M3vLeLtaBrEGtuPGfBfFLAjlSdkVihd7sn/V8Cbvxl0qW9POjIjJW3dqxt5wLev+hQKUgGyh3jOsCMJlcnK4k9/HlCR8o/2NHhwMoMGGuy2VigfN01SjMVG887s7SxpLAv2C4O8ZUr3/CEoQLtkfjtPN6QrGNoUAbWZJyvP+8jlIZaajW3RK5k8MXCoD2aWin9xTpnbCip/dEgKi5dMa6cG2PAGwBX8JeO53IP2HcCtjkkbCVHjGSHGVa2AafAcVnSjMt37+QhVKxUynk868z0QyRvuXSI4n6fvsgvVI/KIe/OVdo3NXW6d7YsAzAuOmgswb//z8Q5CvRuE+xUIySDZn6W81sLQrtvdCImkjQZ29znBv+ZsnuKjqAjznUXQKCHxZHMHupKF4XDuZpzK6WyZ+tRLaUBDxUrQ7bfFzxQHjXblMbfrghLoccZoXVJHZeRsmSATgJl9hMjBMsURKYfWSZE4GhXEaUwPIaZBalIeXXMTCLFTrlqpMp5DPymOP5mS2oyYGCsKcK6QQcygI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5385.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39830400003)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2616005)(83380400001)(41300700001)(1076003)(107886003)(316002)(38100700002)(26005)(5660300002)(8676002)(8936002)(4326008)(2906002)(30864003)(478600001)(6486002)(6506007)(6512007)(66556008)(66946007)(6916009)(966005)(52116002)(66476007)(86362001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?apAf6S8r59XoA6cDfhtBbf1p9ypfscFHN/R95602Hkusss0+LqY7muXS7H3X?=
 =?us-ascii?Q?fSGrL5M29deCrtYeBvIxE0XtX0jRPIlduSkT8jmQAT+S+3RGWYZNXIJl3L3z?=
 =?us-ascii?Q?b2HpvYZvLB5V0m4rf7UxWnWJ1GRESx2GxLcUMRI9fANz1JGcSZ2skLWW0egc?=
 =?us-ascii?Q?1DFC7uQesvABRusMpdCrW2+i0HGkpk4l3a6CnzI4oeyyDwLLQOT/H8a2CEro?=
 =?us-ascii?Q?RwcnOp3H0wz7VJDyotGSKgNrrlvyv2akwq30DW0QbynpBS3pJIdLb+kGeSgQ?=
 =?us-ascii?Q?8g9P7hu6tdk1YU5zgVUheguizn3geD2/SOmRUjDFiIClgeZqkerVpyE6FfQP?=
 =?us-ascii?Q?/RDgPnMSJkirtG21kb2flmYN+BLmbi8U7XeHhQnRbWIY3I9sI1S3g5jPKQX2?=
 =?us-ascii?Q?QdsKZAFJM7kRi66j2z2vJz9OG7aOjAaPTDZhqmyIc9bnXOiSi4DaSklWGY5J?=
 =?us-ascii?Q?lqC/pZC6uI7DR0zy3WU8nhg3HhBW9O+bdd9z8zyvalvfkh3mLlnbHrVXdT5U?=
 =?us-ascii?Q?fnek1rMn4jYmJhuvyCYVlQAgco1w7yC2zUcys9O2fCfdSYe/AhJhpRm7fLiR?=
 =?us-ascii?Q?jYPUWyGan8Ha9kANPclRDGZ7GPllKbFw1V/8fcxWtz0HZ99rQsJ4p2kh7335?=
 =?us-ascii?Q?6rRDlSge4eODnDE+B9SwmfGP4h+anYRKKNtonEkFNCZkmhP+VnlNclYpatd9?=
 =?us-ascii?Q?yt066wAYBOYOXzssRogB+9MR8dxfK/PwRuzT/A5nV5Jq0q8JpTQwNcQm0mKr?=
 =?us-ascii?Q?eNGlB34rLO3wYKBJBlZbGFQpPg+H4wg3yjaGricMczRk9QD68nqwIcM6LFNv?=
 =?us-ascii?Q?KgjM1w8+AtMuIaLV73hx36n1rwXxShe1R9z+g3+EcVAhg0dMD/SSYGUjgNd7?=
 =?us-ascii?Q?T5BiJ6Cpm4hwF082dBZbXxI+pTGlOU0zOO7K+91xdzznC0+H+fAShHsw9RoW?=
 =?us-ascii?Q?DfvtC/zNmV1yzyt1/AhWyjQ8gd5xyQmK4/9JY+TohF5MocihrVfFYjOxTAPb?=
 =?us-ascii?Q?gPJZVyvq7eVjyTjKOeH7oBoC+RV6J7W6hKu0yjfbms7LbH+q8TGGRgphoOrZ?=
 =?us-ascii?Q?13C3zaH1japAdGDU+VR/hx6thYx+WkskO7Gvob0LhTie1bVFKS7yxsHVPBRT?=
 =?us-ascii?Q?6I/faJ6QtQ8OGCXnM7/PwqXaAwoVdxWkglN3S+KBOla5Vi4bhY7BWNSF6FOi?=
 =?us-ascii?Q?SlaDUX0j8QiymVhPIkGsIjG03h8xXJ2tdJzEDB56UznAVfUAWsu/lZU+XwCA?=
 =?us-ascii?Q?PgHFwPdHBTXtv+g3gOcsuMwaA8Bi9D8pmT8/IN/112n3s2QF0hICJiHXlz+P?=
 =?us-ascii?Q?2a/mTK9Xlt0ZzTAaj0B0vfQIgKFZVJXg5Ux8k3LwIfXqye/sJ/rFkN6k6Nel?=
 =?us-ascii?Q?y7uaF5KQHQ02AC7rWKvO42Fp/oXAUqxTEbXy/V4J/3WsNLrIDHtZ4/UavtfC?=
 =?us-ascii?Q?KmVELdFUmriVyh/5lSj2eER5lR5p3A7TJwqpCCMQBnWOf8P38fTpRYOCTbZd?=
 =?us-ascii?Q?SzSlqG0KNzkkMyVbZwULKw35y2ouUUW9rMJP2To25n4nqqelz9YvsvmzoZ5r?=
 =?us-ascii?Q?2AQus7fww9C980SME1L3njf+FL4mWXZ4HzeUghWslDgNHLqZknnyUZPcPGg8?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e1c320-9b95-4e35-469b-08dc07a19878
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5385.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 12:36:21.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8MXriwM0AvxVIXxRXkg02ZsMjnGPw5tn+fjuLIMlonaHZNduSEyAmf7GpUzkCVTiNt2oq9D6rC3tRjUhKjAv+XDZzcfV2y/q0a4JVIy908=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6822

Currently if writeback cache policy is enabled, fuse will allocate
temporary pages with GFP_NOFS|__GFP_HIGHMEM for writeback io, commit
3be5a52b30aa ("fuse: support writable mmap") introduces this behavior
primarily for the following two reasons:
  1. filesystem based on fuse may also need additional memory resources
     to complete a WRITE request, then there's a great danger of a
     deadlock if that allocation may wait for the writepage to finish.
  2. buggy or even malicious userspace filesystem may fail to complete
     WRITE requests, then unrelated parts of the system may hang, for
     example, sync operations may hang.

As commit 3be5a52b30aa said, this approach is wasteful in both memory
and CPU bandwidth, but it's necessary for traditional fuse userspace
filesystems. With the emergence of the virtio-fs file system, the
virtio-fs userspace backend are typically provided by cloud providers,
which may have bugs, but should not be seem as malicious, also vm and
virtio-fs userspace backend normally run on different os, so the
deadlock should not happen, though vm hypervisor is running on the os
same to virtio-fs userspace backend.

Nowadays, modern DPUs(Data Processing Unit) start to support virtio
filesystem device, below is virtio-fs spec:
  https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-49600011
Cloud providers or hardware manufacturers provide DPUs, they should
be seem as trusted hardwares, just like nvme ssd nic, etc. The
DPU also has a running os interenally, the basic architecture would look
like below:
      --------------------------
     | host machine             |
     |                          |
     |--------------------------|
     |       os/virtio-fs       |
     ---------------------------|
     |       hardware           |
      --------------------------
                |
                |(pci)
                v
      -------------------------------
     | DPU                           |
     |                               |
     |  virtio-fs userspace backend  |
     |-------------------------------|
     |          os                   |
     | ------------------------------|
     |         hardware              |
      -------------------------------

Obviously, for virtio-fs case, temporary pages are unnecessary, so this
patch changes the write-back cache policy a bit, if fuse req is passed on
virtio_fs channel, there's no needs to allocate temporary pages, use
page cache pages for write-back io directly.

Use fio to evaluate performance improvement:
[global]
ioengine=psync
fsync=1
direct=0
bs=1048576
rw=randwrite
randrepeat=0
iodepth=1
size=512M
runtime=30
time_based
filename=/home/lege/mntpoint/testfile2

[job1]
cpus_allowed=1

Before patch:
WRITE: bw=655MiB/s (686MB/s), 655MiB/s-655MiB/s (686MB/s-686MB/s), io=19.2GiB (20.6GB), run=30001-30001msec

After patch:
WRITE: bw=754MiB/s (790MB/s), 754MiB/s-754MiB/s (790MB/s-790MB/s), io=22.1GiB (23.7GB), run=30001-30001msec

About 15% throughput improvement.

Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>
---
 fs/fuse/file.c      | 109 +++++++++++++++++++++++++++++++-------------
 fs/fuse/fuse_i.h    |   6 +++
 fs/fuse/inode.c     |   5 +-
 fs/fuse/virtio_fs.c |   1 +
 4 files changed, 89 insertions(+), 32 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..3d14a291cd3e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -400,6 +400,7 @@ struct fuse_writepage_args {
 	struct fuse_writepage_args *next;
 	struct inode *inode;
 	struct fuse_sync_bucket *bucket;
+	bool has_temporary_page;
 };
 
 static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
@@ -1660,8 +1661,10 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	if (wpa->bucket)
 		fuse_sync_bucket_dec(wpa->bucket);
 
-	for (i = 0; i < ap->num_pages; i++)
-		__free_page(ap->pages[i]);
+	if (wpa->has_temporary_page) {
+		for (i = 0; i < ap->num_pages; i++)
+			__free_page(ap->pages[i]);
+	}
 
 	if (wpa->ia.ff)
 		fuse_file_put(wpa->ia.ff, false, false);
@@ -1681,10 +1684,14 @@ static void fuse_writepage_finish(struct fuse_mount *fm,
 
 	for (i = 0; i < ap->num_pages; i++) {
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		dec_node_page_state(ap->pages[i], NR_WRITEBACK_TEMP);
+		if (wpa->has_temporary_page)
+			dec_node_page_state(ap->pages[i], NR_WRITEBACK_TEMP);
+		else
+			end_page_writeback(ap->pages[i]);
 		wb_writeout_inc(&bdi->wb);
 	}
-	wake_up(&fi->page_waitq);
+	if (wpa->has_temporary_page)
+		wake_up(&fi->page_waitq);
 }
 
 /* Called under fi->lock, may release and reacquire it */
@@ -1823,6 +1830,9 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 	if (!fc->writeback_cache)
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
 	spin_lock(&fi->lock);
+	if (!wpa->has_temporary_page)
+		goto skip;
+
 	rb_erase(&wpa->writepages_entry, &fi->writepages);
 	while (wpa->next) {
 		struct fuse_mount *fm = get_fuse_mount(inode);
@@ -1859,6 +1869,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 		 */
 		fuse_send_writepage(fm, next, inarg->offset + inarg->size);
 	}
+skip:
 	fi->writectr--;
 	fuse_writepage_finish(fm, wpa);
 	spin_unlock(&fi->lock);
@@ -1952,8 +1963,9 @@ static int fuse_writepage_locked(struct page *page)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_writepage_args *wpa;
 	struct fuse_args_pages *ap;
-	struct page *tmp_page;
+	struct page *tmp_page = NULL;
 	int error = -ENOMEM;
+	int needs_temporary_page = !fc->no_temporary_page;
 
 	set_page_writeback(page);
 
@@ -1962,9 +1974,11 @@ static int fuse_writepage_locked(struct page *page)
 		goto err;
 	ap = &wpa->ia.ap;
 
-	tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
-	if (!tmp_page)
-		goto err_free;
+	if (needs_temporary_page) {
+		tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+		if (!tmp_page)
+			goto err_free;
+	}
 
 	error = -EIO;
 	wpa->ia.ff = fuse_write_file_get(fi);
@@ -1974,19 +1988,24 @@ static int fuse_writepage_locked(struct page *page)
 	fuse_writepage_add_to_bucket(fc, wpa);
 	fuse_write_args_fill(&wpa->ia, wpa->ia.ff, page_offset(page), 0);
 
-	copy_highpage(tmp_page, page);
+	if (needs_temporary_page) {
+		copy_highpage(tmp_page, page);
+		ap->pages[0] = tmp_page;
+		inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
+	} else {
+		ap->pages[0] = page;
+	}
 	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
 	wpa->next = NULL;
 	ap->args.in_pages = true;
 	ap->num_pages = 1;
-	ap->pages[0] = tmp_page;
 	ap->descs[0].offset = 0;
 	ap->descs[0].length = PAGE_SIZE;
 	ap->args.end = fuse_writepage_end;
 	wpa->inode = inode;
+	wpa->has_temporary_page = needs_temporary_page;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
 
 	spin_lock(&fi->lock);
 	tree_insert(&fi->writepages, wpa);
@@ -1994,12 +2013,14 @@ static int fuse_writepage_locked(struct page *page)
 	fuse_flush_writepages(inode);
 	spin_unlock(&fi->lock);
 
-	end_page_writeback(page);
+	if (needs_temporary_page)
+		end_page_writeback(page);
 
 	return 0;
 
 err_nofile:
-	__free_page(tmp_page);
+	if (needs_temporary_page)
+		__free_page(tmp_page);
 err_free:
 	kfree(wpa);
 err:
@@ -2013,7 +2034,7 @@ static int fuse_writepage(struct page *page, struct writeback_control *wbc)
 	struct fuse_conn *fc = get_fuse_conn(page->mapping->host);
 	int err;
 
-	if (fuse_page_is_writeback(page->mapping->host, page->index)) {
+	if ((!fc->no_temporary_page) && fuse_page_is_writeback(page->mapping->host, page->index)) {
 		/*
 		 * ->writepages() should be called for sync() and friends.  We
 		 * should only get here on direct reclaim and then we are
@@ -2084,8 +2105,11 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 	fuse_flush_writepages(inode);
 	spin_unlock(&fi->lock);
 
-	for (i = 0; i < num_pages; i++)
-		end_page_writeback(data->orig_pages[i]);
+
+	if (wpa->has_temporary_page) {
+		for (i = 0; i < num_pages; i++)
+			end_page_writeback(data->orig_pages[i]);
+	}
 }
 
 /*
@@ -2156,7 +2180,8 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 	 * the pages are faulted with get_user_pages(), and then after the read
 	 * completed.
 	 */
-	if (fuse_page_is_writeback(data->inode, page->index))
+	if (data->wpa->has_temporary_page &&
+	    fuse_page_is_writeback(data->inode, page->index))
 		return true;
 
 	/* Reached max pages */
@@ -2187,8 +2212,9 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct page *tmp_page;
+	struct page *tmp_page = NULL;
 	int err;
+	int needs_temporary_page = !fc->no_temporary_page;
 
 	if (!data->ff) {
 		err = -EIO;
@@ -2202,10 +2228,12 @@ static int fuse_writepages_fill(struct folio *folio,
 		data->wpa = NULL;
 	}
 
-	err = -ENOMEM;
-	tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
-	if (!tmp_page)
-		goto out_unlock;
+	if (needs_temporary_page) {
+		err = -ENOMEM;
+		tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+		if (!tmp_page)
+			goto out_unlock;
+	}
 
 	/*
 	 * The page must not be redirtied until the writeout is completed
@@ -2223,7 +2251,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	if (data->wpa == NULL) {
 		err = -ENOMEM;
 		wpa = fuse_writepage_args_alloc();
-		if (!wpa) {
+		if (!wpa && tmp_page) {
 			__free_page(tmp_page);
 			goto out_unlock;
 		}
@@ -2242,14 +2270,20 @@ static int fuse_writepages_fill(struct folio *folio,
 	}
 	folio_start_writeback(folio);
 
-	copy_highpage(tmp_page, &folio->page);
-	ap->pages[ap->num_pages] = tmp_page;
+	if (needs_temporary_page) {
+		copy_highpage(tmp_page, &folio->page);
+		ap->pages[ap->num_pages] = tmp_page;
+		data->orig_pages[ap->num_pages] = &folio->page;
+		inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
+	} else {
+		ap->pages[ap->num_pages] = &folio->page;
+		data->orig_pages[ap->num_pages] = &folio->page;
+	}
 	ap->descs[ap->num_pages].offset = 0;
 	ap->descs[ap->num_pages].length = PAGE_SIZE;
-	data->orig_pages[ap->num_pages] = &folio->page;
+	wpa->has_temporary_page = needs_temporary_page;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
 
 	err = 0;
 	if (data->wpa) {
@@ -2260,10 +2294,16 @@ static int fuse_writepages_fill(struct folio *folio,
 		spin_lock(&fi->lock);
 		ap->num_pages++;
 		spin_unlock(&fi->lock);
-	} else if (fuse_writepage_add(wpa, &folio->page)) {
-		data->wpa = wpa;
+	} else if (needs_temporary_page) {
+		if (fuse_writepage_add(wpa, &folio->page))
+			data->wpa = wpa;
+		else
+			folio_end_writeback(folio);
 	} else {
-		folio_end_writeback(folio);
+		spin_lock(&fi->lock);
+		data->wpa = wpa;
+		ap->num_pages++;
+		spin_unlock(&fi->lock);
 	}
 out_unlock:
 	folio_unlock(folio);
@@ -2436,6 +2476,9 @@ static vm_fault_t fuse_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct folio *folio = page_folio(vmf->page);
+	int has_temporary_page = !fc->no_temporary_page;
 
 	file_update_time(vmf->vma->vm_file);
 	lock_page(page);
@@ -2444,7 +2487,11 @@ static vm_fault_t fuse_page_mkwrite(struct vm_fault *vmf)
 		return VM_FAULT_NOPAGE;
 	}
 
-	fuse_wait_on_page_writeback(inode, page->index);
+	if (has_temporary_page)
+		fuse_wait_on_page_writeback(inode, page->index);
+	else
+		folio_wait_stable(folio);
+
 	return VM_FAULT_LOCKED;
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6e6e721f421b..9958f672ba47 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -646,9 +646,15 @@ struct fuse_conn {
 	/** Filesystem supports NFS exporting.  Only set in INIT */
 	unsigned export_support:1;
 
+	/** Indicate fuse req is passed on virtio_fs channel **/
+	unsigned virtio_fs_ch:1;
+
 	/** write-back cache policy (default is write-through) */
 	unsigned writeback_cache:1;
 
+	/** Indicate whether write-back cache policy should use temporary pages **/
+	unsigned no_temporary_page:1;
+
 	/** allow parallel lookups and readdir (default is serialized) */
 	unsigned parallel_dirops:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 74d4f09d5827..69da39728ae0 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1191,8 +1191,11 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_ASYNC_DIO)
 				fc->async_dio = 1;
-			if (flags & FUSE_WRITEBACK_CACHE)
+			if (flags & FUSE_WRITEBACK_CACHE) {
 				fc->writeback_cache = 1;
+				if (fc->virtio_fs_ch)
+					fc->no_temporary_page = 1;
+			}
 			if (flags & FUSE_PARALLEL_DIROPS)
 				fc->parallel_dirops = 1;
 			if (flags & FUSE_HANDLE_KILLPRIV)
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..dfa3806f979f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1346,6 +1346,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	/* Previous unmount will stop all queues. Start these again */
 	virtio_fs_start_all_queues(fs);
+	fc->virtio_fs_ch = 1;
 	fuse_send_init(fm);
 	mutex_unlock(&virtio_fs_mutex);
 	return 0;
-- 
2.40.0


