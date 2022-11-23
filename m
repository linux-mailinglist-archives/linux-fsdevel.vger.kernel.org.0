Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEEB63502C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 07:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiKWGO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 01:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiKWGOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:14:07 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBD3EA11C
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 22:13:53 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221123061352epoutp04480d0f079b199fafeae17d97965f33b3~qIgiWKOWd2398123981epoutp04X
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 06:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221123061352epoutp04480d0f079b199fafeae17d97965f33b3~qIgiWKOWd2398123981epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669184032;
        bh=7nuYnpvMw7veh3TNnapyVxUSrFiOjNfa2fJfOcnjtew=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IMrT2LnGTW6XV4z8O7DqYif2XI16EjdIezRysPZ9Ok0gUJuGc85jG5365M87lg70I
         dA1yC/fuNzU2KlGIpRt3qr0nT+yg3ZRHza3bsaUAM+9NS5pcSOfcII5XXNtGuwNfLT
         HQZBN0natO502JKQZ6UU9Mke7fVlK8lVCCaI3jdM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221123061350epcas5p471359445e51afd8cd2387ddbf6faa737~qIggyQ-f61580315803epcas5p4-;
        Wed, 23 Nov 2022 06:13:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NH9mq4fGdz4x9QH; Wed, 23 Nov
        2022 06:13:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.37.56352.B1ABD736; Wed, 23 Nov 2022 15:13:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221123061010epcas5p21cef9d23e4362b01f2b19d1117e1cdf5~qIdUMOmSP0377003770epcas5p2k;
        Wed, 23 Nov 2022 06:10:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221123061010epsmtrp240c1b1d323a61346f7e8928f9190ee34~qIdULATEz0451404514epsmtrp2a;
        Wed, 23 Nov 2022 06:10:10 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-35-637dba1bece3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.FA.14392.249BD736; Wed, 23 Nov 2022 15:10:10 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221123061007epsmtip1e493ba5af1c6e49ea490269a2dcb0bab~qIdRPeIeF1429014290epsmtip1d;
        Wed, 23 Nov 2022 06:10:07 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v5 00/10] Implement copy offload support
