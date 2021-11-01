Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A016441958
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 11:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhKAKGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 06:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhKAKGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:06:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC17C06BA35
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Nov 2021 02:38:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso4728631pjo.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Nov 2021 02:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tivwVd0zRaSLDL6pT4dO7HnCUvbN3jMLwZBfbtgKG4I=;
        b=e07KqjgIDdVf4+PVNrsVVCxPfJn3fg2iUWT02uv/EDLbvOrxZdW98BMGRqCC+whzvK
         D7/kIjtuTJqUphVIOm7JIb6zVTRyjkBsk15uktYzsCwE6dt51XlcNPwAnTdqY49M8TYA
         eBaqng7n9rsV27zsga6wvcHEeXEf3WeN9tihkSqo3ohw+aTyxBcsVEP3vAdTRMyQ+Bql
         uMgTQGoEgb93Ppt5sfZK1DmY+dNvdyq8agrU58CqlcjGLQZMIPXU4CtI+LdurPUY1gKV
         BG4HhlxQg5pzPX+6DrlNz7Bk2eTvOdgY0hWoQaD3igfGYqbMG0o/88PK7lLezK2YoTAW
         B7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tivwVd0zRaSLDL6pT4dO7HnCUvbN3jMLwZBfbtgKG4I=;
        b=mC6IBbdoujiySvbKRrPjckAgVfOvwjRHlplsotlWsbmYJ2HQ9MKnYxGpjKpKHqgwfl
         F77liBGs0boNVFGLNuOqV54aa9s6BkLgW16BYRKf0rLLOP30I5F3QMZQk7AY1yRnN+gk
         u/HNHrmuIDv144226W5+W0+HcC7qIa3/YG7MRH+B+tCMhWO9EMxz00iOsNIwpXd1FXA+
         9pmM6bxA/TpOhMdysFZPDLjDL1piqvFInJzACOXC8FfR27gSE/lM72vnF6/MvyZ4Fc7i
         ceehwd7NOa28UUMriNVX7uWkHPJFmO0E+UotE2OgjC08rH8DNNnhinR0aCrYcGTAGutD
         69rA==
X-Gm-Message-State: AOAM530korAdq0YNIGVsGz5CwQ+VU1jSqPuSv2mtcxWRuMcU5MXE8Iu6
        xMVtZpmrKoG0hNJZiKM+WYsSgNbws9KoPkE/
X-Google-Smtp-Source: ABdhPJx5336aSRwmSU39b7bpTkJK0CP08e63GZmjtH2A242VZk8eGGPuRDk3SvOOZ0Z9wMjjNODdmw==
X-Received: by 2002:a17:90b:4acd:: with SMTP id mh13mr4616797pjb.230.1635759479803;
        Mon, 01 Nov 2021 02:37:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id p16sm15738259pfh.97.2021.11.01.02.37.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 02:37:59 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/4] remove PDE_DATA()
Date:   Mon,  1 Nov 2021 17:35:14 +0800
Message-Id: <20211101093518.86845-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I found a bug [1] some days ago, which is because we want to use
inode->i_private to pass user private data. However, this is wrong
on proc fs. We provide a specific function PDE_DATA() to get user
private data. Actually, we can hide this detail by storing
PDE()->data into inode->i_private and removing PDE_DATA() completely.
The user could use inode->i_private to get user private data just
like debugfs does. This series is trying to remove PDE_DATA().

[1] https://lore.kernel.org/lkml/20211029032638.84884-1-songmuchun@bytedance.com/

Muchun Song (4):
  fs: proc: store PDE()->data into inode->i_private
  fs: proc: replace PDE_DATA(inode) with inode->i_private
  fs: proc: remove PDE_DATA()
  fs: proc: use DEFINE_PROC_SHOW_ATTRIBUTE() to simplify the code

 arch/alpha/kernel/srm_env.c                        |  4 ++--
 arch/arm/kernel/atags_proc.c                       |  2 +-
 arch/ia64/kernel/salinfo.c                         | 10 ++++-----
 arch/powerpc/kernel/proc_powerpc.c                 |  4 ++--
 arch/sh/mm/alignment.c                             |  2 +-
 arch/xtensa/platforms/iss/simdisk.c                |  4 ++--
 drivers/acpi/proc.c                                |  2 +-
 drivers/hwmon/dell-smm-hwmon.c                     |  4 ++--
 drivers/net/bonding/bond_procfs.c                  |  8 ++++----
 drivers/net/wireless/cisco/airo.c                  | 22 ++++++++++----------
 drivers/net/wireless/intersil/hostap/hostap_ap.c   | 16 +++++++--------
 .../net/wireless/intersil/hostap/hostap_download.c |  2 +-
 drivers/net/wireless/intersil/hostap/hostap_proc.c | 24 +++++++++++-----------
 drivers/net/wireless/ray_cs.c                      |  2 +-
 drivers/nubus/proc.c                               |  2 +-
 drivers/parisc/led.c                               |  4 ++--
 drivers/pci/proc.c                                 | 10 ++++-----
 drivers/platform/x86/thinkpad_acpi.c               |  4 ++--
 drivers/platform/x86/toshiba_acpi.c                | 16 +++++++--------
 drivers/pnp/isapnp/proc.c                          |  2 +-
 drivers/pnp/pnpbios/proc.c                         |  4 ++--
 drivers/scsi/scsi_proc.c                           |  4 ++--
 drivers/usb/gadget/function/rndis.c                |  4 ++--
 drivers/zorro/proc.c                               |  2 +-
 fs/afs/proc.c                                      |  6 +++---
 fs/cifs/cifs_debug.c                               | 17 ++-------------
 fs/ext4/mballoc.c                                  | 14 ++++++-------
 fs/jbd2/journal.c                                  |  2 +-
 fs/nfsd/stats.c                                    | 15 ++------------
 fs/proc/generic.c                                  |  6 ------
 fs/proc/inode.c                                    |  1 +
 fs/proc/internal.h                                 |  5 -----
 fs/proc/proc_net.c                                 | 12 +++++------
 include/linux/proc_fs.h                            |  2 --
 include/linux/seq_file.h                           |  2 +-
 ipc/util.c                                         |  2 +-
 kernel/irq/proc.c                                  |  8 ++++----
 kernel/resource.c                                  |  4 ++--
 net/atm/proc.c                                     |  4 ++--
 net/bluetooth/af_bluetooth.c                       |  8 ++++----
 net/can/bcm.c                                      |  2 +-
 net/can/proc.c                                     |  2 +-
 net/core/neighbour.c                               |  6 +++---
 net/core/pktgen.c                                  |  6 +++---
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  6 +++---
 net/ipv4/raw.c                                     |  8 ++++----
 net/ipv4/tcp_ipv4.c                                |  2 +-
 net/ipv4/udp.c                                     |  6 +++---
 net/netfilter/x_tables.c                           | 10 ++++-----
 net/netfilter/xt_hashlimit.c                       | 18 ++++++++--------
 net/netfilter/xt_recent.c                          |  4 ++--
 net/sunrpc/auth_gss/svcauth_gss.c                  |  4 ++--
 net/sunrpc/cache.c                                 | 24 +++++++++++-----------
 net/sunrpc/stats.c                                 | 15 ++------------
 sound/core/info.c                                  |  4 ++--
 55 files changed, 168 insertions(+), 215 deletions(-)

-- 
2.11.0

