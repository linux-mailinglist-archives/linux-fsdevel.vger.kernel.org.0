Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226A110B03C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfK0Nej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 08:34:39 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:56979 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0Nej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:34:39 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MsJXG-1hgTC52xKM-00tnZ9; Wed, 27 Nov 2019 14:34:36 +0100
Received: by mail-qt1-f169.google.com with SMTP id w47so21224632qtk.4;
        Wed, 27 Nov 2019 05:34:35 -0800 (PST)
X-Gm-Message-State: APjAAAWQOiHQ3V1ODdv/MTewcLMt7enMUK+kNbVT4PDPgLS0UdSqxyJL
        v+rPFTSalT9h+YONZsQ1UC4F/uB9U2oN/pChh0U=
X-Google-Smtp-Source: APXvYqwXfgB9A3NHUhugMFzVb1L3NF0w6yl8MWl5AdQwMYAsApmqxIiuPZSWuCIRZrRx8Mam8ZKXY+H6izUi4YBxTfM=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr876524qte.204.1574861674482;
 Wed, 27 Nov 2019 05:34:34 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Nov 2019 14:34:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0vt7sBs=mG-m698yQSkoJezb=AgKNCZYCo=+OuxEzLzg@mail.gmail.com>
Message-ID: <CAK8P3a0vt7sBs=mG-m698yQSkoJezb=AgKNCZYCo=+OuxEzLzg@mail.gmail.com>
Subject: [GIT PULL] compat_ioctl: remove most of fs/compat_ioctl.c
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9FldJbuxso6feXt8bKXz0LOO14UdkArdLX/jS7GMHbVS66B3vFh
 ZSiRnpPKfDsHQAwqRSkhmNpp5G0YWeDBhsL+17wXQ4a22uWKtMKrwiM7tZsCnPec2++SYbe
 RPpZJb1sid4ftwl/VqS3VdIAzV8Fl5G/wcRXB0okQCJRAwKqgM5oUj1HfiwvzSZAk7SS06u
 U5gkTCbRl52oywRF4cNNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2sHMEr/dN1Y=:DwGsS+RnoPlprJhsq6JcOR
 fmPaL2WiG2y803FdRtSG71cw/UAVcORhgAT9XTaBv3i1Op9y18GGIdoCdsMu67Mdf+AKZWYxP
 pPtFiliIo6AvW9GxVRtUCJsx9Mw0uqI89RdGS35/9ygQVX/ITRVk9OgCltw9t1eHHJvRpiItZ
 1YGceNUjFGtc5JxGxYNdcMJNBeWcj1lI+s44WYU0jCv1m7Feb8ABGQ4f0lk/cQiFni1XI75iU
 a1hsqtCCE22+rvI1bk6KBak+/gzFwNMHFpeCH+sgNJyEONsPDDAl7gvid8Wil4UeHsBjOelkx
 UC/atCypc51bdyxE85bOSgutSKeYTcTPPA40WzQCG8/3bhS0SCpTE0pVrLmbld4pyNknHBh+e
 l05liJ2tyjI/3r+gXz2kZlxKTJEBkpyhqJmeh5v2mKpS9fnEIgEHuXgmlMY8HEDgsfhiPj8RG
 sYTwROrS3ozWIHsp9hwIeAv6jQ0jHL5Wo/mx9/CZLW59D76lS7NhtSRjZD46ivQnSbyMxKn9t
 dhSnCZlUbk5oAIPr8SOQ0RLoH+pE2vYkLQVj8CeYLVcDia9KgA8NCkdBjcP3axXZ3dFPgK2ji
 coMVVbjE84/L2vB5k4KD9GKcV3NUGr/Xa9z9nNI8HMJHrySA9yEgcQ8cYNc0nlS9IxYnUzHMr
 936Vl22QXDF04Ha3jL14pdOfFDMC/KzApAuMG+VqJ/tGeIuLf0M2iD2pt8nq/y2WimRTYVKMd
 hGzgpMWpHKyXwzmBQT323/+hkX1zKHNJwmwU38V+NfpKPkNA0jZiEI8w2nN/mmoEKBcn9NNOL
 DEhvdTKYGereMxQMf0vTPrcJF3BG5NCQTPr4+F2VDvjdlsTvDP9h3TEeYPSXTRoKF1OWIk5uf
 jI9gdjxt3u9gsO4Ke/cA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/compat-ioctl-5.5

