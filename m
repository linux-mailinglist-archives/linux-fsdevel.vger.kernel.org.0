Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9012A58B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2019 18:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfEYQzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 May 2019 12:55:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35731 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfEYQzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 May 2019 12:55:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id h11so11287434ljb.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2019 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBdLovlpt9AZuIiNUZbGP+lZb3Sg/PGshfq8cZbUBd0=;
        b=amJvf4Mf4+qu8tdwTdbzD3weELsw5ul+SeN2Y2A+KXwri5iCvpoMv3QsDHz5iHYNmb
         9+v4lc5LTsDIJzQmSUaXGS7dtebcYbd+O0qcSFEqasYPEdaL6AaYnO9V/W0Y3SguqyHp
         LogCMsi64f4r6N92eF/bc7hFdaM5KrEmZfqoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBdLovlpt9AZuIiNUZbGP+lZb3Sg/PGshfq8cZbUBd0=;
        b=ZGIlabUDP7mt1WPxR4x3o9jmUL41sTfVjVRPv4divjz4EcS7fw+pmbepuBl1OLQOxm
         blwRh1Jxg97c705CMztZ5UnFXvSigftqNCkn7ke3yIlvWBu1nctfTw2wc10ms+CgRAw9
         vFQRAF04SUrdH4bHJyqEpsy02dLmhxF7jH/TG3iedh40s3lKe2vO0Q/VjlEwBVY6dbgv
         GhNFoJUI0MnHgm2dqJ1SY6AWLCjUyP4kllpv4Va48l+0pwQpsgT+yaCZgHMBSaXqdwbz
         DTkDI+3M5STdEAoHRAbA2pQu2NDytQ4ktzMo33TFPzrf4ShLoHw5DcmYz/noTTDxs8zN
         WlIA==
X-Gm-Message-State: APjAAAV8WbUJLXfy9ZwmFhPua47+GJz7jd8LdyXEzC7mA33fa+/+o+J9
        KpaymDWvjWTviZU3gd3u+bd+sYSH4mI=
X-Google-Smtp-Source: APXvYqz0v7MGWmoArDTtNHDHOWAshMcRe+Bd4+BjFW1M55PJlN3CIOjLEg/NZhOdFZbeCjXioQ81/A==
X-Received: by 2002:a2e:88ce:: with SMTP id a14mr13225610ljk.122.1558803308316;
        Sat, 25 May 2019 09:55:08 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r29sm372567lfn.68.2019.05.25.09.55.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 09:55:06 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id e13so11226597ljl.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2019 09:55:06 -0700 (PDT)
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr46505164ljj.52.1558803305972;
 Sat, 25 May 2019 09:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190507164317.13562-1-cyphar@cyphar.com> <20190507164317.13562-6-cyphar@cyphar.com>
 <CAHk-=whbFMg4+HuWOBuHpvDNiAyowX2HUowv3+pt8vPWk5W-YQ@mail.gmail.com> <20190525070307.bxbvjh2254sx2z6g@yavin>
