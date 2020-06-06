Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AD61F08F9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgFFWdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 18:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgFFWdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 18:33:35 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7675C03E96A
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2020 15:33:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so7955735lfi.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2020 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3v5Kt8eWKoj8/dfeikK8krF25svghEw3lMoiT9ZcXk0=;
        b=eu2j1Y6krpt/zk9nzog/RgFPJNYImb6WDJAJ4Q3BH2EbU7xXBVn59g7FwqPU7fkIYd
         nIA7YYAmqf6rZR72RWPdr1NiipocRqwcLnHtA/zm37ImiNm+JzA4cfKk1HKQ1WYq9g67
         mbfsgYhy8HsrX6T9EiQ6x5XUQF2CJ7Kna5Yl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3v5Kt8eWKoj8/dfeikK8krF25svghEw3lMoiT9ZcXk0=;
        b=uX4p2gY1tGr4Q/51B54cAXbra2MGA/onbXbXXOGZbBouiH3o6iMKAaM0FEpkUantP3
         Z+Yl5ajjMBVoJo2R14atZxi9c+MvPlZMXNaKxQBgEpYl1YGvc2jUDkYEV/ss48eXfu0+
         ku0hD3ran98G6N/QGiO9CNl1ayOfbNBT0AlKfH0aoTaGOjQmJ3vUJifLd0PJKMpve8qY
         VgqDqH9z2CDOKAotIVuqZecht85I7g3WEK9FY+S/QU5ry0ROPsM7TR9Z/y7aUItE7QHI
         +tCP8wO2iWXrBf/IHTVTMcxi2RkK+OVwmH2eymSYdCjC9/dgzdvidh+d89MGdh/Q+hup
         4gXA==
X-Gm-Message-State: AOAM531caJry7WTh46DiPjmWmGNQM2w1MPnPI9dNLFLbICQUzxk4OweD
        prQCd57dMq6/jG8642bOUlNQAH3ikGY=
X-Google-Smtp-Source: ABdhPJzoOwOMhx+2pA3waAzEL1pQiO+36JpNDPYWNW8IWTtExz5IRk5kuvtO1jIm5+Of5sxdWF69zA==
X-Received: by 2002:a19:c7d6:: with SMTP id x205mr8810011lff.113.1591482812433;
        Sat, 06 Jun 2020 15:33:32 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 22sm2261177lju.5.2020.06.06.15.33.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 15:33:31 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 202so7973604lfe.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2020 15:33:30 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr8657693lfo.152.1591482810474;
 Sat, 06 Jun 2020 15:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook> <875zc4c86z.fsf_-_@x220.int.ebiederm.org> <20200606201956.rvfanoqkevjcptfl@ast-mbp>
In-Reply-To: <20200606201956.rvfanoqkevjcptfl@ast-mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Jun 2020 15:33:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
Message-ID: <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 6, 2020 at 1:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Please mention specific bugs and let's fix them.

Well, Eric did mention one explicit bug, and several "looks dodgy" bugs.

And the fact is, this isn't used.

It's clever, and I like the concept, but it was probably a mistake to
do this as a user-mode-helper thing.

If people really convert netfilter rules to bpf, they'll likely do so
in user space. This bpfilter thing hasn't gone anywhere, and it _has_
caused problems.

So Alexei, I think the burden of proof is not on Eric, but on you.

Eric's claim is that

 (a) it has bugs (and yes, he pointed to at lelast one)

 (b) it's not doing anything useful

 (b) it's a maintenance issue for execve, which is what Eric maintains.

So you can't just dismiss this, ignore the reported bug, and say
"we'll fix them".

That only answers (a) (well, it _would_ have answered (a)., except you
actually didn't even read Eric's report of existing bugs).

What is your answer to (b)-(c)?

             Linus
