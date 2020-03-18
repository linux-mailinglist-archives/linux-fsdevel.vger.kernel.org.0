Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0002118A02E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 17:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCRQGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 12:06:06 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41579 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgCRQGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:06:03 -0400
Received: by mail-il1-f195.google.com with SMTP id l14so24135131ilj.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2020 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+E6phefA0/UCxZU68Ee5CkdpY/LreXqfKusKthyp5I=;
        b=PmkHFgajk2/8VWOHdYUg8VCj1tVopeX6fqfrGgYm0sPb35e5EoxUjxowANbaw3zCwS
         wqDhItzeSSD2F4OzNelMLAyDUKSqRDkOzITlg+Hge+tWY5LhXczVM8GuM5pTiPEM5aFa
         ut6OlQnzTW2CXrIbgEnOI63xRs4UIkIGUhynA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+E6phefA0/UCxZU68Ee5CkdpY/LreXqfKusKthyp5I=;
        b=Ak8SkzHiWej4QsQnyg7AUeQ2eWxFgF9y2OK0eXONjZd9GCBHT2NqqF8rFHv42eYo14
         xZ+GOCd/9y93WAGF13YJL94KvqPDTNeaWPGyBR8A3JBZfqubKqCJKOvWp+Sv9cItzJ/Z
         i9yb4bVwM+HCk5pdQCoZlOTba0ayZjViThnwWnsAPYaXGQnPfJ2xb0KGfN4MoLGJvOzx
         pIBlmoYQhIw1jQfuUU8dx8UV0YpVkMTznjELHLCTA8CaYI0f88CZoqqOHoFKvg/EIs9M
         G+H99YuCDuLS07Zd2syodzSPLmcM66+5/uyt55WLzXUJdr2JuqJk3tZl265KjfzK2QX1
         BJLA==
X-Gm-Message-State: ANhLgQ2TltX1TfBeSN+doUxuG9Zsy2nrKaR33VMPd8DVDLxzFxOTFVRl
        QLT5MxNHDxuJi8hlpbYEK+U1k1tvELqYuNH4PEUvqg==
X-Google-Smtp-Source: ADFU+vseuj9ZXYFeMbS3X+5vGmRRSiZoxImF5rzfLQFjQscZDtBKPWLdRkROYV3TZYIAEV5wBxQF2hmZ0LlipmXRNY0=
X-Received: by 2002:a92:5d52:: with SMTP id r79mr4664957ilb.212.1584547562099;
 Wed, 18 Mar 2020 09:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 Mar 2020 17:05:50 +0100
Message-ID: <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com>
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 18, 2020 at 4:08 PM David Howells <dhowells@redhat.com> wrote:

> ============================
> WHY NOT USE PROCFS OR SYSFS?
> ============================
>
> Why is it better to go with a new system call rather than adding more magic
> stuff to /proc or /sysfs for each superblock object and each mount object?
>
>  (1) It can be targetted.  It makes it easy to query directly by path.
>      procfs and sysfs cannot do this easily.
>
>  (2) It's more efficient as we can return specific binary data rather than
>      making huge text dumps.  Granted, sysfs and procfs could present the
>      same data, though as lots of little files which have to be
>      individually opened, read, closed and parsed.

Asked this a number of times, but you haven't answered yet:  what
application would require such a high efficiency?

Nobody's suggesting we move stat(2) to proc interfaces, and AFAIK
nobody suggested we move /proc/PID/* to a binary syscall interface.
Each one has its place, and I strongly feel that mount info belongs in
the latter category.    Feel free to prove the opposite.

>  (3) We wouldn't have the overhead of open and close (even adding a
>      self-contained readfile() syscall has to do that internally

Busted: add f_op->readfile() and be done with all that.   For example
DEFINE_SHOW_ATTRIBUTE() could be trivially moved to that interface.

We could optimize existing proc, sys, etc. interfaces, but it's not
been an issue, apparently.

>
>  (4) Opening a file in procfs or sysfs has a pathwalk overhead for each
>      file accessed.  We can use an integer attribute ID instead (yes, this
>      is similar to ioctl) - but could also use a string ID if that is
>      preferred.
>
>  (5) Can easily query cross-namespace if, say, a container manager process
>      is given an fs_context that hasn't yet been mounted into a namespace -
>      or hasn't even been fully created yet.

Works with my patch.

>  (6) Don't have to create/delete a bunch of sysfs/procfs nodes each time a
>      mount happens or is removed - and since systemd makes much use of
>      mount namespaces and mount propagation, this will create a lot of
>      nodes.

Not true.

> The argument for doing this through procfs/sysfs/somemagicfs is that
> someone using a shell can just query the magic files using ordinary text
> tools, such as cat - and that has merit - but it doesn't solve the
> query-by-pathname problem.
>
> The suggested way around the query-by-pathname problem is to open the
> target file O_PATH and then look in a magic directory under procfs
> corresponding to the fd number to see a set of attribute files[*] laid out.
> Bash, however, can't open by O_PATH or O_NOFOLLOW as things stand...

Bash doesn't have fsinfo(2) either, so that's not really a good argument.

Implementing a utility to show mount attribute(s) by path is trivial
for the file based interface, while it would need to be updated for
each extension of fsinfo(2).   Same goes for libc, language bindings,
etc.

Thanks,
Miklos
