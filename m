Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538882D54B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 07:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfE2F6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 01:58:22 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38715 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfE2F6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 01:58:21 -0400
Received: by mail-yw1-f66.google.com with SMTP id b74so558921ywe.5;
        Tue, 28 May 2019 22:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6nWKM07XCTQG/jfZDs9epRQaNFVvzTBWML5ZHkbuZw=;
        b=A2C1071RXs3ZnZFiz4+/N4wTKcNvDdPJLbUb0TAOcCSExMUOU0vJkws3W8UBuKFXJK
         DQYos90pa3qhlOzf9QdV8jpPV3w6caXq9Z5SF6c5Yd2KFWaf5qzXzQ2BDN4ifGyZm0d6
         DTQbQ5k4lq9u5oMjPtxM1Og6YUXpPJEcJrzyqI1eg8XuwOON5Bf70Mr8cfVb7V+ZKVSt
         eGk+Rhy9X77XNrNW/fIyQeQcBZ8aSptJYLkkBruwp0Nash6DVh3WHRQ2Z3adqhkLVzRB
         tcKEfFr170QG/HzEvGMGkIp5ASzcgqG4Kpm3woXcLTsYvw/rW8KfTfap5hMeA/clngd0
         N1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6nWKM07XCTQG/jfZDs9epRQaNFVvzTBWML5ZHkbuZw=;
        b=YGMFLKuyLkDjSlhk/jf3LW2fUiVVYAm89EpEUsRJFj2zZiw/piGR0xWv3KuLD21Fel
         hX454flacYF21d2Ln+8k31AmVNku0p1LbUy/3vP10vFfWtjng/O3jBCHbXp42TUiZ3hf
         4OXaIissRLfFBhuFUX2UXz+aGjHnjPgo8IFPOmZqLPgtZEerxZ1XvP7ENYT8VgVzjzen
         X6x6WnhE0bXCiolC/l1eoFVQwFZCnu01yTo7z8RUnwsjWO+f9uF9G62fvjAZX1qoDUKr
         /ZjKWKpxOz+zj8GVOM0aVDo2Dl0xvV2keVFRyFqU+lIcr1mkCZRst07IHZ3jBvy2BqP1
         /bIQ==
X-Gm-Message-State: APjAAAVOWs8yCgcdML+NPT0lNwckr7GT22Po59zDXJY8a1aFtmza/UOu
        hwWnwtpnhmSkgTnjtGr+Fe2RxdH4atvDK8QIpR0=
X-Google-Smtp-Source: APXvYqwOYL6l/1Lb+X/MmTJtqY36StiIa0PKZ+W9pnloEyELi6wxlXec1BgwoTyrnIQmVl1lph0TPhcoazHCkPM1AuM=
X-Received: by 2002:a81:4ecc:: with SMTP id c195mr60862161ywb.31.1559109500665;
 Tue, 28 May 2019 22:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190527172655.9287-1-amir73il@gmail.com> <20190528200659.GK5221@magnolia>
