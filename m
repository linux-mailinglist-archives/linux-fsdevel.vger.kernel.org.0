Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B72D33CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 00:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfJJWNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 18:13:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37978 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfJJWNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:13:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id b20so7805612ljj.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2019 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vF7vVvcx7X2Y4bkz6NSFslpoAQ3GnfhWGvkOzcDGukk=;
        b=AePMDpuhTnjZhuA+/iTNCIk2Byoun7PsLjybqrf7awqwwp3sOrG6tM3PCboDKAch+d
         EhWYtOGQhvAGMcekGIWbotORBzlbwuFZcc8XQPO39gh+OplKN3UleWxt/iI7gTOIQILP
         MeBm7+0MuhDlPPspHH3U9j73Xa9+HDEGQFOEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vF7vVvcx7X2Y4bkz6NSFslpoAQ3GnfhWGvkOzcDGukk=;
        b=umjMpUA+hEvKqufgt5YyDEpC1oOOdwPOBvcqXR6axl0F5Dcr6b+WrZV/K6FQw8ediI
         lftwKJ6fxc1SZXgB5LNjAiMDN4+MTD1ocughb8nBX6AutsUZHcxxEwbgaNUkZyY7Gcpo
         w81YEGqDuxtjIxQhEyXtkHQh5NlXEHdntBRaqlCncvQ3G2AkRPXwfMe5hhjQT5IS0Btm
         pAeYKwn/2C8SxiJHoXCqI5MjdkFoZuKW03zofS9qtYyOA8NSztzwDLFwrCMvR1tu59Aa
         XAi8SjKdCMWoWaeWO+luIismYYwAEqvi+A5do8ZDOd1XfBaEFGJdXW1ah2PXOgNVk4pS
         TCOQ==
X-Gm-Message-State: APjAAAWbDupdwzNtRG8oPEvV+0ifmQyTfG8GosilXDSZPZpWOSBwo7Fc
        2UAkqgX/y9TKrufQBa0usNqTC1OnbCA=
X-Google-Smtp-Source: APXvYqzcmtv+AXwNiqdH3YEgauyIQleRRewQDEU4RCGI4riPZXtSUyv9aLkD9Q8RKgqi8xuHMKFPow==
X-Received: by 2002:a2e:8945:: with SMTP id b5mr7710399ljk.215.1570745587005;
        Thu, 10 Oct 2019 15:13:07 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id c4sm1549290lfm.4.2019.10.10.15.13.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 15:13:06 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id y3so7802570ljj.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2019 15:13:05 -0700 (PDT)
X-Received: by 2002:a2e:8315:: with SMTP id a21mr7522218ljh.133.1570745585422;
 Thu, 10 Oct 2019 15:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com> <20191010195504.GI26530@ZenIV.linux.org.uk>
In-Reply-To: <20191010195504.GI26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Oct 2019 15:12:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
Message-ID: <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 10, 2019 at 12:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Anyway, another question you way: what do you think of try/catch approaches
> to __get_user() blocks, like e.g. restore_sigcontext() is doing?

I'd rather have them converted to our unsafe_get/put_user() instead.

We don't generate great code for the "get" case (because of how gcc
doesn't allow us to mix "asm goto" and outputs), but I really despise
the x86-specific "{get,put}_user_ex()" machinery. It's not actually
doing a real try/catch at all, and will just keep taking faults if one
happens.

But I've not gotten around to rewriting those disgusting sequences to
the unsafe_get/put_user() model. I did look at it, and it requires
some changes exactly *because* the _ex() functions are broken and
continue, but also because the current code ends up also doing other
things inside the try/catch region that you're not supposed to do in a
user_access_begin/end() region .

> Should that be available outside of arch/*?  For that matter, would
> it be a good idea to convert get_user_ex() users in arch/x86 to
> unsafe_get_user()?

See above: yes, it would be a good idea to convert to
unsafe_get/put_user(), and no, we don't want to expose the horrid
*_ex() model to other architectures.

          Linus
