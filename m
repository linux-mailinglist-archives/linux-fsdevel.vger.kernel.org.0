Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93361A1A50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 05:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDHDgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 23:36:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39003 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDHDgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:36:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id i20so6042291ljn.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 20:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJf9EXNj3y/TKHffW9ag62Sko1WtINX0aC0YEmTe104=;
        b=S5OUs8S2WPRcFflOiuuZsTxZ8A1VyAyMWTd+UIkBzHeqvN6tEv6DNT/Bpoq4rp7OB+
         ggO9z6fRYGobw4WBVT1GwWBGUhc1933I2vOXImxppct2Mq6upT6lf6wE5i9FG0JmTvnn
         rr5kl3i0aGePIwNow27mp+LGMU0yoljl7cDiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJf9EXNj3y/TKHffW9ag62Sko1WtINX0aC0YEmTe104=;
        b=tKX3lXXrmoFpVPb/iCO3XbqeD5cdLhNz456vOVlArTgAndQoGLk1JiSPWV2qCC84U0
         kbu2qs3ICsInfWi2ZiH/C4BQ3zZj61hdc+OhMKiIjSsjWCZ+5vnfmyn9VyQ4xC+AJl7r
         RVUVwdMKlqiUnu6X6Zor1tlurY+fyL6FpjawDX8MGuZ06EWPY2+xzeJO6hCQn78K6G3s
         xNbYZwT4thAfC3brpx7T0h6bUOpby+nTf4kP7OKvfetd9X/GeL9IWeMZyG2j1Eo4kHAh
         MB76W/BWMjRGRB4zartsj54EEtt9hnN1tnqCg5MjNzH0h0R5pFtecfHfInSZYvJpmCt3
         jOeQ==
X-Gm-Message-State: AGi0PualEeVkw8gZ0vUl4I2Fjlem81/AMoVxkMX2Erjef/1B4SsKf1KU
        sxXmYFqkPR/8x5H6eCEXGj3gMu99BQI=
X-Google-Smtp-Source: APiQypLe6OzUBSr886bLPueRypjrLhHOhDmyascgwk2JOVGXhcdAHQqAkqESvRK0DWnfW38B7VdHnw==
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr3432611ljp.241.1586317005983;
        Tue, 07 Apr 2020 20:36:45 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id e20sm13062510ljn.107.2020.04.07.20.36.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 20:36:44 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id l11so4029003lfc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 20:36:44 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr3241858lfl.125.1586317003620;
 Tue, 07 Apr 2020 20:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login> <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login> <20200403203024.GB27105@fieldses.org>
 <20200406091701.q7ctdek2grzryiu3@ws.net.home> <CAHk-=wjW735UE+byK1xsM9UvpF2ubh7bCMaAOwz575U7hRCKyA@mail.gmail.com>
 <20200406184812.GA37843@gardel-login>
In-Reply-To: <20200406184812.GA37843@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 20:36:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNuJaJS9Vfe83Tfgq92PonhpfLy1-vvG63SC=3VYf3+g@mail.gmail.com>
Message-ID: <CAHk-=wgNuJaJS9Vfe83Tfgq92PonhpfLy1-vvG63SC=3VYf3+g@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Karel Zak <kzak@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 6, 2020 at 11:48 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Mo, 06.04.20 09:34, Linus Torvalds (torvalds@linux-foundation.org) wrote:
>
> > On Mon, Apr 6, 2020 at 2:17 AM Karel Zak <kzak@redhat.com> wrote:
> > >
> > > On Fri, Apr 03, 2020 at 04:30:24PM -0400, J. Bruce Fields wrote:
> > > >
> > > > nfs-utils/support/misc/mountpoint.c:check_is_mountpoint() stats the file
> > > > and ".." and returns true if they have different st_dev or the same
> > > > st_ino.  Comparing mount ids sounds better.
> > >
> > > BTW, this traditional st_dev+st_ino way is not reliable for bind mounts.
> > > For mountpoint(1) we search the directory in /proc/self/mountinfo.
> >
> > These days you should probably use openat2() with RESOLVE_NO_XDEV.
>
> Note that opening a file is relatively "heavy" i.e. typically triggers
> autofs and stuff, and results in security checks (which can fail and
> such, and show up in audit).

For the use that Bruce outlined, openat2() with RESOLVE_NO_XDEV is
absolutely the right thing.

He already did the stat() of the file (and ".."), RESOLVE_NO_XDEV is
only an improvement. It's also a lot better than trying to parse
mountinfo.

Now, I don't disagree that a statx() flag to also indicate "that's a
top-level mount" might be a good idea, and may be the right answer for
other cases.

I'm just saying that considering what Bruce does now, RESOLVE_NO_XDEV
sounds like the nobrainer approach, and needs no new support outside
of what we already had for other reasons.

(And O_PATH _may_ or may not be part of what you want to do, it's an
independent separate issue, but automount behavior wrt a O_PATH lookup
is somewhat unclear - see Al's other emails on that subject)

             Linus
