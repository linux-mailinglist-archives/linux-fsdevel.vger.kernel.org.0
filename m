Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C682704007
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbjEOVpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 17:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjEOVpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 17:45:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22BA10EC
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 14:45:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f4234f67feso403545e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684187113; x=1686779113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aUC85Wp/X7FacCd+b+KASSibCPsy79wU+ZFAhpzb8A=;
        b=YS0zfFNJjU6+9uCXWmCbwdsE9R9w/j+VnxfC/Aqva/liNhsivEcxERGgLL/X/a95a+
         Op7ZudEfxSzKNf8tck3IsADM9Qs8MNHxivNE21fKVrHOr64mURR0AcBp0ji3Ug59+y/S
         F8OQJhiShCNwGELEEARTo2Uvs0fzQU2SkcJ7S2r9pdPqQK41sWp8wOUEGuwXEWT3tIyF
         Ghm0BU2gn94FgdKpPVUGtcC/gdCumyo3Le5CCAeQvEPkaTx7PLj5cX5k6RvB+SbBu4u2
         XJkVPlN18Mu3/d78XNQigF3/i9cpsm/j5sLhnGAYaWVVRmgZUez4S4Vvmabl8WMtNeCq
         W7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684187113; x=1686779113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aUC85Wp/X7FacCd+b+KASSibCPsy79wU+ZFAhpzb8A=;
        b=SmLlGoUj0iTjTKKqcmQ/FQHh18EjUqQuM2hUXShnZbtP93WY3Rh0vWqU3ykCoS+g1/
         noOCHkzBkO4e9IgWoutzfPtsBCF6nITo6eRmqbRJfox3MwIdaLMHCOkylqLyQ81GkNik
         bJ2M6ZQ8lyU9KFYQVCfwjjlbadSj/3GBc8sz3+/oT5hoAaKbovaKZR6oHQrCMQLEOvcl
         HGZ5GYqa9DF++gPQTMaoeQgckMfmhK3K2pBQbHmHi+POqQMaTbAUvyZ5st0S3MeZqdmG
         yg0WAg+Q09zacjr2JNRStt5Alr5xSNUSH6pSwNRotXSAX0xnizMklpMr3bn9vcKV9rmX
         WhKA==
X-Gm-Message-State: AC+VfDzHuMMi3pQE6Zc6cTN/oy7hP4DbCgt+VFcsL3dSqj++uc9ptxwX
        dGK6IPhdLT8AlQLwR5kn72X5YHJvhviLJrK8w0Vjwg==
