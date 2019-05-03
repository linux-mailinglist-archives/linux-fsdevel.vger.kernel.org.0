Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C583912FF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfECOSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 10:18:24 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44529 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbfECOSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 10:18:24 -0400
Received: by mail-yw1-f67.google.com with SMTP id j4so4378994ywk.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2019 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4XtQ9BE6S/+vFeJxumqTjxJbaQPwqJr03SgLnlZUfE=;
        b=RZGJY1dmnCmXGVjbiwtEyKAK0Tw0jsq6wSLoBAzzjbLWQgxXVSJYgZWt6c279Eoa85
         LIrwwpmaV/Om3qxIVnwZSIhqjrZCGAt/9IOo97L7VygddHyr7p+v0fXkvGlDi3PAuQkk
         Mddc9sX67afmDzJ7QNjos71OPFIfnJU6VnVhXw0AURKsxYr1i2Z9zC5UdBB//kz/07Y9
         f2MPumzc18SzLVf1L104+HV3tmxl7sk3YOfvqPJGp5UNwHeBrwcflK+BPO+G8dW3sqgY
         2Pe4JIhymDgahAjpu0pLC1uN0HnxPG9Eud8W2CChog5VOcUWQdbWPFu9B+6LWCM52Zpr
         dEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4XtQ9BE6S/+vFeJxumqTjxJbaQPwqJr03SgLnlZUfE=;
        b=IBJEXrK9AkpkGsIE3OgwCiactk+HaostndjR8uTSGokPyNDBxUG71XF3qB5YGHSUNP
         4qEQKTMEjOGHl0nSyxIajsG2XtL/dF+nk15xJeo5WRF5iW3lZd7v+LGQ2v/TFbSRDOvF
         8JVoMUMdNA3gX9kuIhXT1PcbmTCJYXjDTi1WPPBJGb71b9Iger1vEHlCAXcugi5tuAHG
         9vpzr5draVAjO2yopVugfCjYvCPa0oj93/AO4OmQ8GaScsPpNLqjgs0jM0miVwiBMX44
         KWpHJjkSWa+RHw/7pp5GcyGvrsGz3s2AAR6cAj4CVBPmQJUsT2IiLBAes8WK7cbz2h0k
         RlLA==
X-Gm-Message-State: APjAAAXR3RwUGk+CvIOyF1P1PRKRaaSax2U6RCvvO5PFhRGW/QAgtPf0
        m2RN98UEHe8wM3D5vDTqB83zZW5fhk1yGd8RUI8=
X-Google-Smtp-Source: APXvYqxKnAUJZFTnI0T3Ay4fZk8u3wC7XSpyb3jxa5YhMVc7ztm0FobY6eT/szRKIQcwh1v6c4jNkseBft1/5OGROks=
X-Received: by 2002:a25:952:: with SMTP id u18mr7914528ybm.397.1556893102987;
 Fri, 03 May 2019 07:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu> <CAOQ4uxjM+ivnn-oU482GmRqOF6bYY5j89NdyHnfH++f49qB4yw@mail.gmail.com>
 <20190503095846.GE23724@mit.edu>
In-Reply-To: <20190503095846.GE23724@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 3 May 2019 10:18:11 -0400
Message-ID: <CAOQ4uxi5AGnXRY7CbdbAwz2OJiXYxTo5NQqaFGSqw23ihSyK1g@mail.gmail.com>
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties contract
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Vijay Chidambaram <vijay@cs.utexas.edu>,
        lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 3, 2019 at 5:59 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Fri, May 03, 2019 at 12:16:32AM -0400, Amir Goldstein wrote:
> > OK. we can leave that one for later.
> > Although I am not sure what the concern is.
> > If we are able to agree  and document a LINK_ATOMIC flag,
> > what would be the down side of documenting a RENAME_ATOMIC
> > flag with same semantics? After all, as I said, this is what many users
> > already expect when renaming a temp file (as ext4 heuristics prove).
>
> The problem is if the "temp file" has been hardlinked to 1000
> different directories, does the rename() have to guarantee that we
> have to make sure that the changes to all 1000 directories have been
> persisted to disk?  And all of the parent directories of those 1000
> directories have also *all* been persisted to disk, all the way up to
> the root?
>
> With the O_TMPFILE linkat case, we know that inode hasn't been
> hard-linked to any other directory, and mercifully directories have
> only one parent directory, so we only have to check one set of
> directory inodes all the way up to the root having been persisted.
>
> But.... I can already imagine someone complaining that if due to bind
> mounts and 1000 mount namespaces, there is some *other* directory
> pathname which could be used to reach said "tmpfile", we have to
> guarantee that all parent directories which could be used to reach
> said "tmpfile" even if they span a dozen different file systems,
> *also* have to be persisted due to sloppy drafting of what the
> atomicity rules might happen to be.
>
> If we are only guaranteeing the persistence of the containing
> directories of the source and destination files, that's pretty easy.
> But then the consistency rules need to *explicitly* state this.  Some
> of the handwaving definitions of what would be guaranteed.... scare
> me.
>

I see. So the issue is with the language:
"metadata modifications made to the file before being linked"
that may be interpreted that hardlinking a file is making a
modification to the file. I can't help myself writing the pun
"nlink doesn't count".

Tough one. We can include more exclusive language, but that
is not going to aid the goal of a simple documented API.

OK, I'll withdraw RENAME_ATOMIC for now and concede to
having LINK_ATOMIC fail when trying to link and nlink > 0.

How about if I implement RENAME_ATOMIC for in-kernel users
only at this point in time?

Overlayfs needs it for correctness of directory copy up operation.

>
> P.S.  If we were going to do this, we'd probably want to simply define
> a flag to be AT_FSYNC, using the strict POSIX definition of fsync,
> which is to say, as a result of the linkat or renameat, the file in
> question, and its associated metadata, are guaranteed to be persisted
> to disk.  No other guarantees about any other inode's metadata
> regardless of when they might be made, would be guaranteed.
>

I agree that may be useful. Not to my use case though.

> If people really want "global barrier" semantics, then perhaps it
> would be better to simply define a barrierfs(2) system call that works
> like syncfs(2) --- it applies to the whole file system, and guarantees
> that all changes made after barrierfs(2) will be visible if any
> changes made *after* barrierfs(2) are visible.  Amir, you used "global
> ordering" a few times; if you really need that, let's define a new
> system call which guarantees that.  Maybe some of the research
> proposals for exotic changes to SSD semantics, etc., would allow
> barrierfs(2) semantics to be something that we could implement more
> efficiently than syncfs(2).  But let's make this be explicit, as
> opposed to some magic guarantee that falls out as a side effect of the
> fsync(2) system call to a single inode.

Yes, maybe. For xfs/ext4.
Not sure about btrfs. Seems like fbarrier(2) would have been
more natural for btrfs model (file and all its dependencies).

I think barrierfs(2) would be useful, but I think it is harder to
explain to users.
See barrierfs() should not flush all inode pages that would be counter
productive, so what does it really mean to end users?
We would end up with the same problem of misunderstood sync_file_range().

I would have been happy with this API:
sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WRITE_AND_WAIT);
barrierfs(fd);
rename(...)/link(...)

Perhaps atomic_rename()/atomic_link() should be library functions
wrapping the lower level API to hide those details from end users.

Thanks,
Amir.
