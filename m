Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD223E2754
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244530AbhHFJfM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244184AbhHFJfL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:35:11 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01476C061798
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Aug 2021 02:34:55 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id bg4so4830251vsb.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Aug 2021 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXPn3uQPIIhP59b+FgTmiTfUvHzG+54RJLC1awAt7ps=;
        b=dmMuUniHqGRuRZWQxrlWr74O2OMbw8lF/kyBrE4T5A3oFYYup2Sh3sEFHXuchWjwI4
         X+7u3z0g0dkIcFMnoUGZddDe3zKLaBhl/DeY+lbldDuBVtiPNosBiGbhkvMDYxvYYYGq
         p3ZI39QNVaZFgcSxPxwrQH2Mjhdf7eATHaWcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXPn3uQPIIhP59b+FgTmiTfUvHzG+54RJLC1awAt7ps=;
        b=IWIZJwLN4zoWcS+afBTB7a6xjHDCztg44yokKvBpc28hpy7E2fkvnSa2opbcef2da1
         ETp0T4Ax9Ocx2eQLULWpPWWNF19gXi+JTm6aso2fmEtcqv4C5sd1bXtA7mIykru3NTZI
         1G24swiQg5Fpqv4turCOn2UL7N5n385HbClFvAajcvvxf+u/hOLmYBO+Zncfif/r/auz
         iyT7AU7wl/FXRi33pXaOoqBKLO/5pr4CzuYi/0izm7BbgJA0nxHOa2pz8BUqSYEgopSs
         F5NFjtlfSVnfkVcP9gMs1e6J5728pSIRtVgKEbhBIOQhlc4Ut30FauXx9ENGQ2rotwQm
         QA1w==
X-Gm-Message-State: AOAM53381GeGFddxCj0zHS6hLFgvFYEGRTJmpjgyJiQFw+Pf2lxiqwrD
        FrydmebvMH41ucepWL/7/EYvYZwvkuLzD1cuEXolWQ==
X-Google-Smtp-Source: ABdhPJwX8F649azmC72pLb1ZNow2hFpZuFnBsNxwPOUOr1S630r2/6W60rj5R3ev5HGbkaiyz0h6xRjOOJezwO1DIkg=
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr8193379vst.0.1628242494179;
 Fri, 06 Aug 2021 02:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000295a6a05b65efe35@google.com> <00000000000029363505c748757d@google.com>
 <CAJfpegsyFb3bC=dqUbqhs9055TW95EJO2st7iS-4sPME7Y-cmA@mail.gmail.com> <CACT4Y+Zh9Bw8DTZyvoOB_hjXwRQuRN+VHmJ-HfMqOaOu7GyVXA@mail.gmail.com>
In-Reply-To: <CACT4Y+Zh9Bw8DTZyvoOB_hjXwRQuRN+VHmJ-HfMqOaOu7GyVXA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Aug 2021 11:34:43 +0200
Message-ID: <CAJfpegu2fR3cP+eR24a1+WBBR=hvz8p2cTfK0x4sNz5c-MMH3Q@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in fuse_simple_request
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzkaller@googlegroups.com>,
        syzbot <syzbot+46fe899420456e014d6b@syzkaller.appspotmail.com>,
        areeba.ahmed@futuregulfpak.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 6 Aug 2021 at 11:15, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> ",On Fri, 6 Aug 2021 at 10:54, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Hi,
> >
> > I'm not sure what to make of this report.
> >
> > Does syzbot try to kill all tasks before generating such a hung task report?
> >
> > Does it use the fuse specific /sys/fs/fuse/connections/*/abort to
> > terminate stuck filesystems?
>
> Hi Miklos,
>
> Grepping the C reproducer for "/sys/fs/fuse/connections", it seems
> that it tries to abort all connections.

Hi  Dmitry,

So this could indicate a bug in the abort code of fuse, or it could
indicate that the test case DoS-es the system so that the abort code
simply doesn't get the resources to execute.

Can the two be differentiated somehow?

Thanks,
Miklos