X-Google-Smtp-Source: ACHHUZ7rYMRmjFgS/8pDLKksfTtU0p+AesLpDAZqWCggDtSWpETJqyhsABZ6XgGDl8DizrvUlYOEJZ3HBPdroO7+HrM=
X-Received: by 2002:a05:600c:4e0f:b0:3f3:3855:c5d8 with SMTP id
 b15-20020a05600c4e0f00b003f33855c5d8mr38576wmq.6.1684187112981; Mon, 15 May
 2023 14:45:12 -0700 (PDT)
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
In-Reply-To: <93b77b5d-a1bc-7bb9-ffea-3876068bd369@fastmail.fm>
From:   Paul Lawrence <paullawrence@google.com>
Date:   Mon, 15 May 2023 14:45:01 -0700
Message-ID: <CAL=UVf78XujrotZnLjLcOYaaFHAjVEof-Qx_+peOtpdaRMoCow@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH RESEND V12 3/8] fuse: Definitions and ioctl
 for passthrough
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Amir Goldstein <amir73il@gmail.com>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 2:11=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
> On 5/15/23 22:16, Nikolaus Rath wrote:
> > On May 15 2023, Amir Goldstein <amir73il@gmail.com> wrote:
> >> On Mon, May 15, 2023 at 10:29=E2=80=AFAM Miklos Szeredi <miklos@szered=
i.hu> wrote:
> >>> On Fri, 12 May 2023 at 21:37, Amir Goldstein <amir73il@gmail.com> wro=
te:
> >>>
> >>>> I was waiting for LSFMM to see if and how FUSE-BPF intends to
> >>>> address the highest value use case of read/write passthrough.
> >>>>
> >>>>  From what I've seen, you are still taking a very broad approach of
> >>>> all-or-nothing which still has a lot of core design issues to addres=
s,
> >>>> while these old patches already address the most important use case
> >>>> of read/write passthrough of fd without any of the core issues
> >>>> (credentials, hidden fds).
> >>>>
> >>>> As far as I can tell, this old implementation is mostly independent =
of your
> >>>> lookup based approach - they share the low level read/write passthro=
ugh
> >>>> functions but not much more than that, so merging them should not be
> >>>> a blocker to your efforts in the longer run.
> >>>> Please correct me if I am wrong.
> >>>>
> >>>> As things stand, I intend to re-post these old patches with mandator=
y
> >>>> FOPEN_PASSTHROUGH_AUTOCLOSE to eliminate the open
> >>>> questions about managing mappings.
> >>>>
> >>>> Miklos, please stop me if I missed something and if you do not
> >>>> think that these two approaches are independent.
> >>>
> >>> Do you mean that the BPF patches should use their own passthrough mec=
hanism?
> >>>
> >>> I think it would be better if we could agree on a common interface fo=
r
> >>> passthough (or per Paul's suggestion: backing) mechanism.
> >>
> >> Well, not exactly different.
> >> With BFP patches, if you have a backing inode that was established dur=
ing
> >> LOOKUP with rules to do passthrough for open(), you'd get a backing fi=
le and
> >> that backing file would be used to passthrough read/write.
> >>
> >> FOPEN_PASSTHROUGH is another way to configure passthrough read/write
> >> to a backing file that is controlled by the server per open fd instead=
 of by BFP
> >> for every open of the backing inode.
> >>
> >> Obviously, both methods would use the same backing_file field and
> >> same read/write passthrough methods regardless of how the backing file
> >> was setup.
> >>
> >> Obviously, the BFP patches will not use the same ioctl to setup passth=
rough
> >> (and/or BPF program) to a backing inode, but I don't think that matter=
s much.
> >> When we settle on ioctls for setting up backing inodes, we can also ad=
d new
> >> ioctls for setting up backing file with optional BPF program.
> >
> >> I don't see any reason to make the first ioctl more complicated than t=
his:
> >>
> >> struct fuse_passthrough_out {
> >>          uint32_t        fd;
> >>          /* For future implementation */
> >>          uint32_t        len;
> >>          void            *vec;
> >> };
> >>
> >> One advantage with starting with FOPEN_PASSTHROUGH, besides
> >> dealing with the highest priority performance issue, is how it deals w=
ith
> >> resource limits on open files.
> >
> > One thing that struck me when we discussed FUSE-BPF at LSF was that fro=
m
> > a userspace point of view, FUSE-BPF presents an almost completely
> > different API than traditional FUSE (at least in its current form).
> >
> > As long as there is no support for falling back to standard FUSE
> > callbacks, using FUSE-BPF means that most of the existing API no longer
> > works, and instead there is a large new API surface that doesn't work i=
n
> > standard FUSE (the pre-filter and post-filter callbacks for each
> > operation).
> >
> > I think this means that FUSE-BPF file systems won't work with FUSE, and
> > FUSE filesystems won't work with FUSE-BPF.
>
> Is that so? I think found some incompatibilities in the patches (need to
> double check), but doesn't it just do normal fuse operations and then
> replies with an ioctl to do passthrough? BPF is used for additional
> filtering, that would have to be done otherwise in userspace.
>
> Really difficult in the current patch set and data structures is to see
> what is actually BPF and what is passthrough.

I hope that fuse and fuse-bpf play together a little better than that
;) In the current design, you can set a backing file from within
traditional fuse lookups, which moves you to fuse-bpf for that
file/directory, and you can remove the backing file during the
post-filter, moving that node back to fuse. You can also return a
value from the bpf prefilter that tells fuse to use traditional fuse
for that command. I think this is a very useful feature - it's one of
the first ones we used in Android.

If we do find any areas where we can't easily switch between
traditional fuse and fuse-bpf, we would consider that a bug and fix it
as fast as possible.

And yes, we got the feedback from LSFMMBPF that the current patches
are hard to follow, and we will be reordering them and resending them
as three patchsets. One will add backing files, one will add backing
directories, and the final will add bpf filters to both. Hopefully
that will make them easier to understand.

Paul
