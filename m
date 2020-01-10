Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39817136666
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 06:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgAJFDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 00:03:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32989 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgAJFDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 00:03:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so778978lji.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 21:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/GI7mSLrO7+AWyztv1F/7+LjmBRdi9pxniW8srHraM=;
        b=WJnSkgb5IoN+QFM9zDo/+1LUciNYCKC1uNr4+jda+SHQ4Al4kAzM40Ki7rykrkdSQb
         LRo6BkP+xKhXKun/nrSizTl2SLNY7SO9HFhXKlKAOnq3AXpHt/oUN004/3so/HMeBcSV
         czfR5SnYRegkSqQWTz+TDMXgEHM9RAu7JIN+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/GI7mSLrO7+AWyztv1F/7+LjmBRdi9pxniW8srHraM=;
        b=tyL64tHivqES1ePowskwpShZXUn2/SmxI4J2SY6wn3Lbta8NBpv8rbue48BuHE9mir
         OB/JYSwg8M96GLd7f8cC4zXkb+PvfAlpxcQrfctNAR/l/An5kHUBiKxV+2mnUJ1pPbTZ
         AJeaYVW8U8WOIoXExG4x9SO48zEntJcLuMp81qkqxSD7NyxSGbG1TW2QJWAfRUf/2cex
         O26ZUza8OJBO5uciE1fSqrIeUTA+/rhvx6MtRT9y/SsRTS1VKvKdF8ePiAzb0qOJ1CQ5
         gl7XAgfab1+QbtsTfF6tDA9KCmZ05mcDQAmEeySL3nx0dUOPLHBvqrmO6fnKxGe9Bl4s
         f6tQ==
X-Gm-Message-State: APjAAAW4bwr7WcKUfBJgPx2kyiJBv0LUtQXchSpBszBwCFGMCj0zO5Dg
        KmhVHd7Xa9WYzalXg0VGLAqbEps8Bb4=
X-Google-Smtp-Source: APXvYqye93StbOzKRljEkHRPhXgEHCNhXPuPw7CR6i2TxV/DzuMIbZFRE5KXzKCeBn6IyGq9nUOejQ==
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr1201432ljk.228.1578632599354;
        Thu, 09 Jan 2020 21:03:19 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id j204sm365841lfj.38.2020.01.09.21.03.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 21:03:18 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id i23so467556lfo.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 21:03:17 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr961529lfp.106.1578632597317;
 Thu, 09 Jan 2020 21:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20200101005446.GH4203@ZenIV.linux.org.uk> <20200101030815.GA17593@ZenIV.linux.org.uk>
 <20200101144407.ugjwzk7zxrucaa6a@yavin.dot.cyphar.com> <20200101234009.GB8904@ZenIV.linux.org.uk>
 <20200102035920.dsycgxnb6ba2jhz2@yavin.dot.cyphar.com> <20200103014901.GC8904@ZenIV.linux.org.uk>
 <20200108031314.GE8904@ZenIV.linux.org.uk> <CAHk-=wgQ3yOBuK8mxpnntD8cfX-+10ba81f86BYg8MhvwpvOMg@mail.gmail.com>
 <20200108213444.GF8904@ZenIV.linux.org.uk> <CAHk-=wiq11+thoe60qhsSHk_nbRF2TRL1Wnf6eHcYObjhJmsww@mail.gmail.com>
 <20200110041523.GK8904@ZenIV.linux.org.uk>
In-Reply-To: <20200110041523.GK8904@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jan 2020 21:03:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF6en6WD7JdYAUxHnzeTgs3P08ysDQPv4504hQ2qUcmA@mail.gmail.com>
Message-ID: <CAHk-=wiF6en6WD7JdYAUxHnzeTgs3P08ysDQPv4504hQ2qUcmA@mail.gmail.com>
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

On Thu, Jan 9, 2020 at 8:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Hmm. If that's the case, maybe they should be marked implicitly as
> > O_PATH when opened?
>
> I thought you wanted O_PATH as starting point to have mounts traversed?
> Confused...

No, I'm confused.  I meant "non-O_PATH", just got the rules reversed in my mind.

So cwd/root would always act as it non-O_PATH, and only using an
actual fd would look at the O_PATH flag, and if it was set would walk
the mountpoints.

> <grabs Bach> Right, he simply transcribes v7 iget().
>
> So I suspect that you are right - your variant of iget was pretty much
> one-to-one implementation of Bach's description of v7 iget.

Ok, that makes sense. My copy of Bach literally had the system call
list "marked off" when I implemented them back when.

I may still have that paperbook copy somewhere. I don't _think_ I'd
have thrown it out, it has sentimental value.

> > I think that in a perfect world, the O_PATH'ness of '42' would be the
> > deciding factor. Wouldn't those be the best and most consistent
> > semantics?
> >
> > And then 'cwd'/'root' always have the O_PATH behavior.
>
> See above - unless I'm misparsing you, you wanted mount traversals in the
> starting point if it's ...at() with O_PATH fd.

.. and see above, it was just my confusion about the sense of O_PATH.

> For cwd and root the situation is opposite - we do NOT traverse mounts
> for those.  And that's really too late to change.

Oh, absolutely.

[ snip some more about your automount digging. Looks about right, but
I'm not going to make a peep after getting O_PATH reversed ;) ]

            Linus
