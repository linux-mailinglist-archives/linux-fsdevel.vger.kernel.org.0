Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE63D2E1A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfE2Pxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 11:53:34 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38398 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2Pxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 11:53:34 -0400
Received: by mail-yb1-f194.google.com with SMTP id x7so974818ybg.5;
        Wed, 29 May 2019 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9aGSUCLgs+CCQtCy+mSQIYSrSfa7rRjanT2W47J6sk=;
        b=W0b/OulLZHLFV0o5VHh2eX0OO5W2c6ozuOk/exQ/evdjbqKfAvYKVt7nTJGaelABjS
         dT23v19RZz/oCSnKBJWW90dsJ+LYjXH/I6f0xdCp7Ns9P2zRQEgKzIB7oPFIKES6dLL0
         1S2hquEItW4s9OBDLayQAbeYb/4FSVufl5UVpaPEQIW/PmeFS34MEP46KP8ZHlnFiBsw
         K0tMAyJSTUEs8HMZj3oPQHBACECBiHtM8MLlqU72ovwQu7RRpglK7KESRZJnCOJUlr/Z
         aFZI1mL6fEFOS/JQjVycB9xbHwMUe2+s8qeSxZ+RSO0UZ0YTVQ+WuM01aDm6k1H+a88w
         ujGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9aGSUCLgs+CCQtCy+mSQIYSrSfa7rRjanT2W47J6sk=;
        b=bF6AyhDT1RzgZWdEyQ24AWdFWnzzLKctT6+dHMWZuQY0R8oFpm0SHa2tQDYBbm3gaW
         JHiOF7mQay1GPzpPAKQzHZt091wd9UOE3JO3jvWN58cm/0sySG3V9SSmv8DJZI+Q+1wx
         BShkwU+io+bSf1dimJSVbZ0fih5j118AhZr2h2sHa2vyuAQKOfuAnCUPsTyOrR6HnuwK
         qtC0L8obobpcYGPEbFrhfipu8zf3fxjscATTALfNFVV/2KdJS0MUFVpP2a9F+Be0VjAe
         9h7BZFRD+zuYLqXxkbGZKyDl9DWpamqHPNaUzTgc01VguXoIqPJTGBenGi7iwFA7Wp4y
         Ijnw==
X-Gm-Message-State: APjAAAW3hxNmdD3JJrQzi8vTMVCCIq+LPSXfl3Q84FuvW2pDcQBOEhdP
        OJJiCdb8ZwRg4EuT6DXVfkid8G3gQjxvSAxxe0w=
X-Google-Smtp-Source: APXvYqyuiZhLx3GUMFzgw2IYz0TSRIybXZHfA9Jg5KdebmCQMJWjl9o9t2ZQPuZZp6OanotPLkBniUcUeRijLC1e6Ps=
X-Received: by 2002:a25:b202:: with SMTP id i2mr26173195ybj.439.1559145212823;
 Wed, 29 May 2019 08:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <CAOQ4uxjC1M7jwjd9zSaSa6UW2dbEjc+ZbFSo7j9F1YHAQxQ8LQ@mail.gmail.com> <20190529142504.GC32147@quack2.suse.cz>
In-Reply-To: <20190529142504.GC32147@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 18:53:21 +0300
Message-ID: <CAOQ4uxjLzURf8c1UH_xCJKkuD2es8i-=P-ZNM=t3aFcZLMwXEg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications
To:     Jan Kara <jack@suse.cz>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > David,
> >
> > I am interested to know how you envision filesystem notifications would
> > look with this interface.
> >
> > fanotify can certainly benefit from providing a ring buffer interface to read
> > events.
> >
> > From what I have seen, a common practice of users is to monitor mounts
> > (somehow) and place FAN_MARK_MOUNT fanotify watches dynamically.
> > It'd be good if those users can use a single watch mechanism/API for
> > watching the mount namespace and filesystem events within mounts.
> >
> > A similar usability concern is with sb_notify and FAN_MARK_FILESYSTEM.
> > It provides users with two complete different mechanisms to watch error
> > and filesystem events. That is generally not a good thing to have.
> >
> > I am not asking that you implement fs_notify() before merging sb_notify()
> > and I understand that you have a use case for sb_notify().
> > I am asking that you show me the path towards a unified API (how a
> > typical program would look like), so that we know before merging your
> > new API that it could be extended to accommodate fsnotify events
> > where the final result will look wholesome to users.
>
> Are you sure we want to combine notification about file changes etc. with
> administrator-type notifications about the filesystem? To me these two
> sound like rather different (although sometimes related) things.
>

Well I am sure that ring buffer for fanotify events would be useful, so
seeing that David is proposing a generic notification mechanism, I wanted
to know how that mechanism could best share infrastructure with fsnotify.

But apart from that I foresee the questions from users about why the
mount notification API and filesystem events API do not have better
integration.

The way I see it, the notification queue can serve several classes
of notifications and fsnotify could be one of those classes
(at least FAN_CLASS_NOTIF fits nicely to the model).

Thanks,
Amir.