for you to fetch changes up to 142b2ac82e31c174936c5719fa12ae28f51a55b7:

  scsi: sd: enable compat ioctls for sed-opal (2019-10-23 17:23:47 +0200)

----------------------------------------------------------------
compat_ioctl: remove most of fs/compat_ioctl.c

As part of the cleanup of some remaining y2038 issues, I came to
fs/compat_ioctl.c, which still has a couple of commands that need support
for time64_t.

In completely unrelated work, I spent time on cleaning up parts of this
file in the past, moving things out into drivers instead.

After Al Viro reviewed an earlier version of this series and did a lot
more of that cleanup, I decided to try to completely eliminate the rest
of it and move it all into drivers.

This series incorporates some of Al's work and many patches of my own,
but in the end stops short of actually removing the last part, which is
the scsi ioctl handlers. I have patches for those as well, but they need
more testing or possibly a rewrite.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Al Viro (8):
      fix compat handling of FICLONERANGE, FIDEDUPERANGE and FS_IOC_FIEMAP
      FIGETBSZ: fix compat
      compat: itanic doesn't have one
      do_vfs_ioctl(): use saner types
      compat: move FS_IOC_RESVSP_32 handling to fs/ioctl.c
      compat_sys_ioctl(): make parallel to do_vfs_ioctl()
      compat_ioctl: unify copy-in of ppp filters
      compat_ioctl: move PPPIOCSCOMPRESS to ppp_generic

