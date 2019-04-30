Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E69B1023C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 00:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfD3WKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 18:10:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45580 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3WKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:10:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so11906598lfl.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11uSpDxtH6dG0q9YKWxI5cXz2fwFpfDX0CVXmGVsMic=;
        b=fy9h/5M/mkY5w34D4xiAGxIH43aqHphBmI8w0s6flqgR4Hbr36nNBh3rsGmKfX/aXD
         N7LgS5vwvaHwmc1WGLLAVoYzn0RqyqisCP1nWSRR0lGqmUr8q7E0odOhfoQmdYIVRkkL
         O90kt81jswX2hgTL7v6uYTrIt+rJt7NzIb/5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11uSpDxtH6dG0q9YKWxI5cXz2fwFpfDX0CVXmGVsMic=;
        b=AyvXAb0viab4MBNLGt7YLSyonpKqr8zeqWIz8wSd1r+UQA2nBvUzDLsajzTcqewiWr
         Z1f8szlGK58rfXCu4GlaqOTJtGUvrDqKhWepBW55OjcaQ/jjjChHomwT8B5gd3WQyfox
         M/63mCni6FVPo2xhDXAlYgwIw5RwTOeEBDWMKbY3LQcDIEec+ntXx0vBtoVinpYWkWbC
         giYE6c+E7KL0bNd/yz7O/CbL+Sd7xCEi7mGWn0ySziD0wI/kLPDBbIQwsAXzQBOEPPe8
         Gg+Ff7DL0fPRmQKZaaAWc7X6bsVjgwK/29f2GLJ3t7K/tJo5nNTiO0QuD8jZv2BnFXcU
         F54g==
X-Gm-Message-State: APjAAAUosVvB9/w7t/+cJHppAKJ+I+K0NL4pohhnDTYA5mGGACgzz0Wo
        q4IPZNuQ+BhYIRetlV7lz7ZfQAC9mGw=
X-Google-Smtp-Source: APXvYqyIfmgZ7E/DgDZaGWYoNfh4+2+26UoLfw6ZuPzrJ2jTSyWgh0r2y5dD78iWTzAj7oqOLr2jdQ==
X-Received: by 2002:a19:f24c:: with SMTP id d12mr37033585lfk.163.1556662247710;
        Tue, 30 Apr 2019 15:10:47 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 192sm7973384lfh.14.2019.04.30.15.10.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:10:46 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id d12so12027836lfk.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 15:10:46 -0700 (PDT)
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr7178490lfl.67.1556662246250;
 Tue, 30 Apr 2019 15:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190430214149.GA482@quack2.suse.cz>
In-Reply-To: <20190430214149.GA482@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Apr 2019 15:10:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgn8iEOsT0wwHu4RoZSODb7bRAq5bS59wgZttHbn4gZrg@mail.gmail.com>
Message-ID: <CAHk-=wgn8iEOsT0wwHu4RoZSODb7bRAq5bS59wgZttHbn4gZrg@mail.gmail.com>
Subject: Re: [GIT PULL] fsnotify fix for v5.1-rc8
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 2:41 PM Jan Kara <jack@suse.cz> wrote:
>
> to get a fix of user trigerable NULL pointer dereference syzbot has
> recently spotted. The problem has been introduced in rc1 so no CC stable is
> needed.

Hmm. Pulled, but I thin kthe use of READ_ONCE/WRITE_ONCE is suspicious.

If we're reading a pointer like this locklessly, the proper sequence
is almost always something like "smp_store_release()" to write the
pointer, and "smp_load_acquire()" to read it.

Because that not only does the "access once" semantics, but it also
guarantees that when we actually look _through_ the pointer, we see
the data that was written to it. In contrast, code like this (from the
fix)

+       WRITE_ONCE(mark->connector, conn);

   ...

+               conn = READ_ONCE(iter_info->marks[type]->connector);
+               /* Mark is just getting destroyed or created? */
+               if (!conn)
+                       continue;
+               fsid = conn->fsid;

is rather suspicious, because there's no obvious guarantee that tjhe
"conn->fsid" part was written on one CPU before we read it on another.

There may well be barriers in place there that end up guaranteeing it
in practice, but I wanted to point out that the READ/WRITE_ONCE()
pattern tends to be a bit dodgy unless you have some other explicit
synchronization (and if that synchronization is a lock, then you
obviously shouldn't be using READ/WRITE_ONCE() at all).

                 Linus
