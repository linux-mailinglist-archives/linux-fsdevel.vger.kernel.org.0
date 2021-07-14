Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4044F3C8099
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbhGNIrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 04:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238597AbhGNIrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626252287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PDIhQYO2pmfAw1yw1pQlYSKRZZrPG4WTDkKfh53KhyE=;
        b=infyA88DMroeL8vGLY8QgYIZip11uqWT/hQYYjLdMLH8EC4QOXEH560uCKWXPvNZ+iCHVg
        b8aEETXPwwo4g4qFZCgWyRpOlH3CcZi/muVuzkrzpoaaEcOSYf/OSu2G9Nua2EK4ZUNWsZ
        tciqc7+Rqfrr0RG2Sx76yUWgH8Qlid8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-QXFxSquFOgWs7N9nYAYC8g-1; Wed, 14 Jul 2021 04:44:46 -0400
X-MC-Unique: QXFxSquFOgWs7N9nYAYC8g-1
Received: by mail-pg1-f197.google.com with SMTP id k9-20020a63d1090000b029021091ebb84cso1038393pgg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 01:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDIhQYO2pmfAw1yw1pQlYSKRZZrPG4WTDkKfh53KhyE=;
        b=nF3cYBaPNYTkBc1sEDOeVBk87BHAwAfm3PYtWtLDvqv1Xbrn08GTw6uuFKzNwfwhW/
         HjpeaQjzba1fOrW2hZ8c17SIiH4T99cOp7olU0Zs9BJVunnOzkn61hxxa5xYeL6Vnohm
         2v79m9iLf549lHEWcL+05YRSuPko71vKoz5uw10P+tCbJ+futqehgFgISvAattNDXqcj
         /IAjs2YfRPnddp0SKib7Kn/YCia7NzvjUrzUJ9cqRZ9orFcR0TidLXHmN3WBdIuPCtUI
         +KoAUz0uBjIwVrKfcnyTY+FK0CUWoBGFxQaErFLzVu8hPRUICsP7cy0F5fUYdFKCEEjb
         0MVQ==
X-Gm-Message-State: AOAM530l11F6Nt1sUd5KaaTW54CJqK8E7RNXNJj0qjdC3ZvadjLJTZ6H
        czllMrMbv0HQDieXx/zdWNoReYsXqqsNdaQcyceMUw6Ine3qBX1Ey4lbQK6VGRnW0dkMEkiUehM
        kfLvjgcHAn571mMCk80TlM8Q+tM9vW4we5N/w7v4WRA==
X-Received: by 2002:a17:902:bf45:b029:129:8147:3a93 with SMTP id u5-20020a170902bf45b029012981473a93mr6985435pls.84.1626252284960;
        Wed, 14 Jul 2021 01:44:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz82NUK3/u4KIzP5Fbyw488whisvjCfa2Oma0+CrkKWscEaWbYqp0EY1eYk/RnoJLj7tgYsHGC96okIdGWjwP4=
X-Received: by 2002:a17:902:bf45:b029:129:8147:3a93 with SMTP id
 u5-20020a170902bf45b029012981473a93mr6985425pls.84.1626252284590; Wed, 14 Jul
 2021 01:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
In-Reply-To: <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
From:   Boyang Xue <bxue@redhat.com>
Date:   Wed, 14 Jul 2021 16:44:33 +0800
Message-ID: <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roman,

On Wed, Jul 14, 2021 at 12:12 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Jul 14, 2021 at 11:21:12AM +0800, Boyang Xue wrote:
> > Hello,
> >
> > I'm not sure if this is the right place to report this bug, please
> > correct me if I'm wrong.
> >
> > I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
> > running xfstests generic/256 on ext4 [1]. Looking at the call trace,
> > it looks like the bug had been introduced by the commit
> >
> > c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes
> >
> > It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing
> > was performed with the latest xfstests, and the bug can be reproduced
> > on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.
>
> Hello Boyang,
>
> thank you for the report!
>
> Do you know on which line the oops happens?

I was trying to inspect the vmcore with crash utility, but
unfortunately it doesn't work.

```
# crash /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux vmcore
...
crash: invalid structure member offset: task_struct_state
       FILE: task.c  LINE: 5929  FUNCTION: task_state()

     [/usr/bin/crash] error trace: aaaae238b080 => aaaae238aff0 =>
aaaae23ff4e8 => aaaae23ff440
...
```
Could you suggest other ways to know "the line the oops happens"?

> I'll try to reproduce the problem. Do you mind sharing your .config, kvm options
> and any other meaningful details?

I can't access the VM host, so sorry I can't provide the kvm
configuration for now. Please check the following other info:

xfstests local.config
```
# cat local.config
FSTYP="ext4"
TEST_DIR="/test"
TEST_DEV="/dev/vda3"
SCRATCH_MNT="/scratch"
SCRATCH_DEV="/dev/vda4"
LOGWRITES_MNT="/logwrites"
LOGWRITES_DEV="/dev/vda6"
MKFS_OPTIONS="-b 4096"
MOUNT_OPTIONS="-o rw,relatime,seclabel"
TEST_FS_MOUNT_OPTS="-o rw,relatime,seclabel"
```

# lscpu
Architecture:            aarch64
  CPU op-mode(s):        64-bit
  Byte Order:            Little Endian
CPU(s):                  4
  On-line CPU(s) list:   0-3
Vendor ID:               Cavium
  BIOS Vendor ID:        QEMU
  Model name:            ThunderX2 99xx
    BIOS Model name:     virt-rhel7.6.0
    Model:               1
    Thread(s) per core:  1
    Core(s) per cluster: 4
    Socket(s):           4
    Cluster(s):          1
    Stepping:            0x1
    BogoMIPS:            400.00
    Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32
atomics cpuid asimdrdm
NUMA:
  NUMA node(s):          1
  NUMA node0 CPU(s):     0-3
Vulnerabilities:
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Spec store bypass:     Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:            Mitigation; __user pointer sanitization
  Spectre v2:            Mitigation; Branch predictor hardening
  Srbds:                 Not affected
  Tsx async abort:       Not affected

# getconf PAGESIZE
65536

Please let me know if there's other useful info I can provide.

Thanks,
Boyang

>
> Thank you!
>
> Roman
>

