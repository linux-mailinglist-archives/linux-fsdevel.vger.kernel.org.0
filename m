Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976863D1D68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 07:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhGVEsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 00:48:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230187AbhGVEsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 00:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626931758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d5Jskim/SnYeMk+zNwuZ4+S7+dbfaQoDitKjM+kLtI0=;
        b=DY2sHp1ny/yzPbfdYDxnl70njY9npV990xUE2r80afCSjMt0984w4P1f/509d81Fxtvz3c
        rogoUQjC9Sr/+VtLdEzUmO9tB7M7N1y1t79ieItMz6TKWXyJx6CfLd6iEL4gf19e0eSEsf
        cfOU7QE94gNhVcsK4h81mof2Q81FSxg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-okCuh7hnM7mesUZvOgTi1w-1; Thu, 22 Jul 2021 01:29:16 -0400
X-MC-Unique: okCuh7hnM7mesUZvOgTi1w-1
Received: by mail-pj1-f71.google.com with SMTP id j9-20020a17090a7349b0290176428e89e9so3308027pjs.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 22:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5Jskim/SnYeMk+zNwuZ4+S7+dbfaQoDitKjM+kLtI0=;
        b=eSPOmrhPoGCrZIToxK79SF6V1MVX83rWUMTBfxDmITKLgX+etdqU2gndpf4qlAbnxS
         eUz2pgWcZ7GlN6M7utOI/1qP3jq2Bjba1LW4yWDpCAIcQQmaQDJjbRjfN2CCzqF/maZS
         9AMamH+4AFIw3idtz1GL8AXsuFGXssndzOt5S0hDepCEi/szeEb6NT5xr7rhCliyrYKD
         5AJ53Pc3aTfF8tNommPiGsCUJEb9WlyGPl0v9dYx0D2Fvr86SPhwdm7lHhcjaJP9KV0i
         g6bYPJ+vDBrbUvgIVFMMhDoJFWNI4y2Eg+o3etlJhiQyXdBU9+ACwBjsyL2A0w7Pizbl
         TLcQ==
X-Gm-Message-State: AOAM5336MjDeZgn9ZUQjioxef3cmj67RBP9rQFLZeJTfSZInzeMD5pkX
        iIZNSDfA7QC0yllmVK9EZ02X3RLx1Moc1N7hZWRP1yoPCohqErMTg5ozhAiJ/bePi5NmddSQpKX
        /jXcKUx4gDyhNUAjUfdIL8SPP/I3jnJFgrUNTeJ4h/w==
X-Received: by 2002:a17:902:f282:b029:12b:2b93:fbdd with SMTP id k2-20020a170902f282b029012b2b93fbddmr30577538plc.35.1626931755559;
        Wed, 21 Jul 2021 22:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqxOmet6FXZyNOxIZb5IOiNmQRiWlMOCeVo6Nek/VYLOcmnym4EMitOOuBSgp9/+/RbUIxJMGy/8ip+gi5omk=
X-Received: by 2002:a17:902:f282:b029:12b:2b93:fbdd with SMTP id
 k2-20020a170902f282b029012b2b93fbddmr30577520plc.35.1626931755236; Wed, 21
 Jul 2021 22:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com> <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz> <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
 <YO+e8UrCbzp2pfvj@casper.infradead.org> <CAHLe9YZnLGnJp-8RpkUCHDrH=5Vrj-8-t5Yf0y_w0Sf6zhNfTQ@mail.gmail.com>
 <20210715171050.GB22357@magnolia> <YPCVrwov6R9yaBcG@carbon.dhcp.thefacebook.com>
 <20210715222812.GW22357@magnolia> <20210716162340.GY22357@magnolia>
 <YPHmLwF09QCPB7tw@carbon.dhcp.thefacebook.com> <CAHLe9YZLrYJvuXBiZvu0BLVth0Cuxw4Ja1DKgyH0Q43-V62AsA@mail.gmail.com>
In-Reply-To: <CAHLe9YZLrYJvuXBiZvu0BLVth0Cuxw4Ja1DKgyH0Q43-V62AsA@mail.gmail.com>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 22 Jul 2021 13:29:03 +0800
Message-ID: <CAHLe9YZ0GC30Cunw+j2ejqtYekacRHgiS+KLxTefAkcV=MpfDw@mail.gmail.com>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
To:     Roman Gushchin <guro@fb.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just FYI, the tests on ppc64le are done, no longer kernel panic, so my
tests on all arches are fine now.

