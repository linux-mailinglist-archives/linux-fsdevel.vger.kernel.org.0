Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0793B177C87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 17:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgCCQ62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 11:58:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44141 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCCQ61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:58:27 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so3688725oia.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 08:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScbkU4HAVEXYpr6J/KNSyKOPxHj3lMzwfJpy31vHYIA=;
        b=QQnIXHnDRgDAtVyGUu1WuSHqQIHl9XOB/MvTUd8ZqZ57/hDiO++NKjWutJOotOc9Gs
         YFdM8Mb3kAx3zmXKo2Tltvdz478H2kSlV6SkbCxs9yqVpEWqoqdrFlCfJgI2t4aPEwSz
         NhhF5I4J9HqNFKeDw2E21bgVgCDVqUAhKs24c9NhXBdm67NPGJNVwpy0AA4XmmPKMyZF
         M7S8XgUGhgMct5GOy1xnsBUM8edxeBMLHwngwlHPg/bLXCejvKnZkemKMbCxfiYoO553
         OXolpr7ADo5jJnOti3uUKuqDBfyVuu+WRbWbTZKSVo6IiEPb5VEKlELPani9HF6yMjO8
         QCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScbkU4HAVEXYpr6J/KNSyKOPxHj3lMzwfJpy31vHYIA=;
        b=hWxt/raXkMGph8wG6XkDuEIL9f79EOwU9R8AL8T2t/j7FKfWmy/Th4C0hPG7J/hs05
         pkrBQRvs6+0aYvDM+pEjqWlH8qEAta+byFQUWOQKK8IN/GkWb2UlxgcNy+t7bwjMbpsv
         UHkW+E6RVLKG6aBPjF8LaEfxL5R2bZkdZQdjdaM+NDBUwjE7SarfbR248mAdOY33MKMZ
         fW3mLeHSTx5cBLr0VofzGaLQMNuACQ3WnRuuFMAvthVTsD3eMagOyYhZXzRgTQaJaWhA
         5f4aRUBy+vi6jzW8CXcgMzIRIIMtVgKt0dtOBFM66CyuXeTItuHxxZ4GcPfgmfcyUHjJ
         tybQ==
X-Gm-Message-State: ANhLgQ0lV5EVKjZYu/Agn03EBlokpC54flh6X6J18PPphw82yE2kmDqd
        bjRRlALN4LiKT1Y4e26LkAFyZ7eyK6IJOaOVcXPphw==
X-Google-Smtp-Source: ADFU+vt35orZwY0yvmiwtHL/Y5b+HBGpMm3TOKv9W+oTPSR7MVPOf9AJ2fU7F+00NzOC+jaFdEOnsJtC0ykS3vIHHUM=
X-Received: by 2002:a05:6808:8d0:: with SMTP id k16mr3125414oij.68.1583254706145;
 Tue, 03 Mar 2020 08:58:26 -0800 (PST)
MIME-Version: 1.0
References: <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home> <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com> <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com> <CAJfpegtFyZqSRzo3uuXp1S2_jJJ29DL=xAwKjpEGvyG7=AzabA@mail.gmail.com>
 <20200303142958.GB47158@kroah.com> <CAG48ez1sdUJzp85oqBw8vCpc3E4Sb26M9pj2zHhnKpb-1+f4vg@mail.gmail.com>
 <20200303165103.GA731597@kroah.com>
In-Reply-To: <20200303165103.GA731597@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Mar 2020 17:57:58 +0100
Message-ID: <CAG48ez3Fnc9qbAE5OTpqmWmPPfGXHtYPoQEm1w6pKuZnBNNwCg@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 3, 2020 at 5:51 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 03, 2020 at 03:40:24PM +0100, Jann Horn wrote:
> > On Tue, Mar 3, 2020 at 3:30 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Tue, Mar 03, 2020 at 03:10:50PM +0100, Miklos Szeredi wrote:
> > > > On Tue, Mar 3, 2020 at 2:43 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> > > >
> > > > > > If buffer is too small to fit the whole file, return error.
> > > > >
> > > > > Why?  What's wrong with just returning the bytes asked for?  If someone
> > > > > only wants 5 bytes from the front of a file, it should be fine to give
> > > > > that to them, right?
> > > >
> > > > I think we need to signal in some way to the caller that the result
> > > > was truncated (see readlink(2), getxattr(2), getcwd(2)), otherwise the
> > > > caller might be surprised.
> > >
> > > But that's not the way a "normal" read works.  Short reads are fine, if
> > > the file isn't big enough.  That's how char device nodes work all the
> > > time as well, and this kind of is like that, or some kind of "stream" to
> > > read from.
> > >
> > > If you think the file is bigger, then you, as the caller, can just pass
> > > in a bigger buffer if you want to (i.e. you can stat the thing and
> > > determine the size beforehand.)
> > >
> > > Think of the "normal" use case here, a sysfs read with a PAGE_SIZE
> > > buffer.  That way userspace "knows" it will always read all of the data
> > > it can from the file, we don't have to do any seeking or determining
> > > real file size, or anything else like that.
> > >
> > > We return the number of bytes read as well, so we "know" if we did a
> > > short read, and also, you could imply, if the number of bytes read are
> > > the exact same as the number of bytes of the buffer, maybe the file is
> > > either that exact size, or bigger.
> > >
> > > This should be "simple", let's not make it complex if we can help it :)
> > >
> > > > > > Verify that the number of bytes read matches the file size, otherwise
> > > > > > return error (may need to loop?).
> > > > >
> > > > > No, we can't "match file size" as sysfs files do not really have a sane
> > > > > "size".  So I don't want to loop at all here, one-shot, that's all you
> > > > > get :)
> > > >
> > > > Hmm.  I understand the no-size thing.  But looping until EOF (i.e.
> > > > until read return zero) might be a good idea regardless, because short
> > > > reads are allowed.
> > >
> > > If you want to loop, then do a userspace open/read-loop/close cycle.
> > > That's not what this syscall should be for.
> > >
> > > Should we call it: readfile-only-one-try-i-hope-my-buffer-is-big-enough()?  :)
> >
> > So how is this supposed to work in e.g. the following case?
[...]
> >   int maps = open("/proc/self/maps", O_RDONLY);
> >   static char buf[0x100000];
> >   int res;
> >   do {
> >     res = read(maps, buf, sizeof(buf));
> >   } while (res > 0);
> > }
[...]
> >
> > The kernel is randomly returning short reads *with different lengths*
> > that are vaguely around PAGE_SIZE, no matter how big the buffer
> > supplied by userspace is. And while repeated read() calls will return
> > consistent state thanks to the seqfile magic, repeated readfile()
> > calls will probably return garbage with half-complete lines.
>
> Ah crap, I forgot about seqfile, I was only considering the "simple"
> cases that sysfs provides.
>
> Ok, Miklos, you were totally right, I'll loop and read until the end of
> file or buffer, which ever comes first.

I wonder what we should do when one of the later reads returns an
error code. As in, we start the first read, get a short read (maybe
because a signal arrived), try a second read, get -EINTR. Do we just
return the error code? That'd probably work fine for most usecases -
e.g. if "top" is reading stuff from procfs, and that gets interrupted
by SIGWINCH or so, it doesn't matter that we've already started the
first read; the only thing "top" really needs to know is that the read
was a short read and it has to retry.
