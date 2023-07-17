Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06DD755B03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGQFx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 01:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGQFx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:53:56 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A4E43
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jul 2023 22:53:52 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-440c368b4e2so1192110137.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jul 2023 22:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689573232; x=1692165232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mbweXHv7kdKWUZdlAydPfD6L+ufswWI7k+5+2hFp+3U=;
        b=zcAlzvEvj9x06ElWg6xZ1CLijUw9Cizq1yeKK4E6PcHpe4/oaLPe2JRvA8ZqqtOT6M
         K+8QKF5dP4FhhNYVkzuH5Z2xinlh2vOWCTw2KwFLsKzogNR52YC8Ki4WxK2nBX0UvigX
         hu4KcptJVhlIH6vqQeZnJGROJEPNgoQnFfZvYPECRpbaGOBSXJs+8ioLMVz7yBuzGyzu
         LZRd/OsbDrmX9Sx8IJMhD4CW/J54X/PiSezqd+7ijelf28rRjx1N2pDNysUktNrP8xrj
         s97pRszhXEBj1aFn2JZggjbl8HLxRSrTwWyTs9FieO6LU5KkR0QJ9CoxAzCgQCRGbVm1
         jkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689573232; x=1692165232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbweXHv7kdKWUZdlAydPfD6L+ufswWI7k+5+2hFp+3U=;
        b=AnX/Oq7YJ4TVclKtOxVOi8V260rOWfzClF6t2Ky13hfaWvCsVhqtfO9FiCPAVp/ql8
         ltze6SdT2utQMEkGKrcxD1n8CQKBxMORavzzSIsSehW4AhzdKgMP5LZkrU1vKTHPyGx0
         lLo4y4OYivFNhElXER1PB07D5P6iYUzYb+gNR3o8GI+iJ0lZtxBQgzQMUXaAYKH5aP6G
         yF3e+Y1K6kwT1pP2LEUDUloZbl84J8dvf8XJEx6GvUPVkgsApkJEPhkQFy6KhTE2jDvZ
         uMJZblIhmG70g8W9lrna0I+W61NVK7YJpT/3kSMJlE0BqJ3fEhHLLhk/caVcA0GrA2rf
         nP7Q==
X-Gm-Message-State: ABy/qLYXaZvNX4DF9eyjfIUJJu3UGuE62G/S1HH83DKrtGMrY21w58/j
        RpQa6UQb/a/3Ou/vBcyl4bFSWHxesIRsE/tI9tC1AQ==
X-Google-Smtp-Source: APBJJlEHqGsBV7eWCheFDBIfx1kB0q/DbVj2TkFe1sCl0QAH5pfkbGqP4mLYUEV7JYoIzUCOOnvWue45JpEz8Ii9ABI=
X-Received: by 2002:a67:f88e:0:b0:443:6352:4651 with SMTP id
 h14-20020a67f88e000000b0044363524651mr5197739vso.22.1689573231868; Sun, 16
 Jul 2023 22:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230716194949.099592437@linuxfoundation.org>
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 17 Jul 2023 11:23:40 +0530
Message-ID: <CA+G9fYsSE1q5UiCZxP+EW_QuhMsLqBmVUoRnJqR=59S+5JFEZA@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/800] 6.4.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 17 Jul 2023 at 01:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 800 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Following kernel warnings / BUG noticed on qemu-arm64 while running
Kunit / KASAN tests while booting stable rc 6.4 kernel.

Similar issues have been reported on Linux next [1].
 next: qemu-arm64: kernel BUG at fs/inode.c:1763!
[1] https://lore.kernel.org/linux-mm/5d48dd9a-1822-4917-a77e-193a48ed3bd8@kili.mountain/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Crash log:
---

