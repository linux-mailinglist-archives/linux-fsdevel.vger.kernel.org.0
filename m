Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C486D247A9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgHQWo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgHQWoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:44:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087EDC061389
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 15:44:50 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x24so9177858lfe.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4oCLwSFAMfX0jUk1zRXnY7OWQRSXzVnX6hrYGZa4vs=;
        b=Ot97LDuE1VQD/tFXQHGZ9kal3BL+Bs8jJUmcjt3HaQFhxwhsmdVZmU7bqaxx6SHCOi
         Am2J3ry3DoqYNnlkX0YdsYu0rNFw9zoYcgEwV5ZpYnntndFXmS3jFlz+g59jSMMLNjLs
         FbV6xSzh8EqoGh9CvhAN6frNL/9IP9BgJF/YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4oCLwSFAMfX0jUk1zRXnY7OWQRSXzVnX6hrYGZa4vs=;
        b=NTCXXc1XUqxAsgjl1w7kD7zftW88kWvoP9+mlPIHV3Lbv+We7gbuFfzDfZDubOZnm0
         v+vjAmlx3ifwVCpUnPLlSP44AotkRC+ayG1JCFzfhmurUiR7wbBhqaL/ZnNoO0O6q3kA
         kXd58CowoHT87JuG15VEnOr2TvT5Y7YEi0r1vaCjjMeUYz8ow0p7sMp2KKIGNz237I8E
         oazz8GuqBPhNK+MQqlqqUYYIYUysTJh+9wZJRe6S3/V1bbmWb7yvaST/jw6vwWQ78JZZ
         wElqwiDc3gTOf2SfKO0Xn3qxlIKiMg8gq6IbH33E4RkWFIWSE5vgMLl7hjkjP5ZnPUiY
         Co0Q==
X-Gm-Message-State: AOAM532tZaLYCLNmR4b4h5viTU+s6L2JX+LxpNGxGXU4H87pKOL9P/jB
        Wy14TteLIaEKU/SGFdKRwhY6Zcr7Zo72Xw==
X-Google-Smtp-Source: ABdhPJyNGZhJmbCWvEYE3VtrH6RMMyL/inDUsJAt+LeTvBnVzrkoaIHCRjMLo/8pi/IoI+YXn63rMw==
X-Received: by 2002:a05:6512:3156:: with SMTP id s22mr8471918lfi.140.1597704287651;
        Mon, 17 Aug 2020 15:44:47 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y16sm5346862ljg.21.2020.08.17.15.44.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 15:44:46 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id t6so19248198ljk.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 15:44:45 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr8046290lju.102.1597704285617;
 Mon, 17 Aug 2020 15:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com> <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
 <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com> <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
In-Reply-To: <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 15:44:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
Message-ID: <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:15 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So it has this very complex "random structures of random things"
> implementation. It's a huge sign of over-design and "I don't know what
> the hell I want to expose, so I'll make this generic thing that can
> expose anything, and then I start adding random fields".

You can see the overdesign in other places too: that "time
granularity" is some very odd stuff. It doesn't actually even match
the kernel granularity rules, so that fsinfo interface is basically
exporting random crap that doesn't match reality.

In the kernel, we give the granularity in nsec, but for some reason
that fsinfo stuff gives it in some hand-written pseudo-floating-point
format. Why? Don't ask me.

And do we really want to have that whole odd Nth/Mth thing?
Considering that it cannot be consistent or atomic, and the complaint
against the /proc interfaces have been about that part, it really
smells completely bogus.

So please. Can we just make a simple extended statfs() and be done
with it, instead of this hugely complex thing that does five different
things with the same interface and makes it really odd as a result?

                  Linus
So honestly,  there's a