In-Reply-To: <20190528200659.GK5221@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 08:58:09 +0300
Message-ID: <CAOQ4uxgq-A7qpi8Mj-N2f2TC1fCHZ45yBc0_KfA9CygwqLMNHw@mail.gmail.com>
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 11:07 PM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Mon, May 27, 2019 at 08:26:55PM +0300, Amir Goldstein wrote:
> > New link flags to request "atomic" link.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Hi Guys,
> >
> > Following our discussions on LSF/MM and beyond [1][2], here is
> > an RFC documentation patch.
> >
> > Ted, I know we discussed limiting the API for linking an O_TMPFILE
> > to avert the hardlinks issue, but I decided it would be better to
> > document the hardlinks non-guaranty instead. This will allow me to
> > replicate the same semantics and documentation to renameat(2).
> > Let me know how that works out for you.
> >
> > I also decided to try out two separate flags for data and metadata.
> > I do not find any of those flags very useful without the other, but
> > documenting them seprately was easier, because of the fsync/fdatasync
> > reference.  In the end, we are trying to solve a social engineering
> > problem, so this is the least confusing way I could think of to describe
> > the new API.
> >
> > First implementation of AT_ATOMIC_METADATA is expected to be
> > noop for xfs/ext4 and probably fsync for btrfs.
> >
> > First implementation of AT_ATOMIC_DATA is expected to be
> > filemap_write_and_wait() for xfs/ext4 and probably fdatasync for btrfs.
> >
> > Thoughts?
> >
> > Amir.
> >
> > [1] https://lwn.net/Articles/789038/
> > [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com/
> >
> >  man2/link.2 | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/man2/link.2 b/man2/link.2
> > index 649ba00c7..15c24703e 100644
> > --- a/man2/link.2
> > +++ b/man2/link.2
> > @@ -184,6 +184,57 @@ See
> >  .BR openat (2)
> >  for an explanation of the need for
> >  .BR linkat ().
> > +.TP
> > +.BR AT_ATOMIC_METADATA " (since Linux 5.x)"
> > +By default, a link operation followed by a system crash, may result in the
> > +new file name being linked with old inode metadata, such as out dated time
> > +stamps or missing extended attributes.
> > +.BR fsync (2)
> > +before linking the inode, but that involves flushing of volatile disk caches.
> > +
> > +A filesystem that accepts this flag will guaranty, that old inode metadata
> > +will not be exposed in the new linked name.
> > +Some filesystems may internally perform
> > +.BR fsync (2)
> > +before linking the inode to provide this guaranty,
> > +but often, filesystems will have a more efficient method to provide this
> > +guaranty without flushing volatile disk caches.
> > +
> > +A filesystem that accepts this flag does
> > +.BR NOT
> > +guaranty that the new file name will exist after a system crash, nor that the
> > +current inode metadata is persisted to disk.
>
> Hmmm.  I think it would be much clearer to state the two expectations in
> the same place, e.g.:
>
> "A filesystem that accepts this flag guarantees that after a successful
> call completion, the filesystem will return either (a) the version of
> the metadata that was on disk at the time the call completed; (b) a
> newer version of that metadata; or (c) -ENOENT.  In other words, a
> subsequent access of the file path will never return metadata that was
> obsolete at the time that the call completed, even if the system crashes
> immediately afterwards."

Your feedback is along the same line as Ted's feedback.
I will try out the phrasing that Ted proposed, will see how that goes...

>
> Did I get that right?  I /think/ this means that one could implement Ye
> Olde Write And Rename as:
>
> fd = open(".", O_TMPFILE...);
> write(fd);
> fsync(fd);

Certainly not fsync(), that what my "counter-fsync()" phrasing was trying to
convey. The flags are meant as a "cheaper" replacement for that fsync().

> snprintf(path, PATH_MAX, "/proc/self/fd/%d", fd);
> linkat(AT_FDCWD, path, AT_FDCWD, "file.txt",
>         AT_EMPTY_PATH | AT_ATOMIC_DATA | AT_ATOMIC_METADATA);
>
> (Still struggling to figure out what userspace programs would use this
> for...)
>

There are generally two use cases:

1. Flushing volatile disk caches is very expensive.
In this case sync_file_range(SYNC_FILE_RANGE_WRITE_AND_WAIT)
is cheaper than fdatasync() for a preallocated file and obviously a noop
for AT_ATOMIC_METADATA in "S.O.M.C" filesystem is cheaper than
a journal commit.

2. Highly concurrent metadata workloads
Many users running  AT_ATOMIC_METADATA concurrently are much
less likely to interfere each other than many users running fsync concurrently.

IWO, when I'm using fsync() to provide the AT_ATOMIC_METADATA guarantee
on a single journal fs, other users pay the penalty for a guaranty that I didn't
ask for (i.e. persistency).

Thanks,
Amir.
