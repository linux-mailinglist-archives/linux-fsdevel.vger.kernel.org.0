Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB5DAC8AF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 20:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbfIGSPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Sep 2019 14:15:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39018 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfIGSPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:15:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id s12so6623698pfe.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Sep 2019 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yCXO2IUW/xP5rGitFpbGKrkQxCFizP24AMzmcKYJo+k=;
        b=gPB2S/s21fOdrhZkZvzaMRRbkTHlbc79vLkQ8L7Cpmmu8hvbAG6eoC0Dm32QXRGYMY
         +1LPES8i+LJBkfY/p1yzpRzMMv2odDchTO0YHOkxwFiie7OsEOHDwtOH8zJJ6F9AZyk5
         MkZFVhvuxPxeMIKfq+G9obcmbfsQBob0Nc70jrYQVbX0W8tNU0vMgyrejbOLHj/PJBII
         8jO1EQn6kWKOgkBib76U4yxHBzWI3KaSO/lLhJIPi5x1WrjQ3kHOZysmKhg2Dv2MsCh4
         N/OxZH40a7P6xhJ/lAgfa+dSsRZSJmy+02UKql6Xb3VKWtRKJq/2ht+J5tBxXcxSYFTB
         1GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yCXO2IUW/xP5rGitFpbGKrkQxCFizP24AMzmcKYJo+k=;
        b=aq2RmPQPLt26uzqqmR4PeL7vhQzpcQLlO2gZ51mHROZrRP0XDARhTyG+xE/EeXCz8M
         Y632Xhwxrl8sRu7mv05ePjiLNcglwrpyJoOC2FXh/C8NKk7w0nHem4+FRhucbBLapaAk
         ie1xsQWPdInUtVeNiB6Qm4szGpwjZMx49cEDvddLufp+9Y9p6Na/7RLczocYWWSivX0G
         29/KN0t+lDV7UL0VuZL4BuxG3Lejjozta8IYDpPIeeZF2NGrv0MbpgZwb4fkYv+rvcH5
         18tcMU8bT5KDkCDWGFfo9LESdEHjyYxcInOAXPDLNLJ1QWiw5YWzaOh5VYTeJQ2zg2vU
         cnQA==
X-Gm-Message-State: APjAAAVqE4L99tpThnTEol3lCGALNvTRIKVZZQx/z8muYy+kc3vAtEY4
        Xu35r1rAJ00yW2YyhHMz7JpIMg==
X-Google-Smtp-Source: APXvYqwtLHTxDBZPI4nj5nW8UmB/sRAqU0rGQe5gnm9Rg561yB9Atb14l/OoZSzCcZVB4Qk4BIIw8Q==
X-Received: by 2002:aa7:8b09:: with SMTP id f9mr13154710pfd.23.1567880111917;
        Sat, 07 Sep 2019 11:15:11 -0700 (PDT)
Received: from ?IPv6:2600:100f:b121:da37:bc66:d4de:83c7:e0cd? ([2600:100f:b121:da37:bc66:d4de:83c7:e0cd])
        by smtp.gmail.com with ESMTPSA id x5sm10495873pfn.149.2019.09.07.11.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 11:15:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <CAHk-=whe90Ec_RRrMRLE0=bJOHNS9YmVwcytVxmrfK3oCuZF6A@mail.gmail.com>
Date:   Sat, 7 Sep 2019 11:15:09 -0700
Cc:     Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE7399FD-7587-407B-B628-1D92CFD6B120@amacapital.net>
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-12-cyphar@cyphar.com> <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org> <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com> <C81D6D29-F6BF-48E6-A15E-3ABCB2C992E5@amacapital.net> <CAHk-=whe90Ec_RRrMRLE0=bJOHNS9YmVwcytVxmrfK3oCuZF6A@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Sep 7, 2019, at 10:45 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>> On Sat, Sep 7, 2019 at 10:42 AM Andy Lutomirski <luto@amacapital.net> wro=
te:
>>=20
>> Linus, you rejected resolveat() because you wanted a *nice* API
>=20
> No. I rejected resoveat() because it was a completely broken garbage
> API that couldn't do even basic stuff right (like O_CREAT).
>=20
> We have a ton of flag space in the new openat2() model, we might as
> well leave the old flags alone that people are (a) used to and (b) we
> have code to support _anyway_.
>=20
> Making up a new flag namespace is only going to cause us - and users -
> more work, and more confusion. For no actual advantage. It's not going
> to be "cleaner". It's just going to be worse.
>=20
>=20

If we keep all the flag bits in the same mask with the same values, then we=E2=
=80=99re stuck with O_RDONLY=3D0 and everything that implies.  We=E2=80=99ll=
 have UPGRADE_READ that works differently from the missing plain-old-READ bi=
t, and we can=E2=80=99t express execute-only-no-read-or-write. This sucks.

Can we at least split the permission bits into their own mask and make bits 0=
 and 1 illegal in the main set of flags in openat2?

There=E2=80=99s another thread going on right now about adding a bit along t=
he lines of =E2=80=9CMAYEXEC=E2=80=9D, and one of the conclusions was that i=
t should wait for openat2 so that it can have same semantics. If we=E2=80=99=
re stuck with O_RDONLY and friends, then MAYEXEC is doomed to being at least=
 a bit nonsensical.

As an analogy, AMD64 introduced bigger PTEs but kept the same nonsense encod=
ing of read and write permission. And then we got NX, and now we=E2=80=99re g=
etting little holes in the encoding stolen by CET to mean new silly things. =
 I don=E2=80=99t know if you=E2=80=99ve been following the various rounds of=
 patches, but it is truly horrible. The mapping from meaning to the actual b=
its is *shit*, and AMD64 should have made a clean break instead.

open()=E2=80=99s permission bits are basically the same situation. And the k=
ernel *already* has a non-type-safe translation layer. Please, please let op=
enat2() at least get rid of the turd in open()=E2=80=99s bits 0 and 1.

