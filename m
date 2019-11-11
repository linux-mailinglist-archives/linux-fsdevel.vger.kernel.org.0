Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D938F7DDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 20:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKKTAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 14:00:04 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40380 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbfKKTAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:00:04 -0500
Received: by mail-oi1-f193.google.com with SMTP id 22so12442499oip.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 11:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hij9WRW9jexaTExPnUz0qaTqt1chIxl/l165TeSCuFk=;
        b=RVbyU4ESVWlXQ8T3vJoN/oZeBZzpoGo5ihXG901x+xkoVGygn+QUOW8Q+wh00/DvOP
         giok/SgrwR70kYfkO45hsvOAP+WhHiPqYwDj0dHHMkve8fY461e4iJtlRNi7eR1DhAnr
         msvmqz3cgRr9WTZZh2vG1SNXT9gxsC4kYzoWV5sLY5uoS7y7h9f1x7peNvMd98iVG6e6
         HxL1ITDDClLoV1YB9+VYGF7sapY8UPo3CA5UJHCfPI+qLRQi3yfO44XttBTSfdrQ6EaD
         7jEOcmSiHHrw/5DNMhwm1YzJ+xQTSjO1kZJk+T45B0zkAzCPjVfZEJtuP1V0O9Lh2wbP
         Pj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hij9WRW9jexaTExPnUz0qaTqt1chIxl/l165TeSCuFk=;
        b=EUYgyTuE/uQOes2OBJ3rE/XsRbK7ljaZCrP5/AIq7ah1sU7MDOjMW/UWSK0wGk3bz8
         A6Srh4Rh4TfqUANIxWnsFb1H6HxUhpH4sOjW0XWj9ctR2PSxKf6zCchcX73Wapsp2geZ
         yu60tlxPBhh3B+sJcoR0yDx6rHhRF1Mqi7avzRP8RjlyB8X5oP37qw/JccweUPtRIXLk
         2Cmkeiq+ts/DyU9+7vD2Ly0scP3vAIofuwyqeSxtix2GuZAuqI++45XC9oriKR3Jj0Bk
         iLm01is3D6gZHPxmNoAoYL7n0Hkr30QkxRLlV2Kci5FffOA7fEMDDSKzqaK2lnQZsIyX
         WTdA==
X-Gm-Message-State: APjAAAUoaAypiTtdNqER/wjLsDw+Ao9ma9cca511eF/Unf9dcNRmPmYr
        cv6BomWFIhLsOaV/u38URBBMOYedJxc1RDa45Mk+Rw==
X-Google-Smtp-Source: APXvYqwuLe2W6zNidCS4fhh7tulT13NX4MB6+vyTZa/nE+xFjVDnEnM6AgSgW+nAjTQsXtyrboaM6eqO5Q/xA8t81gM=
X-Received: by 2002:aca:5413:: with SMTP id i19mr388074oib.121.1573498802654;
 Mon, 11 Nov 2019 11:00:02 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com> <CAHk-=wgWf7Ma+iWuJTTr9HW1-yP26vEswC1Gids-A=eOP7LaOQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgWf7Ma+iWuJTTr9HW1-yP26vEswC1Gids-A=eOP7LaOQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Nov 2019 19:59:50 +0100
Message-ID: <CANpmjNOJOBcKh23tPi_+Lv1ONfL_kkK9q6qqS51LK4h63n2swA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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

On Mon, 11 Nov 2019 at 19:50, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Nov 11, 2019 at 10:31 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > Problem is that KASAN/KCSAN stops as soon as one issue is hit,
> > regardless of it being a false positive or not.
>
> So mayb e that - together with the known huge base of false positives
> - just means that KCSAN needs some more work before it can be used as
> a basis for sending out patches.
>
> Maybe the reporting needs to create a hash of the location, and report
> once per location? Or something like that.
>
> Maybe KCSAN needs a way to filter out known false positives on a KCSAN
> side, without having to change the source for a tool that gives too
> much noise?
>
> > If we do not annotate the false positive, the real issues might be
> > hidden for years.
>
> I don't think "change the kernel source for a tool that isn't good
> enough" is the solution.
>
> > There is no pattern really, only a lot of noise (small ' bugs'  that
> > have no real impact)
>
> Yeah, if it hasn't shown any real bugs so far, that just strengthens
> the "it needs much fewer false positives to be useful".
>
> KASAN and lockdep can afford to stop after the first problem, because
> the problems they report - and the additional annotations you might
> want to add - are quality problems and annotations.

There is a fundamental limitation here. As I understand, in an ideal
world we'd only find true logic bugs, *race conditions*, first, and
*data races* later. Some data races are also race conditions, which a
tool like KCSAN can report. However, not all race conditions are data
races and vice-versa.

The intent is to report data races according to the LKMM. KCSAN
currently does that. On syzbot, we do not even report all data races
because we use a very conservative config, to filter things like data
races between plain and ONCE/atomic accesses, etc. A data race
detector can only work at the memory model/language level.

Deeper analysis, to find only race conditions, requires conveying the
intended logic and patterns to a tool. This requires 1) the developer
either writing a spec or model of their code, and then 2) the tool
verifying that the implementation matches.  People have done this for
small bits of code using model checkers (and other formal methods),
but this just doesn't scale!

KCSAN finds real problems today. Maybe not all of them are race
conditions, but they are data races. We already have several options
to filter data races, and will keep adding more. However, a tool that
magically proves that there are no concurrency related logic bugs is
an entirely different beast.

Thanks,
-- Marco
