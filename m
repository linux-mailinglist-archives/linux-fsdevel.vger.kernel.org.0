Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7F33C888F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhGNQZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhGNQZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626279762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oLqGODqKuzoiI61BizAG+5GlJB1wI5HyMpgzIXPtLhs=;
        b=J1B1AwlhRRBTNfPp8luPAYg53E5HxDVgpY6+4usb6Fqs4mezZGBKGc5jBJbBmSyKRAXubR
        AOLtWN24y3VCs2+RMCLI7NdfT3mNiAiRLKhFn4zrijypF9wVPyewYMo899ENmBgXUTUjIQ
        T33OvCkFBNY0EGQ9GQQyBQDiV2xlmng=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-IitFh_BjNESSzxWN6lkiSA-1; Wed, 14 Jul 2021 12:22:41 -0400
X-MC-Unique: IitFh_BjNESSzxWN6lkiSA-1
Received: by mail-pg1-f197.google.com with SMTP id u190-20020a6379c70000b029022ceb8c8831so492099pgc.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 09:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLqGODqKuzoiI61BizAG+5GlJB1wI5HyMpgzIXPtLhs=;
        b=IQufqJqwOGHxkma2iepgjyK1+hliS6Hy/4r1BUdCdGonT7pWvjCFrWGP0q9tQn9vZ2
         usyR4INqr5DPN3xgyDXpVUeRh/dVVn9mfTnaMUeRU5orzq2/IP1aHpiyyM8A/waNPciJ
         weErgFqknBB8Is3+Ibj/Q/BhBCFvQDAtSUUTqn2T+2sdkZBqnVfpNrn60NLKxUiIAn7d
         PzlwiuSefdCpwfT7u4SW3PziEeGl3J9XPz+3bKFUlV2bJ+bpM6aCZkYgtD8FKOqdG8OJ
         6jGuhp9F9uwWBoaLBWUip3a2k4FoTmshOD/g+Jc3WMIte+SOlJ8rWV2rnedBLK/Mb9ro
         lfyg==
X-Gm-Message-State: AOAM533HnsrY51i+BHPuMqdRVLmhrumoxXEKCxlwtGaKuOqKDpwaqBN4
        ZGWIrMAGUJozgoQusfvJk2tXjaKSbxP0j3ShFvF1AQbM56DQhNEVSh4aNGbmhFQmTTgDcN0e/MK
        rrtSu0yvJPbDPFMfAlBO12f/TpzJ6xnmIfuxeWQDDlg==
X-Received: by 2002:aa7:810b:0:b029:2fe:decd:c044 with SMTP id b11-20020aa7810b0000b02902fedecdc044mr10849488pfi.15.1626279760183;
        Wed, 14 Jul 2021 09:22:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrt7doYkiVPjqmf9/NUldd9k267ZW03LHK48ffy6XpvnP7EaOGju6v+lvA1rPA7UdQg/NDUWuiGGQDDJ22ofA=
X-Received: by 2002:aa7:810b:0:b029:2fe:decd:c044 with SMTP id
 b11-20020aa7810b0000b02902fedecdc044mr10849457pfi.15.1626279759815; Wed, 14
 Jul 2021 09:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com> <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz>
In-Reply-To: <20210714092639.GB9457@quack2.suse.cz>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 15 Jul 2021 00:22:28 +0800
Message-ID: <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
To:     Jan Kara <jack@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On Wed, Jul 14, 2021 at 5:26 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 14-07-21 16:44:33, Boyang Xue wrote:
> > Hi Roman,
> >
> > On Wed, Jul 14, 2021 at 12:12 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Wed, Jul 14, 2021 at 11:21:12AM +0800, Boyang Xue wrote:
> > > > Hello,
> > > >
> > > > I'm not sure if this is the right place to report this bug, please
> > > > correct me if I'm wrong.
> > > >
> > > > I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
> > > > running xfstests generic/256 on ext4 [1]. Looking at the call trace,
> > > > it looks like the bug had been introduced by the commit
> > > >
> > > > c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes
> > > >
> > > > It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing
> > > > was performed with the latest xfstests, and the bug can be reproduced
> > > > on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.
> > >
> > > Hello Boyang,
> > >
> > > thank you for the report!
> > >
> > > Do you know on which line the oops happens?
> >
> > I was trying to inspect the vmcore with crash utility, but
> > unfortunately it doesn't work.
>
> Thanks for report!  Have you tried addr2line utility? Looking at the oops I
> can see:

Thanks for the tips!

It's unclear to me that where to find the required address in the
addr2line command line, i.e.

addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
<what address here?>

But I have tried gdb like this,

# gdb /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
GNU gdb (GDB) Red Hat Enterprise Linux 10.1-14.el9
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "aarch64-redhat-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from
/usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux...
(gdb) list *(cleanup_offline_cgwbs_workfn+0x320)
0xffff8000102d6ddc is in cleanup_offline_cgwbs_workfn
(./arch/arm64/include/asm/jump_label.h:38).
33      }
34
35      static __always_inline bool arch_static_branch_jump(struct
static_key *key,
36                                                          bool branch)
37      {
38              asm_volatile_goto(
39                      "1:     b               %l[l_yes]               \n\t"
40                       "      .pushsection    __jump_table, \"aw\"    \n\t"
41                       "      .align          3                       \n\t"
42                       "      .long           1b - ., %l[l_yes] - .   \n\t"
(gdb)

I'm not sure is it meaningful?

>
> [ 4371.307867] pc : cleanup_offline_cgwbs_workfn+0x320/0x394
>
> Which means there's probably heavy inlining going on (do you use LTO by
> any chance?) because I don't think cleanup_offline_cgwbs_workfn() itself
> would compile into ~1k of code (but I don't have much experience with
> aarch64). Anyway, add2line should tell us.

Actually I built the kernel on an internal build service, so I don't
know much of the build details, like LTO.

>
> Also pasting oops into scripts/decodecode on aarch64 machine should tell
> us more about where and why the kernel crashed.

The output is:

# echo "Code: d63f0020 97f99963 17ffffa6 f8588263 (f9400061)" |
/usr/src/kernels/5.14.0-0.rc1.15.bx.el9.aarch64/scripts/decodecode
Code: d63f0020 97f99963 17ffffa6 f8588263 (f9400061)
All code
========
   0:   d63f0020        blr     x1
   4:   97f99963        bl      0xffffffffffe66590
   8:   17ffffa6        b       0xfffffffffffffea0
   c:   f8588263        ldur    x3, [x19, #-120]
  10:*  f9400061        ldr     x1, [x3]                <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:   f9400061        ldr     x1, [x3]

>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>

Thanks,
Boyang

