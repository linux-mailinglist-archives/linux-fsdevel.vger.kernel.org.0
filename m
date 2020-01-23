Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB7A147237
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 20:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAWT6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 14:58:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40149 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWT6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:58:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18so5038356ljo.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2020 11:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DVtOQwrFkEAE5or+ctC9NfF/UngBhO5F9zvyg/cwIE=;
        b=eQxTZQW0N74htNr8ZIoBTg2RQDPW3OjTEHCMc4sFe5oYhaOUGSJvrl6o1eL0CZRoF6
         x82sJpEoaWzhBeyAQr4AJVLWbXFgY8LgUhy1SsB1ddXX6DI1lqW3atZTfWsWptXew+SX
         fwPcf1xNLR3ZLFeVh0I0M9xVVUDiWrMIvhW4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DVtOQwrFkEAE5or+ctC9NfF/UngBhO5F9zvyg/cwIE=;
        b=KNu910ZeM931TMHPwNbC3tq144UNyrddC6ANAD0lFEAL0IixMWsdFCmsw4gqjUaRmy
         diWZ8gbd0KH/f1JJaSS2Yk5fm2NQqKH8Ec7EuHNanIdgintC81jt5c0yxVmY6xcLA/95
         +bvJ9QUe/QJ1W2VrJR/QNAe3PFPE6DqAVqj/WEqHl4+0EU/Vje3pN9Oh00MTukAz5u1d
         dsaXlyNV63PzVai30YEcB2XrGSI9by7f27j+UNuEZQniODZHo8t4NyQjrd45zzHLs8hA
         MF0YBsQFWwYch1rDI9Qp9kjn2pdyhncAm2qV4GU+j855t3oKm/FlhNE0F4gh9Ai4yEB6
         +dIg==
X-Gm-Message-State: APjAAAXaeQ2JTK6lRPvuVtL/0F6ya64N/3p6YkpWGcto7SpeSSurBryI
        xKRCcur6CzLCY7qvTWJnGdaJjPXKzNI=
X-Google-Smtp-Source: APXvYqxShifTieDzMakRyx9ZtW72qTonMISZlZy7VwePZbash6Gos4uNaZAU6rOiNlT6qvggKo+FDA==
X-Received: by 2002:a2e:548:: with SMTP id 69mr14608ljf.67.1579809497492;
        Thu, 23 Jan 2020 11:58:17 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 78sm1867796ljj.28.2020.01.23.11.58.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:58:14 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id j1so5094478lja.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2020 11:58:14 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr3682ljk.201.1579809493632;
 Thu, 23 Jan 2020 11:58:13 -0800 (PST)
MIME-Version: 1.0
References: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
 <e11a8f0670251267f87e3114e0bdbacb1eb72980.1579783936.git.christophe.leroy@c-s.fr>
 <CAHk-=wg4HEABOZdjxMzbembNmxs1zYfrNAEc2L+JS9FBSnM8JA@mail.gmail.com> <fc5c94a2-5a25-0715-5240-5ba3cbe0f2b2@c-s.fr>
In-Reply-To: <fc5c94a2-5a25-0715-5240-5ba3cbe0f2b2@c-s.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 11:57:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8FvaeRv6PpisQ+L_Cv52yE6jCxZzUHQPZ_K7HzFkaBQ@mail.gmail.com>
Message-ID: <CAHk-=wi8FvaeRv6PpisQ+L_Cv52yE6jCxZzUHQPZ_K7HzFkaBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] uaccess: Tell user_access_begin() if it's for a
 write or not
To:     christophe leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 11:47 AM christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
> I'm going to leave it aside, at least for the time being, and do it as a
> second step later after evaluating the real performance impact. I'll
> respin tomorrow in that way.

Ok, good.

From a "narrow the access window type" standpoint it does seem to be a
good idea to specify what kind of user accesses will be done, so I
don't hate the idea, it's more that I'm not convinced it matters
enough.

On x86, we have made the rule that user_access_begin/end() can contain
_very_ few operations, and objtool really does enforce that. With
objtool and KASAN, you really end up with very small ranges of
user_access_begin/end().

And since we actually verify it statically on x86-64, I would say that
the added benefit of narrowing by access type is fairly small. We're
not going to have complicated code in that user access region, at
least in generic code.

> > Also, it shouldn't be a "is this a write". What if it's a read _and_ a
> > write? Only a write? Only a read?
>
> Indeed that was more: does it includes a write. It's either RO or RW

I would expect that most actual users would be RO or WO, so it's a bit
odd to have those choices.

Of course, often writing ends up requiring read permissions anyway if
the architecture has problems with alignment handling or similar, but
still... The real RW case does exist conceptually (we have
"copy_in_user()", after all), but still feels like it shouldn't be
seen as the only _interface_ choice.

IOW, an architecture may decide to turn WO into RW because of
architecture limitations (or, like x86 and arm, ignore the whole
RO/RW/WO _entirely_ because there's just a single "allow user space
accesses" flag), but on an interface layer if we add this flag, I
really think it should be an explicit "read or write or both".

So thus my "let's try to avoid doing it in the first place, but if we
_do_ do this, then do it right" plea.

                 Linus
