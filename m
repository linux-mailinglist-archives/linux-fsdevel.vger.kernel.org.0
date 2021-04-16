Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6585836226A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhDPOhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 10:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbhDPOha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:37:30 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873D3C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:04 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso3438827otl.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qf+FJe+xw5HpAnbzOHfJuUgNgS+dip/R7izw4T9zTbA=;
        b=GoX9ZN/sDS86JpD/mHBughrnxFbIv6o9YXEUEVY3kNHRz7hlm6HXFNk7XR3PQLyZ4+
         lZH2/SNmuy+6dowThikWP14ZMZgZe/fZiSXOQXaaY6cB6ZXr+3sB9joul/V9nidw/oMq
         TFllsvs9DhXxjoX0l0GYHfKWyQvMRyrDrW0c6Q9xZKrmCkVuSwKxesPdRaYrLQv9MLCS
         hFmx0eQBh6lToQ8VpAg9uttmapCpbyA3F2Y9LfzoXWKx3IQRv6/HRU93MbAlCutECMJZ
         Ziqzb0q9A7zOf36aczu2QYuHMWc9L8P5KvMTKXU9iQ41xWC6+5bRD8/GDKXohH+zg9sV
         yUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qf+FJe+xw5HpAnbzOHfJuUgNgS+dip/R7izw4T9zTbA=;
        b=Sn7I7vq7FDrGVE0ATKkkdvMMh//q8ygdoLoDaUtUpssHl4JrHEVsTTGomEAV/jUK/B
         e4MFWI7wfRdqUJ/w97/oaV9xIdc37EoYoTSjhgEe15T+DhUH7lZllcPL2dU+BQxvmJhw
         D6TYj749ATziQwPGOW9ZlVUmB0F7fZEkuBaNBFF2l+Dtj+KbdfHs7zt7x2gF1kTXpWP7
         aj0s0I7sX17udDgkKXXjry8v06Gu+nfZjrgFkTvV6J9l2tixgFHo6HNFjg0n5S7oROzR
         BjFTjYXXqnjbeGNvgt/3dRxpT5Asmrs73ZumeNdYyKUAXh9DjusL0tzmA1KGCeBsVEoP
         brAQ==
X-Gm-Message-State: AOAM532uHToEn4xLsPpnUqGS8Qy0BO1xb0O/MR7YmsZWFx9jzJOYo8g6
        iF4Fnz2vHyvHUzjiwq6Tq2dT3FovHGTydZlLJotsCilJYqyRjh5R
X-Google-Smtp-Source: ABdhPJwU/QePfsMlqHoMMMa02gdBBPK/uQOWQuy0bTPt0NIoM3QiSAU6jr/eYPFaJhZoLkT1hqp1YNGaJanr/ENDA+c=
X-Received: by 2002:a9d:204:: with SMTP id 4mr4093576otb.352.1618583823912;
 Fri, 16 Apr 2021 07:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210327035019.GG1719932@casper.infradead.org>
 <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
 <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org>
 <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
 <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
 <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com>
 <1720948.1617010659@warthog.procyon.org.uk> <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com>
 <CAOg9mSQTRfS1Wyd_ULbN8cS7FstH9ix-um9ZeKLa2O=xLgF+-Q@mail.gmail.com> <1268214.1618326494@warthog.procyon.org.uk>
In-Reply-To: <1268214.1618326494@warthog.procyon.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 16 Apr 2021 10:36:52 -0400
Message-ID: <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     David Howells <dhowells@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David...

I got your netfs-lib branch as of Apr 15.

I added my orangefs_readahead on top of it and ran through
xfstests. I failed generic 75, 112, 127, & 263, which I
don't usually fail.

I took off my orangefs_readahead patch and ran xfstests with
your untouched netfs-lib branch. No regressions.

I git-reset back to 5.12.0-rc4 (I think your netfs-lib branch is based
on a linus-tree-of-the-day?) and ran xfstests... no regressions.

So... I think all your stuff is working well from my perspective
and that I need to figure out why my orangefs_readahead patch
is causing the regressions I listed. My readahead implementation (via your
readahead_expand) is really fast, but it is bare-bones... I'm probably
leaving out some important stuff... I see other filesystem's
readahead implementations doing stuff like avoiding doing readahead
on pages that have yet to be written back for example.

The top two commits at https://github.com/hubcapsc/linux/tree/readahead_v3
is the current state of my readahead implementation.

Please do add
Tested-by: Mike Marshall <hubcap@omnibond.com>

-Mike

On Tue, Apr 13, 2021 at 11:08 AM David Howells <dhowells@redhat.com> wrote:
>
> Mike Marshall <hubcap@omnibond.com> wrote:
>
> > Hi David... I've been gone on a motorcycle adventure,
> > sorry for the delay... here's my public branch...
> >
> > https://github.com/hubcapsc/linux/tree/readahead_v3
>
> That seems to have all of my fscache-iter branch in it.  I thought you'd said
> you'd dropped them because they were causing problems.
>
> Anyway, I've distilled the basic netfs lib patches, including the readahead
> expansion patch and ITER_XARRAY patch here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-lib
>
> if that's of use to you?
>
> If you're using any of these patches, would it be possible to get a Tested-by
> for them that I can add?
>
> David
>
