Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1696CB30D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2019 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbfIOQL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Sep 2019 12:11:29 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42519 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfIOQL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:11:29 -0400
Received: by mail-ua1-f65.google.com with SMTP id r19so501294uap.9;
        Sun, 15 Sep 2019 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSWQJqSgzi0rRB4MB03H01txRo3ZEbvDz6ZQVxWpBys=;
        b=Erd+t2miEUQ/AY1Xlk+AweRMJFkMT8HBCeMLi11DDHsLxD3Pa+IqMMXIIfpxyaYhcG
         /aeqOlIwCYg6UM/tDyIoZOzBbwegNscxVfzC87LjiAuTcUitlULaD43HLu1zPGiw2KV7
         TtOqFoNFHyRVONUq8TR/fBzZ3V2cEZgobua0m3r83q4AS8SOETKr4QTzb6qM+zjYkXkn
         C0McYEJ04d28z1hAaR3s6PCOpns71MG3rz2RwRp/xOw3R8BsUR5Ze3KD033+y5FJkzTj
         jyMnZE1dAxwc8bPBY+AVxQQFvzm3lVu6JHSaeAcK5gCGk7S1StHWlSABfVPHr5DYmWwh
         t5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSWQJqSgzi0rRB4MB03H01txRo3ZEbvDz6ZQVxWpBys=;
        b=km/kpBdLHwretiwjzbhZzGvhdII/h4avAv/uIcK+q83KC9SiAbQiRe+gztb3HE6/11
         9U8KpaCFkqgX0ed8kq03wVQE8uXbPllYRL8Oe8qFVmmhK7WkLlu01uAA9x9XlkLzHGak
         rWUjg1qkyTh6JPFddK7UgkYhmOfDW+bezyl/uK0w/lVglJFkQyzmq9eN1ufmJH/hiyEC
         BEGqVzvMKK95LZe0cKzh/gvuKm4Z3IPELBqzyTOLJF0r/hSTlLgsnpfpCHB5lhjXOyII
         OulJP4XpX8soGviFVrodGtBlvQD3Te/Ug5B4Ri4WP6rGYb00B3A5eFLY37qDzVlIFTR3
         B9EA==
X-Gm-Message-State: APjAAAVGMnRhPnOkg44rIYzLM+BdYfvliGSuemtGCyuoKlkT3/yLn4Dk
        ou9UBoPS96BaYzBQ/2W4PlHP/DjT4KpVscHXFXE=
X-Google-Smtp-Source: APXvYqyB9j0r6bSS+9T87UFEPkzM/e4XMgBNe9Edu9uNZgf/FMBxUv/LhclgCMRJS0jFWtsVwrOBAVDShPeJKz7t0Ss=
X-Received: by 2002:ab0:2808:: with SMTP id w8mr21830317uap.75.1568563886024;
 Sun, 15 Sep 2019 09:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190914133951.16501-1-qkrwngud825@gmail.com> <20190915135409.GA553917@kroah.com>
In-Reply-To: <20190915135409.GA553917@kroah.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Mon, 16 Sep 2019 01:11:14 +0900
Message-ID: <CAD14+f2EqjUfr+Xwx9CDoqvCdeFo0UqYrVxN=s8Yo4b3KTyZXA@mail.gmail.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexander.levin@microsoft.com, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On Sun, Sep 15, 2019 at 10:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> Note, this just showed up publically on August 12, where were you with
> all of this new code before then?  :)

My sdFAT port, exfat-nofuse and the one on the staging tree, were all
made by Samsung.
And unless you guys had a chance to talk to Samsung developers
directly, those all share the same faith of lacking proper development
history.

The source I used was from http://opensource.samsung.com, which
provides kernel sources as tar.gz files.
There is no code history available.

> For the in-kernel code, we would have to rip out all of the work you did
> for all older kernels, so that's a non-starter right there.

I'm aware.
I'm just letting mainline know that there is potentially another (much
better) base that could be upstreamed.

If you want me to rip out older kernel support for upstreaming, I'm
more than happy to do so.

> As for what codebase to work off of, I don't want to say it is too late,
> but really, this shows up from nowhere and we had to pick something so
> we found the best we could at that point in time.

To be honest, whole public exFAT sources are all from nowhere unless
you had internal access to Samsung's development archive.
The one in the current staging tree isn't any better.

I'm not even sure where the staging driver is from, actually.

Samsung used the 1.2.x versioning until they switched to a new code
base - sdFAT.
The one in the staging tree is marked version 1.3.0(exfat_super.c).
I failed to find anything 1.3.x from Samsung's public kernel sources.

The last time exFAT 1.2.x was used was in Galaxy S7(released in 2016).
Mine was originally based on sdFAT 2.1.10, used in Galaxy S10(released
in March 2019) and it just got updated to 2.2.0, used in Galaxy
Note10(released in August 2019).

> Is there anything specific in the codebase you have now, that is lacking
> in the in-kernel code?  Old-kernel-support doesn't count here, as we
> don't care about that as it is not applicable.  But functionality does
> matter, what has been added here that we can make use of?

This is more of a suggestion of
"Let's base on a *much more recent* snapshot for the community to work on",
since the current one on the staging tree also lacks development history.

The diff is way too big to even start understanding the difference.


With that said though, I do have some vague but real reason as to why
sdFAT base is better.

With some major Android vendors showing interests in supporting exFAT,
Motorola notably published their work on public Git repository with
full development history(the only vendor to do this that I'm aware
of).
Commits like this:
https://github.com/MotorolaMobilityLLC/kernel-msm/commit/7ab1657 is
not merged to exFAT(including the current staging tree one) while it
did for sdFAT.


The only thing I regret is not working on porting sdFAT sooner.
I definitely didn't anticipate Microsoft to suddenly lift legal issues
on upstreaming exFAT just around when I happen to gain interest in
porting sdFAT.

If my port happened sooner, it would have been a no-brainer for it to
be considered as a top candidate for upstreaming.

> And do you have any "real" development history to look at instead of the
> "one giant commit" of the initial code drop?  That is where we could
> actually learn what has changed over time.  Your repo as-is shows none
> of the interesting bits :(

As I mentioned, development history is unobtainable, even for the
current staging tree or exfat-nofuse.
(If you guys took exfat-nofuse, you can also see that there's barely
any real exFAT-related development done in that tree. Everything is
basically fixes for newer kernel versions.)

The best I could do, if someone's interested, is to diff all versions
of exFAT/sdFAT throughout the Samsung's kernel versions, but that
still won't give us reasons as to why the changes were made.

TL;DR
My suggestion - Let's base on a much newer driver that's matured more,
contains more fixes, gives (slightly?) better performance and
hopefully has better code quality.

Both drivers are horrible.
You said it yourself(for the current staging one), and even for my new
sdFAT-base proposal, I'm definitely not comfortable seeing this kind
of crap in mainline:
https://github.com/arter97/exfat-linux/commit/0f1ddde

However, it's clear to me that the sdFAT base is less-horrible.

Please let me know what you think.

> thanks,
>
> greg kh

Thanks.
