Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128D71FA076
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 21:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgFOTmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 15:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbgFOTmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:42:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673CC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 12:42:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s88so298248pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HYEguIgCbs72qU3RQvrxRYIXfQehsVQ9xr9hBAlsIv0=;
        b=dkbPpsjDjU6G8ru0ttn46RPKVPgFK19yRuH9PgkL25/VkhONVT6d1SRaSawFEkIh3P
         q2G9dK2MaZXWR8pk5Y2Y1Mt/EV6grY8Q7bXEvq8BPnQgIoE3kerT+l+D6ATbDm2I1+nO
         Ua7wjPbwO7pX5wW8J0wsCoA2UyrRPH+drXvz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HYEguIgCbs72qU3RQvrxRYIXfQehsVQ9xr9hBAlsIv0=;
        b=eV7ey6TOukaTs7C6YwBqq5zq/uchPFYxS9GCZYjv8Jd2WpKx/iEi+98F0An/GKMHdC
         GnH6TFGAyzDvNZQGr6USQ5uwF4tF2pXgzzMED6pzZrTXXwAPru59Wj2C1zIHzYClcboI
         3TR92THpqwi2xMGMZ7Tk2Y5NrG4XmJr9EnZjhFdxHDOw3WbEsbTagwF0qkRFm1etyEgm
         0KIfJmWGhnSdRXE66F47iAmV7XzQDlTOweCvxLDdiGzyCPSDeheq0+QSUCBliwxn2t0i
         KvDjkk9jRCA06B3qmDd1YVfMur6vE/ItwLK2lLm9nNltrrRehGzpHza/vibaG+RM5rsV
         Uqpg==
X-Gm-Message-State: AOAM533eg2L2VTehYnGG8ee6k/Ykr/LLLVjuu4XqEvSPx0eRsOxqu3o6
        jp1bF3AMN8zxpxB30Oly7MJsRQ==
X-Google-Smtp-Source: ABdhPJxlw3cBZEDOlyThQIHDpnQsA/kqwh3v+wvEHfOnz+hY04zT6ELbTDVN9pSlaag4HAinH9avGg==
X-Received: by 2002:a17:902:b411:: with SMTP id x17mr22579249plr.272.1592250120762;
        Mon, 15 Jun 2020 12:42:00 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id gq8sm293663pjb.14.2020.06.15.12.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 12:42:00 -0700 (PDT)
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
Subject: [PATCH v9 0/8] firmware: add request_partial_firmware_into_buf
Date:   Mon, 15 Jun 2020 12:41:43 -0700
Message-Id: <20200615194151.7011-1-scott.branden@broadcom.com>
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
originating from request_firmware_into_buf calls.

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

Scott Branden (8):
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
 drivers/base/firmware_loader/main.c           |   79 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   29 +
 drivers/misc/bcm-vk/Makefile                  |   11 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  407 +++++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1310 +++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c              | 1440 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  202 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  271 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   60 +
 drivers/misc/bcm-vk/bcm_vk_tty.c              |  352 ++++
 fs/exec.c                                     |   93 +-
 include/linux/firmware.h                      |   12 +
 include/linux/fs.h                            |   15 +
 include/uapi/linux/misc/bcm_vk.h              |   99 ++
 lib/test_firmware.c                           |  154 +-
 security/integrity/ima/ima_main.c             |   24 +-
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 21 files changed, 4599 insertions(+), 53 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

