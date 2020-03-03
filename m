Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D385217743D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 11:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgCCKcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 05:32:46 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43213 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgCCKcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:32:45 -0500
Received: by mail-il1-f195.google.com with SMTP id o18so2279421ilg.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 02:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OjMBCp185rGeJiYNbICf2InVl2PDcWD4SEMMWbNn20=;
        b=EgBq0A2ueanm2MvysZvBDL8USSRx6pTzWx2f04bJ4DFxzma7xFHZNG2+Rg4SZkgd+O
         K26n1FQBeiKe8uXeeDPX7xyIybxQZzyZVVzfse2xhJ/Cz1Oj1bDVo17iaVLZVj0WRG8s
         nQx5gnQ9btpq29VS2/nKW+UhtVD3Ik2avMa90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OjMBCp185rGeJiYNbICf2InVl2PDcWD4SEMMWbNn20=;
        b=NsCd7+PJnT6EbLUApzMl6wUmu7eX9oPBF6sqQm0tTw26jx4KswNnrLEU27LB/Dh3tR
         jxfpcWWX/AHMTz74V7h9ztxp5CTLnwog/1C62BqIgURzoxkUf9j/fVWaU8lSzjuBJdPd
         7PRnJpQtec2BWFgn5yEPCjFXYXmgT8iVgmQ/1jn6chmuN+m1LZxYtTJ/gpjjWs+Z/Wd7
         9jJjQPWMJKKVeLhOQz2j6wb5VV54fPtYweqKHjAaRR+JV4jejxyT7lqEzaRtQ1kuHcCF
         fBbHp/Q3CJsqdZWNCck4hfNu21cZzVcm58WeQ8ApOgLdMkq3mFTdVdvjd9Ng8fXizOQJ
         1++Q==
X-Gm-Message-State: ANhLgQ0Dz08WCKllTJURbkDpGSUTQAnCbVyKMNim2F1koK2gh0C/enpg
        diZGvbVfWuIPZJHNBBrN/pdQzWeIIb+q+KqpGtHcojSM
X-Google-Smtp-Source: ADFU+vtBUu4UN/503DlgMuAkB/+JNw29l5C01S+SzUIIjaQZb5bNvIbrd2zfhpo/xTL/HkTPnrVFO0z7X5d23lRKXyY=
X-Received: by 2002:a92:89cb:: with SMTP id w72mr3979428ilk.252.1583231564670;
 Tue, 03 Mar 2020 02:32:44 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <CAJfpegtemv64mpmTRT6ViHmsWq4nNE4KQvuHkNCYozRU7dQd8Q@mail.gmail.com> <06d2dbf0-4580-3812-bb14-34c6aa615747@redhat.com>
In-Reply-To: <06d2dbf0-4580-3812-bb14-34c6aa615747@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Mar 2020 11:32:33 +0100
Message-ID: <CAJfpegsW5S3dRhhfGyAnhLEDjBxMQRBda5fsnXQ+=S=4YR0MCA@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
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

On Tue, Mar 3, 2020 at 11:22 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> Hi,
>
> On 03/03/2020 09:48, Miklos Szeredi wrote:
> > On Tue, Mar 3, 2020 at 10:26 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >> On Tue, Mar 3, 2020 at 10:13 AM David Howells <dhowells@redhat.com> wrote:
> >>> Miklos Szeredi <miklos@szeredi.hu> wrote:
> >>>
> >>>> I'm doing a patch.   Let's see how it fares in the face of all these
> >>>> preconceptions.
> >>> Don't forget the efficiency criterion.  One reason for going with fsinfo(2) is
> >>> that scanning /proc/mounts when there are a lot of mounts in the system is
> >>> slow (not to mention the global lock that is held during the read).
> > BTW, I do feel that there's room for improvement in userspace code as
> > well.  Even quite big mount table could be scanned for *changes* very
> > efficiently.  l.e. cache previous contents of /proc/self/mountinfo and
> > compare with new contents, line-by-line.  Only need to parse the
> > changed/added/removed lines.
> >
> > Also it would be pretty easy to throttle the number of updates so
> > systemd et al. wouldn't hog the system with unnecessary processing.
> >
> > Thanks,
> > Miklos
> >
>
> At least having patches to compare would allow us to look at the
> performance here and gain some numbers, which would be helpful to frame
> the discussions. However I'm not seeing how it would be easy to throttle
> updates... they occur at whatever rate they are generated and this can
> be fairly high. Also I'm not sure that I follow how the notifications
> and the dumping of the whole table are synchronized in this case, either.

What I meant is optimizing current userspace without additional kernel
infrastructure.   Since currently there's only the monolithic
/proc/self/mountinfo, it's reasonable that if the rate of change is
very high, then we don't re-read this table on every change, only
within a reasonable time limit (e.g. 1s) to provide timely updates.
Re-reading the table on every change would (does?) slow down the
system so that the actual updates would even be slower, so throttling
in this case very much  makes sense.

Once we have per-mount information from the kernel, throttling updates
probably does not make sense.

Thanks,
Miklos
