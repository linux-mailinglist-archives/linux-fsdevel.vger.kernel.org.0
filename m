Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC76C9B4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 08:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjC0GRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 02:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjC0GRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:17:36 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AD84218
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 23:17:34 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id i22so5471458uat.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 23:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679897853;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XdgBfpjOOksSTNgNPHcd3A0LovIuXeaveYNJpMFhIog=;
        b=WWOdkC+q32XzlvPfrjQA8hnveCcw/77L8hUJZRgoudm0BUKtUdY6eVtNuY0Imw7Q/A
         V/RwyTSlD65X+d34kGH/sMAEErqtIITg4BGD0CI1uyIiskfkH0AoIlMyMEUFyTP9ccyp
         b0J83Bbc5ddkKZYQLcrR5iNIJTN/kxeSW7qAVPLusQ3YiVY1bufHlcCH1vT5KeZjQUwi
         uq/jmG94mrJ5ubLJZ7wBmrj123FkQGN256Vj4AfgeQiKmVpNlKqW79f1XqtYkidf1QSN
         6uVf42sSaBztgTUp65GjIpb2dLtePnWDZt5yvxE1LbGWtq9RYyDc7GZ4aIkK0hf71qA5
         WYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679897853;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdgBfpjOOksSTNgNPHcd3A0LovIuXeaveYNJpMFhIog=;
        b=W3kxtSkWcjzC1cYuIgAx4MVAblA8L+arlRMOYsEHDfNLJtxNOE5mTp8P53QDAPaPgf
         04zBWpkUbJahgoWi8iy3yuVGODG3guITDUBXEHV6qdX2j8yHGxbuk5jgbOGNb6UCWH5p
         sjBvhVN9e+/WvpqlcsvkEX4NpTsEVMUPhfeVfbWs1jLLuRHsMSErfM/zDG9HoCQUu5DD
         Ne5v3SvJcYZrLzo6yuRc2ceV0gNwO9p8psaqPNrf6B1OYG1/d61SnXxpg66/FhU6bXNn
         ee5oJITKaNUOQ7iEDrplpI8AUfGMJkxAAH9FciHmBEYIFaMKUk0irPQaGiT11R1YP0mA
         339g==
X-Gm-Message-State: AAQBX9fLI9lAWz5LKn1S09wxr6l5TLd4YNPlG3TeaJom3O/TvHcR7RFE
        7cNBEJXvAqmDWsUujFot4OJvUfUUtpXZ1LgyLu5+4A==
X-Google-Smtp-Source: AKy350a9KZxFFbpmphNB/f01g/2/z26hmGP+EJfyAiJE9qOb9rZbwV1GUHBDKWx7e4QuNPpnT2IDcqb0gx0TisbVyy4=
X-Received: by 2002:a1f:9cd3:0:b0:435:b6ce:23e7 with SMTP id
 f202-20020a1f9cd3000000b00435b6ce23e7mr5826726vke.0.1679897853537; Sun, 26
 Mar 2023 23:17:33 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 27 Mar 2023 11:47:22 +0530
Message-ID: <CA+G9fYs1ytc7B2ffLpYCqscwVTZ2vb7aAV0cEc-s+2QS1g3hyA@mail.gmail.com>
Subject: next: x86: RIP: 0010:do_iter_read+0x241/0x340 - BUG: unable to handle
 page fault for address: 000000000042da60
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        lkft-triage@lists.linaro.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Following LTP syscalls test cases on arm64 FVP, x86_64 and i386.

Regressions found on i386 x86 and fvp-aemva:

 - ltp-syscalls/preadv202_64
 - ltp-syscalls/process_vm_writev01
 - ltp-syscalls/pwritev02
 - ltp-syscalls/pwritev02_64
 - ltp-syscalls/preadv02_64
 - ltp-syscalls/preadv202
 - ltp-syscalls/recvmsg01
 - ltp-syscalls/preadv02
 - ltp-syscalls/process_vm_readv01
 - ltp-syscalls/readv02


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

