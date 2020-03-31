Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD0D199F56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 21:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgCaTnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 15:43:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43224 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbgCaTnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:43:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id bd14so26603536edb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2020 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HFZna7B6g1qQUnAQTOaaX3bdubKi7WXs6HzJfhZe8E4=;
        b=TcGP1kiFt9TdcQCMN/6cHIEa8mw5mBMiYAgzq5W5XMfO9Pplrw2mgTSH95iHFkjugK
         VNgA55P4+EMCWXOZlJVe9vEBju8ag+gGELwv3TPDpBljOsqJNv1dgIaIsLKdA7RG6BnN
         3sTGVsH3VMr2PFu+Gs2kiwF6gEq9MgmoG35qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFZna7B6g1qQUnAQTOaaX3bdubKi7WXs6HzJfhZe8E4=;
        b=FwInBjZVeFgDypRwHdqyAHbe8vcRqoj/rRebB8QFfCnNBd5NOb/eHBWP+cLvg+p6ET
         17co4DLXFy7TtxqAS/+SWl0DyuHHHvYRFH0hCwRSlgFDdRTliSm+nEt+z0x/+68Kfl/5
         CFmmr7I2MYrL3Srm1i+Jgke9sryKKl3RKcrrNFpfm6WzEbEHYIQ44Fz/lI15XBQn+ONl
         mYKQTXYNQWLMUbrY1xvQlUnm1ICe4uY46irKcD4AUjaGZh1twrUace2jGIlQwHK8Jyaj
         ewpaziNI02PV1/COCp7fvulfGiGOOm8h9lWYcJ94MPmSaTDvKjuNjNiVv5hWrfh9RfEP
         O6eg==
X-Gm-Message-State: ANhLgQ2Ulq+YevN2Fz+JWOf3jbEHiQMY1MJ7oMc8k4u4LboNOGSL16aj
        JtWKzsb3lD5FsclQmT0pZjWu0IRy+zUjOC8OyftsFg==
X-Google-Smtp-Source: ADFU+vtrYvHHl1chvcRo/VYstpzDmXRwHh8LdW6LXuVqHM34+7/GlmkkMu0Wr8lt8XH3sfM/6AQ9IhhQXBTgz0BbqIs=
X-Received: by 2002:aa7:cfd4:: with SMTP id r20mr17351970edy.378.1585683779811;
 Tue, 31 Mar 2020 12:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk> <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com>
 <2294742.1585675875@warthog.procyon.org.uk>
In-Reply-To: <2294742.1585675875@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 31 Mar 2020 21:42:48 +0200
Message-ID: <CAJfpegtn1A=dL9VZJQ2GRWsOiP+YSs-4ezE9YgEYNmb-AF0OLA@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 7:31 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > The basic problem in my view, is that the performance requirement of a
> > "get filesystem information" type of API just does not warrant a
> > binary coded interface. I've said this a number of times, but it fell
> > on deaf ears.
>
> It hasn't so fallen, but don't necessarily agree with you.  Let's pin some
> numbers on this.

Cool, thanks for testing.  Unfortunately the test-fsinfo-perf.c file
didn't make it into the patch.   Can you please refresh and resend?

> Okay, the results:
>
>   For  1000 mounts, f= 1514us f2= 1102us p=  6014us p2=  6935us; p=4.0*f p=5.5*f2 p=0.9*p2
>   For  2000 mounts, f= 4712us f2= 3675us p= 20937us p2= 22878us; p=4.4*f p=5.7*f2 p=0.9*p2
>   For  3000 mounts, f= 6795us f2= 5304us p= 31080us p2= 34056us; p=4.6*f p=5.9*f2 p=0.9*p2
>   For  4000 mounts, f= 9291us f2= 7434us p= 40723us p2= 46479us; p=4.4*f p=5.5*f2 p=0.9*p2
>   For  5000 mounts, f=11423us f2= 9219us p= 50878us p2= 58857us; p=4.5*f p=5.5*f2 p=0.9*p2
>   For 10000 mounts, f=22899us f2=18240us p=101054us p2=117273us; p=4.4*f p=5.5*f2 p=0.9*p2
>   For 20000 mounts, f=45811us f2=37211us p=203640us p2=237377us; p=4.4*f p=5.5*f2 p=0.9*p2
>   For 30000 mounts, f=69703us f2=54800us p=306778us p2=357629us; p=4.4*f p=5.6*f2 p=0.9*p2

So even the p2 method will give at least 80k queries/s, which is quite
good, considering that the need to rescan the complete mount tree
should be exceedingly rare (and in case it mattered, could be
optimized by priming from /proc/self/mountinfo).

Thanks,
Miklos
