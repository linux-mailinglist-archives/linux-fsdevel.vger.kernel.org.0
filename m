Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412BF21620C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 01:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgGFXX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 19:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGFXX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:23:28 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF09C08C5E0
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 16:23:28 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so44617053ejc.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2020 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sGrYZWycqP9TAozi+mTo3rMZiZ+iFPNxAZmAwH/+2ic=;
        b=NNTkWglw6v8kimxFbbxcgXJ9At1/ku05iGPvE8aPC5Jsx2p0hxTjTgFCfNzoD2yDSq
         NeU0flxzuhPXu/cjIb4PYggIl9H8gAz4LElUJBaOF7Z+BxrNCD22m5U83Er7SJaklDOe
         /nmJU10L+D7EbL4AsQRX9J355g4LfXHsBpk0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sGrYZWycqP9TAozi+mTo3rMZiZ+iFPNxAZmAwH/+2ic=;
        b=TOchVmf34yeUUFZXf1G+WLYrmgCu6rSKTSfIFm11iONMjiyKvmA/4RAjPig48GKf0M
         u5kThZhZQ1nHXLme8DBbSMqrg1txGl2QB5MaOfeNrSe99sNBSasPO6ylibyiRTrPRk/Y
         LbP+Uq6ykyvrVozpo1Vn61/RT6K6FyUO7vIBbB1NrV/vCxbUXFF5zGTSEuNmoKCq32QQ
         xnejlEawmn+XvKKRcZ3GtluqVfFkZ2/xftjybVYHDWdaOtHOrPu9pIK78ssqEe4AeNsk
         jw5+z6Ux6uMtXKk7F0epyEM2hmwOyrJFAdV2w94nTR2nP1Hx7de/D2dBGcseZ+i1fCfB
         Junw==
X-Gm-Message-State: AOAM532KI2X6t/hhhowuIBuEGU0xbhAR2ycphpBKN0e02USyWek6xz1/
        vx2yVk9nOZqXj0Ime4Z9nsbmoA==
X-Google-Smtp-Source: ABdhPJxhgqqb6a9BehYW0oPK9MabgPgpNbZJDqPabgwIBemL8sOsGvlShdvo3/nkEhwm/Wj/lYWWpg==
X-Received: by 2002:a17:906:57c6:: with SMTP id u6mr44182312ejr.194.1594077807004;
        Mon, 06 Jul 2020 16:23:27 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id i2sm4002567ejp.114.2020.07.06.16.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:23:26 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v10 0/9] firmware: add request_partial_firmware_into_buf
Date:   Mon,  6 Jul 2020 16:23:00 -0700
Message-Id: <20200706232309.12010-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds partial read support via a new call
request_partial_firmware_into_buf.
Such support is needed when the whole file is not needed and/or
only a smaller portion of the file will fit into allocated memory
at any one time.
In order to accept the enhanced API it has been requested that kernel
selftests and upstreamed driver utilize the API enhancement and so
are included in this patch series.

Also in this patch series is the addition of a new Broadcom VK driver
utilizing the new request_firmware_into_buf enhanced API.

Further comment followed to add IMA support of the partial reads
originating from request_firmware_into_buf calls.  And another request
to move existing kernel_read_file* functions to its own include file.

Changes from v9:
 - add patch to move existing kernel_read_file* to its own include file
 - driver fixes
Changes from v8:
 - correct compilation error when CONFIG_FW_LOADER not defined
Changes from v7:
 - removed swiss army knife kernel_pread_* style approach
   and simply add offset parameter in addition to those needed
   in kernel_read_* functions thus removing need for kernel_pread enum
Changes from v6:
 - update ima_post_read_file check on IMA_FIRMWARE_PARTIAL_READ
 - adjust new driver i2c-slave-eeprom.c use of request_firmware_into_buf
 - remove an extern
Changes from v5:
 - add IMA FIRMWARE_PARTIAL_READ support
 - change kernel pread flags to enum
 - removed legacy support from driver
 - driver fixes
Changes from v4:
 - handle reset issues if card crashes
 - allow driver to have min required msix
 - add card utilization information
Changes from v3:
 - fix sparse warnings
 - fix printf format specifiers for size_t
 - fix 32-bit cross-compiling reports 32-bit shifts
 - use readl/writel,_relaxed to access pci ioremap memory,
  removed memory barriers and volatile keyword with such change
 - driver optimizations for interrupt/poll functionalities
Changes from v2:
 - remove unnecessary code and mutex locks in lib/test_firmware.c
 - remove VK_IOCTL_ACCESS_BAR support from driver and use pci sysfs instead
 - remove bitfields
 - remove Kconfig default m
 - adjust formatting and some naming based on feedback
 - fix error handling conditions
 - use appropriate return codes
 - use memcpy_toio instead of direct access to PCIE bar


Scott Branden (9):
  fs: move kernel_read_file* to its own include file
  fs: introduce kernel_pread_file* support
  firmware: add request_partial_firmware_into_buf
  test_firmware: add partial read support for request_firmware_into_buf
  firmware: test partial file reads of request_partial_firmware_into_buf
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom VK driver
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
  ima: add FIRMWARE_PARTIAL_READ support

 MAINTAINERS                                   |    7 +
 drivers/base/firmware_loader/firmware.h       |    5 +
 drivers/base/firmware_loader/main.c           |   80 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   29 +
 drivers/misc/bcm-vk/Makefile                  |   11 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  419 +++++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1357 +++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c              | 1504 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  211 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  275 +++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   61 +
 drivers/misc/bcm-vk/bcm_vk_tty.c              |  352 ++++
 fs/exec.c                                     |   92 +-
 include/linux/firmware.h                      |   12 +
 include/linux/fs.h                            |   39 -
 include/linux/ima.h                           |    1 +
 include/linux/kernel_read_file.h              |   69 +
 include/linux/security.h                      |    1 +
 include/uapi/linux/misc/bcm_vk.h              |   99 ++
 kernel/kexec_file.c                           |    1 +
 kernel/module.c                               |    1 +
 lib/test_firmware.c                           |  154 +-
 security/integrity/digsig.c                   |    1 +
 security/integrity/ima/ima_fs.c               |    1 +
 security/integrity/ima/ima_main.c             |   25 +-
 security/integrity/ima/ima_policy.c           |    1 +
 security/loadpin/loadpin.c                    |    1 +
 security/security.c                           |    1 +
 security/selinux/hooks.c                      |    1 +
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 32 files changed, 4802 insertions(+), 91 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/linux/kernel_read_file.h
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

