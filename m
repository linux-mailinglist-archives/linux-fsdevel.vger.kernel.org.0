Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B025117F352
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 10:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCJJSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 05:18:21 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35822 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgCJJSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:18:21 -0400
Received: by mail-il1-f196.google.com with SMTP id g126so11342410ilh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hhr2JQNCTfwAz5fM8AxpKXVAk7m03eW/WPRPp++R3bc=;
        b=CLeuNfcd8lneEopBSQtHp3Kt+HipoV0gZP6IuZpydHV2/p4TlsVqkfu5HowfqMTXt4
         B6Nes0PUjpXtVP2DD/+CYwm5MJkMF1NpiN6Pigz83+0gVtQu29MQJHpZf1loCCFWgnuY
         NvSCicUjakpnIekJzu1+qB/DP+TL60iT/Mg+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hhr2JQNCTfwAz5fM8AxpKXVAk7m03eW/WPRPp++R3bc=;
        b=cxED51knbM3gGZiijsxw3gpi0SY/p5GH+fFrLIRCFG9JRufR30yCKmQlP21lE1Ahon
         D6DardoqIHT2bIeAgExAiPI5paNHlrsWi2qCKnqowFsXozg39iEnb23EZJc5pdglcB3t
         uS/Cv3lgHTbsYZkjXKcZhLYLp3ZBW5zq75prI/iygX4brxWbrFEJzLgcsI0mLYVVQBbl
         6+JuBFXG3ekACjw5NVX3e+PvT6CrsdkNLXFFHnrThdFmWISJa66lajg9iT3gQMfl/SQZ
         sk8922A50vq3I9B9m1e56+Td7bqeEuabnEjbQmiU0nPlghX5CGS26wiiwePrjGaHrpQ3
         YUkg==
X-Gm-Message-State: ANhLgQ0iaG7FNoIAaJTO0wa9grzlbOvjVb+55GIFOE5IoI/aFCCXCpMr
        aiEIGnyLoKuJXECUMcX5YoZma/EgBKTjIjPyJspJ1g==
X-Google-Smtp-Source: ADFU+vugKYA3Ig1dwzBjyGS81nr/dzb7dU1rNPjVpJ6bTLDiyqMRJ04NHueIU+BRzWkQaOZi8m5WZXZZBMnnCNWaxaA=
X-Received: by 2002:a92:9602:: with SMTP id g2mr18883520ilh.212.1583831899169;
 Tue, 10 Mar 2020 02:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <20200309200238.GB28467@miu.piliscsaba.redhat.com> <537182.1583794373@warthog.procyon.org.uk>
In-Reply-To: <537182.1583794373@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 10:18:08 +0100
Message-ID: <CAJfpegt9TqfyJuk0G-OJdWLiKuxSeY0cQKK=1GVf1fStA9COBw@mail.gmail.com>
Subject: Re: [PATCH 00/14] VFS: Filesystem information [ver #18]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
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

On Mon, Mar 9, 2020 at 11:53 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > >  (1) It can be targetted.  It makes it easy to query directly by path or
> > >      fd, but can also query by mount ID or fscontext fd.  procfs and sysfs
> > >      cannot do three of these things easily.
> >
> > See above: with the addition of open(path, O_PATH) it can do all of these.
>
> That's a horrible interface.  To query a file by path, you have to do:
>
>         fd = open(path, O_PATH);
>         sprintf(procpath, "/proc/self/fdmount/%u/<attr>");
>         fd2 = open(procpath, O_RDONLY);
>         read(fd2, ...);
>         close(fd2);
>         close(fd);
>
> See point (3) about efficiency also.  You're having to open *two* files.

I completely agree, opening two files is surely going to kill
performance of application needing to retrieve a billion mount
attributes per second.</sarcasm>

> > >  (2) Easier to provide LSM oversight.  Is the accessing process allowed to
> > >      query information pertinent to a particular file?
> >
> > Not quite sure why this would be easier for a new ad-hoc interface than for
> > the well established filesystem API.
>
> You're right.  That's why fsinfo() uses standard pathwalk where possible,
> e.g.:
>
>         fsinfo(AT_FDCWD, "/path/to/file", ...);
>
> or a fairly standard fd-querying interface:
>
>         fsinfo(fd, "", { resolve_flags = RESOLVE_EMPTY_PATH },  ...);
>
> to query an open file descriptor.  These are well-established filesystem APIs.

Yes.  The problem is with the "..." part where you pass random
structures to a function.   That's useful sometimes, but at the very
least it breaks type safety, and not what I would call a "clean" API.

> > Now onto the advantages of a filesystem based API:
> >
> >  - immediately usable from all programming languages, including scripts
>
> This is not true.  You can't open O_PATH from shell scripts, so you can't
> query things by path that you can't or shouldn't open (dev file paths, for
> example; symlinks).

Yes.  However, you just wrote the core of a utility that could do this
(in 6 lines, no less).  Now try that feat with fsinfo(2)!

Thanks,
Miklos
