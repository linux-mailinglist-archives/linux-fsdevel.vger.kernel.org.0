Return-Path: <linux-fsdevel+bounces-737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974347CF6DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 13:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82AC9B2124A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E04C199A3;
	Thu, 19 Oct 2023 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YcK6SBDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD819442
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 11:30:59 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435B9119
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 04:30:55 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231019113052epoutp04c94a053f04a65ca3b20612da1dd5f5e7~PfthWTO2-1831718317epoutp04Z
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 11:30:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231019113052epoutp04c94a053f04a65ca3b20612da1dd5f5e7~PfthWTO2-1831718317epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697715052;
	bh=q9SxftoJ28f/aKMttE4F2HKL0g6oV33glPP48Dl+Hr4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=YcK6SBDXRLdx4+/cRm3vueQh8NinWEtZiigkm/wb/uHdMmUVJcHJMBYqtVGtmgc4D
	 5vypqw7pnmKhle2ITRhqGDaI2Cg0JMHhF4t3kWH3VSv99GtLM/8G0nbP4+t0gpuoxo
	 OJO+TOs1+S+Ywc+g4sN+7RdjVILQhhfW48NZuLKE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231019113051epcas5p364449205f2f821b44340b2c92c4ad4a2~Pftgs3N681624016240epcas5p3Z;
	Thu, 19 Oct 2023 11:30:51 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SB5BL2S2Tz4x9Q0; Thu, 19 Oct
	2023 11:30:50 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.9E.08567.A6311356; Thu, 19 Oct 2023 20:30:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231019110811epcas5p4235bfd5359d4269f4abd70bbf581a6a8~PfZubLc-S2077720777epcas5p4X;
	Thu, 19 Oct 2023 11:08:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019110811epsmtrp2ef5badb9e8d53cc3757a4a3629357d13~PfZuaQzWa1571815718epsmtrp2v;
	Thu, 19 Oct 2023 11:08:11 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-5a-6531136a43fb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.07.18939.B1E01356; Thu, 19 Oct 2023 20:08:11 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110808epsmtip1c0c9d353ca00317d26232ec2f7db7e83~PfZrZap0Y2859128591epsmtip1D;
	Thu, 19 Oct 2023 11:08:08 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 00/12] Implement copy offload support
