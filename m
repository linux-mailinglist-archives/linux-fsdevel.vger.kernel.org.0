Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7AB702EF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjEOOAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 10:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEOOA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 10:00:29 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D376E6E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 07:00:28 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-43469a7946eso4174033137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684159227; x=1686751227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzPH09o0wj4RjABN673jHX+ADMH1DGf48AY7XECThdc=;
        b=i3HDcbsoCbUD0VhhvfPuscj8H+DSjmCNri+hZxNlg+nqMuA353B9whyaFtJy8r4l5U
         QdFbel2AgMLYSfsXeTofmOWRt7uqJj20XEQTSyCNTJ3qmDY1MKOW3Mpvr5Vnc7c6tt3j
         Bls9l0QlyKkoS95Lg+El6tvmAxFao6cxvu6FammXa5w1RsdundX3R7WXA6u3sMCb6a3Z
         Dazlg2nH1saSrV+wLVEtute2ji09lhSwdBBnVU8bXpH6rcyxgBwMXYfSxKU1rtjXchL/
         sTeP/RpXOqxhZr8fYNol2Kh+tPveIaXkor1vimCLvULC28nnrwOi6F9P+5wNvC/6hRi2
         VG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684159227; x=1686751227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzPH09o0wj4RjABN673jHX+ADMH1DGf48AY7XECThdc=;
        b=DyzSpcKZfINaJa6p46Fys9wJE0XmVkDgthaBVonuW8b0e9Q4layYofzGtEQQjQVtZN
         Bm0fWIs3038z5LRxr/yOGzPq+Pc/i2pTJam7Yj8Za+IxVbPIPYEB9fzOHNeu3+wCDPb6
         LVAAJ5svRO2JpQ18MDEU42xZ7xJZxKb95+BtZA+12yGHVq+8asUpdZdWjO4Pr5YfLINJ
         m3vkdWmV4BcqG5VR72ShY9YiEeLn0u5plIU7oeqaW/PtvzzTclWFBFLhX85ZqAWgfgGq
         tvXon7lWPDLcV6uDLlz5mM+WIohTBEtfL/yelm4e+XDTHeytfPehX7X88ggKje49UmWn
         Bd3A==
X-Gm-Message-State: AC+VfDwPs6WGyQPoTl0BeDLeoWkt3Fyy4cHYIQgCknnEbpPxG18tkP+x
        jhXarFX39KBZY8Pj+gUNXhcaTkdSUohy1MRQIO0=
X-Google-Smtp-Source: ACHHUZ5c3H4n2A0LwcavRuu227zb7x9qGDkq404AA44ID8Ps//xRxcszEFhj7z0N0fZmJcVz/dG+XtDa6Ive4ZbbKgc=
X-Received: by 2002:a05:6102:7a5:b0:42f:e81b:a803 with SMTP id
 x5-20020a05610207a500b0042fe81ba803mr13768282vsg.31.1684159227257; Mon, 15
 May 2023 07:00:27 -0700 (PDT)
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
 <CAOQ4uxg2k3DsTdiMKNm4ESZinjS513Pj2EeKGW4jQR_o5Mp3-Q@mail.gmail.com> <CAJfpegv1ByQg750uHTGOTZ7CJ4OrYp6i4MKXU13mwZPUEk+pnA@mail.gmail.com>
In-Reply-To: <CAJfpegv1ByQg750uHTGOTZ7CJ4OrYp6i4MKXU13mwZPUEk+pnA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 May 2023 17:00:16 +0300
Message-ID: <CAOQ4uxjrhf8D081Z8aG71=Kjjub28MwR3xsaAHD4cK48-FzjNA@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alessio Balsini <balsini@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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

On Mon, May 15, 2023 at 10:29=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Fri, 12 May 2023 at 21:37, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I was waiting for LSFMM to see if and how FUSE-BPF intends to
> > address the highest value use case of read/write passthrough.
> >
> > From what I've seen, you are still taking a very broad approach of
> > all-or-nothing which still has a lot of core design issues to address,
> > while these old patches already address the most important use case
> > of read/write passthrough of fd without any of the core issues
> > (credentials, hidden fds).
> >
> > As far as I can tell, this old implementation is mostly independent of =
your
> > lookup based approach - they share the low level read/write passthrough
> > functions but not much more than that, so merging them should not be
> > a blocker to your efforts in the longer run.
> > Please correct me if I am wrong.
> >
> > As things stand, I intend to re-post these old patches with mandatory
> > FOPEN_PASSTHROUGH_AUTOCLOSE to eliminate the open
> > questions about managing mappings.
> >
> > Miklos, please stop me if I missed something and if you do not
> > think that these two approaches are independent.
>
> Do you mean that the BPF patches should use their own passthrough mechani=
sm?
>
> I think it would be better if we could agree on a common interface for
> passthough (or per Paul's suggestion: backing) mechanism.

Well, not exactly different.
With BFP patches, if you have a backing inode that was established during
LOOKUP with rules to do passthrough for open(), you'd get a backing file an=
d
that backing file would be used to passthrough read/write.

FOPEN_PASSTHROUGH is another way to configure passthrough read/write
to a backing file that is controlled by the server per open fd instead of b=
y BFP
for every open of the backing inode.

Obviously, both methods would use the same backing_file field and
same read/write passthrough methods regardless of how the backing file
was setup.

Obviously, the BFP patches will not use the same ioctl to setup passthrough
(and/or BPF program) to a backing inode, but I don't think that matters muc=
h.
When we settle on ioctls for setting up backing inodes, we can also add new
ioctls for setting up backing file with optional BPF program.
I don't see any reason to make the first ioctl more complicated than this:

struct fuse_passthrough_out {
        uint32_t        fd;
        /* For future implementation */
        uint32_t        len;
        void            *vec;
};

One advantage with starting with FOPEN_PASSTHROUGH, besides
dealing with the highest priority performance issue, is how it deals with
resource limits on open files.

While the backing files are not accounted to the server, the server
is very likely to keep an open fd for the backing file until release,
otherwise, the server will not be able to perform other non-passthrough
file operations (e.g. fallocate) on the backing fd, so at least with
FOPEN_PASSTHROUGH_AUTOCLOSE, there should be only
up to 2 times the number of open files, very much the same as overlayfs.

I intend to enforce this heuristically by counting the number of passthroug=
h
fds and restrict new passthrough fd setup to the number of current open fds
by the server, so a malicious or misbehaving server cannot setup infinite
number of backing fds that it does not also keep open itself.

>
> Let's see this patchset and then we can discuss how this could be
> usable for the BPF case as well.
>

OK. I'll try to dust off these patches and re-submit.

Thanks,
Amir.
