Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF81DF56F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 20:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfJUSyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 14:54:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39709 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfJUSyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:54:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so7057238plp.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2lNu3wJMupeX6OsWxDB5URIVOVHHQXmSejNHXu9O6Ts=;
        b=S1ZQF3WDGyHbVjCQsSClAXzJkMeyqk4At9hncfL/RcuwbOntwK/SITBsrBkfoWMRUT
         TqbSSlfmJVi2xUeRj/B04PUi0TpgNyLpSAFp1xJIEnpmw4ucknJ1OONE6S0y8t7m2F1b
         EhMhdFTNCQgoxKDt+rmSD8ZXS5TLZM3XcwGZLJlP+LarfLXMI0f36V+pZ8Wus9gXCuH7
         IWUVlNj/fXQzve11q0pI/OTb3smdHzgWTtfVBCJRMP5uW3Z8Btj76kg8lZOHKki0yjCy
         zZOO8Y2o6FWRDk8unPycu9gwJM1c9iZwG0t9SuelDXdDdAumZjHEvPZTcDoruWWJ4E9Y
         UOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lNu3wJMupeX6OsWxDB5URIVOVHHQXmSejNHXu9O6Ts=;
        b=IinfdcexTc7aGx/mtuIwcEMnINxCswV9B0TTv/sXLFxCutANj4DFxl7neyMogoZe1s
         XMgbF64Uyvb5HD6QonYqeZj7RL23OdM7X995OPJQL8+q7LPmT7mZoCv0+k6VV6K1ruEy
         xcWkMQMi7eBQtPCU1FAeVzefwfM3qLcu0ZWLJ603Gs5jzuDUHNDnmNcfCWcARb7evAoj
         ZrxnxVj4MZoA314XeMV4utZt+sTyr5gsbtidLhlEPmRu4EERJJ1B7yuFVvSnFSBLelp6
         P5dVtKM23vT49RSSQ8l1Z0ydbkjMCcmIyK3hhFIzHNVlP1LV4e4jp2HlUa0mdr3ojpMn
         DEIA==
X-Gm-Message-State: APjAAAXnTQI8wqeKvGhtrbWrHdip8AtIkmiZkptn8zY5D4sr9Uu6z4Jo
        6EeUjSMskutLq6XVH0lIbu+PZg==
X-Google-Smtp-Source: APXvYqzR6mx7801niDofcAX3CiEzxhfuxTmp6paOqzwxaZx0Vu8keEXp7NeebEFDGwjdfVfPB0n8DA==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5mr26052636plk.33.1571684040062;
        Mon, 21 Oct 2019 11:54:00 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:4637])
        by smtp.gmail.com with ESMTPSA id c125sm16433599pfa.107.2019.10.21.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 11:53:59 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:53:56 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH man-pages] Document encoded I/O
Message-ID: <20191021185356.GB81648@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
 <CAOQ4uxh_pZSiMmD=46Mc3o0GE+svXuoC155P_9FGJXdsE4cweg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh_pZSiMmD=46Mc3o0GE+svXuoC155P_9FGJXdsE4cweg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:18:13AM +0300, Amir Goldstein wrote:
> CC: Ted
> 
> What ever happened to read/write ext4 encrypted data API?
> https://marc.info/?l=linux-ext4&m=145030599010416&w=2
> 
> Can we learn anything from the ext4 experience to improve
> the new proposed API?

I wasn't aware of these patches, thanks for pointing them out. Ted, do
you have any thoughts about making this API work for fscrypt?

> On Wed, Oct 16, 2019 at 12:29 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > This adds a new page, rwf_encoded(7), providing an overview of encoded
> > I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
> > reference it.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  man2/fcntl.2       |  10 +-
> >  man2/open.2        |  13 ++
> >  man2/readv.2       |  46 +++++++
> >  man7/rwf_encoded.7 | 297 +++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 365 insertions(+), 1 deletion(-)
> >  create mode 100644 man7/rwf_encoded.7
> >
> > diff --git a/man2/fcntl.2 b/man2/fcntl.2
> > index fce4f4c2b..76fe9cc6f 100644
> > --- a/man2/fcntl.2
> > +++ b/man2/fcntl.2
> > @@ -222,8 +222,9 @@ On Linux, this command can change only the
> >  .BR O_ASYNC ,
> >  .BR O_DIRECT ,
> >  .BR O_NOATIME ,
> > +.BR O_NONBLOCK ,
> >  and
> > -.B O_NONBLOCK
> > +.B O_ENCODED
> >  flags.
> >  It is not possible to change the
> >  .BR O_DSYNC
> > @@ -1803,6 +1804,13 @@ Attempted to clear the
> >  flag on a file that has the append-only attribute set.
> >  .TP
> >  .B EPERM
> > +Attempted to set the
> > +.B O_ENCODED
> > +flag and the calling process did not have the
> > +.B CAP_SYS_ADMIN
> > +capability.
> > +.TP
> > +.B EPERM
> >  .I cmd
> >  was
> >  .BR F_ADD_SEALS ,
> > diff --git a/man2/open.2 b/man2/open.2
> > index b0f485b41..cdd3c549c 100644
> > --- a/man2/open.2
> > +++ b/man2/open.2
> > @@ -421,6 +421,14 @@ was followed by a call to
> >  .BR fdatasync (2)).
> >  .IR "See NOTES below" .
> >  .TP
> > +.B O_ENCODED
> > +Open the file with encoded I/O permissions;
> 
> 1. I find the name of the flag confusing.
> Yes, most people don't read documentation so carefully (or at all)
> so they will assume O_ENCODED will affect read/write or that it
> relates to RWF_ENCODED in a similar way that O_SYNC relates
> to RWF_SYNC (i.e. logical OR and not logical AND).
> 
> I am not good at naming and to prove it I will propose:
> O_PROMISCUOUS, O_MAINTENANCE, O_ALLOW_ENCODED

