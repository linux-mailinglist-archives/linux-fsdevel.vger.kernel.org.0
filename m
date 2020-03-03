Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E17617782D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 15:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgCCOEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 09:04:11 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42371 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbgCCOEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:04:11 -0500
Received: by mail-oi1-f176.google.com with SMTP id l12so3064899oil.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 06:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5SOsGdj13iAaTZ5WnVwP1r7WHAp30ZWrAWiWCxl86dM=;
        b=WxAW7Dq+cdbY0wtzLnAM2VlH2TSqf4NXmWBVUykvoeNKu0upZemvsUnyBkF6IVuIIi
         ge8LIPJGIc7tyrcvEi9PkbtSuNZqCtSW326CHfIEAuKScUYB3QAWYP6rjvWNYRrZVarD
         vDAU2Bz+ZyBQ/HQYTcnjBzps25tyC/mU4q9mqLUd72qwxTT7BW17y+WZZuvkJ0UouMZw
         y1F57GzeMqh3Lpt1FHacKHEjZgeSd+0o8Qp8f+ThBtHSTmcZPaWT6BigNNyqaIAVpQWL
         0ZtY5+S2XM7utg8TdrU/zn9Ta5TszvzcKNVgNs34lSQOx3EnqjVJbhbtjVbWmxuRhTTU
         Ilig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5SOsGdj13iAaTZ5WnVwP1r7WHAp30ZWrAWiWCxl86dM=;
        b=NyE/3XAhF5KblXTYS7HNbIb7g04D3gzS2XLfcgGrzuIVWLFdoGrbKmyWCt/IdtIJOF
         yxvVRulxpWpMRc48KNyxeRsh8nvZxDVl4RzP8e6Sfdmwm3WLEPvXNXm2o8PadHPFoguL
         LdA2Uyuy0L7Tl+iFqKiH1UApZIfceXqTWrzIj31CuZOf91NmHomGEQmBfFnOSRs16GGT
         c2w2E6yqyI+eD6LSfkoiVTdnhYl7zleyK3CJi/4chq4de/816y44PUhjPZp0alH8w05s
         vk8FN+Svzb/TqdzTHKsUVPhQ3AdZR3n4DspKl6QnIHs5U19U2S3txMKZl9+en/QFafik
         B/gw==
X-Gm-Message-State: ANhLgQ3V36dt3ZF6+3/lEHFdJ/HMrLNhFa+cp8AsAyv8vm14FZv/Y+UE
        MgG53kTwer7Au2Tp4K7gKFq0Sml6VWdkdjIKQgrUUQ==
X-Google-Smtp-Source: ADFU+vvDhfQa1++FCih/IiclAQTyIDsZwsxz4995CMfE9/X3UT6uuPnEn6drjU/bt5ti5p0OT6FOt9cdLWOZlWUaKhA=
X-Received: by 2002:aca:c45:: with SMTP id i5mr2392065oiy.111.1583244250138;
 Tue, 03 Mar 2020 06:04:10 -0800 (PST)
MIME-Version: 1.0
References: <CANnVG6kZzN1Ja0EmxG3pVTdMx8Kf8fezGWBtCYUzk888VaFThg@mail.gmail.com>
 <CACQJH27s4HKzPgUkVT+FXWLGqJAAMYEkeKe7cidcesaYdE2Vog@mail.gmail.com>
 <CANnVG6=Ghu5r44mTkr0uXx_ZrrWo2N5C_UEfM59110Zx+HApzw@mail.gmail.com>
 <CAJfpegvzhfO7hg1sb_ttQF=dmBeg80WVkV8srF3VVYHw9ybV0w@mail.gmail.com>
 <CANnVG6kSJJw-+jtjh-ate7CC3CsB2=ugnQpA9ACGFdMex8sftg@mail.gmail.com>
 <CAJfpegtkEU9=3cvy8VNr4SnojErYFOTaCzUZLYvMuQMi050bPQ@mail.gmail.com> <20200303130421.GA5186@mtj.thefacebook.com>
In-Reply-To: <20200303130421.GA5186@mtj.thefacebook.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Tue, 3 Mar 2020 15:03:58 +0100
Message-ID: <CANnVG6=i1VmWF0aN1tJo5+NxTv6ycVOQJnpFiqbD7ZRVR6T4=Q@mail.gmail.com>
Subject: Re: [fuse-devel] Writing to FUSE via mmap extremely slow (sometimes)
 on some machines?
To:     Tejun Heo <tj@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jack Smith <smith.jack.sidman@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here=E2=80=99s a /proc/<pid>/stack from when the issue is happening:

[<0>] balance_dirty_pages_ratelimited+0x2ca/0x3b0
[<0>] __handle_mm_fault+0xe6e/0x1280
[<0>] handle_mm_fault+0xbe/0x1d0
[<0>] __do_page_fault+0x249/0x4f0
[<0>] page_fault+0x1e/0x30

How can I obtain the numbers for the next step?

Thanks,

On Tue, Mar 3, 2020 at 2:04 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> Sorry about the delay.
>
> On Wed, Feb 26, 2020 at 08:59:55PM +0100, Miklos Szeredi wrote:
> > - apparently memcpy is copying downwards (from largest address to
> > smallest address).  Not sure why, when I run the reproducer, it copies
> > upwards.
> > - there's a slow batch of reads of the first ~4MB of data, then a
> > quick writeback
> > - there's a quick read of the rest (~95MB) of data, then a quick
> > writeback of the same
> >
> > Plots of the whole and closeups of slow and quick segments attached.
> > X axis is time, Y axis is offset.
> >
> > Tejun, could this behavior be attributed to dirty throttling?  What
> > would be the best way to trace this?
>
> Yeah, seems likely. Can you please try offcputime (or just sample
> /proc/PID/stack) and see whether it's in balance dirty pages?
>
>   https://github.com/iovisor/bcc/blob/master/tools/offcputime.py
>
> If it's dirty throttling, the next step would be watching the bdp
> tracepoints to find out what kind of numbers it's getting.
>
> Thanks.
>
> --
> tejun
