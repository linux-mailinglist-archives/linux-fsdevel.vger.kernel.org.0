Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521D217E293
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCIOcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:32:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40699 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgCIOcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:32:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id x19so9736299otp.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2020 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wwttuEgJLrHDrsoeti/WRvxYN1vo6oc1Gkxoo3LNrYk=;
        b=Y56O/CGGKX6JjG/tEDKs8wpA5NNiUKYMORJsS8olRIwd59un5niG5ggzfTBmi4Bg07
         0H1ibRSQqIFB7VLHmmT06mg5RCILlUW9t/SD5sGQJJ+U2GSY/lIu0s1ea36tIEZ+XJzI
         TBxZrdg5Cy1scfui5yXeQFBJ6rw2oHdp6vaaS5yN66UQLQrp4pvVYm+KPahqIj00uVqY
         HQNpDynu37ITkchS+hc7B7c37s81wORIk3IBpeMvwVwHzb2V6ZlelvM7adcK5iT48dsk
         HNg+ObkT602w7saoTpwRHm88aaE9h1QcmHAJ7Az283YsljOM3K/Dctx5oa157lQ8mGbm
         GW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wwttuEgJLrHDrsoeti/WRvxYN1vo6oc1Gkxoo3LNrYk=;
        b=cH/F7uwqltoel9BiTQkJSUsSIrdf5TcooDsH4G6U+ofdj2nW/yeGLTzR3PeDLoC1eh
         CSFfkYFAiSjGwINuU8wsjil39bQdGWo3iSOmsSNEV/e3Ws6Jxiik33MbnxUHO6vbz9Et
         gx3Q4JI1ZgvWM0T3ONdCLKPmcmghf7YlZhus0/8lWB1WETQOMj0HljOClHCsaAD0/HM3
         TQNp1Vxz0Ucidy5KuI/iaqi1TiNTnzGgBfnHYgnzNe8a07R//tnVID1VpkzE0VPQwVdi
         a+xCzZlkSW4S4ViPnMW61Dt+y/snMJadtta3rX0x4KsGJL30+xCWBaTlumeSaBnostA1
         sd1A==
X-Gm-Message-State: ANhLgQ08SIMIkNduvLYF21QXWB1jUJTThhl1fMF5nmEv/NAcvI3cxoLt
        /q3GL9LpZMXbQN+3DtAwvLeKbz/Zog2PPUkfs62UqQ==
X-Google-Smtp-Source: ADFU+vurIp6uaBT8quIe8mrP94VZjXTFnvdeCAPZtjSz8BnPkGOgpzEY/LeTYfHsFd1fuP3uoZtuU1x60QjucjHoAY8=
X-Received: by 2002:a9d:3e89:: with SMTP id b9mr13399637otc.3.1583764360881;
 Mon, 09 Mar 2020 07:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <CANnVG6kZzN1Ja0EmxG3pVTdMx8Kf8fezGWBtCYUzk888VaFThg@mail.gmail.com>
 <CACQJH27s4HKzPgUkVT+FXWLGqJAAMYEkeKe7cidcesaYdE2Vog@mail.gmail.com>
 <CANnVG6=Ghu5r44mTkr0uXx_ZrrWo2N5C_UEfM59110Zx+HApzw@mail.gmail.com>
 <CAJfpegvzhfO7hg1sb_ttQF=dmBeg80WVkV8srF3VVYHw9ybV0w@mail.gmail.com>
 <CANnVG6kSJJw-+jtjh-ate7CC3CsB2=ugnQpA9ACGFdMex8sftg@mail.gmail.com>
 <CAJfpegtkEU9=3cvy8VNr4SnojErYFOTaCzUZLYvMuQMi050bPQ@mail.gmail.com>
 <20200303130421.GA5186@mtj.thefacebook.com> <CANnVG6=i1VmWF0aN1tJo5+NxTv6ycVOQJnpFiqbD7ZRVR6T4=Q@mail.gmail.com>
 <20200303141311.GA189690@mtj.thefacebook.com> <CANnVG6=9mYACk5tR2xD08r_sGWEeZ0rHZAmJ90U-8h3+iSMvbA@mail.gmail.com>
 <20200303142512.GC189690@mtj.thefacebook.com> <CANnVG6=yf82CcwmdmawmjTP2CskD-WhcvkLnkZs7hs0OG7KcTg@mail.gmail.com>
In-Reply-To: <CANnVG6=yf82CcwmdmawmjTP2CskD-WhcvkLnkZs7hs0OG7KcTg@mail.gmail.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Mon, 9 Mar 2020 15:32:29 +0100
Message-ID: <CANnVG6n=_PhhpgLo2ByGeJrrAaNOLond3GQJhobge7Ob2hfJrQ@mail.gmail.com>
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

Here=E2=80=99s one more thing I noticed: when polling
/sys/kernel/debug/bdi/0:93/stats, I see that BdiDirtied and BdiWritten
remain at their original values while the kernel sends FUSE read
requests, and only goes up when the kernel transitions into sending
FUSE write requests. Notably, the page dirtying throttling happens in
the read phase, which is most likely why the write bandwidth is
(correctly) measured as 0.

Do we have any ideas on why the kernel sends FUSE reads at all?

On Thu, Mar 5, 2020 at 3:45 PM Michael Stapelberg
<michael+lkml@stapelberg.ch> wrote:
>
> Thanks for taking a look!
>
> Find attached a trace file which illustrates that the device=E2=80=99s wr=
ite
> bandwidth (write_bw) decreases from the initial 100 MB/s down to,
> eventually, 0 (not included in the trace). When seeing the
> pathologically slow write-back performance, I observed write_bw=3D0!
>
> The trace was generated with these tracepoints enabled:
> echo 1 > /sys/kernel/debug/tracing/events/writeback/balance_dirty_pages/e=
nable
> echo 1 > /sys/kernel/debug/tracing/events/writeback/bdi_dirty_ratelimit/e=
nable
>
> I wonder why the measured write bandwidth decreases so much. Any thoughts=
?
>
> On Tue, Mar 3, 2020 at 3:25 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Tue, Mar 03, 2020 at 03:21:47PM +0100, Michael Stapelberg wrote:
> > > Find attached trace.log (cat /sys/kernel/debug/tracing/trace) and
> > > fuse-debug.log (FUSE daemon with timestamps).
> > >
> > > Does that tell you something, or do we need more data? (If so, how?)
> >
> > This is likely the culprit.
> >
> >  .... 1319822.406198: balance_dirty_pages: ... bdi_dirty=3D68 dirty_rat=
elimit=3D28 ...
> >
> > For whatever reason, bdp calculated that the dirty throttling
> > threshold for the fuse device is 28 pages which is extremely low. Need
> > to track down how that number came to be. I'm afraid from here on it'd
> > mostly be reading source code and sprinkling printks around but the
> > debugging really comes down to figuring out how we ended up with 68
> > and 28.
> >
> > Thanks.
> >
> > --
> > tejun
