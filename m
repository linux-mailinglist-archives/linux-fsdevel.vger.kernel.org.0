Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3DC13642B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 01:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgAJAIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 19:08:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45563 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbgAJAIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 19:08:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so196295ljc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 16:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjrwlNrUWv0QXAIqsTPozbObZ8/7GgridjmNme8W52I=;
        b=ZtRoq1DRX7RXsXHhNmpxW4UB5JzoQNOKVTmOa01bx5ggT/DHqnRKaMysJGfaxE1BO8
         89pqzHmvERx+seKq1dYzZ8We/mt3eqN1+GxPl8i6s9a40Llm5xj1AoQQ53D6zO8ixCG8
         zDKJYDEBm9yUsTkdwHLUa14RvnsxxJ0XX8xZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjrwlNrUWv0QXAIqsTPozbObZ8/7GgridjmNme8W52I=;
        b=KgPJcDiGOlNslwZif13pWfzDx2h2NOiMk+H7a0f6oVn1y1hgn4/RbBFsNqAUfA/wJX
         D/2UxIx8CCxEXflW+ovWuk3xC+kQQZgD/OQbAZYHwp8Cxwy0qgbCRZtPyVFdyo/u7Frj
         3a1pc5MmQ6rlMx1AfVNt2gWuaNsDY/09VUsufxGxmyOZw3CgQriycPGlVdlzv2q0WYoJ
         QuL1fQeYVN2ww8h1ceq5lq5aGX2ZfG6CNq357PkI7+sXj12QslrHiWOMPjqllErA5QCF
         MTYGuwAW4h8Dm7sUJrhm/qcPHwnwui4Iu17UYLDtPC07VqvO8T3OWvozpUzBw70circG
         abxA==
X-Gm-Message-State: APjAAAVwNxVWb1HrO0+oEmH/14fgNHnk5EK5Dtf883jqrn9Ow9RP3p2d
        9JjfjkvwSUqGIHjRwTEB6WiBuEkXWaE=
X-Google-Smtp-Source: APXvYqy4bWmMH6PHWusq/Q5YL60TjIp3AoelXxe6N9HQhKKZGwniKWfuS/YWxNGKERw+8+gGNLz0QQ==
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr389695ljo.125.1578614914875;
        Thu, 09 Jan 2020 16:08:34 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id s2sm85321lji.53.2020.01.09.16.08.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 16:08:33 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id y4so210109ljj.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 16:08:32 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr455607ljn.48.1578614912546;
 Thu, 09 Jan 2020 16:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20191230072959.62kcojxpthhdwmfa@yavin.dot.cyphar.com>
 <20200101004324.GA11269@ZenIV.linux.org.uk> <20200101005446.GH4203@ZenIV.linux.org.uk>
 <20200101030815.GA17593@ZenIV.linux.org.uk> <20200101144407.ugjwzk7zxrucaa6a@yavin.dot.cyphar.com>
 <20200101234009.GB8904@ZenIV.linux.org.uk> <20200102035920.dsycgxnb6ba2jhz2@yavin.dot.cyphar.com>
 <20200103014901.GC8904@ZenIV.linux.org.uk> <20200108031314.GE8904@ZenIV.linux.org.uk>
 <CAHk-=wgQ3yOBuK8mxpnntD8cfX-+10ba81f86BYg8MhvwpvOMg@mail.gmail.com> <20200108213444.GF8904@ZenIV.linux.org.uk>
In-Reply-To: <20200108213444.GF8904@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jan 2020 16:08:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiq11+thoe60qhsSHk_nbRF2TRL1Wnf6eHcYObjhJmsww@mail.gmail.com>
Message-ID: <CAHk-=wiq11+thoe60qhsSHk_nbRF2TRL1Wnf6eHcYObjhJmsww@mail.gmail.com>
Subject: Re: [PATCH RFC 0/1] mount: universally disallow mounting over symlinks
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        stable <stable@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 8, 2020 at 1:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The point is, we'd never followed mounts on /proc/self/cwd et.al.
> I hadn't checked 2.0, but 2.1.100 ('97, before any changes from me)
> is that way.

Hmm. If that's the case, maybe they should be marked implicitly as
O_PATH when opened?

> Actually, scratch that - 2.0 behaves the same way
> (mountpoint crossing is done in iget() there; is that Minix influence
> or straight from the Lions' book?)

I don't think I ever had access to Lions' - I've _seen_ a printout of
it later, and obviously maybe others did,

More likely it's from Maurice Bach: the Design of the Unix Operating
System. I'm pretty sure that's where a lot of the FS layer stuff came
from.  Certainly the bad old buffer head interfaces, and quite likely
the iget() stuff too.

> 0.10: forward traversal in iget(), back traversal in fs/namei.c:find_entry()

Whee, you _really_ went back in time.

So I did too.

And looking at that code in iget(), I doubt it came from anywhere.
Christ. It's just looping over a fixed-size array, both when finding
the inode, and finding the superblock.

Cute, but unbelievably stupid. It was a more innocent time.

In other words, I think you can chalk it up to just me, because
blaming anybody else for that garbage would be very very unfair indeed
;)

> How would your proposal deal with access("/proc/self/fd/42/foo", MAY_READ)
> vs. faccessat(42, "foo", MAY_READ)?

I think that in a perfect world, the O_PATH'ness of '42' would be the
deciding factor. Wouldn't those be the best and most consistent
semantics?

And then 'cwd'/'root' always have the O_PATH behavior.

> The latter would trigger automount,
> the former would not...  Or would you extend that to "traverse mounts
> upon following procfs links, if the file in question had been opened with
> O_PATH"?

Exactly.

But you know what? I do not believe this is all that important, and I
doubt it will matter to anybody.

So what matters most is what makes the most sense to the VFS layer,
and what makes the most sense to _you_.

Because my reaction from this thread is that not only have you thought
about this issue and followed the history a whole lot more than I
would ever have done, it's also that I trust you to DTRT.

I think it would be good to have some self-consistency, but at the
same time clearly we already don't really, and our behavior here has
subtly changed over the years (and not so subtly - if you go back
sufficiently far, /proc behavior wrt file descriptors has had both
"dup()" behavior and "make a new file descriptor with the same inode"
behavior, afaik).

               Linus
