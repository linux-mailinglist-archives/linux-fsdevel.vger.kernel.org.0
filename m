Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0015712673F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 17:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLSQgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 11:36:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43546 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSQgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:36:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so6922029ljm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2019 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0EPaeAm1h5et+pcE0Lw2TnBFxWaf1zou6EIoTCmP30=;
        b=bZHWn0PsXhDbOK/Bql+EUdVYbHBqZFT+2Nbu2NKTbOPDpYJnxQ8/xUws763LXH9j3m
         XvTn3+qa6G5xDrHkogar6bc8r1mWIiQFLSpH4PfDJaTYQjML3UPjF8ReFuAn4IPFe3wt
         CsSw4N/hW8UkyP4cDs7xLRa2iwzcttIS4FCkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0EPaeAm1h5et+pcE0Lw2TnBFxWaf1zou6EIoTCmP30=;
        b=BbzQo+gNiOcPOdS9J7k64shVYezfzzagldSNT7O7VQ5wz3pGS066Otx5V4VO6wAtbQ
         BdI6CNJC2I56xkLXUfGPgoRiE657Yc8TjLSQeU3I0oUhW8KEhhaFJBrX/K1KKPbcn1zs
         Fql6HBthshMKWXQFq4xXZJLbCnIKPRyywcx2e9a5E5vc75LOxekadTcRUcdRHiuh+WIm
         gpI24RThMGCHxbWCTdy4bv+Xx5fb9zO2PRaw+ksRC1v71IxZNFC1NoDKIg+l5XvCS2w/
         9k4Uk+U8XxLgI9hZgLXZyEx7zZa0bA7Vpnr12xP9pfgWJ2Lr5RHDbI3iBb0uN6muDiMh
         Kyyw==
X-Gm-Message-State: APjAAAV5qG5wPXv4QGHOQ2qlUb0hduddbPrKhcQnBmcUlFyl0KZF8ZaD
        eBexs36XM9yCXuaN1RthHSVaLB5hGM0=
X-Google-Smtp-Source: APXvYqzJEKMuRmCG1/nU9hxeA8maHojY8bcbshN0I1hEB6YvhyZw79G53EL0AQz9ZKffYnRYzluzgw==
X-Received: by 2002:a2e:9cc:: with SMTP id 195mr5118804ljj.130.1576773365173;
        Thu, 19 Dec 2019 08:36:05 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id y23sm3190117ljk.6.2019.12.19.08.36.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 08:36:04 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id u1so6917219ljk.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2019 08:36:03 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr6832409ljj.26.1576773363095;
 Thu, 19 Dec 2019 08:36:03 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <b2ae78da-1c29-8ef7-d0bb-376c52af37c3@yandex-team.ru> <CAHk-=wgTisLQ9k-hsQeyrT5qBS0xuQPYsueFWNT3RxbkkVmbjw@mail.gmail.com>
 <20191219000013.GB13065@localhost> <20191219001446.GA49812@localhost>
 <CAHk-=wgMiTbRPp6Fx_A4YV+9xL7dc2j0Dj3NTFDPRfjsjLQTWw@mail.gmail.com> <935.1576742190@warthog.procyon.org.uk>
In-Reply-To: <935.1576742190@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Dec 2019 08:35:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQdy80352u4d39QD58yQKaNfeEz+k3eRwZw5faEYFsgw@mail.gmail.com>
Message-ID: <CAHk-=wiQdy80352u4d39QD58yQKaNfeEz+k3eRwZw5faEYFsgw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Akemi Yagi <toracat@elrepo.org>, DJ Delorie <dj@redhat.com>,
        David Sterba <dsterba@suse.cz>,
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

On Wed, Dec 18, 2019 at 11:56 PM David Howells <dhowells@redhat.com> wrote:
>
> I looked at splitting the waitqueue in to two, but it makes poll tricky.

No, it's actually trivial for poll.

The thing is, poll can happily just add two wait-queues to the
poll_table. In my conversion, I just did

-       poll_wait(filp, &pipe->wait, wait);
+       if (filp->f_mode & FMODE_READ)
+               poll_wait(filp, &pipe->rd_wait, wait);
+       if (filp->f_mode & FMODE_WRITE)
+               poll_wait(filp, &pipe->wr_wait, wait);

which changes the unconditional "add one" to two conditional adds.
They _could_ have been unconditional too, but why add unnecessary
wakeups? So it only really does it twice on named pipes (if opened for
reading and writing).

It's _unusual_ to add two wait-queues for a single poll, but it's not
wrong. The tty layer has always done it - exactly because it has
separate wait queues for reading and writing. Some other drivers do
too. Sometimes there's a separate wait queue for errors, sometimes
there are multiple wait-queues because there are events from the
"subsystem" and there are other events from the "device". I think
sound does the latter, for example.

And no, I don't particularly like the FMODE_READ/WRITE testing above -
it would be better to pass in the polling mask and ask "are we waiting
for polling for reading or writing?" instead of asking whether the
file descriptor was opened for read or write, but hey, it is what it
is.

Sadly, "poll()" doesn't really get passed the bitmask of what is being
waited on (it's there in the poll_tabvle "_key" field, but I don't
want to have the pipe code look into those kinds of details.

So the named pipe case could be improved, but it's not like anybody
really cares. Nobody uses named pipes any more (and few people ever
did). So I didn't worry about it.

            Linus
