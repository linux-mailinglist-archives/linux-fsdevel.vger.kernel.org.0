Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3173A586D95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiHAPU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiHAPUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:20:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5166564C7;
        Mon,  1 Aug 2022 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659367217;
        bh=pmPjh/lA87Z5W2nyaW7ihvFXNYv9bkrPbRGc5PPQH8A=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=lE549N2gSiLnnfNA1wunzQTZ+ah4tpEP5Bky62c5DTnXldiU1lPMBHJrBwe3+9Qnu
         J5RxSVvWxIULnM47pbVjyQ5x7+9wS4ZGdM31tFENgA3SCUZ3OFBhf4EfpqK84u9ISp
         RF+X9JScAdU/5u1cu9wPuwY0+39At0MaOJZFm5AI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.150.19]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McYCl-1nk0kP3d8P-00d1GX; Mon, 01
 Aug 2022 17:20:16 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Dump command line of faulting process to syslog
Date:   Mon,  1 Aug 2022 17:20:13 +0200
Message-Id: <20220801152016.36498-1-deller@gmx.de>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W8hcioovE+Z+4+5r9LvNT3xnxYPDcNyVIT36mxBOBAsVYnianR1
 Fk0uyBo+lIsSbJ/nZIXitqJA1/uzvLwohmND4IIR7ZWkVtOugqDY0npB7Dnkx+e/nAS0Fp8
 k1Hfd6gXQglgB2oTxS83+hzgwJEHFCC+fOLLODfL84+hBXHNLAtD5moH83E/9ukNtflxtjF
 bphXKtzcRjuE9otnQSFWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Oq5XVvyQtI=:QCeDmdf+soI5wZ/NjoG3tL
 OEWeTxDe5F0McjEZSPiLyG2dbFOr/wIeNlbJpB24bAi4kPMl1jqhnEWALm48vaYp1Q7t7NvIw
 nd8zS4fO7GYDTWSEbx/pligOafIk+tcGJ4Kwx5eRlkO4VwqK6OttsfzOrD7ZHpMvteGCcvaAd
 bdf35qmgowe0LpIPpfsVolhHl0AspewS6RBAY0R38GmVe9xhJ/L4Vv5FyY/hYTwv7S0LcIJ3N
 x673oHs1Cr0y/oSrC/+zS5DLzo3qztivG40vur3UHxTN7rCSrV8f+iVaNmGXyRt4p/F3K9Qlp
 I1n5/s+rs5vSbWXc0k7twGmtoflnud5YhO7PF2eA2OldYpMus6LH8xa2wYPLzMATZI9sQmX1k
 8/RSGTzLv2Q2HOrG4gAdWL4O/iUqHuNz5btRBa11rzU3pd1rLfROt0RdZ9+JESZdI5/tbh6aJ
 woB/lYFsAzZWpgvT3Kft19m8amaNLWoa7Hy5s+IZ7kRLSMwgwI2y0oK1A1RHHnrM/USl9n3bP
 1hHvAZFpJbh95ytPkzpZFOMrPg+g5XlTfUvHBVBn7796m8lHELmDy8S9MtY1UiyCj+KaHr2LC
 cwGC5HbpDbW823pjTv9uooQ6sOO70J9W06SqSQS4P08Mllq52Pg78rMxdxf3wSPEALNgD76jt
 Z2OnIKsyT92n4eStQSgpIgOdAzWXnl6m5q3/IDm1v2qiT4rj6To4EFqjnYs4kuelMaSISNhNu
 YlP8yf3DQ+nYNdb4RfWK5N5RVir/EvsJ1uZMIHjy+HHIAlf1NjeT6wNgAI/Uw6YZb3HTdm4t1
 2NYtLBGhH2jRA8vChuUxmnrpyqj4GbNmbzUjzTa3iDhzqQtg1piHjjqrFc63maGdKMJa31pxH
 pKhZZGyihhCnYBVKuGu7kQt8D6iNLyOKNi/8bIWWE5/IwjJtLQJCvRf2nfi8l5yKRkMMtSRUL
 3Vv+WyLKDZ2iFFf6WisdHeAN48jPPbzIJDMWd7Ya/OoXDxkCdfY1prFycUxLNp+F/7BngSeZp
 uQRr7JidIoxduuLgNmwPrp6DV88i+33vY0sZbHZkE7VWkJKEJSK+chpf/alnwAn73VwK+tq9j
 Q/JF/neJOyTw1m2WGCgDHzYR9v29Cpd56toBn5g5ayRE6VlcXXlD9RD6g==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series allows the arch-specific kernel fault handlers to dump
