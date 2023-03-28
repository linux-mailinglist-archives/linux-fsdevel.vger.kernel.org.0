Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C5F6CCB2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjC1UCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 16:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjC1UCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:02:30 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA5A421D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 13:02:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y20so17355628lfj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680033723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quq8/ANKE/FnscNdTiexjHovD7OcjRI7MRJvqHe2IEA=;
        b=aIf24F8p0MOP+R24E7qMJdfqE2uQSUOEwEbYPH1i/5lrqf2+6VtvMvnoIAOdUXJAVw
         ncVk8eXzVEYRRUSba0P/1u6T2V2Yh0c7lIE99BB3dFN3iLSfySKCqB5XlDH7mFnUJkVG
         2hykFQOdJ0Vlxh+rfhUY3tZDrCWhlDQChNosu1VIYzHx2PT/TKEx16euq+7L/G3x6DFt
         J/OyuLpTSZopK+fnPUjl0pQr7LZeNb/3ShBddIXsjR6L4sSddwNZHdLd5fGqi2ObeECg
         ko3wc6o62KilNt1bC5P97nyYxUwV61h/s//PnMGuS/llA5IqSv6dAvbLhSh30VOnvqjd
         VKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680033723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quq8/ANKE/FnscNdTiexjHovD7OcjRI7MRJvqHe2IEA=;
        b=hZXKMBPp09Nk2u4K8drH3qFLhuj7AGCyVw4aheQuW2BfTBL/ryf5nKW8/epfaQEk0m
         t1eMQ7SfniQDr43nGTQ9cyQdFc+Y+aXdKsmosoKuZEb5LiPho4cWiTUI0htCKKDWXMmW
         +aQEs5wyOdM2fbV7vrcdPD0LxoCA68czuxHHsb9po5V+I/oIMrfUCc240rHnACBAu/M0
         8KkU8N37mKK72zZHbfax2W8W1Y4VGYqNdtJgOqLC79S1GuFaWAbzkluBG9zgR2qNc5KB
         jrI0cwn+S81NymG/+CZWvcptnc/fE1cvzcDyMOmmUIce61/8gy3VytjC+PQB2eMocJi4
         ekPw==
X-Gm-Message-State: AO0yUKXYKaiusH5X44EoztCidtmUgXO1z3Z5tfqCtd19FNDanQ709ej3
        xL2eIk07ACW68zz1zzAffBoi2V1rHHFFqSVwDADSkmuz9/dOq65sjnE=
X-Google-Smtp-Source: AKy350bEPelAbCPo1Tu89aeE2p/hbPM0kQ9mKfZGCLxuv0BO4OudfQC7ys/h19rzRD0JNvyG4LwmDB5bYjxxkhWNKsY=
X-Received: by 2002:a05:6512:1090:b0:4d8:86c2:75ea with SMTP id
 j16-20020a056512109000b004d886c275eamr12563486lfg.3.1680033723149; Tue, 28
 Mar 2023 13:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220722201513.1624158-1-axelrasmussen@google.com>
 <ZCIEGblnsWHKF8RD@x1n> <CAJHvVcj5ysY-xqKLL8f48-vFhpAB+qf4cN0AesQEd7Kvsi9r_A@mail.gmail.com>
 <ZCNDxhANoQmgcufM@x1n>
In-Reply-To: <ZCNDxhANoQmgcufM@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 28 Mar 2023 13:01:26 -0700
Message-ID: <CAJHvVcjU8QRLqFmk5GXbmOJgKp+XyVHMCS0hABtWmHTDuCusLA@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: don't fail on unrecognized features
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:45=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Tue, Mar 28, 2023 at 12:28:59PM -0700, Axel Rasmussen wrote:
> > On Mon, Mar 27, 2023 at 2:01=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > I think I overlooked this patch..
> > >
> > > Axel, could you explain why this patch is correct?  Comments inline.
> > >
> > > On Fri, Jul 22, 2022 at 01:15:13PM -0700, Axel Rasmussen wrote:
> > > > The basic interaction for setting up a userfaultfd is, userspace is=
sues
> > > > a UFFDIO_API ioctl, and passes in a set of zero or more feature fla=
gs,
> > > > indicating the features they would prefer to use.
> > > >
> > > > Of course, different kernels may support different sets of features
> > > > (depending on kernel version, kconfig options, architecture, etc).
> > > > Userspace's expectations may also not match: perhaps it was built
> > > > against newer kernel headers, which defined some features the kerne=
l
> > > > it's running on doesn't support.
> > > >
> > > > Currently, if userspace passes in a flag we don't recognize, the
> > > > initialization fails and we return -EINVAL. This isn't great, thoug=
h.
> > >
> > > Why?  IIUC that's the major way for user app to detect any misconfig =
of
> > > feature list so it can bail out early.
> > >
> > > Quoting from man page (ioctl_userfaultfd(2)):
> > >
> > > UFFDIO_API
> > >        (Since Linux 4.3.)  Enable operation of the userfaultfd and pe=
rform API handshake.
> > >
> > >        ...
> > >
> > >            struct uffdio_api {
> > >                __u64 api;        /* Requested API version (input) */
> > >                __u64 features;   /* Requested features (input/output)=
 */
> > >                __u64 ioctls;     /* Available ioctl() operations (out=
put) */
> > >            };
> > >
> > >        ...
> > >
> > >        For Linux kernel versions before 4.11, the features field must=
 be
> > >        initialized to zero before the call to UFFDIO_API, and zero (i=
.e.,
> > >        no feature bits) is placed in the features field by the kernel=
 upon
