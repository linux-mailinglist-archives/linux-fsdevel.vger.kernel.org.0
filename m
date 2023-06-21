Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4004473860F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjFUOCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjFUOBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:01:44 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39FE1BE6
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 07:01:42 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-440ade974b8so1396684137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687356101; x=1689948101;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQij4wQznsR5F2fxwwkBmYe5wHBeledhlw5RjB1MrFk=;
        b=NwWhpwZ3uuatMmOugjTDVZU/f79JRrQT/EdiyhkGVUhZoTOqqYUhj+j7+Of42ZxvXY
         GDXH45Pfnu0sEf3jPzTud1mYefqDEXkT7ZBclg/YI4D/2pzWexdDC/AhnKcUsRV2ZpTR
         cf0cF9QGd+iGQ5lxF8YNIVtE7WL+K7SD18+YQbTWB0adpXmH9/yq1TZyOMem+0NWXGZu
         vexZksiGTvSZcHtXH+p7zUCic6cA+Ey+pWsl4Xjl6jpgPLOVOQ1du7mBXLP7LNSypHxD
         fZtGqN2SMhuXyXXyFa6UEEVuV3ZFFYGdQ0/ECfnKlAnEkVoiqBKMTPVa8HRcFfQHiH5U
         Azbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687356101; x=1689948101;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQij4wQznsR5F2fxwwkBmYe5wHBeledhlw5RjB1MrFk=;
        b=V2fhMNdUxwXNG4eeLomxxqvd1vf+0nCsRCLQGmnHlGkG+x033Fzm7W6ZYenozxpBZp
         QjcChHyc58e1UK12HF2CS6y/oGFK61hl2yD52fngY+NrhPrnX0WlNWFnykhsCYj2WmDS
         vIHrImewb3s7ALu1uewXSyST9mZ5/Ulgqi6HhTeOoc9n9Ba5o9RJjPuRH6Cl6FxUV7vu
         Ep8HjujflWu37I81F/F5v4obS5JnmImpe9XiqiDFgQhlwFgy6Ul3iX4ytqKpFQXL5NGB
         4JOORivJxQWu434BwDUyDPJUW9UFRUtQuUxV1w6Q7+ZLuJuG+F/zmhK82/kYDigbkJ35
         TpFg==
X-Gm-Message-State: AC+VfDw1gyKJ+rgKY+5+sMlyNieVahQIEjV/BxJmfWOjrdmHTDOjoTIr
        EVOYZrW4zY31jQdh76UKGI6itbUoMDm7p0TP5GOsCg==
X-Google-Smtp-Source: ACHHUZ7xdIJUeh4hZ7I54b7bLEO89fpN300504s2wq/4nNI2/3k6dHahRRll87ZLl5WIf6YkM1HJArctWAgSZeTNgT4=
X-Received: by 2002:a67:f514:0:b0:440:9cda:df51 with SMTP id
 u20-20020a67f514000000b004409cdadf51mr7209167vsn.28.1687356100440; Wed, 21
 Jun 2023 07:01:40 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 21 Jun 2023 19:31:29 +0530
Message-ID: <CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com>
Subject: next: ltp: fs: read_all: block sda: the capability attribute has been
 deprecated. - supervisor instruction fetch in kernel mode
To:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
        linux-block <linux-block@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, linux-mm <linux-mm@kvack.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While running LTP fs testing on x86_64 device the following kernel BUG:
notice with Linux next-20230621.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:

# cd /opt/ltp
# ./runltp -f fs

