Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34E241DC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgHKQFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 12:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgHKQFn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:05:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4D9C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 09:05:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id i10so14147781ljn.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM4jBsQMzRRDK/34QKUyfcJDWJhksJw26XHd2o7K/hw=;
        b=h5REYG6BLAhcl7YCtx2yrw4ToGBDJU4uXkvyEjPSm/S5Qgt/fykHaqSq3JywpXVzhk
         cx/W8MOJkg0ndiBLZgviuz2vr1RU763vUQcJdmRoZ6xko8AzSyxIh/lsVnNs/b3a8lQl
         8o4utRdytVjQvpDmIMQfxUgnL+ljmt3Z+u/5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM4jBsQMzRRDK/34QKUyfcJDWJhksJw26XHd2o7K/hw=;
        b=gi2CcOAnyr3OB1FcWMVxQMOC6PrCKfh03Qq8rAkhF7RvVVvcAuh3k1iLKrMCq1ZtTu
         JU9kmxETcEIHupHD/zFlylhTmpkeCsfEyZQyOej0EgivL4x+5C7EJuvjl8aHKbIxuPtQ
         vlKINLoIpacox9xkwX4/aQy4Ec4mF8wi7iVIciOdF6X9TM6j55xhpelg/KDxAVxESsNT
         2+glJcaKdY/J4TCrpASZWAMC0ZQWFRD7nYSYulmJcsIrD7S3scjENPKEkI8ovBo7gZX2
         DAgFx9AWv7cs42KfVT1jqi/c60YSUPYEiDN/HxHyYAYgw0yaj2VoskYO6IpQQjoDnRNW
         idSw==
X-Gm-Message-State: AOAM533Tq5OuqkCu5c/RbwRrC6litzI+dxdqwduxqCMXNXGkit4VQtNC
        qbWh+5QJTV4U2pBpUSb+GJwlIcrPuo0=
X-Google-Smtp-Source: ABdhPJwaA/Q4+hgDY1gsBbMjZTJNYObPaVlZqCUA6AN3qgbkxFw8azEwEF3bW001zQjiBFE6yxpZBw==
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr3409328lji.47.1597161940563;
        Tue, 11 Aug 2020 09:05:40 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a2sm10160591ljj.40.2020.08.11.09.05.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:05:39 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id i10so14147574ljn.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 09:05:38 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr3184107lju.102.1597161938384;
 Tue, 11 Aug 2020 09:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com>
In-Reply-To: <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 09:05:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
Message-ID: <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Aug 11, 2020 at 8:30 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> What's the disadvantage of doing it with a single lookup WITH an enabling flag?
>
> It's definitely not going to break anything, so no backward
> compatibility issues whatsoever.

No backwards compatibility issues for existing programs, no.

But your suggestion is fundamentally ambiguous, and you most
definitely *can* hit that if people start using this in new programs.

Where does that "unified" pathname come from? It will be generated
from "base filename + metadata name" in user space, and

 (a) the base filename might have double or triple slashes in it for
whatever reasons.

This is not some "made-up gotcha" thing - I see double slashes *all*
the time when we have things like Makefiles doing

    srctree=../../src/

and then people do "$(srctree)/". If you haven't seen that kind of
pattern where the pathname has two (or sometimes more!) slashes in the
middle, you've led a very sheltered life.

 (b) even if the new user space were to think about that, and remove
those (hah! when have you ever seen user space do that?), as Al
mentioned, the user *filesystem* might have pathnames with double
slashes as part of symlinks.

So now we'd have to make sure that when we traverse symlinks, that
O_ALT gets cleared. Which means that it's not a unified namespace
after all, because you can't make symlinks point to metadata.

Or we'd retroactively change the semantics of a symlink, and that _is_
a backwards compatibility issue. Not with old software, no, but it
changes the meaning of old symlinks!

So no, I don't think a unified namespace ends up working.

And I say that as somebody who actually loves the concept. Ask Al: I
have a few times pushed for "let's allow directory behavior on regular
files", so that you could do things like a tar-filesystem, and access
the contents of a tar-file by just doing

    cat my-file.tar/inside/the/archive.c

or similar.

Al has convinced me it's a horrible idea (and there you have a
non-ambiguous marker: the slash at the end of a pathname that
otherwise looks and acts as a non-directory)

               Linus
