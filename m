Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9A736B98F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbhDZTCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 15:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbhDZTCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:02:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB945C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 12:01:34 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i26so2099250oii.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2KbT7PQc2n/dov1wT9gi/ffjoBVZa5sAbsDoX32iVI=;
        b=HdwapXQD8JIZzQWEQnnFOA6s+24knQad0BSYg8MjUQs+P9VBTSS6igat8tBoMI+FiL
         WYdGdiS9E5P3BfG7AyRHzqRS6JgumYvrdiSzAAJLCJxK3OiUOl7OTz93wwqflQYbxAN1
         heWm17MS38rRK1aZ+Rb8iHSZEXrsnXw7z8osNhgXMj7JY2+AiGGdGkYHfqIwemkZXi3C
         /6M2j2G7GVHdTMLHOvyxinAP3j4AuFry6AsYf4maGpzhmx/Knc/GLtjnGEUtNaIpcF03
         JfESMsp3w72otzGrCTnYbhgP/Xzr2LDeZAGtH/7VF2ZiGCBP6DO0kKgAhXfx2lMR6w3l
         9BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2KbT7PQc2n/dov1wT9gi/ffjoBVZa5sAbsDoX32iVI=;
        b=RHfTwNJ9owgTHqMkbD6gbt7oPiMGsfFjcRL3e4+Pcut0Lr5MFQXJURvs1FKaMAASmU
         Z8dfX095UI728nai6syNArQcPzdYFpLM1w9mxgyTWzjgr7R9Qc/+r9FgVbSO6xUq18Ew
         tmbVpSB97bUWL54ILuALAgMlGJ8o/M9FV7Mrj9RnmNXUcQqVRGvw2/zDQw+MtnoumD+X
         xBqaps3lxOrh4KWtGYwPWMzKKayczjsH/jPs26gAV10H6jIXWk0F6NfwqUYOsHLow/4U
         2wrRA4jRDN3MWVQANCfJOUIUp4xObFV5b2V5Wq/E8hzBLGeu4bQTi2NihyBFwvjdgdId
         N0oA==
X-Gm-Message-State: AOAM531dcm2udgHv2eYXjGgHHtCZhCYWuehSeik6SjgK9jRXHWLQB2cg
        EhAVQ66jUcOWYfiUFyrg51IWzxJ1s4orDzxQo6SNmw==
X-Google-Smtp-Source: ABdhPJyj7SqHPsAIeji8lohEArEDupo5Jd3A9LJSKNP3p08pKaIDp8aSLYv9a1mOcd3iiIMj7HyfKgGk4epqyF7mchw=
X-Received: by 2002:aca:ea06:: with SMTP id i6mr13179392oih.82.1619463694156;
 Mon, 26 Apr 2021 12:01:34 -0700 (PDT)
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
 <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com>
 <1612829.1618587694@warthog.procyon.org.uk> <CAOg9mSTwNKPdRMwr_F87YCeUyxT775pBd5WcewGpcwSZFVz5=w@mail.gmail.com>
 <3365453.1619336991@warthog.procyon.org.uk> <CAOg9mSSCFJ2FgQ2TAeaz6CLf010wbsBws6h6ou0NW8SPNBzwSg@mail.gmail.com>
In-Reply-To: <CAOg9mSSCFJ2FgQ2TAeaz6CLf010wbsBws6h6ou0NW8SPNBzwSg@mail.gmail.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 26 Apr 2021 15:01:23 -0400
Message-ID: <CAOg9mSTXDHyE5W7-GQt0+u3z=SM7w8=bh=VwR2F8ShO=5kKbuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     David Howells <dhowells@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I added the "Four fixes for ITER_XARRAY" patch and got things
running again.

I ran the tests I had regressions on by themselves, and I still fail
generic/075, generic/112, generic/127 and generic/263.

generic/438 passes now.

I was analyzing what test 075 was doing when it was failing, and I
found it to be doing this:

/home/hubcap/xfstests-dev/ltp/fsx -d -N 1000 -S 0 -P
/home/hubcap/xfstests-dev /pvfsmnt/whatever

The above used to fail every time... now it works every time.

Progress :-).

I'm about to launch the whole suite of tests, I'll report back
on what happens later...

-Mike

On Mon, Apr 26, 2021 at 10:53 AM Mike Marshall <hubcap@omnibond.com> wrote:
>
> >> Is it easy to set up an orangefs client and server?
>
> I think it is easy to set up a test system on a single VM,
> but I do it all the time. I souped up the build details in
> Documentation/filesystems/orangefs.rst not too long
> ago, I hope it is useful.
>
> Your VM would need to be a "developer" VM,
> with all the autotools stuff and such if you build
> from source. I also worked on the configure stuff
> so that you would learn about any packages you
> lack at configure time, I hope that is also still good.
>
> I read your message about trying again with the
> "Four fixes for ITER_XARRAY" patch, I'll report
> on how that goes...
>
> -Mike
>
> On Sun, Apr 25, 2021 at 3:49 AM David Howells <dhowells@redhat.com> wrote:
> >
> > Mike Marshall <hubcap@omnibond.com> wrote:
> >
> > > >> I wonder if you should use iov_length(&iter)
> > >
> > > iov_length has two arguments. The first one would maybe be iter.iov and
> > > the second one would be... ?
> >
> > Sorry, I meant iov_iter_count(&iter).
> >
> > I'll look at the other things next week.  Is it easy to set up an orangefs
> > client and server?
> >
> > David
> >
