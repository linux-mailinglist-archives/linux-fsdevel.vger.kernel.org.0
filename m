Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A0E1F49AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 00:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgFIW5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 18:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgFIW5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:57:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC70C05BD1E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 15:57:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so225542pfn.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BG3o4m9VW7EKE6RQWof5spkXsGN8jYloY6eeW3sY9aQ=;
        b=R8GFoOJu3YU/sFkhqOUpFwaJHJW+dgJujqwlysKLkgIsmFM1P3/+XnlW8S59aMLRQz
         tE5MJ0yA1Fofk8hem9RCom2WIlgc5yQXBPJkBEqPNCl3x1894g3BBdCs0QWipUq09EKv
         Kk3u7EgvPyBhAOKmpPNitYXFx7vTwzc0QOuBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BG3o4m9VW7EKE6RQWof5spkXsGN8jYloY6eeW3sY9aQ=;
        b=neYkxqUs+H30SJZgsqhIWgVXLgD2wTgCfOZdablYXhk3xaApWXnJajuGawk/z5jlPz
         4ggDSs6oWRLlSNy7Bvcuy3pzJK9ol/omluXMFja8Hep+1H96//xxzJpA/Q8FUpm1zSAd
         C4JggJVHJIJbON8l/qaMwCdJ4KF7FDJCEoyMldd5pmZ/Y/Ken8amJPlssRGC9g41qYUx
         ONgoAjzZQ43LEOL4Bi8AtlZUA+YLym7dpbXj8zGUaqaH05FH61Li+xu9mzcZXsWjoeuA
         k8IJ7qZAzWMlaDKWLvY07m/hXeYJLgfmZItanbcgbiBPZh+kkiADz02PmDle4rSi6qiH
         eZHA==
X-Gm-Message-State: AOAM530tQ75RYcakm9yD2nqK0Qz1iSwTJc49K0q+YAU29CFimtELVbwc
        Du8pna8R8bffG2ouSRnu7v90XA==
X-Google-Smtp-Source: ABdhPJyxpgD52xf/eo5W7qCamOEF+hzbooC8LDE64w+FTdvtyp4gCIClQdSJQgXetDh7lv1MWg5M1Q==
X-Received: by 2002:a62:9246:: with SMTP id o67mr83649pfd.109.1591743427888;
        Tue, 09 Jun 2020 15:57:07 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm9104978pgs.29.2020.06.09.15.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:57:06 -0700 (PDT)
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
Subject: [PATCH v8 0/8] firmware: add request_partial_firmware_into_buf
Date:   Tue,  9 Jun 2020 15:56:48 -0700
Message-Id: <20200609225656.18663-1-scott.branden@broadcom.com>
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
  firmware: add offset to request_firmware_into_buf
  test_firmware: add partial read support for request_firmware_into_buf
  firmware: test partial file reads of request_firmware_into_buf
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

