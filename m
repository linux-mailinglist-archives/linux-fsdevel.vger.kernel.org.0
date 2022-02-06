Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A04AB2CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 00:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbiBFXWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 18:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241365AbiBFXWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 18:22:10 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09E1C06173B;
        Sun,  6 Feb 2022 15:22:06 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id o15so6908630vki.2;
        Sun, 06 Feb 2022 15:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wtQhWRukk8Wpp5yxiX70FWMA1ONW4KzaDWRD7a/WsqY=;
        b=A0QUuSW8b9cjuOgm47aFCdUrAUMhovJehvDRNNB/D/Y+gPfvJvlLeY6J6UAUVPvMun
         akdVzUAZmIP9BrAQg/79XR35udHIho0mRWQUQM7elimczZTkB2Z8DNNlPTisVJih50xC
         BfcmFyVJuV6cBUPcLrNLoIgNtc2uvW3rIPYCda2QJqvz24FK5cet7sL1lfD7TgRI/1uv
         mao9SyzNxgSYu+jjH/O4y/whaj08GG4yDAqyzKhn5BjAEZPf6Ukqo4vrdpxUHY6nxN29
         Pk5ruXVuQFiJ7vHsR/ldFVGMZpVvxbKcvPATwaSN50VtmylE8hUB4A4wCqQggcuQiF04
         9F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wtQhWRukk8Wpp5yxiX70FWMA1ONW4KzaDWRD7a/WsqY=;
        b=rVf5Q5BRZzYO4HwVpQkHOJpq059HrXJZZX+pY5ixQ4sUhJNmTvNxwh2DTiHU99Fq8/
         QVnzeHxfnFxyahIi4FA1pgd3xCtgK2p+O6N0iYH10ovyI3RTJFG77KGsYfZCUOIMpfZS
         aMAZBo1RKa8hPFBO0baSP85ZglxPqPoU9YWojikfC2xitYtQ7zOJdCMOp9mnxYzJNgpP
         lpHqxKEGokEYHA128wNSSf+rgqbzw60DLDq5GMnJCcjxom1DKvHedGtewZvwO+1o3TnL
         flWg3X4DsOnCW6a7bwNqCdmp2uAalf4m7Fb9JUNksRa3wMXh1E/Wa2Sr5Ux9LUUVSe4i
         VCQQ==
X-Gm-Message-State: AOAM531IVM7cUvl7fKKoJC2QbJMCT+2Qwiz5sOQ0HH7mc+gOzhcg6AwP
        WYe0zlUyrKm6J7AgKZwTp8oMtdctyD/s4sPStPotQQ6vLLmV/g==
X-Google-Smtp-Source: ABdhPJzV5rhh3k03ePB/c8oIQZU6dG1WdiwRzWJisegxne9dIx5hvJaLg8JuP4SJUSC+AoLHrVLctiHg/AZGuV44qps=
X-Received: by 2002:a05:6122:91b:: with SMTP id j27mr4257514vka.32.1644189724840;
 Sun, 06 Feb 2022 15:22:04 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
 <YfrX1BVIlIwiVYzs@casper.infradead.org> <CAOE4rSz1OTRYQPa4PUrQ-=cwSM3iVY977Uz_d77E2j-kH0G3rA@mail.gmail.com>
 <CAPj211uKvndvR40Vjh9WAf4wRbaV5MSnmUsvDAEAKv3Q+2tDkA@mail.gmail.com>
 <Yf/DiefrNOkib5mm@casper.infradead.org> <CAPj211uFgCyri=RKnOJs2cV7-9FRFjOPLti8Jo0ODZeHEPgGAw@mail.gmail.com>
In-Reply-To: <CAPj211uFgCyri=RKnOJs2cV7-9FRFjOPLti8Jo0ODZeHEPgGAw@mail.gmail.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Mon, 7 Feb 2022 01:21:53 +0200
Message-ID: <CAOE4rSzJtDwDpb6PDN-E1i=b5p6jePu7wnKKgwr8dnwextaxUw@mail.gmail.com>
Subject: Re: How to debug stuck read?
To:     FMDF <fmdefrancesco@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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

