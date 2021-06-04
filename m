Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7692A39B8BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 14:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhFDMKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 08:10:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46838 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhFDMKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:10:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id u126so3318886pfu.13;
        Fri, 04 Jun 2021 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jo3Fvmq2V7OwPGYkYg50BrG40f8IEBRSlOJxYlXjmqg=;
        b=IXygTDoQvDJCV9NmIdcmqWs8z4kHMBlaIBqg9zmXCPO6GQgDm5oAG+8QQNmN+7FY/c
         i9qe3maYMG9g7P/8NSY2wqDZwDhWsIWn3h2o/xH5Rt94U0C5Z27iJRWTJnsfaj5BuBqv
         vRDWGgJyVRaE3Otcb/HCoG2NDenw09MhKnL5g6QqmPBcnbQfHlumYA4zYgiDgtoDOYR4
         UWslRPfHpVVS0037kEY3tNz5ke2FHbqEcHfXbFd7JtSWD3eN/MIZvjLzlPLmd35FPMUA
         pxsDQ2eHtCM867MazzknntpEq1Im3Kik4IwUrMc9n+45KSAZ+j2lpYvsCQ5tHbiXmTmm
         R9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jo3Fvmq2V7OwPGYkYg50BrG40f8IEBRSlOJxYlXjmqg=;
        b=qgW3UWGrCQUq8sQSvzxjXVcOpAlzUt0I4PgMvF+Letr+l7lp2UFuoUfyClN5QW70w3
         7hbM/X7oszQ0N1C9mRpHqcyXjK6OT1dkKXqdxrGqyUw1anxeV66BthYevOKZ6EYGBYUF
         goY0AiKmNqpa5e3RmyvbXDfM+LPzmRu3eOCvR3AbpJdIXXx61D2Yp2cQ+p7ZhHqlXoaU
         omYeBXw5bGBMOJ7tp9n6QwlqWqS+AKFoUc5y6cJSbghfk/0RedI/R/T6dAHKFXEeIxlR
         9x2ts1HmLXHAePjy0QmzWU2QCQfFOF++m61agRjJRpj/OrzRItmPvxFaSOG3jW8mKxea
         xnYA==
X-Gm-Message-State: AOAM533SGGYwOhfEV0kOxfspIIxyUBe24+BHvF5Zjk/BA73oHjHtQRso
        IZ9ypQQAyj2fIa2+fiso9QW+JxPbeQyljw==
X-Google-Smtp-Source: ABdhPJwPzVLGAQuy4phYnEWFNr+Ol0WDifLU9yFgm7+CHZlbwGyJM9dCK6VxWKHccQvi3mdawdErEQ==
X-Received: by 2002:aa7:9983:0:b029:2e9:e086:7917 with SMTP id k3-20020aa799830000b02902e9e0867917mr4350756pfh.57.1622808468529;
        Fri, 04 Jun 2021 05:07:48 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id ev11sm4779146pjb.36.2021.06.04.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 05:07:47 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        elver@google.com, masahiroy@kernel.org, dong.menglong@zte.com.cn,
        joe@perches.com, axboe@kernel.dk, hare@suse.de, jack@suse.cz,
        gregkh@linuxfoundation.org, tj@kernel.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, f.fainelli@gmail.com,
        arnd@arndb.de, palmerdabbelt@google.com,
        wangkefeng.wang@huawei.com, linux@rasmusvillemoes.dk,
        brho@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, pmladek@suse.com, glider@google.com,
        chris@chrisdown.name, ebiederm@xmission.com, jojing64@gmail.com,
        geert@linux-m68k.org, mingo@kernel.org, terrelln@fb.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, jeyu@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: [PATCH v5 0/3] init/initramfs.c: make initramfs support pivot_root
Date:   Fri,  4 Jun 2021 05:07:24 -0700
Message-Id: <20210604120727.58410-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

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



David Sterba (1):
  MAINTAINERS: add btrfs IRC link

Menglong Dong (2):
  net: tipc: fix FB_MTU eat two pages
  init/main.c: introduce function ramdisk_exec_exist()

-- 
2.25.1

