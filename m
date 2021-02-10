Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30773171AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 21:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhBJUuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 15:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhBJUuN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:50:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C827C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 12:49:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g10so4669298eds.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 12:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFCBVLmx4m3P8OJ7FexI4xTU+D+dqeOPB5L3zdP1j98=;
        b=OlXMEGE3+YXDW20u82up+ZZJxFuT5KQPVaOZp56fIviL/ca54YrjE5bQPiM0jLbtr5
         JephDlBWc6ihBoJg5k8R1M7+hSbeoGkpREvy/8A8Bsg5/X4GhbjclPWfb060aUds7Xkf
         2bFaMcZ2LOg9RoALDj7udW/xyJ4i9lrqIzZcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFCBVLmx4m3P8OJ7FexI4xTU+D+dqeOPB5L3zdP1j98=;
        b=VJx7a/5F62MDIUdI3Xp4B+nEo9l2/cTwhpu8vNOOH2bTcmLOnwJ31OVeXDrTZCaxB5
         GP+Q6RAU5FPFdKS4E3zjAwVWFrsK5/P4vJsN0gO4FxpYx8et59X/oYoDsI7kH76WDDIO
         05RhMxYkNoBrWEBd0yfL+CoWN9M3YK+ne1FqTk0pWo7VAIPIKR3xqCXvWImSLvQZ3hD8
         UiZN+kyrgEv2SFneokTQHwsr8ndvdaqegGcL3XlsVkw/lBivlRXBduHIpfhXBGNNoJ1U
         0kKAIn6R1/yAnjmkxgOGPHncAL8XEIaDwcz3/+h0jlXYssXGSFL4kWYcMohaT/0w9C4Q
         LZ1A==
X-Gm-Message-State: AOAM531hiWzIT4313udQnJLs0g8Kw/h/rPe2k9VH1ZO18EORL4BWX9yU
        AcNx0XNeMbPAt7SxW9dUwx/ipYVStgIV9Q==
X-Google-Smtp-Source: ABdhPJw/rvDrKnqGk5o5o6e7depTgOz0ECctyvaU2P4WpKQdZDb73Wjlnj5a43tiNOvKE50f3AVt1w==
X-Received: by 2002:a05:6402:4252:: with SMTP id g18mr5047907edb.231.1612990171486;
        Wed, 10 Feb 2021 12:49:31 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id b2sm2001081edk.11.2021.02.10.12.49.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 12:49:31 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id l25so6557063eja.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 12:49:31 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr2551518lfu.253.1612989815438;
 Wed, 10 Feb 2021 12:43:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
 <591237.1612886997@warthog.procyon.org.uk> <1330473.1612974547@warthog.procyon.org.uk>
 <1330751.1612974783@warthog.procyon.org.uk>
In-Reply-To: <1330751.1612974783@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Feb 2021 12:43:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com>
Message-ID: <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 8:33 AM David Howells <dhowells@redhat.com> wrote:
>
> Then I could follow it up with this patch here, moving towards dropping the
> PG_fscache alias for the new API.

So I don't mind the alias per se, but I did mind the odd mixing of
names for the same thing.

So I think your change to make it be named "wait_on_page_private_2()"
fixed that mixing, but I also think that it's probably then a good
idea to have aliases in place for filesystems that actually include
the fscache.h header.

Put another way: I think that it would be even better to simply just
have a function like

   static inline void wait_on_page_fscache(struct page *page)
   {
        if (PagePrivate2(page))
                wait_on_page_bit(page, PG_private_2);
  }

and make that be *not* in <linux/pagemap.h>, but simply be in
<linux/fscache.h> under that big comment about how PG_private_2 is
used for the fscache bit. You already have that comment, putting the
above kind of helper function right there would very much explain why
a "wait for fscache bit" function then uses the PagePrivate2 function
to test the bit. Agreed?

Alternatively, since that header file already has

    #define PageFsCache(page)               PagePrivate2((page))

you could also just write the above as

   static inline void wait_on_page_fscache(struct page *page)
   {
        if (PageFsCache(page))
                wait_on_page_bit(page, PG_fscache);
  }

and now it is even more obvious. And there's no odd mixing of
"fscache" and "private_2", it's all consistent.

IOW, I'm not against "wait_on_page_fscache()" as a function, but I
*am* against the odd _mixing_ of things without a big explanation,
where the code itself looks very odd and questionable.

And I think the "fscache" waiting functions should not be visible to
any core VM or filesystem code - it should be limited explicitly to
those filesystems that use fscache, and include that header file.

Wouldn't that make sense?

Also, honestly, I really *REALLY* want your commit messages to talk
about who has been cc'd, who has been part of development, and point
to the PUBLIC MAILING LISTS WHERE THAT DISCUSSION WAS TAKING PLACE, so
that I can actually see that "yes, other people were involved"

No, I don't require this in general, but exactly because of the
history we have, I really really want to see that. I want to see a

   Link: https://lore.kernel.org/r/....

and the Cc's - or better yet, the Reviewed-by's etc - so that when I
get a pull request, it really is very obvious to me when I look at it
that others really have been involved.

So if I continue to see just

    Signed-off-by: David Howells <dhowells@redhat.com>

at the end of the commit messages, I will not pull.

Yes, in this thread a couple of people have piped up and said that
they were part of the discussion and that they are interested, but if
I have to start asking around just to see that, then it's too little,
too late.

No more of this "it looks like David Howells did things in private". I
want links I can follow to see the discussion, and I really want to
see that others really have been involved.

Ok?

                  Linus