<6>[  928.522368] ok 67 Encryption test suite # SKIP
<6>[  928.526361]     KTAP version 1
<6>[  928.527663]     # Subtest: Handshake API tests
<6>[  928.528569]     1..11
<6>[  928.529461]         KTAP version 1
<6>[  928.530289]         # Subtest: req_alloc API fuzzing
<6>[  928.534580]         ok 1 handshake_req_alloc NULL proto
<6>[  928.540928]         ok 2 handshake_req_alloc CLASS_NONE
<6>[  928.546026]         ok 3 handshake_req_alloc CLASS_MAX
<6>[  928.556181]         ok 4 handshake_req_alloc no callbacks
<6>[  928.561854]         ok 5 handshake_req_alloc no done callback
<6>[  928.568591]         ok 6 handshake_req_alloc excessive privsize
<6>[  928.574197]         ok 7 handshake_req_alloc all good
<6>[  928.577290]     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
<6>[  928.578830]     ok 1 req_alloc API fuzzing
<6>[  928.589194]     ok 2 req_submit NULL req arg
<6>[  928.595860]     ok 3 req_submit NULL sock arg
<6>[  928.601760]     ok 4 req_submit NULL sock->file
<6>[  928.613613]     ok 5 req_lookup works
<6>[  928.621095]     ok 6 req_submit max pending
<6>[  928.627492]     ok 7 req_submit multiple
<6>[  928.633124]     ok 8 req_cancel before accept
<6>[  928.640751]     ok 9 req_cancel after accept
<6>[  928.646414]     ok 10 req_cancel after done
<4>[  928.650411] ------------[ cut here ]------------
<2>[  928.654074] kernel BUG at fs/inode.c:1805!
<0>[  928.655661] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
<4>[  928.657205] Modules linked in:
<4>[  928.659307] CPU: 1 PID: 21 Comm: kworker/1:0 Tainted: G
       N 6.4.4-rc1 #1