Agreed, the name is misleading. I can't think of anything better than
O_ALLOW_ENCODED, so I'll go with that unless someone comes up with
something better :)

> 2. While I see no harm in adding O_ flag to open(2) for this
> use case, I also don't see a major benefit in adding it.
> What if we only allowed setting the flag via fcntl(2) which returns
> an error on old kernels?
> Since unlike most O_ flags, O_ENCODED does NOT affect file
> i/o without additional opt-in flags, it is not standard anyway and
> therefore I find that setting it only via fcntl(2) is less error prone.

If I make this fcntl-only, then it probably shouldn't be through
F_GETFL/F_SETFL (it'd be pretty awkward for an O_ flag to not be valid
for open(), and also awkward to mix some non-O_ flag with O_ flags for
F_GETFL/F_SETFL). So that leaves a couple of options:

1. Get/set it with F_GETFD/F_SETFD, which is currently only used for
   FD_CLOEXEC. That also silently ignores unknown flags, but as with the
   O_ flag option, I don't think that's a big deal for FD_ALLOW_ENCODED.
2. Add a new fcntl command (F_GETFD2/F_SETFD2?). This seems like
   overkill to me.

However, both of these options are annoying to implement. Ideally, we
wouldn't have to add another flags field to struct file. But, to reuse
f_flags, we'd need to make sure that FD_ALLOW_ENCODED doesn't collide
with other O_ flags, and we'd probably want to hide it from F_GETFL. At
that point, it might as well be an O_ flag.

It seems to me that it's more trouble than it's worth to make this not
an O_ flag, but please let me know if you see a nice way to do so.

> > +see
> > +.BR rwf_encoded (7).
> > +The caller must have the
> > +.B CAP_SYS_ADMIN
> > +capabilty.
> > +.TP
> >  .B O_EXCL
> >  Ensure that this call creates the file:
> >  if this flag is specified in conjunction with
> > @@ -1168,6 +1176,11 @@ did not match the owner of the file and the caller was not privileged.
> >  The operation was prevented by a file seal; see
> >  .BR fcntl (2).
> >  .TP
> > +.B EPERM
> > +The
> > +.B O_ENCODED
> > +flag was specified, but the caller was not privileged.
> > +.TP
> >  .B EROFS
> >  .I pathname
> >  refers to a file on a read-only filesystem and write access was
> > diff --git a/man2/readv.2 b/man2/readv.2
> > index af27aa63e..aa60b980a 100644
> > --- a/man2/readv.2
> > +++ b/man2/readv.2
> > @@ -265,6 +265,11 @@ the data is always appended to the end of the file.
> >  However, if the
> >  .I offset
> >  argument is \-1, the current file offset is updated.
> > +.TP
> > +.BR RWF_ENCODED " (since Linux 5.6)"
> > +Read or write encoded (e.g., compressed) data.
> > +See
> > +.BR rwf_encoded (7).
> >  .SH RETURN VALUE
> >  On success,
> >  .BR readv (),
> > @@ -284,6 +289,13 @@ than requested (see
> >  and
> >  .BR write (2)).
> >  .PP
> > +If
> > +.B
> > +RWF_ENCODED
> > +was specified in
> > +.IR flags ,
> > +then the return value is the number of encoded bytes.
> > +.PP
> >  On error, \-1 is returned, and \fIerrno\fP is set appropriately.
> >  .SH ERRORS
> >  The errors are as given for
> > @@ -314,6 +326,40 @@ is less than zero or greater than the permitted maximum.
> >  .TP
> >  .B EOPNOTSUPP
> >  An unknown flag is specified in \fIflags\fP.
> > +.TP
> > +.B EOPNOTSUPP
> > +.B RWF_ENCODED
> > +is specified in
> > +.I flags
> > +and the filesystem does not implement encoded I/O.
> > +.TP
> > +.B EPERM
> > +.B RWF_ENCODED
> > +is specified in
> > +.I flags
> > +and the file was not opened with the
> > +.B O_ENCODED
> > +flag.
> > +.PP
> > +.BR preadv2 ()
> > +can fail for the following reasons:
> > +.TP
> > +.B EFBIG
> > +.B RWF_ENCODED
> > +is specified in
> > +.I flags
> > +and buffers in
> > +.I iov
> > +were not big enough to return the encoded data.
> 
> I don't like it that EFBIG is returned for read.
> While EXXX values meaning is often very vague, EFBIG meaning
> is still quite consistent - it is always a write related error when trying
> to change i_size above fs/system limits.
> 
> In the case above, I find E2BIG much more appropriate.
> Although its original meaning was too long arg list, it already grew
> several cases where it generally means "buffer cannot hold the result"
> like the case with msgrcv(2) and listxattr(2).

Yes, E2BIG is a better fit, I'll change it.
