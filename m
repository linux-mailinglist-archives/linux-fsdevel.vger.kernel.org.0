Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C15819A701
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 10:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgDAIS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 04:18:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42429 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbgDAIS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:18:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id cw6so27865330edb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2020 01:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NfTZ1psxcbruTelVq920UEZMKP5Q8CYhbx3Of3ZlPA=;
        b=TsV8RV0SNk0duVRe8v/Jj4pUvxKHMnpiNZJsAeg9dXLkJzcr28I12rPobiFSrxekML
         lZvjBSqesoMNZcw1jplpdWMUlDPvIYiCa5VHqqtrXDqBvhuLrRMLZ7+aBc6IpMGq+fcW
         2/z6FfT4AnvWnPiH8aQdExL1Q5n0l2QdZdKhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NfTZ1psxcbruTelVq920UEZMKP5Q8CYhbx3Of3ZlPA=;
        b=hf4OIyEEQ1tiRKBKCJW33QT8+gfq4BUaOgN7DxFyihTcCy9R+Gg/5ceadM2Mrr/FGJ
         3ROHNs/4Y2PZ6BH+vHQ5m/wmFTRZ9p5es6no8LSyKSHqyNawgRAwxzjH6d5PX6PYB85J
         dZaZkyQjbRBu4dFZ+hJnr5iVexCWCEzVnCmSchqlhQaLE/dsX/kwKHSuVQlDSIY9EfUw
         H7tNdr7a3E5RcGecrtBM0GKeA3Pc8HRlo+jeCFyzekFhpfebBi+GW7ygD5SpK1cdu95t
         osV8fihKdTluRAipzdASwfSMvwVABFK8+n71PliPe0UB9lD2Eq52cIniwzJY6n+wB2Qs
         oEdg==
X-Gm-Message-State: ANhLgQ1C1iG/jcmNIrOfYMlYhyuqEYCDmQhUzXalnfdYh0rMOWWrNdy6
        8zp1Q+SGOKih4ltXEcE6Psay8+lIXHJz0OxCfuCpWw==
X-Google-Smtp-Source: ADFU+vtzbMBDUSOP6hzS0q+rekhXxHRVTRf1V7Qotd7o9b2HuU0+vYqetl4dyF5TMa+9BSocqVggTTfkwZ/JTmGjJJE=
X-Received: by 2002:a17:906:9ca:: with SMTP id r10mr18691109eje.151.1585729105602;
 Wed, 01 Apr 2020 01:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
 <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com> <50caf93782ba1d66bd6acf098fb8dcb0ecc98610.camel@themaw.net>
In-Reply-To: <50caf93782ba1d66bd6acf098fb8dcb0ecc98610.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 10:18:14 +0200
Message-ID: <CAJfpegvvMVoNp1QeXEZiNucCeuUeDP4tKqVfq2F4koQKzjKmvw@mail.gmail.com>
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
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

On Wed, Apr 1, 2020 at 7:22 AM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2020-03-18 at 17:05 +0100, Miklos Szeredi wrote:
> > On Wed, Mar 18, 2020 at 4:08 PM David Howells <dhowells@redhat.com>
> > wrote:
> >
> > > ============================
> > > WHY NOT USE PROCFS OR SYSFS?
> > > ============================
> > >
> > > Why is it better to go with a new system call rather than adding
> > > more magic
> > > stuff to /proc or /sysfs for each superblock object and each mount
> > > object?
> > >
> > >  (1) It can be targetted.  It makes it easy to query directly by
> > > path.
> > >      procfs and sysfs cannot do this easily.
> > >
> > >  (2) It's more efficient as we can return specific binary data
> > > rather than
> > >      making huge text dumps.  Granted, sysfs and procfs could
> > > present the
> > >      same data, though as lots of little files which have to be
> > >      individually opened, read, closed and parsed.
> >
> > Asked this a number of times, but you haven't answered yet:  what
> > application would require such a high efficiency?
>
> Umm ... systemd and udisks2 and about 4 others.
>
> A problem I've had with autofs for years is using autofs direct mount
> maps of any appreciable size cause several key user space applications
> to consume all available CPU while autofs is starting or stopping which
> takes a fair while with a very large mount table. I saw a couple of
> applications affected purely because of the large mount table but not
> as badly as starting or stopping autofs.
>
> Maps of 5,000 to 10,000 map entries can almost be handled, not uncommon
> for heavy autofs users in spite of the problem, but much larger than
> that and you've got a serious problem.
>
> There are problems with expiration as well but that's more an autofs
> problem that I need to fix.
>
> To be clear it's not autofs that needs the improvement (I need to
> deal with this in autofs itself) it's the affect that these large
> mount tables have on the rest of the user space and that's quite
> significant.


According to dhowell's measurements processing 100k mounts would take
about a few seconds of system time (that's the time spent by the
kernel to retrieve the data, obviously the userspace processing would
add to that, but that's independent of the kernel patchset).  I think
that sort of time spent by the kernel is entirely reasonable and is
probably not worth heavy optimization, since userspace is probably
going to spend as much, if not more time with each mount entry.

> I can't even think about resolving my autofs problem until this
> problem is resolved and handling very large numbers of mounts
> as efficiently as possible must be part of that solution for me
> and I think for the OS overall too.

The key to that is allowing userspace to retrieve individual mount
entries instead of having to parse the complete mount table on every
change.

Thanks,
Miklos
