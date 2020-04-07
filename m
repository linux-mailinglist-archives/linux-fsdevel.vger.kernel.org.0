Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F881A10F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgDGQG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 12:06:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34359 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgDGQG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:06:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id o1so4757002edv.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZSC8MNyMYJ4CcbIl5da3tSwMWoq31/28XKL6OZqNaaY=;
        b=lYJjsqchyogIG2xHJXiYDwsutn6iKu82kteMMh/iUcPx8osqcaPhaQMR0VRfmVhNWK
         NCagF590A9IHqge+RLez3WuO7uxY62A3hcYNfVsfdv+RVIwhEq7wV1V2/QfjuAh/HHNJ
         Ndiq/cU1KP/QZ40BrUjm6Tbot2afFBCYP9DNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZSC8MNyMYJ4CcbIl5da3tSwMWoq31/28XKL6OZqNaaY=;
        b=aEU2z6W/W0xcRxxmOgdExuYIfGGitpw9oUG5SbZvIkLvrSrn9MEl0XTIH/e+KbQ9TX
         aJXOjknXtV3BftjqL9CzvG68XaLlj8A0gN6Kbze2WQdBcBe/dT6l+k7wyavSoC2WXIoE
         93M47ljMd3GRcsf+QwbYrRK7fe1sBUiUin8KZD5+A8hqEYVgPqn4nvQ0Q1pqqctGocjX
         UH4Fzz72GyNeogNhKBVxr6hBzq0gi0CAmNQPa8EWiCCbJzUkqQkNFBYrcqnpYOMQXqCA
         R2BQ+AFxUqac/Xh9MXXSr7lYL4UizPbKwskJvdMOat/29aokY3qjCGqc0kakRDiPzZh6
         w5AA==
X-Gm-Message-State: AGi0Pua/Sij52hx5HbUYBtrpoeH6RbRTT/9Oj+VupICJzxJsdNN/JD6m
        Nf5a55+TUbKn0PEBj6krwzMG75bCmvLk1aoqtIOnpQ==
X-Google-Smtp-Source: APiQypIXfOQtepXXTh7ycOqzqzJa8O502xxo9QjDYoNHsfjRyMveiS82f7idPBRjOLqUA9QCRFw1nO3c8tM2xgW4Ai4=
X-Received: by 2002:a17:906:405b:: with SMTP id y27mr2784058ejj.213.1586275585452;
 Tue, 07 Apr 2020 09:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login> <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login> <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
 <20200403150143.GA34800@gardel-login> <CAJfpegudLD8F-25k-k=9G96JKB+5Y=xFT=ZMwiBkNTwkjMDumA@mail.gmail.com>
 <20200406172917.GA37692@gardel-login> <a4b5828d73ff097794f63f5f9d0fd1532067941c.camel@themaw.net>
 <CAJfpegvYGB01i9eqCH-95Ynqy0P=CuxPCSAbSpBPa-TV8iXN0Q@mail.gmail.com> <20200407155329.GA39803@gardel-login>
In-Reply-To: <20200407155329.GA39803@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Apr 2020 18:06:13 +0200
Message-ID: <CAJfpegufdi7u3Wyo0YWeoPs9MQa1TePD=AHNW9S9Ey9jTuofHw@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 7, 2020 at 5:53 PM Lennart Poettering <mzxreary@0pointer.de> wr=
ote:
>
> On Di, 07.04.20 15:59, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > On Tue, Apr 7, 2020 at 4:22 AM Ian Kent <raven@themaw.net> wrote:
> > > > Right now, when you have n mounts, and any mount changes, or one is
> > > > added or removed then we have to parse the whole mount table again,
> > > > asynchronously, processing all n entries again, every frickin
> > > > time. This means the work to process n mounts popping up at boot is
> > > > O(n=C2=B2). That sucks, it should be obvious to anyone. Now if we g=
et that
> > > > fixed, by some mount API that can send us minimal notifications abo=
ut
> > > > what happened and where, then this becomes O(n), which is totally O=
K.
> >
> > Something's not right with the above statement.  Hint: if there are
> > lots of events in quick succession, you can batch them quite easily to
> > prevent overloading the system.
> >
> > Wrote a pair of utilities to check out the capabilities of the current
> > API.   The first one just creates N mounts, optionally sleeping
> > between each.  The second one watches /proc/self/mountinfo and
> > generates individual (add/del/change) events based on POLLPRI and
> > comparing contents with previous instance.
> >
> > First use case: create 10,000 mounts, then start the watcher and
> > create 1000 mounts with a 50ms sleep between them.  Total time (user +
> > system) consumed by the watcher: 25s.  This is indeed pretty dismal,
> > and a per-mount query will help tremendously.  But it's still "just"
> > 25ms per mount, so if the mounts are far apart (which is what this
> > test is about), this won't thrash the system.  Note, how this is self
> > regulating: if the load is high, it will automatically batch more
> > requests, preventing overload.  It is also prone to lose pairs of add
> > + remove in these case (and so is the ring buffer based one from
> > David).
>
> We will batch requests too in systemd, of course, necessarily, given
> that the /p/s/mi inotify stuff is async. Thing though is that this
> means we buy lower CPU usage =E2=80=94 working around the O(n=C2=B2) issu=
e =E2=80=94 by
> introducing artifical higher latencies. We usually want to boot
> quickly, and not artificially slow.
>
> Sure one can come up with some super smart scheme how to tweak the
> artifical latencies, how to grow them, how to shrink them, depending
> on a perceived flood of events, some backing off scheme. But that's
> just polishing a turd, if all we want is proper queued change
> notification without the O(n=C2=B2) behaviour.
>
> I mean, the fix for an O(n=C2=B2) algorithm is to make it O(n) or so. By
> coalescing wake-up events you just lower the n again, probably
> linearly, but that still means we pay O(n=C2=B2), which sucks.

Obviously.  But you keep ignoring event queue overflows; it's
basically guaranteed to happen with a sizable mount storm and then you
are back to O(n^2).

Give it some testing please, as Linus is not going to take any
solution without an actual use case and testing.  When you come back
and say that fsinfo(2) works fine with systemd and a 100k mount/umount
storm, then we can have a look at the performance budget and revisit
the fine points of API design.

Thanks,
Miklos
