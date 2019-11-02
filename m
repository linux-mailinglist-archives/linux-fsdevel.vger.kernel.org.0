Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200D7ED0F7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 00:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfKBXKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 19:10:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34017 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfKBXKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 19:10:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id 139so13812063ljf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Nov 2019 16:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh8/ql1swcZ/RLJ8zkeObExj1w6DyGVNWtfZIlFMpeo=;
        b=Vx52JGJ2fL2ca9BB2NXhwTThadLFJNdykQ5Qc2uEp2vn5uwNFrfyadC6EXLjhvKklV
         KXMcjJQrv3h80vcy/cZZjfo/5qqKgj2fI2pWR4TA74i3RLzoy9MP14q5tRVf25F8gLLb
         ceXpd5ICYbOD7PSidUN5wWZK5ccyx9qRkG23Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh8/ql1swcZ/RLJ8zkeObExj1w6DyGVNWtfZIlFMpeo=;
        b=hKDk3homZfapexkS0nCd9RysYP5g20wUrK43zhUN/J0vbPFjITm19i+/YpA0Uo5Irq
         JntfIn72auvak1t8uSpqpyt+lO0wmIR0xkL88CKntLRlojHBGxRXp0gW4si9DkP7I8Sf
         ll3FNtuD5PAhEeBkpwMEoNwsnUhAfgClz5p9nNaKOFgNWNdbNbIxps1CeEjGVkmwIikF
         nqVhb8s/21ATssEk2eZ5lQw+rxlkQg8/qoYBbcuDzN7eXBw/36Csc+uRK8mGQQkE6ArX
         fx7pvgfUvQRbZGYh8Rh7CmCRFGklH11J8nOIcM9oueTIfM3goRGm9YI70lGZcP8WqIXx
         sI1A==
X-Gm-Message-State: APjAAAWvhaNMZEcit8RT6rhQm7IojE4PsMWwWf+uqPAkHrP97rzImbX8
        DBJPGmSYGMf805rS2jmF5ybGADgM6mA=
X-Google-Smtp-Source: APXvYqxISye6d5rkgQjtci66l7G7HzOlyj8eqYLz6QKym6RoR5k77Ss6E92SnBgx39dyF2BFGf2AzQ==
X-Received: by 2002:a2e:9216:: with SMTP id k22mr1714459ljg.157.1572736212744;
        Sat, 02 Nov 2019 16:10:12 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id d3sm4850356lfm.83.2019.11.02.16.10.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id v2so13779552lji.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr1543119lji.97.1572736211179;
 Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
 <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net> <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 16:09:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
Message-ID: <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 2, 2019 at 4:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I don't think anybody actually _did_ any of that. But that's
> basically the argument for the three splice operations:
> write/vmsplice/splice(). Which one you use depends on the lifetime and
> the source of your data. write() is obviously for the copy case (the
> source data might not be stable), while splice() is for the "data from
> another source", and vmsplace() is "data is from stable data in my
> vm".

Btw, it's really worth noting that "splice()" and friends are from a
more happy-go-lucky time when we were experimenting with new
interfaces, and in a day and age when people thought that interfaces
like "sendpage()" and zero-copy and playing games with the VM was a
great thing to do.

It turns out that VM games are almost always more expensive than just
copying the data in the first place, but hey, people didn't know that,
and zero-copy was seen a big deal.

The reality is that almost nobody uses splice and vmsplice at all, and
they have been a much bigger headache than they are worth. If I could
go back in time and not do them, I would. But there have been a few
very special uses that seem to actually like the interfaces.

But it's entirely possible that we should kill vmsplice() (likely by
just implementing the semantics as "write()") because it's not common
enough to have the complexity.

             Linus