On Sat, Jul 17, 2021 at 8:00 PM Boyang Xue <bxue@redhat.com> wrote:
>
> Testing fstests on aarch64, x86_64, s390x all passed. There's a
> shortage of ppc64le systems, so I can't provide the ppc64le test
> result for now, but I hope I can report the result next week.
>
> Thanks,
> Boyang
>
> On Sat, Jul 17, 2021 at 4:04 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Jul 16, 2021 at 09:23:40AM -0700, Darrick J. Wong wrote:
> > > On Thu, Jul 15, 2021 at 03:28:12PM -0700, Darrick J. Wong wrote:
> > > > On Thu, Jul 15, 2021 at 01:08:15PM -0700, Roman Gushchin wrote:
> > > > > On Thu, Jul 15, 2021 at 10:10:50AM -0700, Darrick J. Wong wrote:
> > > > > > On Thu, Jul 15, 2021 at 11:51:50AM +0800, Boyang Xue wrote:
> > > > > > > On Thu, Jul 15, 2021 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> > > > > > > > > It's unclear to me that where to find the required address in the
> > > > > > > > > addr2line command line, i.e.
> > > > > > > > >
> > > > > > > > > addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > > > > > > > <what address here?>
> > > > > > > >
> > > > > > > > ./scripts/faddr2line /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux cleanup_offline_cgwbs_workfn+0x320/0x394
> > > > > > > >
> > > > > > >
> > > > > > > Thanks! The result is the same as the
> > > > > > >
> > > > > > > addr2line -i -e
> > > > > > > /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > > > > > FFFF8000102D6DD0
> > > > > > >
> > > > > > > But this script is very handy.
> > > > > > >
> > > > > > > # /usr/src/kernels/5.14.0-0.rc1.15.bx.el9.aarch64/scripts/faddr2line
> > > > > > > /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > > > > > cleanup_offlin
> > > > > > > e_cgwbs_workfn+0x320/0x394
> > > > > > > cleanup_offline_cgwbs_workfn+0x320/0x394:
> > > > > > > arch_atomic64_fetch_add_unless at
> > > > > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2265
> > > > > > > (inlined by) arch_atomic64_add_unless at
> > > > > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2290
> > > > > > > (inlined by) atomic64_add_unless at
> > > > > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-instrumented.h:1149
> > > > > > > (inlined by) atomic_long_add_unless at
> > > > > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-long.h:491
> > > > > > > (inlined by) percpu_ref_tryget_many at
> > > > > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:247
> > > > > > > (inlined by) percpu_ref_tryget at
> > > > > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:266
> > > > > > > (inlined by) wb_tryget at
> > > > > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:227
> > > > > > > (inlined by) wb_tryget at
> > > > > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:224
> > > > > > > (inlined by) cleanup_offline_cgwbs_workfn at
> > > > > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c:679
> > > > > > >
> > > > > > > # vi /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c
> > > > > > > ```
> > > > > > > static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> > > > > > > {
> > > > > > >         struct bdi_writeback *wb;
> > > > > > >         LIST_HEAD(processed);
> > > > > > >
> > > > > > >         spin_lock_irq(&cgwb_lock);
> > > > > > >
> > > > > > >         while (!list_empty(&offline_cgwbs)) {
> > > > > > >                 wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
> > > > > > >                                       offline_node);
> > > > > > >                 list_move(&wb->offline_node, &processed);
> > > > > > >
> > > > > > >                 /*
> > > > > > >                  * If wb is dirty, cleaning up the writeback by switching
> > > > > > >                  * attached inodes will result in an effective removal of any
> > > > > > >                  * bandwidth restrictions, which isn't the goal.  Instead,
> > > > > > >                  * it can be postponed until the next time, when all io
> > > > > > >                  * will be likely completed.  If in the meantime some inodes
> > > > > > >                  * will get re-dirtied, they should be eventually switched to
> > > > > > >                  * a new cgwb.
> > > > > > >                  */
> > > > > > >                 if (wb_has_dirty_io(wb))
> > > > > > >                         continue;
> > > > > > >
> > > > > > >                 if (!wb_tryget(wb))  <=== line#679
> > > > > > >                         continue;
> > > > > > >
> > > > > > >                 spin_unlock_irq(&cgwb_lock);
> > > > > > >                 while (cleanup_offline_cgwb(wb))
> > > > > > >                         cond_resched();
> > > > > > >                 spin_lock_irq(&cgwb_lock);
> > > > > > >
> > > > > > >                 wb_put(wb);
> > > > > > >         }
> > > > > > >
> > > > > > >         if (!list_empty(&processed))
> > > > > > >                 list_splice_tail(&processed, &offline_cgwbs);
> > > > > > >
> > > > > > >         spin_unlock_irq(&cgwb_lock);
> > > > > > > }
> > > > > > > ```
> > > > > > >
> > > > > > > BTW, this bug can be only reproduced on a non-debug production built
> > > > > > > kernel (a.k.a kernel rpm package), it's not reproducible on a debug
> > > > > > > build with various debug configuration enabled (a.k.a kernel-debug rpm
> > > > > > > package)
> > > > > >
> > > > > > FWIW I've also seen this regularly on x86_64 kernels on ext4 with all
> > > > > > default mkfs settings when running generic/256.
> > > > >
> > > > > Oh, that's a useful information, thank you!
> > > > >
> > > > > Btw, would you mind to give a patch from an earlier message in the thread
> > > > > a test? I'd highly appreciate it.
> > > > >
> > > > > Thanks!
> > > >
> > > > Will do.
> > >
> > > fstests passed here, so
> > >
> > > Tested-by: Darrick J. Wong <djwong@kernel.org>
> >
> > Great, thank you!
> >

