Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9656CCC4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjC1VxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjC1VxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:53:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B42DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:53:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o20so11163304ljp.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680040392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F375vSEJI5wPgXWAZJLnnHY9xngsqNbiF/IhmJrS0ds=;
        b=lfAVF+e6h0BXytuiz4nQUSaoBGeDfo4wlNuG4jpTy6P1ag3DEvnCoOAtytsCuGNPO9
         a6PQZvoDr0iwuM3d+wUtUxgQtSh9w8g5BxHBJIxR920oC4WCFEQ1ZDT5snV6Les6U3Ra
         NRKk06Ime4HOulqEFnxoJ+5yHib6+9PMdNmV7FIZDzQjM9vpOqelEScZcUroUCqhC97I
         qbrVz2xVvlBXhLHSK3Y2cfUT9tC9CieG54cW0ceMdpoZt8dryleRsN8cCXsTPedXpslx
         xjGuS4ZYaZ7KN9obLHMk97JtCX5isT7iZlNJBjUuYYBYtSx1u3HyOI2aa0l9whKy1FyF
         39dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F375vSEJI5wPgXWAZJLnnHY9xngsqNbiF/IhmJrS0ds=;
        b=wrbqWYvCOIT5SgtIDYjsVv9PfIcbX5tUChDDSLvvERVEv4NotgxkC6i8e/m+uKpjxl
         d0NYI7y8qPDXw8rqssJDja9jJBSgjrlBX0UuUGJ9Fial6ekHK5d+gbrHtyrgGGOoF+Iz
         rQC1/Qfn1Y6ECMSqeMo77WC52vLgDh+LudgnI5PGuFYthJF8K6wMpPBtDZOs2Ct4iyGx
         xKKcy9X3U3O10ND9L/in1IOpV/80IIpI4LGeYuLCREcopUvmZPK8Bf+BIIlN8He9FA3l
         9r6hqrc1F3ykU269OkrEcWN3W1j2w2CQoJlISgts2E4rkTPPF88UuSFYaiiunRVH6UnT
         LQ2g==
X-Gm-Message-State: AAQBX9fvp0i03W9lmzYJJjOsuh1AK4zZPt3fw1lj5WnoX4XLB3OH8Ro0
        9Mxk9a2Ms2FyOdeM1w7Ku2+u8XUsi7ySCERPVdhH0w==
X-Google-Smtp-Source: AKy350ZZxC7k6bP1agjh/QKhjPEkbtzEgFI8ZLgl7BaFZ/OCNG8jelmHpfgfG8bWUb83AcRj8tS7fPzRkNRLvSToT/s=
X-Received: by 2002:a2e:bc1e:0:b0:299:6e0e:3a1b with SMTP id
 b30-20020a2ebc1e000000b002996e0e3a1bmr67751ljf.4.1680040392225; Tue, 28 Mar
 2023 14:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220722201513.1624158-1-axelrasmussen@google.com>
 <ZCIEGblnsWHKF8RD@x1n> <CAJHvVcj5ysY-xqKLL8f48-vFhpAB+qf4cN0AesQEd7Kvsi9r_A@mail.gmail.com>
 <ZCNDxhANoQmgcufM@x1n> <CAJHvVcjU8QRLqFmk5GXbmOJgKp+XyVHMCS0hABtWmHTDuCusLA@mail.gmail.com>
 <ZCNPFDK0vmzyGIHb@x1n>
In-Reply-To: <ZCNPFDK0vmzyGIHb@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 28 Mar 2023 14:52:35 -0700
Message-ID: <CAJHvVciwT0xw3Nu2Fpi-7H9iR92xK7VB31dYLfmJF5K3vQxvFQ@mail.gmail.com>
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

On Tue, Mar 28, 2023 at 1:33=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Mar 28, 2023 at 01:01:26PM -0700, Axel Rasmussen wrote:
> > On Tue, Mar 28, 2023 at 12:45=E2=80=AFPM Peter Xu <peterx@redhat.com> w=
rote:
> > >
> > > On Tue, Mar 28, 2023 at 12:28:59PM -0700, Axel Rasmussen wrote:
> > > > On Mon, Mar 27, 2023 at 2:01=E2=80=AFPM Peter Xu <peterx@redhat.com=
> wrote:
> > > > >
> > > > > I think I overlooked this patch..
> > > > >
> > > > > Axel, could you explain why this patch is correct?  Comments inli=
ne.
> > > > >
> > > > > On Fri, Jul 22, 2022 at 01:15:13PM -0700, Axel Rasmussen wrote:
> > > > > > The basic interaction for setting up a userfaultfd is, userspac=
e issues
> > > > > > a UFFDIO_API ioctl, and passes in a set of zero or more feature=
 flags,