Date:   Wed, 23 Nov 2022 11:28:17 +0530
Message-Id: <20221123055827.26996-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1CTdRi/7/tu7wYJvQLJV7iAm2ch3mCLMb94UnaRvaQV1gXi1dEab4Ng
        P9y7iZodKFKKyY8MsmFAAbs2aOAkmFsrDg4IhPAiMEgiA0z5KeIZhosGL5T/fZ7P83k+z/N8
        v/fwcR8XEcBPU+lorUqWISA8OY2tW0KFgfb35aLipmBU19WOo+OFLhzVDBcQaLGnF0fOmVIu
        Gmy+hCFTTRuGHF/MYahtaZpA1+8OcdDHLQMAjfcbMOQc2oq+dXZyUJ/9PIHKjeM8VNRxkYts
        Y8cAalwsx9F89QkeskzOctAPQ4Go19XB3elPGUZ6COqSYZhH9f52gUP19egpq/kUQV2syqIc
        g9kEdSZnxi3IHeFSs9/1E1R+gxlQ89Yg6sPm0xhlHZvG4r33p+9IpWUptDaEVsnVKWkqRYxg
        92vJzyVHSUVioTgabROEqGRKOkYQuydeuCstw72/IOSgLEPvpuJlDCOIeHqHVq3X0SGpakYX
        I6A1KRkaiSackSkZvUoRrqJ128Ui0VNRbuFb6am35iwczVnpIaO9l8gGN0PzgAcfkhI46yoh
        8oAn34d0ADhcbMLZ4A6A90bPcdngHoDVp7u4ayXmG3mrCSeAldndgA1yMbhQ1YblAT6fILfC
        y0v8Zd6PzMfgSUfzii9OlmJw2viAtyzyJRGsdSmXXTnkZth+YwksYy9yOzz1QR++LIFkBCwY
        Wc/S62HnZ2OcZYyTwTDnm9IVS0h+6gHNJcOr08XCKVMrh8W+cKKjgcfiADg/4yRYnAlNn3xF
        sMUnADRcNQA28QzM7SpYaYyTW2CdPYKlH4fFXRaMbewNzyyOYSzvBW1la3gTrK2rWPXfCAf+
        OraKKThVO7syjw/5JnSUjBKFINjw0D6Gh/Yx/N+5AuBmsJHWMEoFzURpIlV05n8/K1crrWDl
        DsJ228Afv98ObwEYH7QAyMcFfl5ZcUflPl4pssNHaK06WavPoJkWEOV+4yI84DG52n1IKl2y
        WBItkkilUkl0pFQs8PeqPBcm9yEVMh2dTtMaWrtWh/E9ArKxV4V7F9qVl1/389cnRUuS4vL3
        JpQ3/bghWvHskUbbe4og735rgmHf17ZYv52HTK+8KDXNz8qEo/G/aPh3qn+1dTTkJ2wmg3vM
        I/cnB8hr82XJuQk9alhqvh3wZH3mleKy/ePMwsGr3LP1jC1tQsQTHy4M4ybl5j9Sv8/PFf95
        5d+1B7r7Q6cs9v63/7GYEm/665pqWjrStOeFExeemPy+veJPT+Pg8Qksbh3HaXmesJbl3L/1
        Uh0avtJZHiQ5WlT/qPnlqsR3D3gGVl0z/9Q+lLhnk71V+ELkR0xXUzHte5LSlV/fcDcrMizI
        +M62n3uV3caKdeYlpWOwaGju1BsPlr5scwk4TKpMHIZrGdm/XLQGHpAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RbUhTYRiGec97dnZcrU4z6NW+aFiWpmZWvFSUSD9OP6KMKMlqjXXSaF9s
        miVl2mzhpMyEoGlpoUunGU1nuWmIqVPDrLREw+zD+TFRGwVac1lLov7d93VfPH8eGorqyUD6
        lDKJ0yilcjElIGueiVeExdRekG1wOEPww/YWiC9d90Jc3p9DYU9HJ8T1E/k83NtQS+Cy8mYC
        2++6Cdw8O07hj9/6SHyj8S3AzjdGAtf3heK6+jYSd9kKKFxocvJxrqOKh58MZgBc4ymE+GtJ
        Jh9Xjk2SuLVvKe70OnjRS1jjQAfF1hr7+Wzn+0ck29WRzFrMWRRbVXyRtfemU+xV3cRv4fIA
        j518+oZir1WbAfvVsoK90pBNsJbBcWLfgsOC7Sc4+akznCZix3FB4qi7klTnbTlrsnVS6WBk
        rQH40YjZhMxDBp4BCGgRYwfIav9Mzg0ByORtgnPZH5X9HObPSToCeRzTwABommJC0fNZ2scX
        M0UE6nrvgr4CmRIC5Xf3Uz7Jn8GowqvwHSKZ1ahlaBb4spDZirL0XdCnICYC5QwsmsOLUNut
        QdKHIROMHt4R+TBkViKdNR9eBwuN/1nGf5bxP6sIQDMI4NRaRYJCG6mOVHIp4VqpQpusTAiX
        qRQW8OfDIeuegMfmL+GNgKBBI0A0FC8WXtx9XiYSnpCeS+U0KokmWc5pG8FSmhQvEb40tElE
        TII0iTvNcWpO83claL/AdGJ5bJrytTUtKapWlCUqfyVxf785n++/rVLc6rbqEgX0SOQtVWnc
        7qrqnqwYuKHF5Z7yHCvIHX6aZ9o+I961wG+/9lO2TebQl6iO6+7Pb2/esnPEIN04kOM6eCgq
        eLCwGIc1pVpwT+l+3iSbuOdzLO1cr1He0JcuBF7VdETsPOu05NLVJJfJaawLSQkSPh//Njam
        H4qD8jPx/PHRjOw7qa7eo9Hd2bagk9FrH+T3lO8dvtequFzmmnmw90DKu7z7o/MCfygagkMj
        RupWTRxZJv9Q0JIZo5fctsQXxwv9PK+Uw3Su+lBuja3ixafuqOo17cVhTec32wOmipoyZbrN
        YlKbKI0MgRqt9BedYdszUAMAAA==
X-CMS-MailID: 20221123061010epcas5p21cef9d23e4362b01f2b19d1117e1cdf5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061010epcas5p21cef9d23e4362b01f2b19d1117e1cdf5
References: <CGME20221123061010epcas5p21cef9d23e4362b01f2b19d1117e1cdf5@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch series covers the points discussed in November 2021 virtual
call [LSF/MM/BFP TOPIC] Storage: Copy Offload [0].
We have covered the initial agreed requirements in this patchset and
further additional features suggested by community.
Patchset borrows Mikulas's token based approach for 2 bdev
implementation.

This is on top of our previous patchset v4[1].

Overall series supports:
========================
	1. Driver
		- NVMe Copy command (single NS, TP 4065), including support
		in nvme-target (for block and file backend).

	2. Block layer
		- Block-generic copy (REQ_COPY flag), with interface
		accommodating two block-devs, and multi-source/destination
		interface
		- Emulation, when offload is natively absent
		- dm-linear support (for cases not requiring split)

	3. User-interface
		- new ioctl
		- copy_file_range for zonefs

	4. In-kernel user
		- dm-kcopyd
		- copy_file_range in zonefs