> > >        return from ioctl(2).
> > >
> > >        ...
> > >
> > >        To enable userfaultfd features the application should set a bi=
t
> > >        corresponding to each feature it wants to enable in the featur=
es
> > >        field.  If the kernel supports all the requested features it w=
ill
> > >        enable them.  Otherwise it will zero out the returned uffdio_a=
pi
> > >        structure and return EINVAL.
> > >
> > > IIUC the right way to use this API is first probe with features=3D=3D=
0, then
> > > the kernel will return all the supported features, then the user app =
should
> > > enable only a subset (or all, but not a superset) of supported ones i=
n the
> > > next UFFDIO_API with a new uffd.
> >
> > Hmm, I think doing a two-step handshake just overcomplicates things.
> >
> > Isn't it simpler to just have userspace ask for the features it wants
> > up front, and then the kernel responds with the subset of features it
> > actually supports? In the common case (all features were supported),
> > there is nothing more to do. Userspace is free to detect the uncommon
> > case where some features it asked for are missing, and handle that
> > however it likes.
> >
> > I think this patch is backwards compatible with the two-step approach, =
too.
> >
> > I do agree the man page could use some work. I don't think it
> > describes the two-step handshake process correctly, either. It just
> > says, "ask for the features you want, and the kernel will either give
> > them to you or fail". If we really did want to keep the two-step
> > process, it should describe it (set features =3D=3D 0 first, then ask o=
nly
> > for the ones you want which are supported), and the example program
> > should demonstrate it.
> >
> > But, I think it's simpler to just have the kernel do what the man page
> > describes. Userspace asks for the features up front, kernel responds
> > with the subset that are actually supported. No need to return EINVAL
> > if unsupported features were requested.
>
> The uffdio_api.features passed into the ioctl(UFFDIO_API) should be such
> request to enable features specified in the kernel.  If the kernel doesn'=
t
> support any of the features in the list, IMHO it's very natural to fail i=
t
> as described in the man page.  That's also most of the kernel apis do
> afaik, by failing any enablement of features if not supported.
>
> >
> > >
> > > > Userspace doesn't have an obvious way to react to this; sure, one o=
f the
> > > > features I asked for was unavailable, but which one? The only optio=
n it
> > > > has is to turn off things "at random" and hope something works.
> > > >
> > > > Instead, modify UFFDIO_API to just ignore any unrecognized feature
> > > > flags. The interaction is now that the initialization will succeed,=
 and
> > > > as always we return the *subset* of feature flags that can actually=
 be
> > > > used back to userspace.
> > > >
> > > > Now userspace has an obvious way to react: it checks if any flags i=
t
> > > > asked for are missing. If so, it can conclude this kernel doesn't
> > > > support those, and it can either resign itself to not using them, o=
r
> > > > fail with an error on its own, or whatever else.
> > > >
> > > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > > > ---
> > > >  fs/userfaultfd.c | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index e943370107d0..4974da1f620c 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -1923,10 +1923,8 @@ static int userfaultfd_api(struct userfaultf=
d_ctx *ctx,
> > > >       ret =3D -EFAULT;
> > > >       if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
> > > >               goto out;
> > > > -     features =3D uffdio_api.features;
> > > > -     ret =3D -EINVAL;
> > > > -     if (uffdio_api.api !=3D UFFD_API || (features & ~UFFD_API_FEA=
TURES))
> > > > -             goto err_out;
> > >
> > > What's worse is that I think you removed the only UFFD_API check.  Al=
though
> > > I'm not sure whether it'll be extended in the future or not at all (v=
ery
> > > possible we keep using 0xaa forever..), but removing this means we wo=
n't be
> > > able to extend it to a new api version in the future, and misconfig o=
f
> > > uffdio_api will wrongly succeed I think:
> > >
> > >         /* Test wrong UFFD_API */
> > >         uffdio_api.api =3D 0xab;
> > >         uffdio_api.features =3D 0;
> > >         if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D 0)
> > >                 err("UFFDIO_API should fail but didn't");
> >
> > Agreed, we should add back the UFFD_API check - I am happy to send a
> > patch for this.
>
> Do you plan to just revert the patch?  If so, please go ahead.  IMHO we
> should just follow the man page.
>
> What I agree here is the api isn't that perfect, in that we need to creat=
e
> a separate userfault file descriptor just to probe.  Currently the featur=
es
> will be returned in the initial test with features=3D0 passed in, but it =
also
> initializes the uffd handle even if it'll never be used but for probe onl=
y.

Oh, I thought you could UFFDIO_API the same FD twice. Having to create
a whole separate FD just to probe features makes me dislike that
design even more.

>
> However since that existed in the 1st day I guess we'd better keep it
> as-is.  And it's not so bad either: user app does open/close one more tim=
e,
> but only once for each app's lifecycle.

I don't think just reverting would be enough. We'd also need to update
the man page to describe the two-step initialization, and we'd need to
update the man page's example program to demonstrate it. Our own
selftest also doesn't use that approach, so it would need to be
updated as well.

It also seems not unlikely that there exists some userspace code which
simply copied the example program from the man page, and as such
doesn't do the two-step handshake today. Hard to know for certain.

Once we've dealt with that, what we'll have accomplished is just
making the API harder to use. I don't see any downside from the
current state of things, it allows a much simpler way of configuring
userfaultfds, and it's backwards compatible with the more complicated
way.

I think we can set things right by just adding in the UFFD_API version
check by itself, and then updating the man page to describe the
current state of things?

>
> Thanks,
>
> --
> Peter Xu
>
