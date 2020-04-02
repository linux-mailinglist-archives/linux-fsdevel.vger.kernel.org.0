Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0546719C7D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 19:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389166AbgDBRUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 13:20:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41872 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389160AbgDBRUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:20:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id v1so5224971edq.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8EoII7z9i5h4OnvIq0Rj015ZeVzlUXsiRDLRpXTqXw=;
        b=qazYXUmbDRgfAw8MLzT3O7+59Pt4zqcbTg4g0l/11y7Dr1rCScxhqWrtzb5yM/chh5
         xRLOjQHXW3454+bqFfrL1FiSjO9gPgydQ36xBjx2kVTf975fxHNN0Qpy7X52lFiDdAwG
         YO5SKfy/vuW+9URF5W7+XZqL7uBAwxH9JaXFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8EoII7z9i5h4OnvIq0Rj015ZeVzlUXsiRDLRpXTqXw=;
        b=iI/gNhb3Egx4FT99MBByxb94LSeQJxPL6hjbSkTu8YfgHznX6daFVCpcWaKuwMOzFj
         VUD0ALj/vuj4MGAcErpA1I5wnMJBE5iJB4VpYRCC/U6rvkUDeHvTgYRGkef2xtayQvvE
         fVi3oqtN5IsUz6kzQric4Sk7e2Q2Y0+6W3+gokA1/2Gw1ULuIH3IoAXgRjXMg+yUrC6b
         Mtalt3S3FRvIRj8GeiHFO6YzrlQdXZUS21EyVt2GjubutVIOvVjylJDeMs2TeDR/dVAu
         ibe20j9kXgl/vJN40ozJnLZaljXxEvOdbpgvJARBaP/K6SQhYZkMFyE27RJIA0HY2cYg
         lUXw==
X-Gm-Message-State: AGi0PuZYCwKlz4HE+EBe9SvkKbcqOfY0Nbs+PT9EFuyFLIr6uNL9p8Bu
        B3QX4sTv7ulALM8p9WDHNTbYdhNvEHqAle/ZQBW2hQ==
X-Google-Smtp-Source: APiQypIQHESW7HGsSbWi/b67+Z8CM+ogEI/TSMrREOv0dfgoAhH5cHrRKa2azcoZn3/BZnYkNIQR6b32zGY3N0UdqOc=
X-Received: by 2002:aa7:cfd4:: with SMTP id r20mr3924122edy.378.1585848038082;
 Thu, 02 Apr 2020 10:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login> <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login>
In-Reply-To: <20200402155020.GA31715@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 Apr 2020 19:20:26 +0200
Message-ID: <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
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
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 2, 2020 at 5:50 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Do, 02.04.20 17:35, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > > systemd cares about all mount points in PID1's mount namespace.
> > >
> > > The fact that mount tables can grow large is why we want something
> > > better than constantly reparsing the whole /proc/self/mountinfo. But
> > > filtering subsets of that is something we don't really care about.
> >
> > I can accept that, but you haven't given a reason why that's so.
> >
> > What does it do with the fact that an automount point was crossed, for
> > example?  How does that affect the operation of systemd?
>
> We don't care how a mount point came to be. If it's autofs or
> something else, we don't care. We don't access these mount points
> ourselves ever, we just watch their existance.
>
> I mean, it's not just about startup it's also about shutdown. At
> shutdown we need to unmount everything from the leaves towards the
> root so that all file systems are in a clean state.

Unfortunately that's not guaranteed by umounting all filesystems from
the init namespace.  A filesystem is shut down when all references to
it are gone.  Perhaps you instead want to lazy unmount root (yeah,
that may not actually be allowed, but anyway, lazy unmounting the top
level ones should do) and watch for super block shutdown events
instead.

Does that make any sense?

Thanks,
Miklos
