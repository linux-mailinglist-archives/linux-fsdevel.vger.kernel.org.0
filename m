Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B266EF6B16
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 20:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfKJTVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 14:21:14 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:34487 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfKJTVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 14:21:14 -0500
Received: by mail-lf1-f50.google.com with SMTP id y186so2370994lfa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2019 11:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vps6XmCw9WRkAtYxpnFwWu+xV4X8ojukCSN0qo58N6c=;
        b=cIj419uq1cCoNo/Cqt9dnkfZ/zoLO/cAgHHpjyVkn/Tj0px/QPbQk8+nmQiG4RBzYX
         /DhDmmagDbgLBwtfJUZexOqqGEfiZJNMQDyi3dPKp2PfVpw/BsJT01SEfki1eU0+DTUe
         IuZxYN2U4SUb4pI+OIgnz5/kkESeGNQ+VYBVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vps6XmCw9WRkAtYxpnFwWu+xV4X8ojukCSN0qo58N6c=;
        b=LUJJCRPgbcJmvshETGJ+o7e0918gT4bCTLvWrapSM+/TG5UtlSdM8zdp9PoGz6kU6C
         2VUGMEre0KSBn9aNu1LIyp/JNhHcezvrQWroH1Y3OS+3LjyOrovWof4YzsNPtpCcNsPt
         xuoLvHLRMOjbS9L3iSUIcWlGRuNjCgrl5euXDKbiUVn+R6OGE/1qiz5aG8s9i2vGkhO7
         /f/NPHbI80fsL2TZ3p2ueMPFznJAw602wZlASHLndFYeqlmLltFiGA2MBT/PusqQs6mC
         PX6cf3t/z+urroCSFxDOmRChXD9hKpx9wXkuWb34+oQ1adOUJRSs1ZNuKO7/YeJq5CC0
         7g5Q==
X-Gm-Message-State: APjAAAXhXKbX2ANToSDObcfPcjrT8rVX9hS7XDuCSVmMCWNfyd9n6OMg
        sGjZawdXgEra7G4eIrqS4Mfw5GESkJg=
X-Google-Smtp-Source: APXvYqwLnlmaGGMqCdi+jvuXb4Xa8A4z45uak6vvGriTKSKbmLyUbkl4GS+L4LV/SPV6fviVFKaweQ==
X-Received: by 2002:a19:651b:: with SMTP id z27mr12796185lfb.117.1573413671461;
        Sun, 10 Nov 2019 11:21:11 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t28sm3319756ljd.47.2019.11.10.11.21.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 11:21:10 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id y186so2370959lfa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2019 11:21:09 -0800 (PST)
X-Received: by 2002:ac2:498a:: with SMTP id f10mr1217684lfl.170.1573413669634;
 Sun, 10 Nov 2019 11:21:09 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org> <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
In-Reply-To: <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Nov 2019 11:20:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com>
Message-ID: <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 10, 2019 at 11:12 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And this is where WRITE_IDEMPOTENT would make a possible difference.
> In particular, if we make the optimization to do the "read and only
> write if changed"

It might be useful for checking too. IOW, something like KCSAN could
actually check that if a field has an idempotent write to it, all
writes always have the same value.

Again, there's the issue with lifetime.

Part of that is "initialization is different". Those writes would not
be marked idempotent, of course, and they'd write another value.

There's also the issue of lifetime at the _end_ of the use, of course.
There _are_ interesting data races at the end of the lifetime, both
reads and writes.

In particular, if it's a sticky flag, in order for there to not be any
races, all the writes have to happen with a refcount held, and the
final read has to happen after the final refcount is dropped (and the
refcounts have to have atomicity and ordering, of course). I'm not
sure how easy something like that is model in KSAN. Maybe it already
does things like that for all the other refcount stuff we do.

But the lifetime can be problematic for other reasons too - in this
particular case we have a union for that sticky flag (which is used
under the refcount), and then when the final refcount is released we
read that value (thus no data race) but because of the union we will
now start using that field with *different* data. It becomes that RCU
list head instead.

That kind of "it used to be a sticky flag, but now the lifetime of the
flag is over, and it's something entirely different" might be a
nightmare for something like KCSAN. It sounds complicated to check
for, but I have no idea what KCSAN really considers complicated or
not.

                  Linus