Arnd Bergmann (34):
      compat_ioctl: add compat_ptr_ioctl()
      ceph: fix compat_ioctl for ceph_dir_operations
      compat_ioctl: move rtc handling into drivers/rtc/dev.c
      compat_ioctl: move drivers to compat_ptr_ioctl
      compat_ioctl: move more drivers to compat_ptr_ioctl
      compat_ioctl: use correct compat_ptr() translation in drivers
      compat_ioctl: move tape handling into drivers
      compat_ioctl: move ATYFB_CLK handling to atyfb driver
      compat_ioctl: move isdn/capi ioctl translation into driver
      compat_ioctl: move rfcomm handlers into driver
      compat_ioctl: move hci_sock handlers into driver
      compat_ioctl: remove HCIUART handling
      compat_ioctl: remove HIDIO translation
      compat_ioctl: remove translation for sound ioctls
      compat_ioctl: remove IGNORE_IOCTL()
      compat_ioctl: remove /dev/random commands
      compat_ioctl: remove joystick ioctl translation
      compat_ioctl: remove PCI ioctl translation
      compat_ioctl: remove /dev/raw ioctl translation
      compat_ioctl: remove last RAID handling code
      compat_ioctl: remove unused convert_in_user macro
      gfs2: add compat_ioctl support
      fs: compat_ioctl: move FITRIM emulation into file systems
      compat_ioctl: move WDIOC handling into wdt drivers
      compat_ioctl: reimplement SG_IO handling
      af_unix: add compat_ioctl support
      compat_ioctl: handle SIOCOUTQNSD
      compat_ioctl: move SIOCOUTQ out of compat_ioctl.c
      tty: handle compat PPP ioctls
      compat_ioctl: handle PPPIOCGIDLE for 64-bit time_t
      compat_ioctl: ppp: move simple commands into ppp_generic.c
      compat_ioctl: move SG_GET_REQUEST_TABLE handling
      pktcdvd: add compat_ioctl handler
      scsi: sd: enable compat ioctls for sed-opal

 Documentation/networking/ppp_generic.txt    |   2 +
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c   |   1 +
 arch/um/drivers/harddog_kern.c              |   1 +
 arch/um/drivers/hostaudio_kern.c            |   1 +
 block/scsi_ioctl.c                          | 132 +++-
 drivers/android/binder.c                    |   2 +-
 drivers/block/pktcdvd.c                     |  25 +
 drivers/char/ipmi/ipmi_watchdog.c           |   1 +
 drivers/char/ppdev.c                        |  12 +-
 drivers/char/random.c                       |   1 +
 drivers/char/tpm/tpm_vtpm_proxy.c           |  12 +-
 drivers/crypto/qat/qat_common/adf_ctl_drv.c |   2 +-
 drivers/dma-buf/dma-buf.c                   |   4 +-
 drivers/dma-buf/sw_sync.c                   |   2 +-
 drivers/dma-buf/sync_file.c                 |   2 +-
 drivers/firewire/core-cdev.c                |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c    |   2 +-
 drivers/hid/hidraw.c                        |   4 +-
 drivers/hid/usbhid/hiddev.c                 |  11 +-
 drivers/hwmon/fschmd.c                      |   1 +
 drivers/hwmon/w83793.c                      |   1 +
 drivers/hwtracing/stm/core.c                |  12 +-
 drivers/ide/ide-tape.c                      |  27 +-
 drivers/iio/industrialio-core.c             |   2 +-
 drivers/infiniband/core/uverbs_main.c       |   4 +-
 drivers/isdn/capi/capi.c                    |  31 +
 drivers/media/rc/lirc_dev.c                 |   4 +-
 drivers/misc/cxl/flash.c                    |   8 +-
 drivers/misc/genwqe/card_dev.c              |  23 +-
 drivers/misc/mei/main.c                     |  22 +-
 drivers/misc/vmw_vmci/vmci_host.c           |   2 +-
 drivers/mtd/ubi/cdev.c                      |  36 +-
 drivers/net/ppp/ppp_generic.c               | 245 +++++---
 drivers/net/tap.c                           |  12 +-
 drivers/nvdimm/bus.c                        |   4 +-
 drivers/nvme/host/core.c                    |   2 +-
 drivers/pci/switch/switchtec.c              |   2 +-
 drivers/platform/x86/wmi.c                  |   2 +-
 drivers/rpmsg/rpmsg_char.c                  |   4 +-
 drivers/rtc/dev.c                           |  33 +-
 drivers/rtc/rtc-ds1374.c                    |   1 +
 drivers/rtc/rtc-m41t80.c                    |   1 +
 drivers/rtc/rtc-vr41xx.c                    |   8 +
 drivers/s390/char/tape_char.c               |  41 +-
 drivers/sbus/char/display7seg.c             |   2 +-
 drivers/sbus/char/envctrl.c                 |   4 +-
 drivers/scsi/3w-xxxx.c                      |   4 +-
 drivers/scsi/cxlflash/main.c                |   2 +-
 drivers/scsi/esas2r/esas2r_main.c           |   2 +-
 drivers/scsi/megaraid/megaraid_mm.c         |  28 +-
 drivers/scsi/pmcraid.c                      |   4 +-
 drivers/scsi/sd.c                           |  14 +-
 drivers/scsi/sg.c                           |  59 +-
 drivers/scsi/st.c                           |  28 +-
 drivers/staging/android/ion/ion.c           |   4 +-
 drivers/staging/pi433/pi433_if.c            |  12 +-
 drivers/staging/vme/devices/vme_user.c      |   2 +-
 drivers/tee/tee_core.c                      |   2 +-
 drivers/tty/tty_io.c                        |   5 +
 drivers/usb/class/cdc-wdm.c                 |   2 +-
 drivers/usb/class/usbtmc.c                  |   4 +-
 drivers/usb/core/devio.c                    |  16 +-
 drivers/usb/gadget/function/f_fs.c          |  12 +-
 drivers/vfio/vfio.c                         |  39 +-
 drivers/vhost/net.c                         |  12 +-
 drivers/vhost/scsi.c                        |  12 +-
 drivers/vhost/test.c                        |  12 +-
 drivers/vhost/vsock.c                       |  12 +-
 drivers/video/fbdev/aty/atyfb_base.c        |  12 +-
 drivers/virt/fsl_hypervisor.c               |   2 +-
 drivers/watchdog/acquirewdt.c               |   1 +
 drivers/watchdog/advantechwdt.c             |   1 +
 drivers/watchdog/alim1535_wdt.c             |   1 +
 drivers/watchdog/alim7101_wdt.c             |   1 +
 drivers/watchdog/ar7_wdt.c                  |   1 +
 drivers/watchdog/at91rm9200_wdt.c           |   1 +
 drivers/watchdog/ath79_wdt.c                |   1 +
 drivers/watchdog/bcm63xx_wdt.c              |   1 +
 drivers/watchdog/cpu5wdt.c                  |   1 +
 drivers/watchdog/eurotechwdt.c              |   1 +
 drivers/watchdog/f71808e_wdt.c              |   1 +
 drivers/watchdog/gef_wdt.c                  |   1 +
 drivers/watchdog/geodewdt.c                 |   1 +
 drivers/watchdog/ib700wdt.c                 |   1 +
 drivers/watchdog/ibmasr.c                   |   1 +
 drivers/watchdog/indydog.c                  |   1 +
 drivers/watchdog/intel_scu_watchdog.c       |   1 +
 drivers/watchdog/iop_wdt.c                  |   1 +
 drivers/watchdog/it8712f_wdt.c              |   1 +
 drivers/watchdog/ixp4xx_wdt.c               |   1 +
 drivers/watchdog/m54xx_wdt.c                |   1 +
 drivers/watchdog/machzwd.c                  |   1 +
 drivers/watchdog/mixcomwd.c                 |   1 +
 drivers/watchdog/mtx-1_wdt.c                |   1 +
 drivers/watchdog/mv64x60_wdt.c              |   1 +
 drivers/watchdog/nv_tco.c                   |   1 +
 drivers/watchdog/pc87413_wdt.c              |   1 +
 drivers/watchdog/pcwd.c                     |   1 +
 drivers/watchdog/pcwd_pci.c                 |   1 +
 drivers/watchdog/pcwd_usb.c                 |   1 +
 drivers/watchdog/pika_wdt.c                 |   1 +
 drivers/watchdog/pnx833x_wdt.c              |   1 +
 drivers/watchdog/rc32434_wdt.c              |   1 +
 drivers/watchdog/rdc321x_wdt.c              |   1 +
 drivers/watchdog/riowd.c                    |   1 +
 drivers/watchdog/sa1100_wdt.c               |   1 +
 drivers/watchdog/sb_wdog.c                  |   1 +
 drivers/watchdog/sbc60xxwdt.c               |   1 +
 drivers/watchdog/sbc7240_wdt.c              |   1 +
 drivers/watchdog/sbc_epx_c3.c               |   1 +
 drivers/watchdog/sbc_fitpc2_wdt.c           |   1 +
 drivers/watchdog/sc1200wdt.c                |   1 +
 drivers/watchdog/sc520_wdt.c                |   1 +
 drivers/watchdog/sch311x_wdt.c              |   1 +
 drivers/watchdog/scx200_wdt.c               |   1 +
 drivers/watchdog/smsc37b787_wdt.c           |   1 +
 drivers/watchdog/w83877f_wdt.c              |   1 +
 drivers/watchdog/w83977f_wdt.c              |   1 +
 drivers/watchdog/wafer5823wdt.c             |   1 +
 drivers/watchdog/watchdog_dev.c             |   1 +
 drivers/watchdog/wdrtas.c                   |   1 +
 drivers/watchdog/wdt.c                      |   1 +
 drivers/watchdog/wdt285.c                   |   1 +
 drivers/watchdog/wdt977.c                   |   1 +
 drivers/watchdog/wdt_pci.c                  |   1 +
 fs/btrfs/super.c                            |   2 +-
 fs/ceph/dir.c                               |   1 +
 fs/ceph/file.c                              |   2 +-
 fs/compat_ioctl.c                           | 917 ++--------------------------
 fs/ecryptfs/file.c                          |   1 +
 fs/ext4/ioctl.c                             |   1 +
 fs/f2fs/file.c                              |   1 +
 fs/fat/file.c                               |  13 +-
 fs/fuse/dev.c                               |   2 +-
 fs/gfs2/file.c                              |  30 +
 fs/hpfs/dir.c                               |   1 +
 fs/hpfs/file.c                              |   1 +
 fs/ioctl.c                                  |  80 ++-
 fs/nilfs2/ioctl.c                           |   1 +
 fs/notify/fanotify/fanotify_user.c          |   2 +-
 fs/ocfs2/ioctl.c                            |   1 +
 fs/userfaultfd.c                            |   2 +-
 include/linux/blkdev.h                      |   2 +
 include/linux/falloc.h                      |  20 +
 include/linux/fs.h                          |   7 +
 include/linux/mtio.h                        |  60 ++
 include/uapi/linux/ppp-ioctl.h              |   2 +
 include/uapi/linux/ppp_defs.h               |  14 +
 lib/iov_iter.c                              |   1 +
 net/bluetooth/hci_sock.c                    |  21 +-
 net/bluetooth/rfcomm/sock.c                 |  14 +-
 net/rfkill/core.c                           |   2 +-
 net/socket.c                                |   3 +
 net/unix/af_unix.c                          |  19 +
 sound/core/oss/pcm_oss.c                    |   4 +
 sound/oss/dmasound/dmasound_core.c          |   2 +
 156 files changed, 954 insertions(+), 1394 deletions(-)
 create mode 100644 include/linux/mtio.h