<4>[  928.660829] Hardware name: linux,dummy-virt (DT)
<4>[  928.662415] Workqueue: events delayed_fput
<4>[  928.664806] pstate: 42400005 (nZcv daif +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[  928.666592] pc : iput+0x2cc/0x2d0
<4>[  928.667870] lr : iput+0x30/0x2d0
<4>[  928.668975] sp : ffff8000081d7af0
<4>[  928.669951] x29: ffff8000081d7af0 x28: ffff0000c094c020 x27:
00000000002e0003
<4>[  928.672194] x26: ffff0000c4f61668 x25: ffff0000c6911590 x24:
0000000000000000
<4>[  928.674232] x23: ffff0000c0467638 x22: ffff0000c69115b0 x21:
ffff0000c0467598
<4>[  928.676413] x20: ffff0000c0467500 x19: ffff0000c0467500 x18:
0000000010992f9a
<4>[  928.678485] x17: ffffa2bb7d60bc64 x16: ffffa2bb7d60c00c x15:
ffffa2bb7e7c02f4
<4>[  928.680443] x14: ffffa2bb7d63c708 x13: ffffa2bb7d216100 x12:
0000000000000001
<4>[  928.682505] x11: 1fffe0001808ceb1 x10: 1fffe0001808ceb3 x9 :
0000000000000000
<4>[  928.684647] x8 : 0000000000000060 x7 : 0000000000000000 x6 :
ffffa2bb7d5c67b8
<4>[  928.686630] x5 : ffff0000c814a6d8 x4 : 0000000000000000 x3 :
ffffa2bb7ead2fec
<4>[  928.689091] x2 : 0000000000000001 x1 : 0000000000000001 x0 :
ffff0000c0467598
<6>[  928.690005]     ok 11 req_destroy works
<4>[  928.690476]
<6>[  928.693528] # Handshake API tests: pass:11 fail:0 skip:0 total:11
<4>[  928.694200] Call trace:
<4>[  928.694404]  iput+0x2cc/0x2d0
<6>[  928.697513] # Totals: pass:17 fail:0 skip:0 total:17
<4>[  928.697467]  dentry_unlink_inode+0x220/0x240
<6>[  928.698341] ok 68 Handshake API tests
<4>[  928.699216]  __dentry_kill+0x190/0x2a4
<4>[  928.702948]  dentry_kill+0x90/0x150
<4>[  928.704551]  dput+0xd8/0x144
<4>[  928.706425]  __fput+0x2bc/0x3cc
<4>[  928.707982]  delayed_fput+0x54/0x6c
<4>[  928.709490]  process_one_work+0x3c4/0x574
<4>[  928.711092]  worker_thread+0x488/0x83c
<4>[  928.712551]  kthread+0x1ac/0x238
<4>[  928.714034]  ret_from_fork+0x10/0x20
<0>[  928.717103] Code: 94522f0a 17ffffec d4210000 17ffffba (d4210000)
<4>[  928.719393] ---[ end trace 0000000000000000 ]---
<6>[  928.721045] note: kworker/1:0[21] exited with irqs disabled
<6>[  928.725022] note: kworker/1:0[21] exited with preempt_count 1
<6>[  928.730067] uart-pl011 9000000.pl011: no DMA platform data
<4>[  928.733763] ------------[ cut here ]------------
<4>[  928.735164] WARNING: CPU: 1 PID: 0 at
kernel/context_tracking.c:128 ct_kernel_exit+0xa4/0xac
<4>[  928.737209] Modules linked in:
<4>[  928.738504] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
    N 6.4.4-rc1 #1
<4>[  928.740310] Hardware name: linux,dummy-virt (DT)
<4>[  928.741569] pstate: 224003c5 (nzCv DAIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[  928.743556] pc : ct_kernel_exit+0xa4/0xac
<4>[  928.745560] lr : ct_kernel_exit+0x14/0xac
<4>[  928.747498] sp : ffff800008187db0
<4>[  928.749156] x29: ffff800008187db0 x28: ffffa2bb7ff5cb38 x27:
ffffa2bb7ffdd000
<4>[  928.751416] x26: 0000000000000002 x25: 0000000000000001 x24:
0000000000000000
<4>[  928.753426] x23: 0000000000000000 x22: 0000000000000000 x21:
ffffa2bb7ffddb50
<4>[  928.755520] x20: ffffa2bb7ffdda40 x19: ffff0000daea6a20 x18:
0000000010992f9a
<4>[  928.757619] x17: 0000000000000000 x16: 0000000100000000 x15:
0000000200000002
<4>[  928.759766] x14: 00000000ffffa2bb x13: 00000000000711d6 x12:
0000000008000000
<4>[  928.761789] x11: 000db58580000000 x10: 4000000000000000 x9 :
4000000000000002
<4>[  928.763942] x8 : ffffa2bb7ff5aa20 x7 : 0000000000000000 x6 :
000000000000003f
<4>[  928.766237] x5 : 0000000000000040 x4 : 0000000000000000 x3 :
ffffa2bb7d316f00
<4>[  928.768327] x2 : 0000000000000001 x1 : 0000000000000001 x0 :
ffff5d455af4c000
<4>[  928.770366] Call trace:
<4>[  928.771153]  ct_kernel_exit+0xa4/0xac
<4>[  928.772308]  ct_idle_enter+0x10/0x1c
<4>[  928.773463]  default_idle_call+0x1c/0x38
<4>[  928.774700]  do_idle+0x134/0x2fc
<4>[  928.775976]  cpu_startup_entry+0x24/0x28
<4>[  928.777255]  secondary_start_kernel+0x170/0x194
<4>[  928.778638]  __secondary_switched+0xb8/0xbc
<4>[  928.780012] ---[ end trace 0000000000000000 ]---
<6>[  928.888117] EXT4-fs (vda): mounted filesystem
488f3595-af73-4163-86f5-9256efc01ed6 ro with ordered data mode. Quota
mode: none.


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.3-801-g2b7c5a626789/testrun/18368775/suite/boot/test/clang-nightly-defconfig-40bc7ee5/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.3-801-g2b7c5a626789/testrun/18368340/suite/boot/test/gcc-12-defconfig-40bc7ee5/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.3-801-g2b7c5a626789/testrun/18374719/suite/boot/test/gcc-12-lkftconfig-kunit/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2SfVz5dCm2BdJzRORqOHFcy7nOK/


--
Linaro LKFT
https://lkft.linaro.org
