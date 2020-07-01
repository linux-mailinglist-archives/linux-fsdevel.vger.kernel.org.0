Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF282108C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 11:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgGAJ6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 05:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgGAJ62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:58:28 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C877C061755
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2020 02:58:28 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t27so15556003ill.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2020 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0dHlgcv4sbxhgmkhvddO/jEH8IZWk/uLZU2aq4ocRCg=;
        b=Ni/KGkPRntWb0OaXZ02d3Lx7xYR57iM94ZASq4mMQN4BYm/yDNPwJPtiRB9JZTVkT3
         Y7KYCTlD4P53A2nmzsqcUngiQC019VPG0TTJ1399bYfGLORG81kvl3OGJEvhveUgebfG
         Nv1TSGEIxKo/yKiVwLfpiqa66rkc1jeu+wjO91SLwK8cFTsDKBIclSrF2DV/kiIhpBBi
         IIjxST3q/mpeL7Zer0Nvl5mZfL0OwGSdCyZg+9pLcm7oIbV1GRa3O9JDHGV5iTHUpM4c
         LMotFH6U0PgXF9pDXLwPBpPTY52tPVvkYwMAQowLA4QRPORWF57XyufsIzLGsvIAODM7
         le+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=0dHlgcv4sbxhgmkhvddO/jEH8IZWk/uLZU2aq4ocRCg=;
        b=J4K2SfYzp5iFHnGXp8Wr6Fh/3UautX96FNIugesOFVqA9/O5UBK4z0kXFDYZUq2f9I
         DCl4VnUyno7SpQT1REOoqzJx+/Rwjnl3iXdcZ9764/5ysbMGi3BKwc50yvqd88CunGcg
         GIGay9lKgvdX6/Lmh49OOk81UUuzCLuNo9adNN3tsiUuPwBwet0XMGF60elZ8TS6s94E
         mwBQWVCbaYsaloSu1iE7JgMcNSL+1qzYeED+XrBEFp2sm3BUaE/zc6MbUtPL3xeC68X0
         leTV5DT0IviCA3+HP+1ZngIm74LlEc08UKc+hRqCpyzlr6bBcaZpmPmRmHnQTZGqNINJ
         gbHw==
X-Gm-Message-State: AOAM533ZV3hV3jUHJIQ3bfssDuqOoFPJfW1BkghR3tQDwuU1XonveBBb
        soFzzsPilcjdDzN9p88WeKadCXfNfKZAOOPMxYA=
X-Google-Smtp-Source: ABdhPJyJ5xkXTYs3zllZ2Aj+/fBxNPvRJ2DXwqXtJUP1lgeIKLNgRY89hgoGqqRfsqxgbIKoZbGbSmcyTWk0gNW6poI=
X-Received: by 2002:a92:a1cf:: with SMTP id b76mr6693791ill.128.1593597507405;
 Wed, 01 Jul 2020 02:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHtQmP_TVR8QA+noWQk04Nj_8AxMXfjCj1K_k0Zf6BN-Bq9sg@mail.gmail.com>
 <87bllhh7mg.fsf@vostro.rath.org> <CAMHtQmPcADq0WSAY=uFFyRgAeuCCAo=8dOHg37304at1SRjGBg@mail.gmail.com>
 <877dw0g0wn.fsf@vostro.rath.org> <CAJfpegs3xthDEuhx_vHUtjJ7BAbVfoDu9voNPPAqJo4G3BBYZQ@mail.gmail.com>
 <87sgensmsk.fsf@vostro.rath.org> <CAOQ4uxiYG3Z9rnXB6F+fnRtoV1e3k=WP5-mgphgkKsWw+jUK=Q@mail.gmail.com>
 <87mu4vsgd4.fsf@vostro.rath.org> <CAOQ4uxgqrT=cxyjAE+FAJzfnJ1=YS91t8aidXSqxPTsEoR90Vw@mail.gmail.com>
 <874kqycs7t.fsf@vostro.rath.org>
In-Reply-To: <874kqycs7t.fsf@vostro.rath.org>
From:   Hselin Chen <hselin.chen@gmail.com>
Date:   Wed, 1 Jul 2020 02:58:16 -0700
Message-ID: <CAMHtQmMz8rzZhwD0J72YL_57_UM7ESpGu-5bdv7eaMUWyxa+3w@mail.gmail.com>
Subject: Re: [fuse-devel] 512 byte aligned write + O_DIRECT for xfstests
To:     Amir Goldstein <amir73il@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nikolaus,

