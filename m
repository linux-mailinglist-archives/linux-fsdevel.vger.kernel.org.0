Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6BC4909A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 14:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiAQNoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 08:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiAQNoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:44:07 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6211FC061574;
        Mon, 17 Jan 2022 05:44:07 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id o135so8651066qke.8;
        Mon, 17 Jan 2022 05:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcgdBMETg09EaIqnlllAs1b5H6LLPh/71QIKDM8zgoQ=;
        b=aB4uPEUcyHIddyBjA09c1Ve85mosTSF4qF+8O1xymYerqPxVfWr3/YKiK62kzwU8bE
         Sw5+sbvrsh7deGjMKqTomRo7c3uygv/DgWuHMhIS/jHIvKMNkD3LfKc2ewCOJcxxkeFy
         joI1PqdJYlkwzdNvo4WQ5mKC8fkYJvkO03rzLT2fKw51Wz0Y5nLXDDDiwm849/K1FQ6R
         4v0PmCVacEOP3k3t1wJWrAtNrk6Da+0dyUBesvecag4qDirawZNxHFq6/fxlvjxvAQ8C
         mXMpNFRsmvnSGwdhV9pzynuuz7L8WnSemFB8BjFlXRcLXfGn8BZy/uc/v7LyDfyLnNoZ
         AaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcgdBMETg09EaIqnlllAs1b5H6LLPh/71QIKDM8zgoQ=;
        b=XL9vv2j3kYSJBJ8hGO+bvF3etbZro8P9ffoy+KVNNMinYv2+0hyM8FxYA4v3vN4u2Z
         pTKVM7OF+RHMAcCEHhIMBZ0W0ExLzgICRgK2QGxsVdJ7lW02EhxMY/9APrUim0BMSj1z
         DAZ0yK4PrIWjrmziW5Osps8PhK1M26K5wE09Ba7NVfBT7RT7xShAJw+3zgatTzkFQrDw
         UV/kNL+PQ6sA54NBrL4ai/DWXNDhLaygjUNZUwMq2QOIDQBBL0UhwoWnFCwwdQxFHqYb
         PRsHaGRtM2YsLAGE9Nu9FgwV3pjy/OR7UgN7+zHNMpQX0jptv7DfILWHugGPNYH9UKvi
         m7jQ==
X-Gm-Message-State: AOAM533VFoNjFktYCZPzE4SxtKlwvs91N80QIEe39UuqDgNmQ2BaWI0h
        vOfTKFa+MCq9jeTizScMg1s=
X-Google-Smtp-Source: ABdhPJzvafk1T1OUqBxHnB53261+ZqfPQG+SyFnzkux6s+4h35+3vQj53k6oFQCsvq83Ui9dpOXg2w==
X-Received: by 2002:a05:620a:458c:: with SMTP id bp12mr3572279qkb.175.1642427046452;
        Mon, 17 Jan 2022 05:44:06 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s1sm9124073qtw.25.2022.01.17.05.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 05:44:05 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     mhiramat@kernel.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        bhelgaas@google.com, elver@google.com, masahiroy@kernel.org,
        zhang.yunkai@zte.com.cn, axboe@kernel.dk, vgoyal@redhat.com,
        jack@suse.cz, leon@kernel.org, akpm@linux-foundation.org,
        rppt@kernel.org, linux@rasmusvillemoes.dk,
        palmerdabbelt@google.com, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, rostedt@goodmis.org,
        ahalaney@redhat.com, valentin.schneider@arm.com,
        peterz@infradead.org, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] init/initramfs.c: make initramfs support pivot_root
Date:   Mon, 17 Jan 2022 13:43:50 +0000
Message-Id: <20220117134352.866706-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

As Luis Chamberlain suggested, I split the patch:
[init/initramfs.c: make initramfs support pivot_root]
(https://lore.kernel.org/linux-fsdevel/20210520154244.20209-1-dong.menglong@zte.com.cn/)
into three.

The goal of the series patches is to make pivot_root() support initramfs.

In the first patch, I introduce the function ramdisk_exec_exist(), which
is used to check the exist of 'ramdisk_execute_command' in LOOKUP_DOWN
lookup mode.

In the second patch, I create a second mount, which is called
'user root', and make it become the root. Therefore, the root has a
parent mount, and it can be umounted or pivot_root.

In the third patch, I fix rootfs_fs_type with ramfs, as it is not used
directly any more, and it make no sense to switch it between ramfs and
tmpfs, just fix it with ramfs to simplify the code.

Changes since V6:

Fix some bugs by Zhang Yunkai.


Changes since V5:

Remove the third patch and make it combined with the second one.


Changes since V4:                                                                                                                                                     
                                                                                                                                                                      
Do some more code cleanup for the second patch, include:                                                                                                              
- move 'ramdisk_exec_exist()' to 'init.h'                                                                                                                             
- remove unnecessary struct 'fs_rootfs_root'                                                                                                                          
- introduce 'revert_mount_rootfs()'                                                                                                                                   
- [...]                                                                                                                                                               


Changes since V3:

Do a code cleanup for the second patch, as Christian Brauner suggested:
- remove the concept 'user root', which seems not suitable.
- introduce inline function 'check_tmpfs_enabled()' to avoid duplicated
  code.
- rename function 'mount_user_root' to 'prepare_mount_rootfs'
- rename function 'end_mount_user_root' to 'finish_mount_rootfs'
- join 'init_user_rootfs()' with 'prepare_mount_rootfs()'

Changes since V2:

In the first patch, I use vfs_path_lookup() in init_eaccess() to make the
path lookup follow the mount on '/'. After this, the problem reported by
Masami Hiramatsu is solved. Thanks for your report :/


Changes since V1:

In the first patch, I add the flag LOOKUP_DOWN to init_eaccess(), to make
it support the check of filesystem mounted on '/'.

In the second patch, I control 'user root' with kconfig option
'CONFIG_INITRAMFS_USER_ROOT', and add some comments, as Luis Chamberlain
suggested.

In the third patch, I make 'rootfs_fs_type' in control of
'CONFIG_INITRAMFS_USER_ROOT'.


Zhang Yunkai (2):
  init/main.c: introduce function ramdisk_exec_exist()
  init/do_mounts.c: create second mount for initramfs

 fs/init.c            | 11 +++++++++--
 include/linux/init.h |  1 +
 init/do_mounts.c     | 45 ++++++++++++++++++++++++++++++++++++++++++++
 init/do_mounts.h     | 17 ++++++++++++++++-
 init/initramfs.c     | 12 +++++++++++-
 init/main.c          |  7 ++++++-
 usr/Kconfig          | 10 ++++++++++
 7 files changed, 98 insertions(+), 5 deletions(-)

-- 
2.25.1