sv=C4=93td., 2022. g. 6. febr., plkst. 13:01 =E2=80=94 lietot=C4=81js FMDF
(<fmdefrancesco@gmail.com>) rakst=C4=ABja:
[...]
> There is no special recipe for debugging "this properly" :)
>
> You wrote that "by pure luck" you found a memcpy() that wrote beyond the
> limit of allocated memory. I suppose that you found that faulty memcpy()
> somewhere in one of the function listed in the stack trace.
>
> That's the right approach! You read the calls chain and find out where so=
mething
> looks wrong and then fix it. This is why stack traces are so helpful.
>
> It was not "pure luck". I think that you did what developers usually do a=
fter
> decoding a stack trace. If not, how did you find that faulty memcpy() bur=
ied
> somewhere in 40 millions lines of code?
>
> it seems that you've found the right way to figure out the problems in co=
de
> that (probably) you had not ever worked on or read before you hit that bu=
g.
>

I think there should be a way to see which locks (and by who/where)
have been taken for a long time. In this case it would be just this
one as no one should take a lock for 10+ mins and such. Here we have
several complications that make figuring this out difficult. Firstly
you can get crash only once per boot. Killing process and reading file
again you won't get any crash at all but process will always get
stuck. Not even dropping caches changes anything. That's why I
couldn't figure out what is the issue because I tried repeating it
several times and never got any new crash in dmesg. Secondly even if
you see some crash in dmesg, your process didn't crash and it's not
clear if it is related to your issue - how to link kernel side crash
with your stuck process. Finally the way how this bug is it was
possible for it to not cause any crash but I'm guessing process
probably wouldn't have stuck then.

> Have you sent a patch to the LKML? If not, please do it.
>
Yeah I did, see patch titled: "[PATCH 2/2] btrfs: prevent copying too
big compressed lzo segment"



sv=C4=93td., 2022. g. 6. febr., plkst. 23:22 =E2=80=94 lietot=C4=81js FMDF
(<fmdefrancesco@gmail.com>) rakst=C4=ABja:
>
> On Sun, Feb 6, 2022 at 1:48 PM Matthew Wilcox <willy@infradead.org> wrote=
:
> >
> > On Sun, Feb 06, 2022 at 12:01:02PM +0100, FMDF wrote:
[...]
> >
> > I very much doubt that.  The code flow here is:
> >
> > userspace calls read() -> VFS -> btrfs -> block layer -> return to btrf=
s
> > -> return to VFS, wait for read to complete.  So by the time anyone's
> > looking at the stack trace, all you can see is the part of the call
> > chain in the VFS.  There's no way to see where we went in btrfs, nor
> > in the block layer.  We also can't see from the stack trace what
> > happened with the interrupt which _should have_ cleared the lock bit
> > and didn't.
> >
> OK, I agree. This appears to be is one of those special cases where the m=
ere
> reading of a stack trace cannot help much... :(
>
> My argument is about a general approach to debugging some unknown code
> by just reading the calls chain. Many times I've been able to find out wh=
at was
> wrong with code I had never seen before by just following the chain of ca=
lls
> in subsystems that I know nothing of (e.g., a bug in "tty" that was repor=
ted by
> Syzbot).
>
> In this special case, if the developer doesn't know that "the interrupt [=
which]
> _should have_ cleared the lock bit and didn't." there is nothing that one=
 can
> deduce from a stack trace.
>
> Here one need to know how things work, well beyond the functions that are
> listed in the trace. So, probably, if one needs a "recipe" for those case=
s, the
> recipe is just know the subsystem(s) at hand and know how the kernel mana=
ges
> interrupts.
>

Yeah, that's why I'm saying it was by luck :P The way how I fixed this
was pretty much accidental byproduct. Basically for this issue all I
saw in dmesg was "invalid lzo header". By looking at that part of code
I didn't see anything suspicious and also issue happened after this so
it wasn't culprit (but did hint it could be something related to
this). Anyway at this point I gave up on it, but I saw that I have one
crash in dmesg so I thought I'll fix that. I didn't thought it's
related to this issue, but once I fixed that this also was solved.

> Actually I haven't deepened this issue but, by reading what Matthew write=
s,
> I doubt that a faulty memcpy() can be the culprit... Davis, are you reall=
y sure
> that you've fixed that bug?
>

Yep, fully sure and tested :P I'm able to reproduce stuck process with
100% reliability. After applying my patch it returns EIO as expected
and doesn't get stuck.
If you look at copy_compressed_segment (in fs/btrfs/lzo.c) you'll see
  kaddr =3D kmap(cur_page);
  memcpy(dest + *cur_in - orig_in,
                 kaddr + offset_in_page(*cur_in), copy_len);
  kunmap(cur_page);

My guess is that kmap(cur_page) locks that page, then memcpy crashes
so that page never gets unmapped causing anyone that tries to map it
to wait forever. Hence this can be reproduced only once per boot. If I
knew how to find kernel thread that is running this we could check
it's stack and it should be stuck here on kmap.