Date: Thu, 19 Oct 2023 16:31:28 +0530
Message-Id: <20231019110147.31672-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVDTdRzH+f5+P34MbPRjo/MrZcI8vAMP2GyML54IFeXvwisuO4s6g7X9
	eBzbbg9R3nVAc+kwHgyUGCIbEvJ00tB4DKRxNIWQQkAhCS1IEpEES86hxBiY/70+D+/v5+F7
	HxbOWSJ9WClyDaOSi2U80oNo6g4ICErlChi+vYiNGnp/xNG9f+wEqhvPJ9FM9zxAk12HATJV
	lBFotKsVQzV1PRj6yjoC0NSwEUMdY9uR+YtKAn3fcYlAV9pOkqi8asoNHb3aQqIztscYulYw
	BVDLZDZATfZyHJ2dmSPQxbHn0cAjm2vURrrVOO5GD/xmIegr/Vq6sdZA0ucqM+npcyWAbh/N
	IunTeYWudK7uLknfmxoj6LnOYZLOO18L6IXGF+nGyVks1vP9tF3JjFjKqHwZuUQhTZEnRfBi
	9sW/Gh8q4guCBOEojOcrF6czEbzovbFBr6fIVubn+X4slmlXXLFitZoXsnuXSqHVML7JCrUm
	gscopTKlUBmsFqertfKkYDmj2Sng83eEriQmpCUPdffjSkPcJ8XdFa5ZoOLlHODOgpQQ/ln1
	kMwBHiwO1Q5gcedNzGnMA2jJ+YN8YszX/wTWJeW5J9ycgVYAv62eIx0BDqXHoL3t2RzAYpHU
	dti3zHLkeFN6HF64fgc4DJwaxWD/hSbMIeBS4VBn6l9lgvKHy0MFuEPMpnbCpr/9HAipEJg/
	4eXIYFNe8FLJJOFgnNoCdd+V4o4nIVXoDh9etq81Fw3NJyxrzIW3befdnOwDF+52kE7OgDVF
	1aRTfAhA41XjmiAS6nvzV3vAqQDY0BbidG+Gx3vPYs7CnjDXPok5/WzYcmqdt8L6BtPa+5vg
	yIPsNabhwMQs5tzPAWhdtBAFYIvxqXmMT81j/L+yCeC1YBOjVKcnMZJQpUDOZDz5WIkivRGs
	nkFgdAu4Vv442AowFrACyMJ53mx/ms9w2FLxpwcZlSJepZUxaisIXVnxMdznOYli5Y7kmniB
	MJwvFIlEwvCXRALeRvaMvkzKoZLEGiaNYZSMal2Hsdx9sjAYd+ZI3/XZzBi3cr+gkm/CdDWJ
	vgcjpounyWeqm/MMHl1990urb1cMujT+wPAmrOOVw2aW9NZ+0Zfyy5HvLpVio7y3FoXRhZmx
	s9n6DR2aqCPbbGOW4Fu7E22HRlJ1swN7bnzkGvNzLQr7bPMdP/OU2HV/oslTcZraMHZDPTjd
	Y0ngfnC0I97QnPdoScYP1Q0ael2q5hSLEQGRiw9uen8eteDKDZuY+Lo/cO+pIeZYSH2P1fO9
	47lpqr9+OfrrNq+8399IfbPsne7UMBezWLeQgce9YnpBItVSdVk9nQlbl12K2g8b70sI27i2
	VbTvwMV/E2O5OzgG854PpR5vv6Y/6d/MI9TJYkEgrlKL/wOsD1ucjwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re1BMYRjGfeecPZ12LKdt1acMY7Ma0s00fJG7GR9jXJIhpqmlM0W1rT3l
	0phpzaIp0mJGtVJJk6mGWEl3KUqlYrLRjpKpJUoXd1Yyx2X473l/z+/562VIaRnlxOxRxXAa
	lTJSToupkjr5dHfnSd6cl86qQEVN9SQa/WilUGFXCo0G6t4B1FeTAFB2zgUKddaUESi/8B6B
	ztR2AGQxGQhUZXZDF4/nUqiyqpFC7eUZNMrKs9igE09KaXS54QeBnuotAJX2HQGoxJpFoqsD
	wxS6b3ZGbWMNouWOuMzQZYPbuq9TuL0lFhsLEml8Izce999IB7iiU0vjS6fOinCybojGoxYz
	hYerTTQ+VVwA8HvjdGzse0tsmrRD7BfKRe7Zz2k8l4aIwx/XtZDqxMCDqXU5Ii3IWZEEbBnI
	+sCs5HM2SUDMSNlbAJYkVVK/i6kwb+wu+Tvbw/wfr/5IOgJW1FvpJMAwNOsGm8cZgcvYFBIO
	jaUSwkGyFgKOfv0EhLU96wt12S2EkClWAccf60lhLGEXwZKRmUKErCdMeW4nGBLWDjam91EC
	JllXWJQpFTDJzoC6m+dJPZhs+M8y/LMM/1nZgCwAUzg1HxUWtVvt7cEro/hYVZjH7ugoI/j1
	3bn+pSCvaMyjFhAMqAWQIeUyiQJ7cVJJqPJQHKeJDtbERnJ8LXBmKLmjxCUyMVTKhiljuAiO
	U3Oavy3B2DppCUJv+hbovEjb6q0xf/m+5TDt27BO8WCKp5edz37Dtw8d6rRBnMinzZj1fsLr
	hTm9AXa3qaDFPu10MumgstfG63u4wSVraXNM+YUMd+w5MqIyuwz1m5sGXHYYLflvApxC1les
	lN7s6S97mCDOnB0rHSlO6zZNPLD6c1xm8CXXeYqIpREvWC7P7VZa/5rCj8HVq+ZET5NfG963
	pMD6bOY1kXp4a+vx076d65Yt9g8b6PKV7VK4ZzjhhUddZSeb6l+49ionzF/QKOuxvpzKXyla
	+1Yxa5tfwLhJHKy/0xTk/2iLSLyT37zs3a6NjdNyN6+I2DDZfVVzceA9h5q27YcTjr0275VT
	fLjSey6p4ZU/AZZNi69MAwAA
X-CMS-MailID: 20231019110811epcas5p4235bfd5359d4269f4abd70bbf581a6a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110811epcas5p4235bfd5359d4269f4abd70bbf581a6a8
References: <CGME20231019110811epcas5p4235bfd5359d4269f4abd70bbf581a6a8@epcas5p4.samsung.com>

Hi Jens, Martin, Christoph,
We have addressed most of the review-comments received from community in
the previous iterations of this series.
Is it possible to know your opinion on this, what needs to be added to
get this series merged?

The patch series covers the points discussed in past and most recently
in LSFMM'23[0].
We have covered the initial agreed requirements in this patch set and
further additional features suggested by community.

This is next iteration of our previous patch set v16[1].
Copy offload is performed using two bio's -
1. Take a plug
2. The first bio containing source info is prepared and sent,
        a request is formed.
3. This is followed by preparing and sending the second bio containing the
        destination info.
4. This bio is merged with the request containing the source info.
5. The plug is released, and the request containing source and destination
        bio's is sent to the driver.
