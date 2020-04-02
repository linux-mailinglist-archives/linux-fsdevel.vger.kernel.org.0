Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8061219C606
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 17:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389371AbgDBPgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 11:36:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37091 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732754AbgDBPgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:36:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so4749832edb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvpB8Y9+2s8yhXG+Difzh12SAeQrdOznGEw6/JuNFsM=;
        b=GwITZ4q6fgQ4Z9f/rIhWXZ4D433UVA+cFWOjP9ECWJk9WlbE5kYdg98i0AmdJst2kc
         2ez8gd97agQdCMtxG/DO5OmiX4lFPAbTvrJIkmTgQQiPUxOK6UIHN3XEcBoK6AhWgU1A
         tfFrCRgezw+SxIODtjbiHb+KRBHAL/1MjaOVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvpB8Y9+2s8yhXG+Difzh12SAeQrdOznGEw6/JuNFsM=;
        b=GC9PXsn+GiOicXwI95FJ+38wsD0ViNj5a8WAvlLiHi05HGTRAinETaOzVFzznM6ZvA
         EpcJofQOYNBv4FBShXNqdqtXzGEihagmPCSN9UKD0Gw9xqE8FSZ4SjMKa7rGGLNjXrHq
         0qKDD8RihCqRVvO1DckXtiLL6tsZ5oMtXKM3fnO1i9SI8XkqXPTO5XFY5r8hkLupjK1W
         99Hh+I/NEVkKUUIk4/usBf89wGM9ATQxYHXR98ZoMAsn0ozGKG1mThjMaOrCVtBW+Dj1
         fYoP2D+k/+2m6ut31rPxc2nSTJXDg/uOlNJOuPOrBEY/nGxkNtWpFKywo3osTTjfBJbM
         rgBw==
X-Gm-Message-State: AGi0PuZGBw5Lxfm8HI8yZhy4mTTQNMIE5jc5GD6LVGaE0R47B0yCoORA
        l3RjZpTDe9K1mB6lSBO0YNHYj6MmEBEF3vvBcMZTIw==
X-Google-Smtp-Source: APiQypI+AyCZaLfkgAoRXsYBwDo+KUKIpDLcwXtmEMG0HteM88CwCZRnu4LJE+dw5rBNknVXHip3cfzZdnvFU2Wwhuw=
X-Received: by 2002:a05:6402:44e:: with SMTP id p14mr3563979edw.356.1585841765422;
 Thu, 02 Apr 2020 08:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk> <2418286.1585691572@warthog.procyon.org.uk>
 <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login>
In-Reply-To: <20200402152831.GA31612@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 Apr 2020 17:35:54 +0200
Message-ID: <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
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

On Thu, Apr 2, 2020 at 5:28 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Do, 02.04.20 17:22, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > On Thu, Apr 2, 2020 at 4:36 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > > You appear to be thinking about the "udisks" project or so?
> >
> > Probably.
> >
> > The real question is: is there a sane way to filter mount
> > notifications so that systemd receives only those which it is
> > interested in, rather than the tens of thousands that for example
> > autofs is managing and has nothing to do with systemd?
>
> systemd cares about all mount points in PID1's mount namespace.
>
> The fact that mount tables can grow large is why we want something
> better than constantly reparsing the whole /proc/self/mountinfo. But
> filtering subsets of that is something we don't really care about.

I can accept that, but you haven't given a reason why that's so.

What does it do with the fact that an automount point was crossed, for
example?  How does that affect the operation of systemd?

Thanks,
Miklos
