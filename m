Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A43704828
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 10:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjEPIs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 04:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjEPIsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 04:48:55 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570CAD
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 01:48:54 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-43656c7c686so858582137.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684226933; x=1686818933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZy+J5Ra6Nuh1OY11/DtMbEzLhstK8ek7lcEVoHRAYY=;
        b=bjcZWUTQsxJo4hmH94bVAgUaeX4BQt58fQFL09RxYCqxSlLn06Psgg7ZpuY+NAHyra
         wxJsF5ZH1EHKYWC6HFOq2AXZbOgpWhI6j8A9iBp3peDaGvdIN5KIGiStlEVHqN12oGm7
         ydCM/GdIzkXjz7cqXbnTdZFCA+KdftmFvdF5RgJQI+EL1C35ZplJ+C6p96MupEYVlLkC
         w4sKvmLB1XfWi/0/sPAy6w/UvQr7aElBA0t92NnOZXFt9i7KxwQsUMePP8OHAHkJe/lc
         0Q25lFJGb9fGbXamENMiQzW/u/TXCT8aWohcFyf+/ojTyJO43n0Bxvpv5MILxjG3VCgb
         toxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684226933; x=1686818933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZy+J5Ra6Nuh1OY11/DtMbEzLhstK8ek7lcEVoHRAYY=;
        b=CnJuEaJ2AFKzbskDCL+33+lCtpgk9yzers0xZROWxre73NsOg0zAP2eUKRdA+3C3KF
         kO5qfH5dDN36hSHyL1PEex1fAdZGGsWjsixVtx4BafHViTEFH9nm2qMYjycJsqb0jfzy
         YMmpTsE9Nbx6L67XavY+nxmp7BERFE6hs0o4u/RMT5BSmhIGvY+lR1mg8JlkkLzbHdxT
         P9hKu4MfXhdVsw06z7Xfc0ake+UT0KCgj5qoaHWoK1hlaYZxfKsBjROFbhJoXqRWeogb
         O6lDQBB+Ll2v4pK28x8CgNQYECZNzoxap7qO3eJFdef2H+fTM3VyUhqNWv8DqxRtWW19
         oV2w==
X-Gm-Message-State: AC+VfDwhVWMedpRiE14OG9ub6w8dBBxJxFejg4jUq3m7kmvwXx4NtnQ2
        HziqlojSn/FQIOkfqGMcjVtnz22ZzHXmdjLHnvY=
X-Google-Smtp-Source: ACHHUZ7OABR+XSzh0p1mk2G6+exrW5G77n9hwQFJWjX/OR1MdYbJDHgFAQcZFETCL6chEKSEhLiwSAEOdCFEN4fge6U=
X-Received: by 2002:a05:6102:3cd:b0:42f:f7c2:1a7 with SMTP id
 n13-20020a05610203cd00b0042ff7c201a7mr14462248vsq.13.1684226933476; Tue, 16
 May 2023 01:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
 <CAOQ4uxg2k3DsTdiMKNm4ESZinjS513Pj2EeKGW4jQR_o5Mp3-Q@mail.gmail.com>
 <CAJfpegv1ByQg750uHTGOTZ7CJ4OrYp6i4MKXU13mwZPUEk+pnA@mail.gmail.com>
 <CAOQ4uxjrhf8D081Z8aG71=Kjjub28MwR3xsaAHD4cK48-FzjNA@mail.gmail.com>
 <87353xjqoj.fsf@vostro.rath.org> <93b77b5d-a1bc-7bb9-ffea-3876068bd369@fastmail.fm>
 <CAL=UVf78XujrotZnLjLcOYaaFHAjVEof-Qx_+peOtpdaRMoCow@mail.gmail.com>
In-Reply-To: <CAL=UVf78XujrotZnLjLcOYaaFHAjVEof-Qx_+peOtpdaRMoCow@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 May 2023 11:48:42 +0300
Message-ID: <CAOQ4uxiV1kMhhVKAL0GuNx0Y8KptUtVfmYdiRKmKtLgaJucAtQ@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH RESEND V12 3/8] fuse: Definitions and ioctl
 for passthrough
To:     Paul Lawrence <paullawrence@google.com>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stefano Duo <duostefano93@gmail.com>,
        David Anderson <dvander@google.com>, wuyan <wu-yan@tcl.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Akilesh Kailash <akailash@google.com>,
        Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 12:45=E2=80=AFAM Paul Lawrence <paullawrence@google=