Testing
=======
	Copy offload can be tested on:
	a. QEMU: NVME simple copy (TP 4065). By setting nvme-ns
		parameters mssrl,mcl, msrc. For more info [2].
	b. Fabrics loopback.
	c. zonefs copy_file_range

	Emuation can be tested on any device.

	Sample application to use IOCTL is present in patch desciption.
	fio[3].

Performance
===========
	With the async design of copy-emulation/offload using fio[3],
	we were  able to see the following improvements as
	compared to userspace read and write on a NVMeOF TCP setup:
	Setup1: Network Speed: 1000Mb/s
		Host PC: Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz
		Target PC: AMD Ryzen 9 5900X 12-Core Processor
		block size 8k, range 1:
			635% improvement in IO BW (107 MiB/s to 787 MiB/s).
			Network utilisation drops from  97% to 14%.
		block-size 2M, range 16:
			2555% improvement in IO BW (100 MiB/s to 2655 MiB/s).
			Network utilisation drops from 89% to 0.62%.
	Setup2: Network Speed: 100Gb/s
		Server: Intel(R) Xeon(R) Gold 6240 CPU @ 2.60GHz, 72 cores
			(host and target have the same configuration)
		block-size 8k, range 1:
			6.5% improvement in IO BW (791 MiB/s to 843 MiB/s).
			Network utilisation drops from  6.75% to 0.14%.
		block-size 2M, range 16:
			15% improvement in IO BW (1027 MiB/s to 1183 MiB/s).
			Network utilisation drops from 8.42% to ~0%.
		block-size 8k, 8 ranges:
			18% drop in IO BW (from 798 MiB/s to 647 MiB/s)
			Network utilisation drops from 6.66% to 0.13%.

		At present we see drop in performance for bs 8k,16k and
		higher ranges (8, 16), so something more to check there.
	Overall, in these tests, kernel copy emulation performs better than
	userspace read+write. 

Zonefs copy_file_range
======================
	Sample tests for zonefs-tools[4]. Test 0118 and 0119 will test
	basic CFR. Will raise a PR, once this series is finalized.

Future Work
===========
	- nullblk: copy-offload emulation
	- generic copy file range (CFR):
		I did go through this, but couldn't find straight forward
		way to plug in copy offload for all the cases. We are doing
		detailed study, will address this future versions.
	- loopback device copy offload support
	- upstream fio to use copy offload

	These are to be taken up after we reach consensus on the
	plumbing of current elements that are part of this series.


Additional links:
=================
	[0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=zT14mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
	[1] https://lore.kernel.org/lkml/20220426101241.30100-1-nj.shetty@samsung.com/
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/vincentkfu/fio/tree/copyoffload
	[4] https://github.com/nitesh-shetty/zonefs-tools/tree/cfr

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

Nitesh Shetty (10):
  block: Introduce queue limits for copy-offload support
  block: Add copy offload support infrastructure
  block: add emulation for copy
  block: Introduce a new ioctl for copy
  nvme: add copy offload support
  nvmet: add copy command support for bdev and file ns
  dm: Add support for copy offload.
  dm: Enable copy offload for dm-linear target
  dm kcopyd: use copy offload support
  fs: add support for copy file range in zonefs

 Documentation/ABI/stable/sysfs-block |  36 ++
 block/blk-lib.c                      | 597 +++++++++++++++++++++++++++
 block/blk-map.c                      |   4 +-
 block/blk-settings.c                 |  24 ++
 block/blk-sysfs.c                    |  64 +++
 block/blk.h                          |   2 +
 block/ioctl.c                        |  36 ++
 drivers/md/dm-kcopyd.c               |  56 ++-
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  42 ++
 drivers/md/dm.c                      |   7 +
 drivers/nvme/host/core.c             | 106 ++++-
 drivers/nvme/host/fc.c               |   5 +
 drivers/nvme/host/nvme.h             |   7 +
 drivers/nvme/host/pci.c              |  28 +-
 drivers/nvme/host/rdma.c             |   7 +
 drivers/nvme/host/tcp.c              |  16 +
 drivers/nvme/host/trace.c            |  19 +
 drivers/nvme/target/admin-cmd.c      |   9 +-
 drivers/nvme/target/io-cmd-bdev.c    |  79 ++++
 drivers/nvme/target/io-cmd-file.c    |  51 +++
 drivers/nvme/target/loop.c           |   6 +
 drivers/nvme/target/nvmet.h          |   2 +
 fs/zonefs/super.c                    | 179 ++++++++
 include/linux/blk_types.h            |  44 ++
 include/linux/blkdev.h               |  18 +
 include/linux/device-mapper.h        |   5 +
 include/linux/nvme.h                 |  43 +-
 include/uapi/linux/fs.h              |  27 ++
 29 files changed, 1502 insertions(+), 18 deletions(-)


base-commit: e4cd8d3ff7f9efeb97330e5e9b99eeb2a68f5cf9
-- 
2.35.1.500.gb896f729e2

