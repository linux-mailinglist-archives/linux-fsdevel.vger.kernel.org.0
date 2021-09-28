Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4F541B5BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 20:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbhI1SOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 14:14:54 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:39506
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241531AbhI1SOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:14:53 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 495B540D72
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 18:13:13 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id e144so3189420iof.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 11:13:13 -0700 (PDT)
X-Gm-Message-State: AOAM5332DTDw5xlfCjK7yBq2YYC4vylQKy7TIxAZp/+jmDEeS6kvaAuV
        WwGXaxM2tirnjT9PlVS6Hil4OmdpuwiCq3IX+vIAcQ==
X-Google-Smtp-Source: ABdhPJySlSvzybi+oPX1R+/TnCxNdawSlFrUQHATg0VfdBhxl7uvwmrn4QlgrE7bkNHqmMEQ2iO25PBoBAXSYD+E3t4=
X-Received: by 2002:a6b:6806:: with SMTP id d6mr4999741ioc.96.1632852791965;
 Tue, 28 Sep 2021 11:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHrFyr4AYi_gad7LQ-cJ9Peg=Gt73Sded8k_ZHeRZz=faGzpQA@mail.gmail.com>
 <87pmst4rhy.fsf@disp2133>
In-Reply-To: <87pmst4rhy.fsf@disp2133>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Date:   Tue, 28 Sep 2021 20:12:00 +0200
X-Gmail-Original-Message-ID: <CAHrFyr7z82u1QcOo+f72sPr7_L8qUxo1EAK=JeU8xuzAsO9REg@mail.gmail.com>
Message-ID: <CAHrFyr7z82u1QcOo+f72sPr7_L8qUxo1EAK=JeU8xuzAsO9REg@mail.gmail.com>
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

On Mon, Sep 27, 2021 at 04:51:05PM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
>
> > I'm expanding the Cc on this since this has crossed a clear line now.
>
> What asking people to fix their bugs?
>
> Sitting out and not engaging because this situation is very frustrating
> when people refuse to fix their bugs?

I clearly explained why this has crossed a line in the prior mail. Cutting that
part off won't make it go away.

>
> > You have claimed on two occasions on the PR itself (cf. [1]) and in a
> > completely unrelated thread on fsdevel (cf. [2]) that there exist bugs in the
> > current implementation.
> > On both occasions (cf. [3], [4]) we have responded and asked you to please
> > disclose those bugs and provide reproducers. You have not responded on both
> > occasions.
>
> You acknowledged the trivial bug in chown_common that affects security
> modules and exists to this day.
>
> It is trivial to see all you have to do is look at the stomp of uid and
> gid.
>
> The other bug I gave details of you and it the tracing was tricky and
> you did not agree.  Last I looked it is also there.
>
> > I ask you to stop spreading demonstrably false information such as that we are
> > refusing to fix bugs. The links clearly disprove your claims.
> > We are more than happy to fix any bugs that exist. But we can't if we don't
> > know what they are.
>
> Hog wash.

Stop the handwaving and stop claiming things that aren't true. The links in the
prior mail clearly disprove any of your claims. I did not acknowledge any bug.
And I did not do so because you have not provided any proof that this leads to
any issues. You claim that there are bugs. So the burden of proof is on you to
spell them out clearly and provide reproducers where this actually leads to
issues.

>
> A demonstration is a simple as observing that security_path_chown very
> much gets a different uid and gid values than it used to.
>
> I have been able to dig in far enough to see that the idmapped mounts
> code does not have issues when you are not using idmapped mounts, and I
> am not using idmapped mounts.  So dealing with this has not been a
> priority for me.
>
> All I have seen you do on this issue is get frustrated.  I am very
> frustrated also.
>
> All I was intending to say was that if we could sit down in person at
> LPC we could probably sort this all out quickly, and get past this our
> frustrations with each other.  As it is, I don't know a quick way to
> resolve our frustrations easily.

If that really was your intention then again, you could have easily handed in a
session to either one of the microconferences that I ran and presented in, you
could've easily asked for a hackroom session. You could've written a normal
mail addressing the issue. None of that happened. Your actions clearly speak
against any intention of resolving this constructively so far.

It is not our task to to chase after you in order to get you to tell us
what your problem is. You need to find better, less passive-aggressive
ways to deal with your frustrations.

Here is my proposal to resolve this. The Linux Plumbers infrastructure is well
alive and running and always there for on-demand meetings. I offer you a
virtual meeting with camera and audio to clear the air both socially and
technically. We will ask someone to be around as arbiter and to take notes
during that meeting so we have a track-record.


Christian