test crash log:
--------------
[  606.816186] BUG: unable to handle page fault for address: 000000000042da60
[  606.824151] #PF: supervisor read access in kernel mode
[  606.829296] #PF: error_code(0x0001) - permissions violation
[  606.834869] PGD 80000001373fb067 P4D 80000001373fb067 PUD 113a7b067
PMD 1085d5067 PTE 8000000119372067
[  606.844200] Oops: 0001 [#3] PREEMPT SMP KASAN PTI
[  606.848908] CPU: 2 PID: 100812 Comm: preadv202 Tainted: G    B D W
        6.3.0-rc3-next-20230327 #1
[  606.858206] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[  606.865599] RIP: 0010:do_iter_read+0x241/0x340
[  606.870054] Code: 00 00 00 48 8b 7d a8 e8 4d af fb ff 48 8b 45 d0
4c 8b 78 28 48 8b 7d 98 e8 3c af fb ff 49 8b 5c 24 18 48 89 df e8 2f
af fb ff <48> 8b 03 48 8b 7d a0 48 89 45 c0 e8 1f af fb ff 48 8d 7b 08
4d 8b
[  606.888807] RSP: 0018:ffff8881080b7c38 EFLAGS: 00010286
[  606.894034] RAX: 0000000000000000 RBX: 000000000042da60 RCX: ffffffff87a89ce1
[  606.901174] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 000000000042da60
[  606.908333] RBP: ffff8881080b7cb0 R08: 0000000000000000 R09: ffff888101adf457
[  606.915466] R10: ffffed102035be8a R11: 0000000000000001 R12: ffff8881080b7d10
[  606.922607] R13: 0000000000000000 R14: 0000000000000040 R15: ffffffff8955a380
[  606.929739] FS:  00007f7d8b9a6740(0000) GS:ffff888230900000(0000)
knlGS:0000000000000000
[  606.937834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  606.943589] CR2: 000000000042da60 CR3: 00000001139a0006 CR4: 00000000003706e0
[  606.950730] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  606.957861] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  606.964995] Call Trace:
[  606.967447]  <TASK>
[  606.969558]  vfs_readv+0xce/0x140
[  606.972882]  ? __pfx_vfs_readv+0x10/0x10
[  606.976817]  ? do_send_sig_info+0x9d/0xd0
[  606.980839]  ? preempt_count_sub+0x50/0x80
[  606.984945]  ? _raw_spin_unlock_irqrestore+0x37/0x60
[  606.989919]  ? do_send_sig_info+0x9d/0xd0
[  606.993941]  ? __rcu_read_unlock+0x3b/0x80
[  606.998050]  ? __kasan_check_read+0x15/0x20
[  607.002245]  ? __fget_light+0x1d0/0x210
[  607.006091]  ? kill_something_info+0x1d3/0x200
[  607.010538]  do_preadv+0x132/0x190
[  607.013952]  ? __pfx_do_preadv+0x10/0x10
[  607.017880]  __x64_sys_preadv2+0x71/0xa0
[  607.021815]  do_syscall_64+0x3c/0x90
[  607.025401]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  607.030461] RIP: 0033:0x7f7d8baaac8c
[  607.034051] Code: 49 89 cc 55 89 fd 53 44 89 c3 48 83 ec 18 64 8b
04 25 18 00 00 00 85 c0 75 7c 45 89 c1 49 89 ca 45 31 c0 b8 47 01 00
00 0f 05 <48> 3d 00 f0 ff ff 0f 87 c8 00 00 00 48 85 c0 79 49 48 8b 0d
5c e1
[  607.052804] RSP: 002b:00007ffdd4ce73c0 EFLAGS: 00000246 ORIG_RAX:
0000000000000147
[  607.060380] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7d8baaac8c
[  607.067520] RDX: 0000000000000001 RSI: 000000000042d670 RDI: 0000000000000005
[  607.074660] RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
[  607.081795] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  607.088934] R13: 000000000042d670 R14: 0000000000000000 R15: 0000000000000001
[  607.096070]  </TASK>
[  607.098261] Modules linked in: tun x86_pkg_temp_thermal
[  607.103495] CR2: 000000000042da60
[  607.106815] ---[ end trace 0000000000000000 ]---
[  607.111442] RIP: 0010:do_iter_read+0x241/0x340
[  607.115897] Code: 00 00 00 48 8b 7d a8 e8 4d af fb ff 48 8b 45 d0
4c 8b 78 28 48 8b 7d 98 e8 3c af fb ff 49 8b 5c 24 18 48 89 df e8 2f
af fb ff <48> 8b 03 48 8b 7d a0 48 89 45 c0 e8 1f af fb ff 48 8d 7b 08
4d 8b
[  607.134652] RSP: 0018:ffff88810713fc78 EFLAGS: 00010286
[  607.139885] RAX: 0000000000000001 RBX: 000000000042da60 RCX: ffffffff876b219e
[  607.147026] RDX: fffffbfff1665005 RSI: 0000000000000008 RDI: ffffffff8b328020
[  607.154191] RBP: ffff88810713fcf0 R08: 0000000000000001 R09: ffffffff8b328027
[  607.161325] R10: fffffbfff1665004 R11: 0000000000000001 R12: ffff88810713fd50
[  607.168459] R13: 0000000000000000 R14: 0000000000000040 R15: ffffffff8955a380
[  607.175593] FS:  00007f7d8b9a6740(0000) GS:ffff888230900000(0000)
knlGS:0000000000000000
[  607.183686] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  607.189432] CR2: 000000000042da60 CR3: 00000001139a0006 CR4: 00000000003706e0
[  607.196572] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  607.203706] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  607.210840] note: preadv202[100812] exited with irqs disabled
adv2() read 32 bytes with content 'b' expectedly
preadv201.c:90: TPASS: preadv2() read 64 bytes with content 'a' expectedly
preadv201.c:90: TPASS: preadv2() read 64 bytes with content 'a' expectedly
preadv201.c:90: TPASS: preadv2() read 64 bytes with co[  607.237557]
BUG: unable to handle page fault for address: 000000000042da60
[  607.245714] #PF: supervisor read access in kernel mode
[  607.250859] #PF: error_code(0x0001) - permissions violation
[  607.256431] PGD 8000000100dde067 P4D 8000000100dde067 PUD 10c184067
PMD 137231067 PTE 8000000116a0d067
[  607.265758] Oops: 0001 [#4] PREEMPT SMP KASAN PTI
[  607.270501] CPU: 0 PID: 100814 Comm: preadv202_64 Tainted: G    B D
W          6.3.0-rc3-next-20230327 #1
[  607.280094] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[  607.287519] RIP: 0010:do_iter_read+0x241/0x340
[  607.292000] Code: 00 00 00 48 8b 7d a8 e8 4d af fb ff 48 8b 45 d0
4c 8b 78 28 48 8b 7d 98 e8 3c af fb ff 49 8b 5c 24 18 48 89 df e8 2f
af fb ff <48> 8b 03 48 8b 7d a0 48 89 45 c0 e8 1f af fb ff 48 8d 7b 08
4d 8b
[  607.310781] RSP: 0018:ffff88810aabfc38 EFLAGS: 00010286
[  607.316042] RAX: 0000000000000000 RBX: 000000000042da60 RCX: ffffffff87a89ce1
[  607.323206] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 000000000042da60
[  607.330366] RBP: ffff88810aabfcb0 R08: 0000000000000000 R09: ffff888101adf457
[  607.337525] R10: ffffed102035be8a R11: 0000000000000001 R12: ffff88810aabfd10
[  607.344692] R13: 0000000000000000 R14: 0000000000000040 R15: ffffffff8955a380
[  607.351850] FS:  00007f3989bcd740(0000) GS:ffff888230800000(0000)
knlGS:0000000000000000
[  607.359973] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  607.365752] CR2: 000000000042da60 CR3: 0000000111308001 CR4: 00000000003706f0
[  607.372919] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  607.380079] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  607.387238] Call Trace:
[  607.389714]  <TASK>
[  607.391824]  vfs_readv+0xce/0x140
[  607.395174]  ? __pfx_vfs_readv+0x10/0x10
[  607.399172]  ? do_send_sig_info+0x9d/0xd0
[  607.403237]  ? preempt_count_sub+0x50/0x80
[  607.407368]  ? _raw_spin_unlock_irqrestore+0x37/0x60
[  607.412371]  ? do_send_sig_info+0x9d/0xd0
[  607.416426]  ? __rcu_read_unlock+0x3b/0x80
[  607.420560]  ? __kasan_check_read+0x15/0x20
[  607.424780]  ? __fget_light+0x1d0/0x210
[  607.428618]  ? kill_something_info+0x1d3/0x200
[  607.433102]  do_preadv+0x132/0x190
[  607.436533]  ? __pfx_do_preadv+0x10/0x10
[  607.440485]  __x64_sys_preadv2+0x71/0xa0
[  607.444444]  do_syscall_64+0x3c/0x90
[  607.448032]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  607.453112] RIP: 0033:0x7f3989cd1c8c
[  607.456700] Code: 49 89 cc 55 89 fd 53 44 89 c3 48 83 ec 18 64 8b
04 25 18 00 00 00 85 c0 75 7c 45 89 c1 49 89 ca 45 31 c0 b8 47 01 00
00 0f 05 <48> 3d 00 f0 ff ff 0f 87 c8 00 00 00 48 85 c0 79 49 48 8b 0d
5c e1
[  607.475479] RSP: 002b:00007ffdfa87c790 EFLAGS: 00000246 ORIG_RAX:
0000000000000147
[  607.483054] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3989cd1c8c
[  607.490195] RDX: 0000000000000001 RSI: 000000000042d670 RDI: 0000000000000005
[  607.497397] RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
[  607.504562] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  607.511723] R13: 000000000042d670 R14: 0000000000000000 R15: 0000000000000001
[  607.518884]  </TASK>
[  607.521107] Modules linked in: tun x86_pkg_temp_thermal
[  607.526396] CR2: 000000000042da60
[  607.529742] ---[ end trace 0000000000000000 ]---
[  607.534394] RIP: 0010:do_iter_read+0x241/0x340
[  607.538876] Code: 00 00 00 48 8b 7d a8 e8 4d af fb ff 48 8b 45 d0
4c 8b 78 28 48 8b 7d 98 e8 3c af fb ff 49 8b 5c 24 18 48 89 df e8 2f
af fb ff <48> 8b 03 48 8b 7d a0 48 89 45 c0 e8 1f af fb ff 48 8d 7b 08
4d 8b
[  607.557656] RSP: 0018:ffff88810713fc78 EFLAGS: 00010286
[  607.562915] RAX: 0000000000000001 RBX: 000000000042da60 RCX: ffffffff876b219e
[  607.570082] RDX: fffffbfff1665005 RSI: 0000000000000008 RDI: ffffffff8b328020
[  607.577250] RBP: ffff88810713fcf0 R08: 0000000000000001 R09: ffffffff8b328027
[  607.584418] R10: fffffbfff1665004 R11: 0000000000000001 R12: ffff88810713fd50
[  607.591576] R13: 0000000000000000 R14: 0000000000000040 R15: ffffffff8955a380
[  607.598733] FS:  00007f3989bcd740(0000) GS:ffff888230800000(0000)
knlGS:0000000000000000
[  607.606847] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  607.612602] CR2: 000000000042da60 CR3: 0000000111308001 CR4: 00000000003706f0
[  607.619766] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  607.626928] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  607.634095] note: preadv202_64[100814] exited with irqs disabled


Test log links,
---------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230327/testrun/15902655/suite/
- ltp-syscalls/test/preadv202/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230327/testrun/15899127/suite/
- ltp-syscalls/test/preadv202/history/

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 011eb7443621f49ca1e8cdf9c74c215f25019118
  git_describe: next-20230327
  kernel_version: 6.3.0-rc3
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2NZpQvNrdOzi9UUukh8f6b4TmOv/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/818444740
  artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2NZpQvNrdOzi9UUukh8f6b4TmOv
  toolchain: gcc-11



--
Linaro LKFT
https://lkft.linaro.org