Test log:
======
read_all.c:687: TPASS: Finished reading files
Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
tst_test.c:1558: TINFO: Timeout per run is 0h 06m 40s
read_all.c:568: TINFO: Worker timeout set to 10% of max_runtime: 1000ms
[ 1344.664349] block sda: the capability attribute has been deprecated.
[ 1344.679885] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1344.686839] #PF: supervisor instruction fetch in kernel mode
[ 1344.692490] #PF: error_code(0x0010) - not-present page
[ 1344.697620] PGD 8000000105569067 P4D 8000000105569067 PUD 1056ed067 PMD 0
[ 1344.704494] Oops: 0010 [#1] PREEMPT SMP PTI
[ 1344.708680] CPU: 0 PID: 5649 Comm: read_all Not tainted
6.4.0-rc7-next-20230621 #1
[ 1344.716245] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.5 11/26/2020
[ 1344.723629] RIP: 0010:0x0
[ 1344.726257] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[ 1344.732780] RSP: 0018:ffff98d38123bd38 EFLAGS: 00010286
[ 1344.737998] RAX: 0000000000000000 RBX: ffffffffbea38720 RCX: 0000000000000000
[ 1344.745123] RDX: ffff979e42e31000 RSI: ffffffffbea38720 RDI: ffff979e40371900
[ 1344.752246] RBP: ffff98d38123bd48 R08: ffff979e4080a0f0 R09: 0000000000000001
[ 1344.759371] R10: ffff979e42e31000 R11: 0000000000000000 R12: ffff979e42e31000
[ 1344.766495] R13: 0000000000000001 R14: ffff979e432dd2f8 R15: ffff979e432dd2d0
[ 1344.773621] FS:  00007ff745d4b740(0000) GS:ffff97a1a7a00000(0000)
knlGS:0000000000000000
[ 1344.781704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1344.787442] CR2: ffffffffffffffd6 CR3: 000000010563c004 CR4: 00000000003706f0
[ 1344.794587] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1344.801733] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1344.808857] Call Trace:
[ 1344.811301]  <TASK>
[ 1344.813399]  ? show_regs+0x6e/0x80
[ 1344.816804]  ? __die+0x29/0x70
[ 1344.819857]  ? page_fault_oops+0x154/0x470
[ 1344.823957]  ? do_user_addr_fault+0x355/0x6c0
[ 1344.828314]  ? exc_page_fault+0x6e/0x170
[ 1344.832239]  ? asm_exc_page_fault+0x2b/0x30
[ 1344.836420]  max_phase_adjustment_show+0x23/0x50
[ 1344.841038]  dev_attr_show+0x1e/0x60
[ 1344.844616]  sysfs_kf_seq_show+0xb5/0x100
[ 1344.848628]  kernfs_seq_show+0x28/0x40
[ 1344.852374]  seq_read_iter+0x112/0x4a0
[ 1344.856125]  ? inode_security+0x27/0x60
[ 1344.859967]  kernfs_fop_read_iter+0x145/0x1a0
[ 1344.864325]  ? security_file_permission+0x52/0x60
[ 1344.869031]  vfs_read+0x1c7/0x310
[ 1344.872350]  ksys_read+0x6b/0xf0
[ 1344.875602]  __x64_sys_read+0x1d/0x30
[ 1344.879274]  do_syscall_64+0x3c/0x90
[ 1344.882846]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 1344.887898] RIP: 0033:0x7ff745e4a292
[ 1344.891476] Code: c0 e9 d2 fe ff ff 50 48 8d 3d 6a d5 0b 00 e8 15
ed 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
54 24
[ 1344.910213] RSP: 002b:00007fff8e8dd828 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[ 1344.917770] RAX: ffffffffffffffda RBX: 00000000008dabc0 RCX: 00007ff745e4a292
[ 1344.924896] RDX: 00000000000003ff RSI: 00007fff8e8dd8e0 RDI: 0000000000000003
[ 1344.932029] RBP: 00007ff745d40028 R08: 00000000001b4e6e R09: 00007fff8e903170
[ 1344.939159] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000030
[ 1344.946283] R13: 0000000000000003 R14: 00007ff745d3c000 R15: 0000000000001611
[ 1344.953411]  </TASK>
[ 1344.955617] Modules linked in: tun x86_pkg_temp_thermal
[ 1344.960836] CR2: 0000000000000000
[ 1344.964148] ---[ end trace 0000000000000000 ]---
[ 1344.964149] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1344.968766] RIP: 0010:0x0
[ 1344.975717] #PF: supervisor instruction fetch in kernel mode
[ 1344.978334] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[ 1344.983983] #PF: error_code(0x0010) - not-present page
[ 1344.990502] RSP: 0018:ffff98d38123bd38 EFLAGS: 00010286
[ 1344.995633] PGD 800000011c4c4067 P4D 800000011c4c4067


Links:
https://lkft.validation.linaro.org/scheduler/job/6531405#L2063
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230621/testrun/17701281/suite/log-parser-test/tests/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230621/testrun/17701281/suite/log-parser-test/test/check-kernel-bug/details/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230621/testrun/17701281/suite/log-parser-test/test/check-kernel-bug/log

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 15e71592dbae49a674429c618a10401d7f992ac3
  git_describe: next-20230621
  kernel_version: 6.4.0-rc7
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVA4HTFTr9mUVGTxGUDk0W0i9b/config
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVA4HTFTr9mUVGTxGUDk0W0i9b/

--
Linaro LKFT
https://lkft.linaro.org
