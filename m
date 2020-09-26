Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2880279C0B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 21:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgIZTNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 15:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZTNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 15:13:11 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7CCC0613CE;
        Sat, 26 Sep 2020 12:13:11 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 26so6683403ois.5;
        Sat, 26 Sep 2020 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+fAzY/YKdgot67kmHIgZxQBjZo7KUMmu9cN3uidw/nI=;
        b=a3Xx86UdAtDo/78pi4k5iv7YKBceh37BgrH/g92zxlMNYaKCk43xCh4KbGTsOpr5CS
         9Gj6NSlpCoeAUSVpSXmMAtuwN5HsXl43tPtS3K5gQDoNOm/xmUrN+yyKJqWsDTZEZZO5
         XQwbHwLdj6czu5qeONPhUNAYwaRUJDts8TpYg52LwBcc8YlNxaz9uGeV5yoIuDdJOag6
         uLB1mNMlXO3xZpPG58cEYWMiSBZa8Is3a7PEm71ID2IAMRloxYOPks6eXMx1fooyzUtf
         9/0rUChHTcG5lvMNP7TeELwsVi41XYZb6e0QMo2YHicMNNU0Ceb+xg2d16wqJ+5+L2yt
         owtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+fAzY/YKdgot67kmHIgZxQBjZo7KUMmu9cN3uidw/nI=;
        b=tePY8UneRRqila5eiz48vWoOFCNWGKwLvvzTteCVMEcH9YLzziRNH3zc5pdmxRLBLI
         a76rBuaOKIV/QUWkmVSB0FDWWkuhhXX9VpZvy4pqIG5gIcvd06h2W2CqeSkgATPSQMM+
         P3d6vMw0p4s167INqC87exWDrXhnDaJaRcR39XLUewVD5IPm4DjNFqtVOQioa1PNuWpC
         Nmd3axGyzOfEQaERm80V6hQ13eoaRI2wCHRlPMwhlyT4EcwbFoPOZKJLBZRoMgpSpLpD
         lXS6Obesvc/8jDVXm1nZyyjH3yJit143Rj8Lg/V70sveux2tl+BgSJRrrve2AlqbKjXT
         YwOw==
X-Gm-Message-State: AOAM533t48AqzOK2UlQukhnO4gaaSToOLvPsV+glc3FhKc3xHA9Eu8eh
        H/UNe0VtaxxaeBs3qg+GksReBVNDetyS1dPojvQ=
X-Google-Smtp-Source: ABdhPJzzvRk26GEH6fkGxt7/Xle7wR9kTLLqWjDJ7/JcsOAxcw+0koLxqiSBwDDYD3thCOrEiSTedFmBFQvRoOBl0Xk=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr1934383oih.35.1601147590988;
 Sat, 26 Sep 2020 12:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org> <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org> <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
 <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
 <20200925134608.GE32101@casper.infradead.org> <CA+icZUV9tNMbTC+=MoKp3rGmhDeO9ScW7HC+WUTCCvSMpih7DA@mail.gmail.com>
 <20200925155340.GG32101@casper.infradead.org>
In-Reply-To: <20200925155340.GG32101@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 26 Sep 2020 21:12:59 +0200
Message-ID: <CA+icZUV__V=_BrYz2kA2jos92mTGU0FoarHYWLgWB8tbnbo5dQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 5:53 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Sep 25, 2020 at 04:01:02PM +0200, Sedat Dilek wrote:
> > On Fri, Sep 25, 2020 at 3:46 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Sep 25, 2020 at 03:36:01PM +0200, Sedat Dilek wrote:
> > > > > I have applied your diff on top of Linux v5.9-rc6+ together with
> > > > > "iomap: Set all uptodate bits for an Uptodate page".
> > > > >
> > > > > Run LTP tests:
> > > > >
> > > > > #1: syscalls (all)
> > > > > #2: syscalls/preadv203
> > > > > #3: syscalls/dirtyc0w
> > > > >
> > > > > With #1 I see some failures with madvise0x tests.
> > >
> > > Why do you think these failures are related to my patches?
> >
> > Oh sorry, I was not saying it is related to your patches and I am not
> > familiar with all syscalls LTP tests.
>
> It's probably a good idea to become familiar with the tests.  I'm not,
> but a good way to work with any test-suite is to run it against a
> presumed-good kernel, then against a kernel with changes and see whether
> the failures change.
>
> > You said:
> > > Qian reported preadv203.c could reproduce it easily on POWER and ARM.
> > > They have 64kB pages, so it's easier to hit.  You need to have a
> > > filesystem with block size < page size to hit the problem.
> >
> > Here on my x86-64 Debian host I use Ext4-FS.
> > I can setup a new partition with a different filesystem if this helps.
> > Any recommendations?
>
> If I understand the output from preadv203 correctly, it sets up a loop
> block device with a new filesystem on it, so it doesn't matter what your
> host fs is.  What I don't know is how to change the block size for that
> filesystem.
>
> > How does the assertion look like in the logs?
> > You have an example.
>
> I happen to have one from my testing last night:
>
> 0006 ------------[ cut here ]------------
> 0006 WARNING: CPU: 5 PID: 1417 at fs/iomap/buffered-io.c:80 iomap_page_release+0xb1/0xc0
> 0006 bam!
> 0006 Modules linked in:
> 0006 CPU: 5 PID: 1417 Comm: fio Kdump: loaded Not tainted 5.8.0-00001-g51f85a97ccdd-dirty #54
> 0006 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1 04/01/2014
> 0006 RIP: 0010:iomap_page_release+0xb1/0xc0
> 0006 Code: 45 d9 48 8b 03 48 c1 e8 02 83 e0 01 75 13 38 d0 75 18 4c 89 ef e8 1f 6a f8 ff 5b 41 5c 41 5d 5d c3 eb eb e8 e1 07 f4 ff eb 8c <0f> 0b eb e4 0f 0b eb a8 0f 0b eb ac 0f 1f 00 55 48 89 e5 41 56 41
> 0006 RSP: 0018:ffffc90001ed3a40 EFLAGS: 00010202
> 0006 RAX: 0000000000000001 RBX: ffffea0001458ec0 RCX: ffffffff81cf75a7
> 0006 RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880727d1f90
> 0006 RBP: ffffc90001ed3a58 R08: 0000000000000000 R09: ffff888051ddd6e8
> 0006 R10: 0000000000000005 R11: 0000000000000230 R12: 0000000000000004
> 0006 R13: ffff8880727d1f80 R14: 0000000000000005 R15: ffffea0001458ec0
> 0006 FS:  00007fe4bdd9df00(0000) GS:ffff88807f540000(0000) knlGS:0000000000000000
> 0006 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 0006 CR2: 00007fe4bdd50000 CR3: 000000006f7e6005 CR4: 0000000000360ea0
> 0006 Call Trace:
> 0006  iomap_releasepage+0x58/0xc0
> 0006  try_to_release_page+0x4b/0x60
> 0006  invalidate_inode_pages2_range+0x38b/0x3f0
>
> I would suggest that you try applying just the assertion to Linus'
> kernel, then try to make it fire.  Then apply the fix and see if you
> can still make the assertion fire.
>

Thanks.

In the meantime I built a new LTP-from-Git and Linux-kernel v5.9-rc6+.
Applied only with the iomap-assertion diff.

Unfortunately, I do not hit the assertion when running all LTP syscalls tests.

> FWIW, I got it to fire with generic/095 from the xfstests test suite.

Good to know.
It's been a long time since I used xfstests.
Is it clone xfstests Git or do I need to compile?
Can I run only one single test like generic/095 (and how)?

- Sedat -
