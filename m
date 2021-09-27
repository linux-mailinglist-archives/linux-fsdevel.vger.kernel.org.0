Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1EE41A14E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 23:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhI0VYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 17:24:33 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43520
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237028AbhI0VYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:24:33 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0AD7341975
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 21:22:54 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id b78so19329754iof.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 14:22:53 -0700 (PDT)
X-Gm-Message-State: AOAM531O0WkI88jqRwjzWjchxdQDmAQEazM7GDPkYhJN3wsCPzxCmE6A
        /aldPfnNM8oJrE51Hjb0u/bChuQKuHhlwfalyWzbUA==
X-Google-Smtp-Source: ABdhPJzC69WYcmKBfot6ZxiY9ys4a/1tFjAIU/TBMsBB4KO2mtdypTRm5irX0ZmVzbgq2bwLBRxgG2KtUqZxvyfM/bM=
X-Received: by 2002:a05:6638:3289:: with SMTP id f9mr1654129jav.115.1632777770621;
 Mon, 27 Sep 2021 14:22:50 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Brauner <christian.brauner@ubuntu.com>
Date:   Mon, 27 Sep 2021 23:21:00 +0200
X-Gmail-Original-Message-ID: <CAHrFyr4AYi_gad7LQ-cJ9Peg=Gt73Sded8k_ZHeRZz=faGzpQA@mail.gmail.com>
Message-ID: <CAHrFyr4AYi_gad7LQ-cJ9Peg=Gt73Sded8k_ZHeRZz=faGzpQA@mail.gmail.com>
Subject: Re: [lpc-contact] Linux Plumbers Conference Last Day
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        contact@linuxplumbersconf.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 11:29:12AM -0500, Eric W. Biederman wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
>
> > Dear Eric,
> >
> > Thank you again for coming to Linux Plumbers Conference, we're hoping
> > to make it one of the best technical conferences of the year, with
> > your help.  The conference should start up in about 15 minutes at
> > 07:00PDT/14:00UTC.  However, some Microconferences do start early, so
> > check out the timetable:
> >
> > https://linuxplumbersconf.org/event/11/timetable/#20210924
> >
> > And on that note: we'll be running an hour longer today (finishing at
> > 19:00 UTC) to accommodate the closing keynote which will include a
> > beer BoF, the traditional show your pets Gala and a discussion of the
> > results of the 30 years of linux survey.  A reminder to those
> > procrastinators among you: please fill out the looking forwards to the
> > next thirty years survey here:
>
> I regret to write to tell you that I will not be attending the closing
> bof.
>
> I need to get into the same room and talk things out with Christian
> Brauner.  Currently he has been refusing fixing security bugs in
> idmapped mounts for several releases, and I just haven't had the
> time/energy to deal with it.  Thankfully not much is using idmapped
> mounts yet, and the issues don't affect the code unless you are have
> enabled idmapped mounts.
>
> Last year was a disaster in failed communications and agreements on what
> we should do.  This year the microconference was very much toned down,
> and we did not manage to resolve anything.
>
> So my apologies but unfortunately for me the not-in-person setting
> really has really made LPC not worth attending this year.
>

I'm expanding the Cc on this since this has crossed a clear line now.

You have claimed on two occasions on the PR itself (cf. [1]) and in a
completely unrelated thread on fsdevel (cf. [2]) that there exist bugs in the
current implementation.
On both occasions (cf. [3], [4]) we have responded and asked you to please
disclose those bugs and provide reproducers. You have not responded on both
occasions.

I ask you to stop spreading demonstrably false information such as that we are
refusing to fix bugs. The links clearly disprove your claims.
We are more than happy to fix any bugs that exist. But we can't if we don't
know what they are.

If it is true that there are bugs that you have known about for over a year
that you haven't disclosed then this is extremely irresponsible.

This outlandish approach towards technical conflict resolution that you have
chosen for the last year has turned any potential future bug in the
implementation of a complicated patchset into a hugely political thing.
I refuse to let that happen. If there are bugs we fix them just like we always
do. We don't use bugs as political pawns to score points or attack our peers.
We come together as a community to fix them and then we move on.

Last week during LPC you were in the same room with me and others for 4 hours
straight on Monday. You were also present in the talk I gave on this in the
filesystem MC with opportunity for discussion after the talk.
Your contribution to this discussion was a single line in the chat:
"Please fix the implementation bugs before you relax the permissions."

You could have handed in a session to any of those two MCs, you could've asked
for a hackroom meeting, you could've approached us in the chat. None of that
happened. What happened was yet another very unpleasant passive-aggressive
attack.

I've been asking a lot of people for advice on how to deal with this since this
isn't the first time you resort to this strategy. The new mount API is another
example where you kept claiming serious bugs exist but never provided proof.

I was fine with ascribing a good chunk of this behavior to a lack in some basic
developer and maintainer etiquette but this mail has crossed a line for me.
Other developers literally come up to me and ask me what's going on there. To
which I have no real answer.
But this recent mail has a crossed a line for me because you're now even coming
after me by going through third parties spreading demonstrably false
information at a public event that I'm helping organize. This needs to stop!

Frankly, all of this has eroded any trust I have in you as a maintainer. None
of this has bee good faith for a while now.
Please, provide the details and reproducers on the bugs so we can discuss them
or send patches with tests. I will happily pick them up and send them to Linus.

Christian

[1]: https://lore.kernel.org/lkml/20210213130042.828076-1-christian.brauner@ubuntu.com/T/#m3a9df31aa183e8797c70bc193040adfd601399ad
[2]: https://lore.kernel.org/lkml/m1r1ifzf8x.fsf@fess.ebiederm.org
[3]: https://lore.kernel.org/lkml/20210213130042.828076-1-christian.brauner@ubuntu.com/T/#m59cdad9630d5a279aeecd0c1f117115144bc15eb
[4]: https://lore.kernel.org/lkml/20210510125147.tkgeurcindldiwxg@wittgenstein
