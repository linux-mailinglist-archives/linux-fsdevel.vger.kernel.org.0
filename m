Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE94AB250
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiBFVWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 16:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiBFVWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:22:34 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7335C06173B;
        Sun,  6 Feb 2022 13:22:32 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m10so15130229oie.2;
        Sun, 06 Feb 2022 13:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pX8nlKBp44Uuhg9EXUmG+LyN9UR0HWbq6erV5cZ3MCw=;
        b=Z5DlpI7zw7u9xhBLe2a+f+1fSs8WOCd8B0d2KFkGeKOvOw+cPzUePf1hy/DcbUEwb4
         OUmgG7Fx8WxEKFluROeNi00sPbboSqtbg9ZdbEQRKXhKWsQVFRKCir/lNdYmofd+cS3p
         SzJYQOs6mYbm2K1v1aM9LpJ2cwiXVS8AP9yXGITgmY1H5LEhS1pWNmG2J3RVNtm1jFmw
         vVBH5GYPmod/iQwFY7V0OPt6sSpvPRNqLJ7vXZJoiId2anbLi7zoqYG79FBOPu6bsfN6
         uEuqcL2tJTusYAICleA3B8EsSaRh6UN1UCjlOxICzUx0FofwoCW9loDScawPLHSNNl13
         RbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pX8nlKBp44Uuhg9EXUmG+LyN9UR0HWbq6erV5cZ3MCw=;
        b=1isTVrayO5Z5UrMFT8qsKFUcbbvOLEHJirY/4u0gONyXg8dJVuxpqjubvIF2GlZnuy
         jtVMWWUnibBhbIIUZT83ugg59OicEwKPTjzGG2DBFyiRADAuO7MNIWmRrYp4ZRujC0YU
         Crw+9HwJ2Sj9QbMOWcVuxMX1Vd1o0V814WyWdqtuPOBMZbU8b6XVOQNM2k2WfP/9/gp+
         x22x9OAgWXVEDXpBmmDuQ+swbNY5cTBqEV5mDw4Sj+/l9QDEO+/DnZyBVtkLfrXEjCyK
         P1r3q4Uov+TwDDD/AmN+u2eYFq6pOcqVk4/209/26ZYRPr+Ptga+y50YaOwtA6wD0pF8
         Zfmg==
X-Gm-Message-State: AOAM5303IIUlh9558S6m7hBQDSHUFoXv6xR4wpe4Wbbz8NheARmLy2AP
        pxIQKu0+DtlB2Sa3gMBh/JTauzmsin66zygwW1zWThARbb4=
X-Google-Smtp-Source: ABdhPJyAUixt1ceMP81WcHVJryCF7r+NYUnhb68azyCQLn0ozUdZazlr5LdFrF6Nl2ghrD/Qt/d0cYobR5iFb1Ity94=
X-Received: by 2002:a05:6808:191a:: with SMTP id bf26mr6057093oib.111.1644182552251;
 Sun, 06 Feb 2022 13:22:32 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
 <YfrX1BVIlIwiVYzs@casper.infradead.org> <CAOE4rSz1OTRYQPa4PUrQ-=cwSM3iVY977Uz_d77E2j-kH0G3rA@mail.gmail.com>
 <CAPj211uKvndvR40Vjh9WAf4wRbaV5MSnmUsvDAEAKv3Q+2tDkA@mail.gmail.com> <Yf/DiefrNOkib5mm@casper.infradead.org>
In-Reply-To: <Yf/DiefrNOkib5mm@casper.infradead.org>
From:   FMDF <fmdefrancesco@gmail.com>
Date:   Sun, 6 Feb 2022 22:22:16 +0100
Message-ID: <CAPj211uFgCyri=RKnOJs2cV7-9FRFjOPLti8Jo0ODZeHEPgGAw@mail.gmail.com>
Subject: Re: How to debug stuck read?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-fsdevel@vger.kernel.org, BTRFS <linux-btrfs@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
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

On Sun, Feb 6, 2022 at 1:48 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Feb 06, 2022 at 12:01:02PM +0100, FMDF wrote:
> > On Wed, Feb 2, 2022 at 10:50 PM D=C4=81vis Mos=C4=81ns <davispuh@gmail.=
com> wrote:
> > >
> > > tre=C5=A1d., 2022. g. 2. febr., plkst. 21:13 =E2=80=94 lietot=C4=81js=
 Matthew Wilcox
> > > (<willy@infradead.org>) rakst=C4=ABja:
> > > >
> > > > On Wed, Feb 02, 2022 at 07:15:14PM +0200, D=C4=81vis Mos=C4=81ns wr=
ote:
> > > > > I have a corrupted file on BTRFS which has CoW disabled thus no
> > > > > checksum. Trying to read this file causes the process to get stuc=
k
> > > > > forever. It doesn't return EIO.
> > > > >
> > > > > How can I find out why it gets stuck?
> > > >
> > > > > $ cat /proc/3449/stack | ./scripts/decode_stacktrace.sh vmlinux
> > > > > folio_wait_bit_common (mm/filemap.c:1314)
> > > > > filemap_get_pages (mm/filemap.c:2622)
> > > > > filemap_read (mm/filemap.c:2676)
> > > > > new_sync_read (fs/read_write.c:401 (discriminator 1))
> > > >
> > > > folio_wait_bit_common() is where it waits for the page to be unlock=
ed.
> > > > Probably the problem is that btrfs isn't unlocking the page on
> > > > seeing the error, so you don't get the -EIO returned?
> > >
> > >
> > > Yeah, but how to find where that happens.
> > > Anyway by pure luck I found memcpy that wrote outside of allocated
> > > memory and fixing that solved this issue but I still don't know how t=
o
> > > debug this properly.
> > >
> > There is no special recipe for debugging "this properly" :)
> >
> > You wrote that "by pure luck" you found a memcpy() that wrote beyond th=
e
> > limit of allocated memory. I suppose that you found that faulty memcpy(=
)
> > somewhere in one of the function listed in the stack trace.
>
> I very much doubt that.  The code flow here is:
>
> userspace calls read() -> VFS -> btrfs -> block layer -> return to btrfs
> -> return to VFS, wait for read to complete.  So by the time anyone's
> looking at the stack trace, all you can see is the part of the call
> chain in the VFS.  There's no way to see where we went in btrfs, nor
> in the block layer.  We also can't see from the stack trace what
> happened with the interrupt which _should have_ cleared the lock bit
> and didn't.
>
OK, I agree. This appears to be is one of those special cases where the mer=
e
reading of a stack trace cannot help much... :(

My argument is about a general approach to debugging some unknown code
by just reading the calls chain. Many times I've been able to find out what=
 was
wrong with code I had never seen before by just following the chain of call=
s
in subsystems that I know nothing of (e.g., a bug in "tty" that was reporte=
d by
Syzbot).

In this special case, if the developer doesn't know that "the interrupt [wh=
ich]
_should have_ cleared the lock bit and didn't." there is nothing that one c=
an
deduce from a stack trace.

Here one need to know how things work, well beyond the functions that are
listed in the trace. So, probably, if one needs a "recipe" for those cases,=
 the
recipe is just know the subsystem(s) at hand and know how the kernel manage=
s
interrupts.

Actually I haven't deepened this issue but, by reading what Matthew writes,
I doubt that a faulty memcpy() can be the culprit... Davis, are you really =
sure
that you've fixed that bug?

Regards,

Fabio
