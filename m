Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87CB3C96B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhGODy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231378AbhGODy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626321123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1fOE/VG2Jpms0RzmQLl6gbrGAPQgBFskN6IIEj8J1iA=;
        b=b1hS/Mr7gAIu1LiTa2y02dxriy8Aqk2AqiABMzLun/ZHzX4AVVNJ1H5f3XyxiFddMtXIqJ
        4g8kQ37Pxz/EMBftayUvWIzyyPqVVuW1nU0UkXQr+HRpShYbSu17Curg+0C+/JJYiIy4vG
        sKbm2GslfBoeiUtroU0EB1vWhkwa6PM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-u4C7NjQ4O76FX0YHQHzIhg-1; Wed, 14 Jul 2021 23:52:02 -0400
X-MC-Unique: u4C7NjQ4O76FX0YHQHzIhg-1
Received: by mail-pj1-f72.google.com with SMTP id u12-20020a17090abb0cb029016ee12ec9a1so2526002pjr.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 20:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fOE/VG2Jpms0RzmQLl6gbrGAPQgBFskN6IIEj8J1iA=;
        b=MOqyHnGCWN9dUos+HgancspNK+agNAprrY8ZkSY4+f0lRlUm7IIZCyvyUt3IPfAwew
         BmwdckuN7Rdq+hsryC9JQKFZpvIW/MnoC34gIZlAFxuYEcJiMyUpRTjex2eA0hlri5ZE
         ojU9MZUxIu+mHkUeuig5MvLddRApXk32TmXkQrxK9zPCTd518LhiXA9JR6Nj8iyGDs/V
         dEPyLmHmnrGb4HotMM+kVoF/iqne5MRu/7gb/DvxwmSYWW8mmqwVnTKngdLJLhsc+76m
         VLOl7jQhSCiUkZMxUayZAztadRGEb1GGxbReQRsMCwapMx4KxD1WptvG/1ubTWAMK3mk
         ct7w==
X-Gm-Message-State: AOAM533CPa0RrqpbClJ7/+gLKlyc17G8J+8ydK7ee3/N1g3pCXWDVu1/
        k9hu7ftUhN6RJJ523N6xy3xSMoqlZMvwBEdFwR50j5OZanGo1+ShLh89Y7J+DiJ2oRwSoW8mGLW
        Ici248tHztv/BiNEGzTnYU9QKm7AgSZcob8KthEcJNg==
X-Received: by 2002:aa7:810b:0:b029:2fe:decd:c044 with SMTP id b11-20020aa7810b0000b02902fedecdc044mr1891859pfi.15.1626321121579;
        Wed, 14 Jul 2021 20:52:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPXjcCsvMW55pekpqJVp9KXYj0zT1+ZSWAnzwkTGswgY0xvMdeSSsx08t8DBTKiIxsMy+KENfcsoJGEdz6ZgU=
X-Received: by 2002:aa7:810b:0:b029:2fe:decd:c044 with SMTP id
 b11-20020aa7810b0000b02902fedecdc044mr1891829pfi.15.1626321121269; Wed, 14
 Jul 2021 20:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com> <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz> <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
 <YO+e8UrCbzp2pfvj@casper.infradead.org>
In-Reply-To: <YO+e8UrCbzp2pfvj@casper.infradead.org>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 15 Jul 2021 11:51:50 +0800
Message-ID: <CAHLe9YZnLGnJp-8RpkUCHDrH=5Vrj-8-t5Yf0y_w0Sf6zhNfTQ@mail.gmail.com>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> > It's unclear to me that where to find the required address in the
> > addr2line command line, i.e.
> >
> > addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > <what address here?>
>
> ./scripts/faddr2line /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux cleanup_offline_cgwbs_workfn+0x320/0x394
>

Thanks! The result is the same as the

addr2line -i -e
/usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
FFFF8000102D6DD0

But this script is very handy.

# /usr/src/kernels/5.14.0-0.rc1.15.bx.el9.aarch64/scripts/faddr2line
/usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
cleanup_offlin
e_cgwbs_workfn+0x320/0x394
cleanup_offline_cgwbs_workfn+0x320/0x394:
arch_atomic64_fetch_add_unless at
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2265
(inlined by) arch_atomic64_add_unless at
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2290
(inlined by) atomic64_add_unless at
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-instrumented.h:1149
(inlined by) atomic_long_add_unless at
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-long.h:491
(inlined by) percpu_ref_tryget_many at
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:247
(inlined by) percpu_ref_tryget at
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:266
(inlined by) wb_tryget at
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:227
(inlined by) wb_tryget at
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:224
(inlined by) cleanup_offline_cgwbs_workfn at
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c:679

# vi /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c
```
static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
{
        struct bdi_writeback *wb;
        LIST_HEAD(processed);

        spin_lock_irq(&cgwb_lock);

        while (!list_empty(&offline_cgwbs)) {
                wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
                                      offline_node);
                list_move(&wb->offline_node, &processed);

                /*
                 * If wb is dirty, cleaning up the writeback by switching
                 * attached inodes will result in an effective removal of any
                 * bandwidth restrictions, which isn't the goal.  Instead,
                 * it can be postponed until the next time, when all io
                 * will be likely completed.  If in the meantime some inodes
                 * will get re-dirtied, they should be eventually switched to
                 * a new cgwb.
                 */
                if (wb_has_dirty_io(wb))
                        continue;

                if (!wb_tryget(wb))  <=== line#679
                        continue;

                spin_unlock_irq(&cgwb_lock);
                while (cleanup_offline_cgwb(wb))
                        cond_resched();
                spin_lock_irq(&cgwb_lock);

                wb_put(wb);
        }

        if (!list_empty(&processed))
                list_splice_tail(&processed, &offline_cgwbs);

        spin_unlock_irq(&cgwb_lock);
}
```

BTW, this bug can be only reproduced on a non-debug production built
kernel (a.k.a kernel rpm package), it's not reproducible on a debug
build with various debug configuration enabled (a.k.a kernel-debug rpm
package)