This design helps to avoid putting payload (token) in the request,
as sending payload that is not data to the device is considered a bad
approach.

So copy offload works only for request based storage drivers.
We can make use of copy emulation in case copy offload capability is
absent.

Overall series supports:
========================
	1. Driver
		- NVMe Copy command (single NS, TP 4065), including support
		in nvme-target (for block and file back end).

	2. Block layer
		- Block-generic copy (REQ_OP_COPY_DST/SRC), operation with
                  interface accommodating two block-devs
                - Merging copy requests in request layer
		- Emulation, for in-kernel user when offload is natively
                absent
		- dm-linear support (for cases not requiring split)

	3. User-interface
		- copy_file_range

Testing
=======
	Copy offload can be tested on:
	a. QEMU: NVME simple copy (TP 4065). By setting nvme-ns
		parameters mssrl,mcl, msrc. For more info [2].
	b. Null block device
        c. NVMe Fabrics loopback.
	d. blktests[3]

	Emulation can be tested on any device.

	fio[4].

Infra and plumbing:
===================
        We populate copy_file_range callback in def_blk_fops. 
        For devices that support copy-offload, use blkdev_copy_offload to
        achieve in-device copy.
        However for cases, where device doesn't support offload,
        use generic_copy_file_range.
        For in-kernel users (like NVMe fabrics), use blkdev_copy_offload
        if device is copy offload capable or else use emulation 
        using blkdev_copy_emulation.
        Modify checks in generic_copy_file_range to support block-device.

Blktests[3]
======================
	tests/block/035-040: Runs copy offload and emulation on null
                              block device.
	tests/block/050,055: Runs copy offload and emulation on test
                              nvme block device.
        tests/nvme/056-067: Create a loop backed fabrics device and
                              run copy offload and emulation.

Future Work
===========
	- loopback device copy offload support
	- upstream fio to use copy offload
	- upstream blktest to test copy offload
        - update man pages for copy_file_range
        - expand in-kernel users of copy offload

	These are to be taken up after this minimal series is agreed upon.

