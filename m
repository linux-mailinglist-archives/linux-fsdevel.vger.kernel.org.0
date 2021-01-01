Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35242E85CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jan 2021 23:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbhAAWYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jan 2021 17:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbhAAWYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jan 2021 17:24:54 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70BFC061573
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jan 2021 14:24:13 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id f29so7203476uab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jan 2021 14:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QesEHulitxiKn/Mig6QmmuDiUHli6tk016+kIdl+UB4=;
        b=XilMiKh0T/NS6V3CyEOV2zesLq+U+wBgNEBdxE9AsjKD2XNVpWJhfY+2YgGmM0Q9B0
         /bBnnelGkHOihjgqf1qn/38VBVk0Bt2vg/25lV/AhQ762Fyuiw1iCNAOezJOwsfPJq4s
         Fg9SyB83C4EAJRvdccqhr1N23R5U8h4mEmaoPjgy6ISdnA/pPcYN7mPY5HTSNaOhbUvm
         /H5X5eBaU8ybF7926XmdGht+bN5kgVUUTur3gAGT5Jh1lhJJQyadQAf8SqKNiKFHLC77
         7uuv7Y7L49VfRN8YE1cP5Hl5I4Z8rRtdcieFRtFFR3cs1SNWmzBkU10YOC6aneLcejL3
         HMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QesEHulitxiKn/Mig6QmmuDiUHli6tk016+kIdl+UB4=;
        b=JIHSk4Mu2jB3ruE2Ks2oU2I+5Jw6ELrYGQxxHSc9MlQYYIMGIOERBflaLlmBlRMELz
         N6Fo+PgtV1+tyFi1N85852xdClQg1hWOGt1q0/mSfnqAfSdJzgVnYz6X7/hQP4JEnEfY
         9sGM7mSvGDc7KQZRMy9ql3UBqJZZVh7h4gP/w3rI6up29/n+Ksqvwxv7/hKkjcnsoDV/
         tq/yi+MUujiYkWoVWyD30imbAX8lyZo5cAYFsRTrgyzT8aJ9n8+q3TTKLEyXRdyNNnGm
         /xp+Cklcuy/VvGUISkaoaD6ZSBluPCnMGNmZORCyuLfNtiHfn6WF450uYI+K+AMXCGIO
         7z0Q==
X-Gm-Message-State: AOAM531N5UUMdQ1dBPCpxm7TZ3jwl689mZTOFH54sAaIwZEOuzIqKiA5
        zW3o8nGg1qPhrH7yD7a6//FJm7HNLdTATbeatKSRWcvAOLzVBA==
X-Google-Smtp-Source: ABdhPJxbbsPcS49oSPaZZ9aq78WWl8wl9wOPyT9EFOisgbt5StCzNQ2n+6ogulf+2njERGYH5k1p2A9UTK0N9sj5+ow=
X-Received: by 2002:ab0:614d:: with SMTP id w13mr16631090uan.67.1609539852743;
 Fri, 01 Jan 2021 14:24:12 -0800 (PST)
MIME-Version: 1.0
References: <CAOg9mSQkkZtqBND-HKb2oSB8jxT6bkQU1LuExo0hPsEUhcMrPw@mail.gmail.com>
 <20210101040808.GB18640@casper.infradead.org> <CAAoczXbw9A+kqMemEsJax+CaPkQsJzZNw6Y7XFhTsBqDnGD6hw@mail.gmail.com>
In-Reply-To: <CAAoczXbw9A+kqMemEsJax+CaPkQsJzZNw6Y7XFhTsBqDnGD6hw@mail.gmail.com>
From:   Mike Marshall <hubcapsc@gmail.com>
Date:   Fri, 1 Jan 2021 17:23:49 -0500
Message-ID: <CAAoczXYEcBm9BQTzR6soB0HtMUYy0rkaVAut0M_PWc-feCp=LA@mail.gmail.com>
Subject: Fwd: problem with orangefs readpage...
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oops... my non-work email doesn't default to text only, so this
bounced to the list...

---------- Forwarded message ---------
From: Mike Marshall <hubcapsc@gmail.com>
Date: Fri, Jan 1, 2021 at 5:15 PM
Subject: Re: problem with orangefs readpage...
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Marshall <hubcap@omnibond.com>, linux-fsdevel
<linux-fsdevel@vger.kernel.org>



Hi Matthew... Thanks so much for the suggestions!

> This is some new version of orangefs_readpage(), right?

No, that code has been upstream for a while... that readahead_control
thing looks very interesting :-) ...

-Mike

On Thu, Dec 31, 2020 at 11:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Dec 31, 2020 at 04:51:53PM -0500, Mike Marshall wrote:
> > Greetings...
> >
> > I hope some of you will suffer through reading this long message :-) ...
>
> Hi Mike!  Happy New Year!
>
> > Orangefs isn't built to do small IO. Reading a
> > big file in page cache sized chunks is slow and painful.
> > I tried to write orangefs_readpage so that it would do a reasonable
> > sized hard IO, fill the page that was being called for, and then
> > go ahead and fill a whole bunch of the following pages into the
> > page cache with the extra data in the IO buffer.
>
> This is some new version of orangefs_readpage(), right?  I don't see
> anything resembling this in the current codebase.  Did you disable
> orangefs_readpages() as part of this work?  Because the behaviour you're
> describing sounds very much like what the readahead code might do to a
> filesystem which implements readpage and neither readahead nor readpages.
>
> > orangefs_readpage gets called for the first four pages and then my
> > prefill kicks in and fills the next pages and the right data ends
> > up in /tmp/nine. I, of course, wished and planned for orangefs_readpage
> > to only get called once, I don't understand why it gets called four
> > times, which results in three extraneous expensive hard IOs.
>
> I might suggest some judicious calling of dump_stack() to understand
> exactly what's calling you.  My suspicion is that it's this loop in
> read_pages():
>
>                 while ((page = readahead_page(rac))) {
>                         aops->readpage(rac->file, page);
>                         put_page(page);
>                 }
>
> which doesn't test for PageUptodate before calling you.
>
> It'd probably be best if you implemented ->readahead, which has its own
> ideas about which pages would be the right ones to read.  It's not always correct, but generally better to have that logic in the VFS than in each filesystem.
>
> You probably want to have a look at Dave Howells' work to allow
> the filesystem to expand the ractl:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
>
> specifically this patch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=fscache-iter&id=f582790b32d5d1d8b937df95a8b2b5fdb8380e46
