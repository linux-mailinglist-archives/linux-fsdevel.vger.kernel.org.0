Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF571239B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLQWRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:17:35 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:37457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfLQWRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:35 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MybCV-1hkpcF1SpR-00yzON; Tue, 17 Dec 2019 23:17:22 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL v2 00/27] block, scsi: final compat_ioctl cleanup
Date:   Tue, 17 Dec 2019 23:16:41 +0100
Message-Id: <20191217221708.3730997-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VlWKwOFf1KSwLXjO2pB7j6+pEUqyZrcFF3CAeJCBtjviS76xwR1
 wd7NvB/QDEzDk3wOFDgjK9AaCaYK3rS5F5lzDetJrGk0oWgnwxRJSRZP7JW9BTf04/IvN8s
 JZkW025kIad1Db9MSLIBCX3lhAghhqk2JrE1ryGymA/zcEJa09p05sYnmshL9cAbYwivdqF
 Eq24NkaEs45DzcyGNlSQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:udjpz5XslWU=:ltLEnKRlUvnpXDC/A28PIt
 h8lW2R0cB4ADrBP/9FGCaMz5UpCiBqa2d/1S+RImKPp6WMTIFYs9Owp41G3d5N3plf2Gvuyz4
 YkPJLeDFJyHRu6NdD19VDcFNqbBaeFivJ7o0P+fO0w0JU7sP3BIXBqrAEcOSP21hk6RJP7ggz
 1w/3KkZkw2df34oa7Dk8cqMOjrKoUVPTY5ifNEYBXxgjlg9oArEPW3WF9eBB/c07rtEI1wKo/
 OTnlu+q2f3KlRPhLu1VYyWji0IvaN6ttc5EAbVaLyZvCejgQIhlOemejUfX0s/n6GFRxRUzdI
 pKqlfrBopZw7TUcXAW42Un+93Bu66drpuLnPQndPatiU1ouKOzir6SuEAPl9ayEM5WBBnFzyx
 ei846/KAJY0Mt6VrNM9X9szlRxY9+8ttewRFllwidJK27iXiiHX1dtuaG6qr8AMd/rWf3jzmA
 swcAKs16F+EVUnjgIeK5+5ECSCzGrt4bXse9Qd7Eq0XM2Jxar4jv8AQneEpzXDnH8WXQwhPyl
 amWtDucl/i8VpOehhA88P7nOYz795nOMz4OFKM+L8hEBlqljiipDz6hL/pmVLjgcnubuG95JK
 zpAQblBXlvuTgMmN+XRTAOkUPA28wnh+6ebmaryjNXNhUueO0ShQCgjMP55ON7No1ahzRsTx1
 eFbqe9zmFWhDvlg4qneFAr+LvbHksW4cHvUoFX7xFpUwwES9R9LOfykcsrQuzUg1xrCM74l/2
 InwnshJDi79gmjO9UiwCCd2L0VNDMt+jhWXut0eW3cgdCBdyPaiIejWrEvaQ3zxTTiBo2vwGE
 E7IJEanH5s/jFwz2Gmhp/kj8ONjryJw5WKtMba13NwYXpZhurN4VwJ1wV3R5VwSxTLkyLJX9V
 ZxwiCsbPEnsF+zu9sVlw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git tags/block-ioctl-cleanup-5.6

for you to fetch changes up to 3462d5c19dac7c062c5a2db727775116e6d2b28e:

  Documentation: document ioctl interfaces better (2019-12-17 22:45:18 +0100)

----------------------------------------------------------------
block, scsi: final compat_ioctl cleanup

This series concludes the work I did for linux-5.5 on the compat_ioctl()
cleanup, killing off fs/compat_ioctl.c and block/compat_ioctl.c by moving
everything into drivers.

Overall this would be a reduction both in complexity and line count, but
as I'm also adding documentation the overall number of lines increases
in the end.

My plan was originally to keep the SCSI and block parts separate.
This did not work easily because of interdependencies: I cannot
do the final SCSI cleanup in a good way without first addressing the
CDROM ioctls, so this is one series that I hope could be merged through
either the block or the scsi git trees, or possibly both if you can
pull in the same branch.

The series comes in these steps:

1. clean up the sg v3 interface as suggested by Linus. I have
   talked about this with Doug Gilbert as well, and he would
   rebase his sg v4 patches on top of "compat: scsi: sg: fix v3
   compat read/write interface"

2. Actually moving handlers out of block/compat_ioctl.c and
   block/scsi_ioctl.c into drivers, mixed in with cleanup
   patches

3. Document how to do this right. I keep getting asked about this,
   and it helps to point to some documentation file.

The branch is based on another one that fixes a couple of bugs found
during the creation of this series.

Changes since the original version [1]:

- move out the bugfixes into a branch for itself
- clean up scsi sg driver further as suggested by Christoph Hellwig
- avoid some ifdefs by moving compat_ptr() out of asm/compat.h
- split out the blkdev_compat_ptr_ioctl function; bug spotted by
  Ben Hutchings
- Improve formatting of documentation

[1] https://lore.kernel.org/linux-block/20191211204306.1207817-1-arnd@arndb.de/T/#m9f89df30565fc66abbded5d01f4db553b16f129f

