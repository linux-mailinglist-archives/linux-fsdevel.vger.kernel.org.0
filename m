Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801731720EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgB0OqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 09:46:00 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41217 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbgB0Npj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:45:39 -0500
Received: by mail-il1-f193.google.com with SMTP id f10so2441375ils.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 05:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8OnTzg5LRFjVMbn8DLKRBIEARILm6ghNdG6yQfmP38=;
        b=csZxDWdp9Kg2a9YfxdWiQA3V9+CoKoVZc0EZnmskUOShlrcXcpWMgE9o4u6YRiHDII
         3lY1aufSeabIIc6erb1oS/km4U0n3lTdwzbGWKhOCS7bpEQ8U3Zh6X5Ldpb/jYnFuL/e
         x43KESU3syYK2PxnF02uwj9pUFlwx7F4kS80Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8OnTzg5LRFjVMbn8DLKRBIEARILm6ghNdG6yQfmP38=;
        b=MkWH4Eji0XFgUsx1K4i9EB46Webttf38vU8c0p57H/hTJ7jEuY6SW9RlqvVG1FD486
         vyZ70piwVTeCL3Ypu13wzFg/ZpCRVGMi6MswaejtV+rQ2S67YCQ6Zm8Za+SOog2S3yQY
         jWEGdjkYPc60XvCvgjXP2No7G67Xbx+EjKlkkTJQz9PHxcvg9A9PjrGu/01WrC/AkAQz
         314oS+U1f45dM57u4X7diEM1/myDNPhVJJvroZadYUJ8RYT/GxcnmcsHYSd1ZzE+b+1L
         PKyhsMu/mzZyMYkp/dMOXh3TLg9Dq6/YRcFVpYXk/4ynupxcGCKbBIF8ESH1QsT43OiG
         k5lg==
X-Gm-Message-State: APjAAAWL0Wz+dturyVBlRtcSEOyuNne5yVQd35JbBBuUtEneKFCOyeg3
        bDOo91SnTbJe47L5hqXHJ5jh76UZe3ThYZx+mhKXRg==
X-Google-Smtp-Source: APXvYqzQ6BzhXtXlhNTUi8rTkHy3riEAJKrSKAZv8W+W43+NLOCgkCwSk3m7m7xDRMSgpYjkil26fYRlpnCcNnc0xlc=
X-Received: by 2002:a92:89c2:: with SMTP id w63mr5483209ilk.252.1582811138833;
 Thu, 27 Feb 2020 05:45:38 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
 <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
 <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com> <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
In-Reply-To: <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 27 Feb 2020 14:45:27 +0100
Message-ID: <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Ian Kent <raven@themaw.net>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 12:34 PM Ian Kent <raven@themaw.net> wrote:
>
> On Thu, 2020-02-27 at 10:36 +0100, Miklos Szeredi wrote:
> > On Thu, Feb 27, 2020 at 6:06 AM Ian Kent <raven@themaw.net> wrote:
> >
> > > At the least the question of "do we need a highly efficient way
> > > to query the superblock parameters all at once" needs to be
> > > extended to include mount table enumeration as well as getting
> > > the info.
> > >
> > > But this is just me thinking about mount table handling and the
> > > quite significant problem we now have with user space scanning
> > > the proc mount tables to get this information.
> >
> > Right.
> >
> > So the problem is that currently autofs needs to rescan the proc
> > mount
> > table on every change.   The solution to that is to
>
> Actually no, that's not quite the problem I see.
>
> autofs handles large mount tables fairly well (necessarily) and
> in time I plan to remove the need to read the proc tables at all
> (that's proven very difficult but I'll get back to that).
>
> This has to be done to resolve the age old problem of autofs not
> being able to handle large direct mount maps. But, because of
> the large number of mounts associated with large direct mount
> maps, other system processes are badly affected too.
>
> So the problem I want to see fixed is the effect of very large
> mount tables on other user space applications, particularly the
> effect when a large number of mounts or umounts are performed.
>
> Clearly large mount tables not only result from autofs and the
> problems caused by them are slightly different to the mount and
> umount problem I describe. But they are a problem nevertheless
> in the sense that frequent notifications that lead to reading
> a large proc mount table has significant overhead that can't be
> avoided because the table may have changed since the last time
> it was read.
>
> It's easy to cause several system processes to peg a fair number
> of CPU's when a large number of mounts/umounts are being performed,
> namely systemd, udisks2 and a some others. Also I've seen couple
> of application processes badly affected purely by the presence of
> a large number of mounts in the proc tables, that's not quite so
> bad though.
>
> >
> >  - add a notification mechanism   - lookup a mount based on path
> >  - and a way to selectively query mount/superblock information
> based on path ...
> >
> > right?
> >
> > For the notification we have uevents in sysfs, which also supplies
> > the
> > changed parameters.  Taking aside namespace issues and addressing
> > mounts would this work for autofs?
>
> The parameters supplied by the notification mechanism are important.
>
> The place this is needed will be libmount since it catches a broad
> number of user space applications, including those I mentioned above
> (well at least systemd, I think also udisks2, very probably others).
>
> So that means mount table info. needs to be maintained, whether that
> can be achieved using sysfs I don't know. Creating and maintaining
> the sysfs tree would be a big challenge I think.
>
> But before trying to work out how to use a notification mechanism
> just having a way to get the info provided by the proc tables using
> a path alone should give initial immediate improvement in libmount.

Adding Karel, Lennart, Zbigniew and util-linux@vger...

At a quick glance at libmount and systemd code, it appears that just
switching out the implementation in libmount will not be enough:
systemd is calling functions like mnt_table_parse_*() when it receives
a notification that the mount table changed.

What is the end purpose of parsing the mount tables?  Can systemd guys
comment on that?

Thanks,
Miklos