In-Reply-To: <20190525070307.bxbvjh2254sx2z6g@yavin>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 May 2019 09:54:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKFi5wi33AmJ4XJmzQaCMHa21-Z-GD_OKPNz=js7R7ig@mail.gmail.com>
Message-ID: <CAHk-=wiKFi5wi33AmJ4XJmzQaCMHa21-Z-GD_OKPNz=js7R7ig@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] namei: resolveat(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 25, 2019 at 12:03 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> You might not have seen the v8 of this set I sent a few days ago[1]. The
> new set includes an example of a feature that is possible with
> resolveat(2) but not with the current openat(O_PATH) interface.

It's the "forced O_PATH" model that makes resolveat() basically
entirely pointless to me.

You can do almost nothing with an O_PATH file descriptor. Yes, it's a
really cool feature, and it's great for what it is, but it's less than
0.001% of all opens people have.

Even among security-conscious users, it's pointless. Yes, an O_PATH
file descriptor is somewhat more "secure", but it's secure because
it's mostly USELESS, and has to be converted into something else to be
used.

So say you are something like a static web server that actually wants
to use the "don't traverse '..', don't follow symlinks" features etc.
What you want to do with the end result is read() it or mmap it, or
sendpage or whatever.

This is why I think resolveat() is entirely pointless. Even with
O_EMPTYPATH it's pointless - because you shouldn't *need* that extra
"ok, now get me the actual useful fd" phase.

In fact, I think resolveat() as a model is fundamentally wrong for yet
another reason: O_CREAT. If you want to _create_ a new file, and you
want to still have the path resolution modifiers in place, the
resolveat() model is broken, because it only gives you path resolution
for the lookup, and then when you do openat(O_CREAT) for the final
component, you now don't have any way to limit that last component.

Sure,  you can probably effectively hack around it with resolveat() on
everything but the last component, and then
openat(O_CREAT|O_EXCL|O_NOFOLLOW) on the last component, because the
O_EXCL|O_NOFOLLOW should mean that it won't do any of the unsafe
things. And then (if you didn't actually want the O_EXCL), you handle
the race between "somebody else got there first" by re-trying etc. So
I suspect the O_CREAT thing could be worked around with extra
complexity, but it's an example of how the O_PATH model really screws
you over.

End result: I really think resolveat() is broken. It absolutely
*needs* to be a full-fledged "openat()" system call, just with added
path resolution flags.

>   openat2(rootfd, "path/to/file", O_PATH, RESOLVE_IN_ROOT, &statbuf);

Note that for O_CREAT, it either needs the 'mode' parameter too, or
the statbuf would need to be an in-out thing. I think the in-out model
might be nice (the varargs model with a conditional 'mode' parameter
is horrid, I think), but at some point it's just bike-shedding.

Also, I'm not absolutely married to the statbuf, but I do think it
might be a useful extension. A *lot* of users need the size of the
file for subsequent mmap() calls (or for buffer management for
read/write interface) or for things like just headers (ie
"Content-length:" in html etc).

I'm not sure people actually want a full 'struct stat', but people
historically also do st_ino/st_dev for indexing into existing
user-space caches (or to check permissions like that it's on the right
filesystem, but the resolve flags kind of make that less of an issue).
And st_mode to verify that it's a proper regular file etc etc.

You can always just leave it as NULL if you don't care, there's almost
no downside to adding it, and I do think that people who want a "walk
pathname carefully" model almost always would want to also check the
end result anyway.

Again, I'm thinking of the most obvious use cases where you want these
kinds of special pathname traversals: file servers, static web content
serving etc. They *all* want the file size and type when they open a
file.

> Is there a large amount of overhead or downside to the current
> open->fstat way of doing things, or is this more of a "if we're going to
> add more ways of opening we might as well add more useful things"?

Right now, system calls are sadly very expensive on a lot of hardware.
We used to be very proud of the fact that Linux system calls were
fast, but with meltdown and retpoline etc, we're back to "system calls
can be several thousand cycles each, just in overhead, on commonly
available hardware".

Is "several thousand cycles" fatal? Not necessarily. But I think that
if we do add a new system call, particularly a fancy one for special
security-conscious models, we should look at what people need and use,
and want. And performance should always be a concern.

I realize that people who come at this from primarily just a security
issue background may think that security is the primary goal. But no.
Security always needs to realize that the _primary_ goal is to have
people _use_ it. Without users, security is entirely pointless. And
the users part is partly performance, but mostly "it's convenient".

The whole "this is Linux-specific" is a big inconvenience point, but
aside from that, let's make any new interface as welcoming and simple
and useful as possible. Not a "you have to do extra work" interface.
Quite the reverse. Make it something that makes people go "ahh, yes,
this actually means I don't have to do anything extra, because it
already does everything I want for opening and checking a pathname".

So the way to sell the path lookup improvements should not be "look,
here's a secure way to look up paths". No. That's entirely missing the
point.

No, the way to do path lookup improvements is to say "look, here's a
_convenient_ way to look up paths, and btw, it's also easy to make
secure".

Talking about securely opening things - another flag that we may want
to avoid issues is a "don't open device nodes" flag. Sure, O_NONBLOCK
plus checking the st_mode of the result is usually sufficient, but
it's actually fairly easy to get that wrong. Things like /dev/tty and
/dev/zero often need to be available for various reasons, and have
been used to screw careless "open and read" users up that missed a
check.

I also do wonder that if the only actual user-facing interface for the
resolution flags is a new system call, should we not make the
*default* value be "don't open anything odd at all".

So instead of saying RESOLVE_XDEV for "don't cross mount points",
maybe the flags should be the other way around, and say "yes, allow
mount point crossings", and "yes, explicitly allow device node
opening", and "yes, allow DOTDOT" etc.

               Linus
