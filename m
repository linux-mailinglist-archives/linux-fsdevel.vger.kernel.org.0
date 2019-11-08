Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A44F52B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 18:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfKHRjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 12:39:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39049 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfKHRjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:39:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id p18so7084362ljc.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 09:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0HyUPs5wRItBK7m6Cq2qgQoPBnwk/wYZPQ6kr3orrA=;
        b=cNIrikGewcX3TfzGA7DTIDVQAsE0zbz7keQN8vCX7RCd/Hv905PLymolBEW+BYQraJ
         sWDYisbWpxTssmp2D2YezzJf3kW7bs+FdM4VtnlBu+i15ynPCQAQkhBEXHKASRmGjNQF
         u2eTspzbiv17j9VBNXqDv9laIVCLfAQXMtCS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0HyUPs5wRItBK7m6Cq2qgQoPBnwk/wYZPQ6kr3orrA=;
        b=pQzuOZWnVPazD97lkcIyuiDcTFxxCHO2j8IF6dULVIMjeZFs3vwSTW0PY96Kb1OFaD
         9+ZfznG1pxxTkra0aC5fkKwUz7veEouFbCo8sF8itwi1XZ0SFGd3XijYkN1k9rfn8im6
         f8Ud+C21TkWq19Q4mTeHQ8ZXg+D+DpYRVjIGN4+Ts3WYYjtBeztBVAzcTdKKWIEpDsn7
         QxEW6Rwof56tGh3J+zOr/OcYzqAdPjv/zcA4xXgBGxR0Hsy7kv+ktfFqWjHRUQOlhIUI
         Dc4o5VqwEC9CR7pKue0WFd6T+x7UAfVADHEsR5T6qiZlUXNLpVJ77OCxST3eZ4VNjxKB
         bxOg==
X-Gm-Message-State: APjAAAWf1vcl2v6ppfB9p/WAhJbLsEm1r3tymgUkJrPc3lIDwLlw6rLv
        vj5E2ANeOUydG8KtjSbBljVtSfXEe3Q=
X-Google-Smtp-Source: APXvYqyNUt18Klzsccvmi5zrtITt8wwc++3BKv6dxsqLczeRPEzMrN/MdO+88++H6lZqjaDP1f0hXg==
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr7840749ljm.241.1573234752064;
        Fri, 08 Nov 2019 09:39:12 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m12sm2678496lfb.60.2019.11.08.09.39.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 09:39:10 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id z12so5058088lfj.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 09:39:10 -0800 (PST)
X-Received: by 2002:ac2:5587:: with SMTP id v7mr7485443lfg.79.1573234750371;
 Fri, 08 Nov 2019 09:39:10 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com> <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
In-Reply-To: <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 09:38:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
Message-ID: <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
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

On Fri, Nov 8, 2019 at 9:22 AM Eric Dumazet <edumazet@google.com> wrote:
>
> Ok, so what do you suggest next ?
>
> Declare KCSAN useless because too many false positives ?

I'd hope that there is some way to mark the cases we know about where
we just have a flag. I'm not sure what KCSAN uses right now - is it
just the "volatile" that makes KCSAN ignore it, or are there other
ways to do it?

"volatile" has huge problems with code generation for gcc. It would
probably be fine for "not_rcu" in this case, but I'd like to avoid it
in general otherwise, which is why I wonder if there are other
options.

But worst comes to worst, I'd be ok with a WRITE_ONCE() and a comment
about why (and the reason being KCSAN, not the questionable
optimization).

           Linus
