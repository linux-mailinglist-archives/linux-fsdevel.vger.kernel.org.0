Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4419270F489
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 12:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjEXKs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjEXKsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 06:48:55 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AEC98
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 03:48:54 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-783f88ce548so610943241.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684925333; x=1687517333;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=izjtzCWSO3V30nPY/lKoLTSymypWksl9aXq+SMrSSR4=;
        b=eIrDBzI2+Y6c3ajP2t6EfqTU7yrqOLMZnBSNdLYLBo5Ge+Kpnmz3xI2NDLuXGJUx9B
         IJK1edBpN8tWETbLzwnxqmUm180YNQyONPhZfihmxtC/8lxgDIMPa3oTAjz9fytgiymC
         k0Ucea9q/KKmAxDL56o7Lw3RLYNjjlxrZ72qN5wi6cVqMnYrhV1qc4TJ9KT1e6SlGedB
         9JNlsczyLltriaG9hWfSIBJ9C85xhFt35DVOv78ovRPwRmqSZFz0X+dq6Jtg+G1brGsS
         WWc8Q6uG1FodpCiDTvXX14CfOX0Og6D7zhB8IDOPUXJogq5ek6sIrWs9xmYANFfq+vmA
         rbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684925333; x=1687517333;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izjtzCWSO3V30nPY/lKoLTSymypWksl9aXq+SMrSSR4=;
        b=g8B6a9qyG+p17Cldn/NR8warE/Vkm2Y6tpLmniYObH9JgfSDJiY6H816Su1HgfmkLA
         wompdejXjquDe8zMUgnVv5TcvetCbQ1RncGqPN/7LmATRel06TxSvVoXSy65IQz2MMw2
         GsIJdRYl8cpxIrjw4Rkrn+eOLPfKraR1EOF7RYV/cSGZKunO7z3WpIu2QYnyjoMxRCVt
         q/i1SymN2cOTtyMVz+iPM/Q0xoCVcvbYku2Vvd+leeueaFlJT0Fer2i2KRfWLI3w5Ghx
         dGEoGbjlGkHurOm3/LbtZyMZ0T+4PuzsBCgGL8m9goNoj7uTU6eSUvrnzPgZSgb0YC5E
         vLWA==
X-Gm-Message-State: AC+VfDxO9FksPIlPD2sXT3N5Bcg77rwajZk7pq6Nx9mKEpubpDUt2LZO
        1YgA/ftiJE5/ctx3pHs4qV7+01l7TkKfcgwZUTRsOQ==
X-Google-Smtp-Source: ACHHUZ7dGXhAAYQ0ZVMH5xXIrESE7KpD6AKM288xP3S7MG24zrh10Wcemw5hhk9LGDL9KAGbU0DtksYgalPfF1DMPBQ=
X-Received: by 2002:a67:f148:0:b0:434:2f6a:6009 with SMTP id
 t8-20020a67f148000000b004342f6a6009mr5715027vsm.8.1684925333160; Wed, 24 May
 2023 03:48:53 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 24 May 2023 16:18:42 +0530
Message-ID: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
Subject: LTP: syscalls: statx06.c:138: TFAIL: Modified time > after_time
To:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LTP syscalls statx06 fails on NFS mounted devices using external hard drives
for testing and running on Linux next 6.4.0-rc3-next-20230524.

Test case fails on x86_64, i386 and arm64 Juno-r2.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Linux version 6.4.0-rc3-next-20230524 (tuxmake@tuxmake)
(x86_64-linux-gnu-gcc (Debian 11.3.0-12) 11.3.0, GNU ld (GNU Binutils
for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1684908723
...

[    1.396191] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    1.397234] sysctl table check failed: kernel/usermodehelper Not a file
[    1.398166] sysctl table check failed: kernel/usermodehelper No proc_handler
[    1.399165] sysctl table check failed: kernel/usermodehelper bogus .mode 0555
[    1.400166] sysctl table check failed: kernel/keys Not a file
[    1.401165] sysctl table check failed: kernel/keys No proc_handler
[    1.402165] sysctl table check failed: kernel/keys bogus .mode 0555
[    1.403166] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
6.4.0-rc3-next-20230524 #1
[    1.404165] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.5 11/26/2020
[    1.404165] Call Trace:
[    1.404165]  <TASK>
[    1.404165]  dump_stack_lvl+0x72/0x90
[    1.404165]  dump_stack+0x14/0x20
[    1.404165]  __register_sysctl_table+0x570/0x840
[    1.404165]  __register_sysctl_init+0x29/0x60
[    1.404165]  sysctl_init_bases+0x27/0x80
[    1.404165]  proc_sys_init+0x37/0x40
[    1.404165]  proc_root_init+0x7b/0x90
[    1.404165]  start_kernel+0x403/0x6a0
[    1.404165]  x86_64_start_reservations+0x1c/0x30
[    1.404165]  x86_64_start_kernel+0xcb/0xe0
[    1.404165]  secondary_startup_64_no_verify+0x179/0x17b
[    1.404165]  </TASK>
[    1.404165] failed when register_sysctl kern_table to kernel

....
./runltp -f syscalls -d /scratch

...

[ 1192.088987] loop0: detected capacity change from 0 to 614400
tst_device.c:93: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='-I 256'
extra opts=''
mke2fs 1.46.5 (30-Dec-2021)
[ 1192.337350] EXT4-fs (loop0): mounted filesystem
dfe9283c-5d2f-43f8-840e-a2bbbff5b202 r/w with ordered data mode. Quota
mode: none.
tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s

statx06.c:140: TPASS: Birth time Passed
statx06.c:138: TFAIL: Modified time > after_time
statx06.c:140: TPASS: Access time Passed
statx06.c:140: TPASS: Change time Passed


links,
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/details/


--
Linaro LKFT
https://lkft.linaro.org