> > > > > > indicating the features they would prefer to use.
> > > > > >
> > > > > > Of course, different kernels may support different sets of feat=
ures
> > > > > > (depending on kernel version, kconfig options, architecture, et=
c).
> > > > > > Userspace's expectations may also not match: perhaps it was bui=
lt
> > > > > > against newer kernel headers, which defined some features the k=
ernel
> > > > > > it's running on doesn't support.
> > > > > >
> > > > > > Currently, if userspace passes in a flag we don't recognize, th=
e
> > > > > > initialization fails and we return -EINVAL. This isn't great, t=
hough.
> > > > >
> > > > > Why?  IIUC that's the major way for user app to detect any miscon=
fig of
> > > > > feature list so it can bail out early.
> > > > >
> > > > > Quoting from man page (ioctl_userfaultfd(2)):
> > > > >
> > > > > UFFDIO_API
> > > > >        (Since Linux 4.3.)  Enable operation of the userfaultfd an=
d perform API handshake.
> > > > >
> > > > >        ...
> > > > >
> > > > >            struct uffdio_api {
> > > > >                __u64 api;        /* Requested API version (input)=
 */
> > > > >                __u64 features;   /* Requested features (input/out=
put) */
> > > > >                __u64 ioctls;     /* Available ioctl() operations =
(output) */
> > > > >            };
> > > > >
> > > > >        ...
> > > > >
> > > > >        For Linux kernel versions before 4.11, the features field =
must be
> > > > >        initialized to zero before the call to UFFDIO_API, and zer=
o (i.e.,
> > > > >        no feature bits) is placed in the features field by the ke=
rnel upon
> > > > >        return from ioctl(2).
> > > > >
> > > > >        ...
> > > > >
> > > > >        To enable userfaultfd features the application should set =
a bit
> > > > >        corresponding to each feature it wants to enable in the fe=
atures
> > > > >        field.  If the kernel supports all the requested features =
it will
> > > > >        enable them.  Otherwise it will zero out the returned uffd=
io_api
> > > > >        structure and return EINVAL.
> > > > >
> > > > > IIUC the right way to use this API is first probe with features=
=3D=3D0, then
> > > > > the kernel will return all the supported features, then the user =
app should
> > > > > enable only a subset (or all, but not a superset) of supported on=
es in the
> > > > > next UFFDIO_API with a new uffd.
> > > >
> > > > Hmm, I think doing a two-step handshake just overcomplicates things=
.
> > > >
> > > > Isn't it simpler to just have userspace ask for the features it wan=
ts
> > > > up front, and then the kernel responds with the subset of features =
it
> > > > actually supports? In the common case (all features were supported)=
,
> > > > there is nothing more to do. Userspace is free to detect the uncomm=
on
> > > > case where some features it asked for are missing, and handle that
> > > > however it likes.
> > > >
> > > > I think this patch is backwards compatible with the two-step approa=
ch, too.
> > > >
> > > > I do agree the man page could use some work. I don't think it
> > > > describes the two-step handshake process correctly, either. It just
> > > > says, "ask for the features you want, and the kernel will either gi=
ve
> > > > them to you or fail". If we really did want to keep the two-step
> > > > process, it should describe it (set features =3D=3D 0 first, then a=
sk only
> > > > for the ones you want which are supported), and the example program
> > > > should demonstrate it.
> > > >
> > > > But, I think it's simpler to just have the kernel do what the man p=
age
> > > > describes. Userspace asks for the features up front, kernel respond=
s
> > > > with the subset that are actually supported. No need to return EINV=
AL
> > > > if unsupported features were requested.
> > >
> > > The uffdio_api.features passed into the ioctl(UFFDIO_API) should be s=
uch
> > > request to enable features specified in the kernel.  If the kernel do=
esn't
> > > support any of the features in the list, IMHO it's very natural to fa=
il it
> > > as described in the man page.  That's also most of the kernel apis do
> > > afaik, by failing any enablement of features if not supported.
> > >
> > > >
> > > > >
> > > > > > Userspace doesn't have an obvious way to react to this; sure, o=
ne of the
> > > > > > features I asked for was unavailable, but which one? The only o=
ption it
> > > > > > has is to turn off things "at random" and hope something works.
> > > > > >
> > > > > > Instead, modify UFFDIO_API to just ignore any unrecognized feat=
ure
> > > > > > flags. The interaction is now that the initialization will succ=
eed, and
> > > > > > as always we return the *subset* of feature flags that can actu=
ally be
> > > > > > used back to userspace.
> > > > > >
> > > > > > Now userspace has an obvious way to react: it checks if any fla=
gs it
> > > > > > asked for are missing. If so, it can conclude this kernel doesn=
't
> > > > > > support those, and it can either resign itself to not using the=
m, or
> > > > > > fail with an error on its own, or whatever else.
> > > > > >
> > > > > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > > > > > ---
> > > > > >  fs/userfaultfd.c | 6 ++----
> > > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > > > index e943370107d0..4974da1f620c 100644
> > > > > > --- a/fs/userfaultfd.c
> > > > > > +++ b/fs/userfaultfd.c
> > > > > > @@ -1923,10 +1923,8 @@ static int userfaultfd_api(struct userfa=
ultfd_ctx *ctx,
> > > > > >       ret =3D -EFAULT;
> > > > > >       if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
> > > > > >               goto out;
> > > > > > -     features =3D uffdio_api.features;
> > > > > > -     ret =3D -EINVAL;
> > > > > > -     if (uffdio_api.api !=3D UFFD_API || (features & ~UFFD_API=
_FEATURES))
> > > > > > -             goto err_out;
> > > > >
> > > > > What's worse is that I think you removed the only UFFD_API check.=
  Although
> > > > > I'm not sure whether it'll be extended in the future or not at al=
l (very
> > > > > possible we keep using 0xaa forever..), but removing this means w=
e won't be
> > > > > able to extend it to a new api version in the future, and misconf=
ig of
> > > > > uffdio_api will wrongly succeed I think:
> > > > >
> > > > >         /* Test wrong UFFD_API */
> > > > >         uffdio_api.api =3D 0xab;
> > > > >         uffdio_api.features =3D 0;
> > > > >         if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D 0)
> > > > >                 err("UFFDIO_API should fail but didn't");
> > > >
> > > > Agreed, we should add back the UFFD_API check - I am happy to send =
a
> > > > patch for this.
> > >
> > > Do you plan to just revert the patch?  If so, please go ahead.  IMHO =
we
> > > should just follow the man page.
> > >
> > > What I agree here is the api isn't that perfect, in that we need to c=
reate
> > > a separate userfault file descriptor just to probe.  Currently the fe=
atures
> > > will be returned in the initial test with features=3D0 passed in, but=
 it also
