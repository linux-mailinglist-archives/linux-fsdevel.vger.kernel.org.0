Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43EAAC848
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 19:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406148AbfIGRm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Sep 2019 13:42:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46129 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393335AbfIGRm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:42:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id t1so4653241plq.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Sep 2019 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zOxFxXxkeAXBLA4hmpQx5p2K1SwU8yRrMWsF/vzne4c=;
        b=Ahrc72PGzKNYWoLbwpqpkb4sblxxhLeem6jebRPHiC48yikyu8YdaM5Oje1cRKpGrE
         B1aFxjVmVluxNvScD9M4WSgd+3044EW5n5U/PFuuVmQG4Hbymvgt22zE94vbhcs9R725
         YmVhBFQvI6AY2jzBjl65iE1N91bXW5n21nVFyaplmtDp+2SiGPjY7BdJbCgTW6FOdyps
         WzpWqeuBT7oibyk4x8aGykU8dzYGBQ3SiApw6VGFkEO8SPi7/aZ892rQXq+Pb+3b5ZeC
         PbzZzd392k2TpO4uq92p9v5vThdZeJX5HF5wKk1rRbCSaXdBoZUNJaEVn/U3I0P9Ilwr
         6irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zOxFxXxkeAXBLA4hmpQx5p2K1SwU8yRrMWsF/vzne4c=;
        b=JgiKUlxT7EgFZ4kXZ4HXlfC2rGnwG1MP4VT+M1sdYK7Xgos3uZyg1HAjfOMYods470
         0xOqkWV2n98S798UI3aRjOOqDTUJcv188KLo2Kwz4UwjZ/t7raPUUS02F38X/CelKoiC
         OABi8cjo9r80JGh1YoemdZAoeGUb6CDu2du6CpV9YPdCF91uJ7Vv5vWLCWVroD9kZtsY
         QWEuzybo8T+tdqLgvrxwY0ujR58C05jPXthw0Ukf6pFF0E55ry606DeOj+Nx9pqx19uY
         0v5JzbdFwtx4GBCoI3A9LOVTB043RlGBrbVaRy2itYGulAPH878t5sXvMLM4zOC5+TI7
         yFdw==
X-Gm-Message-State: APjAAAUmwnn4ZLAf5rp0gt0tkmKkbDvAf7Wg1mw3xSBQIvC59DZmYMZn
        tWQlqLh0DMbAi8qRTUaS9sp7Wg==
X-Google-Smtp-Source: APXvYqy9Whfn7uTg3BOXXtKo+Xb13mslF8Px0gcix7JC2yC4OfYP4K4dJzWw76A+9fC6aflAwbUnzg==
X-Received: by 2002:a17:902:421:: with SMTP id 30mr16087280ple.105.1567878146356;
        Sat, 07 Sep 2019 10:42:26 -0700 (PDT)
Received: from ?IPv6:2600:100f:b121:da37:bc66:d4de:83c7:e0cd? ([2600:100f:b121:da37:bc66:d4de:83c7:e0cd])
        by smtp.gmail.com with ESMTPSA id h11sm8785567pgv.5.2019.09.07.10.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 10:42:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com>
Date:   Sat, 7 Sep 2019 10:42:23 -0700
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
Message-Id: <C81D6D29-F6BF-48E6-A15E-3ABCB2C992E5@amacapital.net>
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-12-cyphar@cyphar.com> <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org> <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 7, 2019, at 9:58 AM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>=20
>> On Sat, Sep 7, 2019 at 5:40 AM Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> After thinking about this a bit, I wonder if we might be better served
>> with a new set of OA2_* flags instead of repurposing the O_* flags?
>=20
> I'd hate to have yet _another_ set of translation functions, and
> another chance of people just getting it wrong either in user space or
> the kernel.
>=20
> So no. Let's not make another set of flags that has no sane way to
> have type-safety to avoid more confusion.
>=20
> The new flags that _only_ work with openat2() might be named with a
> prefix/suffix to mark that, but I'm not sure it's a huge deal.
>=20
>           =20

I agree with the philosophy, but I think it doesn=E2=80=99t apply in this ca=
se.  Here are the flags:

O_RDONLY, O_WRONLY, O_RDWR: not even a proper bitmask. The kernel already ha=
s the FMODE_ bits to make this make sense. How about we make the openat2 per=
mission bits consistent with the internal representation and let the O_ perm=
ission bits remain as an awful translation.  The kernel already translates l=
ike this, and it already sucks.

O_CREAT, O_TMPFILE, O_NOCTTY, O_TRUNC: not modes on the fd at all.  These af=
fect the meaning of open().  Heck, for openat2, NOCTTY should be this defaul=
t.

O_EXCL: hopelessly overloaded.

O_APPEND, O_DIRECT, O_SYNC, O_DSYNC, O_LARGEFILE, O_NOATIME, O_PATH, O_NONBL=
OCK: genuine mode bits

O_CLOEXEC: special because it affects the fd, not the struct file.

Linus, you rejected resolveat() because you wanted a *nice* API that people w=
ould use and that might even be adopted by other OSes. Let=E2=80=99s please n=
ot make openat2() be a giant pile of crap in the name of consistency with op=
en().  open(), frankly, is horrible.

