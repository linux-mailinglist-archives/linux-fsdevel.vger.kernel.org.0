Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B42634F1EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 22:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhC3UBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 16:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhC3UBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:01:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D2EC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 13:01:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s17so21272246ljc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iUQpi+sJY96M0oTRItdYRMKHG3+VxUz+t6vY8dGmO+U=;
        b=oeUZ5mND0ZbBb92my2vpif9MOmzQpXmPHa6ESdE9DoEgmJ+f4n7aaHY2hH2cLOqBU5
         lVvw3oI5Hub03dWw0BPaeUYp7WteB8Z+ilsGDG0uvhCNa0btjGOj4iqHeXlIKIh2AqM3
         HMOgo3bj2JQddAe6BV9FPcySj7NAFx4dwvGTQHf3a30b44vc8Vpc/9QkLiUDRuMchM0k
         zrxWJ4f6fkYlf0ube1r+3OFxfH05Nf0v9t/1zeHq26DG7zOuAjK/m1t0GVOiC3DM5hjt
         iSsfM4b2LKDhF+tTotxIuu8AzYxnN/Tv5JkVaPgMIgPArL+cQSbK9IzJQvEkhuszTrYy
         FdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iUQpi+sJY96M0oTRItdYRMKHG3+VxUz+t6vY8dGmO+U=;
        b=LKkXpVYHvOzJTjPakw9o2WonHjU4yJ+BCTUCTyftq1htqAZkhsm+PGnc6hSFnWwZrU
         llDwRpJRuebpfiD0/WpTgez+dpTPcVWdcGx/6MTofK2h+y5KQW+pLzQPx98eNJyB3gyo
         rZyU8CewAb76zhYCeLJb55Xb405uQ0iGWIqpc+tpiacj47Mq7PUUeqToL2ckQE5Ge08m
         OGMyMYkV91rnPmhafV8clB2y5QLCi3b/Kyie4v6/WVikv5bh86hnte+BUhrVTaUo1yOC
         a4w/aqnekTmyyhsrm1tkrUGukx3w2nyL03oODsC6uGkkzFcTSifoKpWAQOfX/4PWuflY
         ULlA==
X-Gm-Message-State: AOAM531wBlTUVrd2b2IWCo3osBbYJTQZqg6apZ4ni/HdQqKaGUxsSJwe
        eXcTJ7X6bLG0QDGFtkhoH2xAqFs78tfXZ3U3Sioxww==
X-Google-Smtp-Source: ABdhPJz3sX1eTQm5fKKV5RmJJoxAuSmvn4gDPlEJ/96820aGiIae+uwCS6EeIvCfqacZ4jbrc/sDWj9KXHXzdKtgdwI=
X-Received: by 2002:a2e:8196:: with SMTP id e22mr22326561ljg.398.1617134470053;
 Tue, 30 Mar 2021 13:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210322215823.962758-1-cfijalkovich@google.com>
 <CAPhsuW4RK9-yWrFmoUzi09bquxr_K16LqeZBYWoJXM0t=qo+Gw@mail.gmail.com>
 <CAL+PeoGfCmbMSEYgaJNPHWfLvmmXJGaEM5G6rFstKzhTeY=2yw@mail.gmail.com> <2E59E29C-E04D-417C-9B2B-7F0F7D5E43EA@fb.com>
In-Reply-To: <2E59E29C-E04D-417C-9B2B-7F0F7D5E43EA@fb.com>
From:   Collin Fijalkovich <cfijalkovich@google.com>
Date:   Tue, 30 Mar 2021 13:00:59 -0700
Message-ID: <CAL+PeoHXNjcgR=te+WnkGGMiGyqqdparX+HH8K2KCK0CV9sUKg@mail.gmail.com>
Subject: Re: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on file-backed THPs
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Hugh Dickins <hughd@google.com>,
        Tim Murray <timmurray@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There will be an immediate performance hit when the file is opened for
write, as its associated pages are removed from the page cache. While
the writer is present there will be the usual overhead of using 4kB
pages instead of THPs, but there should not be an additional penalty.
It is problematic if a file is repeatedly opened for write, as it will
need to refault each time.

- Collin


On Sun, Mar 28, 2021 at 9:45 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Mar 23, 2021, at 10:13 AM, Collin Fijalkovich <cfijalkovich@google.c=
om> wrote:
> >
> > Question: when we use this on shared library, the library is still
> > writable. When the
> > shared library is opened for write, these pages will refault in as 4kB
> > pages, right?
> >
> > That's correct, while a file is opened for write it will refault into 4=
kB pages and block use of THPs. Once all writers complete (i_writecount <=
=3D0), the file can fault into THPs again and khugepaged can collapse exist=
ing page ranges provided that it can successfully allocate new huge pages.
>
> Will it be a problem if a slow writer (say a slow scp) writes to the
> shared library while the shared library is in use?
>
> Thanks,
> Song
>
> >
> > From,
> > Collin
> >
> > On Mon, Mar 22, 2021 at 4:55 PM Song Liu <song@kernel.org> wrote:
> > On Mon, Mar 22, 2021 at 3:00 PM Collin Fijalkovich
> > <cfijalkovich@google.com> wrote:
> > >
> > > Transparent huge pages are supported for read-only non-shmem filesyst=
ems,
> > > but are only used for vmas with VM_DENYWRITE. This condition ensures =
that
> > > file THPs are protected from writes while an application is running
> > > (ETXTBSY).  Any existing file THPs are then dropped from the page cac=
he
> > > when a file is opened for write in do_dentry_open(). Since sys_mmap
> > > ignores MAP_DENYWRITE, this constrains the use of file THPs to vmas
> > > produced by execve().
> > >
> > > Systems that make heavy use of shared libraries (e.g. Android) are un=
able
> > > to apply VM_DENYWRITE through the dynamic linker, preventing them fro=
m
> > > benefiting from the resultant reduced contention on the TLB.
> > >
> > > This patch reduces the constraint on file THPs allowing use with any
> > > executable mapping from a file not opened for write (see
> > > inode_is_open_for_write()). It also introduces additional conditions =
to
> > > ensure that files opened for write will never be backed by file THPs.
> >
> > Thanks for working on this. We could also use this in many data center
> > workloads.
> >
> > Question: when we use this on shared library, the library is still
> > writable. When the
> > shared library is opened for write, these pages will refault in as 4kB
> > pages, right?
> >
> > Thanks,
> > Song
>