in addition to the typical info (IP address, fault type, backtrace and so =
on)
the command line of the faulting process.

The motivation for this patch is that it's sometimes quite hard to find ou=
t and
annoying to not know which program *exactly* faulted when looking at the s=
yslog.

Some examples from the syslog are:

On parisc:
   do_page_fault() command=3D'cc1' type=3D15 address=3D0x00000000 in libc-=
2.33.so[f6abb000+184000]
   CPU: 1 PID: 13472 Comm: cc1 Tainted: G            E     5.10.133+ #45
   Hardware name: 9000/785/C8000

-> We see the "cc1" compiler crashed, but it would be useful to know which=
 file was compiled.

With this patch series, the kernel now prints in addition:
   cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 -quiet @/tmp/ccR=
kFSfY -imultilib . -imultiarch hppa-linux-gnu -D USE_MINIINTERPRETER -D NO=
_REGS -D _HPUX_SOURCE -D NOSMP -D THREADED_RTS -include /build/ghc/ghc-9.0=
.2/includes/dist-install/build/ghcversion.h -iquote compiler/GHC/Iface -qu=
iet -dumpdir /tmp/ghc13413_0/ -dumpbase ghc_5.hc -dumpbase-ext .hc -O -Wim=
plicit -fno-PIC -fwrapv -fno-builtin -fno-strict-aliasing -o /tmp/ghc13413=
_0/ghc_5.s

-> now we know that cc1 crashed while compiling some haskell code.

Another parisc example:
   do_page_fault() command=3D'ld.so.1' type=3D15 address=3D0x565921d8 in l=
ibc.so[f7339000+1bb000]
   CPU: 1 PID: 1151 Comm: cc1 Tainted: G            E     5.10.133+ #45
   Hardware name: 9000/785/C8000

-> apparently here a program from the glibc testsuite segfaulted.

With this patch we now additionally get:
   ld.so.1[1151] cmdline: /home/gnu/glibc/objdir/elf/ld.so.1 --library-pat=
h /home/gnu/glibc/objdir:/home/gnu/glibc/objdir/math:/home/gnu/
        /home/gnu/glibc/objdir/malloc/tst-safe-linking-malloc-hugetlb1

-> it was the tst-safe-linking-malloc-hugetlb1 testcase which faulted.

An example of a typical x86 fault shows up as:
   crash[2326]: segfault at 0 ip 0000561a7969c12e sp 00007ffe97a05630 erro=
r 6 in crash[561a7969c000+1000]
   Code: 68 ff ff ff c6 05 19 2f 00 00 01 5d c3 0f 1f 80 00 00 00 00 c3 0f=
 1f 80 00 00 00 00 e9 7b ff ff ff 55 48 89 e5 b8 00 00 00 00 <c7> 00 01 00=
 00 00 b8 00 00 00 00 5d c3 0f 1f 44 00 00 41 57 4c 8d

-> with this patch we now will see the whole command line:
   crash[2326] cmdline: ./crash test_write_to_page_0

The patches are relatively small, and reuses functions which are used
to create the output for the /proc/<pid>/cmdline files.

This is the version 1 of the patch series.
I'm interested if people find this useful too, and if so, I'm
happy for any feedback on those patches.

Thanks!
Helge

Helge Deller (3):
  proc: Add get_task_cmdline_kernel() function
  lib/dump_stack: Add dump_stack_print_cmdline() and wire up in
    dump_stack_print_info()
  x86/fault: Dump command line of faulting process to syslog

 arch/x86/mm/fault.c     |  2 ++
 fs/proc/base.c          | 68 +++++++++++++++++++++++++++--------------
 include/linux/printk.h  |  5 +++
 include/linux/proc_fs.h |  5 +++
 lib/dump_stack.c        | 17 +++++++++++
 5 files changed, 74 insertions(+), 23 deletions(-)

=2D-
2.37.1

