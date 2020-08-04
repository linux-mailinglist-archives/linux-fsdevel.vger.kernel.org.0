Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1902F23BC58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHDOhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbgHDOhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:37:04 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E4FC06179E
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 07:37:02 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v22so19259599edy.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GO/PaZjgiFmbIuDRQzdv2wEQ6v47brbCE/X/qo+KGSI=;
        b=MGzOwyvudquI7+thXiAsvTjduPmqjSU+8Jg6qbo7Hm6IpMNgUd3ikSIr6D06QgaZna
         7Jf9ZKzPaRpkYpXfUnQmdC0A1myZp2zEJg9WyuiLwti06vtSHx2MffTqzYijOIG3dO+S
         wq+dyltnrBdKrjDuxsS6rTu9Kv1j7ITrSwn3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GO/PaZjgiFmbIuDRQzdv2wEQ6v47brbCE/X/qo+KGSI=;
        b=nT4Nmq5/BAjX8NBVnjMDNzqBZpx1bB4Z+cFdpPp0ucfCTKj2Q3A7WNIoQx8Lnfdb2K
         a/MfYvhXYQ71jRto3uFqqJKR2Wh3Fju3dh7zEEhcZ4gq+MJLvKa3e65nDN+7kUQaGAM8
         ADJZLcoVV9pq7/wkxXU9wugUeloqlJOzmz6noFr2Vdj+hBh2dnG0DTR1LTZkdYgU+doz
         PSXnMOd8o+CVQFvMoUUkpdG9CHeA7g09oCGNUowJlk6duf3P3VKGI9GFS8Q5Ljyvr1nw
         ATk6t3iIZWZCq8LSpocq/gYQhrpVvWgTlVMnq7J0ugxSw8SJNorYBcj3znoVwCIhpOHX
         cVKw==
X-Gm-Message-State: AOAM5301/F3xm55fOHjVsPhvC3I6MTgFQ+1IBEd/X2YdXiAuL7b31Mix
        MFtsmyQSe8EqbO4OQfA/Zkn7ZmjkaBWALQZMDzMUJQ==
X-Google-Smtp-Source: ABdhPJw8dVKolbYySKTpAVDj8Qqnrnk5bHQe6836go+X2Mkbuxqboankiu/s4QrpC7g8HyY1lZnZFgsI4Gl9xJDkvQs=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr20551403edx.358.1596551821283;
 Tue, 04 Aug 2020 07:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com> <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
In-Reply-To: <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Aug 2020 16:36:50 +0200
Message-ID: <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
Subject: Re: [GIT PULL] Filesystem Information
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 4, 2020 at 4:15 AM Ian Kent <raven@themaw.net> wrote:
>
> On Mon, 2020-08-03 at 18:42 +0200, Miklos Szeredi wrote:
> > On Mon, Aug 3, 2020 at 5:50 PM David Howells <dhowells@redhat.com>
> > wrote:
> > >
> > > Hi Linus,
> > >
> > > Here's a set of patches that adds a system call, fsinfo(), that
> > > allows
> > > information about the VFS, mount topology, superblock and files to
> > > be
> > > retrieved.
> > >
> > > The patchset is based on top of the mount notifications patchset so
> > > that
> > > the mount notification mechanism can be hooked to provide event
> > > counters
> > > that can be retrieved with fsinfo(), thereby making it a lot faster
> > > to work
> > > out which mounts have changed.
> > >
> > > Note that there was a last minute change requested by Mikl=C3=B3s: th=
e
> > > event
> > > counter bits got moved from the mount notification patchset to this
> > > one.
> > > The counters got made atomic_long_t inside the kernel and __u64 in
> > > the
> > > UAPI.  The aggregate changes can be assessed by comparing pre-
> > > change tag,
> > > fsinfo-core-20200724 to the requested pull tag.
> > >
> > > Karel Zak has created preliminary patches that add support to
> > > libmount[*]
> > > and Ian Kent has started working on making systemd use these and
> > > mount
> > > notifications[**].
> >
> > So why are you asking to pull at this stage?
> >
> > Has anyone done a review of the patchset?
>
> I have been working with the patch set as it has evolved for quite a
> while now.
>
> I've been reading the kernel code quite a bit and forwarded questions
> and minor changes to David as they arose.
>
> As for a review, not specifically, but while the series implements a
> rather large change it's surprisingly straight forward to read.
>
> In the time I have been working with it I haven't noticed any problems
> except for those few minor things that I reported to David early on (in
> some cases accompanied by simple patches).
>
> And more recently (obviously) I've been working with the mount
> notifications changes and, from a readability POV, I find it's the
> same as the fsinfo() code.
>
> >
> > I think it's obvious that this API needs more work.  The integration
> > work done by Ian is a good direction, but it's not quite the full
> > validation and review that a complex new API needs.
>
> Maybe but the system call is fundamental to making notifications useful
> and, as I say, after working with it for quite a while I don't fell
> there's missing features (that David hasn't added along the way) and
> have found it provides what's needed for what I'm doing (for mount
> notifications at least).

Apart from the various issues related to the various mount ID's and
their sizes, my general comment is (and was always): why are we adding
a multiplexer for retrieval of mostly unrelated binary structures?

<linux/fsinfo.h> is 345 lines.  This is not a simple and clean API.

A simple and clean replacement API would be:

int get_mount_attribute(int dfd, const char *path, const char
*attr_name, char *value_buf, size_t buf_size, int flags);

No header file needed with dubiously sized binary values.

The only argument was performance, but apart from purely synthetic
microbenchmarks that hasn't been proven to be an issue.

And notice how similar the above interface is to getxattr(), or the
proposed readfile().  Where has the "everything is  a file" philosophy
gone?

I think we already lost that with the xattr API, that should have been
done in a way that fits this philosophy.  But given that we  have "/"
as the only special purpose char in filenames, and even repetitions
are allowed, it's hard to think of a good way to do that.  Pity.

Still I think it would be nice to have a general purpose attribute
retrieval API instead of the multiplicity of binary ioctls, xattrs,
etc.

Is that totally crazy?  Nobody missing the beauty in recently introduced AP=
Is?

Thanks,
Miklos
