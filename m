Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF00A1258DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 01:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfLSAvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 19:51:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44030 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSAvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:51:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so3039301lfq.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 16:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XwJOrPvdC/OUnIx0D6OjuNWpdSOqNbwus7db7UF6FVU=;
        b=Nl5szeDVZvUT71nMP156KqkEP8YHndvFSlJCEiPDHzbV5vK5/s3HiS6NiImDS5R5cN
         Iy+cr0WDd6qL9kXmukbM0acwscQlGDkRF0HR0pWYJBQ0rljJpxJvxat9H5+HxFR0Ib9C
         jge2AHNXRjmluquEn00EdhqyX1BwD/AfPX6vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XwJOrPvdC/OUnIx0D6OjuNWpdSOqNbwus7db7UF6FVU=;
        b=UJ2qBgUr2Pzp1Yfudscm9PNODSquoFa13rr8VEVBGhqCWxx+j7JMomTcpy2RPGMJMT
         a1vs0lXyxk3h7nvdXxZ5hBXvLmxtdO1Csii9EYdsHx14R38NAbRJV/KO0OWUiNNScdOd
         hI2x5ahj0eMjt/Z3B+Yq3i3cZVneJaQSV9gN7tscaQ2jXjFRCm6RytvYTlf2KonEXAvj
         aMatD5EJ5J5s6fp79NttnIIAoPwQ/PLlBgTqpzi4uzdWsg1riz8PhAkjxb4SkuCHHIQZ
         +boP48uwtE2dhpy4ZliAmsf5Ztal79yLRcdnCETYQ8yfk1Qb1hpkr/NhuHXmijRXsLi5
         Liig==
X-Gm-Message-State: APjAAAVNKNqiPQ2YiaV8GPFqTCEaTraSSOLis18BQWjzAq7nbGM2lwO3
        Gm5N1XKQ1WYz2J4l8E4pTUNKpBKe0Y4=
X-Google-Smtp-Source: APXvYqyLxYtqO/o5GQLlRnSyHLVc8XJpcY2cT/bk09FuiUAPO2LYviuX7F3taMS7foHG2f0yKa0m9w==
X-Received: by 2002:a19:6a04:: with SMTP id u4mr3708972lfu.62.1576716705107;
        Wed, 18 Dec 2019 16:51:45 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id e21sm2346439lfc.63.2019.12.18.16.51.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 16:51:44 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id h23so4217384ljc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 16:51:43 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr3975797ljg.82.1576716703501;
 Wed, 18 Dec 2019 16:51:43 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <b2ae78da-1c29-8ef7-d0bb-376c52af37c3@yandex-team.ru> <CAHk-=wgTisLQ9k-hsQeyrT5qBS0xuQPYsueFWNT3RxbkkVmbjw@mail.gmail.com>
 <20191219000013.GB13065@localhost> <20191219001446.GA49812@localhost>
In-Reply-To: <20191219001446.GA49812@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Dec 2019 16:51:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMiTbRPp6Fx_A4YV+9xL7dc2j0Dj3NTFDPRfjsjLQTWw@mail.gmail.com>
Message-ID: <CAHk-=wgMiTbRPp6Fx_A4YV+9xL7dc2j0Dj3NTFDPRfjsjLQTWw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Akemi Yagi <toracat@elrepo.org>, DJ Delorie <dj@redhat.com>,
        David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 4:14 PM Josh Triplett <josh@joshtriplett.org> wrote:
>
> Er, wrong file. That's the original patch; the attached patch is the
> right one.

This looks correct to me.

If I were to actually commit it, the "split into two waitqueues" would
be a separate patch from the "use wait_event_interruptible_exclusive()
and add "wake_next_reader/writer logic", but for testing purposes the
unified patch was simpler, and your forward port looks good to me.

I ran the original patch for a couple of days, and didn't see any
other issues than the 'make' thing in F30. It was all good with my
self-build make.

But that "ran for a couple of days" wasn't all that stress-full. I did
do the "verify that the thundering herd is gone" test - including that
silly test-case here again:

    #include <unistd.h>

    int main(int argc, char **argv)
    {
        int fd[2], counters[2];

        pipe(fd);
        counters[0] = 0;
        counters[1] = -1;
        write(fd[1], counters, sizeof(counters));

        /* 64 processes */
        fork(); fork(); fork(); fork(); fork(); fork();

        do {
                int i;
                read(fd[0], &i, sizeof(i));
                if (i < 0)
                        continue;
                counters[0] = i+1;
                write(fd[1], counters, (1+(i & 1)) *sizeof(int));
        } while (counters[0] < 1000000);
        return 0;
    }

where you can tweak the numbers - add another fork() or two to create
even more pipe waiters, and maybe change the final count exit value to
match whatever hw performance you have.

         Linus