----------------------------------------------------------------

Arnd Bergmann (22): (plus five from the first pull request)
  compat: ARM64: always include asm-generic/compat.h
  compat: provide compat_ptr() on all architectures
  compat: scsi: sg: fix v3 compat read/write interface
  compat_ioctl: block: add blkdev_compat_ptr_ioctl
  compat_ioctl: ubd, aoe: use blkdev_compat_ptr_ioctl
  compat_ioctl: move CDROM_SEND_PACKET handling into scsi
  compat_ioctl: move CDROMREADADIO to cdrom.c
  compat_ioctl: cdrom: handle CDROM_LAST_WRITTEN
  compat_ioctl: block: handle cdrom compat ioctl in non-cdrom drivers
  compat_ioctl: add scsi_compat_ioctl
  compat_ioctl: bsg: add handler
  compat_ioctl: ide: floppy: add handler
  compat_ioctl: scsi: move ioctl handling into drivers
  compat_ioctl: move sys_compat_ioctl() to ioctl.c
  compat_ioctl: simplify the implementation
  compat_ioctl: move cdrom commands into cdrom.c
  compat_ioctl: scsi: handle HDIO commands from drivers
  compat_ioctl: move HDIO ioctl handling into drivers/ide
  compat_ioctl: block: move blkdev_compat_ioctl() into ioctl.c
  compat_ioctl: block: simplify compat_blkpg_ioctl()
  compat_ioctl: simplify up block/ioctl.c
  Documentation: document ioctl interfaces better

 Documentation/core-api/index.rst       |   1 +
 Documentation/core-api/ioctl.rst       | 248 +++++++++++++++
 arch/arm64/include/asm/compat.h        |  22 +-
 arch/mips/include/asm/compat.h         |  18 --
 arch/parisc/include/asm/compat.h       |  17 -
 arch/powerpc/include/asm/compat.h      |  17 -
 arch/powerpc/oprofile/backtrace.c      |   2 +-
 arch/s390/include/asm/compat.h         |   6 +-
 arch/sparc/include/asm/compat.h        |  17 -
 arch/um/drivers/ubd_kern.c             |   1 +
 arch/x86/include/asm/compat.h          |  17 -
 block/Makefile                         |   1 -
 block/bsg.c                            |   1 +
 block/compat_ioctl.c                   | 411 -------------------------
 block/ioctl.c                          | 319 +++++++++++++++----
 block/scsi_ioctl.c                     | 214 ++++++++-----
 drivers/ata/libata-scsi.c              |   9 +
 drivers/block/aoe/aoeblk.c             |   1 +
 drivers/block/floppy.c                 |   3 +
 drivers/block/paride/pcd.c             |   3 +
 drivers/block/paride/pd.c              |   1 +
 drivers/block/paride/pf.c              |   1 +
 drivers/block/pktcdvd.c                |  26 +-
 drivers/block/sunvdc.c                 |   1 +
 drivers/block/virtio_blk.c             |   3 +
 drivers/block/xen-blkfront.c           |   1 +
 drivers/cdrom/cdrom.c                  |  35 ++-
 drivers/cdrom/gdrom.c                  |   3 +
 drivers/ide/ide-cd.c                   |  37 +++
 drivers/ide/ide-disk.c                 |   1 +
 drivers/ide/ide-floppy.c               |   4 +
 drivers/ide/ide-floppy.h               |   2 +
 drivers/ide/ide-floppy_ioctl.c         |  35 +++
 drivers/ide/ide-gd.c                   |  14 +
 drivers/ide/ide-ioctls.c               |  44 ++-
 drivers/ide/ide-tape.c                 |  11 +
 drivers/scsi/aic94xx/aic94xx_init.c    |   3 +
 drivers/scsi/ch.c                      |   9 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   3 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   3 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   3 +
 drivers/scsi/ipr.c                     |   3 +
 drivers/scsi/isci/init.c               |   3 +
 drivers/scsi/mvsas/mv_init.c           |   3 +
 drivers/scsi/pm8001/pm8001_init.c      |   3 +
 drivers/scsi/scsi_ioctl.c              |  54 +++-
 drivers/scsi/sd.c                      |  50 ++-
 drivers/scsi/sg.c                      | 170 +++++-----
 drivers/scsi/sr.c                      |  53 +++-
 drivers/scsi/st.c                      |  51 +--
 fs/Makefile                            |   2 +-
 fs/compat_ioctl.c                      | 261 ----------------
 fs/internal.h                          |   6 -
 fs/ioctl.c                             | 131 +++++---
 include/linux/blkdev.h                 |   7 +
 include/linux/compat.h                 |  18 ++
 include/linux/falloc.h                 |   2 -
 include/linux/fs.h                     |   4 -
 include/linux/ide.h                    |   2 +
 include/linux/libata.h                 |   6 +
 include/scsi/scsi_ioctl.h              |   1 +
 include/scsi/sg.h                      |  30 ++
 62 files changed, 1257 insertions(+), 1171 deletions(-)
 create mode 100644 Documentation/core-api/ioctl.rst
 delete mode 100644 block/compat_ioctl.c
 delete mode 100644 fs/compat_ioctl.c

-- 
2.20.0

