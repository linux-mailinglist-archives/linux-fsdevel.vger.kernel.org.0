Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6760D436E20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 01:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhJUXSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhJUXST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:18:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D14C061764;
        Thu, 21 Oct 2021 16:16:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j21so5466173lfe.0;
        Thu, 21 Oct 2021 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGd3ZBTVw8WerW8TiXkapULoiLMOJ6XxJFj9gFvuuSU=;
        b=b2s6FHWu+usXqQrC6G5oR1QXzV421vmzu616cj0TNoasagpoWnKOEKbYxv6lwcqPeI
         3rORErL7fa/RFd0y2Vi9iFsS945DYpKaBv5nii1hrDWFRTJAvwghzmPtEJj+WMAEM17L
         /O3Sh1kCF4mjJgVQs5ZVXMKHMXWjelDAnQuriR3P4qbXBgow863UHNut4GWOwsAcq3R8
         LkWsfmC9oiosn2tFEKgiUpbhG4Nj1FZGqH8d5l/mF+MDgVDszmLDzMmBdqz5dfZydR6W
         CwiG1vdp59S9FmUIPQ76gL5GOhXou9LfjHasOMDZ9f3WorvSSWSHDMjI2c/fnqLqoXEM
         8naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGd3ZBTVw8WerW8TiXkapULoiLMOJ6XxJFj9gFvuuSU=;
        b=q6clXKjd+1N1hCp8jdTnitbz4y6OqwHd6HBKO1twKQBtkPyjOj5d1VWB8jMvbF24QV
         NUERDdfV4FL47Onz74r81zk7KzHRUgJ/JfkAiqisboBIQQcyt9CSrpzIpfaLppUSm+25
         9sM0TeTbuJew5BJt4UTA15PvAk8i1hWnDGX6K36IuM0PSnmJQlwNmew9sQtJgj1PUGaz
         CQidLadGxjEBFfWU/Y9Qi3f0UBAWBnzSMF4/0Y94JCFSYik+Vgl3wjvdeaKu2nVMv6O3
         es0YZbqgp91IDh9PEoPGJEJs4C8R1C2K70RYiVjLYe3TqY0qNCq8ss1+HOcS4MMRA3WU
         geMA==
X-Gm-Message-State: AOAM531bVULI7mss9ONV7EPTcclTb9W3rcDJ4YTb2l29PwsBvtMCfS/y
        7K6X4gT59lmlL79znnwMxGZHK2GIbPb/2wMF72A=
X-Google-Smtp-Source: ABdhPJwZpcQ1KdeVcaHk764w6WspHm/7cDejlBv/A5lS6M8tifVYkMndPvZos9ePSqOr5Sy9U5NwiVeDSIz4sIygGiM=
X-Received: by 2002:a05:6512:3763:: with SMTP id z3mr8185733lft.601.1634858160588;
 Thu, 21 Oct 2021 16:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
 <YXHntB2O0ACr0pbz@relinquished.localdomain>
In-Reply-To: <YXHntB2O0ACr0pbz@relinquished.localdomain>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 21 Oct 2021 18:15:49 -0500
Message-ID: <CAH2r5msO7-QCXv6JQj2Tado9ZoWAHRkgq6-En18PeKSXFDdBLw@mail.gmail.com>
Subject: Re: [PATCH 00/67] fscache: Rewrite index API and management system
To:     Omar Sandoval <osandov@osandov.com>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        v9fs-developer@lists.sourceforge.net,
        CIFS <linux-cifs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 5:21 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Mon, Oct 18, 2021 at 03:50:15PM +0100, David Howells wrote:
> However, with the advent of the tmpfile capacity in the VFS, an opportunity
> arises to do invalidation much more easily, without having to wait for I/O
> that's actually in progress: Cachefiles can simply cut over its file
> pointer for the backing object attached to a cookie and abandon the
> in-progress I/O, dismissing it upon completion.

Have changes been made to O_TMPFILE?  It is problematic for network filesystems
because it is not an atomic operation, and would be great if it were possible
to create a tmpfile and open it atomically (at the file system level).

Currently it results in creating a tmpfile (which results in
opencreate then close)
immediately followed by reopening the tmpfile which is somewhat counter to
the whole idea of a tmpfile (ie that it is deleted when closed) since
the syscall results
in two opens ie open(create)/close/open/close


-- 
Thanks,

Steve