.com> wrote:
>
> On Mon, May 15, 2023 at 2:11=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> > On 5/15/23 22:16, Nikolaus Rath wrote:
> > > On May 15 2023, Amir Goldstein <amir73il@gmail.com> wrote:
> > >> On Mon, May 15, 2023 at 10:29=E2=80=AFAM Miklos Szeredi <miklos@szer=
edi.hu> wrote:
> > >>> On Fri, 12 May 2023 at 21:37, Amir Goldstein <amir73il@gmail.com> w=
rote:
> > >>>
> > >>>> I was waiting for LSFMM to see if and how FUSE-BPF intends to
> > >>>> address the highest value use case of read/write passthrough.
> > >>>>
> > >>>>  From what I've seen, you are still taking a very broad approach o=
f
> > >>>> all-or-nothing which still has a lot of core design issues to addr=
ess,
> > >>>> while these old patches already address the most important use cas=
e
> > >>>> of read/write passthrough of fd without any of the core issues
> > >>>> (credentials, hidden fds).
> > >>>>
> > >>>> As far as I can tell, this old implementation is mostly independen=
t of your
> > >>>> lookup based approach - they share the low level read/write passth=
rough
> > >>>> functions but not much more than that, so merging them should not =
be
> > >>>> a blocker to your efforts in the longer run.
> > >>>> Please correct me if I am wrong.
> > >>>>
> > >>>> As things stand, I intend to re-post these old patches with mandat=
ory
> > >>>> FOPEN_PASSTHROUGH_AUTOCLOSE to eliminate the open
> > >>>> questions about managing mappings.
> > >>>>
> > >>>> Miklos, please stop me if I missed something and if you do not
> > >>>> think that these two approaches are independent.
> > >>>
> > >>> Do you mean that the BPF patches should use their own passthrough m=
echanism?
> > >>>
> > >>> I think it would be better if we could agree on a common interface =
for
> > >>> passthough (or per Paul's suggestion: backing) mechanism.
> > >>
> > >> Well, not exactly different.
> > >> With BFP patches, if you have a backing inode that was established d=
uring
> > >> LOOKUP with rules to do passthrough for open(), you'd get a backing =
file and
> > >> that backing file would be used to passthrough read/write.
> > >>
> > >> FOPEN_PASSTHROUGH is another way to configure passthrough read/write
> > >> to a backing file that is controlled by the server per open fd inste=
ad of by BFP
> > >> for every open of the backing inode.
> > >>
> > >> Obviously, both methods would use the same backing_file field and
> > >> same read/write passthrough methods regardless of how the backing fi=
le
> > >> was setup.
> > >>
> > >> Obviously, the BFP patches will not use the same ioctl to setup pass=
through
> > >> (and/or BPF program) to a backing inode, but I don't think that matt=
ers much.
> > >> When we settle on ioctls for setting up backing inodes, we can also =
add new
> > >> ioctls for setting up backing file with optional BPF program.
> > >
> > >> I don't see any reason to make the first ioctl more complicated than=
 this:
> > >>
> > >> struct fuse_passthrough_out {
> > >>          uint32_t        fd;
> > >>          /* For future implementation */
> > >>          uint32_t        len;
> > >>          void            *vec;
> > >> };
> > >>
> > >> One advantage with starting with FOPEN_PASSTHROUGH, besides
> > >> dealing with the highest priority performance issue, is how it deals=
 with
> > >> resource limits on open files.
> > >
> > > One thing that struck me when we discussed FUSE-BPF at LSF was that f=
rom
> > > a userspace point of view, FUSE-BPF presents an almost completely
> > > different API than traditional FUSE (at least in its current form).
> > >
> > > As long as there is no support for falling back to standard FUSE
> > > callbacks, using FUSE-BPF means that most of the existing API no long=
er
> > > works, and instead there is a large new API surface that doesn't work=
 in
> > > standard FUSE (the pre-filter and post-filter callbacks for each
> > > operation).

I think there is a confusion here that needs to be clarified.
I was confused when you asked in the session why the usermode
post-filter was needed.

IIUC, there is no usermode post filter. There are only in-kernel BPF
pre/post filters.

Paul/Daniel will correct me if I am wrong, but I think the FUSE server
can be called at most once per op as legacy FUSE, but with
FUSE-BPF, the server may be bypassed.

Pre/post filters are used to toggle the bypass mode permanently
or for a specific op and post filter can also be used to modify the
server response.

> > >
> > > I think this means that FUSE-BPF file systems won't work with FUSE, a=
nd
> > > FUSE filesystems won't work with FUSE-BPF.
> >
> > Is that so? I think found some incompatibilities in the patches (need t=
o
> > double check), but doesn't it just do normal fuse operations and then
> > replies with an ioctl to do passthrough?

About that, I wanted to ask.
Alessio's initial patches used to have a similar approach.
Without ioctl, but the passthrough/backing fd was provided as part of the
response to OPEN request.

Following feedback from Miklos and Jens, not only the passthrough
request was moved to ioctl, but it was also decoupled from the OPEN
response.

This allows the server more flexibility in managing the passthrough
mode of files (or inodes in FUSE-BPF case).
FUSE-BPF patches use ioctl for response, but without decoupling.
I wonder if that should be amended for the next version?

> > BPF is used for additional
> > filtering, that would have to be done otherwise in userspace.
> >
> > Really difficult in the current patch set and data structures is to see
> > what is actually BPF and what is passthrough.
>
> I hope that fuse and fuse-bpf play together a little better than that
> ;) In the current design, you can set a backing file from within
> traditional fuse lookups, which moves you to fuse-bpf for that
> file/directory, and you can remove the backing file during the
> post-filter, moving that node back to fuse. You can also return a
> value from the bpf prefilter that tells fuse to use traditional fuse
> for that command. I think this is a very useful feature - it's one of
> the first ones we used in Android.
>
> If we do find any areas where we can't easily switch between
> traditional fuse and fuse-bpf, we would consider that a bug and fix it
> as fast as possible.
>
> And yes, we got the feedback from LSFMMBPF that the current patches
> are hard to follow, and we will be reordering them and resending them
> as three patchsets. One will add backing files, one will add backing
> directories, and the final will add bpf filters to both. Hopefully
> that will make them easier to understand.
>

That sounds great!
I started to dust off Alessio's patches.
I might just post what I have as a reference implementation that
we can compare to your "backing file" series.
I would much rather that your version is the one that ends up being
merged at the end ;-)

Thanks,
Amir.
