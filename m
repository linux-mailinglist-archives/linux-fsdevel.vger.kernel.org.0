Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1781BF53A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 19:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfKHSk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 13:40:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41096 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbfKHSk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:40:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id m9so7240670ljh.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 10:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nK0Zw7DLkFj9Fi972X4waBUlozfHM/3V2eGjeSiAYSA=;
        b=NHeFmexs7Yz1xxa1LiwHuBGwXB+UPoBzyW8Ms19u2B7AJ+X1/cPn7PIRLnUcjY65zc
         I1BM+BlXfL0H3tx4/zcFNIsihVYs0aG27mlRkRGJ6/azjW5Y6ie2SRZYkeLY9kmCSSKE
         r/TQA/vggkYBJM0F9kfKGYF9kggQPVl/LeW+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nK0Zw7DLkFj9Fi972X4waBUlozfHM/3V2eGjeSiAYSA=;
        b=dN/3xs9tHSa5mDBlOoL32C9yQrNbCHQqGiTfKGqPKEEpGfCqtF6mjH1STs3QH+d3Py
         /Kj9W2vhN362e3M/R5kpPcOwxL+JJTUlYtSwMh1/yQikG4tP0fOhMEgq6wx5j4Pi5wGx
         oHCHBTv5qVh5ulBc1wgcUNC3wRfoQB2ZO84CKoSSOYIxy++NLQFSoBgNFzF5HyBsrB2T
         FZWzXLD6nW9faOC3qcwfHcgVb7FOA66UlnI4EENNq/r0iA+WF9rXdG0GNUUtNp9blAZG
         Ct9aLXvnRQuOa+XF+9cxH9i/6gcjXuey+pJG6pVIcnHdj+UJFlT6PZtAvP5HG60YbZ2s
         1aIw==
X-Gm-Message-State: APjAAAWaQxNMaoKgKzvwFLbuqvBc2gHfVkXYB4fsypON/Gzpn4yRhHEo
        4uOh8LFAOB2VOv6DvYnSzd4lYyIEYJI=
X-Google-Smtp-Source: APXvYqxgaCartOZDEbshq4YCj4wkqSwhF36rLjLLcEDJto/49XBINHfzh7P0BGY9TfoHByG8yPywUA==
X-Received: by 2002:a2e:9889:: with SMTP id b9mr7591178ljj.187.1573238449793;
        Fri, 08 Nov 2019 10:40:49 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id a18sm3323094lfi.15.2019.11.08.10.40.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 10:40:48 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id n5so7253113ljc.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 10:40:48 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr7922518ljp.133.1573238447956;
 Fri, 08 Nov 2019 10:40:47 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
 <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com> <CANpmjNOuRp0gdekQeodXm8O_yiXm7mA8WZsXZNmFfJYMs93x8w@mail.gmail.com>
In-Reply-To: <CANpmjNOuRp0gdekQeodXm8O_yiXm7mA8WZsXZNmFfJYMs93x8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 10:40:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjodfXqd9=iW=ziFrfY7xqopgO3Ko_HrAUp-kUQHHyyqg@mail.gmail.com>
Message-ID: <CAHk-=wjodfXqd9=iW=ziFrfY7xqopgO3Ko_HrAUp-kUQHHyyqg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Marco Elver <elver@google.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 8, 2019 at 10:16 AM Marco Elver <elver@google.com> wrote:
>
> KCSAN does not use volatile to distinguish accesses. Right now
> READ_ONCE, WRITE_ONCE, atomic bitops, atomic_t (+ some arch specific
> primitives) are treated as marked atomic operations.

Ok, so we'd have to do this in terms of ATOMIC_WRITE().

One alternative might be KCSAN enhancement, where you notice the
following pattern:

 - a field is initialized before the data structure gets exposed (I
presume KCSAN already must understand about this issue -
initializations are different and not atomic)

 - while the field is live, there are operations that write the same
(let's call it "idempotent") value to the field under certain
circumstances

 - at release time, after all the reference counts are gone, the field
is read for whether that situation happened. I'm assuming KCSAN
already understands about this case too?

So it would only be the "idempotent writes" thing that would be
something KCSAN would have to realize do not involve a race - because
it simply doesn't matter if two writes of the same value race against
each other.

But I guess we could also just do

   #define WRITE_IDEMPOTENT(x,y) WRITE_ONCE(x,y)

and use that in the kernel to annotate these things. And if we have
that kind of annotation, we could then possibly change it to

  #define WRITE_IDEMPOTENT(x,y) \
       if READ_ONCE(x)!=y WRITE_ONCE(x,y)

if we have numbers that that actually helps (that macro written to be
intentionally invalid C - it obviously needs statement protection and
protection against evaluating the arguments multiple times etc).

                Linus