Sorry for being dense, apologies if I misunderstood something.
I think the issue is also more than just short writes?
The "reverse" write order (i.e. writing higher offsets before lower
offsets) can create temporary "holes" in the written file that short
writes wouldn't have caused.

Thanks!
Albert

On Thu, Jun 25, 2020 at 10:27 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> On Jun 22 2020, Amir Goldstein <amir73il@gmail.com> wrote:
> >> >> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_cha=
p02.html#tag_15_09_07
> >> >>
> >> >> Thanks for digging this up, I did not know about this.
> >> >>
> >> >> That leaves FUSE in a rather uncomfortable place though, doesn't it=
?
> >> >> What does the kernel do when userspace issues a write request that'=
s
> >> >> bigger than FUSE userspace pipe? It sounds like either the request =
must
> >> >> be splitted (so it becomes non-atomic), or you'd have to return a s=
hort
> >> >> write (which IIRC is not supposed to happen for local filesystems).
> >> >>
> >> >
> >> > What makes you say that short writes are not supposed to happen?
> >>
> >> I don't think it was an authoritative source, but I I've repeatedly re=
ad
> >> that "you do not have to worry about short reads/writes when accessing
> >> the local disk". I expect this to be a common expectation to be baked
> >> into programs, no matter if valid or not.
> >
> > Even if that statement would have been considered true, since when can
> > we speak of FUSE as a "local filesystem".
> > IMO it follows all the characteristics of a "network filesystem".
> >
> >> > Seems like the options for FUSE are:
> >> > - Take shared i_rwsem lock on read like XFS and regress performance =
of
> >> >   mixed rw workload
> >> > - Do the above only for non-direct and writeback_cache to minimize t=
he
> >> >   damage potential
> >> > - Return short read/write for direct IO if request is bigger that FU=
SE
> >> > buffer size
> >> > - Add a FUSE mode that implements direct IO internally as something =
like
> >> >   RWF_UNCACHED [2] - this is a relaxed version of "no caching" in cl=
ient or
> >> >   a stricter version of "cache write-through"  in the sense that
> >> > during an ongoing
> >> >   large write operation, read of those fresh written bytes only is s=
erved
> >> >   from the client cache copy and not from the server.
> >>
> >> I didn't understand all of that, but it seems to me that there is a
> >> fundamental problem with splitting up a single write into multiple FUS=
E
> >> requests, because the second request may fail after the first one
> >> succeeds.
> >>
> >
> > I think you are confused by the use of the word "atomic" in the standar=
d.
> > It does not mean what the O_ATOMIC proposal means, that is - write ever=
ything
> > or write nothing at all.
> > It means if thread A successfully wrote data X over data Y, then thread=
 B can
> > either read X or Y, but not half X half Y.
> > If A got an error on write, the content that B will read is probably un=
defined
> > (excuse me for not reading what "the law" has to say about this).
> > If A got a short (half) write, then surely B can read either half X or =
half Y
> > from the first half range. Second half range I am not sure what to expe=
ct.
> >
> > So I do not see any fundamental problem with FUSE write requests.
> > On the contrary - FUSE write requests are just like any network protoco=
l write
> > request or local disk IO request for that matter.
> >
> > Unless I am missing something...
>
> Well, you're missing the point I was trying to make, which was that FUSE
> is in an unfortunate spot if we want to avoid short writes *and* comply
> with the standard. You are asserting that is perfectly fine for FUSE to
> return short writes and I agree that in that case there is no problem
> with making writes atomic.
>
> I do not dispute that FUSE is within its right to return short
> rights. What I am saying is that I'm sure that there are plenty of
> userspace applications that don't expect short writes or reads when
> reading *any* regular file, because people assume this is only a concern
> for fds that represents sockets or pipes. Yes, this is wrong of
> them. But it works almost all the time, so it would be unfortunate if it
> suddenly stopped working for FUSE in the situations where it previously
> worked.
>
>
> Best,
> -Nikolaus
>
> --
> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>
>              =C2=BBTime flies like an arrow, fruit flies like a Banana.=
=C2=AB
>
>
> --
> fuse-devel mailing list
> To unsubscribe or subscribe, visit https://lists.sourceforge.net/lists/li=
stinfo/fuse-devel