> > > initializes the uffd handle even if it'll never be used but for probe=
 only.
> >
> > Oh, I thought you could UFFDIO_API the same FD twice. Having to create
> > a whole separate FD just to probe features makes me dislike that
> > design even more.
> >
> > >
> > > However since that existed in the 1st day I guess we'd better keep it
> > > as-is.  And it's not so bad either: user app does open/close one more=
 time,
> > > but only once for each app's lifecycle.
> >
> > I don't think just reverting would be enough. We'd also need to update
> > the man page to describe the two-step initialization, and we'd need to
> > update the man page's example program to demonstrate it. Our own
> > selftest also doesn't use that approach, so it would need to be
> > updated as well.
>
> No worry on that, I'm recently cleaning up the selftest (majorly, split
> userfaultfd.c into two tests).  This is also on my radar, and yes it was
> broken.  I do plan to make sure the selftests can run on all old/new
> kernels after the cleanup.  It's getting a bit chaos by having so much
> global variables and I found it becomes harder to maintain.
>
> For this I blame myself on being lazy starting from the uffd-wp selftests=
,
> though..  It can do better.
>
> >
> > It also seems not unlikely that there exists some userspace code which
> > simply copied the example program from the man page, and as such
> > doesn't do the two-step handshake today. Hard to know for certain.
>
> The example has no feature enabled, in which case is fine.  Definitely go=
od
> if there's another one illustrates the features!=3D0 case.
>
> >
> > Once we've dealt with that, what we'll have accomplished is just
> > making the API harder to use. I don't see any downside from the
> > current state of things, it allows a much simpler way of configuring
> > userfaultfds, and it's backwards compatible with the more complicated
> > way.
> >
> > I think we can set things right by just adding in the UFFD_API version
> > check by itself, and then updating the man page to describe the
> > current state of things?
>
> I still don't understand why you would consider it's right only by having
> the kernel succeed the ioctl even if some specified features are not
> supported.  What's the benefit?

For me the clear benefit is just that it's simpler to use. With this
way, userspace only has to open + UFFDIO_API a userfaultfd once,
instead of twice.

This also means the example in the man page can be simpler, and our
selftest can be simpler.

I don't see being very strict here as useful. Another example might be
madvise() - for example trying to MADV_PAGEOUT on a kernel that
doesn't support it. There is no way the kernel can proceed here, since
it simply doesn't know how to do what you're asking for. In this case
an error makes sense.

In the userfaultfd case, these are optional features, and userfaultfds
are generally usable without them. If userspace asks for a feature and
it isn't available, it seems fairly likely userspace could degrade
gracefully, and just use the userfaultfd in a slightly different way
to compensate. Of course, userspace is free to consider this case
fatal if it prefers.

I think we should look at it the other way around. Let's prefer the
simpler approach, unless there is a clear benefit to the more complex
two-step handshake approach? Does the two-step handshake support a
case the simpler approach doesn't?

>
> An user app will need to check the returned feature list and bit-check wi=
th
> what was requested which is even more awkward to me than a straightforwar=
d
> failure, isn't it?

I don't see this as a downside, because it has to be done in either
design. Either we have to check the list of features after the first
(of two) handshake API ioctls, or we have to check them after our one
API ioctl where we requested a list of features.


>
> QEMU definitely uses it with a proper probing:
>
> https://gitlab.com/qemu-project/qemu/-/blob/master/migration/postcopy-ram=
.c#L222
>
> Meanwhile anyone can try to enable FEATURE_NEVER_EXISTED and ioctl will
> return 0.  It just doesn't sound right to me in any case..
>
> --
> Peter Xu
>
