Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1346F439E67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 20:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhJYS1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 14:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232819AbhJYS1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635186280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3SLaknlCrgsyNEFXulutuLS6zkvJHd+fv8cS/rpPqI=;
        b=UrCbbeo37FFAA5hy86HB+nhRyZZezns6zs7souS+/3D9VqGNo0OFKRuTRie7LoXwScCtXw
        kI8+6BOVJH9R1gsJxYUPHwET26cq3J4CKt+s+Pdr5sHKnBn6+pN9A/6fYF/2bcVnVaoF0h
        2vRhPltp6uVkXh01qqSomsXXhubMsCY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-RbMLZDtGP4G1tgb2iGjiyg-1; Mon, 25 Oct 2021 14:24:38 -0400
X-MC-Unique: RbMLZDtGP4G1tgb2iGjiyg-1
Received: by mail-wm1-f70.google.com with SMTP id y141-20020a1c7d93000000b0032cbd531f09so264368wmc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 11:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3SLaknlCrgsyNEFXulutuLS6zkvJHd+fv8cS/rpPqI=;
        b=VgGpDJC9U4B4FQ0fewrvg2Zc10CV58XB+rROgQGRQX8cLbl16kUtCbZTJjW+ir30KX
         TU1g2kC7gqU9MquoO8JuiHdQG3SngP5F0be/K8DPBiIeJpRZDMmWGbUXNf7uf1n5L3Wc
         hcTaBq/5Z/Nbe0b0/N8wb2xaX660kwzIfSdfmUsXHMTRvCkEWZ2yClVu6BpdYQ+bT8AN
         II++npKbZwKrLWTQzK0nIAYh3jXrYzxJCA/+U+AO67PhzCzSYZAhnpwolJB4RAmxSqlq
         KPvHructNNXxV6U6fZ/p8Slu6uuBdOcHDmBpfV2k530yiuuRuCbGFD/zdEeLcJx44h8z
         QBXA==
X-Gm-Message-State: AOAM530yUGoiUiTn4AHV1T2fEdiZQE125NhrqXU8iSrXDhloudbsbMJF
        9IY/lqRZrplqZGUJ3OPPkwN8H4MptJOIF4kEifqCKRuafyefZojNGJEKV0PG6AoscTSDo8W7EIa
        XX0D7HnwK7vfcqZag8kbVrNxGL2EOLrJD6zh580qbXg==
X-Received: by 2002:a5d:4bc2:: with SMTP id l2mr24538447wrt.81.1635186277624;
        Mon, 25 Oct 2021 11:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFzXJ9qteuovw6CsfxV07yOsXNr94Jrc52XFmj3IWaW0sfPtl2ViNad/7UKAIgfk9H2m/v1wcPdQgWW5/Viog=
X-Received: by 2002:a5d:4bc2:: with SMTP id l2mr24538418wrt.81.1635186277388;
 Mon, 25 Oct 2021 11:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com>
In-Reply-To: <YXL9tRher7QVmq6N@arm.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 25 Oct 2021 20:24:26 +0200
Message-ID: <CAHc6FU6JC4ZOwA8t854WbNdmuiNL9DPq0FPga8guATaoCtvsaw@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Ted Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit
On Fri, Oct 22, 2021 at 8:07 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Oct 20, 2021 at 08:19:40PM -1000, Linus Torvalds wrote:
> > On Wed, Oct 20, 2021 at 12:44 PM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > >
> > > However, with MTE doing both get_user() every 16 bytes and
> > > gup can get pretty expensive.
> >
> > So I really think that anything that is performance-critical had
> > better only do the "fault_in_write()" code path in the cold error path
> > where you took a page fault.
> [...]
> > So I wouldn't worry too much about the performance concerns. It simply
> > shouldn't be a common or hot path.
> >
> > And yes, I've seen code that does that "fault_in_xyz()" before the
> > critical operation that cannot take page faults, and does it
> > unconditionally.
> >
> > But then it isn't the "fault_in_xyz()" that should be blamed if it is
> > slow, but the caller that does things the wrong way around.
>
> Some more thinking out loud. I did some unscientific benchmarks on a
> Raspberry Pi 4 with the filesystem in a RAM block device and a
> "dd if=/dev/zero of=/mnt/test" writing 512MB in 1MB blocks. I changed
> fault_in_readable() in linux-next to probe every 16 bytes:
>
> - ext4 drops from around 261MB/s to 246MB/s: 5.7% penalty
>
> - btrfs drops from around 360MB/s to 337MB/s: 6.4% penalty
>
> For generic_perform_write() Dave Hansen attempted to move the fault-in
> after the uaccess in commit 998ef75ddb57 ("fs: do not prefault
> sys_write() user buffer pages"). This was reverted as it was exposing an
> ext4 bug. I don't [know] whether it was fixed but re-applying Dave's commit
> avoids the performance drop.

Interesting. The revert of commit 998ef75ddb57 is in commit
00a3d660cbac. Maybe Dave and Ted can tell us more about what went
wrong in ext4 and whether it's still an issue.

Commit 998ef75ddb57 looks mostly good except that it should loop
around whenever the fault-in succeeds even partially, so it needs the
semantic change of patch 4 [*] of this series. A copy of the same code
now lives in iomap_write_iter, so the same fix needs to be applied
there. Finally, it may be worthwhile to check for pagefault_disabled()
in generic_perform_write and iomap_write_iter before trying the
fault-in; this would help gfs2 which will always call into
iomap_write_iter with page faults disabled, and additional callers
like that could emerge relatively soon.

[*] https://lore.kernel.org/lkml/20211019134204.3382645-5-agruenba@redhat.com/

> btrfs_buffered_write() has a comment about faulting pages in before
> locking them in prepare_pages(). I suspect it's a similar problem and
> the fault_in() could be moved, though I can't say I understand this code
> well enough.
>
> Probing only the first byte(s) in fault_in() would be ideal, no need to
> go through all filesystems and try to change the uaccess/probing order.

Thanks,
Andreas

