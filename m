Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8330C177550
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgCCLeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 06:34:00 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:32894 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCCLeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:34:00 -0500
Received: by mail-il1-f195.google.com with SMTP id r4so2478302iln.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6byiiSiBg+O9qfUoKK2ksV0ZQAH63X1Hb8rEqsCdvnA=;
        b=BDwb6Aqrx0xtaZxAiJzRl8XeyjQnOY6DfKQWnfKlSJyw80tDndkNTO1YIRtxXiY32u
         jX+rF79QYJ93n6uKhvAsKktrD0A98qVn8g0o2FP4zpYgjGgDbSp4ye0NeZ/S6xaEu/9P
         jinoTbqOhlXGvA2nE26OcaLpGlhLDzhcnIkuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6byiiSiBg+O9qfUoKK2ksV0ZQAH63X1Hb8rEqsCdvnA=;
        b=IRcwfB8cgC2LOXfoSf66kmFBBW+t3Dh+5ObSGN1va7I8h8O4qchzfhr/2xu/H2jvjS
         it+BNwV5xCWlcNlhk2/5UW196KYiFbag3T8OpiCTm1GbTFZihmTIZFiucoIVHd3+Lx2F
         oKtDWAqh/eSA6fJ95XulRsxHyIxsG20y4UCQBTIQbW0mVcipevdEe1DmFqQztDAv58L6
         rloKVvscQS6NGhYaRMHsMrNJbaZsjfpWL39LSYgSZj0GKHoeZe0gJ32aX0DKY/r+SmTk
         qism5An7zvL2fPP2bjsv2IcC1CotT6JB42tFnfIVnpmcQx1HGPs703BIcvNfMhZRcl9L
         +plQ==
X-Gm-Message-State: ANhLgQ0fG4SSj/xV3ahg8V23zugtCcriYCpmTv6chjXKNns19rfDHnRm
        N17bwUeOrOG5gFHZpGFWdSQ1n4l4uNh4sZ9oljpqoA==
X-Google-Smtp-Source: ADFU+vtdZi1ZHmFd0i6HeNGyBbTzdkdeTY8UruU2lDGdtfEbDHYjU8QcXctIQ1YFTTxOKq3DU5hMTC1oZ34IhqBV7I8=
X-Received: by 2002:a92:89cb:: with SMTP id w72mr4195534ilk.252.1583235239625;
 Tue, 03 Mar 2020 03:33:59 -0800 (PST)
MIME-Version: 1.0
References: <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303100045.zqntjjjv6npvs5zl@wittgenstein> <CAJfpegu_O=wQsewDWdM39dhkrEoMPG4ZBkTQOsWTgFnYmvrLeA@mail.gmail.com>
 <20200303102541.diud7za3vvjvqco4@wittgenstein>
In-Reply-To: <20200303102541.diud7za3vvjvqco4@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Mar 2020 12:33:48 +0100
Message-ID: <CAJfpegu7CTmE8XfL-Oqp3KkjJNU5FM+VJxohFfK9dO+xnJAdYA@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 3, 2020 at 11:25 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Mar 03, 2020 at 11:13:50AM +0100, Miklos Szeredi wrote:
> > On Tue, Mar 3, 2020 at 11:00 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:

> > > More magic links to beam you around sounds like a bad idea. We had a
> > > bunch of CVEs around them in containers and they were one of the major
> > > reasons behind us pushing for openat2(). That's why it has a
> > > RESOLVE_NO_MAGICLINKS flag.
> >
> > No, that link wouldn't beam you around at all, it would end up in an
> > internally mounted instance of a mountfs, a safe place where no
>
> Even if it is a magic link to a safe place it's a magic link. They
> aren't a great solution to this problem. fsinfo() is cleaner and
> simpler as it creates a context for a supervised mount which gives the a
> managing application fine-grained control and makes it easily
> extendable.

Yeah, it's a nice and clean interface in the ioctl(2) sense. Sure,
fsinfo() is way better than ioctl(), but it at the core it's still the
same syscall multiplexer, do everything hack.

> Also, we're apparently at the point where it seems were suggesting
> another (pseudo)filesystem to get information about filesystems.

Implementation detail.  Why would you care?

Thanks,
Miklos