Additional links:
=================
	[0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=zT14mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
            https://lore.kernel.org/linux-nvme/f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com/
            https://lore.kernel.org/linux-nvme/20230113094648.15614-1-nj.shetty@samsung.com/
	[1] https://lore.kernel.org/all/20230920080756.11919-1-nj.shetty@samsung.com/T/#t
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v15
	[4] https://github.com/OpenMPDK/fio/tree/copyoffload-3.35-v14

Changes since v16:
=================
        - block: fixed memory leaks and renamed function (Jinyoung Choi)
        - nvmet: static error fixes (kernel test robot) 

Changes since v15:
=================
        - fs, nvmet: don't fallback to copy emulation for copy offload IO
                    failure, user can still use emulation by disabling
                    device offload (Hannes)
        - block: patch,function description changes (Hannes)
        - added Reviewed-by from Hannes and Luis.

Changes since v14:
=================
        - block: (Bart Van Assche)
            1. BLK_ prefix addition to COPY_MAX_BYES and COPY_MAX_SEGMENTS
            2. Improved function,patch,cover-letter description
            3. Simplified refcount updating.
        - null-blk, nvme:
            4. static warning fixes (kernel test robot)

Changes since v13:
=================
        - block:
            1. Simplified copy offload and emulation helpers, now
                  caller needs to decide between offload/emulation fallback
            2. src,dst bio order change (Christoph Hellwig)
            3. refcount changes similar to dio (Christoph Hellwig)
            4. Single outstanding IO for copy emulation (Christoph Hellwig)
            5. use copy_max_sectors to identify copy offload
                  capability and other reviews (Damien, Christoph)
            6. Return status in endio handler (Christoph Hellwig)
        - nvme-fabrics: fallback to emulation in case of partial
          offload completion
        - in kernel user addition (Ming lei)
        - indentation, documentation, minor fixes, misc changes (Damien,
          Christoph)
        - blktests changes to test kernel changes

Changes since v12:
=================
        - block,nvme: Replaced token based approach with request based
          single namespace capable approach (Christoph Hellwig)

Changes since v11:
=================
        - Documentation: Improved documentation (Damien Le Moal)
        - block,nvme: ssize_t return values (Darrick J. Wong)
        - block: token is allocated to SECTOR_SIZE (Matthew Wilcox)
        - block: mem leak fix (Maurizio Lombardi)

Changes since v10:
=================
        - NVMeOF: optimization in NVMe fabrics (Chaitanya Kulkarni)
        - NVMeOF: sparse warnings (kernel test robot)

Changes since v9:
=================
        - null_blk, improved documentation, minor fixes(Chaitanya Kulkarni)
        - fio, expanded testing and minor fixes (Vincent Fu)

Changes since v8:
=================
        - null_blk, copy_max_bytes_hw is made config fs parameter
          (Damien Le Moal)
        - Negative error handling in copy_file_range (Christian Brauner)
        - minor fixes, better documentation (Damien Le Moal)
        - fio upgraded to 3.34 (Vincent Fu)

Changes since v7:
=================
        - null block copy offload support for testing (Damien Le Moal)
        - adding direct flag check for copy offload to block device,
	  as we are using generic_copy_file_range for cached cases.
        - Minor fixes

Changes since v6:
=================
        - copy_file_range instead of ioctl for direct block device
        - Remove support for multi range (vectored) copy
        - Remove ioctl interface for copy.
        - Remove offload support in dm kcopyd.

Changes since v5:
=================
	- Addition of blktests (Chaitanya Kulkarni)
        - Minor fix for fabrics file backed path
        - Remove buggy zonefs copy file range implementation.

Changes since v4:
=================
	- make the offload and emulation design asynchronous (Hannes
	  Reinecke)
	- fabrics loopback support
	- sysfs naming improvements (Damien Le Moal)
	- use kfree() instead of kvfree() in cio_await_completion
	  (Damien Le Moal)
	- use ranges instead of rlist to represent range_entry (Damien
	  Le Moal)
	- change argument ordering in blk_copy_offload suggested (Damien
	  Le Moal)
	- removed multiple copy limit and merged into only one limit
	  (Damien Le Moal)
	- wrap overly long lines (Damien Le Moal)
	- other naming improvements and cleanups (Damien Le Moal)
	- correctly format the code example in description (Damien Le
	  Moal)
	- mark blk_copy_offload as static (kernel test robot)
	
Changes since v3:
=================
	- added copy_file_range support for zonefs
	- added documentation about new sysfs entries
	- incorporated review comments on v3
	- minor fixes

Changes since v2:
=================
	- fixed possible race condition reported by Damien Le Moal
	- new sysfs controls as suggested by Damien Le Moal
	- fixed possible memory leak reported by Dan Carpenter, lkp
	- minor fixes

Changes since v1:
=================
	- sysfs documentation (Greg KH)
        - 2 bios for copy operation (Bart Van Assche, Mikulas Patocka,
          Martin K. Petersen, Douglas Gilbert)
        - better payload design (Darrick J. Wong)
Anuj Gupta (1):
  fs/read_write: Enable copy_file_range for block device.

Nitesh Shetty (11):
  block: Introduce queue limits and sysfs for copy-offload support
  Add infrastructure for copy offload in block and request layer.
  block: add copy offload support
  block: add emulation for copy
  fs, block: copy_file_range for def_blk_ops for direct block device
  nvme: add copy offload support
  nvmet: add copy command support for bdev and file ns
  dm: Add support for copy offload
  dm: Enable copy offload for dm-linear target
  null: Enable trace capability for null block
  null_blk: add support for copy offload

 Documentation/ABI/stable/sysfs-block |  23 ++
 Documentation/block/null_blk.rst     |   5 +
 block/blk-core.c                     |   7 +
 block/blk-lib.c                      | 427 +++++++++++++++++++++++++++
 block/blk-merge.c                    |  41 +++
 block/blk-settings.c                 |  24 ++
 block/blk-sysfs.c                    |  36 +++
 block/blk.h                          |  16 +
 block/elevator.h                     |   1 +
 block/fops.c                         |  25 ++
 drivers/block/null_blk/Makefile      |   2 -
 drivers/block/null_blk/main.c        | 100 ++++++-
 drivers/block/null_blk/null_blk.h    |   1 +
 drivers/block/null_blk/trace.h       |  25 ++
 drivers/block/null_blk/zoned.c       |   1 -
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  37 +++
 drivers/md/dm.c                      |   7 +
 drivers/nvme/host/constants.c        |   1 +
 drivers/nvme/host/core.c             |  79 +++++
 drivers/nvme/host/trace.c            |  19 ++
 drivers/nvme/target/admin-cmd.c      |   9 +-
 drivers/nvme/target/io-cmd-bdev.c    |  71 +++++
 drivers/nvme/target/io-cmd-file.c    |  50 ++++
 drivers/nvme/target/nvmet.h          |   1 +
 drivers/nvme/target/trace.c          |  19 ++
 fs/read_write.c                      |   8 +-
 include/linux/bio.h                  |   6 +-
 include/linux/blk_types.h            |  10 +
 include/linux/blkdev.h               |  22 ++
 include/linux/device-mapper.h        |   3 +
 include/linux/nvme.h                 |  43 ++-
 32 files changed, 1101 insertions(+), 19 deletions(-)


base-commit: 213f891525c222e8ed145ce1ce7ae1f47921cb9c
-- 
2.35.1.500.gb896f729e2


