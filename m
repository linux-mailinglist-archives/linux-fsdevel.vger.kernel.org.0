Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C7D125737
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 23:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLRWvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 17:51:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39456 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfLRWvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:51:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id t17so3021462eds.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 14:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0opJ0B65Q5BiWbXOfLeRpbLzFdNkXbzXfsShY/S8STo=;
        b=DUkxLRvmbaiH3+fF8+61ttVLfREI0A+NWtWnJOtLUOSriU6hVGAfH7iqm4AZPXQqzt
         7aO270kl1hKuJ5aO8Gokb2xsJxP0eGToFjcV4DL7BdieT8cYuox6b9GzA72q3+lVU+Px
         napMS5WIEyhf5c/+6313JTnavgdEB2AaJj+cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0opJ0B65Q5BiWbXOfLeRpbLzFdNkXbzXfsShY/S8STo=;
        b=qV4B6HaJH15nd2/sKEhFHE+tvjOa5G2SRplXGg6yaZOqCRgzp8ZkCNvXfZK0VYP0Cv
         9ysYr6FfmhY1bU23FM85w3OEr0ZW7/w81OY0w7ZXmsMWIJGXVrIjRuuKuXUtkrAt4Byg
         5VD0Ce6edljGOXUaQrD46nbyLr55jZnGxVD6sDbLWy3Y+Vxf7M4XrJM6HlxyHTsfNqUY
         zyD+J2vCzyHuGQljMXaDz+dsBaSo2vmVOrLjHjzvq77VsBaHMiNQthHaGwz8DHyPyKvq
         wfiPGRqA9soQfpRNLYosIW12ilT8zRX3iZiQ7KVVbJ1jH1/5aPE/DNOkSIviDROVRioO
         /oTg==
X-Gm-Message-State: APjAAAWM2/r7Lyk3om5iP6yTzBwJa2mYHK7ScMGBfwSjUKpbQ+pA75+F
        fjrRbSp3Mjw/94er/3j3l477hMOpk+w=
X-Google-Smtp-Source: APXvYqztttOnWugfcP8iN9X3dTEF356BBDelO96iUlfdZL7i8p7zwAzv0D3OqqgmlgGIRfzJqRlaEQ==
X-Received: by 2002:a17:906:838c:: with SMTP id p12mr5773046ejx.204.1576709506357;
        Wed, 18 Dec 2019 14:51:46 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c2sm129055ejk.74.2019.12.18.14.51.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 14:51:45 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id r14so2894772lfm.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 14:51:44 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr3406731lfo.134.1576709503936;
 Wed, 18 Dec 2019 14:51:43 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com> <b2ae78da-1c29-8ef7-d0bb-376c52af37c3@yandex-team.ru>
In-Reply-To: <b2ae78da-1c29-8ef7-d0bb-376c52af37c3@yandex-team.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Dec 2019 14:51:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTisLQ9k-hsQeyrT5qBS0xuQPYsueFWNT3RxbkkVmbjw@mail.gmail.com>
Message-ID: <CAHk-=wgTisLQ9k-hsQeyrT5qBS0xuQPYsueFWNT3RxbkkVmbjw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Josh Triplett <josh@joshtriplett.org>,
        Akemi Yagi <toracat@elrepo.org>, DJ Delorie <dj@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>,
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

On Thu, Dec 12, 2019 at 2:18 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> commit f467a6a66419 pipe: fix and clarify pipe read wakeup logic
> killed "wake writer when buffer becomes half empty" part added by
> commit cefa80ced57a ("pipe: Increase the writer-wakeup threshold to reduce context-switch count").
>
> I suppose that was unintentional. Jobserver juggles with few bytes and
> should never reach half/full buffer thresholds.

It wasn'tunintentional - the rest of the cleanups should mean that we
never wake things up unnecessarily - we now only wake up if it _used_
to be 100% full, and we only do it once per read.

And it did it without the watermark, which I was worried about might
break something that "knew" the size of the pipe.

But performance testing would be good. Both for the "no unnecessary
wakeups" case, but also for the thundering herd issue.

To answer Josh's email in this same thread:

On Wed, Dec 18, 2019 at 12:59 PM Josh Triplett <josh@joshtriplett.org> wrote:
>
> Debian and Ubuntu have make 4.2.1-1.2, which includes "[SV 51159] Use a
> non-blocking read with pselect to avoid hangs." and various other fixes.
> https://metadata.ftp-master.debian.org/changelogs/main/m/make-dfsg/make-dfsg_4.2.1-1.2_changelog
> So, both Debian and Ubuntu should be fine with the pipe improvements.
> (I'm testing that now.)
>
> Is the version of your non-thundering-herd pipe wakeup patch attached to
> https://lore.kernel.org/lkml/CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com/
> still the best version to test performance with?

That's my latest version, but you'll have to tweak it a tiny bit
because of d1c6a2aa02af ("pipe: simplify signal handling in
pipe_read() and add comments") which I did after that patch.

The easiest way to resolve it is likely to revert that d1c6a2aa02af,
then apply the non-thundering-herd patch and then apply d1c6a2aa02af
again by hand - it's fairly straightforward (and you can return
-ERESTARTSYS directly if wait_event_interruptible_exclusive() fails,
because of all the same reasons why it coul dhappen without the
thundering-herd patch.

I can look at re-creating that patch if  you find it to be too annoying.

               Linus
