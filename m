Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89EABCA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404800AbfIFPgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 11:36:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35107 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404801AbfIFPgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:36:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id q22so1832456ljj.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXqD3C73hqZbQh8+pyGdwCZwxnrqPGKEEp+0kRpG5I8=;
        b=DYc6W/hyCfxAxHbkWTmDrh+ODKc6x42+38HNklF0/ptlANxl7RT8hSgyEdfrQHi6Xh
         5ChSGqRSbxC9ue8UUxHuvt5x60DSZdetyLFMHeKirW5J2qmzjwoayW12EsnqZorry25V
         3FxxQI4aE2n0uiQzkRk4wz84DwPGTYa2AbbHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXqD3C73hqZbQh8+pyGdwCZwxnrqPGKEEp+0kRpG5I8=;
        b=JhX64RqHsfD57XJkxlPQIdVRillmNnI/9bkFD9t74ZanEHL2eNxJ9C2FAzMvltx73y
         fu2DMwyV5EcuYHYKNJHKpAYYVQNa5xsQXKlzeGV1VPzLkV0hK8z7QFheMVlCSyenC6e6
         w5/VuHQWk3GJdI1arOTyzxb8TonxmayOk3lKzRRCur4/eCiZVi7yYoH/zm2OEF/3cRp4
         qng8hgCSw3zTqo6IVNAF6W8LLfseWVxro2XIH8biHBu3W6iNbCxl8Lq9uaITeUbBUeEr
         M/GsrJrYuPlyribkQmLygPskuVr+mkzvizcgJknkxlRZw0v5573p4i9znahgHZMznvkp
         F+Sg==
X-Gm-Message-State: APjAAAUqbEs2W3+/6yNeFjZ824ukgXE2iA0cKEv0m361oNWZp1Lri6ZC
        vJaQ0x8LZ7FyxCK9JqYBY8XvRW1Yxmg=
X-Google-Smtp-Source: APXvYqxVxvwVgwavEUDztc9JRNyShey8e8VoooQRxlBX7QM6kLRs4HcHQxeLv7kFpkrj/2uo9xuxiQ==
X-Received: by 2002:a2e:9a52:: with SMTP id k18mr6045245ljj.95.1567784166540;
        Fri, 06 Sep 2019 08:36:06 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 126sm1366099lfh.45.2019.09.06.08.36.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:36:02 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id l11so5416396lfk.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 08:36:02 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr6833712lfp.134.1567784162071;
 Fri, 06 Sep 2019 08:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
 <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
 <5396.1567719164@warthog.procyon.org.uk> <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
 <14883.1567725508@warthog.procyon.org.uk> <CAHk-=wjt2Eb+yEDOcQwCa0SrZ4cWu967OtQG8Vz21c=n5ZP1Nw@mail.gmail.com>
 <27732.1567764557@warthog.procyon.org.uk>
In-Reply-To: <27732.1567764557@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Sep 2019 08:35:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
Message-ID: <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     David Howells <dhowells@redhat.com>
Cc:     Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 6, 2019 at 3:09 AM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > But it's *literally* just finding the places that work with
> > pipe->curbuf/nrbufs and making them use atomic updates.
>
> No.  It really isn't.  That's two variables that describe the occupied section
> of the buffer.  Unless you have something like a 68020 with CAS2, or put them
> next to each other so you can use CMPXCHG8, you can't do that.
>
> They need converting to head/tail pointers first.

You misunderstand - because I phrased it badly. I meant "atomic" in
the traditional kernel sense, as in "usable in not thread context" (eg
GFP_ATOMIC etc).

I'd start out just using a spinlock.

I do agree that we could try to be fancy and do it entirely locklessly
too, and I mentioned that in another part:

 "[..] it should not
  be all that hard to just make the whole "curbuf/nrbufs" handling use
  its own locking (maybe even some lockless atomics and cmpxchg)"

but I also very much agree that it's much more complex.

The main complexity of a lockless thing is actually almost certainly
not in curbuf/nrbufs, because those could easily be packed as two
16-bit values in a 32-bit entity and then regular cmpxchg works fine.

No, the complexity in the lockless model is that then you have to be
very careful with the "buf[]" array update too.  Maybe that's trivial
(just make sure that they are NULL when not used), but it just looks
less than wonderfully easy.

So a lockless update I'm sure is _doable_ with some cleverness, but is
probably not really worth it.

That's particularly true since we already *have* a spinlock that we
would take anyway: the we could strive to use the waitqueue spinlock
in pipe->wait, and not even really add any new locking. That would
require a bit of cleverness too and re-ordering things more, but we do
that in other places (eg completions, but the fs_pin code does it too,
and a few other cases.

Look for "wake_up_locked()" and friends, which is a sure-fire sign
that somebody is playing games and taking the wait-queue lock manually
for their own nefarious reasons.

> > They really would work with almost anything. You could even mix-and-match
> > "data generated by kernel" and "data done by 'write()' or 'splice()' by a
> > user process".
>
> Imagine that userspace writes a large message and takes the mutex.  At the
> same time something in softirq context decides *it* wants to write a message -
> it can't take the mutex and it can't wait, so the userspace write would have
> to cause the kernel message to be dropped.

No. You're missing the point entirely.

The mutex is entirely immaterial for the "insert a message". It is
only used for user-space synchronization. The "add message to the pipe
buffers" would only do the low-level buffer updates (whether using a
new spinlock, re-using the pipe waitqueue lock, or entirely
locklessly, ends up being then just an implementation detail).

Note that user-space writes are defined to be atomic, but they are (a)
not ordered and (b) only atomic up to a single buffer entry (which is
that PIPE_BUF limit). So you can always put in a new buffer entry at
any time.

Obviously if a user space write just fills up the whole queue (or
_other_ messages fill up the whole queue) you'd have to drop the
notification. But that's always true. That's true even in your thing.
The only difference is that we _allow_ other user spaces to write to
the notification queue too.

But if you don't want to allow that, then don't give out the write
side of the pipe to any untrusted user space.

But in *general*, allowing user space to write to the pipe is a great
feature: it means that your notification source *can* be a user space
daemon that you gave the write side of the pipe to (possibly using fd
passing, possibly by just forking your own user-space child or cloning
a thread).

So for example, from a consumer standpoint, you can start off doing
these things in user space with a helper thread that feeds the pipe
(for example, polling /proc/mounts every second), and then when you've
prototyped it and are happy with it, you can add the system call (or
ioctl or whatever) to make the kernel generate the messages so that
you don't have to poll.

But now, once you have the kernel patch, you already have a proven
user, and you can show numbers ("My user-space thing works, but it
uses up 0.1% CPU time and has that nasty up-to-one-second latency
because of polling"). Ta-daa!

End result: it's backwards compatible, it's prototypable, and it's
fairly easily extensible. Want to add a new source of events? Just
pass the pipe to any random piece of code you want. It needs kernel
support only when you've proven the concept _and_ you can show that
"yeah, this user space polling model is a real performance or
complexity problem" or whatever.

This is why I like pipes. You can use them today. They are simple, and
extensible, and you don't need to come up with a new subsystem and
some untested ad-hoc thing that nobody has actually used.

And they work automatically with all the existing infrastructure. They
work with whatever perl or shell scripts, they work with poll/select
loops, they work with user-space sources of events, they are just very
flexible.

                     Linus
