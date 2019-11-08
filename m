Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08490F5334
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 19:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfKHSF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 13:05:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46645 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbfKHSF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:05:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so7119641ljp.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 10:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9NweSEf4drXt4A6DP1qgzu1cS6gHr1cMfGzVR+7ZWY=;
        b=BFXx5UUjilC2VGGIFH0qbcrUE/AJuyx2/d46qw2iAAOeTsVx8j2aw2hoCox9tJS3wD
         paX9fnyjuYtJC19oeyWD/gCxwI2Uq0qQyNq71XhkZ11olv7oacH0v1uAPcX/b+eFj2DD
         4IPRZi+crMZ7QCrYaUhsZncB/RosCknDpvqSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9NweSEf4drXt4A6DP1qgzu1cS6gHr1cMfGzVR+7ZWY=;
        b=Nq5YVW3wyRbYN5CCUVxcWvAFL7HCv7i8amnokJ7AOEx99dC9oHn9AyBBE6LuibTCw8
         tkgqEAiFNTV8tN44cyCl9fxb962mIaEBJilyct4QTG202MHBqN42OhqVGDaDRfJdM0jU
         gtX5XVH/arElDsORYxlhzi1171WBtHBZH8otw2oTVM3Yfnr4U13YEavjdSdhNkv0T978
         eDNOT2MJlbgpWp5JEbizlgbXuTcTYdnmvd98PbhzV0pJtVZ1oz6UQ6eFMeoDEW3rduPz
         as5Edy+lb2Bhv0BzkSpknXui6wj96gCeoA+RMa2/j3+q+gMNobzn71DJW9y65o7Qg/pd
         1XHQ==
X-Gm-Message-State: APjAAAUbavplbAi5KEjnOZRAZMgO9mXmQqY8uR86kMMK4KITOAh6rfOg
        uPYZPKhGzq7RXkWECHMDlM0AWVsCmxY=
X-Google-Smtp-Source: APXvYqxDvkBWmP5qyN0CnS43U1EWAIJaIDIybLoZeWFwW4SbgMvA1jjRlhxLf4q/ltDOsTihCH5/Rg==
X-Received: by 2002:a2e:7c10:: with SMTP id x16mr7885440ljc.120.1573236326259;
        Fri, 08 Nov 2019 10:05:26 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id d19sm3069115lfc.12.2019.11.08.10.05.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 10:05:25 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id t5so7188955ljk.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 10:05:25 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr7860520lji.1.1573236324900;
 Fri, 08 Nov 2019 10:05:24 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com> <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
In-Reply-To: <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 10:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com>
Message-ID: <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:53 AM Eric Dumazet <edumazet@google.com> wrote:
>
> I personally like WRITE_ONCE() since it adds zero overhead on generated code,
> and is the facto accessor we used for many years (before KCSAN was conceived)

So I generally prefer WRITE_ONCE() over adding "volatile" to random
data structure members.

Because volatile *does* have potentially absolutely horrendous
overhead on generated code. It just happens to be ok for the simple
case of writing once to a variable.

In fact, you bring that up yourself in your next email when you ask
for "ADD_ONCE()". Exactly because gcc generates absolutely horrendous
garbage for volatiles, for no actual good reason. Gcc *could* generate
a single add-to-memory instruction. But no, that's not at all what gcc
does.

So for the kernel, we've generally had the rule to avoid 'volatile'
data structures as much as humanly possible, because it actually does
something much worse than it could do, and the source code _looks_
simple when the volatile is hidden in the data structures.

Which is why we have READ_ONCE/WRITE_ONCE - it puts the volatile in
the code, and makes it clear not only what is going on, but also the
impact it has on code generation.

But at the same time, I don't love WRITE_ONCE() when it's not actually
about writing once. It might be better to have another way to show
"this variable is a flag that we set to a single value". Even if maybe
the implementation is then the same (ie we use a 'volatile' assignment
to make KCSAN happy).

> Hmm, which questionable optimization are you referring to?

The "avoid dirty cacheline" one by adding a read and a conditional.
Yes, it can be an optimization. And it might not be.

                Linus
