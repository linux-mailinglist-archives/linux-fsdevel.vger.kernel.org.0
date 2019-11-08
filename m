Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D282F5884
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 21:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKHUa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 15:30:56 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:42348 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHUa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:30:56 -0500
Received: by mail-lf1-f45.google.com with SMTP id z12so5408041lfj.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 12:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4G9LhNu511cUTzzUCbonTskDej2Ys9dbnlHdssKk4WQ=;
        b=HHey9ElQaNeZFkqKeSFK/EfPMq6vbK2Lm2dr3sIzCNHajSxBJDn4nfeJC674ARMqAO
         R5Ops4OPDogoeOgHpHESom8BR5x8/Q+cM6RqG6iYH0DFbaImijW3x06QX7os2TCHiDT2
         MGulyXH2fLc6SW6VRGS2Cy1Xz3yb2hE39NIfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4G9LhNu511cUTzzUCbonTskDej2Ys9dbnlHdssKk4WQ=;
        b=mq0Lg9AHNfVlEEr/kpUDUTWvotYFSH7nRGn84Pq6jnCxPu4Vpv+CH8wnSUSFdxIA7y
         S8c9V8ECTGEcKQiY8B9aPbfaGVxd32Fy+BxAuSdYmfjz4AETQ4E9vLeebcb/vqglN7fw
         brgTzDNYE3zZDjAoS+uuz6q2Pevzru58dvsVuv/hyYdxvfCiUmR9hObrM6vVJUi3WyBZ
         UNiHApFIzHCjKStvOajL4aFLlehyjmg4BPrf6URAoYRnZZE1/dxEW4D1ZtIWdEryMtuu
         UoGWrqdoE5IkfQxllCBiDK7i2DOz+OG9PE2tr9cqFmyiXgbdXxRMaB8YIO5idcLyxb9H
         7KFw==
X-Gm-Message-State: APjAAAVKcfx2zhBiz64VK2/AevLPRPJpGhDREJglhlsWW0M3a72Bpn/t
        weeLFwAVD5t58Vd5Rkgat6AP9ztEeHE=
X-Google-Smtp-Source: APXvYqxwjzrX7Szep6Nxe1SLqEInnwQkNqU9d6aJn5vFerrzDHwfiJvAkeyz5DJIKKE2ZWoZ041ZMw==
X-Received: by 2002:ac2:46c9:: with SMTP id p9mr7240581lfo.166.1573245052913;
        Fri, 08 Nov 2019 12:30:52 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id j8sm2870475lja.32.2019.11.08.12.30.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:30:51 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id m9so7526663ljh.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 12:30:51 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr8195764ljp.133.1573245051344;
 Fri, 08 Nov 2019 12:30:51 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com> <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com>
In-Reply-To: <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 12:30:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-aTQx5-gD51QC6UWJYxQv1p1CnrPpfbn4X1S4AC7G-g@mail.gmail.com>
Message-ID: <CAHk-=wi-aTQx5-gD51QC6UWJYxQv1p1CnrPpfbn4X1S4AC7G-g@mail.gmail.com>
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

On Fri, Nov 8, 2019 at 9:56 AM Eric Dumazet <edumazet@google.com> wrote:
>
> BTW, I would love an efficient ADD_ONCE(variable, value)
>
> Using WRITE_ONCE(variable, variable + value) is not good, since it can
> not use the optimized instructions operating directly on memory.

So I'm having a hard time seeing how this could possibly ever be valid.

Is this a "writer is locked, readers are unlocked" case or something?

Because we don't really have any sane way to do that any more
efficiently, unless we'd have to add new architecture-specific
functions for it (like we do have fo the percpu ops).

Anyway, if you have a really hot case you care about, maybe you could
convince the gcc people to just add it as a peephole optimization?
Right now, gcc ends up doing some strange things with volatiles, and
basically disables a lot of stuff over them. But with a test-case,
maybe you can convince somebody that certain optimizations are still
fine. A "read+add+write" really does the exact same accesses as an
add-to-memory instruction, but gcc has some logic to disable that
instruction fusion.

          Linus
